# Vault Consul -Puppet Build 

This repository has Puppet Roles and Profiles to install Vault and Consul.

## Passing Consul server parameters
The consul server parameters are passed from consulserver profiles. Consul server and client uses puppetforge module KyleAnderson/consul.
More info about reconfiguring the module available at [consul_puppet_forge](https://forge.puppet.com/KyleAnderson/consul/readme)

## Vault Server Installation
The Vault server puppet module was built from the scratch and it supports only centos. Tested on CentOs7


