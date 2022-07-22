Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A00A757E64B
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Jul 2022 20:11:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236033AbiGVSLO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 22 Jul 2022 14:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232444AbiGVSLN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 22 Jul 2022 14:11:13 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E6DB6B27F;
        Fri, 22 Jul 2022 11:11:12 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u14-20020a05600c00ce00b003a323062569so2914128wmm.4;
        Fri, 22 Jul 2022 11:11:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to;
        bh=6bhINipkuISMye/v/enOK2bYVnVGplP4utVhoyD/Xq0=;
        b=JIYGndWXTy6DSmLZU8vix4fauYixYn/LSaITBbjwe8mV0VuV3uxoZUpMa5DTGLSJpR
         GfMyF4Eq4ZlBY7WD5gUnCVOJPxUy4hPPN+LJnEQAyRwmsBazKoSNCg0tjvxZBJGwhElz
         h68+lvIUbhF4lwO0PkBMwUBox/4iUhEl4uvea/I+aaO/iymKtabTp3bxG5OxRQ5b5PLr
         PcE4Tbfq3Hn87d6YAEU05yLKdLMpfr7ViKQCjirMWSurNUhiOY47ZDsQfmjEjccwLR6a
         dB9/WqhcQxAw0VSf6bH5y9pTB9PUEZLMZ5Eh9O9YGPS6d5v33GCmrF8Vq5phPFtMSSxr
         +4sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to;
        bh=6bhINipkuISMye/v/enOK2bYVnVGplP4utVhoyD/Xq0=;
        b=3An+7H0QYkRlF0aTDEdx7mVI1oDgR0XJvOol8pZlQwHlDq6CSMXpNgWyNqrx231iWz
         lKybAZHQUZYu7Zc0Mc2cIGFWvdV5ZFCgL4pWA/jwOgzljoH/3qEOKBEnWVVkErgsJau+
         BZVJ6n/yLd28cig0n30aCsjDcm7v+JtLv8M1KGsNfR92Q5sTFG9BUNVPDPhE3J7T7bKb
         BPhWD3z1Kpizqxe/neiSYi9VYQZ7qZm7eujtBUfTeHetuBsxjBQLM0eVE6I//ueQCnJT
         5BuXQtDwrVzka6rcOK7ALBqhOw3QV6hrWT7NJg0Z43b4Nw4HAriOLvG9sIB6VwPKE9GB
         iLcg==
X-Gm-Message-State: AJIora9qPmBENnoL7QA4T34lJkWIERm4BgMKRcwGdSkYI23IJ1tJUUSY
        3O8YyTDaZfgGzlWl3uELAy4=
X-Google-Smtp-Source: AGRyM1sed6IhPu/ANsspiDAdWReAVAKSw79KxbYqQ29xF2Lupj+DNDwVDUxuy+yf3rZo0zIPYa9Gxg==
X-Received: by 2002:a1c:f208:0:b0:3a2:dc06:f3fe with SMTP id s8-20020a1cf208000000b003a2dc06f3femr13315155wmc.119.1658513470977;
        Fri, 22 Jul 2022 11:11:10 -0700 (PDT)
Received: from [192.168.0.160] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id b6-20020a056000054600b0021badf3cb26sm6538301wrf.63.2022.07.22.11.11.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 11:11:10 -0700 (PDT)
Message-ID: <1266e2ec-2f26-b465-c1a8-3d4c7136a0f1@gmail.com>
Date:   Fri, 22 Jul 2022 20:11:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.0.2
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
Content-Language: en-US
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Theodore Ts'o <tytso@mit.edu>, Jeremy Bongio <bongiojp@gmail.com>,
        linux-ext4@vger.kernel.org, linux-man@vger.kernel.org
References: <20220720234512.354076-1-bongiojp@gmail.com>
 <YtiZ+gOmOFTpiAjW@magnolia> <e503645b-e665-50c4-37a9-cdc8637ba1d8@gmail.com>
 <YtmXAyoF2PXstnLY@magnolia> <e1573002-7ea3-2636-b2d2-331767a5622f@gmail.com>
 <YtqsTM2qXyR+dlz6@mit.edu> <c1bcaed9-0711-83de-f823-c38ba0302b4b@gmail.com>
 <YtriWvxMcNMUPBry@magnolia>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <YtriWvxMcNMUPBry@magnolia>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------kUGXG1KWt7yMUAl6tcXkTjQk"
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
--------------kUGXG1KWt7yMUAl6tcXkTjQk
Content-Type: multipart/mixed; boundary="------------0cX1IdPrN9OwH00kjO3bOpGa";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Theodore Ts'o <tytso@mit.edu>, Jeremy Bongio <bongiojp@gmail.com>,
 linux-ext4@vger.kernel.org, linux-man@vger.kernel.org
Message-ID: <1266e2ec-2f26-b465-c1a8-3d4c7136a0f1@gmail.com>
Subject: Re: [PATCH v2] Add manpage for get/set fsuuid ioctl for ext4
 filesystem.
References: <20220720234512.354076-1-bongiojp@gmail.com>
 <YtiZ+gOmOFTpiAjW@magnolia> <e503645b-e665-50c4-37a9-cdc8637ba1d8@gmail.com>
 <YtmXAyoF2PXstnLY@magnolia> <e1573002-7ea3-2636-b2d2-331767a5622f@gmail.com>
 <YtqsTM2qXyR+dlz6@mit.edu> <c1bcaed9-0711-83de-f823-c38ba0302b4b@gmail.com>
 <YtriWvxMcNMUPBry@magnolia>
In-Reply-To: <YtriWvxMcNMUPBry@magnolia>

--------------0cX1IdPrN9OwH00kjO3bOpGa
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

SGkgRGFycmljaywNCg0KT24gNy8yMi8yMiAxOTo0NiwgRGFycmljayBKLiBXb25nIHdyb3Rl
Og0KPj4gTm93IHRoYXQgeW91IHNheSBpdCwgSSBmb3Jnb3QgdG8gZG9jdW1lbnQgdGhlIExJ
QlJBUlkgc2VjdGlvbiBpbg0KPj4gbWFuLXBhZ2VzKDcpLiAgVGhlcmUncyBzb21ldGhpbmcg
YWJvdXQgaXQsIGJ1dCBJIGZvcmdvdCB0byBhZGQgYSBwYXJhZ3JhcGgNCj4+IGRlc2NyaWJp
bmcgaXQgaW4gZGV0YWlsLg0KPiANCj4gVGhhdCB3b3VsZCd2ZSBoZWxwZWQsIHNpbmNlIEkg
c2Nhbm5lZA0KPiBodHRwczovL21hbjcub3JnL2xpbnV4L21hbi1wYWdlcy9tYW43L21hbi1w
YWdlcy43Lmh0bWwNCj4gYW5kIGRpZG4ndCBzZWUgbXVjaCBhYm91dCB3aGF0IGdvZXMgaW4g
dGhpcyBzZWN0aW9uLi4uDQoNClRoZXNlIGNoYW5nZXMgaGF2ZSBiZWVuIGludHJvZHVjZWQg
YWZ0ZXIgdGhlIGxhc3QgcmVsZWFzZSB3YXMgbWFkZSwgc28gDQpldmVuIGlmIEkgaGFkIGRv
Y3VtZW50ZWQgaXQsIGl0IHdvdWxkbid0IGhhdmUgcmVhY2hlZCA8bWFuNy5vcmc+LiAgSSdk
IA0KcmVjb21tZW5kIHlvdSB0byBpbnN0YWxsIHRoZSBtYW4gcGFnZXMgZnJvbSBzb3VyY2Ug
KGBzdWRvIG1ha2UgaW5zdGFsbGApLg0KDQo+IA0KPj4gUmVnYXJkaW5nIHRoZSBFWEFNUExF
UyBzZWN0aW9uLCBldmVyeSBwYWdlIGluIG1hbjIgb3IgbWFuMyBzaG91bGQgaGF2ZSBhbg0K
Pj4gZXhhbXBsZSBwcm9ncmFtLCBJTU8uICBDb25zaWRlciB0aGF0IHRoZXJlIGFyZSBwcm9n
cmFtbWVycyB0aGF0IG1heSBmaW5kIGl0DQo+PiBlYXNpZXIgdG8gbGVhcm4gYSBmdW5jdGlv
biBieSBleHBlcmltZW50aW5nIHdpdGggYSB3b3JraW5nIGV4YW1wbGUgb2YgQw0KPj4gY29k
ZSwgcmF0aGVyIHRoYW4gYSBkZW5zZSB0ZXh0dWFsIGRlc2NyaXB0aW9uIGluIGEgbGFuZ3Vh
Z2UgdGhhdCBtYXkgbm90IGJlDQo+PiBuYXRpdmUgdG8gdGhlIHByb2dyYW1tZXIuDQo+IA0K
PiBGcmFua2x5IEknZCByYXRoZXIgcHVzaCBwZW9wbGUgdG8gaGF2ZSBleGFtcGxlIGNvZGUg
b3ZlciBkb2N1bWVudGluZw0KPiB0aGF0IHN0YW5kYXJkIEMgbGlicmFyeSBmdW5jdGlvbnMg
cmVxdWlyZSB0aGUgc3RhbmRhcmQgQyBsaWJyYXJ5LiA6KQ0KDQpBZ3JlZWQgOikNCg0KPiAN
Cj4gVGhhdCBzYWlkLCBJIGRvbid0IGFsd2F5cyBlbmpveSB0aGUgdGV4dGJvb2sgZXhhbXBs
ZXMgdGhhdCBoYXZlIGJlZW4NCj4gc2xpbW1lZCBkb3duIGZvciBtYW5wYWdlcyAtLSBJIHBy
ZWZlciBhIGxpbmsgdG8gYSByZWFsIGltcGxlbWVudGF0aW9uDQo+IGluIChzYXkpIHRoZSB0
ZXN0IHN1aXRlIHNvIHRoYXQgSSBjYW4gc2VlIGNvZGUgdGhhdCAob25lIHdvdWxkIGhvcGUp
DQo+IGV4ZXJjaXNlcyBhbGwgdGhlIGZ1bmN0aW9uYWxpdHkgZXhwb3NlZCB0aHJvdWdoIHRo
ZSBpbnRlcmZhY2UuDQo+IA0KPiBCdXQgSSBndWVzcyB0aGF0J3MgcmVhbGx5IHVwIHRvIHRo
ZSBtYW5wYWdlIGF1dGhvciB0byBkZWNpZGUuDQoNClRoZXkncmUgbm90IGV4Y2x1c2l2ZS4g
IEl0J3Mgd2VsY29tZSB0byBwb2ludCB0byBhIChzdGFibGUpIGxpbmsgc2hvd2luZyANCmEg
bW9yZSBjb21wbGV4IGV4YW1wbGUgYWZ0ZXIgc2hvd2luZyBhIHNpbXBsZSBleGFtcGxlIHRo
YXQgZml0cyB0aGUgcGFnZS4NCg0KPiANCj4+IFRoZXJlIGFyZSBtYW55IHBhZ2VzIHRoYXQg
bGFjayBleGFtcGxlcywgYnV0IHRoYXQncyBub3Qgc29tZXRoaW5nIEkgd291bGQNCj4+IGNv
bnNpZGVyIGEgZ29vZCB0aGluZy4NCj4+DQo+Pj4NCj4+PiBTb21lIHRoZSBzdWdnZXN0aW9u
cyB5b3UgYXJlIG1ha2luZyBkb24ndCBzZWVtIHRvIGJlIGFkaGVyZWQgdG8gYnkNCj4+PiB0
aGUgZXhpc3RpbmcgbWFuIHBhZ2VzLCBhbmQgbW9yZSB0ZXh0IGlzIG5vdCBhbHdheXMgYmV0
dGVyLg0KPj4NCj4+IFRoZSBuZXh0IHJlbGVhc2Ugb2YgdGhlIG1hbi1wYWdlcyBpcyBjZXJ0
YWlubHkgZ29pbmcgdG8gYmUgYW4gaW1wb3J0YW50IG9uZS4NCj4+IEl0IG1heSBiZSBoYXRl
ZCBieSBtYW55LCBsb3ZlZCBieSBtYW55IG90aGVycy4gIEkgaG9wZSBvdmVyYWxsIEkgZGlk
IGENCj4+IHNpZ25pZmljYW50IGltcHJvdmVtZW50IGluIGJvdGggaW1wcm92aW5nIHRoZSB0
cmFuc21pc3Npb24gb2YgaW5mb3JtYXRpb24NCj4+IGFuZCBzaW1wbGlmeWluZyBtYWludGVu
YW5jZS4NCj4gDQo+IEknbSBub3QgY29udmluY2VkIHRoYXQgaGF2aW5nIHRvIG9wZW4gKnR3
byogbWFucGFnZXMganVzdCB0byBmaWd1cmUgb3V0DQo+IGhvdyB0byBjYWxsIGFuIGlvY3Rs
IGlzIGdvaW5nIHRvIHNpbXBsaWZ5IG1haW50ZW5hbmNlIHVubGVzcyB0aGUgc3RydWN0DQo+
IGlzIHNoYXJlZCBhY3Jvc3MgbW9yZSB0aGFuIG9uZSBtYW5wYWdlLCBidXQgSSd2ZSBhbHJl
YWR5IG1hZGUgdGhhdA0KPiBwb2ludC4NCg0KV2VsbCwgSSdkIHNheSBpdCBzaW1wbGlmaWVz
IG1haW50ZW5hbmNlIGluIHRoZSBjYXNlIHRoYXQgYW5vdGhlciBwYWdlIA0KYWRkcyBpbmZv
cm1hdGlvbiBhYm91dCB0aGlzIHR5cGU6IHdoZW4gSSByZWNlaXZlIGEgcGF0Y2gsIEknbSBu
b3QgDQpncmVwcGluZyBhbGwgb2YgdGhlIHBhZ2VzIHRvIHNlZSBpZiBvbmUgYWxyZWFkeSBk
b2N1bWVudHMgYSB0eXBlLCB0byANCmRlY2lkZSB0byBtb3ZlIGl0IHRvIGEgc2VwYXJhdGUg
cGFnZS4gIEl0J3MgbGlrZWx5IHRvIGJlIGZvcmdvdHRlbiwgYW5kIA0KdGhlIGRvY3VtZW50
YXRpb24gYWJvdXQgdGhlIHR5cGUgZHVwbGljYXRlZCAoYW5kIHRoZXkgYXJlIGxpa2VseSB0
byBnZXQgDQpvdXQgb2Ygc3luYykuDQoNCldoZW4gSSBhZGRlZCB0aGUgdHlwZSBwYWdlcywg
SSBmb3VuZCBtYW55IHR5cGVzIHRvIGJlIGRvY3VtZW50ZWQgDQpkaWZmZXJlbnRseSBvbiBk
aWZmZXJlbnQgcGFnZXMsIG5lZWRpbmcgdG8gY29weSBwYXJ0cyBvZiBldmVyeSBwYWdlIHRv
IA0KZ2V0IHRoZSBmdWxsIHBpY3R1cmUsIGJlY2F1c2Ugbm9uZSBvZiB0aGVtIHdhcyBjb21w
bGV0ZS4gIFRoYXQncyANCmVzcGVjaWFsbHkgd2hhdCBJJ20gdHJ5aW5nIHRvIGF2b2lkLg0K
DQpTdGlsbCwgdGhlcmUgYXJlIG1hbnkgbW9yZSBpbXBvcnRhbnQgdHlwZXMgdG8gZG9jdW1l
bnQgaW4gdGhlIHR5cGUgDQpwYWdlcywgYW5kIGlmIHlvdSBjb25zaWRlciB0aGF0IHRoaXMg
b25lIGlzIHZlcnkgdW5saWtlbHkgdG8gYmUgc2hhcmVkIA0KaW4gdGhlIGxvbmcgdGVybSwg
dGhlbiBJIGRvbid0IHN0cm9uZ2x5IG9wcG9zZSB0byBpdCBiZWluZyBpbiB0aGUgc2FtZSAN
CnBhZ2UgYXMgdGhlIGlvY3RsIHRoYXQgdXNlcyBpdCBmb3Igbm93Lg0KDQo+IA0KPiAoVGhl
cmUgaXNuJ3QgYW55IG1hZ2ljYWwgd2F5IHRvICNpbmNsdWRlIGEgbWFucGFnZSB3aXRoaW4g
YW5vdGhlcg0KPiBtYW5wYWdlLCBpcyB0aGVyZT8pDQoNCk9oLCB0aGVyZSBpcy4gIEl0J3Mg
dGhlIGdyb2ZmKDcpIC5zbyByZXF1ZXN0LCB3aGljaCBpcyBiYXNpY2FsbHkgdGhlIA0Kc2Ft
ZSBhcyBDJ3MgI2luY2x1ZGUgZGlyZWN0aXZlLiAgV2UgYWN0dWFsbHkgdXNlIGl0IGEgbG90
IGluIHRoZSANCm1hbi1wYWdlcywgdG8gY3JlYXRlIGxpbmsgcGFnZXMgKGEgcGFnZSB3aG9z
ZSBvbmx5IGNvbnRlbnQgaXMgYSAuc28gDQpyZXF1ZXN0LCB3aGljaCBiYXNpY2FsbHkgbWVh
bnMgaXRzIGNvbnRlbnRzIGFyZSB0aGUgc2FtZSBhcyBhbm90aGVyIA0KcGFnZXMnKS4gIFNl
ZSBmb3IgZXhhbXBsZToNCg0KJCBjYXQgbWFuMi9sc3RhdC4yDQouc28gbWFuMi9zdGF0LjIN
Cg0KDQpUZWNobmljYWxseSwgaXQgY291bGQgYmUgdXNlZCBkaWZmZXJlbnRseSwgdG8gaW5j
bHVkZSBhIG1hbiBwYWdlIGFzIHBhcnQgDQpvZiBhbm90aGVyIHBhZ2UsIGJ1dCBpdCBoYXNu
J3QgYmVlbiBkb25lIGV2ZXIsIGFzIGl0IHdvdWxkIHByb2JhYmx5IA0KY29tcGxpY2F0ZSBo
b3cgbWFuIHBhZ2VzIGFyZSBzdG9yZWQsIGluZGV4ZWQsIGFuZCBzZWFyY2hlZCBpbiB0aGUg
DQpmaWxlc3lzdGVtICh0aGVyZSdzIG5vIDwvdXNyL3NoYXJlL21hbi9pbmNsdWRlLz4gb3Ig
PC91c3IvaW5sdWNkZS9tYW4vPiANCmRpcmVjdG9yeSBvciBzb21ldGhpbmcgbGlrZSB0aGF0
KS4NCg0KQ2hlZXJzLA0KDQpBbGV4DQoNCi0tIA0KQWxlamFuZHJvIENvbG9tYXINCjxodHRw
Oi8vd3d3LmFsZWphbmRyby1jb2xvbWFyLmVzLz4NCg==

--------------0cX1IdPrN9OwH00kjO3bOpGa--

--------------kUGXG1KWt7yMUAl6tcXkTjQk
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmLa6DYACgkQnowa+77/
2zILjg//RPuFfnWCw7rsGeytiI3V3MBESbTTJlmwNgOkamB2wwnySVyiJnM/0yIy
TIlJrt4c4+pytH07JR98h97ap2ZVtFABHDLAE2uz+v7TvB2inQQLRTlbJKALYw8B
9KrTDzWkH+IclM1i5YGZ293xWtnFYA0Q2tcmDpOSdVfepIldG4qOeSezFyOtey04
ERk6+Rq8DIHkLtjT99izqovoPqovbeIhjlCE1EKqXT6W4WGgI845y6rPg8M+M23q
sgcpz2ka1itRTUCECRlhdmOzKUDgDFDRG2sLBO5Of9i9Edl++QrGteFyB4aA73sh
UtF1Q4UG+QmslGcegGKK4QV4NkEQvBpjlfFS3awocEKCI3oyiWVuBNlP9qNHKuFx
efilQklBaOPNhlasTbtzhuJjuQXkzH65o2n3uTZ0DspwsWyT6FauXszxYYbteVzi
iHWEc7yL6qYkkpiaLsNq4o8l/Iim4G5OfHwHbQq6TZKC4qys1mm8/Ura8scnv0lI
6ukYmx6mt+OduKShnh5XMAkAR6TR4vRLpNtkQO5j0tVhiCiVHgw/qtKYqlZIDv8U
F6jzsWLN03dEz8DcIun2RPmxLXMlgG6CI9ve4kht0POVAmUM9OO8OkzTJzXiK/aX
c7pdcwUMqjnTdgzuqOZi6lVMo1mBFNPGs4It89bszClV1h8VCpk=
=iiIM
-----END PGP SIGNATURE-----

--------------kUGXG1KWt7yMUAl6tcXkTjQk--
