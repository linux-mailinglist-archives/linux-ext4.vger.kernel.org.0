Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4DC78BB334
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2019 13:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729955AbfIWLzW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Sep 2019 07:55:22 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:56352 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725873AbfIWLzV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 23 Sep 2019 07:55:21 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-27-s_lDrj5TMTGaATnbftqtUA-1; Mon, 23 Sep 2019 12:55:18 +0100
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 23 Sep 2019 12:55:17 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 23 Sep 2019 12:55:17 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Linus Torvalds' <torvalds@linux-foundation.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "Ahmed S. Darwish" <darwish.07@gmail.com>,
        Lennart Poettering <mzxreary@0pointer.de>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        "Alexander E. Patrakov" <patrakov@gmail.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-man@vger.kernel.org" <linux-man@vger.kernel.org>
Subject: RE: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Thread-Topic: [PATCH RFC v4 1/1] random: WARN on large getrandom() waits and
 introduce getrandom2()
Thread-Index: AQHVbyVve2HSE4CfFUa5FrGzj/69Mac5KmJw
Date:   Mon, 23 Sep 2019 11:55:17 +0000
Message-ID: <619e578cdfad4dca904eb9db9bf626c0@AcuMS.aculab.com>
References: <20190912034421.GA2085@darwi-home-pc>
 <20190912082530.GA27365@mit.edu>
 <CAHk-=wjyH910+JRBdZf_Y9G54c1M=LBF8NKXB6vJcm9XjLnRfg@mail.gmail.com>
 <20190914122500.GA1425@darwi-home-pc>
 <008f17bc-102b-e762-a17c-e2766d48f515@gmail.com>
 <20190915052242.GG19710@mit.edu>
 <CAHk-=wgg2T=3KxrO-BY3nHJgMEyApjnO3cwbQb_0vxsn9qKN8Q@mail.gmail.com>
 <20190918211503.GA1808@darwi-home-pc> <20190918211713.GA2225@darwi-home-pc>
 <CAHk-=wiCqDiU7SE3FLn2W26MS_voUAuqj5XFa1V_tiGTrrW-zQ@mail.gmail.com>
 <20190919143427.GQ6762@mit.edu>
 <CAHk-=wgqbBy84ovtr8wPFqRo6U8jvp59rvQ8a6TvXuoyb-4L-Q@mail.gmail.com>
 <CAHk-=wjTbpcyVevsy3g-syB5v9gk_rR-yRFrUAvTL8NFuGfCrw@mail.gmail.com>
In-Reply-To: <CAHk-=wjTbpcyVevsy3g-syB5v9gk_rR-yRFrUAvTL8NFuGfCrw@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: s_lDrj5TMTGaATnbftqtUA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

RnJvbTogTGludXMgVG9ydmFsZHMNCj4gU2VudDogMTkgU2VwdGVtYmVyIDIwMTkgMjE6MDQNCi4u
Lg0KPiBOb3RlIHNtYWxsIGRldGFpbCBhYm92ZTogSSBjaGFuZ2VkIHRoZSBePSB0byBhICs9LiBB
ZGRpdGlvbiB0ZW5kcyB0bw0KPiBiZSBiZXR0ZXIgKGR1ZSB0byBjYXJyeSBiZXR3ZWVuIGJpdHMp
IHdoZW4gdGhlcmUgbWlnaHQgYmUgYml0DQo+IGNvbW1vbmFsaXRpZXMuICBQYXJ0aWN1bGFybHkg
d2l0aCBzb21ldGhpbmcgbGlrZSBhIGN5Y2xlIGNvdW50IHdoZXJlDQo+IHR3byB4b3JzIGNhbiBt
b3N0bHkgY2FuY2VsIG91dCBwcmV2aW91cyBiaXRzIHJhdGhlciB0aGFuIG1vdmUgYml0cw0KPiBh
cm91bmQgaW4gdGhlIHdvcmQuDQoNClRoZXJlIGlzIGNvZGUgaW4gb25lIG9uIHRoZSBrZXJuZWwg
Uk5HIHRoYXQgWE9ScyB0b2dldGhlciB0aGUgb3V0cHV0DQpvZiAzIExGU1IgKENSQykgZ2VuZXJh
dG9ycy4NCkkgdGhpbmsgaXQgaXMgdXNlZCBmb3IgJ2xvdyBxdWFsaXR5JyByYW5kb21uZXNzIGFu
ZCByZXNlZWRlZCBmcm9tIHRoZSBtYWluIFJORy4NClVzaW5nIFhPUiBtYWtlcyB0aGUgZW50aXJl
IGdlbmVyYXRvciAnbGluZWFyJyBhbmQgdGh1cyB0cml2aWFsbHkgcmV2ZXJzaWJsZS4NCldpdGgg
YSByZWxhdGl2ZWx5IHNtYWxsIG51bWJlciBvZiBjb25zZWN1dGl2ZSBvdXRwdXRzIHlvdSBjYW4g
ZGV0ZXJtaW5lIHRoZSBzdGF0ZQ0Kb2YgYWxsIDMgTEZTUi4NCk1lcmdlIHRoZSByZXN1bHRzIHdp
dGggYWRkaXRpb24gYW5kIHRoZSBwcm9jZXNzIGlzIGltbWVuc2VseSBoYXJkZXIuDQoNCkkndmUg
YWxzbyB3b25kZXJlZCB3aGV0aGVyIHRoZSBSQzQgZ2VuZXJhdG9yIGlzIGEgdXNlZnVsIGVudHJv
cHkgc3RvcmU/DQpJdCBoYXMgYSBsb3Qgb2Ygc3RhdGUgYW5kIHlvdSBjYW4gZmFpcmx5IGVhc2ls
eSBmZWVkIGluIHZhbHVlcyB0aGF0IG1pZ2h0IChvcg0KbWlnaHQgbm90KSBjb250YWluIGFueSBy
YW5kb21uZXNzIHdpdGhvdXQgbG9zaW5nIGFueSBzdG9yZWQgZW50cm9weS4NCg0KCURhdmlkDQoN
Ci0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJt
LCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChX
YWxlcykNCg==

