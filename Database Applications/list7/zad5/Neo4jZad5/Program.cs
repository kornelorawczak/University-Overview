using Neo4j.Driver;
using Neo4j.Driver.Preview.Mapping; 

public class Person
{
    public string name { get; set; }
    public int born { get; set; }
}

public class Program
{
    public static async Task Main(string[] args)
    {
        var uri = "neo4j+s://ad672a81.databases.neo4j.io";
        var user = "neo4j";
        var password = "AyQjzj0FBEoVukhBOCNJ0uNQW2rwaVj_6zJM0oXs454"; 

        using (var driver = GraphDatabase.Driver(uri, AuthTokens.Basic(user, password)))
        {
            var program = new Program();
            
            var newPersonId = await program.CreatePersonAsync(driver, "Your Name", 1990);
            Console.WriteLine($"Created person with ID: {newPersonId}");

            await program.GetAllPeopleAsync(driver);

            await program.UpdatePersonNameAsync(driver, newPersonId, "Updated Name");

            await program.DeletePersonAsync(driver, newPersonId);
        }
    }

    public async Task<long> CreatePersonAsync(IDriver driver, string name, int? born)
    {
        var query = @"
            CREATE (p:Person { name: $name, born: $born })
            RETURN id(p) AS nodeId";

        await using var session = driver.AsyncSession();
        
        var result = await session.RunAsync(query, new { name, born });
        var record = await result.SingleAsync();
        
        return record["nodeId"].As<long>();
    }

    public async Task<List<Person>> GetAllPeopleAsync(IDriver driver)
    {
        var query = @"MATCH (p:Person) RETURN p.name AS name, p.born AS born ORDER BY p.name";
        
        await using var session = driver.AsyncSession();
        
        var result = await session.RunAsync(query);
        
        // This  line uses the object mapping feature!!!
        var people = await result.ToListAsync(record => record.AsObject<Person>());
        
        Console.WriteLine("\nAll People:");
        foreach (var person in people)
        {
            Console.WriteLine($" - {person.name} (Born: {person.born})");
        }
        
        return people;
    }

    public async Task UpdatePersonNameAsync(IDriver driver, long personNodeId, string newName)
    {
        var query = @"
            MATCH (p:Person)
            WHERE id(p) = $id
            SET p.name = $newName";

        await using var session = driver.AsyncSession();
        
        await session.RunAsync(query, new { id = personNodeId, newName });
        Console.WriteLine($"Updated person ID {personNodeId} to '{newName}'");
    }

    public async Task DeletePersonAsync(IDriver driver, long personNodeId)
    {
        var query = @"
            MATCH (p:Person)
            WHERE id(p) = $id
            DELETE p";

        await using var session = driver.AsyncSession();
        
        await session.RunAsync(query, new { id = personNodeId });
        Console.WriteLine($"Deleted person ID {personNodeId}");
    }
}