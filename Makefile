.DEFAULT_GOAL := run

up:
				docker-compose pull && docker-compose up -d
.PHONY:up

down:
				docker-compose down
.PHONY:down

restart:
				docker-compose restart
.PHONY:restart

run: 
				docker run --rm -ti \
						--network=renovate-test_gitea \
						--platform=linux/x86_64 \
						-e RENOVATE_PLATFORM=gitea \
						-e RENOVATE_GIT_AUTHOR="Joe Roberts <jroberts@rackner.com>" \
						-e RENOVATE_ENDPOINT="http://server:3000/api/v1" \
						-e RENOVATE_TOKEN=change-me \
						-e RENOVATE_AUTODISCOVER='true' \
						registry1.dso.mil/ironbank/container-hardening-tools/renovate/renovate:latest
.PHONY:run

test:
				curl -X POST "http://localhost:3000/api/v1/repos/jroberts/google-distroless-cc/issues" \
						-H "accept: application/json" \
						-H "Authorization: token change-me" \
						-H "Content-Type: application/json" -d "{ \"body\": \"testing\", \"title\": \"test 20\"}" -i
.PHONE:test
