build: Dockerfile
	docker build -t melashri/pandoc-nbconvert-docker .

push: build
	docker push melashri/pandoc-nbconvert-docker
