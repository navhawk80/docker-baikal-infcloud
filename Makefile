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
			--volume "$$(pwd)/baikal:/var/www/baikal/Specific" \
			--volume "$$(pwd)/baikal:/var/www/baikal/config" \
			--volume "$$(pwd)/baikal/infcloud.config.js:/var/www/infcloud/config.js" \
			$(args) $(image)
