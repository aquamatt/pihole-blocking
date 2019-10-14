# Blocking porn with the Pi-hole

Having installed a Pi-hole I wanted to block not only ads, but sites that I wouldn't want my kids to stumble upon. Finding a big list of porn sites isn't easy but Chad Mayfield took on the task and published his work here: https://github.com/chadmayfield/my-pihole-blocklists

Unfortunately, the list is comprehensive but contains only TLDs (e.g. apornsite.com) and because the Pi-hole does matches on the complete domain (e.g. www.apornsite.com) it will fail to block the latter requests.

It's a complicated problem. Regex matches can wildcard block a domain, but I'm not sure that a *lot* of regexes will lead to very good performance, so I took the simple approach of creating a superset list with additional entries having "www." prepended to all the likely candidates in Chad Mayfield's list. This will also be far from perfect, but we're just after something a bit better than nothing.



## Regex list

Regexes are useful for blocking some obvious TLDs. Find a small set in https://raw.githubusercontent.com/aquamatt/pihole-blocking/master/lists/regex.list to add to your list. The Pi-hole UI doesn't allow you to enter wildcards for a TLD, so just append these to `/etc/pihole/regex.list` and restart the `pihole-FTL` service.

## To use

Download and run `build.sh`. This needs bash but in the `lists` directory here you will find a recent build which can be downloaded with https://raw.githubusercontent.com/aquamatt/pihole-blocking/master/lists/max_porn_block.list

This link can also be used directly in your Pi-hole configuration.

Thank you very much to @chadmayfield for his original work.

# Additional notes for Pi-hole users

## Pi-hole installation

- https://github.com/pi-hole/pi-hole/#one-step-automated-install

## Securing Pi-hole and using CloudflareD to give secure DNS requests

- https://docs.pi-hole.net/guides/dns-over-https/
- https://scotthelme.co.uk/securing-dns-across-all-of-my-devices-with-pihole-dns-over-https-1-1-1-1/

If cloudflared segfaults, you can try stubby:

- https://www.reddit.com/r/pihole/comments/7oyh9m/guide_how_to_use_pihole_with_stubby/

### Stubby and 1.1.1.1
The SHA256 hash of the 1.1.1.1 TLS certificate regularly changes (ie the cert
is rotated). Given that this needs to go into the stubby configuration it will
result in a failure whenever the cert is changed. The relevant configuration
section in `/etc/stubby.yml` is:

```
  - address_data: 1.1.1.1
    tls_auth_name: "cloudflare-dns.com"
    tls_pubkey_pinset:
      - digest: "sha256"
        value: V6zes8hHBVwUECsHf7uV5xGM7dj3uMXIS9//7qC8+jU=
```

The correct value for `value` can be found with OpenSSL tools:

```
$ echo | openssl s_client -connect '1.1.1.1:853' 2>/dev/null | \
  openssl x509 -pubkey -noout | \
  openssl pkey -pubin -outform der | \
  openssl dgst -sha256 -binary | \
  openssl enc -base64
```

## DNS block lists
- https://firebog.net
- https://github.com/topics/pihole-blocklists
- https://www.iblocklist.com/lists?category=general

Blog on generating a porn block list: https://chadmayfield.com/2017/06/29/blocking-porn-with-pihole/


# Whitelists
 `whitelist.txt` contains some whitelisted domains. These may be of more use to
me than you but certain sites, such as a homework site for kids, use these
URLs legitimately. Unfortunately some CDN edge domains such as Cloudfront
domains may be blacklisted because they have been involved in ad serving, but
they can, of course, also be used for other things, or re-allocated.
