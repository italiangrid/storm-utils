
## StoRM space reporting scripts

### storm-get-space-aliases

Usage:

```
storm-get-space-aliases.sh [-u <db-username>] [-p <db-password>]
```

Example:

```
$ sh storm-get-space-tokens.sh -u storm -p storm
DTEAM_TOKEN
TAPE_TOKEN
TESTVO_TOKEN
```

### storm-update-used-space

Usage:

```
storm-update-used-space.sh [-u <db-username>] [-p <db-password>] [-a <spacetoken-alias>] [-s <used-space-size>]
```

Example:

```bash
$ sh storm-update-used-space.sh -u storm -p storm -a TESTVO_TOKEN -s 52080
Getting space info for 'TESTVO_TOKEN' ...
  TOTAL_SIZE=4000000000, FREE_SIZE=3999957920, USED_SIZE=42080
Setting new free size as 3999947920 and new used space as 52080 ...
  Update query exited with 0
```
