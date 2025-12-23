using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;

namespace MongoJoinsExample
{
    public class Customer
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }
        public string CustomerId { get; set; }
        public string Name { get; set; }
        public string Email { get; set; }
    }

    public class Order
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }
        public string OrderId { get; set; }
        public string CustomerId { get; set; }
        public decimal Amount { get; set; }
        public DateTime OrderDate { get; set; }
    }

    public class Product
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }
        public string ProductId { get; set; }
        public string Name { get; set; }
        public decimal Price { get; set; }
    }

    public class OrderItem
    {
        [BsonId]
        [BsonRepresentation(BsonType.ObjectId)]
        public string Id { get; set; }
        public string OrderId { get; set; }
        public string ProductId { get; set; }
        public int Quantity { get; set; }
    }

    class Program
    {
        private static IMongoDatabase database;
        private static IMongoCollection<Customer> customersCollection;
        private static IMongoCollection<Order> ordersCollection;
        private static IMongoCollection<Product> productsCollection;
        private static IMongoCollection<OrderItem> orderItemsCollection;

        static void Main(string[] args)
        {
            InitializeDatabase();
            InsertSampleData();
            
            Console.WriteLine("=== 2-Collection JOIN Example ===");
            PerformTwoCollectionJoin();
            
            Console.WriteLine("\n=== 3-Collection JOIN Example ===");
            PerformThreeCollectionJoin();
            
            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }

        static void InitializeDatabase()
        {
            var client = new MongoClient("mongodb://localhost:27017");
            database = client.GetDatabase("JoinsExampleDB");
            
            customersCollection = database.GetCollection<Customer>("customers");
            ordersCollection = database.GetCollection<Order>("orders");
            productsCollection = database.GetCollection<Product>("products");
            orderItemsCollection = database.GetCollection<OrderItem>("orderItems");
            
            database.DropCollection("customers");
            database.DropCollection("orders");
            database.DropCollection("products");
            database.DropCollection("orderItems");
            
            customersCollection = database.GetCollection<Customer>("customers");
            ordersCollection = database.GetCollection<Order>("orders");
            productsCollection = database.GetCollection<Product>("products");
            orderItemsCollection = database.GetCollection<OrderItem>("orderItems");
        }

        static void InsertSampleData()
        {
            var customers = new List<Customer>
            {
                new Customer { CustomerId = "CUST001", Name = "John Doe", Email = "john@example.com" },
                new Customer { CustomerId = "CUST002", Name = "Jane Smith", Email = "jane@example.com" },
                new Customer { CustomerId = "CUST003", Name = "Bob Johnson", Email = "bob@example.com" }
            };
            customersCollection.InsertMany(customers);

            var products = new List<Product>
            {
                new Product { ProductId = "PROD001", Name = "Laptop", Price = 999.99m },
                new Product { ProductId = "PROD002", Name = "Mouse", Price = 25.50m },
                new Product { ProductId = "PROD003", Name = "Keyboard", Price = 75.00m }
            };
            productsCollection.InsertMany(products);

            var orders = new List<Order>
            {
                new Order { OrderId = "ORD001", CustomerId = "CUST001", Amount = 1075.49m, OrderDate = DateTime.Now.AddDays(-5) },
                new Order { OrderId = "ORD002", CustomerId = "CUST002", Amount = 25.50m, OrderDate = DateTime.Now.AddDays(-3) },
                new Order { OrderId = "ORD003", CustomerId = "CUST001", Amount = 75.00m, OrderDate = DateTime.Now.AddDays(-1) }
            };
            ordersCollection.InsertMany(orders);

            var orderItems = new List<OrderItem>
            {
                new OrderItem { OrderId = "ORD001", ProductId = "PROD001", Quantity = 1 },
                new OrderItem { OrderId = "ORD001", ProductId = "PROD002", Quantity = 3 },
                new OrderItem { OrderId = "ORD002", ProductId = "PROD002", Quantity = 1 },
                new OrderItem { OrderId = "ORD003", ProductId = "PROD003", Quantity = 1 }
            };
            orderItemsCollection.InsertMany(orderItems);

            Console.WriteLine("Sample data inserted successfully!");
        }

        static void PerformTwoCollectionJoin()
        {
            var pipeline = new[]
            {
                new BsonDocument("$lookup", new BsonDocument
                {
                    { "from", "customers" },
                    { "localField", "CustomerId" },
                    { "foreignField", "CustomerId" },
                    { "as", "CustomerInfo" }
                }),
                new BsonDocument("$unwind", "$CustomerInfo")
            };

            var results = ordersCollection.Aggregate<BsonDocument>(pipeline).ToList();

            Console.WriteLine("Orders with Customer Information:");
            Console.WriteLine("=================================");
            
            foreach (var doc in results)
            {
                Console.WriteLine($"Order: {doc["OrderId"]}, " +
                                $"Amount: {doc["Amount"].ToDecimal():C}, " +
                                $"Customer: {doc["CustomerInfo"]["Name"]}, " +
                                $"Email: {doc["CustomerInfo"]["Email"]}");
            }
        }

        static void PerformThreeCollectionJoin()
        {
            var orderItems = orderItemsCollection.Find(_ => true).ToList();
            var orders = ordersCollection.Find(_ => true).ToList();
            var customers = customersCollection.Find(_ => true).ToList();
            var products = productsCollection.Find(_ => true).ToList();

            Console.WriteLine("Order Details with Customer and Product Information:");
            Console.WriteLine("===================================================");
            
            foreach (var item in orderItems)
            {
                var order = orders.FirstOrDefault(o => o.OrderId == item.OrderId);
                var customer = order != null ? customers.FirstOrDefault(c => c.CustomerId == order.CustomerId) : null;
                var product = products.FirstOrDefault(p => p.ProductId == item.ProductId);

                if (order != null && customer != null && product != null)
                {
                    Console.WriteLine($"Order: {item.OrderId}, " +
                                    $"Customer: {customer.Name}, " +
                                    $"Product: {product.Name}, " +
                                    $"Price: {product.Price:C}, " +
                                    $"Quantity: {item.Quantity}, " +
                                    $"Total: {product.Price * item.Quantity:C}");
                }
            }
        }
    }
}