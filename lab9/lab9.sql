
-- Task 1
-- a) Alice's balance decreased by 100, Bob's balance increased by 100
-- b) Because between this two queries might happen some unexpected error which will lead to data inconsistency ->
-- like bob got money from nowhere, bc Alice's money hasn't decreased by 100
-- c) data inconsistency

-- Task 2
-- a) 400
-- b) 900
-- c) where there is data inconsistency which we need to eliminate(rollback changes)

-- Task 3
-- a) B - 600, A - 800, W - 850
-- b) We rollbacked
-- c) Instead of rolling back to the beginning of a transaction, we simply rollback to our desired state, which saves us time and memory

-- Task 4
-- a) Phantom read after terminal 2
-- b) Sees what it saw before terminal 2
-- c) Read commited is a default transaction level in pgsql that reads commited data, even that were commited by other transactions
--  which may cause phantom read. Serializable prevents phantom reading

-- Task 5
-- a) No
-- b) Phantom read - is a read when we are in same transaction reading data at different moments and we get different results
-- c) Serializable and repeatable read
--

-- Task 6
-- a) Yes. Because we read uncommited data which wes rollbacked and leads to inconsistency
-- b) Read of uncommited data
-- c) Read of data which is not being committed can lead to unexpected behaiviour
--

-- Ex1
DO

$$
    DECLARE bal DECIMAL(10, 2);
    BEGIN
        SELECT balance INTO bal FROM accounts WHERE name = 'Bob';
        IF (bal < 200) THEN
            RAISE EXCEPTION 'insufficient funds';
        END IF;
        UPDATE accounts SET balance = balance - 200 WHERE name='Bob';
        UPDATE accounts SET balance = balance + 200 WHERE name='Wally';
    END
$$;
-- Ex2
BEGIN;
INSERT INTO products (shop, product, price) VALUES('Don Carleone', 'Pizza', 20.5);
SAVEPOINT savepoint;
UPDATE products SET price = price - 2.5
WHERE shop='Don Carleone';
SAVEPOINT savepoint2;
DELETE FROM products WHERE shop='Don Carleone';
ROLLBACK TO savepoint;
COMMIT;
-- Table products has the product we added without changed price


-- Ex3
-- T1
-- balance is initially = 100

-- T1
DO $$
    DECLARE
        bal DECIMAL(10, 2);
    BEGIN
        SELECT balance INTO bal FROM accounts WHERE name='Alice';
        IF (bal < 100) THEN
            RAISE EXCEPTION 'insufficient';
        end if;
        UPDATE accounts SET balance = balance - 100 WHERE name='Alice';
    end;
    $$ language plpgsql;
-- If these transactions goes simultaneously, there will be negative balance


DO $$
    DECLARE
        bal DECIMAL(10, 2);
    BEGIN
        SET TRANSACTION ISOLATION LEVEL REPEATABLE READ;
        SELECT balance INTO bal FROM accounts WHERE name='Alice';
        IF (bal < 100) THEN
            RAISE EXCEPTION 'insufficient';
        end if;
        UPDATE accounts SET balance = balance - 100 WHERE name='Alice';
    end;
$$ language plpgsql;
-- When trying to update it will raise an error
-- [40001] ERROR: could not serialize access due to concurrent update
-- For serializable it's could not serialize access due to read/write dependencies


