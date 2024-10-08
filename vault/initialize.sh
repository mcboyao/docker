#! /bin/sh

chmod 777 /vault/data

# Init Vault
vault operator init > generated_keys.out

# Export values
export VAULT_ADDR='http://0.0.0.0:8200'
export VAULT_SKIP_VERIFY='true'

# Parse unsealed keys
keys=$(grep "Unseal Key " < generated_keys.out | cut -c15-)
index=0
for key in $keys
do
	echo $key > unseal_key_$index.out
	index=`expr $index + 1`
done

key0=$(cat unseal_key_0.out)
vault operator unseal $key0

key1=$(cat unseal_key_1.out)
vault operator unseal $key1

key2=$(cat unseal_key_2.out)
vault operator unseal $key2

# Get root token
rootToken=$(grep "Initial Root Token: " < generated_keys.out  | cut -c21-)
echo $rootToken > root_token.out

export VAULT_TOKEN=$rootToken

# Enable kv
vault secrets enable -version=1 -path=secret kv

# Enable userpass and add default user
#SECRET_PASS=admin
#vault auth enable userpass
#vault policy write spring-policy spring-policy.hcl
#vault write auth/userpass/users/admin password=${SECRET_PASS} policies=spring-policy

# Add secrets
vault kv put secret/backend-auth PG_USERNAME=paralelogram PG_PASSWORD=p@raLel0gram PG_HOST=localhost PG_PORT=5432 PG_DATABASE=paralelogram PG_SCHEMA=pilot
