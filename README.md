# Template for a new DCI OpenShift project

Follow the requirements described in [the DCI
documentation](https://docs.distributed-ci.io/dci-openshift-agent/#systems-requirements)
to prepare the jumpbox.

## Instructions

Install the `dci-pipeline` and `dci-openshift-app-agent` rpm on your jumpbox.

Download the archive of this project on your jumpbox, like this:

```ShellSession
# su - dci-pipeline
$ wget https://github.com/dci-labs/template-ocp-config/archive/refs/heads/main.zip
```

Extract it at the right location.

```ShellSession
# su - dci-pipeline
$ unzip main.zip
$ mv template-ocp-config-main <your company>-<lab>-config
```

All the files are expected to be installed into the `dci-pipeline`
user's home (in `/var/lib/dci-pipeline`) under the `config`
directory. Just replace `/var/lib/dci-pipeline` and `config` with your
own locations in the files.

```ShellSession
# su - dci-pipeline
$ find <your company>-<lab>-config -type f|xargs sed -i -e "s@/config/@<your company>-<lab>-config@g"
$ cd <your company>-<lab>-config
$ git init
$ git add .
$ git commit -m 'initial version from template'
```

Ask your DCI contact to create your project on [the dci-labs GitHub
organization](https://github.com/dci-labs). And then push it there:

```ShellSession
# su - dci-pipeline
$ cd <your company>-<lab>-config
$ git remote add origin git@github.com:dci-labs/<your company>-<lab>-config.git
$ git branch -M main
$ git push -u origin main
```

Then create the required directories and files for DCI to work:

```ShellSession
# su - dci-pipeline
$ mkdir -p dci-cache-dir upload-errors .config/dci-pipeline
$ cat > .config/dci-pipeline/config <<EOF
PIPELINES_DIR=/var/lib/dci-pipeline/<your company>-<lab>-config/pipelines
INVENTORIES_DIR==/var/lib/dci-pipeline/<your company>-<lab>-config/inventories
EOF
```

You can now customize the hooks, pipelines and inventories files for
your own needs following [the DCI documentation](https://docs.distributed-ci.io/).
