# groles

Search and browse GCP roles in your terminal. Because Google's [IAM basic and predefined
roles reference](https://cloud.google.com/iam/docs/understanding-roles) is one of the
more painful websites to use on the web.

---

**UPDATE:** Literally _as I was actively working on making this releasable as a useful
project_, Google went and did a good (frustrating?) thing: **They made their permissions
and roles references not suck anymore!** Well I guess this project is obsolete now.

Check it out for yourself: <https://cloud.google.com/iam/docs/roles-permissions>

---

![Screenshot](./screenshot.png)

## Installation

_For now, only Linux is supported. macOS compatibility PRs welcome!_

`groles` is just a script that uses:

* fzf <https://github.com/junegunn/fzf>
* bat <https://github.com/sharkdp/bat>
* jq <https://jqlang.org/>
* curl <https://curl.se/>

If you have these tools installed, just download `groles` from the [latest
release](https://github.com/pcrock-thmdo/groles/releases/latest) and run:

```bash
chmod +x ./groles
```

Ideally put `groles` somewhere on your `$PATH`.

## Usage

Just run `groles`.

On the first run, `groles` will automatically download the latest GCP role data to your
machine. Later, if you want to make sure you have the latest role data available, you
can run `groles --update`.
