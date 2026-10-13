# Isolation Levels

## Read Anomalies

Read anomalies occur when concurrent transactions interfere with each other, causing inconsistent or unexpected results.

- **Dirty read** — Transaction A modifies data but has not committed. Transaction B reads the uncommitted changes. If A rolls back, B has read data that was never committed.
- **Non-repeatable read** — Transaction A reads a row. Transaction B modifies or deletes that row and commits. When A reads it again, the result has changed or the row no longer exists.
- **Phantom read** — Transaction A queries a range of rows. Transaction B inserts or deletes a row matching the same criteria and commits. When A repeats the query, the result contains a different set of rows.
- **Snapshot consistency** — Snapshot isolation uses row versioning to let a transaction read a consistent snapshot of committed data, avoiding dirty reads, non-repeatable reads, and phantom reads within that snapshot. In SQL Server, snapshot isolation is an optional isolation level.

## Isolation Levels

Isolation levels determine which read anomalies can occur during concurrent transactions.

- **Read Uncommitted** — Allows dirty reads, non-repeatable reads, and phantom reads.
- **Read Committed** — Prevents dirty reads by allowing reads only of committed data. Non-repeatable reads and phantom reads are still possible.
- **Repeatable Read** — Prevents dirty reads and non-repeatable reads. Phantom reads are still possible.
- **Serializable** — Prevents dirty reads, non-repeatable reads, and phantom reads by providing behavior equivalent to transactions executing sequentially.
- **Snapshot** — Uses row versioning to provide a consistent view of committed data as of the transaction's start. Prevents dirty reads, non-repeatable reads, and phantom reads within that snapshot.

**Note:** SQL Server supports both `READ COMMITTED` and `SNAPSHOT` using row versioning when configured appropriately.