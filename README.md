# Sample integrations for MVISION EDR activity feed

This is a sandbox for some integrations with MVISION EDR's activity feed.

## The Hive

You can try this integration in two ways: 1) launching a The Hive instace with the included `docker-compose.yml` file, or 2) with an existing The Hive deployment.

In both cases, you need to create a file in the same folder of the `docker-compose.yml` called `.credentials.json`, and insert your MVISION EDR account information there:

```json
{
    "username": "me@mycompany.com",
    "password": "m7p5ssw0rD"
}
```

You also need to have `docker` and `docker-compose` installed.


### All-in-one

This options executes The Hive (including Cortex and Elasticsearch) locally on your docker host. In order for Elasticsearch to run properly, make sure you increase the limit on nmap count, as follows:

```
sysctl -w vm.max_map_count=262144
```

Note this will not survive a reboot, so you can also change this on `/etc/sysctl.conf` (For more details, see: https://www.elastic.co/guide/en/elasticsearch/reference/current/vm-max-map-count.html)

After this setup, follow the next steps:
* Run `docker-compose build` in order to build the `feed` image. You only need to do this once, or after changing the contents of the Dockerfile or associated files
* Run `docker-compose up -d elasticsearch cortex thehive`. This will only start The Hive.
* Navigate to the The Hive UI (e.g., http://localhost:9000) and complete the setup process by creating an account. Also navigate to the user management page, and create an API key for the new user
* Modify the `docker-compose.yml` file, and add the configuration values from the previous step on `hive_user=...` and `hive_key=...`
* Run `docker-compose up -d feed`

You can now monitor the feed by running `docker-compose logs -f feed`. You can log into your MVISION EDR account, and create a sample investigation case in https://ui.soc.mcafee.com/#/investigations, and a new case should be created in the The Hive UI. Modifying `priority` and `status` on MVISION EDR will also sync back to The Hive.

### Using an existing The Hive deployment

After this setup, follow the next steps:
* Run `docker-compose build` in order to build the `feed` image. You only need to do this once, or after changing the contents of the Dockerfile or associated files
* Create an API key for a user (or create a new one) on your The Hive instance
* Modify the `docker-compose.yml` file, and add the configuration values from the previous step on `hive_user=...` and `hive_key=...`. You'll also need to change the value in `hive_url=...` to point to your The Hive instance.
* Run `docker-compose up -d feed`

This will only run the activity feed. You can now monitor the feed by running `docker-compose logs -f feed`. Create a case in MVISION EDR (same as "all-in-one" alternative)

### Teardown

You can stop the containers by simply running `docker-compose down -v`

### Limitations

See open issues for current limitations
