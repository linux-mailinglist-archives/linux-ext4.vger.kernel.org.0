Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 942C9E95C1
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Oct 2019 05:28:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbfJ3E2w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Oct 2019 00:28:52 -0400
Received: from outboundhk.mxmail.xiaomi.com ([207.226.244.126]:56902 "EHLO
        outboundhk.mxmail.xiaomi.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726156AbfJ3E2w (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Oct 2019 00:28:52 -0400
X-AuditID: 0a3808ce-03dff70000010b3c-c7-5db9117a1728
Received: from xiaomi.com (cnbox06.mioffice.cn [10.237.8.126])
        by outboundhk.mxmail.xiaomi.com (xiaomi.com) with SMTP id 07.A9.02876.B7119BD5; Wed, 30 Oct 2019 12:28:43 +0800 (HKT)
Received: from CNBOX04.mioffice.cn (10.237.8.124) by cnbox06.mioffice.cn
 (10.237.8.126) with Microsoft SMTP Server (TLS) id 15.0.1365.1; Wed, 30 Oct
 2019 12:28:42 +0800
Received: from CNBOX04.mioffice.cn ([fe80::b174:e2c9:1acc:9dab]) by
 cnbox04.mioffice.cn ([fe80::b174:e2c9:1acc:9dab%21]) with mapi id
 15.00.1365.000; Wed, 30 Oct 2019 12:28:42 +0800
From:   =?gb2312?B?WGlhb2h1aTEgTGkgwO7P/rvU?= <lixiaohui1@xiaomi.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "harshadshirwadkar@gmail.com" <harshadshirwadkar@gmail.com>
Subject: =?gb2312?B?tPC4tDogW0V4dGVybmFsIE1haWxdUmU6IFtQQVRDSCB2MyAwOS8xM10gZXh0?=
 =?gb2312?Q?4:_fast-commit_commit_path_changes?=
Thread-Topic: [External Mail]Re: [PATCH v3 09/13] ext4: fast-commit commit
 path changes
Thread-Index: AQHVjkrCmqmwGXcD4kKw4yrhequFrqdxnvyAgADuCRI=
Date:   Wed, 30 Oct 2019 04:28:42 +0000
Message-ID: <1572409673853.43507@xiaomi.com>
References: <1571900042725.99617@xiaomi.com> <20191024201800.GE1124@mit.edu>
 <1572349386604.43878@xiaomi.com>,<20191029213553.GD4404@mit.edu>
In-Reply-To: <20191029213553.GD4404@mit.edu>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.237.8.11]
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrKIsWRmVeSWpSXmKPExsXC9ZajTrdGcGesweFDChYrG1uYLGbOu8Nm
        0drzk92B2WPnrLvsHk1njjJ7fN4kF8AcxWWTkpqTWZZapG+XwJXRvqmDvaDJrWJS+3XGBsY5
        Ll2MnBwSAiYSZ+fvZu1i5OIQEtjGKDHlXgM7hLOGUeLxiT9sEM5ORolb82+xgLSwCThLnDt0
        gR3EFhFQk/jZugQszixQI7G9/xpYt7BAC6PEocPrWCGKIiVa7p5lg7CtJJ4umQxmswioSlx/
        9QyshldAR2LFmUlQq/sZJTp6DjGDJDiBEuvam8AaGAVkJaY9us8EsU1cYu60WawQTwhILNlz
        nhnCFpV4+fgfVNxAYuvSfSwQtrzE0ZNPmCF6tSTmNfyGmqMoMaX7ITvEEYISJ2c+YZnAKD4L
        yYpZSFpmIWmZhaRlASPLKkbJjPy89GwgLi5IzDXUy83MT0vLTE7VS87bxAiKPAuOczsYJ7xL
        PcQowMGoxMN7QHNHrBBrYllxZe4hRgkOZiUR3otntsUK8aYkVlalFuXHF5XmpBYfYpTmYFES
        5z3wjjNWSCA9sSQ1OzW1ILUIJsvEwSnVwFiwvfDO0V1sAovKE96uy2ffPyMwel3TtsflBiIl
        /6W8YmWyph4P5q6b/m1by5RbttlrBJecVot7/zxHa3Oy3qt1YW+jd0XH1m2UiNf01VT9fKvp
        0ffrxtJBa32OMxX1y9see2QWe3ie36QMpTrm9g6HuDNXgw4/Yflo80teQ9lS2sTVpsx1mRJL
        cUaioRZzUXEiAE6DG9O4AgAA
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

dGhhbmtzIHRvIHRoaXMgIGlKb3VybmFsaW5nIFVzZW5peCBwYXBlciwNCg0KZnN5bmMgbGF0ZW5j
eS10b28tbG9uZyBwcm9ibGVtIGJlY2F1c2Ugb2YgZW50YW5nbGVkIGRlcGVuZGVuY2llcyBhbmQg
aW5vZGUnIGRhdGEgaGFzIHRvIGJlIHdhaXRlZCBpbiBqYmQyIG9yZGVyIG1vZGUNCmNhbiBiZSBm
aXhlZC4NCg0KZW50YW5nbGVkIGRlcGVuZGVuY2llcyBwcm9ibGVtIGlzIGtub3duIHRvIHVzIGJ5
IHlvdXIga2luZCByZXBseSBlbWFpbC4NCnRoZSAgcHJvYmxlbSBvZiBmaWxlJyBkYXRhIHdhdGlu
ZyBpbiBqYmQyIG9yZGVyIG1vZGUgaXMgYWxzbyBhIHNlcmlvdXMgcHJvYmxlbSB3aGljaCBjYXNl
IGEgbG9uZy1sYXRlbmN5IGZzeW5jIGNhbGwuDQoNCmFzIHBvaW50ZWQgb3V0IGluIHRoaXMgaUpv
dXJuYWxpbmcgcGFwZXIsIHdoZW4gdGhyZWUgY29uZGl0aW9ucyB0dXJuIHVwIGF0IHRoZSBzYW1l
IHRpbWUsDQoxOiBvcmRlciBtb2RlIG11c3QgYmUgYXBwbGllZCwgbm90IHRoZSB3cml0ZWJhY2sg
bW9kZS4NCjI6IFRoZSBkZWxheWVkIGJsb2NrIGFsbG9jYXRpb24gdGVjaG5pcXVlIG9mIGV4dDQg
bXVzdCBiZSAgYXBwbGllZC4NCjM6IGJhY2tncm91ZCBidWZmZXIgd3JpdGVzIGFyZSB0b28gbWFu
eS4NCg0KYmVjYXVzZSB0aGUgcGVyaW9kaWMgZmx1c2ggZGlzayB0aW1lIGNhdXNlZCBieSBkZWxh
eWVkIGJsb2NrIGFsbG9jYXRpb24gaXMgMzBzKGEgYml0IHRvbyBsb25nKSBpbiBhbmRyb2lkIHN5
c3RlbSwNCnNvIHdoZW4gYmVnaW4gdG8gZmx1c2ggZGF0YSBhbmQgbWV0YWRhdGEgdG8gZGlzaywg
dGhlIGFtb3VudCBvZiBpbm9kZSBkYXRhIGZsdXNoZWQgY2FuIGJlIHNvIGxhcmdlLg0KYW5kIHNv
IGJlY2F1c2Ugb2YgdGhlIGRlZmF1bHQgZXh0NCBkYXRhIG1vZGUgaXMgb3JkZXIobm90IHRoZSB3
cml0ZWJhY2sgbW9kZSksIHNvIHdoZW4gZnN5bmMgaXMgY2FsbGVkLA0Kd2UgaGF2ZSB0byBiZSBm
YWNlZCB3aXRoIHN1Y2ggYSBkaWZmaWN1bHQgY29uZGl0aW9uIHdoaWNoIGlzIHRoYXQgaGF2ZSB0
byBiZSB3YWl0ZWQgZm9yIHNvIG1hbnkgaW5vZGUgZGF0YShub3QgdGhlIG1ldGFkYXRhKSBmbHVz
aGVkIHRvDQpkaXNrIGNvbXBsZXRlbHkgaW4gamJkMiB0aHJlYWQuDQoNCndlIGhhdmUgbm8gY2hv
aWNlIGFzIHRoZSBvcmRlciBtb2RlIG5lZWQgdG8gZG8gdGhpcyB3b3JrLCBzbyB0aGUgd2FpdGlu
ZyBpbm9kZS1kYXRhLWZsdXNoZWQtZGlzayB0aW1lIGlzIHRvbyBsb25nIGluIHNvbWUgZXh0cmVt
ZSBjb25kaXRpb25zLg0Kc28gaXQgY2F1c2UgdGhlIGFwcGVhcmFuY2Ugb2YgbG9uZy1sYXRlbmN5
IGZzeW5jIGNhbGwuDQoNCnRoYW5rIHlvdSBmb3IgeW91ciByZXBseSwgaSB3aWxsIHRyeSB0byBm
aXggdGhpcyBwcm9ibGVtIGluIG15IGZyZWUgdGltZS4NCg0KDQphcHBlbmQgc29tZSB3b3JkcyBp
biBpam91cm5hbCBwYXBlciB3aGljaCBtYXkgYmUgaGVscCBmb3Igc29tZW9uZShtYXkgYmUgaW5j
bHVkZSBtZSkgd2hpY2ggZG9uJ3QgYmUgZmFtaWxpYXIgd2l0aCB3aHkgZGVsYXllZCBibG9jayBh
bGxvY2F0aW9uDQp3aWxsIGNhdXNlIGxvbmctbGF0ZW5jeSBmc3luYyBjYWxsIDoNCg0KVGhlIGRl
bGF5ZWQgYmxvY2sgYWxsb2NhdGlvbiB0ZWNobmlxdWUgb2YgZXh0NCBhZy0NCmdyYXZhdGVzIHRo
ZSBDVFggcHJvYmxlbShhcHBlYXJlZCBpbiBmc3luYyBjYWxsKS4NCg0KSG93ZXZlciwgaWYgYW4g
ZnN5bmMgaXMgY2FsbGVkIGp1c3QgYWZ0ZXINCnRoZSBmbHVzaCBrZXJuZWwgdGhyZWFkIGludm9j
YXRpb24sIGFzIHNob3duIGluIHRoZSBleC0NCmFtcGxlIGluIEZpZ3VyZSAxKGEpLCB0aGUgZmx1
c2ggdGhyZWFkIHdpbGwgYWxsb2NhdGUgZGF0YQ0KYmxvY2tzIGZvciBkaXJ0eSBwYWdlcywgYW5k
IHJlZ2lzdGVyIHNldmVyYWwgbW9kaWZpZWQgaW4tDQpvZGVzIGluIHRoZSBydW5uaW5nIHRyYW5z
YWN0aW9uIGR1cmluZyB0aGUgZGVsYXllZCBibG9jaw0KYWxsb2NhdGlvbi4gVGhlbiwgdGhlIGNv
bW1pdCBvcGVyYXRpb24gb2YgdGhlIGpvdXJuYWwNCnRyYW5zYWN0aW9uIHdpbGwgZ2VuZXJhdGUg
bWFueSB3cml0ZSByZXF1ZXN0cyBpbnRvIHN0b3ItDQphZ2UuDQoNCiBTaGFsbCBzb21lb25lIGNh
biB0ZWxsIHRoZSByZWFzb24gd2h5IGRlbGF5ZWQgYmxvY2sgYWxsb2NhdGlvbiB0ZWNobmlxdWUg
b2YgZXh0NCBjYXVzZSAgbG9uZy1sYXRlbmN5IGZzeW5jIGNhbGwgd2l0aCBtb3JlIGRldGFpbCA/
DQptYW55IHRoYW5rcy4NCg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xw0Kt6K8/sjLOiBUaGVvZG9yZSBZLiBUcydvIDx0eXRzb0BtaXQuZWR1Pg0Kt6LLzcqxvOQ6IDIw
MTnE6jEw1MIzMMjVIDU6MzUNCsrVvP7IyzogWGlhb2h1aTEgTGkgwO7P/rvUDQqzrcvNOiBsaW51
eC1leHQ0QHZnZXIua2VybmVsLm9yZzsgaGFyc2hhZHNoaXJ3YWRrYXJAZ21haWwuY29tDQrW98zi
OiBbRXh0ZXJuYWwgTWFpbF1SZTogW1BBVENIIHYzIDA5LzEzXSBleHQ0OiBmYXN0LWNvbW1pdCBj
b21taXQgcGF0aCBjaGFuZ2VzDQoNCk9uIFR1ZSwgT2N0IDI5LCAyMDE5IGF0IDExOjQzOjU0QU0g
KzAwMDAsIFhpYW9odWkxIExpIMDuz/671CB3cm90ZToNCj4gPiBXZSBkb24ndCBhY3R1YWxseSBo
YXZlIHRvIGRvIHRoaXMuICBTdHJpY3RseSBzcGVha2luZywgd2Ugb25seSBoYXZlIHRvDQo+ID4g
d3JpdGUgb3V0IHRoZSBzcGVjaWZpYyBpbm9kZSBiZWluZyBmc3luYydlZCwgb3IgdGhlIHNwZWNp
ZmljIGlub2RlIGZvcg0KPiA+IHdoaWNoIGV4dDRfbmZzX2NvbW1pdF9tZXRkYXRhKCkgaGFzIGJl
ZW4gY2FsbGVkLiAgRm9yIGFuIGZzeW5jKCkNCj4gPiB3b3JrbG9hZCwgZXNwZWNpYWxseSBvbmUg
d2hlcmUgZm9yIGV4YW1wbGUsIHdlIG1pZ2h0IGhhdmUgaHVuZHJlZHMgb2YNCj4gPiBtb2RpZmll
ZCBpbm9kZXMsIGFsbCBvZiB3aGljaCBhcmUgZmMtZWxpZ2libGUgLS0tIGZvciBleGFtcGxlLCBi
ZWNhdXNlDQo+ID4gYSBrZXJuZWwgYnVpbGQgaXMgaGFwcGVuaW5nIGluIHRoZSBiYWNrZ3JvdW5k
LCBhbmQgYSBzaW5nbGUgZmlsZSB3aGljaA0KPiA+IGlzIGJlaW5nIGZzeW5jJ2VkIC0tLSBmb3Ig
ZXhhbXBsZSBiZWNhdXNlIHRoZSBwcm9ncmFtbWVyIGhhcyBqdXN0DQo+ID4gc2F2ZWQgYSBzb3Vy
Y2UgZmlsZSBpbiBlbWFjcyAtLS0tIHdlIG9ubHkgbmVlZCB0byBpbmNsdWRlIHRoYXQgc2luZ2xl
DQo+ID4gaW5vZGUgaW4gdGhlIGZhc3QgY29tbWl0LiAgSW5jbHVkaW5nICphbGwqIG9mIHRoZSBp
bm9kZXMgaW4gdGhlDQo+ID4gaV9mY19saXN0IGluIHRoZSBmYXN0IGNvbW1pdCwgaXMgd2FzdGVk
IGVmZm9ydCwgZXNwZWNpYWxseSBzaW5jZSB0aGUNCj4gPiBpbm9kZXMgaW4gcXVlc3Rpb24gd2ls
bCBiZSBjb21taXR0ZWQgd2l0aGluIHRoZSBuZXh0IDUgc2Vjb25kcy4NCj4NCj4geW91IHNhaWQg
b25seSBuZWVkIHRvIGluY2x1ZGUgdGhhdCBzaW5nbGUgaW5vZGUgaW4gdGhlIGZhc3QgY29tbWl0
Lg0KPiBkbyB5b3UgbWVhbiB0aGF0IGNyZWF0ZSBhIGZhc3QtY29tbWl0IHRyYW5zYWN0aW9uIHdo
aWNoIG9ubHkgbmVlZCB0bw0KPiBjb21taXQgZGF0YSBhbmQgbWV0YWRhdGEgb2YgdGhlIHNwZWNp
ZmljIGlub2RlID8gIGJ1dCBpbiB5b3VyIGxhc3QNCj4gZW1haWwsIHlvdSBzYXlzICJ3ZSBjYW4n
dCBqdXN0IHNlcGFyYXRlIG91dCBzb21lIG9mIHRoZSBoYW5kbGVzIGZyb20NCj4gb3RoZXJzIGlu
IG9uZSB0cmFuc2F0aW9uIi4NCj4NCj4gc28gaWYgd2UganVzdCBvbmx5IGluY2x1ZGUgdGhhdCBz
aW5nbGUgaW5vZGUoaWU6IGJlaW5nIGZzeW5jJ2VkKSBpbg0KPiB0aGUgZmFzdCBjb21taXQsIGlz
IGl0IG1lYW5zIHRoYXQgaW4gdGhlIGV4dDQgdHJhZGl0aW9uYWwgd2F5o6wNCj4gbWV0YWRhdGEg
b2YgdGhpcyBzaW5nbGUgaW5vZGUgYmVpbmcgZnN5bmMnZWQgbmVlZCB0byBiZSBtaXhlZCB3aXRo
DQo+IG90aGVyIGlub2RlcyBub3QgYmVpbmcgZnN5bmMnZWQgKG1heSBkb2luZyBidWZmZXIgd3Jp
dGUpIHRvZ2V0aGVyIGluDQo+IG9uZSB0cmFuc2FjdGlvbiB0byBiZSBmbHVzaGVkIHRvIGRpc2sg
Ym90aCB0b2dldGhlciBiZWNhdXNlIG9mDQo+IGVudGFnbGVkIGRlcGVuZGVuY2llcyB5b3Ugc2F5
cyBpbiB5b3VyIGxhc3QgcmVwbHkgZW1haWwuDQo+DQo+IGJ1dCB3aGVuIGZhc3QtY29tbWl0IHBh
dGNoZXMgYXBwbGllZCwgaG93IHRoZSBtZXRhZGF0YSBhbmQgZGF0YSBvZg0KPiB0aGlzIHNpbmds
ZSBpbm9kZSBiZWluZyBmc3luYydlZCBjYW4gYmUgZXh0cmFjdGVkIGZyb20gYWxsIGZpbGVzDQo+
IG1ldGFkYXRhIGNoYW5nZXMgZHVyaW5nIG9uZSB0aW1lIHJhbmdlIKO/DQoNCkRpZCB5b3UgcmVh
ZCB0aGUgaUpvdXJuYWxpbmcgVXNlbml4IHBhcGVyWzFdIHdoaWNoIEkgcmVmZXJlbmNlZA0KZWFy
bGllcj8gIEl0J3MgZGVzY3JpYmVkIGluIHRoZXJlLg0KDQpbMV0gaHR0cHM6Ly93d3cudXNlbml4
Lm9yZy9jb25mZXJlbmNlL2F0YzE3L3RlY2huaWNhbC1zZXNzaW9ucy9wcmVzZW50YXRpb24vcGFy
aw0KDQpUaGUgdHJpY2sgaXMgdGhhdCB3ZSB0cmFjayB3aGV0aGVyIHRoZSBpbm9kZSBoYXMgY2hh
bmdlcyB3aGljaCB3ZQ0KY2FuJ3QgcmVwcmVzZW50IGluIHRoZSBmYXN0IGNvbW1pdCAibG9naWNh
bCBqb3VybmFsIi4gIEluIHRoZSBsb2dpY2FsDQpqb3VybmFsLCB3ZSByZWNvcmQgY2hhbmdlcyBz
aW5jZSB0aGUgbGFzdCBmdWxsIGNvbW1pdCwgbm90IGFzIHRoZSBmdWxsDQpwaHlzaWNhbCBtZXRh
ZGF0YSBibG9jaywgYnV0IGp1c3QgYml0cyBvZiB0aGUgbG9naWNhbCBtZXRhZGF0YSB0aGF0DQpo
YXZlIGNoYW5nZWQuICBJZiB0aGF0IGlub2RlIGhhcyBjaGFuZ2VkIGluIHdheXMgdGhhdCB3ZSBj
YW4ndA0KcmVwcmVzZW50IGluIHRoZSBmYXN0IGNvbW1pdCBqb3VybmFsLCB0aGVuIHdlIGRvIGEg
bm9ybWFsIGZ1bGwgY29tbWl0Lg0KDQpTbyB3ZSBhdm9pZCBlbnRhbmdsZWQgZGVwZW5kZW5jaWVz
IGluIHR3byB3YXlzIC4gIEZpcnN0IG9mIGFsbCwgd2UNCm9ubHkgam91cm5hbCB0aGUgbG9naWNh
bCBjaGFuZ2UuICBIZW5jZSwgaWYgdGhlcmUgaXMgYSBjaGFuZ2UgaW4NCmFub3RoZXIgcGFydCBv
ZiB0aGUgbWV0YWRhdGEgYmxvY2sgKHNheSwgYW5vdGhlciBpbm9kZSBpbiB0aGUgaW5vZGUNCnRh
YmxlKSB0aGVyZSB3b24ndCBiZSBhbiBpc3N1ZSwgc2luY2Ugd2Ugb25seSB1cGRhdGUgdGhhdCBv
bmUgaW5vZGUuDQpTZWNvbmRseSwgaWYgdGhlIGlub2RlIGhhcyBzb21lIGVudGFuZ2VsZW1lbnRz
IGVpdGhlciB3aXRoIG90aGVyDQppbm9kZXMsIG9yIChiKSBjaGFuZ2VzIGluIHRoZSBpbm9kZSB3
aGljaCB3ZSBjYW4ndCByZWZsZWN0IGluIHRoZSBmYXN0DQpjb21taXQgbG9nLCB0aGVuIGZhbGwg
YmFjayB0byBkb2luZyBhIGZ1bGwgY29tbWl0Lg0KDQpTbyBiYXNpY2FsbHksIHdlIG9ubHkgZGVh
bCB3aXRoIHRoZSBzaW1wbGUsIGNvbW1vbiBjYXNlcywgd2hlcmUgaXQncw0KZWFzeSB0byBsb2cg
Y2hhbmdlcyB0byB0aGUgZmFzdCBjb21taXQgbG9nLiAgTm93LCB0aG9zZSBjaGFuZ2VzIGFyZQ0K
YWxzbyBsb2dnZWQgaW4gdGhlIG5vcm1hbCBwaHlzaWNhbCBjb21taXQsIHNvIG9uY2Ugd2UgZG8g
YSBmdWxsDQpjb21taXQsIGFsbCBvZiB0aGUgZW50cmllcyBpbiB0aGUgZmFzdCBjb21taXQgbG9n
IGFyZSBubyBsb25nZXIgbmVlZGVkDQotLS0gdGhlIGZhc3QgY29tbWl0IGp1c3QgY29udGFpbnMg
dGhlIHNtYWxsLCBzaW1wbGUgY2hhbmdlcyBzaW5jZSB0aGUNCmxhc3QgZnVsbCBjb21taXQuDQoN
CkNoZWVycywNCg0KICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLSBUZWQNCiMvKioqKioqsb7Tyrz+vLDG5Li9vP66rNPQ0KHD17mry761xLGjw9zQxc+io6y9
9s/e09q3osvNuPjJz8PmtdjWt9bQwdCz9rXEuPbIy7vyyLrX6aGjvfvWucjOus7G5Mv7yMvS1MjO
us7Qzsq9yrnTw6OosPzAqLWrsrvP3tPayKuyv7vysr+31rXY0LnCtqGiuLTWxqGiu/LJoreio6mx
vtPKvP7W0LXE0MXPoqGjyOe5+8T6tO3K1cHLsb7Tyrz+o6zH68T6waK8tLXnu7C78tPKvP7NqNaq
t6K8/sjLsqLJvrP9sb7Tyrz+o6EgVGhpcyBlLW1haWwgYW5kIGl0cyBhdHRhY2htZW50cyBjb250
YWluIGNvbmZpZGVudGlhbCBpbmZvcm1hdGlvbiBmcm9tIFhJQU9NSSwgd2hpY2ggaXMgaW50ZW5k
ZWQgb25seSBmb3IgdGhlIHBlcnNvbiBvciBlbnRpdHkgd2hvc2UgYWRkcmVzcyBpcyBsaXN0ZWQg
YWJvdmUuIEFueSB1c2Ugb2YgdGhlIGluZm9ybWF0aW9uIGNvbnRhaW5lZCBoZXJlaW4gaW4gYW55
IHdheSAoaW5jbHVkaW5nLCBidXQgbm90IGxpbWl0ZWQgdG8sIHRvdGFsIG9yIHBhcnRpYWwgZGlz
Y2xvc3VyZSwgcmVwcm9kdWN0aW9uLCBvciBkaXNzZW1pbmF0aW9uKSBieSBwZXJzb25zIG90aGVy
IHRoYW4gdGhlIGludGVuZGVkIHJlY2lwaWVudChzKSBpcyBwcm9oaWJpdGVkLiBJZiB5b3UgcmVj
ZWl2ZSB0aGlzIGUtbWFpbCBpbiBlcnJvciwgcGxlYXNlIG5vdGlmeSB0aGUgc2VuZGVyIGJ5IHBo
b25lIG9yIGVtYWlsIGltbWVkaWF0ZWx5IGFuZCBkZWxldGUgaXQhKioqKioqLyMNCg==
