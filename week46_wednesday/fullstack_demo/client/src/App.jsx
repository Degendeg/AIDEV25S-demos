import { useEffect, useState } from "react";

const App = () => {
  const [products, setProducts] = useState([]);
  const [formData, setFormData] = useState({
    product_name: "",
    supplier_id: "",
    category_id: "",
    quantity_per_unit: "",
    unit_price: "",
    unit_in_stock: "",
  });
  const [msg, setMsg] = useState("");

  // Ladda produkter
  const loadProducts = async () => {
    try {
      const res = await fetch(import.meta.env.VITE_API_URL + '/products');
      const data = await res.json();
      setProducts(data);
    } catch (err) {
      console.error(err);
      setMsg("❌ Fel vid hämtning av produkter.");
    }
  };

  // Hantera formulärändringar
  const handleChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  // Kontrollera att alla required-fält är ifyllda
  const allFilled =
    formData.product_name.trim() &&
    formData.supplier_id.trim() &&
    formData.category_id.trim();

  // Lägg till produkt
  const handleSubmit = async (e) => {
    e.preventDefault();
    try {
      const res = await fetch(import.meta.env.VITE_API_URL + '/products', {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify(formData),
      });

      if (res.ok) {
        setMsg("✅ Produkt tillagd!");
        setFormData({
          product_name: "",
          supplier_id: "",
          category_id: "",
          quantity_per_unit: "",
          unit_price: "",
          unit_in_stock: "",
        });
        loadProducts();
      } else {
        const data = await res.json();
        setMsg("❌ Fel: " + (data.error || "Kunde inte lägga till"));
      }
    } catch (err) {
      console.error(err);
      setMsg("❌ Något gick fel.");
    }
  };

  // Ta bort produkt
  const handleDelete = async (productId, productName) => {
    if (confirm(`Är du säker på att du vill ta bort ${productName}?`)) {
      try {
        const res = await fetch(`${import.meta.env.VITE_API_URL + '/products/' + productId}`, {
          method: "DELETE",
          headers: {
            "Content-Type": "application/json",
          },
        });

        if (res.ok) {
          setMsg("✅ Produkt borttagen!");
          loadProducts();
        } else {
          const data = await res.json();
          setMsg("❌ Fel: " + (data.error || "Kunde inte ta bort"));
        }
      } catch (err) {
        console.error(err);
        setMsg("❌ Något gick fel.");
      }
    }
  };

  useEffect(() => {
    loadProducts();
  }, []);

  return (
    <div className="max-w-6xl mx-auto mt-10 mb-10 flex flex-col md:flex-row gap-6">
      {/* Produktlista */}
      <div className="max-h-[80vh] flex-1 bg-white p-6 rounded-2xl shadow-lg scrollbar-hide overflow-y-auto">
        <h1 className="text-2xl font-bold mb-6 text-center">🛍️ Produktlista</h1>
        <div className="grid gap-4 sm:grid-cols-2">
          {products.length === 0 ? (
            <p className="text-center text-gray-500">
              Inga produkter hittades.
            </p>
          ) : (
            products.map((p) => (
              <div
                key={p.product_id}
                className="relative p-4 bg-gray-50 rounded-lg border hover:shadow-md transition"
              >
                <button
                  onClick={() => handleDelete(p.product_id, p.product_name)}
                  className="absolute bottom-2 right-2 pb-1 bg-red-600 text-white rounded-full w-4 h-4 flex items-center justify-center hover:bg-red-700"
                >
                  &times;
                </button>

                <h2 className="font-semibold text-lg mb-1">{p.product_name}</h2>
                <p className="text-sm text-gray-600">
                  Pris: {parseInt(p.unit_price).toFixed(2) ?? "-"} kr
                </p>
                <p className="text-sm text-gray-600">
                  Antal i lager: {p.unit_in_stock ?? "-"}
                </p>
              </div>
            ))
          )}
        </div>
      </div>

      {/* Lägg till produkt */}
      <div className="w-full h-fit md:w-1/3 bg-white p-6 rounded-xl shadow">
        <h2 className="text-xl font-semibold mb-4">➕ Lägg till produkt</h2>
        <form onSubmit={handleSubmit} className="grid gap-3">
          <input
            type="text"
            name="product_name"
            placeholder="Produktnamn"
            value={formData.product_name}
            onChange={handleChange}
            className="border rounded p-2"
            required
          />
          <input
            type="number"
            name="supplier_id"
            placeholder="Leverantör ID"
            value={formData.supplier_id}
            onChange={handleChange}
            className="border rounded p-2"
            required
          />
          <input
            type="number"
            name="category_id"
            placeholder="Kategori ID"
            value={formData.category_id}
            onChange={handleChange}
            className="border rounded p-2"
            required
          />
          <input
            type="text"
            name="quantity_per_unit"
            placeholder="Antal per enhet"
            value={formData.quantity_per_unit}
            onChange={handleChange}
            className="border rounded p-2"
          />
          <input
            type="number"
            name="unit_price"
            placeholder="Pris"
            value={formData.unit_price}
            onChange={handleChange}
            className="border rounded p-2"
          />
          <input
            type="number"
            name="unit_in_stock"
            placeholder="Antal i lager"
            value={formData.unit_in_stock}
            onChange={handleChange}
            className="border rounded p-2"
          />
          <button
            type="submit"
            disabled={!allFilled}
            className="bg-blue-600 text-white px-4 py-2 rounded hover:bg-blue-700 disabled:opacity-50 disabled:cursor-not-allowed"
          >
            Spara produkt
          </button>
        </form>
        <p className="text-sm mt-3">{msg}</p>
      </div>
    </div>
  );
}

export default App