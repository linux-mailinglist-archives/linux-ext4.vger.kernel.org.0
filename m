Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A399F44459
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Jun 2019 18:37:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731528AbfFMQg1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Jun 2019 12:36:27 -0400
Received: from mail-eopbgr740079.outbound.protection.outlook.com ([40.107.74.79]:17376
        "EHLO NAM01-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727176AbfFMHeO (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 13 Jun 2019 03:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61kvRBY7Sb/+631jV1snlv0jDD40Yfex/sO0GjRVvQc=;
 b=Xz4hcMwqUT3RdZ78k0vQg/b8Q8WQVQB3P6R/3akrwduWhm8THrzAZqjo2Y0IRioG9nxriQvjJDESN461MXAr6T/S7Gpsx7tFjBkyHN3OgKf4bgNdS2OBNYywqY12KffpVyxx4dOeOYC5QpufozxmXMISyQObT9yA6iiYvILxz50=
Received: from MN2PR19MB3167.namprd19.prod.outlook.com (10.255.181.16) by
 MN2PR19MB2717.namprd19.prod.outlook.com (20.178.253.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.10; Thu, 13 Jun 2019 07:34:09 +0000
Received: from MN2PR19MB3167.namprd19.prod.outlook.com
 ([fe80::dc80:b43c:bae8:93ac]) by MN2PR19MB3167.namprd19.prod.outlook.com
 ([fe80::dc80:b43c:bae8:93ac%6]) with mapi id 15.20.1987.010; Thu, 13 Jun 2019
 07:34:09 +0000
From:   Wang Shilong <wshilong@ddn.com>
To:     Chao Yu <yuchao0@huawei.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>
CC:     Andreas Dilger <adilger@dilger.ca>
Subject: =?gb2312?B?u9i4tDogW1BBVENIIDIvMl0gZjJmczogb25seSBzZXQgcHJvamVjdCBpbmhl?=
 =?gb2312?Q?rit_bit_for_directory?=
Thread-Topic: =?gb2312?B?u9i4tDogW1BBVENIIDIvMl0gZjJmczogb25seSBzZXQgcHJvamVjdCBpbmhl?=
 =?gb2312?Q?rit_bit_for_directory?=
Thread-Index: AQHVHCDhgH+VuQHB00eQdWW5nGRidqaZLF6AgACVXgI=
Date:   Thu, 13 Jun 2019 07:34:09 +0000
Message-ID: <MN2PR19MB3167496236BA4D366EAF5D36D4EF0@MN2PR19MB3167.namprd19.prod.outlook.com>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <1559795545-17290-2-git-send-email-wshilong1991@gmail.com>,<73fb9e88-d3f5-9420-d6d8-82ff4354e4d6@huawei.com>
In-Reply-To: <73fb9e88-d3f5-9420-d6d8-82ff4354e4d6@huawei.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wshilong@ddn.com; 
x-originating-ip: [36.62.199.127]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 31fd6d66-302b-4882-fb19-08d6efd18621
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR19MB2717;
x-ms-traffictypediagnostic: MN2PR19MB2717:
x-microsoft-antispam-prvs: <MN2PR19MB271724AB294366F66A2208A9D4EF0@MN2PR19MB2717.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0067A8BA2A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(396003)(366004)(346002)(376002)(136003)(189003)(199004)(316002)(14444005)(7696005)(305945005)(3846002)(99286004)(256004)(33656002)(6116002)(224303003)(53546011)(6506007)(476003)(76176011)(81156014)(74316002)(9686003)(6436002)(8936002)(110136005)(53936002)(55016002)(11346002)(446003)(486006)(81166006)(71190400001)(71200400001)(26005)(7736002)(66066001)(25786009)(4326008)(5660300002)(186003)(102836004)(64756008)(66556008)(14454004)(86362001)(2501003)(52536014)(2906002)(66446008)(76116006)(66946007)(73956011)(2201001)(68736007)(66476007)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB2717;H:MN2PR19MB3167.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: GaybPuLU7fxcESrnlUxJPe/UqqFEQ4GicKxdpkttb2ZAHu1Rhx8cQhUx+T6o2DFs3C/H5Mo8T/y1yD7FpVoaTCwCXPY1pxHvtwMgDxnRVVLfQ9Thn9UIkViD4z7FyhKN2iCcchzjguUOh+sJJ1vO4rj+J169AFaiCd80BZEh2TAyveGLU1G8u/XzhQRh261gCGjjOs0yNRay9u/n/I8bsyz3kTIjOwH7Nukw+1bdA9meVBGuC46/61fWxi8YZIIFL0HiOMLcSo1ilzNU2JCP0z97cp6knVTTEiw3aZDVr3/XE5FlQbPDG6yTzFMwjE6Rz2xzxEj+lcjAiIrbQyC++LbfXJo/gzdAuJ1yg904Msg9mm7BurOsJuZnFscGKSxbrWIrPSrGQI6fN191rcVwxjXwMcXbld0cMKduuj2mDdg=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31fd6d66-302b-4882-fb19-08d6efd18621
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jun 2019 07:34:09.5202
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wshilong@ddn.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2717
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGkgQ2hhbywNCg0KIEkganVzdCBzZW50IGEgVjIsIGJ1dCBJIHRoaW5rIHdlJ2QgYmV0dGVyIGRv
IHRoYXQgd2hlbiByZWFkaW5nIGlub2RlLCBmb3IgdHdvIHJlYXNvbnM6DQoNCjEpIG5vdCBvbmx5
IEYyRlNfSU9DX0dFVEZMQUdTIG5lZWQgZmlsdGVyIGZsYWdzIGJ1dCBhbHNvIEYyRlNfSU9DX0ZT
R0VUWEFUVFIgbmVlZCB0aGF0LCBzbyB0aGUgYW1lbmRlZCBwYXJ0cyBpcyBub3QgZW5vdWdoIElN
Ty4NCg0KMikgZG9pbmcgdGhhdCBieSByZWFkaW5nIGlub2RlIGdpdmUgYSBiZW5lZml0IHRoYXQg
d2UgY291bGQgY29ycmVjdCBvbiBkaXNrIGZsYWdzIGZvciByZWd1bGFyIGZpbGUgbmV4dCBkaXJ0
eWluZyBpbm9kZSBoYXBwZW4uDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18NCreivP7IyzogQ2hhbyBZdSA8eXVjaGFvMEBodWF3ZWkuY29tPg0Kt6LLzcqxvOQ6IDIw
MTnE6jbUwjEzyNUgMTQ6MzYNCsrVvP7IyzogV2FuZyBTaGlsb25nOyBsaW51eC1leHQ0QHZnZXIu
a2VybmVsLm9yZzsgbGludXgtZjJmcy1kZXZlbEBsaXN0cy5zb3VyY2Vmb3JnZS5uZXQNCrOty806
IFdhbmcgU2hpbG9uZzsgQW5kcmVhcyBEaWxnZXINCtb3zOI6IFJlOiBbUEFUQ0ggMi8yXSBmMmZz
OiBvbmx5IHNldCBwcm9qZWN0IGluaGVyaXQgYml0IGZvciBkaXJlY3RvcnkNCg0KT24gMjAxOS82
LzYgMTI6MzIsIFdhbmcgU2hpbG9uZyB3cm90ZToNCj4gRnJvbTogV2FuZyBTaGlsb25nIDx3c2hp
bG9uZ0BkZG4uY29tPg0KPg0KPiBJdCBkb2Vzbid0IG1ha2UgYW55IHNlbnNlIHRvIGhhdmUgcHJv
amVjdCBpbmhlcml0IGJpdHMNCj4gZm9yIHJlZ3VsYXIgZmlsZXMsIGV2ZW4gdGhvdWdoIHRoaXMg
d29uJ3QgY2F1c2UgYW55DQo+IHByb2JsZW0sIGJ1dCBpdCBpcyBiZXR0ZXIgZml4IHRoaXMuDQo+
DQo+IENjOiBBbmRyZWFzIERpbGdlciA8YWRpbGdlckBkaWxnZXIuY2E+DQo+IFNpZ25lZC1vZmYt
Ynk6IFdhbmcgU2hpbG9uZyA8d3NoaWxvbmdAZGRuLmNvbT4NCj4gLS0tDQo+ICBmcy9mMmZzL2Yy
ZnMuaCB8IDMgKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9mcy9mMmZzL2YyZnMuaCBiL2ZzL2YyZnMvZjJmcy5o
DQo+IGluZGV4IDA2Yjg5YTk4NjJhYi4uZjAyZWJlY2I2OGVhIDEwMDY0NA0KPiAtLS0gYS9mcy9m
MmZzL2YyZnMuaA0KPiArKysgYi9mcy9mMmZzL2YyZnMuaA0KPiBAQCAtMjM3MCw3ICsyMzcwLDgg
QEAgc3RhdGljIGlubGluZSB2b2lkIGYyZnNfY2hhbmdlX2JpdCh1bnNpZ25lZCBpbnQgbnIsIGNo
YXIgKmFkZHIpDQo+ICAgICAgICAgICAgICAgICAgICAgICAgICBGMkZTX1BST0pJTkhFUklUX0ZM
KQ0KPg0KPiAgLyogRmxhZ3MgdGhhdCBhcmUgYXBwcm9wcmlhdGUgZm9yIHJlZ3VsYXIgZmlsZXMg
KGFsbCBidXQgZGlyLXNwZWNpZmljIG9uZXMpLiAqLw0KPiAtI2RlZmluZSBGMkZTX1JFR19GTE1B
U0sgICAgICAgICAgICAgICh+KEYyRlNfRElSU1lOQ19GTCB8IEYyRlNfVE9QRElSX0ZMKSkNCj4g
KyNkZWZpbmUgRjJGU19SRUdfRkxNQVNLICAgICAgKH4oRjJGU19ESVJTWU5DX0ZMIHwgRjJGU19U
T1BESVJfRkwgfFwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRjJGU19QUk9K
SU5IRVJJVF9GTCkpDQoNCkhpIFNoaWxvbmcsDQoNCkNvdWxkIHlvdSBwbGVhc2UgYWRkIGJlbG93
IGRpZmYgYXMgZXh0NCBkaWQ/DQoNCmRpZmYgLS1naXQgYS9mcy9mMmZzL2ZpbGUuYyBiL2ZzL2Yy
ZnMvZmlsZS5jDQppbmRleCBlZmRhZmE4ODY1MTAuLjI5NWNhNWVkNDJkOSAxMDA2NDQNCi0tLSBh
L2ZzL2YyZnMvZmlsZS5jDQorKysgYi9mcy9mMmZzL2ZpbGUuYw0KQEAgLTE3NTksNiArMTc1OSw5
IEBAIHN0YXRpYyBpbnQgZjJmc19pb2NfZ2V0ZmxhZ3Moc3RydWN0IGZpbGUgKmZpbHAsIHVuc2ln
bmVkDQpsb25nIGFyZykNCg0KICAgICAgICBmc2ZsYWdzICY9IEYyRlNfR0VUVEFCTEVfRlNfRkw7
DQoNCisgICAgICAgaWYgKFNfSVNSRUcoaW5vZGUtPmlfbW9kZSkpDQorICAgICAgICAgICAgICAg
ZnNmbGFncyAmPSB+RlNfUFJPSklOSEVSSVRfRkw7DQorDQogICAgICAgIHJldHVybiBwdXRfdXNl
cihmc2ZsYWdzLCAoaW50IF9fdXNlciAqKWFyZyk7DQogfQ0KDQpUaGFua3MsDQoNCj4NCj4gIC8q
IEZsYWdzIHRoYXQgYXJlIGFwcHJvcHJpYXRlIGZvciBub24tZGlyZWN0b3JpZXMvcmVndWxhciBm
aWxlcy4gKi8NCj4gICNkZWZpbmUgRjJGU19PVEhFUl9GTE1BU0sgICAgKEYyRlNfTk9EVU1QX0ZM
IHwgRjJGU19OT0FUSU1FX0ZMKQ0KPg0K
