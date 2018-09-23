build:
	docker build -t delve .

deploy: build
	docker run -d --privileged --rm --name=delve -p 8080:8080 -p 40000:40000 --security-opt=seccomp:unconfined delve