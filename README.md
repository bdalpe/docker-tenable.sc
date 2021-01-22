Tenable.sc Docker Container
===

Run Tenable.sc in a Docker container! I needed to run Tenable.sc on my laptop for demos and to have a lab environment for reference. Since I couldn't find anything already created, I'm releasing my work back to the open source community.

Two sample `docker-compose` files are included. `docker-compose.yml` includes a Nessus scanner (a requirement to run Tenable.sc) using the image from [https://github.com/SteveMcGrath/docker-nessus_scanner](https://github.com/SteveMcGrath/docker-nessus_scanner). The `docker-compose.sc.yml` includes only Tenable.sc assuming you already have a Nessus scanner setup somewhere on your network or are using a hybrid deployment with Tenable.io.

### Usage

```
docker-compose up
```

or

```
docker-compose -f docker-compose.sc.yml up
```

### Architecture
1. Package management for Tenable.sc is handled through the Tenable repo.
2. S6 overlay handles process supervision for `httpd` and PHP `Jobd.php` files.
3. Tenable.sc files are installed to the `/opt/sc` volume on initial container start or if the `INSTALL` environment variable is set to any value.

### Upgrading Tenable.sc
To upgrade the container, add the following flags to the `docker-compose.yml` file under the `tenablesc` service:

	environment:
	 - INSTALL=yes
	 - SC_VER=5.17.0-el7

The `SC_VER` environment variable should match the package versions listed here: [https://www.tenable.com/downloads/tenable-sc](https://www.tenable.com/downloads/tenable-sc).

### License
Released under MIT License. No support or endorsement is provided by Tenable for this product.