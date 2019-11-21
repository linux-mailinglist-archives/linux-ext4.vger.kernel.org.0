Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED3E104E6A
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2019 09:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbfKUIwP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Nov 2019 03:52:15 -0500
Received: from mail-eopbgr790042.outbound.protection.outlook.com ([40.107.79.42]:6592
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726343AbfKUIwP (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 21 Nov 2019 03:52:15 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ty6XePl/DxCAq3GfTj05nPSybA31vhXGApWEYb/GVJDsmutEXw1Ko/ftIHoMFSa1I+r61xdaq5wM4GZBN78SMq1MTsezBU7SiYhYxBF2d/L0IRBCSb8Vsz/Lbm03mxWszoEIcfuuvpaVIGeL8ItiDh0/BnOiTwdx6smqtytIZx3p0zdK6Il9qw3RvIhbXE+2AxIvaoG8xPDMbkWkmD4sq6r2sChEM1tOE6jh7zZ4UTovX4Ki3cQA7uvUwssr1ByJZXiFkxJfCBSAGKCitYiTW4x/e5Nj8zJBhwHp2SiBIaT4TM7LcNYQIowcH73c0ofhbraJe51OkCjw42wNFJ34jQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hdL6FhD0d3B/IdO8jdmt9pzTuOvQ3mBCXfux8BFU/c=;
 b=M02hbfC1eOx4MLskAahaeLFre/FqZAyh0NTKMbW78ftVsInsuJXJZT+I0XAFuSDbbD+ePcYCaLREdld1ul9NnwpRsvcYnhX2v1B+FVPoFa29/3OzxzZS2yHQeypcEe6sZaUYXFhLOEanUuo4mrlqEOmH4W8BSAwD2cO7mmefxffMrD+DlCSs+jjJAWm5c7+IbosfP4UP42Wo2qXr9crJXpdxT0nM/LI4/mekald+OdIOrrWcp4x3qKkhGPBh4qZtQVSeYmTnFvxyPgqDCAXx9Aur42s7ohE+CIsuWIYPEchHToDJW3VmYBpW+HDlSdgNdKbZlYzdmBaDLKXT0fdQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hdL6FhD0d3B/IdO8jdmt9pzTuOvQ3mBCXfux8BFU/c=;
 b=JIqpWQNhk53gaAoEY4Fw/sg0Cs5rSdcUXn/lXMrOncx8Gon2lNMG2cluUQsnEqXIiCjLaBdssFE1vK4bhqK/Ta+t4rTc3W/bsH5F5A3LNWveczEZn29fg/7tda3lhg+SzkgdTMhcJ28qKEtvVlYj7tfYFqnpha8sL6Uo3TjDrmw=
Received: from BN8PR19MB2883.namprd19.prod.outlook.com (20.178.218.221) by
 BN8PR19MB2530.namprd19.prod.outlook.com (20.178.223.212) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.30; Thu, 21 Nov 2019 08:52:11 +0000
Received: from BN8PR19MB2883.namprd19.prod.outlook.com
 ([fe80::d09c:38e0:c805:f9d2]) by BN8PR19MB2883.namprd19.prod.outlook.com
 ([fe80::d09c:38e0:c805:f9d2%6]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 08:52:11 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     Artem Blagodarenko <artem.blagodarenko@gmail.com>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [RFC] improve malloc for large filesystems
Thread-Topic: [RFC] improve malloc for large filesystems
Thread-Index: AQHVn45AfmzanBfwskq4XYElVj+Zs6eUXWuAgADXAYCAABhfAIAABgOA
Date:   Thu, 21 Nov 2019 08:52:10 +0000
Message-ID: <9114E776-B44E-4CA5-BD49-C432A688C24E@whamcloud.com>
References: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
 <20191120181353.GG4262@mit.edu>
 <9E04C147-D878-45CE-8473-EF8C67FE4E86@whamcloud.com>
 <4EB2303A-01A3-49AC-B713-195126DB621B@gmail.com>
In-Reply-To: <4EB2303A-01A3-49AC-B713-195126DB621B@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [128.72.176.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 36258d40-6757-4422-7701-08d76e6018f2
x-ms-traffictypediagnostic: BN8PR19MB2530:
x-microsoft-antispam-prvs: <BN8PR19MB2530A842231E2C30BF278202CB4E0@BN8PR19MB2530.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(376002)(346002)(136003)(396003)(39850400004)(199004)(189003)(186003)(53546011)(26005)(2616005)(11346002)(6506007)(33656002)(2906002)(316002)(66556008)(66476007)(71200400001)(71190400001)(66446008)(64756008)(36756003)(102836004)(99286004)(5660300002)(66946007)(6116002)(76116006)(91956017)(446003)(256004)(54906003)(3846002)(14444005)(6916009)(8936002)(6246003)(81156014)(81166006)(4326008)(8676002)(6512007)(6436002)(86362001)(229853002)(6486002)(25786009)(14454004)(66066001)(305945005)(7736002)(76176011)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:BN8PR19MB2530;H:BN8PR19MB2883.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WBEaAqqVomEmmqBUBe0Ri/dPcFX6AEnfmKsZaU/NsV/L7BiUpT6Q5LWXRSNRjJ/1YaSZaVnCfAabSisrkvD7qpKufipzxrNiGzGQ7eo7oOXEb8vBmrCT9eoZiLYBdo9zVqWC2y4pqspaAWINyXZjJ/aNQik6miAIcS3HaehCIUBbkne6sjF6j0mTRNZZqBR1L2EIQpXhW43awwl/4uN5aTP8WC/XXFvqAoO5M2ytXw/rjUQlDHSO7RszBRZoy8Y79kxPkgvCrpBx2GAlTSskbxL8Src06wvai7MJGIWxpXzGFZvaN2QPJzJaSMN/yJK0Hs3EPvXCxYPhjnTMssKq3SAUrCO1spXTklM1HwsDCwvyaTRaBOU5+44zyazwMnq9CJpKDU/KY1Zwqo1gZSKJFIn4xeCjyJvHt3lWXRxyMxeDElPDJ/FuUqkCVPcDPEab
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <F5BC8ED0FBFA3048B6104514133E880A@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36258d40-6757-4422-7701-08d76e6018f2
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 08:52:10.7985
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n9phJDbGfA8DXrEyv6/af2tgioavALtYqX1fU2JUMQNPUHxhckxBDjmoUb0XAZP04qoohUnur4UMVqRN1++M+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR19MB2530
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQoNCj4gT24gMjEgTm92IDIwMTksIGF0IDExOjMwLCBBcnRlbSBCbGFnb2RhcmVua28gPGFydGVt
LmJsYWdvZGFyZW5rb0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gSGVsbG8gQWxleCwNCj4gDQo+
IENvZGUgbG9va3MgZ29vZCwgYnV0IEkgaGF2ZSBvYmplY3Rpb25zIGFib3V0IHRoZSBhcHByb2Fj
aC4NCj4gDQo+IDUxMlRCIGRpc2sgd2l0aCA0ayBibG9jayBzaXplIGhhdmUgNDE5NDMwNCBncm91
cHMuIFNvIDRrIGdyb3VwcyBpcyBvbmx5IH4wLjAxJSBvZiB3aG9sZSBkaXNrLg0KPiBDYW4gd2Ug
bWFrZSBkZWNpc2lvbiB0byBicmVhayBzZWFyY2ggYW5kIGdldCBtaW5pbXVtIGJsb2NrcyBiYXNl
ZCBvbiBzdWNoIGxpbWl0ZWQgZGF0YS4NCj4gSSBhbSBub3Qgc3VyZSB0aGF0IHNwZW5kaW5nIHNv
bWUgdGltZSB0byBmaW5kIGdvb2QgZ3JvdXAgaXMgd29yc2UgdGhlbiBhbGxvY2F0ZSBibG9ja3Mg
d2l0aG91dCANCj4gb3B0aW1pc2F0aW9uLiBFc3BlY2lhbGx5LCBpZiBkaXNrIGlzIHF1aXRlIGZy
ZWUgYW5kIHRoZXJlIGFyZSBhIGxvdCBvZiBmcmVlIGJsb2NrIGdyb3Vwcy4NCg0KRXhhY3QgbnVt
YmVyIGlzbuKAmXQgaGFyZGNvZGVkIGFuZCBzdWJqZWN0IHRvIGRpc2N1c3Npb24sIGJ1dCB5b3Ug
ZG9u4oCZdCByZWFsbHkgd2FudCB0byBzY2FuIDRNIA0KZ3JvdXBzIChlc3BlY2lhbGx5IHVuaW5p
dGlhbGlzZWQpIHRvIGZpbmQg4oCcYmVzdOKAnSBjaHVuay4NCg0KVGhpcyBjYW4gYmUgb3B0aW1p
emVkIGZ1cnRoZXIgbGlrZSDigJxkb27igJl0IGNvdW50IGluaXRpYWxpemVkIGFuZC9vciBlbXB0
eSBncm91cHPigJ0sIGJ1dCBzdGlsbCBzb21lIGxpbWl0DQpJcyByZXF1aXJlZCwgSU1PLiBOb3Rp
Y2UgdGhpcyBsaW1pdCBkb2VzbuKAmXQgYXBwbHkgaWYgb25jZSB3ZSB0cmllZCB0byBmaW5kIOKA
nGJlc3TigJ0sIGkuZS4gaXTigJlzIGFwcGxpZWQgb25seQ0Kd2l0aCBjcj0wIGFuZCBjcj0xLg0K
DQoNClRoYW5rcywgQWxleA0KDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEFydGVtIEJsYWdvZGFy
ZW5rby4NCj4+IE9uIDIxIE5vdiAyMDE5LCBhdCAxMDowMywgQWxleCBaaHVyYXZsZXYgPGF6aHVy
YXZsZXZAd2hhbWNsb3VkLmNvbT4gd3JvdGU6DQo+PiANCj4+IA0KPj4gDQo+Pj4gT24gMjAgTm92
IDIwMTksIGF0IDIxOjEzLCBUaGVvZG9yZSBZLiBUcydvIDx0eXRzb0BtaXQuZWR1PiB3cm90ZToN
Cj4+PiANCj4+PiBIaSBBbGV4LA0KPj4+IA0KPj4+IEEgY291cGxlIG9mIGNvbW1lbnRzLiAgRmly
c3QsIHBsZWFzZSBzZXBhcmF0ZSB0aGlzIHBhdGNoIHNvIHRoYXQgdGhlc2UNCj4+PiB0d28gc2Vw
YXJhdGUgcGllY2VzIG9mIGZ1bmN0aW9uYWxpdHkgY2FuIGJlIHJldmlld2VkIGFuZCB0ZXN0ZWQN
Cj4+PiBzZXBhcmF0ZWx5Og0KPj4+IA0KPj4gDQo+PiBUaGlzIGlzIHRoZSBmaXJzdCBwYXRjaCBv
ZiB0aGUgc2VyaWVzLg0KPj4gDQo+PiBUaGFua3MsIEFsZXgNCj4+IA0KPj4gRnJvbSA4MWM0YjNi
NWExN2Q5NDUyNWJiYzZkMmQ4OWIyMGY2NjE4YjA1YmM2IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAw
MQ0KPj4gRnJvbTogQWxleCBaaHVyYXZsZXYgPGJ6enpAd2hhbWNsb3VkLmNvbT4NCj4+IERhdGU6
IFRodSwgMjEgTm92IDIwMTkgMDk6NTM6MTMgKzAzMDANCj4+IFN1YmplY3Q6IFtQQVRDSCAxLzJd
IGV4dDQ6IGxpbWl0IHNjYW5uaW5nIGZvciBhIGdvb2QgZ3JvdXANCj4+IA0KPj4gYXQgZmlyc3Qg
dHdvIHJvdW5kcyB0byBwcmV2ZW50IHNpdHVhdGlvbiB3aGVuIDEweC0xMDB4IHRob3VzYW5kDQo+
PiBvZiBncm91cHMgYXJlIHNjYW5uZWQsIGVzcGVjaWFsbHkgbm9uLWluaXRpYWxpemVkIGdyb3Vw
cy4NCj4+IA0KPj4gU2lnbmVkLW9mZi1ieTogQWxleCBaaHVyYXZsZXYgPGJ6enpAd2hhbWNsb3Vk
LmNvbT4NCj4+IC0tLQ0KPj4gZnMvZXh0NC9leHQ0LmggICAgfCAgMiArKw0KPj4gZnMvZXh0NC9t
YmFsbG9jLmMgfCAxNCArKysrKysrKysrKystLQ0KPj4gZnMvZXh0NC9zeXNmcy5jICAgfCAgNCAr
KysrDQo+PiAzIGZpbGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0p
DQo+PiANCj4+IGRpZmYgLS1naXQgYS9mcy9leHQ0L2V4dDQuaCBiL2ZzL2V4dDQvZXh0NC5oDQo+
PiBpbmRleCAwM2RiM2U3MTY3NmMuLmQ0ZTQ3ZmRhZDg3YyAxMDA2NDQNCj4+IC0tLSBhL2ZzL2V4
dDQvZXh0NC5oDQo+PiArKysgYi9mcy9leHQ0L2V4dDQuaA0KPj4gQEAgLTE0ODAsNiArMTQ4MCw4
IEBAIHN0cnVjdCBleHQ0X3NiX2luZm8gew0KPj4gCS8qIHdoZXJlIGxhc3QgYWxsb2NhdGlvbiB3
YXMgZG9uZSAtIGZvciBzdHJlYW0gYWxsb2NhdGlvbiAqLw0KPj4gCXVuc2lnbmVkIGxvbmcgc19t
Yl9sYXN0X2dyb3VwOw0KPj4gCXVuc2lnbmVkIGxvbmcgc19tYl9sYXN0X3N0YXJ0Ow0KPj4gKwl1
bnNpZ25lZCBpbnQgc19tYl90b3NjYW4wOw0KPj4gKwl1bnNpZ25lZCBpbnQgc19tYl90b3NjYW4x
Ow0KPj4gDQo+PiAJLyogc3RhdHMgZm9yIGJ1ZGR5IGFsbG9jYXRvciAqLw0KPj4gCWF0b21pY190
IHNfYmFsX3JlcXM7CS8qIG51bWJlciBvZiByZXFzIHdpdGggbGVuID4gMSAqLw0KPj4gZGlmZiAt
LWdpdCBhL2ZzL2V4dDQvbWJhbGxvYy5jIGIvZnMvZXh0NC9tYmFsbG9jLmMNCj4+IGluZGV4IGEz
ZTI3NjdiZGYyZi4uY2ViZDdkOGRmMGI4IDEwMDY0NA0KPj4gLS0tIGEvZnMvZXh0NC9tYmFsbG9j
LmMNCj4+ICsrKyBiL2ZzL2V4dDQvbWJhbGxvYy5jDQo+PiBAQCAtMjA5OCw3ICsyMDk4LDcgQEAg
c3RhdGljIGludCBleHQ0X21iX2dvb2RfZ3JvdXAoc3RydWN0IGV4dDRfYWxsb2NhdGlvbl9jb250
ZXh0ICphYywNCj4+IHN0YXRpYyBub2lubGluZV9mb3Jfc3RhY2sgaW50DQo+PiBleHQ0X21iX3Jl
Z3VsYXJfYWxsb2NhdG9yKHN0cnVjdCBleHQ0X2FsbG9jYXRpb25fY29udGV4dCAqYWMpDQo+PiB7
DQo+PiAtCWV4dDRfZ3JvdXBfdCBuZ3JvdXBzLCBncm91cCwgaTsNCj4+ICsJZXh0NF9ncm91cF90
IG5ncm91cHMsIHRvc2NhbiwgZ3JvdXAsIGk7DQo+PiAJaW50IGNyOw0KPj4gCWludCBlcnIgPSAw
LCBmaXJzdF9lcnIgPSAwOw0KPj4gCXN0cnVjdCBleHQ0X3NiX2luZm8gKnNiaTsNCj4+IEBAIC0y
MTY5LDcgKzIxNjksMTUgQEAgZXh0NF9tYl9yZWd1bGFyX2FsbG9jYXRvcihzdHJ1Y3QgZXh0NF9h
bGxvY2F0aW9uX2NvbnRleHQgKmFjKQ0KPj4gCQkgKi8NCj4+IAkJZ3JvdXAgPSBhYy0+YWNfZ19l
eC5mZV9ncm91cDsNCj4+IA0KPj4gLQkJZm9yIChpID0gMDsgaSA8IG5ncm91cHM7IGdyb3VwKyss
IGkrKykgew0KPj4gKwkJLyogbGltaXQgbnVtYmVyIG9mIGdyb3VwcyB0byBzY2FuIGF0IHRoZSBm
aXJzdCB0d28gcm91bmRzDQo+PiArCQkgKiB3aGVuIHdlIGhvcGUgdG8gZmluZCBzb21ldGhpbmcg
cmVhbGx5IGdvb2QgKi8NCj4+ICsJCXRvc2NhbiA9IG5ncm91cHM7DQo+PiArCQlpZiAoY3IgPT0g
MCkNCj4+ICsJCQl0b3NjYW4gPSBzYmktPnNfbWJfdG9zY2FuMDsNCj4+ICsJCWVsc2UgaWYgKGNy
ID09IDEpDQo+PiArCQkJdG9zY2FuID0gc2JpLT5zX21iX3Rvc2NhbjE7DQo+PiArDQo+PiArCQlm
b3IgKGkgPSAwOyBpIDwgdG9zY2FuOyBncm91cCsrLCBpKyspIHsNCj4+IAkJCWludCByZXQgPSAw
Ow0KPj4gCQkJY29uZF9yZXNjaGVkKCk7DQo+PiAJCQkvKg0KPj4gQEAgLTI4NzIsNiArMjg4MCw4
IEBAIHZvaWQgZXh0NF9wcm9jZXNzX2ZyZWVkX2RhdGEoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwg
dGlkX3QgY29tbWl0X3RpZCkNCj4+IAkJCWJpb19wdXQoZGlzY2FyZF9iaW8pOw0KPj4gCQl9DQo+
PiAJfQ0KPj4gKwlzYmktPnNfbWJfdG9zY2FuMCA9IDEwMjQ7DQo+PiArCXNiaS0+c19tYl90b3Nj
YW4xID0gNDA5NjsNCj4+IA0KPj4gCWxpc3RfZm9yX2VhY2hfZW50cnlfc2FmZShlbnRyeSwgdG1w
LCAmZnJlZWRfZGF0YV9saXN0LCBlZmRfbGlzdCkNCj4+IAkJZXh0NF9mcmVlX2RhdGFfaW5fYnVk
ZHkoc2IsIGVudHJ5KTsNCj4+IGRpZmYgLS1naXQgYS9mcy9leHQ0L3N5c2ZzLmMgYi9mcy9leHQ0
L3N5c2ZzLmMNCj4+IGluZGV4IGViMWVmYWQwZTIwYS4uYzk2ZWUyMGY1NDg3IDEwMDY0NA0KPj4g
LS0tIGEvZnMvZXh0NC9zeXNmcy5jDQo+PiArKysgYi9mcy9leHQ0L3N5c2ZzLmMNCj4+IEBAIC0x
OTgsNiArMTk4LDggQEAgRVhUNF9ST19BVFRSX0VTX1VJKGVycm9yc19jb3VudCwgc19lcnJvcl9j
b3VudCk7DQo+PiBFWFQ0X0FUVFIoZmlyc3RfZXJyb3JfdGltZSwgMDQ0NCwgZmlyc3RfZXJyb3Jf
dGltZSk7DQo+PiBFWFQ0X0FUVFIobGFzdF9lcnJvcl90aW1lLCAwNDQ0LCBsYXN0X2Vycm9yX3Rp
bWUpOw0KPj4gRVhUNF9BVFRSKGpvdXJuYWxfdGFzaywgMDQ0NCwgam91cm5hbF90YXNrKTsNCj4+
ICtFWFQ0X1JXX0FUVFJfU0JJX1VJKG1iX3Rvc2NhbjAsIHNfbWJfdG9zY2FuMCk7DQo+PiArRVhU
NF9SV19BVFRSX1NCSV9VSShtYl90b3NjYW4xLCBzX21iX3Rvc2NhbjEpOw0KPj4gDQo+PiBzdGF0
aWMgdW5zaWduZWQgaW50IG9sZF9idW1wX3ZhbCA9IDEyODsNCj4+IEVYVDRfQVRUUl9QVFIobWF4
X3dyaXRlYmFja19tYl9idW1wLCAwNDQ0LCBwb2ludGVyX3VpLCAmb2xkX2J1bXBfdmFsKTsNCj4+
IEBAIC0yMjgsNiArMjMwLDggQEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKmV4dDRfYXR0cnNb
XSA9IHsNCj4+IAlBVFRSX0xJU1QoZmlyc3RfZXJyb3JfdGltZSksDQo+PiAJQVRUUl9MSVNUKGxh
c3RfZXJyb3JfdGltZSksDQo+PiAJQVRUUl9MSVNUKGpvdXJuYWxfdGFzayksDQo+PiArCUFUVFJf
TElTVChtYl90b3NjYW4wKSwNCj4+ICsJQVRUUl9MSVNUKG1iX3Rvc2NhbjEpLA0KPj4gCU5VTEws
DQo+PiB9Ow0KPj4gQVRUUklCVVRFX0dST1VQUyhleHQ0KTsNCj4+IC0tIA0KPj4gMi4yMC4xDQo+
PiANCj4+IA0KPiANCg0K
