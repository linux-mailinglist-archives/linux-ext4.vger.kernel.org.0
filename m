Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B76D91704C
	for <lists+linux-ext4@lfdr.de>; Wed,  8 May 2019 07:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726444AbfEHFLQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 May 2019 01:11:16 -0400
Received: from asrmicro.com ([210.13.118.86]:38186 "EHLO mail2012.asrmicro.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbfEHFLQ (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 May 2019 01:11:16 -0400
X-Greylist: delayed 921 seconds by postgrey-1.27 at vger.kernel.org; Wed, 08 May 2019 01:11:14 EDT
Received: from mail2012.asrmicro.com (10.1.24.123) by mail2012.asrmicro.com
 (10.1.24.123) with Microsoft SMTP Server (TLS) id 15.0.847.32; Wed, 8 May
 2019 12:55:33 +0800
Received: from mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b]) by
 mail2012.asrmicro.com ([fe80::7c1a:96dd:1a6b:c97b%16]) with mapi id
 15.00.0847.030; Wed, 8 May 2019 12:55:33 +0800
From:   =?utf-8?B?RmFuZyBIb25namllKOaWuea0quadsCk=?= 
        <hongjiefang@asrmicro.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "linux-fscrypt@vger.kernel.org" <linux-fscrypt@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: RE: [PATCH] fscrypt: don't set policy for a dead directory
Thread-Topic: [PATCH] fscrypt: don't set policy for a dead directory
Thread-Index: AQHVBI82K6WCQI9ogEC4ZPkjP1ijfaZfS14AgAEqHED//575AIAAlC+g
Date:   Wed, 8 May 2019 04:55:32 +0000
Message-ID: <dd205c62aca049f694c0b07668138054@mail2012.asrmicro.com>
References: <1557204108-29048-1-git-send-email-hongjiefang@asrmicro.com>
 <20190507155531.GA1399@sol.localdomain>
 <8294e7217a014c5ca64f29fdf69bdeec@mail2012.asrmicro.com>
 <20190508035513.GB26575@sol.localdomain>
In-Reply-To: <20190508035513.GB26575@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-cr-hashedpuzzle: KWCE OAih RKsm SVX0 Up41 VrQI Wxkm ZPnX ZzUm ausF iAka
 lwF1 pZPd qex7 1Mez
 2Bs4;5;ZQBiAGkAZwBnAGUAcgBzAEAAawBlAHIAbgBlAGwALgBvAHIAZwA7AGoAYQBlAGcAZQB1AGsAQABrAGUAcgBuAGUAbAAuAG8AcgBnADsAbABpAG4AdQB4AC0AZQB4AHQANABAAHYAZwBlAHIALgBrAGUAcgBuAGUAbAAuAG8AcgBnADsAbABpAG4AdQB4AC0AZgBzAGMAcgB5AHAAdABAAHYAZwBlAHIALgBrAGUAcgBuAGUAbAAuAG8AcgBnADsAdAB5AHQAcwBvAEAAbQBpAHQALgBlAGQAdQA=;Sosha1_v1;7;{A4A51AE8-1EFF-444D-A563-8E19778B2BC3};aABvAG4AZwBqAGkAZQBmAGEAbgBnAEAAYQBzAHIAbQBpAGMAcgBvAC4AYwBvAG0A;Wed,
 08 May 2019 04:55:24
 GMT;UgBFADoAIABbAFAAQQBUAEMASABdACAAZgBzAGMAcgB5AHAAdAA6ACAAZABvAG4AJwB0ACAAcwBlAHQAIABwAG8AbABpAGMAeQAgAGYAbwByACAAYQAgAGQAZQBhAGQAIABkAGkAcgBlAGMAdABvAHIAeQA=
x-cr-puzzleid: {A4A51AE8-1EFF-444D-A563-8E19778B2BC3}
x-originating-ip: [10.1.170.195]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQo+IEZyb206IEVyaWMgQmlnZ2VycyBbbWFpbHRvOmViaWdnZXJzQGtlcm5lbC5vcmddDQo+IFNl
bnQ6IFdlZG5lc2RheSwgTWF5IDA4LCAyMDE5IDExOjU1IEFNDQo+IFRvOiBGYW5nIEhvbmdqaWUo
5pa55rSq5p2wKQ0KPiBDYzogdHl0c29AbWl0LmVkdTsgamFlZ2V1a0BrZXJuZWwub3JnOyBsaW51
eC1mc2NyeXB0QHZnZXIua2VybmVsLm9yZzsNCj4gbGludXgtZXh0NEB2Z2VyLmtlcm5lbC5vcmcN
Cj4gU3ViamVjdDogUmU6IFtQQVRDSF0gZnNjcnlwdDogZG9uJ3Qgc2V0IHBvbGljeSBmb3IgYSBk
ZWFkIGRpcmVjdG9yeQ0KPiANCj4gWytDYyBsaW51eC1leHQ0XQ0KPiANCj4gT24gV2VkLCBNYXkg
MDgsIDIwMTkgYXQgMDI6MTE6MTBBTSArMDAwMCwgRmFuZyBIb25namllKOaWuea0quadsCkgd3Jv
dGU6DQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBF
cmljIEJpZ2dlcnMgW21haWx0bzplYmlnZ2Vyc0BrZXJuZWwub3JnXQ0KPiA+ID4gU2VudDogVHVl
c2RheSwgTWF5IDA3LCAyMDE5IDExOjU2IFBNDQo+ID4gPiBUbzogRmFuZyBIb25namllKOaWuea0
quadsCkNCj4gPiA+IENjOiB0eXRzb0BtaXQuZWR1OyBqYWVnZXVrQGtlcm5lbC5vcmc7IGxpbnV4
LWZzY3J5cHRAdmdlci5rZXJuZWwub3JnDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIXSBmc2Ny
eXB0OiBkb24ndCBzZXQgcG9saWN5IGZvciBhIGRlYWQgZGlyZWN0b3J5DQo+ID4gPg0KPiA+ID4g
SGksDQo+ID4gPg0KPiA+ID4gT24gVHVlLCBNYXkgMDcsIDIwMTkgYXQgMTI6NDE6NDhQTSArMDgw
MCwgaG9uZ2ppZWZhbmcgd3JvdGU6DQo+ID4gPiA+IGlmIHRoZSBkaXJlY3RvcnkgaGFkIGJlZW4g
cmVtb3ZlZCwgc2hvdWxkIG5vdCBzZXQgcG9saWN5IGZvciBpdC4NCj4gPiA+ID4NCj4gPiA+ID4g
U2lnbmVkLW9mZi1ieTogaG9uZ2ppZWZhbmcgPGhvbmdqaWVmYW5nQGFzcm1pY3JvLmNvbT4NCj4g
PiA+DQo+ID4gPiBDYW4geW91IGV4cGxhaW4gdGhlIG1vdGl2YXRpb24gZm9yIHRoaXMgY2hhbmdl
PyAgSXQgbWFrZXMgc29tZSBzZW5zZSwgYnV0IEkNCj4gPiA+IGRvbid0IHNlZSB3aHkgaXQncyBy
ZWFsbHkgbmVlZGVkLiAgSWYgeW91IGxvb2sgYXQgYWxsIHRoZSBvdGhlciBJU19ERUFERElSKCkN
Cj4gPiA+IGNoZWNrcyBpbiB0aGUga2VybmVsLCB0aGV5J3JlIG5vdCBmb3Igb3BlcmF0aW9ucyBv
biB0aGUgZGlyZWN0b3J5IGlub2RlIGl0c2VsZiwNCj4gPiA+IGJ1dCByYXRoZXIgZm9yIGNyZWF0
aW5nL2ZpbmRpbmcvbGlzdGluZyBlbnRyaWVzIGluIHRoZSBkaXJlY3RvcnkuICBJIHRoaW5rDQo+
ID4gPiBGU19JT0NfU0VUX0VOQ1JZUFRJT05fUE9MSUNZIGlzIG1vcmUgbGlrZSB0aGUgZm9ybWVy
ICh0aG91Z2ggaXQgZG9lcyBoYXZlDQo+IHRvDQo+ID4gPiBjaGVjayB3aGV0aGVyIHRoZSBkaXJl
Y3RvcnkgaXMgZW1wdHkpLg0KPiA+DQo+ID4gSSBtZXQgYSBwYW5pYyBpc3N1ZSB3aGVuIHJ1biB0
aGUgc3l6a2FsbGVyIG9uIGtlcm5lbCA0LjE0LjgxKEVYVDQgRkJFIGVuYWJsZWQpLg0KPiA+IHRo
ZSBmbG93IG9mIGNhc2UgYXMgZm9sbG93Og0KPiA+IHIwID0gb3BlbmF0JGRpcigweGZmZmZmZmZm
ZmZmZmZmOWMsICYoMHg3ZjAwMDAwMDAwMDApPScuXHgwMCcsIDB4MCwgMHgwKQ0KPiA+IG1rZGly
YXQocjAsICYoMHg3ZjAwMDAwMDAwNDApPScuL2ZpbGUwXHgwMCcsIDB4MCkNCj4gPiByMSA9IG9w
ZW5hdCRkaXIoMHhmZmZmZmZmZmZmZmZmZjljLCAmKDB4N2YwMDAwMDAwMTQwKT0nLi9maWxlMFx4
MDAnLCAweDAsIDB4MCkNCj4gPiB1bmxpbmthdChyMCwgJigweDdmMDAwMDAwMDI0MCk9Jy4vZmls
ZTBceDAwJywgMHgyMDApDQo+ID4gaW9jdGwkRlNfSU9DX1NFVF9FTkNSWVBUSU9OX1BPTElDWShy
MSwgMHg4MDBjNjYxMywgJigweDdmMDAwMDAwMDBjMCkNCj4gPiA9ezB4MCwgQGFlczEyOCwgMHgw
LCAiOGFjYzczZGE5N2Q2YWNjYyJ9KQ0KPiA+DQo+ID4gVGhlIGZpbGUwIGRpcmVjdG9yeSBtYXli
ZSByZW1vdmVkIGJlZm9yZSBkb2luZw0KPiBGU19JT0NfU0VUX0VOQ1JZUFRJT05fUE9MSUNZLg0K
PiA+IEluIHRoaXMgY2FzZSwgZnNjcnlwdF9pb2N0bF9zZXRfcG9saWN5KCktPiBleHQ0X2VtcHR5
X2RpcigpIHdpbGwgcmV0dXJuIHRoZQ0KPiA+ICIgaW52YWxpZCBzaXplICIgYW5kIHRyaWdnZXIg
YSBwYW5pYyB3aGVuIGNoZWNrIHRoZSBpX3NpemUgb2YgaW5vZGUuDQo+ID4gdGhlIHBhbmljIHN0
YWNrIGFzIGZvbGxvdzoNCj4gPiBQSUQ6IDI2ODIgICBUQVNLOiBmZmZmZmZjMDg3ZDE4MDgwICBD
UFU6IDMgICBDT01NQU5EOiAic3l6LWV4ZWN1dG9yIg0KPiA+ICAjMCBbZmZmZmZmYzA4N2QyNmZj
MF0gcGFuaWMgYXQgZmZmZmZmOTAwODBkYzA0Yw0KPiA+ICAjMSBbZmZmZmZmYzA4N2QyNzI2MF0g
ZXh0NF9oYW5kbGVfZXJyb3IgYXQgZmZmZmZmOTAwODY4OWIwOA0KPiA+ICAjMiBbZmZmZmZmYzA4
N2QyNzI5MF0gX19leHQ0X2Vycm9yX2lub2RlIGF0IGZmZmZmZjkwMDg2ODllOTANCj4gPiAgIzMg
W2ZmZmZmZmMwODdkMjczZjBdIGV4dDRfZW1wdHlfZGlyIGF0IGZmZmZmZjkwMDg2NWIwNjQNCj4g
PiAgIzQgW2ZmZmZmZmMwODdkMjc0ZDBdIGZzY3J5cHRfaW9jdGxfc2V0X3BvbGljeSBhdCBmZmZm
ZmY5MDA4NTY1ZDcwDQo+ID4gICM1IFtmZmZmZmZjMDg3ZDI3NjMwXSBleHQ0X2lvY3RsIGF0IGZm
ZmZmZjkwMDg2MzEwNWMNCj4gPiAgIzYgW2ZmZmZmZmMwODdkMjdiMDBdIGRvX3Zmc19pb2N0bCBh
dCBmZmZmZmY5MDA4NGNjNDQwDQo+ID4gICM3IFtmZmZmZmZjMDg3ZDI3ZTgwXSBzeXNfaW9jdGwg
YXQgZmZmZmZmOTAwODRjZGFmMA0KPiA+ICAjOCBbZmZmZmZmYzA4N2QyN2ZmMF0gZWwwX3N2Y19u
YWtlZCBhdCBmZmZmZmY5MDA4MDg0ZmZjDQo+ID4NCj4gPiBTbywgaXQgbmVlZCB0byBjaGVjayB0
aGUgZGlyZWN0b3J5IHN0YXR1cyBpbiB0aGUgZnNjcnlwdF9pb2N0bF9zZXRfcG9saWN5KCkuDQo+
ID4NCj4gDQo+IE9rYXksIHRoaXMgaXMgYSByZWFsIGJ1ZywgdGhhbmtzIGZvciByZXBvcnRpbmcg
dGhpcyEgIFNvIGV4dDRfcm1kaXIoKSBzZXRzDQo+IGlfc2l6ZSA9IDAsIHRoZW4gZXh0NF9lbXB0
eV9kaXIoKSByZXBvcnRzIGFuIGVycm9yIGJlY2F1c2UgJ2lub2RlLT5pX3NpemUgPA0KPiBFWFQ0
X0RJUl9SRUNfTEVOKDEpICsgRVhUNF9ESVJfUkVDX0xFTigyKScuICBOb3RlIHRoYXQgaXQncyBh
Y3R1YWxseSBhbiBleHQ0DQo+IGVycm9yLCBub3QgbmVjZXNzYXJpbHkgYSBwYW5pYy4gIEJ1dCB0
aGUgZnMgbWF5IGJlIG1vdW50ZWQgd2l0aCBlcnJvcnM9cGFuaWMuDQo+IA0KPiBUaGlzIGNvdWxk
IGFsc28gYmUgZml4ZWQgYnkgdXBkYXRpbmcgZXh0NF9lbXB0eV9kaXIoKSB0byBhbGxvdyBpX3Np
emUgPT0gMC4gIEJ1dA0KPiB3ZSBtaWdodCBhcyB3ZWxsIGNoZWNrIElTX0RFQURESVIoKSBpbiBm
c2NyeXB0X2lvY3RsX3NldF9wb2xpY3koKSBlaXRoZXIgd2F5Lg0KPiANCj4gQ2FuIHlvdSBwbGVh
c2UgdXBkYXRlIHRoZSBjb21taXQgbWVzc2FnZSB0byBkZXNjcmliZSB0aGUgcHJvYmxlbSwgYW5k
IGFkZDoNCj4gDQo+IAlGaXhlczogOWJkODIxMmY5ODFlICgiZXh0NCBjcnlwdG86IGFkZCBlbmNy
eXB0aW9uIHBvbGljeSBhbmQgcGFzc3dvcmQgc2FsdA0KPiBzdXBwb3J0IikNCj4gCUNjOiA8c3Rh
YmxlQHZnZXIua2VybmVsLm9yZz4gIyB2NC4xKw0KPiANCg0KT2thee+8jEkgd2lsbCB1cGRhdGUg
aXQuDQoNCj4gKEFub3RoZXIgY29tbWVudCBiZWxvdykNCj4gDQo+ID4NCj4gPiA+DQo+ID4gPiA+
IC0tLQ0KPiA+ID4gPiAgZnMvY3J5cHRvL3BvbGljeS5jIHwgNyArKysrKysrDQo+ID4gPiA+ICAx
IGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+ID4gPiA+DQo+ID4gPiA+IGRpZmYgLS1n
aXQgYS9mcy9jcnlwdG8vcG9saWN5LmMgYi9mcy9jcnlwdG8vcG9saWN5LmMNCj4gPiA+ID4gaW5k
ZXggYmQ3ZWFmOS4uODI5MDBhNCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZnMvY3J5cHRvL3BvbGlj
eS5jDQo+ID4gPiA+ICsrKyBiL2ZzL2NyeXB0by9wb2xpY3kuYw0KPiA+ID4gPiBAQCAtNzcsNiAr
NzcsMTIgQEAgaW50IGZzY3J5cHRfaW9jdGxfc2V0X3BvbGljeShzdHJ1Y3QgZmlsZSAqZmlscCwg
Y29uc3Qgdm9pZA0KPiBfX3VzZXINCj4gPiA+ICphcmcpDQo+ID4gPiA+DQo+ID4gPiA+ICAJaW5v
ZGVfbG9jayhpbm9kZSk7DQo+ID4gPiA+DQo+ID4gPiA+ICsJLyogZG9uJ3Qgc2V0IHBvbGljeSBm
b3IgYSBkZWFkIGRpcmVjdG9yeSAqLw0KPiA+ID4gPiArCWlmIChJU19ERUFERElSKGlub2RlKSkg
ew0KPiA+ID4gPiArCQlyZXQgPSAtRU5PRU5UOw0KPiA+ID4gPiArCQlnb3RvIGRlYWRkaXJfb3V0
Ow0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiANCj4gVGhpcyBzZWVtcyBhIGJpdCBtaXNwbGFj
ZWQgZ2l2ZW4gdGhlIGFjdHVhbCBwdXJwb3NlIG9mIHRoZSBjaGVjaywgYW5kIHRoZQ0KPiBjb21t
ZW50IGRvZXNuJ3QgaGVscCBleHBsYWluIGl0LiAgSG93IGFib3V0IG1vdmluZyB0aGlzIHRvIGp1
c3QgYmVmb3JlIHRoZQ0KPiAtPmVtcHR5X2RpcigpIGNhbGwsIHNvIGl0J3Mgb25seSBkb25lIHdo
ZW4gYWN0dWFsbHkgc2V0dGluZyBhIG5ldyBwb2xpY3k/DQo+IEkgdGhpbmsgdGhhdCB3b3VsZCBt
YWtlIGl0IG1vcmUgb2J2aW91czoNCj4gDQo+IGRpZmYgLS1naXQgYS9mcy9jcnlwdG8vcG9saWN5
LmMgYi9mcy9jcnlwdG8vcG9saWN5LmMNCj4gaW5kZXggZDUzNjg4OWFjMzFiZi4uNDk0MWZlODQ3
MWNlZiAxMDA2NDQNCj4gLS0tIGEvZnMvY3J5cHRvL3BvbGljeS5jDQo+ICsrKyBiL2ZzL2NyeXB0
by9wb2xpY3kuYw0KPiBAQCAtODEsNiArODEsOCBAQCBpbnQgZnNjcnlwdF9pb2N0bF9zZXRfcG9s
aWN5KHN0cnVjdCBmaWxlICpmaWxwLCBjb25zdCB2b2lkIF9fdXNlcg0KPiAqYXJnKQ0KPiAgCWlm
IChyZXQgPT0gLUVOT0RBVEEpIHsNCj4gIAkJaWYgKCFTX0lTRElSKGlub2RlLT5pX21vZGUpKQ0K
PiAgCQkJcmV0ID0gLUVOT1RESVI7DQo+ICsJCWVsc2UgaWYgKElTX0RFQURESVIoaW5vZGUpKQ0K
PiArCQkJcmV0ID0gLUVOT0VOVDsNCj4gIAkJZWxzZSBpZiAoIWlub2RlLT5pX3NiLT5zX2NvcC0+
ZW1wdHlfZGlyKGlub2RlKSkNCj4gIAkJCXJldCA9IC1FTk9URU1QVFk7DQo+ICAJCWVsc2UNCj4g
DQo+IChUaGVuIHRoZSBsYWJlbCBiZWxvdyB3b3VsZG4ndCBiZSBuZWVkZWQsIG9mIGNvdXJzZS4p
DQo+IA0KDQpZZWFoLCB0aGlzIGlzIGEgbW9yZSBhcHByb3ByaWF0ZSB3YXkuDQpUaGFua3MgZm9y
IHRoZSBjb21tZW50Lg0KDQo+ID4gPiA+ICAJcmV0ID0gaW5vZGUtPmlfc2ItPnNfY29wLT5nZXRf
Y29udGV4dChpbm9kZSwgJmN0eCwgc2l6ZW9mKGN0eCkpOw0KPiA+ID4gPiAgCWlmIChyZXQgPT0g
LUVOT0RBVEEpIHsNCj4gPiA+ID4gIAkJaWYgKCFTX0lTRElSKGlub2RlLT5pX21vZGUpKQ0KPiA+
ID4gPiBAQCAtOTYsNiArMTAyLDcgQEAgaW50IGZzY3J5cHRfaW9jdGxfc2V0X3BvbGljeShzdHJ1
Y3QgZmlsZSAqZmlscCwgY29uc3Qgdm9pZA0KPiBfX3VzZXINCj4gPiA+ICphcmcpDQo+ID4gPiA+
ICAJCXJldCA9IC1FRVhJU1Q7DQo+ID4gPiA+ICAJfQ0KPiA+ID4gPg0KPiA+ID4gPiArZGVhZGRp
cl9vdXQ6DQo+ID4gPiA+ICAJaW5vZGVfdW5sb2NrKGlub2RlKTsNCj4gPiA+DQo+ID4gPiBDYWxs
IHRoaXMgbGFiZWwgJ291dF91bmxvY2snIGluc3RlYWQ/DQo+ID4gPg0KPiA+ID4gPg0KPiA+ID4g
PiAgCW1udF9kcm9wX3dyaXRlX2ZpbGUoZmlscCk7DQo+ID4gPiA+IC0tDQo+IA0KPiBUaGFua3Ms
DQo+IA0KPiAtIEVyaWMNCg0KDQpCJlINCkhvbmdqaWUNCg==
