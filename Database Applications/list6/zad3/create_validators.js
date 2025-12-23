const db = db.getSiblingDB("library");

const bookSchema = {
  $jsonSchema: {
    bsonType: "object",
    required: ["_id","Isbn","Title","Authors","Year","Copies"],
    properties: {
      _id: { bsonType: "objectId" },
      Isbn: { bsonType: "string" },
      Title: { bsonType: "string" },
      Authors: { bsonType: "array", minItems: 1, items: { bsonType: "string" } },
      Year: { bsonType: ["int","double"], minimum: 0 },
      Copies: {
        bsonType: "array",
        minItems: 1,
        items: {
          bsonType: "object",
          required: ["CopyNumber","Shelf","Condition"],
          properties: {
            CopyNumber: { bsonType: "int" },
            Shelf: { bsonType: "string" },
            Condition: { bsonType: "string" }
          }
        }
      }
    },
    additionalProperties: false
  }
};

const readerSchema = {
  $jsonSchema: {
    bsonType: "object",
    required: ["_id","FirstName","LastName","Address"],
    properties: {
      _id: { bsonType: "objectId" },
      FirstName: { bsonType: "string" },
      LastName: { bsonType: "string" },
      Address: {
        bsonType: "object",
        required: ["Street","City","PostalCode"],
        properties: {
          Street: { bsonType: "string" },
          City: { bsonType: "string" },
          PostalCode: { bsonType: "string" }
        }
      }
    },
    additionalProperties: false
  }
};

const borrowingSchema = {
  $jsonSchema: {
    bsonType: "object",
    required: ["_id","ReaderId","BookId","CopyNumber","BorrowDate"],
    properties: {
      _id: { bsonType: "objectId" },
      ReaderId: { bsonType: "objectId" },
      BookId: { bsonType: "objectId" },
      CopyNumber: { bsonType: "int", minimum: 1 },
      BorrowDate: { bsonType: "date" },
      ReturnDate: { bsonType: ["date","null"] }
    },
    additionalProperties: false
  }
};

function applyValidator(name, schema) {
  try {
    db.createCollection(name, { validator: schema, validationLevel: "strict", validationAction: "error" });
    print(`Created '${name}' with validator`);
  } catch(e) {
    db.runCommand({ collMod: name, validator: schema, validationLevel: "strict", validationAction: "error" });
    print(`Updated '${name}' with validator`);
  }
}

applyValidator("books", bookSchema);
applyValidator("readers", readerSchema);
applyValidator("borrowings", borrowingSchema);

function checkExisting(name, schema) {
  const invalid = db.getCollection(name).find({ $nor: [ schema ] }).count();
  print(`Collection '${name}' has ${invalid} invalid documents`);
}

checkExisting("books", bookSchema);
checkExisting("readers", readerSchema);
checkExisting("borrowings", borrowingSchema);
