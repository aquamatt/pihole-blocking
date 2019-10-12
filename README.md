# Blocking porn with the Pi-hole

Having installed a Pi-hole I wanted to block not only ads, but sites that I wouldn't want my kids to stumble upon. Finding a big list of porn sites isn't easy but Chad Mayfield took on the task and published his work here: https://github.com/chadmayfield/my-pihole-blocklists

Unfortunately, the list is comprehensive but contains only TLDs (e.g. apornsite.com) and because the Pi-hole does matches on the complete domain (e.g. www.apornsite.com) it will fail to block the latter requests.

It's a complicated problem. Regex matches can wildcard block a domain, but I'm not sure that a *lot* of regexes will lead to very good performance, so I took the simple approach of creating a superset list with additional entries having "www." prepended to all the likely candidates in Chad Mayfield's list. This will also be far from perfect, but we're just after something a bit better than nothing.



## To use

Download and run `build.sh`. This needs bash but in the `lists` directory here you will find a recent build which can be downloaded with https://raw.githubusercontent.com/aquamatt/pihole-blocking/master/lists/max_porn_block.list

This link can also be used directly in your Pi-hole configuration.



Thank you very much to @chadmayfield for his original work.



# Additional notes for Pi-hole users

## Pi-hole installation

https://github.com/pi-hole/pi-hole/#one-step-automated-install

## Securing Pi-hole and using CloudflareD to give secure DNS requests

https://docs.pi-hole.net/guides/dns-over-https/
https://scotthelme.co.uk/securing-dns-across-all-of-my-devices-with-pihole-dns-over-https-1-1-1-1/

If cloudflared segfaults, you can try stubby:

https://www.reddit.com/r/pihole/comments/7oyh9m/guide_how_to_use_pihole_with_stubby/

## DNS block lists
https://www.iblocklist.com/lists?category=general
https://firebog.net

Blog on generating a porn block list: https://chadmayfield.com/2017/06/29/blocking-porn-with-pihole/