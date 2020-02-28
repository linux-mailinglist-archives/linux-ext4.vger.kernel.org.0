Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5E59173FE5
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2020 19:45:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgB1Spk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 28 Feb 2020 13:45:40 -0500
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:18167 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725769AbgB1Spk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 28 Feb 2020 13:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582915539; x=1614451539;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=rGPLGhMYnYd4wUpUGnj7Hu45RX1YrowvYp9cRXp4l7w=;
  b=Kd4nstSchub0BsTVjLxPknWLPcp2vFLSPNSc5AeWjVSGgzjW0Er4ssEj
   QTdlno7jXYNizhlkG0E2UPC0LLK6NHXi6+oohVEhEVuvuiskBAUIMm38g
   joaT9wOgOdFbFZI/+PzzO7byuFFH2PH/5BB+SA+9k7v5g6mR2+UyUxcra
   Q=;
IronPort-SDR: pbNzaGAa30Qzm/PIIiUN+igdPsBUzvsKCiNeEsZV7pxLLhA2NIFUpsL9QIM3oHJHUh9wgCxsf6
 ljO4azplMRIQ==
X-IronPort-AV: E=Sophos;i="5.70,497,1574121600"; 
   d="scan'208";a="28179324"
Received: from sea32-co-svc-lb4-vlan3.sea.corp.amazon.com (HELO email-inbound-relay-2b-859fe132.us-west-2.amazon.com) ([10.47.23.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 28 Feb 2020 18:45:37 +0000
Received: from EX13MTAUWC001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-859fe132.us-west-2.amazon.com (Postfix) with ESMTPS id 48F0B2220D7;
        Fri, 28 Feb 2020 18:45:36 +0000 (UTC)
Received: from EX13D30UWC002.ant.amazon.com (10.43.162.235) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 28 Feb 2020 18:45:11 +0000
Received: from EX13D30UWC001.ant.amazon.com (10.43.162.128) by
 EX13D30UWC002.ant.amazon.com (10.43.162.235) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 28 Feb 2020 18:45:11 +0000
Received: from EX13D30UWC001.ant.amazon.com ([10.43.162.128]) by
 EX13D30UWC001.ant.amazon.com ([10.43.162.128]) with mapi id 15.00.1367.000;
 Fri, 28 Feb 2020 18:45:11 +0000
From:   "Jitindar SIngh, Suraj" <surajjs@amazon.com>
To:     "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>,
        "tytso@mit.edu" <tytso@mit.edu>
CC:     "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "wharms@bfs.de" <wharms@bfs.de>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH] ext4: potential crash on allocation error in
 ext4_alloc_flex_bg_array()
Thread-Topic: [PATCH] ext4: potential crash on allocation error in
 ext4_alloc_flex_bg_array()
Thread-Index: AQHV7hjKyEoTApWK8EWcHHjePONMGagw8jYA
Date:   Fri, 28 Feb 2020 18:45:11 +0000
Message-ID: <97e4ea8a96c28aa5e8659c5779c86643cade1f96.camel@amazon.com>
References: <20200228092142.7irbc44yaz3by7nb@kili.mountain>
In-Reply-To: <20200228092142.7irbc44yaz3by7nb@kili.mountain>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.145]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B345B388A5A748468E89CFD7A11A9327@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTI4IGF0IDEyOjIyICswMzAwLCBEYW4gQ2FycGVudGVyIHdyb3RlOg0K
PiBJZiBzYmktPnNfZmxleF9ncm91cHNfYWxsb2NhdGVkIGlzIHplcm8gYW5kIHRoZSBmaXJzdCBh
bGxvY2F0aW9uDQo+IGZhaWxzDQo+IHRoZW4gdGhpcyBjb2RlIHdpbGwgY3Jhc2guICBUaGUgcHJv
YmxlbSBpcyB0aGF0ICJpLS0iIHdpbGwgc2V0ICJpIiB0bw0KPiAtMSBidXQgd2hlbiB3ZSBjb21w
YXJlICJpID49IHNiaS0+c19mbGV4X2dyb3Vwc19hbGxvY2F0ZWQiIHRoZW4gdGhlDQo+IC0xDQo+
IGlzIHR5cGUgcHJvbW90ZWQgdG8gdW5zaWduZWQgYW5kIGJlY29tZXMgVUlOVF9NQVguICBTaW5j
ZSBVSU5UX01BWA0KPiBpcyBtb3JlIHRoYW4gemVybywgdGhlIGNvbmRpdGlvbiBpcyB0cnVlIHNv
IHdlIGNhbGwNCj4ga3ZmcmVlKG5ld19ncm91cHNbLTFdKS4NCj4gVGhlIGxvb3Agd2lsbCBjYXJy
eSBvbiBmcmVlaW5nIGludmFsaWQgbWVtb3J5IHVudGlsIGl0IGNyYXNoZXMuDQo+IA0KPiBGaXhl
czogN2M5OTA3MjhiOTllICgiZXh0NDogZml4IHBvdGVudGlhbCByYWNlIGJldHdlZW4gc19mbGV4
X2dyb3Vwcw0KPiBvbmxpbmUgcmVzaXppbmcgYW5kIGFjY2VzcyIpDQo+IFNpZ25lZC1vZmYtYnk6
IERhbiBDYXJwZW50ZXIgPGRhbi5jYXJwZW50ZXJAb3JhY2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6
IFN1cmFqIEppdGluZGFyIFNpbmdoIDxzdXJhampzQGFtYXpvbi5jb20+DQpDYzogPHN0YWJsZUBr
ZXJuZWwub3JnPg0KDQo+IC0tLQ0KPiBJIGNoYW5nZWQgdGhpcyBmcm9tIGEgLS0gbG9vcCB0byBh
ICsrIGxvb3AgYmVjYXVzZSBJIGtuZXcgaXQgd291bGQNCj4gbWFrZQ0KPiBXYWx0ZXIgSGFybXMg
aGFwcHkuICBIZSBoYXRlcyAtLSBsb29wcyBhbmQgSSBkb24ndCB3aGVuIGhpcyBiaXJ0aGRheQ0K
PiBzbw0KPiBJJ20gY2VsZWJyYXRpbmcgaXQgdG9kYXkuICA6KQ0KPiANCj4gIGZzL2V4dDQvc3Vw
ZXIuYyB8IDYgKysrLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAzIGRl
bGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2ZzL2V4dDQvc3VwZXIuYyBiL2ZzL2V4dDQv
c3VwZXIuYw0KPiBpbmRleCBmZjFiNzY0YjBjMGUuLjBjN2M0YWRiNjY0ZSAxMDA2NDQNCj4gLS0t
IGEvZnMvZXh0NC9zdXBlci5jDQo+ICsrKyBiL2ZzL2V4dDQvc3VwZXIuYw0KPiBAQCAtMjM5MSw3
ICsyMzkxLDcgQEAgaW50IGV4dDRfYWxsb2NfZmxleF9iZ19hcnJheShzdHJ1Y3Qgc3VwZXJfYmxv
Y2sNCj4gKnNiLCBleHQ0X2dyb3VwX3Qgbmdyb3VwKQ0KPiAgew0KPiAgCXN0cnVjdCBleHQ0X3Ni
X2luZm8gKnNiaSA9IEVYVDRfU0Ioc2IpOw0KPiAgCXN0cnVjdCBmbGV4X2dyb3VwcyAqKm9sZF9n
cm91cHMsICoqbmV3X2dyb3VwczsNCj4gLQlpbnQgc2l6ZSwgaTsNCj4gKwlpbnQgc2l6ZSwgaSwg
ajsNCj4gIA0KPiAgCWlmICghc2JpLT5zX2xvZ19ncm91cHNfcGVyX2ZsZXgpDQo+ICAJCXJldHVy
biAwOw0KPiBAQCAtMjQxMiw4ICsyNDEyLDggQEAgaW50IGV4dDRfYWxsb2NfZmxleF9iZ19hcnJh
eShzdHJ1Y3Qgc3VwZXJfYmxvY2sNCj4gKnNiLCBleHQ0X2dyb3VwX3Qgbmdyb3VwKQ0KPiAgCQkJ
CQkgc2l6ZW9mKHN0cnVjdCBmbGV4X2dyb3VwcykpLA0KPiAgCQkJCQkgR0ZQX0tFUk5FTCk7DQo+
ICAJCWlmICghbmV3X2dyb3Vwc1tpXSkgew0KPiAtCQkJZm9yIChpLS07IGkgPj0gc2JpLT5zX2Zs
ZXhfZ3JvdXBzX2FsbG9jYXRlZDsgaS0NCj4gLSkNCj4gLQkJCQlrdmZyZWUobmV3X2dyb3Vwc1tp
XSk7DQo+ICsJCQlmb3IgKGogPSBzYmktPnNfZmxleF9ncm91cHNfYWxsb2NhdGVkOyBqIDwgaTsN
Cj4gaisrKQ0KPiArCQkJCWt2ZnJlZShuZXdfZ3JvdXBzW2pdKTsNCj4gIAkJCWt2ZnJlZShuZXdf
Z3JvdXBzKTsNCj4gIAkJCWV4dDRfbXNnKHNiLCBLRVJOX0VSUiwNCj4gIAkJCQkgIm5vdCBlbm91
Z2ggbWVtb3J5IGZvciAlZCBmbGV4DQo+IGdyb3VwcyIsIHNpemUpOw0K
