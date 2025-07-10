# Packer DigitalOcean Bun

<p>
  <a href="https://github.com/acfatah/packer-digitalocean-bun/commits/main">
    <img
      alt="GitHub last commit (by committer)"
      src="https://img.shields.io/github/last-commit/acfatah/packer-digitalocean-bun?display_timestamp=committer&style=flat-square"></a>
</p>

A Packer template for creating a DigitalOcean image with [Bun][1] installed.

> [!WARNING]
> This is experimental and should be used at your own risk.


## Software Included

| Software    | Version     | License |
| ---         | ---         | ---     |
| [Bun][1]    | [1.2.x][2]  | [MIT][3] |
| [Nginx][4]  | [1.17.x][5] | [Artistic License 2.0][6] |


## Prerequisite

- A [DigitalOcean][21] account and the `DIGITALOCEAN_API_TOKEN` environment variable are required.
- [Packer](https://developer.hashicorp.com/packer) must be installed.
- The [DigitalOcean Packer Plugin](https://developer.hashicorp.com/packer/integrations/digitalocean/digitalocean) must be installed.


## Usage

```sh
packer build template.json
```

After a successful build, the image `snapshot bun-20-04-snapshot-{timestamp}` will be available in the `Backups & Snapshots` section of your DigitalOcean account.

To run with debugging information,

```sh
PACKER_LOG=1 packer build -debug template.json 2>&1 | tee build.log
```
## Implementation Details

The image searches for a Bun application in `/root/app` and executes `bun run start` within that directory. For more information, see 
`files/etc/systemd/system/bun-app.service`.

The `NODE_ENV` is set to `production`.

## References

- https://developer.hashicorp.com/packer/install
- https://developer.hashicorp.com/packer/integrations/digitalocean/digitalocean/latest/components/builder/digitalocean
- https://github.com/digitalocean/droplet-1-clicks
- https://bun.sh/docs

[1]: https://bun.sh
[2]: https://github.com/oven-sh/bun/releases
[3]: https://github.com/oven-sh/bun/blob/main/LICENSE
[4]: https://nginx.org
[5]: https://packages.ubuntu.com/focal/nginx
[6]: https://www.npmjs.com/policies/npm-license


[21]: https://cloud.digitalocean.com/login
