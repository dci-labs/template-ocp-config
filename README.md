# Template for a new DCI OpenShift project

Follow the requirements described in [the DCI
documentation](https://docs.distributed-ci.io/dci-openshift-agent/#systems-requirements)
to prepare the jumpbox.

## Instructions

Install the `dci-pipeline` and `dci-openshift-app-agent` rpm on your jumpbox.

Download the archive of this project on your jumpbox, like this:

```ShellSession
$ wget https://github.com/dci-labs/template-ocp-config/archive/refs/heads/main.zip
```

Extract it at the right location.

```ShellSession
$ unzip main.zip
$ mv template-ocp-config-main <your company>-<lab>-config
```

All the files are expected to be installed into the home of the user
running the pipelines. Just replace `config` with your own locations
in the files (`<your company>-<lab>-config`).

```ShellSession
$ cd ~/<your company>-<lab>-config
$ find . -type f|xargs sed -i -e "s@/config/@/<your company>-<lab>-config/@g"
$ git init
$ git add .
$ git commit -m 'initial version from template'
```

Ask your DCI contact to create your project on [the dci-labs GitHub
organization](https://github.com/dci-labs). And then push it there:

```ShellSession
$ cd ~/<your company>-<lab>-config
$ git remote add origin git@github.com:dci-labs/<your company>-<lab>-config.git
$ git branch -M main
$ git push -u origin main
```

Then create the required directories and files for DCI to work:

```ShellSession
$ cd
$ mkdir -p dci-cache-dir upload-errors .config/dci-pipeline
$ cat > .config/dci-pipeline/config <<EOF
PIPELINES_DIR=$HOME/<your company>-<lab>-config/pipelines
EOF
```

You can now customize the hooks, pipelines and inventories files for
your own needs following [the DCI documentation](https://docs.distributed-ci.io/).

By default 2 job descriptions (`ocp-4.12` and `workload`) and their
associated hooks are present in the template.

The inventories are expecting `dci-queue` to be used with the
following settings:

```ShellSession
$ dci-queue add pool pool
$ dci-queue add resource pool cluster1
```

If you don't want to use `dci-queue`, just edit the the pipeline files
to not use dynamic paths.
