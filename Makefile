postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

sqlc:
	docker run --rm -v "E:\simple\simple_bank\:/src" -w /src kjconroy/sqlc generate

git:
	git add .
	git commit -m "$m"
	git push origin main

test:
	go test -v -cover ./...

requirement:
	go get github.com/lib/pq
	go get github.com/stretchr/testify

.PHONY: postgres createdb dropdb migrateup migratedown sqlc test