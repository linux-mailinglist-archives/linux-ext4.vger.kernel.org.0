Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5069A1054B2
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Nov 2019 15:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726574AbfKUOly (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Nov 2019 09:41:54 -0500
Received: from mail-eopbgr680087.outbound.protection.outlook.com ([40.107.68.87]:16862
        "EHLO NAM04-BN3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726396AbfKUOlx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 21 Nov 2019 09:41:53 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQ5/h/Bb9slFPTaHkjP70X00M1KLwrAtJlRH+0mZB6NJu3dgOb2uEAACUlLazb+FiDjVcHmKkoXk1RtWluMwdie+Jygidlo5S7mwK4lcEqJ42j6VlPC6y3mEbIvlFcvZUN4Lrh/XKXYaTfygzqman6o8hD2G0FAUk3IuDImrV2GYgtdqDZttgpcxes0ILwLeyBeZLeOkJ80e2Nv5x3fcOW51AU6VPV9XM+tPxhhJwOeFujlt+/yQDY/AIVBfOxM9eQjGKq32U6YZekBFxhZhJrpwGS5IRNS4FRsQE++MBESotBJLL6ANMqVrxKbaUY4ncQDhf+iZqOMJOhhT0A6g9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rPmkuK6RovnNQZfKffodGbO6YrGEoz+/v7/Wjngm4Q=;
 b=j8qXmlfgpQkiGxvcIAm8d90aBCI5mWXDepz+lemWmb8xXD05fdnNE0LWYnoGpxW5kqlx+lkcM4IWVzfzCBmhrqTQsEXKiTx2TprhE/K0zy17yfmtf1Gf0DQ7pFh2ZtrcgMdrKWXYsisQdoPlySA0nmqJhXEfIpD+9RmRkDXUaBX1ILr8bPrO0B8kRjlawuAbRDlUB4gRExS9To2I1rm7zbmEaWN9cYyx4DbLTZefi+xNtU4NxNivaxsoUnRUyNl/ThpEXwbl7hYopS6HAbpWHlYNaZRHmWgo3vlAfHIgjQoujeRxu6adnyyKScUBz0EZCV0sJcWN7/VH10RtDofVAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2rPmkuK6RovnNQZfKffodGbO6YrGEoz+/v7/Wjngm4Q=;
 b=Cua7QrGQb+HaqusUM49jmLqUqteAYE+kjk8vXCUMNhRtvLswBBrPUUJBItprU48d9BYRjmq/u5s9DoxbsWJLY/v8dl9g1Q2YLkbFFwqqSZPZNUYxeNZQzAyPsGgsnWl8py1ixo8YXr4ubSWWIqDRX3f5KdqVMZY7ee+g1HMZhlk=
Received: from MN2PR19MB2894.namprd19.prod.outlook.com (20.178.254.95) by
 MN2PR19MB3501.namprd19.prod.outlook.com (10.255.90.84) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.19; Thu, 21 Nov 2019 14:41:49 +0000
Received: from MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e]) by MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e%7]) with mapi id 15.20.2474.019; Thu, 21 Nov 2019
 14:41:49 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [RFC] improve malloc for large filesystems
Thread-Topic: [RFC] improve malloc for large filesystems
Thread-Index: AQHVn45AfmzanBfwskq4XYElVj+Zs6eUXWuAgADXAYCAABhfAIAABgOAgAAHawCAAFpFAA==
Date:   Thu, 21 Nov 2019 14:41:49 +0000
Message-ID: <BCFC8274-0A4E-42E7-9D11-647D47316BD2@whamcloud.com>
References: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
 <20191120181353.GG4262@mit.edu>
 <9E04C147-D878-45CE-8473-EF8C67FE4E86@whamcloud.com>
 <4EB2303A-01A3-49AC-B713-195126DB621B@gmail.com>
 <9114E776-B44E-4CA5-BD49-C432A688C24E@whamcloud.com>
 <43DA6456-AAF9-4225-A79F-CF632AC5241B@gmail.com>
In-Reply-To: <43DA6456-AAF9-4225-A79F-CF632AC5241B@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [128.72.176.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ed65de8b-52ed-42ee-1598-08d76e90f100
x-ms-traffictypediagnostic: MN2PR19MB3501:
x-microsoft-antispam-prvs: <MN2PR19MB3501D422F2B0BA84E732503DCB4E0@MN2PR19MB3501.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0228DDDDD7
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(396003)(346002)(39850400004)(136003)(199004)(189003)(76176011)(5640700003)(6436002)(102836004)(53546011)(6506007)(2906002)(11346002)(6116002)(3846002)(2616005)(446003)(66066001)(25786009)(7736002)(186003)(6486002)(26005)(229853002)(33656002)(305945005)(14444005)(36756003)(256004)(8676002)(8936002)(81166006)(2501003)(2351001)(14454004)(86362001)(478600001)(71190400001)(71200400001)(6916009)(66556008)(64756008)(66446008)(76116006)(99286004)(66476007)(316002)(5660300002)(81156014)(66946007)(91956017)(6512007)(6246003);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB3501;H:MN2PR19MB2894.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TmKto67BTA3nhSt9vQLiOrR7hR4wQEkD8CDhONoVejFkNo0fiTR1afAK1yOcOL9qNRcGxpHKsEPJILQ00q4/7ZgtI3NeQE+yTg8ZfkkTAfrxNQiVJ0MPnpN70miTlhnwMq7B7oKkmKI+kI8On7E/rJbb2tA2uQ8ETJdvQ12lASYLL1ZRH4L0Lox107wzjk135iErf/3LNMLMRibXd46uszgRdwgbQREXYImRcT+M97j1LNdjNPfXvK1GcuGdnIUmTUaxl1gkFybNMOd9xaj991ovTx7S09DDvsRAjEzBaCvxWgI5fmXY3bCN5XvW+/t81nW2rvOe9MS7Pj6cEWpt4LtJ3N/Vp3PJPBUOG2ZQCO49dpgANKChTjCydz66ogIJ0+CA/U9qs6gbcM3F1BYI1VLDRgUXt0xMg6MOJTMEGVw9cfY2nlnmBzJtDtPiaxKl
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D2C528F1A40F64F91E6872F4DDC7FBA@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed65de8b-52ed-42ee-1598-08d76e90f100
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Nov 2019 14:41:49.0377
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xLzzcDKzl7260mBan1e0HoYFA0G3QQlKtvjhGTx9EWxqPd1ooSfqUQe9UzSKPEchYrfqFKqeG1nAhbCoaDC1IQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3501
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQoNCj4gT24gMjEgTm92IDIwMTksIGF0IDEyOjE4LCBBcnRlbSBCbGFnb2RhcmVua28gPGFydGVt
LmJsYWdvZGFyZW5rb0BnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4gY3I9MCBhbmQgY3I9MSBhcmUg
YWxzbyBpbXBvcnRhbnQuIFRoZXkgYWxsb3cgdG8gYWNjZWxlcmF0ZSBhbGxvY2F0b3IsIGJ5IGlu
Y3JlYXNpbmcgYWxsb2NhdGlvbiB3aW5kb3cuDQo+IFN0ZXAgYnkgc3RlcCBmcm9tIHNtYWxsZXN0
IHRvIHRoZSBiaWdnZXN0IHZhbHVlIGluIHByZWFsbG9jYXRpb24gdGFibGUuDQo+IFlvdXIgb3B0
aW1pc2F0aW9uIGNhbiByZXNldCB0aGlzIGFsbG9jYXRpb24gd2luZG93IGdyb3cuDQoNCkRvZXMg
aXQ/DQpJZiBhbGxvY2F0ZWQgY2h1bmsgaXMgc21hbGxlciB0aGFuIGdvYWwgb25lICh0byBwcmVk
aWN0ZWQgZmlsZXNpemUpLCB0aGVuIG5leHQgYWxsb2NhdGlvbiB3aWxsIHRyeSB0byBhbGxvY2F0
ZSB0aGUgcmVtYWluZWQsIEFGQUlSLg0KQnV0IHByZWRpY3Rpb24gZG9lc27igJl0IGRlcGVuZCBv
biB0aGUgcHJldmlvdXMgYWxsb2NhdGlvbiwgZXNzZW50aWFsbHkgaXQganVzdCBhbGlnbiBjdXJy
ZW50IGZpbGUgc2l6ZSArIGFsbG9jYXRpb24gdG8gdGhlIG5leHQgMl5uDQoob3IgZnJvbSB0aGUg
dGFibGUgaW4gb3RoZXIgdmVyc2lvbnMpLg0KDQpjcj0wIGlzIGFuIG9wdGltaXNhdGlvbiBvbiBp
dHMgb3duIGFzIGl0IGNoZWNrcyBvbmx5IDJebiBjaHVua3Mgd2hpY2ggaXMgY2hlYXAgaW4gdGVy
bXMgb2YgY3ljbGVzLg0KY3I9MSBpcyBhIG1vcmUgZXhwZW5zaXZlLCB3ZSBza2lwIGdyb3VwcyBs
aWtlbHkgaGF2aW5nIG5vIGdvb2QgZXh0ZW50cyAodXNpbmcgYXZlcmFnZSksIGJ1dCB3ZSBzdGls
bCBzZWFyY2ggZm9yIHRoZSBnb2FsIHNpemUuDQoNCj4gQXNzdW1lIHdlIGhhdmUgb25lIGZyYWdt
ZW50ZWQgcGFydCBvZiBkaXNrIGFuZCBhbGwgb3RoZXIgcGFydHMgYXJlIHF1aXRlIGZyZWUuDQo+
IEFsbG9jYXRvciB3aWxsIHNwZW5kIGEgbG90IG9mIHRpbWUgdG8gZ28gdGhyb3VnaCB0aGlzIGZy
YWdtZW50ZWQgcGFydCwgYmVjYXVzZSAgd2lsbCBicmFrZSBjcjAgYW5kIGNyMSBhbmQgZ2V0DQo+
IHJhbmdlIHRoYXQgc2F0aXNmeSBjMy4gDQoNCkV2ZW4gYXQgY3I9MyB3ZSBzdGlsbCBzZWFyY2gg
Zm9yIHRoZSBnb2FsIHNpemUuDQoNClRodXMgd2Ugc2hvdWxkbuKAmXQgcmVhbGx5IGFsbG9jYXRl
IGJhZCBjaHVua3MgYmVjYXVzZSB3ZSBicmVhayBjcj0wIGFuZCBjcj0xLCB3ZSBqdXN0IHN0b3Ag
dG8gbG9vayBmb3IgbmljZWx5IGxvb2tpbmcgZ3JvdXBzDQphbmQgZmFsbGJhY2sgdG8gcmVndWxh
ciAobW9yZSBleHBlbnNpdmUpIHNlYXJjaCBmb3IgZnJlZSBleHRlbnRzLg0KDQo+IA0KPiBjMyBy
ZXF1aXJlbWVudCBpcyBxdWl0ZSBzaW1wbGUg4oCcZ2V0IGZpcnN0IGdyb3VwIHRoYXQgaGF2ZSBl
bm91Z2ggZnJlZSBibG9ja3MgdG8gYWxsb2NhdGUgcmVxdWVzdGVkIHJhbmdl4oCdLg0KDQpUaGlz
IGlzIG9ubHkgZ3JvdXAgc2VsZWN0aW9uLCB0aGVuIHdlIHRyeSB0byBmaW5kIHRoYXQgZXh0ZW50
IHdpdGhpbiB0aGF0IGdyb3VwLCBjYW4gZmFpbCBhbmQgbW92ZSB0byB0aGUgbmV4dCBncm91cC4N
CkVYVDRfTUJfSElOVF9GSVJTVCBpcyBzZXQgb3V0c2lkZSBvZiB0aGUgbWFpbiBjcj0wLi4zIGxv
b3AuDQoNCj4gV2l0aCBoaWdodCBwcm9iYWJpbGl0eSBhbGxvY2F0b3IgZmluZCBzdWNoIGdyb3Vw
IGF0IHRoZSBzdGFydCBvZiBjMyBsb29wLCBzbyBnb2FsIChhbGxvY2F0b3Igc3RhcnRzIGl0cyBz
ZWFyY2hpbmcgZnJvbSBnb2FsKSB3aWxsIG5vdCBzaWduaWZpY2FudGx5IGNoYW5nZWQuDQo+IFRo
dXMgYWxsb2NhdG9yIGdvIHRocm91Z2ggdGhpcyBmcmFnbWVudGVkIHJhbmdlIHVzaW5nIHNtYWxs
IHN0ZXBzLg0KPiANCj4gV2l0aG91dCBzdWdnZXN0ZWQgb3B0aW1pc2F0aW9uLCBhbGxvY2F0b3Ig
c2tpcHMgdGhpcyBmcmFnbWVudGVkIHJhbmdlIGF0IG1vbWVudCBhbmQgY29udGludWUgdG8gYWxs
b2NhdGUgYmxvY2tzLg0KDQoxMDAwIGdyb3VwcyAqIDVtcyBhdmcudGltZSA9IDUgc2Vjb25kcyB0
byBza2lwIDEwMDAgYmFkIHVuaW5pdGlhbGl6ZWQgZ3JvdXBzLiBUaGlzIGlzIHRoZSByZWFsIHBy
b2JsZW0uDQpZb3UgbWVudGlvbmVkIDRNIGdyb3Vwcy4uLg0KDQpUaGFua3MsIEFsZXgNCiA=
