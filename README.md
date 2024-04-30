# fly-stream

This repo is intended to allow you to spin up a fly.io machine that allows you
to stream to it (via OBS for example) and share the stream in VRChat **for free**
and with _very low latency_

# IMPORTANT: DO THIS FIRST

Generate a UUID, if you're on Linux or Mac, this command should work fine in a
terminal:

`uuidgen | tr '[[:upper:]]' '[[:lower:]]'`

If it didn't work, you can use this site to make one
https://www.uuidgenerator.net/

Now take your UUID and edit `fly.toml` and replace this line:

```toml
[build.args]
  STREAMPASS = "vrc-fly" # CHANGE THIS!!!
```

Like this:

```toml
[build.args]
  STREAMPASS = "4eb62a63-8601-437c-9721-7572aced5d71"
```

This is like your stream key on YouTube or Twitch -
**keep it secret and do not share it!** If you do not change it, other people
who figure out that you used this guide can use your instance to stream,
potentially costing you money.

---

# Steps to set up

- First, install and set up `flyctl` - https://fly.io/docs/hands-on/install-flyctl/

- Now, sign up/in https://fly.io/docs/hands-on/sign-up-sign-in/

- Finally, launch this app

`flyctl launch --ha=false`

(the `--ha=false` will prevent fly.io from launching multiple machines - we only
need one)

---

- Answer `Would you like to copy its configuration to the new app?` with `Yes`

- Answer `Do you want to tweak these settings before proceeding?` with `No`

- Answer `Would you like to allocate dedicated ipv4 and ipv6 addresses now?` with `Yes`

---

Eventually you should see a line like this

```
Allocated dedicated ipv4: 169.155.59.256
```

Take note of the address after `ipv4:`, you'll need this later

---

# Configuring OBS

Open OBS and go to `Settings -> Output`. then click ->`Recording`<- (we need to use
this tab because we're using some custom functionality)

- File path or URL: `rtsp://stream:vrc-fly@[the IP address from before]/live`
  (replace `vrc-fly` with your UUID)

- Container Format: `rtsp`

- Video Bitrate: Up to you, but I recommend `2500` or `3000` for 1080p. The higher
  the bitrate, the quicker you may use up the free quota

- Keyframe interval (frames): `30`

- Video Encoder: `mpeg4`

- Video Encoder Settings: `br=0`

- Audio Bitrate: `128 Kbps` (you can increase this but the difference may not be
  noticeable)

- Audio Encoder: `aac`

When you stream, click `Start Recording`, **not Start Streaming**

---

# Opening in VRChat

In the video player URL, put in `rtspt://[the IP address from before]/live`.
The delay I had was less than a half a second.

---

# (Optional) DNS

If you own a domain or have an account at a Dynamic DNS provider, you can
set up a human-readable domain name so you don't have to type in the IP address
every time. While this is out of the scope of this guide, you'll want to create
a DNS A record with the value for the record being the IP address from fly.io.
https://noip.com is one free dynamic DNS provider - they let you choose the
suffix among domains they own such as `ddns.net` and `hopto.org`.

---

# Removing all resources

`flyctl apps destroy vr-stream`

---

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
