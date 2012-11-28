This is a sample configuration for use with the [Drifter][] OpenStack
provisioning tool.

[drifter]: https://github.com/larsks/drifter

## About this configuration

This Drifter configuration demonstrates the use of [cloud-init][] and
[Puppet][] to configure your OpenStack instances.  This assumes that
you have a `cloud-init` enabled image, such as those provided by
[Ubuntu][].

[cloud-init]: https://help.ubuntu.com/community/CloudInit
[puppet]: http://puppetlabs.com/
[ubuntu]: http://cloud-images.ubuntu.com/

## How it works

The following `default` instance definition in `project.yml` provides
the contents of `userdata/common` to your instances via the OpenStack
metadata service:

    instances:
      default:
        image: ubuntu-precise-x86_64
        flavor: m1.small
        security groups:
          - default
        userdata: userdata/common

The contents of `userdata/common` are a cloud-init "cloud archive" --
that is, a YAML document that wraps a number of other documents.

### cloud-config section

The first part of the cloud archive is a `cloud-config` file that
controls the behavior of `cloud-init` itself:

    - type: text/cloud-config
      content: |
        apt_upgrade: true
        packages:
        - puppet
        - git-core
        - ruby-json
        puppet_ecn:
          parameters:
            drifter_project: {{ project.config.project_name }}
            drifter_user: {{ project.config.os_username }}
            drifter_instance: {{ instance.name }}

The `puppet_ecn` section is not used by `cloud-init`, but is used
later on by [cloud-init-ecn][], a Puppet 
[external node classifier][] that is used to provide data from Drifter
to the Puppet environment.

[cloud-init-ecn]: https://github.com/larsks/cloud-init-ecn
[external node classifier]: http://docs.puppetlabs.com/guides/external_nodes.html

### Git repositories

The next section is a shell script that clones two git repositories
(`cloud-init-ecn` and [this example configuration][]) onto the local instance:

    - type: text/x-shellscript
      content: |
        #!/bin/sh
        git clone git://github.com/larsks/cloud-init-ecn.git /var/lib/cloud-init-ecn
        git clone git://github.com/larsks/drifter-example-puppet.git /var/lib/drifter

[this example configuration]: https://github.com/larsks/drifter-example-puppet

### Running Puppet

The last section is another shell script that runs Puppet, using
`cloud-init-ecn` as the external node classifier and the contents of
the `puppet` directory as the configuration.

    - type: text/x-shellscript
      content: |
        #!/bin/sh
        cd /var/lib/drifter
        puppet apply --node_terminus=exec \
          --external_nodes=/var/lib/cloud-init-ecn/cloud-init-ecn.py \
          --modulepath=puppet/modules puppet/site.pp

