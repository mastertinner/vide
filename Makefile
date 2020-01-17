.PHONY: build
build:
	docker build -t vide .

.PHONY: clean
clean:
	docker rmi vide
