import '../models/cart_item.dart';
import '../models/product.dart';
import '../models/shopping_frame.dart';
import '../models/merchant.dart';

// Define reusable Merchant constants
const saksMerchant = Merchant(
  name: "Saks Fifth Avenue",
  url: "https://www.saksfifthavenue.com/",
  // Using the direct SVG link for better rendering
  logoUrl: "https://upload.wikimedia.org/wikipedia/commons/3/3b/Saks_Fifth_Avenue_Logo_Vertical_2007.svg",
);

const netAPorterMerchant = Merchant(
  name: "NET-A-PORTER",
  url: "https://www.net-a-porter.com/",
  // Placeholder - find a real SVG/PNG logo URL if needed
  logoUrl: "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Net-a-porter_logo.svg/1280px-Net-a-porter_logo.svg.png",
);

// Define the list of shopping frames with mock product data
final List<ShoppingFrame> mockShoppingFrames = [
  // --- Frame 1: Trending ---
  ShoppingFrame(
    id: "trending",
    title: "Trending for You",
    products: [
      Product(id: "1", brand: "Prada", price: 2200.00, itemName:"Re-Nylon Bomber Jacket", imageUrl: "https://media.saksfifthavenue.com/is/image/saks/0400018077761_BLACK?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0", merchant: saksMerchant), // Updated example URL
      Product(id: "2", brand: "Abercrombie", price: 41.00, itemName:"Essential Tee", imageUrl: "https://img.abercrombie.com/is/image/anf/KIC_155-1090-0123-900_prod1?policy=product-large"), // Example updated URL
      Product(id: "3", brand: "Jacquemus", price: 419.00, itemName:"Le Chiquito Bag", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/3666890009358_WHITE?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0", merchant: saksMerchant), // Updated example URL
      Product(id: "4", brand: "Nanushka", price: 875.00, itemName:"Hide Vegan Leather Jacket", imageUrl: "https://cdn.modesens.com/availability/70087723?w=400&height=600&quality=90"), // Example updated URL
      Product(id: "5", brand: "Zimmerman", price: 1100.00, itemName:"Postcard Floral Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/9352185643800_IVORYFLORAL?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated example URL
      Product(id: "6", brand: "Aje", price: 400.00, itemName:"Mimosa Cutout Midi Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/9356401068316_DAISYYELLOW?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated example URL
      Product(id: "7", brand: "Gucci", price: 2700.00, itemName:"GG Marmont Bag", imageUrl: "https://media.gucci.com/style/DarkGray_Center_0_0_800x800/1680537622/443497_DTDIT_1000_001_083_0000_Light-GG-Marmont-small-matelasse-shoulder-bag.jpg", merchant: saksMerchant), // Updated example URL
      Product(id: "8", brand: "Reformation", price: 218.00, itemName:"Juliette Dress", imageUrl: "https://www.thereformation.com/dw/image/v2/BBZQ_PRD/on/demandware.static/-/Sites-ref-master-catalog/default/dw1f479158/images/1304957POM/1304957POM_1.jpg?sw=870&sh=1160"), // Updated example URL
      Product(id: "9", brand: "Ganni", price: 213.00, itemName:"Software Isoli Sweatshirt", imageUrl: "https://images.us.ganni.com/dw/image/v2/AAWT_PRD/on/demandware.static/-/Sites-ganni-master-catalogue/default/dw3dd44636/images/images/packshot/T3171_099_1.jpg?sh=813&sm=fit&q=85"), // Updated example URL
      Product(id: "10", brand: "Isabel Marant", price: 450.00, itemName:"Étoile Sweatshirt", imageUrl: "https://us.isabelmarant.com/cdn/shop/files/23PSW0001FA-A1M07E-23EC-R.jpg?v=1723190042&width=700"),
      Product(id: "11", brand: "Cult Gaia", price: 458.00, itemName:"Serita Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/194080020386_OFFWHITE?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated example URL
      Product(id: "12", brand: "Celine", price: 357.00, itemName:"Triomphe Sunglasses", imageUrl: "https://cdn.modesens.com/product/76724533_2?w=400&height=600&quality=90", merchant: saksMerchant), // Updated example URL
      Product(id: "13", brand: "Bottega Veneta", price: 1105.00, itemName:"Cassette Bag", imageUrl: "https://bottega-veneta.dam.kering.com/m/13250abea443970f/Small-717134V1E518425_A.jpg?v=1"), // Updated example URL
      Product(id: "14", brand: "Theory", price: 185.00, itemName:"Tiny Tee", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/196060399428_WHITE?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated example URL
    ],
  ),

  // --- Frame 2: Rosie ---
  ShoppingFrame(
    id: "rosie",
    title: "Rosie-inspired relaxed elegance",
    products: [
      Product(id: "r1", brand: "The Row", price: 2440.00, itemName: "Margaret Belted Wool Coat", imageUrl: "https://cdn.saksfifthavenue.com/is/image/saks/0400020786484_OFFWHITE_ASTL?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0", merchant: saksMerchant),
      Product(id: "r2", brand: "Khaite", price: 800.00, itemName: "Ema Cashmere Sweater", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/0400019618956_FLAXMELANGE?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0", merchant: netAPorterMerchant), // Updated URL
      Product(id: "r3", brand: "Totême", price: 775.00, itemName: "Double-Breasted Vent Blazer", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/0400019477293_BLACK?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
      Product(id: "r4", brand: "Loewe", price: 1210.00, itemName: "Anagram Cotton Blouse", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/8445020602224_WHITE?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
      Product(id: "r5", brand: "Bottega Veneta", price: 295.00, itemName: "Intrecciato Leather Belt", imageUrl: "https://bottega-veneta.dam.kering.com/m/394abf5c7f5cf7fc/Small-609182VCPQ38803_A.jpg?v=1"), // Updated URL
      Product(id: "r6", brand: "Victoria Beckham", price: 1250.00, itemName: "Tailored Wide-Leg Trousers", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/5000000000000_NAVY?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Representative Image
      Product(id: "r7", brand: "Vince", price: 205.00, itemName: "Essential Silk Blouse", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/190888061946_OPTICWHITE?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
      Product(id: "r8", brand: "Max Mara", price: 2190.00, itemName: "Madame Wool Coat", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/8054441808088_CAMEL?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
    ],
  ),

  // --- Frame 3: Miami Vibes ---
  ShoppingFrame(
    id: "miami vibes",
    title: "Effortlessly-chic Miami vibes",
    products: [
      Product(id: "m1", brand: "Loewe", price: 1890.00, itemName: "Paula's Ibiza Cotton Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/8445020608288_WHITEECRU?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
      Product(id: "m2", brand: "Eleventy", price: 1295.00, itemName: "Linen-Blend Midi Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/8053611175909_BEIGE?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0", merchant: saksMerchant), // Updated URL
      Product(id: "m3", brand: "Zimmerman", price: 475.00, itemName: "Vitali Paisley Mini Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/9352185799706_PURPLEPAISLEY?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
      Product(id: "m4", brand: "Hutch", price: 398.00, itemName: "Floral Print Silk Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/0400018849908_PRINT?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
      Product(id: "m5", brand: "Misha", price: 380.00, itemName: "Kalani Floral Midi Dress", imageUrl: "https://is4.revolveassets.com/images/p4/n/uv/MISR-WD370_V1.jpg"),
      Product(id: "m6", brand: "Jacquemus", price: 950.00, itemName:"La Robe Bahia Mini Dress", imageUrl: "https://img.ssensemedia.com/images/f_auto,c_limit,h_2800,w_1725/242553F052029_1/jacquemus-white-les-classiques-la-robe-bahia-minidress.jpg"),
      Product(id: "m7", brand: "Khaite", price: 1205.00, itemName: "Mel Linen Midi Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/0400019618994_NATURAL?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
      Product(id: "m8", brand: "Johanna Ortiz", price: 2190.00, itemName: "Energetic Patterns Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/0400018169931_PRINT?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
      Product(id: "m9", brand: "Agua by Agua Bendita", price: 1245.00, itemName: "Floral Embroidered Maxi Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/0400019852335_PRINT?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
      Product(id: "m10", brand: "Ulla Johnson", price: 475.00, itemName: "Leela Floral Midi Dress", imageUrl: "https://images.saksfifthavenue.com/is/image/saks/0400019780361_POPPY?wid=534&hei=712&qlt=90&resMode=sharp2&op_usm=0.9,1.0,8,0"), // Updated URL
    ],
  ),

  // Add the "more tropical" frame if needed, similar structure
];

// Example Cart Items for UI Shell (not loaded from anywhere, just for display)
final List<CartItem> mockCartItems = [
  CartItem(productId: 'm2', product: mockShoppingFrames[2].products[1], quantity: 1), // Eleventy Dress
  CartItem(productId: 'r2', product: mockShoppingFrames[1].products[1], quantity: 1), // Khaite Sweater
];