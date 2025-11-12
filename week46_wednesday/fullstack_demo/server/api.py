import os
import json
import base64
from dotenv import load_dotenv
from flask import Flask, jsonify, request
from flask_mysqldb import MySQL
from flask_cors import CORS
import MySQLdb.cursors

# ny Flask-app
app = Flask(__name__)

# våra miljövariabler
load_dotenv()

# vår conf från .env
app.config['MYSQL_HOST'] = os.getenv('DB_HOST')
app.config['MYSQL_USER'] = os.getenv('DB_USER')
app.config['MYSQL_PASSWORD'] = os.getenv('DB_PASSWORD')
app.config['MYSQL_DB'] = os.getenv('DB_NAME')

# CORS
CORS(app)

# mysql conf
mysql = MySQL(app)

# hjälpfunktion för att ladda in docs
def load_api_docs():
    with open(os.path.join(app.root_path, 'api_docs.json')) as f:
        return json.load(f)
    
# API endpoint to view API docs
@app.route('/', methods=['GET'])
def get_root():
    api_docs = load_api_docs() # kalla på hjälpfunktion
    return jsonify(api_docs)

# API endpoint to fetch all products
@app.route('/products', methods=['GET'])
def get_products():
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM product")
    products = cursor.fetchall()
    return jsonify(products)

# API endpoint to fetch product by product_id
@app.route('/products/<int:product_id>', methods=['GET'])
def get_product(product_id):
    cursor = mysql.connection.cursor(MySQLdb.cursors.DictCursor)
    cursor.execute("SELECT * FROM product WHERE product_id = %s", (product_id,))
    product = cursor.fetchone()
    if product:
        return jsonify(product)
    else:
        return jsonify({'error': 'product not found'}), 404 # not found
    
# API endpoint to add a new product
@app.route('/products', methods=['POST'])
def add_product():
    data = request.json
    product_name = data.get('product_name')
    supplier_id = data.get('supplier_id')
    category_id = data.get('category_id')
    quantity_per_unit = data.get('quantity_per_unit')
    unit_price = data.get('unit_price')
    unit_in_stock = data.get('unit_in_stock')

    cursor = mysql.connection.cursor()
    cursor.execute("""
            INSERT INTO product (product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock)
            VALUES (%s, %s, %s, %s, %s, %s)
        """, (product_name, supplier_id, category_id, quantity_per_unit, unit_price, unit_in_stock))
    mysql.connection.commit()
    return jsonify({'message': 'Product added succesfully'}), 201 # created

# kör Flask-appen om filen startas direkt (inte om den importeras som modul)
# debug=True ger oss auto restart + felutskrift(er)
if __name__ == '__main__':
    app.run(debug=True)