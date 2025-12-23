using Neo4j.Driver;
using System;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace Neo4jAuraExample
{
    class Program
    {
        static async Task Main(string[] args)
        {
            var uri = "neo4j+s://ad672a81.databases.neo4j.io";
            var user = "neo4j";
            var password = "AyQjzj0FBEoVukhBOCNJ0uNQW2rwaVj_6zJM0oXs454";            
            using (var driver = GraphDatabase.Driver(uri, AuthTokens.Basic(user, password)))
            using (var session = driver.AsyncSession())
            {
                try
                {                    
                    var persons = await GetAllPersonsAsync(session);
                    PrintPersonsTable(persons);

                    Console.WriteLine("\n" + new string('=', 70) + "\n");
                    var personsWithMovies = await GetPersonsWithMoviesAsync(session);
                    PrintPersonsWithMoviesTable(personsWithMovies);
                }
                catch (Exception ex)
                {
                    Console.WriteLine($"Error: {ex.Message}");
                    Console.WriteLine($"Stack Trace: {ex.StackTrace}");
                }
            }

            Console.WriteLine("\nPress any key to exit...");
            Console.ReadKey();
        }

        private static async Task<List<Person>> GetAllPersonsAsync(IAsyncSession session)
        {
            var query = "MATCH (p:Person) RETURN p.name AS name, p.born AS born ORDER BY p.name";

            return await session.ReadTransactionAsync(async tx =>
            {
                var result = await tx.RunAsync(query);
                var persons = new List<Person>();

                await result.ForEachAsync(record =>
                {
                    var person = new Person
                    {
                        Name = record["name"].As<string>(),
                        Born = record["born"].As<int?>()
                    };
                    persons.Add(person);
                });

                return persons;
            });
        }

        private static async Task<List<PersonWithMovies>> GetPersonsWithMoviesAsync(IAsyncSession session)
        {
            var query = @"
                MATCH (p:Person)
                OPTIONAL MATCH (p)-[r:ACTED_IN]->(m:Movie)
                RETURN p.name AS name, 
                       p.born AS born, 
                       collect(DISTINCT m.title) AS movies,
                       count(DISTINCT m) AS movieCount
                ORDER BY p.name";

            return await session.ReadTransactionAsync(async tx =>
            {
                var result = await tx.RunAsync(query);
                var persons = new List<PersonWithMovies>();

                await result.ForEachAsync(record =>
                {
                    var moviesList = record["movies"].As<List<object>>();
                    var movies = new List<string>();
                    
                    if (moviesList != null)
                    {
                        foreach (var movie in moviesList)
                        {
                            movies.Add(movie.ToString());
                        }
                    }
                    
                    persons.Add(new PersonWithMovies
                    {
                        Name = record["name"].As<string>(),
                        Born = record["born"].As<int?>(),
                        Movies = movies,
                        MovieCount = record["movieCount"].As<int>()
                    });
                });

                return persons;
            });
        }

        private static void PrintPersonsTable(List<Person> persons)
        {
            Console.WriteLine("\nALL PERSONS IN DATABASE");
            Console.WriteLine(new string('-', 50));
            Console.WriteLine("| {0,-30} | {1,-10} |", "Name", "Born");
            Console.WriteLine(new string('-', 50));

            foreach (var person in persons)
            {
                Console.WriteLine("| {0,-30} | {1,-10} |", 
                    person.Name ?? "N/A", 
                    person.Born?.ToString() ?? "N/A");
            }

            Console.WriteLine(new string('-', 50));
            Console.WriteLine($"Total persons: {persons.Count}");
        }

        private static void PrintPersonsWithMoviesTable(List<PersonWithMovies> persons)
        {
            Console.WriteLine("PERSONS WITH THEIR MOVIES");
            Console.WriteLine(new string('-', 85));
            Console.WriteLine("| {0,-20} | {1,-6} | {2,-4} | {3,-40} |", "Name", "Born", "Movies", "Movie Titles");
            Console.WriteLine(new string('-', 85));

            foreach (var person in persons)
            {
                var moviesSample = person.Movies.Count > 0 
                    ? string.Join(", ", person.Movies)
                    : "None";

                if (moviesSample.Length > 38)
                {
                    moviesSample = moviesSample.Substring(0, 35) + "...";
                }

                Console.WriteLine("| {0,-20} | {1,-6} | {2,-4} | {3,-40} |",
                    TruncateString(person.Name, 20),
                    person.Born?.ToString() ?? "N/A",
                    person.MovieCount,
                    moviesSample);
            }

            Console.WriteLine(new string('-', 85));
        }

        private static string TruncateString(string value, int maxLength)
        {
            if (string.IsNullOrEmpty(value)) return "N/A";
            return value.Length <= maxLength ? value : value.Substring(0, maxLength - 3) + "...";
        }
    }

    public class Person
    {
        public string Name { get; set; }
        public int? Born { get; set; }
    }

    public class PersonWithMovies : Person
    {
        public List<string> Movies { get; set; } = new List<string>();
        public int MovieCount { get; set; }
    }
}