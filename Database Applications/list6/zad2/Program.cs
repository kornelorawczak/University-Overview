using System;
using System.Collections.Generic;
using MongoDB.Bson;
using MongoDB.Bson.Serialization.Attributes;
using MongoDB.Driver;

namespace LibraryMongo
{
    public class BookCopy
    {
        public int CopyNumber { get; set; }      
        public string Shelf { get; set; } = "";
        public string Condition { get; set; } = "";
    }

    public class Book
    {
        [BsonId]
        public ObjectId Id { get; set; }

        public string Isbn { get; set; } = "";
        public string Title { get; set; } = "";
        public List<string> Authors { get; set; } = new();
        public int Year { get; set; }

        public List<BookCopy> Copies { get; set; } = new();
    }

    public class Address
    {
        public string Street { get; set; } = "";
        public string City { get; set; } = "";
        public string PostalCode { get; set; } = "";
    }

    public class Reader
    {
        [BsonId]
        public ObjectId Id { get; set; }

        public string FirstName { get; set; } = "";
        public string LastName { get; set; } = "";

        public Address Address { get; set; } = new();
    }

    public class Borrowing
    {
        [BsonId]
        public ObjectId Id { get; set; }

        public ObjectId ReaderId { get; set; }
        public ObjectId BookId { get; set; }
        public int CopyNumber { get; set; }      
        public DateTime BorrowDate { get; set; }
        public DateTime? ReturnDate { get; set; }    
    }


    class Program
    {
        static void Main(string[] args)
        {
            var connectionString = "mongodb://localhost:27017";
            var client = new MongoClient(connectionString);

            var database = client.GetDatabase("library");

            database.DropCollection("books");
            database.DropCollection("readers");
            database.DropCollection("borrowings");

            var booksCollection = database.GetCollection<Book>("books");
            var readersCollection = database.GetCollection<Reader>("readers");
            var borrowingsCollection = database.GetCollection<Borrowing>("borrowings");

            var book1 = new Book
            {
                Id = ObjectId.GenerateNewId(),
                Isbn = "978-83-01-00001-1",
                Title = "Pan Tadeusz",
                Authors = new List<string> { "Adam Mickiewicz" },
                Year = 1834,
                Copies = new List<BookCopy>
                {
                    new BookCopy { CopyNumber = 1, Shelf = "A1", Condition = "good" },
                    new BookCopy { CopyNumber = 2, Shelf = "A1", Condition = "worn" }
                }
            };

            var book2 = new Book
            {
                Id = ObjectId.GenerateNewId(),
                Isbn = "978-83-01-00002-8",
                Title = "Lalka",
                Authors = new List<string> { "Bolesław Prus" },
                Year = 1890,
                Copies = new List<BookCopy>
                {
                    new BookCopy { CopyNumber = 1, Shelf = "B2", Condition = "good" }
                }
            };

            booksCollection.InsertMany(new[] { book1, book2 });

            var reader1 = new Reader
            {
                Id = ObjectId.GenerateNewId(),
                FirstName = "Jan",
                LastName = "Kowalski",
                Address = new Address
                {
                    Street = "ul. Długa 1",
                    City = "Wrocław",
                    PostalCode = "50-001"
                }
            };

            var reader2 = new Reader
            {
                Id = ObjectId.GenerateNewId(),
                FirstName = "Anna",
                LastName = "Nowak",
                Address = new Address
                {
                    Street = "ul. Krótka 5",
                    City = "Wrocław",
                    PostalCode = "50-002"
                }
            };

            readersCollection.InsertMany(new[] { reader1, reader2 });

            var borrowing1 = new Borrowing
            {
                Id = ObjectId.GenerateNewId(),
                ReaderId = reader1.Id,
                BookId = book1.Id,
                CopyNumber = 1,
                BorrowDate = new DateTime(2024, 10, 1),
                ReturnDate = new DateTime(2024, 10, 15)
            };

            var borrowing2 = new Borrowing
            {
                Id = ObjectId.GenerateNewId(),
                ReaderId = reader1.Id,
                BookId = book2.Id,
                CopyNumber = 1,
                BorrowDate = new DateTime(2024, 11, 5),
                ReturnDate = null         
            };

            var borrowing3 = new Borrowing
            {
                Id = ObjectId.GenerateNewId(),
                ReaderId = reader2.Id,
                BookId = book1.Id,
                CopyNumber = 2,
                BorrowDate = new DateTime(2024, 9, 20),
                ReturnDate = new DateTime(2024, 9, 30)
            };

            var borrowing4 = new Borrowing
            {
                Id = ObjectId.GenerateNewId(),
                ReaderId = reader2.Id,
                BookId = book1.Id,
                CopyNumber = 1,
                BorrowDate = new DateTime(2024, 12, 1),
                ReturnDate = null
            };

            borrowingsCollection.InsertMany(new[] { borrowing1, borrowing2, borrowing3, borrowing4 });

            Console.WriteLine("\nCurrent borrowings in DB:");
            var allBorrowings = borrowingsCollection.Find(FilterDefinition<Borrowing>.Empty).ToList();
            foreach (var b in allBorrowings)
            {
                Console.WriteLine($"Borrowing {b.Id}: Reader={b.ReaderId}, Book={b.BookId}, Copy={b.CopyNumber}, BorrowDate={b.BorrowDate:d}, Returned={(b.ReturnDate.HasValue ? b.ReturnDate.Value.ToShortDateString() : "None")}");
            }
        }
    }
}

