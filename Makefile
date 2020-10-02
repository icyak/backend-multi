.PHONY: docker docker-run clean

backend: main.go
	CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o backend .

docker: Dockerfile backend
# TASK: Build docker image here
	docker build -t icyak/labyrinthlabs:sample_backend3 .

docker-run: docker
	docker run -p 8080:8080 --name backend -ti icyak/labyrinthlabs:sample_backend3

clean:
	rm -rf backend
	docker rmi -f icyak/labyrinthlabs:sample_backend3 | true
