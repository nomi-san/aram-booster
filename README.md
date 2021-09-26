## New method available!

Here is some information that we can reveal about it:
- ARAM BOOST is a purchase on the store
- Any HTTP debugger will break down accessing to the store
- The previous RTMP call needs a token
- League session has 1 day expiration
- Some non-refundable items can be refunded without refund token, but Garena...
- FREE BOOST literally, if you've not enough RP

> This is the ONLY and the LAST method, can be patched anytime 😪

> Opps, it's not here 😪

## Previous method got patched!
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

1. Make sure you're in **ARAM**/**ARURF** champion select 👍
2. Run **aram-booster.bat** as Admin 😎

<p align="center">
  <img alt="" src="https://nomi.dev/img/posts/aram-booster/demo.gif" />
</p>
