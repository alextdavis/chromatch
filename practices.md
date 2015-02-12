This document is mean to convey some of the less obvious intentional choices I made when writing this, both as an explanation, and as a recommendation.

- I use `Sequel::Model#with_pk!` when modifying a record, and `Sequel::Model#[]` when fetching a record to be returned. The idea is that when trying to fetch something, the software using the API should reasonably expect for it to not exist, but the software using the API would only try to modify a record it already knew existed, so that deserves an error.

