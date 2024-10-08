#! /bin/sh

key0=$(cat unseal_key_0.out)
vault operator unseal $key0

key1=$(cat unseal_key_1.out)
vault operator unseal $key1

key2=$(cat unseal_key_2.out)
vault operator unseal $key2