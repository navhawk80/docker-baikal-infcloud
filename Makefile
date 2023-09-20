default: build

image = alpine-infcloud-baikal
tag = 3.15-0.13.1-0.9.3
timezone = Europe/Moscow

build:
	docker build \
			--build-arg TIMEZONE=$(timezone) \
			--tag "$(image):$(tag)" \
			$(args) .

export:
	rm "$(image).$(tag).tgz" || true
	docker image save --output "$(image).$(tag).tgz" "$(image):$(tag)"

run:
	docker run \
			--publish 8800:8800 \
			--name alpine-infcloud-baikal \
			--volume "$$(pwd)/baikal/data:/var/www/baikal/Specific" \
			--volume "$$(pwd)/baikal/config:/var/www/baikal/config" \
			--volume "$$(pwd)/baikal/lighttpd.conf:/etc/lighttpd/lighttpd.conf:ro" \
			--volume "$$(pwd)/baikal/infcloud.config.js:/var/www/infcloud/config.js:ro" \
			$(args) $(image)
