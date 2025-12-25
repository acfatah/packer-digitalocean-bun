# Packer DigitalOcean Bun

<p>
  <a href="./LICENSE">
    <img alt="GitHub" src="https://img.shields.io/github/license/acfatah/packer-digitalocean-bun?style=flat-square"></a>
  <a href="https://github.com/acfatah/packer-digitalocean-bun/commits/main">
    <img
      alt="GitHub last commit (by committer)"
      src="https://img.shields.io/github/last-commit/acfatah/packer-digitalocean-bun?display_timestamp=committer&style=flat-square"></a>
</p>

A Packer template for creating a DigitalOcean image with [Bun][1] pre-installed.

> [!TIP]
> See also [ubuntu-bun-server-setup](https://github.com/acfatah/ubuntu-bun-server-setup) for a bash script to setup Bun server on Ubuntu image.


## Software Included

| Software    | Version     | License |
| ---         | ---         | ---     |
| [Bun][1]    | [1.2.x][2]  | [MIT][3] |
| [Nginx][4]  | [1.17.x][5] | [Artistic License 2.0][6] |
| [Certbot][7]    | [4.1.x][8]  | [Apache 2 on GitHub][9] |


## Prerequisite

- A [DigitalOcean][21] account and the `DIGITALOCEAN_TOKEN` or `DIGITALOCEAN_ACCESS_TOKEN` environment variable are required.
- [Packer](https://developer.hashicorp.com/packer) must be installed.
- The [DigitalOcean Packer Plugin](https://developer.hashicorp.com/packer/integrations/digitalocean/digitalocean) must be installed.


## Usage

```sh
packer build template.pkr.hcl
```

After a successful build, the image `snapshot bun-20-04-snapshot-{timestamp}` will be available in the `Backups & Snapshots` section of your DigitalOcean account.

To run with debugging information,

```sh
PACKER_LOG=1 packer build -color=false template.pkr.hcl 2>&1 | tee build.log
```

By default, the snapshot will be created on `sgp1` region. To change it, add `-var region={region}` or use environmental variable `PKR_VAR_region={region}`.

## Implementation Details

The image searches for a Bun application in `/root/app` and executes `bun run start` within that directory. For more information, see 
`files/etc/systemd/system/bun-app.service`.

The `NODE_ENV` is set to `production`.

## Generate SSL Certificate

To get HTTPS certificate from [LetsEncrypt][22], 

1. Create a nginx configuration for the domain name under `/etc/nginx/sites-available`. 
2. Create symbolic link to the file under `/etc/nginx/sites-neabled`.
3. Optionally test your configuration by running `nginx -t`
4. Restart nginx by running `systemctl restart nginx`.
5. Run `certbot --nginx` then follow the instruction give.

## References

- https://developer.hashicorp.com/packer/install
- https://developer.hashicorp.com/packer/integrations/digitalocean/digitalocean/latest/components/builder/digitalocean
- https://github.com/digitalocean/droplet-1-clicks
- https://bun.sh/docs
- https://letsencrypt.org
- https://certbot.eff.org/instructions?ws=nginx&os=snap

[1]: https://bun.sh
[2]: https://github.com/oven-sh/bun/releases
[3]: https://github.com/oven-sh/bun/blob/main/LICENSE
[4]: https://nginx.org
[5]: https://packages.ubuntu.com/focal/nginx
[6]: https://www.npmjs.com/policies/npm-license
[7]: https://certbot.eff.org/pages/about
[8]: https://github.com/certbot/certbot/releases
[9]: https://github.com/certbot/certbot/blob/master/LICENSE.txt

[21]: https://cloud.digitalocean.com/login
[22]: https://letsencrypt.org
