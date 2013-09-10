# vagrant-golang

## requirements
* vagrant
* chef
* knife-solo
* berkshelf

## setup

```sh
$ vagrant init
$ vagrant up
$ vagrant ssh-config --host v-golang >> ~/.ssh/config
$ knife solo prepare v-golang
$ knife solo cook v-golang
$ ssh v-golang
```
