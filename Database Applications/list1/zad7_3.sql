SELECT @@IDENTITY AS LastIdentityValue;
-- Returns last identity value generated in current session - since this is new query, it returns NULL
SELECT IDENT_CURRENT('Test') AS IdentityInTest;
-- Returns last identity value generated specifically in the table 'Test'
