-- 0. How do you get all users?
SELECT * FROM accounts;

-- 1. How do you get all users from Chicago?

SELECT * FROM "accounts" WHERE city = 'Chicago';

-- 2. How do you get all users with usernames that contain the letter a?

SELECT * FROM "accounts" WHERE "username" LIKE '%a%';

-- 3. The bank is giving a new customer bonus! How do you update all records with 
--    an account balance of 0.00 and a transactions_attempted of 0? Give them a new account balance of 10.00.

UPDATE "accounts" SET "account_balance" = '10.00' 
WHERE "account_balance" = 0.00;

-- 4. How do you select all users that have attempted 9 or more transactions?

SELECT * FROM "accounts" WHERE "transactions_attempted" >= 9;

-- 5. How do you get the username and account balance of the 3 users with the highest balances, 
--    sorted highest to lowest balance? NOTE: Research LIMIT


