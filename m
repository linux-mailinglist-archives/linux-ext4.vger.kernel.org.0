Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3FCAD163B5D
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Feb 2020 04:34:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbgBSDeb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Feb 2020 22:34:31 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:6419 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgBSDeb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 18 Feb 2020 22:34:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582083270; x=1613619270;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=axt5bC42zxmRw+AA1y07U4YjYojFUMoUBCzErqyeLH8=;
  b=pgBHTWfAcvRGcp3fISop0Xlr6S4Ei/EGpTW6XGGpNmX3FsI+Irftb+hs
   v/Maw9zBkTgBPlL9qyPiSpksTyM/7+GBBbsTNS6KQIhVfk3UBG5b1I6Ol
   IQ09Hinc1eCsrJPJ5dLjpFTHwsq6Ob4IycHdJ4LJCjsUglKe+1vES1h5m
   I=;
IronPort-SDR: 2eJwaCDD4tamIpejH1nxXkpYySSNPxq9pouQg6AIzScSc7jJkIyi54Sd6QzVEeQJ/YcZsm9Y54
 OzKQ9oqgOMew==
X-IronPort-AV: E=Sophos;i="5.70,459,1574121600"; 
   d="scan'208";a="17815888"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-67b371d8.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 19 Feb 2020 03:34:18 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-67b371d8.us-east-1.amazon.com (Postfix) with ESMTPS id DC40EA36B6;
        Wed, 19 Feb 2020 03:34:15 +0000 (UTC)
Received: from EX13D30UWB001.ant.amazon.com (10.43.161.80) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 19 Feb 2020 03:34:15 +0000
Received: from EX13D01UWB002.ant.amazon.com (10.43.161.136) by
 EX13D30UWB001.ant.amazon.com (10.43.161.80) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 19 Feb 2020 03:34:15 +0000
Received: from EX13D01UWB002.ant.amazon.com ([10.43.161.136]) by
 EX13d01UWB002.ant.amazon.com ([10.43.161.136]) with mapi id 15.00.1497.006;
 Wed, 19 Feb 2020 03:34:14 +0000
From:   "Singh, Balbir" <sblbir@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "Jitindar SIngh, Suraj" <surajjs@amazon.com>
CC:     "stable@vger-kernel.org" <stable@vger-kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "sjitindarsingh@gmail.com" <sjitindarsingh@gmail.com>
Subject: Re: [PATCH 1/3] ext4: introduce macro sbi_array_rcu_deref() to access
 rcu protected fields
Thread-Topic: [PATCH 1/3] ext4: introduce macro sbi_array_rcu_deref() to
 access rcu protected fields
Thread-Index: AQHV5tIf15alY+ZIxkKysYBevAJAx6gh3UUA
Date:   Wed, 19 Feb 2020 03:34:14 +0000
Message-ID: <be56e829f5a5e546fbd9c8a733e6918ca8b60bc5.camel@amazon.com>
References: <20200219030851.2678-1-surajjs@amazon.com>
         <20200219030851.2678-2-surajjs@amazon.com>
In-Reply-To: <20200219030851.2678-2-surajjs@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.45]
Content-Type: text/plain; charset="utf-8"
Content-ID: <44209A0380B8844AB00E7EFFC70A9ED7@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

T24gVHVlLCAyMDIwLTAyLTE4IGF0IDE5OjA4IC0wODAwLCBTdXJhaiBKaXRpbmRhciBTaW5naCB3
cm90ZToNCj4gVGhlIHNfZ3JvdXBfZGVzYyBmaWVsZCBpbiB0aGUgc3VwZXIgYmxvY2sgaW5mbyAo
c2JpKSBpcyBwcm90ZWN0ZWQgYnkgcmN1IHRvDQo+IHByZXZlbnQgYWNjZXNzIHRvIGFuIGludmFs
aWQgcG9pbnRlciBkdXJpbmcgb25saW5lIHJlc2l6ZSBvcGVyYXRpb25zLg0KPiBUaGVyZSBhcmUg
MiBvdGhlciBhcnJheXMgaW4gc2JpLCBzX2dyb3VwX2luZm8gYW5kIHNfZmxleF9ncm91cHMsIHdo
aWNoDQo+IHJlcXVpcmUgc2ltaWxhciByY3UgcHJvdGVjdGlvbiB3aGljaCBpcyBpbnRyb2R1Y2Vk
IGluIHRoZSBzdWJzZXF1ZW50DQo+IHBhdGNoZXMuIEludHJvZHVjZSBhIGhlbHBlciBtYWNybyBz
YmlfYXJyYXlfcmN1X2RlcmVmKCkgdG8gYmUgdXNlZCB0bw0KPiBwcm92aWRlIHJjdSBwcm90ZWN0
ZWQgYWNjZXNzIHRvIHN1Y2ggZmllbGRzLg0KPiANCj4gQWxzbyB1cGRhdGUgdGhlIGN1cnJlbnQg
c19ncm91cF9kZXNjIGFjY2VzcyBzaXRlIHRvIHVzZSB0aGUgbWFjcm8uDQo+IA0KPiBTaWduZWQt
b2ZmLWJ5OiBTdXJhaiBKaXRpbmRhciBTaW5naCA8c3VyYWpqc0BhbWF6b24uY29tPg0KPiBDYzog
c3RhYmxlQHZnZXIta2VybmVsLm9yZw0KPiAtLS0NCj4gIGZzL2V4dDQvYmFsbG9jLmMgfCAxMSAr
KysrKy0tLS0tLQ0KPiAgZnMvZXh0NC9leHQ0LmggICB8IDE3ICsrKysrKysrKysrKysrKysrDQo+
ICAyIGZpbGVzIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZnMvZXh0NC9iYWxsb2MuYyBiL2ZzL2V4dDQvYmFsbG9jLmMNCj4gaW5k
ZXggNTM2OGJmNjczMDBiLi44ZmQwYjNjZGFiNGMgMTAwNjQ0DQo+IC0tLSBhL2ZzL2V4dDQvYmFs
bG9jLmMNCj4gKysrIGIvZnMvZXh0NC9iYWxsb2MuYw0KPiBAQCAtMjgxLDE0ICsyODEsMTMgQEAg
c3RydWN0IGV4dDRfZ3JvdXBfZGVzYyAqIGV4dDRfZ2V0X2dyb3VwX2Rlc2Moc3RydWN0DQo+IHN1
cGVyX2Jsb2NrICpzYiwNCj4gIA0KPiAgCWdyb3VwX2Rlc2MgPSBibG9ja19ncm91cCA+PiBFWFQ0
X0RFU0NfUEVSX0JMT0NLX0JJVFMoc2IpOw0KPiAgCW9mZnNldCA9IGJsb2NrX2dyb3VwICYgKEVY
VDRfREVTQ19QRVJfQkxPQ0soc2IpIC0gMSk7DQo+IC0JcmN1X3JlYWRfbG9jaygpOw0KPiAtCWJo
X3AgPSByY3VfZGVyZWZlcmVuY2Uoc2JpLT5zX2dyb3VwX2Rlc2MpW2dyb3VwX2Rlc2NdOw0KPiAr
CWJoX3AgPSBzYmlfYXJyYXlfcmN1X2RlcmVmKHNiaSwgc19ncm91cF9kZXNjLCBncm91cF9kZXNj
KTsNCj4gIAkvKg0KPiAtCSAqIFdlIGNhbiB1bmxvY2sgaGVyZSBzaW5jZSB0aGUgcG9pbnRlciBi
ZWluZyBkZXJlZmVyZW5jZWQgd29uJ3QgYmUNCj4gLQkgKiBkZXJlZmVyZW5jZWQgYWdhaW4uIEJ5
IGxvb2tpbmcgYXQgdGhlIHVzYWdlIGluIGFkZF9uZXdfZ2RiKCkgdGhlDQo+IC0JICogdmFsdWUg
aXNuJ3QgbW9kaWZpZWQsIGp1c3QgdGhlIHBvaW50ZXIsIGFuZCBzbyBpdCByZW1haW5zIHZhbGlk
Lg0KPiArCSAqIHNiaV9hcnJheV9yY3VfZGVyZWYgcmV0dXJucyB3aXRoIHJjdSB1bmxvY2tlZCwg
dGhpcyBpcyBvayBzaW5jZQ0KPiArCSAqIHRoZSBwb2ludGVyIGJlaW5nIGRlcmVmZXJlbmNlZCB3
b24ndCBiZSBkZXJlZmVyZW5jZWQgYWdhaW4uIEJ5DQo+ICsJICogbG9va2luZyBhdCB0aGUgdXNh
Z2UgaW4gYWRkX25ld19nZGIoKSB0aGUgdmFsdWUgaXNuJ3QgbW9kaWZpZWQsDQo+ICsJICoganVz
dCB0aGUgcG9pbnRlciwgYW5kIHNvIGl0IHJlbWFpbnMgdmFsaWQuDQo+ICAJICovDQo+IC0JcmN1
X3JlYWRfdW5sb2NrKCk7DQo+ICAJaWYgKCFiaF9wKSB7DQo+ICAJCWV4dDRfZXJyb3Ioc2IsICJH
cm91cCBkZXNjcmlwdG9yIG5vdCBsb2FkZWQgLSAiDQo+ICAJCQkgICAiYmxvY2tfZ3JvdXAgPSAl
dSwgZ3JvdXBfZGVzYyA9ICV1LCBkZXNjID0gJXUiLA0KPiBkaWZmIC0tZ2l0IGEvZnMvZXh0NC9l
eHQ0LmggYi9mcy9leHQ0L2V4dDQuaA0KPiBpbmRleCAxNDllZTBhYjZkNjQuLjIzNmZjNjUwMDM0
MCAxMDA2NDQNCj4gLS0tIGEvZnMvZXh0NC9leHQ0LmgNCj4gKysrIGIvZnMvZXh0NC9leHQ0LmgN
Cj4gQEAgLTE1NzYsNiArMTU3NiwyMyBAQCBzdGF0aWMgaW5saW5lIGludCBleHQ0X3ZhbGlkX2lu
dW0oc3RydWN0IHN1cGVyX2Jsb2NrDQo+ICpzYiwgdW5zaWduZWQgbG9uZyBpbm8pDQo+ICAJCSBp
bm8gPD0gbGUzMl90b19jcHUoRVhUNF9TQihzYiktPnNfZXMtPnNfaW5vZGVzX2NvdW50KSk7DQo+
ICB9DQo+ICANCj4gKy8qDQo+ICsgKiBSZXR1cm5zOiBzYmktPmZpZWxkW2luZGV4XQ0KPiArICog
VXNlZCB0byBhY2Nlc3MgYW4gYXJyYXkgZWxlbWVudCBmcm9tIHRoZSBmb2xsb3dpbmcgc2JpIGZp
ZWxkcyB3aGljaA0KPiByZXF1aXJlDQo+ICsgKiByY3UgcHJvdGVjdGlvbiB0byBhdm9pZCBkZXJl
ZmVyZW5jaW5nIGFuIGludmFsaWQgcG9pbnRlciBkdWUgdG8NCj4gcmVhc3NpZ25tZW50DQo+ICsg
KiAtIHNfZ3JvdXBfZGVzYw0KPiArICogLSBzX2dyb3VwX2luZm8NCj4gKyAqIC0gc19mbGV4X2dy
b3VwDQo+ICsgKi8NCj4gKyNkZWZpbmUgc2JpX2FycmF5X3JjdV9kZXJlZihzYmksIGZpZWxkLCBp
bmRleCkJCQkJDQo+ICAgIFwNCj4gKyh7CQkJCQkJCQkJICAgXA0KPiArCXR5cGVvZigqKChzYmkp
LT5maWVsZCkpIF92OwkJCQkJICAgXA0KPiArCXJjdV9yZWFkX2xvY2soKTsJCQkJCQkgICBcDQo+
ICsJX3YgPSAoKHR5cGVvZigoc2JpKS0+ZmllbGQpKXJjdV9kZXJlZmVyZW5jZSgoc2JpKS0+Zmll
bGQpKVtpbmRleF07IFwNCg0KTWlub3Igbml0LCB0aGlzIGNhbiBiZQ0KICANCl92ID0gKCh0eXBl
b2YoX3YpKilyY3VfZGVyZWZlcmVuY2UoKHNiaSktPmZpZWxkKSlbaW5kZXhdOw0KDQo+ICsJcmN1
X3JlYWRfdW5sb2NrKCk7CQkJCQkJICAgXA0KPiArCV92OwkJCQkJCQkJICAgXA0KPiArfSkNCj4g
Kw0KDQoNCg0KTG9va3MgZ29vZCB0byBtZQ0KUmV2aWV3ZWQtYnk6IEJhbGJpciBTaW5naCA8c2Js
YmlyQGFtYXpvbi5jb20+DQoNCg==
