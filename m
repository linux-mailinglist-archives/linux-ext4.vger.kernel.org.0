Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64DCF1687E8
	for <lists+linux-ext4@lfdr.de>; Fri, 21 Feb 2020 20:54:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgBUTxx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 21 Feb 2020 14:53:53 -0500
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:32006 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgBUTxx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 21 Feb 2020 14:53:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1582314832; x=1613850832;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AqwpE2JhemUmy9j12V9AuW/hy1vmyYX3UqIwTGAtS8U=;
  b=YoRWZt8FMu7kF6Qou7+mtiiWBdaODz08R2xGMM6UtOXrsZh20I6b7DcL
   1psz1GIwHkz3x00e2sulzgSw17O5p+WovJWDSc+OWt5qiDd8NmZh7N37p
   ExrwlncG1ugGkRNa6DE7+2Wpmutg/rCPVCUVu/s/9R7NeREdssql4UF8q
   g=;
IronPort-SDR: KcASRuoSIsQhuM1YzMIgBwUNmvGZJhgwL4vreBd+NAEKp/BU/r5xkxHM17KCJnmV9vFEIBfsvO
 MLelJPKkgzAg==
X-IronPort-AV: E=Sophos;i="5.70,469,1574121600"; 
   d="scan'208";a="18391720"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-821c648d.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 21 Feb 2020 19:53:40 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1a-821c648d.us-east-1.amazon.com (Postfix) with ESMTPS id AF53FA3C1F;
        Fri, 21 Feb 2020 19:53:38 +0000 (UTC)
Received: from EX13D30UWC001.ant.amazon.com (10.43.162.128) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 21 Feb 2020 19:53:37 +0000
Received: from EX13D30UWC001.ant.amazon.com (10.43.162.128) by
 EX13D30UWC001.ant.amazon.com (10.43.162.128) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Fri, 21 Feb 2020 19:53:37 +0000
Received: from EX13D30UWC001.ant.amazon.com ([10.43.162.128]) by
 EX13D30UWC001.ant.amazon.com ([10.43.162.128]) with mapi id 15.00.1367.000;
 Fri, 21 Feb 2020 19:53:37 +0000
From:   "Jitindar SIngh, Suraj" <surajjs@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "tytso@mit.edu" <tytso@mit.edu>
CC:     "cai@lca.pw" <cai@lca.pw>, "stable@kernel.org" <stable@kernel.org>
Subject: Re: [PATCH 3/3] ext4: fix potential race between s_flex_groups online
 resizing and access
Thread-Topic: [PATCH 3/3] ext4: fix potential race between s_flex_groups
 online resizing and access
Thread-Index: AQHV6HjEnzvee4xhAUGX8m4Y6vYtQqgmEEMA
Date:   Fri, 21 Feb 2020 19:53:37 +0000
Message-ID: <715ff6ba37595f794beda090da487d592c356aac.camel@amazon.com>
References: <20200221053458.730016-1-tytso@mit.edu>
         <20200221053458.730016-4-tytso@mit.edu>
In-Reply-To: <20200221053458.730016-4-tytso@mit.edu>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.53]
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F27F20BBC669F4C9EE972296F8D1DDE@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

T24gRnJpLCAyMDIwLTAyLTIxIGF0IDAwOjM0IC0wNTAwLCBUaGVvZG9yZSBUcydvIHdyb3RlOg0K
PiBGcm9tOiBTdXJhaiBKaXRpbmRhciBTaW5naCA8c3VyYWpqc0BhbWF6b24uY29tPg0KPiANCj4g
RHVyaW5nIGFuIG9ubGluZSByZXNpemUgYW4gYXJyYXkgb2Ygc19mbGV4X2dyb3VwcyBzdHJ1Y3R1
cmVzIGdldHMNCj4gcmVwbGFjZWQNCj4gc28gaXQgY2FuIGdldCBlbmxhcmdlZC4gSWYgdGhlcmUg
aXMgYSBjb25jdXJyZW50IGFjY2VzcyB0byB0aGUgYXJyYXkNCj4gYW5kDQo+IHRoaXMgbWVtb3J5
IGhhcyBiZWVuIHJldXNlZCB0aGVuIHRoaXMgY2FuIGxlYWQgdG8gYW4gaW52YWxpZCBtZW1vcnkN
Cj4gYWNjZXNzLg0KPiANCj4gVGhlIHNfZmxleF9ncm91cCBhcnJheSBoYXMgYmVlbiBjb252ZXJ0
ZWQgaW50byBhbiBhcnJheSBvZiBwb2ludGVycw0KPiByYXRoZXINCj4gdGhhbiBhbiBhcnJheSBv
ZiBzdHJ1Y3R1cmVzLiBUaGlzIGlzIHRvIGVuc3VyZSB0aGF0IHRoZSBpbmZvcm1hdGlvbg0KPiBj
b250YWluZWQgaW4gdGhlIHN0cnVjdHVyZXMgY2Fubm90IGdldCBvdXQgb2Ygc3luYyBkdXJpbmcg
YSByZXNpemUNCj4gZHVlIHRvDQo+IGFuIGFjY2Vzc29yIHVwZGF0aW5nIHRoZSB2YWx1ZSBpbiB0
aGUgb2xkIHN0cnVjdHVyZSBhZnRlciBpdCBoYXMgYmVlbg0KPiBjb3BpZWQgYnV0IGJlZm9yZSB0
aGUgYXJyYXkgcG9pbnRlciBpcyB1cGRhdGVkLiBTaW5jZSB0aGUgc3RydWN0dXJlcw0KPiB0aGVt
LQ0KPiBzZWx2ZXMgYXJlIG5vIGxvbmdlciBjb3BpZWQgYnV0IG9ubHkgdGhlIHBvaW50ZXJzIHRv
IHRoZW0gdGhpcyBjYXNlDQo+IGlzDQo+IG1pdGlnYXRlZC4NCg0KQSBidWcgd2l0aCB0aGlzIHBh
dGNoIHRoYXQgSSBtaXNzZWQgaGFzIGJlZW4gcG9pbnRlZCBvdXQgb24gdGhlIG1haWxpbmcNCmxp
c3Q6DQpodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1leHQ0LzE1ODIyOTM3MzYuNzM2NS4x
MDkuY2FtZWxAbGNhLnB3DQoNCj4gDQo+IExpbms6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9y
Zy9zaG93X2J1Zy5jZ2k/aWQ9MjA2NDQzDQo+IFByZXZpb3VzLVBhdGNoLUxpbms6IA0KPiBodHRw
czovL2xvcmUua2VybmVsLm9yZy9yLzIwMjAwMjE5MDMwODUxLjI2NzgtNC1zdXJhampzQGFtYXpv
bi5jb20NCj4gU2lnbmVkLW9mZi1ieTogU3VyYWogSml0aW5kYXIgU2luZ2ggPHN1cmFqanNAYW1h
em9uLmNvbT4NCj4gU2lnbmVkLW9mZi1ieTogVGhlb2RvcmUgVHMnbyA8dHl0c29AbWl0LmVkdT4N
Cj4gQ2M6IHN0YWJsZUBrZXJuZWwub3JnDQo+IC0tLQ0KPiAgZnMvZXh0NC9leHQ0LmggICAgfCAg
MiArLQ0KPiAgZnMvZXh0NC9pYWxsb2MuYyAgfCAyMyArKysrKysrKystLS0tLS0NCj4gIGZzL2V4
dDQvbWJhbGxvYy5jIHwgIDkgKysrKy0tDQo+ICBmcy9leHQ0L3Jlc2l6ZS5jICB8ICA3ICsrKy0t
DQo+ICBmcy9leHQ0L3N1cGVyLmMgICB8IDcyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLQ0KPiAtLQ0KPiAgNSBmaWxlcyBjaGFuZ2VkLCA3NiBpbnNlcnRpb25z
KCspLCAzNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9leHQ0L2V4dDQuaCBi
L2ZzL2V4dDQvZXh0NC5oDQo+IGluZGV4IGIxZWNlNTMyOTczOC4uNjE0ZmVmYTdkYzdhIDEwMDY0
NA0KPiAtLS0gYS9mcy9leHQ0L2V4dDQuaA0KPiArKysgYi9mcy9leHQ0L2V4dDQuaA0KPiBAQCAt
MTUxMiw3ICsxNTEyLDcgQEAgc3RydWN0IGV4dDRfc2JfaW5mbyB7DQo+ICAJdW5zaWduZWQgaW50
IHNfZXh0ZW50X21heF96ZXJvb3V0X2tiOw0KPiAgDQo+ICAJdW5zaWduZWQgaW50IHNfbG9nX2dy
b3Vwc19wZXJfZmxleDsNCj4gLQlzdHJ1Y3QgZmxleF9ncm91cHMgKnNfZmxleF9ncm91cHM7DQo+
ICsJc3RydWN0IGZsZXhfZ3JvdXBzICogX19yY3UgKnNfZmxleF9ncm91cHM7DQo+ICAJZXh0NF9n
cm91cF90IHNfZmxleF9ncm91cHNfYWxsb2NhdGVkOw0KPiAgDQo+ICAJLyogd29ya3F1ZXVlIGZv
ciByZXNlcnZlZCBleHRlbnQgY29udmVyc2lvbnMgKGJ1ZmZlcmVkIGlvKSAqLw0KPiBkaWZmIC0t
Z2l0IGEvZnMvZXh0NC9pYWxsb2MuYyBiL2ZzL2V4dDQvaWFsbG9jLmMNCj4gaW5kZXggYzY2ZThm
OTQ1MWEyLi41MDExMThiOWJhOTAgMTAwNjQ0DQo+IC0tLSBhL2ZzL2V4dDQvaWFsbG9jLmMNCj4g
KysrIGIvZnMvZXh0NC9pYWxsb2MuYw0KPiBAQCAtMzI4LDExICszMjgsMTMgQEAgdm9pZCBleHQ0
X2ZyZWVfaW5vZGUoaGFuZGxlX3QgKmhhbmRsZSwgc3RydWN0DQo+IGlub2RlICppbm9kZSkNCj4g
IA0KPiAgCXBlcmNwdV9jb3VudGVyX2luYygmc2JpLT5zX2ZyZWVpbm9kZXNfY291bnRlcik7DQo+
ICAJaWYgKHNiaS0+c19sb2dfZ3JvdXBzX3Blcl9mbGV4KSB7DQo+IC0JCWV4dDRfZ3JvdXBfdCBm
ID0gZXh0NF9mbGV4X2dyb3VwKHNiaSwgYmxvY2tfZ3JvdXApOw0KPiArCQlzdHJ1Y3QgZmxleF9n
cm91cHMgKmZnOw0KPiAgDQo+IC0JCWF0b21pY19pbmMoJnNiaS0+c19mbGV4X2dyb3Vwc1tmXS5m
cmVlX2lub2Rlcyk7DQo+ICsJCWZnID0gc2JpX2FycmF5X3JjdV9kZXJlZihzYmksIHNfZmxleF9n
cm91cHMsDQo+ICsJCQkJCSBleHQ0X2ZsZXhfZ3JvdXAoc2JpLA0KPiBibG9ja19ncm91cCkpOw0K
PiArCQlhdG9taWNfaW5jKCZmZy0+ZnJlZV9pbm9kZXMpOw0KPiAgCQlpZiAoaXNfZGlyZWN0b3J5
KQ0KPiAtCQkJYXRvbWljX2RlYygmc2JpLT5zX2ZsZXhfZ3JvdXBzW2ZdLnVzZWRfZGlycyk7DQo+
ICsJCQlhdG9taWNfZGVjKCZmZy0+dXNlZF9kaXJzKTsNCj4gIAl9DQo+ICAJQlVGRkVSX1RSQUNF
KGJoMiwgImNhbGwgZXh0NF9oYW5kbGVfZGlydHlfbWV0YWRhdGEiKTsNCj4gIAlmYXRhbCA9IGV4
dDRfaGFuZGxlX2RpcnR5X21ldGFkYXRhKGhhbmRsZSwgTlVMTCwgYmgyKTsNCj4gQEAgLTM2OCwx
MiArMzcwLDEzIEBAIHN0YXRpYyB2b2lkIGdldF9vcmxvdl9zdGF0cyhzdHJ1Y3Qgc3VwZXJfYmxv
Y2sNCj4gKnNiLCBleHQ0X2dyb3VwX3QgZywNCj4gIAkJCSAgICBpbnQgZmxleF9zaXplLCBzdHJ1
Y3Qgb3Jsb3Zfc3RhdHMgKnN0YXRzKQ0KPiAgew0KPiAgCXN0cnVjdCBleHQ0X2dyb3VwX2Rlc2Mg
KmRlc2M7DQo+IC0Jc3RydWN0IGZsZXhfZ3JvdXBzICpmbGV4X2dyb3VwID0gRVhUNF9TQihzYikt
PnNfZmxleF9ncm91cHM7DQo+ICsJc3RydWN0IGZsZXhfZ3JvdXBzICpmbGV4X2dyb3VwID0NCj4g
c2JpX2FycmF5X3JjdV9kZXJlZihFWFQ0X1NCKHNiKSwNCj4gKwkJCQkJCQkgICAgIHNfZmxleF9n
cm8NCj4gdXBzLCBnKTsNCg0KVGhlIGFzc2lnbm1lbnQgdG8gZmxleF9ncm91cCBuZWVkcyB0byBo
YXBwZW4gd2l0aGluIHRoZQ0KaWYgKGZsZXhfc2l6ZSA+IDEpIHt9DQppZiBzdGF0ZW1lbnQgdG8g
YXZvaWQgYSBwb3RlbnRpYWwgbnVsbCBwb2ludGVyIGRlcmVmZXJlbmNlLg0KDQppZiAoZmxleF9z
aXplID4gMSkgew0KCXN0cnVjdCBmbGV4X2dyb3VwcyAqZmxleF9ncm91cCA9DQpzYmlfYXJyYXlf
cmN1X2RlcmVmKEVYVDRfU0Ioc2IpLCBzX2ZsZXhfZ3JvdXBzLCBnKTsNCgkuLi4NCn0NCg0KV291
bGQgeW91IGxpa2UgYSByZXNlbmQ/DQoNCj4gIA0KPiAgCWlmIChmbGV4X3NpemUgPiAxKSB7DQo+
IC0JCXN0YXRzLT5mcmVlX2lub2RlcyA9DQo+IGF0b21pY19yZWFkKCZmbGV4X2dyb3VwW2ddLmZy
ZWVfaW5vZGVzKTsNCj4gLQkJc3RhdHMtPmZyZWVfY2x1c3RlcnMgPQ0KPiBhdG9taWM2NF9yZWFk
KCZmbGV4X2dyb3VwW2ddLmZyZWVfY2x1c3RlcnMpOw0KPiAtCQlzdGF0cy0+dXNlZF9kaXJzID0N
Cj4gYXRvbWljX3JlYWQoJmZsZXhfZ3JvdXBbZ10udXNlZF9kaXJzKTsNCj4gKwkJc3RhdHMtPmZy
ZWVfaW5vZGVzID0gYXRvbWljX3JlYWQoJmZsZXhfZ3JvdXAtDQo+ID5mcmVlX2lub2Rlcyk7DQo+
ICsJCXN0YXRzLT5mcmVlX2NsdXN0ZXJzID0gYXRvbWljNjRfcmVhZCgmZmxleF9ncm91cC0NCj4g
PmZyZWVfY2x1c3RlcnMpOw0KPiArCQlzdGF0cy0+dXNlZF9kaXJzID0gYXRvbWljX3JlYWQoJmZs
ZXhfZ3JvdXAtPnVzZWRfZGlycyk7DQo+ICAJCXJldHVybjsNCj4gIAl9DQo+ICANCltzbmlwXQ0K
