## This method got patched, we'll back soon!
```
01 Jul 2021: Fixed at server side.
```

TL;DR

> Since the release of LCU, the first method was making a POST request to purchase skin BOOST. No consuming any RP, except confirming after clicked the BOOST button.

> Since v11.4, Riot added RP checking on this API. The second method (is used in this repo) invokes directly to RTMP to activate skin BOOST. And now, Riot adds RP checking on RTMP (server side) and some stuff when invoking RTMP methods.

<details>
  <summary><strong>/lol-lobby-team-builder/champ-select/v1/team-boost/purchase</strong> flow</summary>
  <pre>
1. Check current RP amount
  1.1 Return if not enough
2. Pay RP
3. Invoke lcdsServiceProxy.call(uuid, "teambuilder-draft", "activateBattleBoostV1", "")
</pre>
</details>

# aram-booster

Activate ARAM/ARURF skin BOOST without consuming any RP.

<p align="center">
  <img alt="" src="https://nomi.dev/img/posts/aram-booster/demo.gif" />
</p>

## Usage

Make sure League Client is opened and you are in ARAM/ARURF champion select.

**Step 1** - Run **aram-booster.bat** as Admin 👍

**Step 2** - Enjoy 😎

## More

In this repo, we have some other implementations:
- [/autoit](https://github.com/nomi-san/aram-booster/tree/main/autoit) - written in AutoIt with the same feature
- [/nodejs](https://github.com/nomi-san/aram-booster/tree/main/nodejs) - written in Node JS for both Windows and OS X, make everything is automatic
- [~~/csharp~~](https://github.com/nomi-san/aram-booster/tree/main/csharp) - todo
