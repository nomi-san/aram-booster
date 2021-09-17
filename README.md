## This method got patched, we'll back soon!
```
01 Jul 2021: Fixed at server side.
```

TL;DR

> Since the release of LCU, the first method was making a POST request to purchase skin BOOST. No consuming any RP, except confirming after clicked the BOOST button.

> Since v11.4, Riot added RP checking on this API. The second method (is used in this repo) invokes directly to RTMP to activate skin BOOST. And now, Riot adds RP checking on RTMP (server side) and some stuff when invoking RTMP methods.

# aram-booster

Active ARAM BOOST without RP.

<p align="center">
  <img alt="" src="https://nomi.dev/img/posts/aram-booster/demo.gif" />
</p>

## Usage

**Requisites**

- Make sure **curl** is installed, only MSVC version is expected
- If not, you can extract curl.exe in **curl.zip** and copy to C:\Windows\System32\
- Make sure League Client is opened and you are in ARAM's champion select

**Step 1** - Run **aram-booster.bat** as Admin 👍

**Step 2** - Enjoy 😎

## More

In this repo, we have some other implementations:
- [/autoit](https://github.com/nomi-san/aram-booster/tree/main/autoit) - written in AutoIt with the same feature
- [/nodejs](https://github.com/nomi-san/aram-booster/tree/main/nodejs) - written in Node JS for both Windows and OS X, make everything is automatic
- [~~/csharp~~](https://github.com/nomi-san/aram-booster/tree/main/csharp) - todo
