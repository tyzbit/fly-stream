# fly-stream

This repo is intended to allow you to spin up a fly.io machine that allows you
to stream to it (via OBS for example) and share the stream in-game **for free**

# IMPORTANT: DO THIS FIRST

Generate a UUID, if you're on Linux or Mac, this command should work fine in a
terminal:

`uuidgen | tr '[[:upper:]]' '[[:lower:]]'`

If it didn't work, you can use this site to make one
https://www.uuidgenerator.net/

Now take your UUID and edit `fly.toml` and replace this line:

```toml
[build.args]
  ENDPOINT = "vrc-fly" # CHANGE THIS!!!
```

Like this:

```toml
[build.args]
  ENDPOINT = "4eb62a63-8601-437c-9721-7572aced5d71"
```

This is like your stream key on YouTube or Twitch -
**keep it secret and do not share it!**. If you do not change it, other people
who figure out that you used this guide can use your instance to stream,
potentially costing you money.

# Steps to set up

First, install and set up `flyctl` - https://fly.io/docs/hands-on/install-flyctl/

Now, sign up/in https://fly.io/docs/hands-on/sign-up-sign-in/

Finally, launch this app

`flyctl launch --ha=false`

(the `--ha=false` will prevent fly.io from launching multiple machines)

Answer `Would you like to copy its configuration to the new app?` with `Yes`

Answer `Do you want to tweak these settings before proceeding?` with `No`

Answer `Would you like to allocate dedicated ipv4 and ipv6 addresses now?` with `Yes`

Eventually you should see a line like this

```
Allocated dedicated ipv4: 169.155.59.246
```

Save the `ipv4` address

# Configuring OBS

Open OBS and go to `Settings -> Stream`. Select `Custom` and put in this info

Server: `rtmp://169.155.59.246/vrc-fly` (replace `vrc-fly` with your UUID)
Stream Key: `vrc`

# Removing all resources

`flyctl apps destroy vr-stream`

# Is this really free?

You can use it a moderate amount and it should be free. Fly.io doesn't charge
if your bill is below $5/mo and you get 160GB of outbound traffic. Doing some
back-of-the-napkin math, if you streamed at 3000 Mpbs that would be
4 hours of streaming every day of the month **for one viewer**. Every additional
viewer would halve that amount of time. In addition, at $0.02 per GB, you can
use 250GB of _additional_ data before you use more than $5/mo and fly.io would
charge you.

Unless you stream movies to a lot of people every day, I think this will still
be no cost for moderate usage.
