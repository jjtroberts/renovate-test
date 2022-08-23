# Local Renovate Testing
A local testing stack using Gitea, MySQL and Renovate.

The `docker-compose.yaml` and the `Makefile` can be used to test versions of Renovate.
For this use-case, Platform One's Iron Bank Container Hardening Team wanted to test
upstream opensource renovate against Iron Bank's renovate image which contains an additional
module. You can mix and match as needed.

The `renovate` service in `docker-compose.yaml` isn't necessary, but we added it for learnings.
You could simply stand up gitea and mysql, then use `make run` to execute renovate.

## Usage
1. Config: `cp config.js.default config.js`
2. Start: `make up`
3. Go to Gitea at http://localhost:3000 (first registered user becomes the admin)
4. Setup your user account and create a personal access token
5. Change your username, email and the token in `config.js` 
6. Change RENOVATE_TOKEN and RENOVATE_GIT_AUTHOR in the `Makefile`
7. Restart: `make restart` to reload the config values
8. Create a repo and check in your code
9. Run: `make run` if you don't want to wait for renovate or want to use a different version

## Troubleshooting
If you change the directory name after cloning, then you must also change the `--network` in the 
Makefile's `make run` command to whatever docker-compose creates. You can list your available networks
using `docker network ls`. This connects your standalone container with the docker-compose created network so renovate can talk to gitea.

Also, registry1 requires authentication before you can pull images:
1. Setup your account here: https://login.dso.mil
2. Create your CLI secret in harbor: https://registry1.dso.mil/harbor
3. Login: `docker login registry1.dso.mil` and provide your username and harbor cli secret

## References
- https://docs.gitea.io/en-us/api-usage/
- https://docs.renovatebot.com/modules/platform/gitea/