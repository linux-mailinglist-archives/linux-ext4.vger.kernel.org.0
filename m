Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F8F057E314
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 16:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232365AbiGVOc6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 10:32:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231199AbiGVOc5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 10:32:57 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4D233E02;
        Fri, 22 Jul 2022 07:32:55 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id v67-20020a1cac46000000b003a1888b9d36so5331933wme.0;
        Fri, 22 Jul 2022 07:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=bUUKfZnm+sfSFpwslLApLGpMR3Bi1CljFf1FD/rGqD4=;
        b=ppULBiMVNialhOg93bbj4I2VnAMjRAbYh6uZOuMQ/8X+PGsxqTwnkgiQhJ9yGDauI5
         b0vkSz5XIFs8a6Ncqwfmggq2urLqcpViTE9hNh/r/8+VtrbvC0zwqnRc17Dt/Ahgczel
         VxXSJ/tekswoT3ibOSdgyIgd5+Z+V2cECuYsVSFygRZKZkturhJMEHV7k/A2wevDLfYH
         Cd3dBc19U6cJCnXZuI8sQglCmjr+WRVObiypl3u7pVn9h9azAl8OJxCNQuEQc21TXqxv
         bFXdZXDyw/4djQXUPyjcge/hJEiX8zjjyB4awnIfE2XQWuLyI3aOsrJWuO4Vtp+d1buh
         1a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=bUUKfZnm+sfSFpwslLApLGpMR3Bi1CljFf1FD/rGqD4=;
        b=zWdg4pGNLBfWs3RCeab5C7E4TQvrnsgv/p2U6u65BCWRz5PNJ4Ofshse9nj8DEErdZ
         HLwA4xHrgSmChrB6QuSFew4AS2LufLaILLJYKHAjS6oweC+XKauMy23LHeVwaKMEED3v
         g6kebSvVVl6qyqx5cz/oHv47oYhhh03aRrpz2xQk7GqSa1vPqysdBANqMfibO1DYIQI3
         GXEpQuCPtItXeweN4H4Pjg0ccDKkjXmkeXwW2szJzQAuIsKLg+1a4K9eA4zvlos9FEYI
         8k1OXIs4kZd4huUA6hl3bBIxOoaFktr0T/BXn4cg9sro+J3N/FVxFZRj1lU3H4Dwwgrx
         2hAw==
X-Gm-Message-State: AJIora87f5cs/CTgly8+ptx2gMsR7htFoYWgtsqYZcuyNJeUupr7+qxg
        nCkzCHyogOhYh+4Q3oNDrzkhz3snalM=
X-Google-Smtp-Source: AGRyM1t8a3AbR08Nl16IYxuvL3FXkBqg87CaydO+jMG0yJMRFxHOSOqKRWlzpBvpJdtHGLE4R2TrTA==
X-Received: by 2002:a1c:1901:0:b0:3a3:1be3:4df2 with SMTP id 1-20020a1c1901000000b003a31be34df2mr32822wmz.146.1658500374273;
        Fri, 22 Jul 2022 07:32:54 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id k1-20020adff5c1000000b0020fff0ea0a3sm4524579wrp.116.2022.07.22.07.32.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 07:32:53 -0700 (PDT)
Message-ID: <c1bcaed9-0711-83de-f823-c38ba0302b4b@gmail.com>
Date:   Fri, 22 Jul 2022 16:32:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
Content-Language: en-US
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Jeremy Bongio <bongiojp@gmail.com>, linux-ext4@vger.kernel.org,
        linux-man@vger.kernel.org
References: <20220720234512.354076-1-bongiojp@gmail.com>
 <YtiZ+gOmOFTpiAjW@magnolia> <e503645b-e665-50c4-37a9-cdc8637ba1d8@gmail.com>
 <YtmXAyoF2PXstnLY@magnolia> <e1573002-7ea3-2636-b2d2-331767a5622f@gmail.com>
 <YtqsTM2qXyR+dlz6@mit.edu>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <YtqsTM2qXyR+dlz6@mit.edu>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------lX00bHCeg4TyjXo5vdNrux07"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------lX00bHCeg4TyjXo5vdNrux07
Content-Type: multipart/mixed; boundary="------------UD214GjqNs1sWe8AqEo9ZX60";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: "Darrick J. Wong" <djwong@kernel.org>, Jeremy Bongio
 <bongiojp@gmail.com>, linux-ext4@vger.kernel.org, linux-man@vger.kernel.org
Message-ID: <c1bcaed9-0711-83de-f823-c38ba0302b4b@gmail.com>
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
References: <20220720234512.354076-1-bongiojp@gmail.com>
 <YtiZ+gOmOFTpiAjW@magnolia> <e503645b-e665-50c4-37a9-cdc8637ba1d8@gmail.com>
 <YtmXAyoF2PXstnLY@magnolia> <e1573002-7ea3-2636-b2d2-331767a5622f@gmail.com>
 <YtqsTM2qXyR+dlz6@mit.edu>
In-Reply-To: <YtqsTM2qXyR+dlz6@mit.edu>

--------------UD214GjqNs1sWe8AqEo9ZX60
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgVGVkLA0KDQpPbiA3LzIyLzIyIDE1OjU1LCBUaGVvZG9yZSBUcydvIHdyb3RlOg0KPiBP
biBGcmksIEp1bCAyMiwgMjAyMiBhdCAxMjowMzoyM1BNICswMjAwLCBBbGVqYW5kcm8gQ29s
b21hciAobWFuLXBhZ2VzKSB3cm90ZToNCj4+PiBTRUUgQUxTTw0KPj4+IAlpb2N0bCgyKQ0K
Pj4+DQo+Pj4gYXQgdGhlIGVuZCBvZiBhbiBpb2N0bF9YWFggbWFucGFnZSBsaWtlIHRoaXMg
b25lLg0KPj4+DQo+Pg0KPj4gT2theS4gIFRoZW4gbWF5IEkgYXNrIGZvciBhbiBFWEFNUExF
UyBzZWN0aW9uIHdpdGggYSBwcm9ncmFtIHRoYXQNCj4+IHVuZXF1aXZvY2FsbHkgc2hvd3Mg
dXNlcnMgaG93IHRvIHVzZSBpdD8NCj4gDQo+IEknbGwgbm90ZSB0aGF0IGV4aXN0aW5nIGlv
Y3RsIG1hbiBwYWdlcyBkb24ndCBoYXZlIGFuIGV4cGxpY2l0DQo+IHN0YXRlbWVudCB0aGF0
IGEgbGliYyBpcyByZXF1aXJlZCAtLS0gbm9yIGRvIHdlIGRvIHRoaXMgZm9yIG9wZW4oMiks
DQo+IHN0YXQoMiksIGV0Yy4NCg0KVGhhdCdzIGJlY2F1c2UgdGhlcmUgaGFzbid0IGJlZW4g
YSBtYW4tcGFnZXMgcmVsZWFzZSBpbiBhcm91bmQgYSB5ZWFyLg0KSWYgeW91IHNlZSB0aGUg
bWFuLXBhZ2VzIGdpdCByZXBvLCB5b3UnbGwgc2VlIHRoYXQgKGFsbW9zdCkgYWxsIG1hbiAN
CnBhZ2VzIGluIHNlY3Rpb25zIDIgYW5kIDMgaGF2ZSBhIG5ldyBMSUJSQVJZIHNlY3Rpb24u
DQoNCmlvY3RsKDIpIHBhZ2VzIG5vdyBoYXZlIHRoaXMgTElCUkFSWSBzZWN0aW9uOg0KPGh0
dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9kb2NzL21hbi1wYWdlcy9tYW4tcGFnZXMu
Z2l0L3RyZWUvbWFuMi9pb2N0bF9mYXQuMj4NCg0KVGhpcyB3YXMgYmFzZWQgb24gRnJlZUJT
RCdzIG1hbiBwYWdlczoNCjxodHRwczovL3d3dy5mcmVlYnNkLm9yZy9jZ2kvbWFuLmNnaT9x
dWVyeT1zdGF0JmFwcm9wb3M9MCZzZWt0aW9uPTImbWFucGF0aD1GcmVlQlNEKzEzLjEtUkVM
RUFTRSthbmQrUG9ydHMmYXJjaD1kZWZhdWx0JmZvcm1hdD1odG1sPg0KDQo+ICAgKEFuZCB0
aGF0J3MgZXNwZWNpYWxseSBuZWNlc3NhcnkgZm9yIHN0YXQoMiksIEJUVyEpDQoNCnN0YXQo
Mikgbm93IHNheXMgDQo8aHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2RvY3MvbWFu
LXBhZ2VzL21hbi1wYWdlcy5naXQvdHJlZS9tYW4yL3N0YXQuMiNuMjI+Og0KDQpMSUJSQVJZ
DQogICAgICAgIFN0YW5kYXJkIEMgbGlicmFyeSAobGliYywgLWxjKQ0KDQoNCklmIHlvdSB3
b3VsZCBsaWtlIHRvIGltcHJvdmUgb24gdGhhdCwgSSdtIG9wZW4gdG8gaWRlYXMsIG9yIHBh
dGNoZXMgZnJvbSANCnByb2dyYW1tZXJzIHdobyBrbm93IHRoZSBzeXNjYWxscyBtdWNoIGJl
dHRlciB0aGFuIEkgZG8uDQoNCj4gDQo+IE1hbnkgb2YgdGhlIGlvY3RsIG1hbiBwYWdlcyAo
b3Igb3RoZXIgc3lzdGVtIGNhbGwgbWFuIHBhZ2VzLCBmb3IgdGhhdA0KPiBtYXR0ZXIpIGFs
c28gZG9uJ3QgaGF2ZSBhbiBFWEFNUExFUyBzZWN0aW9uLCBlaXRoZXIuDQo+IA0KPiBQZXJo
YXBzIGl0IHdvdWxkIGJlIHVzZWZ1bCB0byBoYXZlIGEgZGlzY3Vzc2lvbiBvdmVyIHdoYXQg
dGhlDQo+IHN0YW5kYXJkcyBhcmUgZm9yIG1hbiBwYWdlcyBpbiBzZWN0aW9uIDIsIGFuZCB3
aGVuIHdlIG5lZWQgdG8gc3RhdGUNCj4gdGhpbmdzIHRoYXQgc2VlbSB0byBiZSByYXRoZXIg
b2J2aW91cyAobGlrZSAieW91IG11c3QgaGF2ZSBhIEMNCj4gbGlicmFyeSIpIGFuZCB3aGVu
IHRoZXJlIHNob3VsZCBiZSB0aGluZ3MgbGlrZSBhbiBFWEFNUExFUyBzZWN0aW9uPw0KDQpO
b3cgdGhhdCB5b3Ugc2F5IGl0LCBJIGZvcmdvdCB0byBkb2N1bWVudCB0aGUgTElCUkFSWSBz
ZWN0aW9uIGluIA0KbWFuLXBhZ2VzKDcpLiAgVGhlcmUncyBzb21ldGhpbmcgYWJvdXQgaXQs
IGJ1dCBJIGZvcmdvdCB0byBhZGQgYSANCnBhcmFncmFwaCBkZXNjcmliaW5nIGl0IGluIGRl
dGFpbC4NCg0KUmVnYXJkaW5nIHRoZSBFWEFNUExFUyBzZWN0aW9uLCBldmVyeSBwYWdlIGlu
IG1hbjIgb3IgbWFuMyBzaG91bGQgaGF2ZSANCmFuIGV4YW1wbGUgcHJvZ3JhbSwgSU1PLiAg
Q29uc2lkZXIgdGhhdCB0aGVyZSBhcmUgcHJvZ3JhbW1lcnMgdGhhdCBtYXkgDQpmaW5kIGl0
IGVhc2llciB0byBsZWFybiBhIGZ1bmN0aW9uIGJ5IGV4cGVyaW1lbnRpbmcgd2l0aCBhIHdv
cmtpbmcgDQpleGFtcGxlIG9mIEMgY29kZSwgcmF0aGVyIHRoYW4gYSBkZW5zZSB0ZXh0dWFs
IGRlc2NyaXB0aW9uIGluIGEgbGFuZ3VhZ2UgDQp0aGF0IG1heSBub3QgYmUgbmF0aXZlIHRv
IHRoZSBwcm9ncmFtbWVyLg0KDQpUaGVyZSBhcmUgbWFueSBwYWdlcyB0aGF0IGxhY2sgZXhh
bXBsZXMsIGJ1dCB0aGF0J3Mgbm90IHNvbWV0aGluZyBJIA0Kd291bGQgY29uc2lkZXIgYSBn
b29kIHRoaW5nLg0KDQo+IA0KPiBTb21lIHRoZSBzdWdnZXN0aW9ucyB5b3UgYXJlIG1ha2lu
ZyBkb24ndCBzZWVtIHRvIGJlIGFkaGVyZWQgdG8gYnkNCj4gdGhlIGV4aXN0aW5nIG1hbiBw
YWdlcywgYW5kIG1vcmUgdGV4dCBpcyBub3QgYWx3YXlzIGJldHRlci4NCg0KVGhlIG5leHQg
cmVsZWFzZSBvZiB0aGUgbWFuLXBhZ2VzIGlzIGNlcnRhaW5seSBnb2luZyB0byBiZSBhbiBp
bXBvcnRhbnQgDQpvbmUuICBJdCBtYXkgYmUgaGF0ZWQgYnkgbWFueSwgbG92ZWQgYnkgbWFu
eSBvdGhlcnMuICBJIGhvcGUgb3ZlcmFsbCBJIA0KZGlkIGEgc2lnbmlmaWNhbnQgaW1wcm92
ZW1lbnQgaW4gYm90aCBpbXByb3ZpbmcgdGhlIHRyYW5zbWlzc2lvbiBvZiANCmluZm9ybWF0
aW9uIGFuZCBzaW1wbGlmeWluZyBtYWludGVuYW5jZS4NCg0KPiANCj4gaHR0cHM6Ly93d3cu
bnByLm9yZy9zZWN0aW9ucy8xMy43LzIwMTQvMDIvMDMvMjcwNjgwMzA0L3RoaXMtY291bGQt
aGF2ZS1iZWVuLXNob3J0ZXINCg0KU29ycnksIGJ1dCBJJ20gbm90IGFibGUgdG8gcmVhZCB0
aGF0IHBhZ2UuICBJdCBwcm9tcHRzIHRoZSB1c3VhbCBHUERSIA0Kbm90aWNlLCBhbmQgZG9l
c24ndCBnaXZlIG1lIHRoZSBvcHRpb24gdG8gcmVqZWN0IGNvb2tpZXMgKG9ubHkgYWNjZXB0
KS4NCg0KQW55d2F5LCBJIGd1ZXNzIHdoYXQgaXQgc2F5cy4gIEkgaG9wZSBJIHdhc24ndCB0
b28gbXVjaCB2ZXJib3NlIHdpdGggbXkgDQptYW55IGNoYW5nZXMuDQoNCkNoZWVycywNCg0K
QWxleA0KDQotLSANCkFsZWphbmRybyBDb2xvbWFyDQo8aHR0cDovL3d3dy5hbGVqYW5kcm8t
Y29sb21hci5lcy8+DQo=

--------------UD214GjqNs1sWe8AqEo9ZX60--

--------------lX00bHCeg4TyjXo5vdNrux07
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmLatQ0ACgkQnowa+77/
2zKXsw//WdYukchpV5toAKPNRzjsyJyJxG1+4VvBxWP+F6Gg/WTLF1ijGd1pOOkQ
HqmwFD3TQOuL2JsA0On4Ub6FZD7zyu5x3M4DNGmlC9m8tNqHhOB6uHMb4X6f/F2H
rhaDOsH7Ec1CYIFoFA3JoueNKByvkdgtItNDzbsTr8IoCXvrijijw/XQZmK2OrB2
HDjxy7Icna5HRJJryjw8JK51tUm9QyiK4K4N1ZzW3nL37kUHWFTZPs7BmrbgYa0/
dV6f3zohQ7PGtQ9qs+zoyLMdinLNA6C3Hk6MTAGcFhoBYqQZhjI459IZFEw69C/5
d9N1bDKrPvV/o4QrC3DQUU0zCca1Qu+Jx0ey3L1aYblA/6x31rMo4q2NlcCnVoZh
9NHekk/0eSye4otjoC8r4iZ9CGG2sVB1AitRhCNs7LE7SWfscUIDXbZcRJxaraA/
KnUeKIO/Wbzim2B13UcQkLhn6ntFYzM0Z30BS8pDQsXJJ+OnkB2t2usltzF9Efoe
CIknFCzGK0vQyF8Di4wH2JYNrTfcHg6M803d76LW/VfmO41Rja8Ltvz73VO3nAgA
4J6jIgQtEeQYOjmelH6Vp/el34qzmA2rA6wdPn3XEjFvnROG5MDZhbSlx2eYmf0B
yXYPsYZ8NvnwXWCBV/EKwtWj42uvbVU0P7gm1dOEeMBIcbxyb0U=
=wr4Q
-----END PGP SIGNATURE-----

--------------lX00bHCeg4TyjXo5vdNrux07--
