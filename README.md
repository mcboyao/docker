# Docker
Docker Compose for
* Vault
* Postgres
* Keycloak

## Usage


### _Vault_ 

Initialize Vault (**This must only be done during the first run!**)

* Go to `./vault` directory
* Run `docker-compose up -d` to start the service in background
* Run `docker exec -it <container-id> sh` to go inside the container shell
  * Use command `docker ps` to get the container id of the vault service
* Inside the container, run
  * `cd /vault`
  * `sh initialize.sh`
    * This will generate the following files and unseal _Vault_:
      * `root_token.out` file that will contain VAULT_TOKEN value
      * `generated_keys.out` that contains the 5 keys used for "unsealing" Vault
      * `unseal_key_*.out` parsed key files
* Access _Vault_ at http://localhost:8200/ using the VAULT_TOKEN value from `root_token.out` file

**_Note:_** Vault (**ALWAYS!**) starts in a "sealed" state, which means that every time it's restarted it must be "unsealed".

Unseal Vault (**These steps must be used in the succeeding run**)

* Go to `./vault` directory
* Run `docker-compose up -d` to start the service in background
* Run `docker exec -it <container-id> sh` to go inside the container shell
    * Use command `docker ps` to get the container id of the vault service
* Inside the container, run
  * `cd /vault`
  * `sh unseal.sh`
* Access _Vault_ at http://localhost:8200/ using the VAULT_TOKEN value from `root_token.out` file

### _Postgres_
* Go to `./postgres` directory
* Modify `./postgres/.env` file to desired database name and credentials. Default:
    * Database: `postgres`
    * User: `postgres`
    * Password: `postgres2024`
* Run `docker-compose up -d` to start the service in background
* Access `postgres` database on port `5432`

### _Keycloak_
* Go to `./keycloak` directory
* Modify `./keycloak/.env` file to desired database name and keycloak credentials. Default:
    * Database: `keycloak`
    * Database User: `keycloak_db_user`
    * Database Password: `keycloak_db_user_password`
    * Keycloak Admin: `admin`
    * Keycloak Admin Password: `keycloak_admin_password`
* Run `docker-compose up -d` to start the service in background
* Access web console at http://localhost:8180/

