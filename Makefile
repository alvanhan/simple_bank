postgres:
	docker run --name postgres12 -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=secret -d postgres:12-alpine

createdb:
	docker exec -it postgres12 createdb --username=root --owner=root simple_bank

dropdb:
	docker exec -it postgres12 dropdb simple_bank

migrateup:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up

migrateup1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose up 1

migratedown:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down

migratedown1:
	migrate -path db/migration -database "postgresql://root:secret@localhost:5432/simple_bank?sslmode=disable" -verbose down 1

sqlc:
	docker run --rm -v "E:\simple\simple_bank\:/src" -w /src kjconroy/sqlc generate

mock:
	mockgen -package mockdb  -destination db/mock/store.go  github.com/alvanhan/simple_bank/db/sqlc Store

git:
	git add .
	git commit -m "$m"
	git push origin main

test:
	go test -v -cover ./...

server:
	go run main.go

requirement:
	go get github.com/lib/pq
	go get github.com/stretchr/testify
	go get -u github.com/gin-gonic/gin
	go get github.com/spf13/viper

.PHONY: postgres createdb dropdb migrateup migratedown migrateup1 migratedown1 sqlc test server mock