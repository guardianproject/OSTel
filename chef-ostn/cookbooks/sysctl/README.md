# sysctl [![Build Status](https://travis-ci.org/onehealth-cookbooks/sysctl.png?branch=master)](https://travis-ci.org/onehealth-cookbooks/sysctl)

Description
===========

Set [sysctl](http://en.wikipedia.org/wiki/Sysctl) system control parameters via Opscode Chef


Platforms
=========

* Debian/Ubuntu
* RHEL/CentOS

Usage
=======

There are two main ways to interact with the cookbook. This is via chef [attributes](http://docs.opscode.com/essentials_cookbook_attribute_files.html) or via the provided [LWRP](http://docs.opscode.com/lwrp.html).

## Attributes

* node['sysctl']['params'] - A namespace for setting sysctl parameters
* node['sysctl']['conf_dir']  - Specifies the sysctl.d directory to be used. Defaults to /etc/sysctl.d on the Debian and RHEL platform families, otherwise nil
* node['sysctl']['allow_sysctl_conf'] - Defaults to false.  Using conf_dir is highly recommended. On some platforms that is not supported. For those platforms, set this to true and the cookbook will rewrite the /etc/sysctl.conf file directly with the params provided. Be sure to save any local edits of /etc/sysctl.conf before enabling this to avoid losing them.

## LWRP

### sysctl_param

Actions

- apply (default)
- remove

Attributes

- key
- value

## Examples

    # set vm.swapiness to 20 via attributes

    node.default['sysctl']['params']['vm']['swappiness'] = 20

    # set vm.swapiness to 20 via sysctl_param LWRP
    sysctl_param 'vm.swappiness' do
      value 20
    end

    # remove sysctl parameter and set net.ipv4.tcp_fin_timeout back to default
    sysctl_param 'net.ipv4.tcp_fin_timeout' do
      value 30
      action :remove
    end

# Development

This cookbook can be tested using vagrant, but it depends on the following vagrant plugins

```
vagrant plugin install vagrant-omnibus
vagrant plugin install vagrant-berkshelf
```

Tested with 
* Vagrant (version 1.2.2)
* vagrant-berkshelf (1.2.0)
* vagrant-omnibus (1.0.2)

To test we have written tests in [bats](https://github.com/sstephenson/bats) and executed via [test-kitchen](https://github.com/opscode/test-kitchen).

Much of the tooling around this cookbook is exposed via thor and test kitchen, so it is highly recommended to learn more about those tools.
However, to give a quick glance at how to do some tests, you can execute the following commmands

```
bundle install
bundle exec thor tailor:lint
bundle exec thor foodcritic:lint
bundle exec kitchen test default-ubuntu-1204
bundle exec kitchen test default-centos-64
```

The above will do ruby style ([tailor](https://github.com/turboladen/tailor)) and cookbook style ([foodcritic](http://acrmp.github.io/foodcritic/)) checks followed by ensuring proper cookbook operation on two separate linux platforms (Ubuntu 12.04 LTS Precise 64-bit and CentOS 6.4). Please run the tests on any pull requests that you are about to submit and write tests for defects or new features to ensure backwards compatibility and a stable cookbook that we can all rely upon.

# Links

There are a lot of different documents that talk about system control parameters, the hope here is to point to some of the most useful ones to provide more guidance as to what the possible kernel parameters are and what they mean.

* [Linux Kernel Sysctl](https://www.kernel.org/doc/Documentation/sysctl/)
* [Linux Kernel IP Sysctl](http://www.kernel.org/doc/Documentation/networking/ip-sysctl.txt)
* [THE /proc FILESYSTEM (Jun 2009)](http://www.kernel.org/doc/Documentation/filesystems/proc.txt)
* [RHEL 5 VM/Page Cache Tuning Presentation (2009) pdf](http://people.redhat.com/dshaks/Larry_Shak_Perf_Summit1_2009_final.pdf)
* [Arch Linux SysCtl Tutorial (Feb 2013)](http://gotux.net/arch-linux/sysctl-config/)
* [Old RedHat System Tuning Overview (2001!)](http://people.redhat.com/alikins/system_tuning.html)

