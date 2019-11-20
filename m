Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 15A1C10433B
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 19:22:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727942AbfKTSWc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Nov 2019 13:22:32 -0500
Received: from mail-eopbgr760085.outbound.protection.outlook.com ([40.107.76.85]:48192
        "EHLO NAM02-CY1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726675AbfKTSWc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 Nov 2019 13:22:32 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=inoFYTwQ7igEasLJl9bH0UoEqV8eu4vwu8QAWd8vCJLExLY+V2mTz9Sw8WyBg9A4ypyCwtyKAjyX6+n5kBnRgYTpqKg8yjwKuP7jHNi0eenKXxYhX9m7QtTT3O1xTwb8TX258u9rwP7XizAe18B3DrW8kVv0PECQ2NtU6J4YAKMxLtyD0721raz3wpkv9mFFjjW783uvcIWecO+tqe9KaW2Y+gCVKbvTgHLJNA9mqnO7daM3I7bVJ/KrPCwIL0KWkjYz2fLcyxuwm2TOfC91lvsNJRzASVOegdeGhLqk+XEQg4ljqH1jTJedde5AqslPq2GQBgKPjiO544LGCiyIHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OqSk7mrJhLanLbUICVmnjanqNZX1dgn0sw1apWT12k=;
 b=E/ciWWnC9tEee1OKuWS6qjT/f9uK5vFTyGQb1wSOjhh2ZKLgXfww8d3lGX5vKJK6Yd4sm5SFIQggaIR524TUZSfrioRaj2eSm39K5QtcloAvBSgk+mBa8MtJQgliO49sLM8j54RLOJOLBGGngCCcqIw87lyasmllPmrbX1Oz6RKzu2THCvXCKHYPq+WRxAffPJ/X7kljgP0ixLl+NF74BYO+tlvAqOzNcAsE3214wcieMcq72RrHT7YNzeAFP22F0RMCRFYRjk4T36VNHB6friTFIoBgDp7h5LgkeI1nrw+RZzGmd3O8HgT+6BHvUW9FMl6my7GpbmFPN4gPbBcKQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4OqSk7mrJhLanLbUICVmnjanqNZX1dgn0sw1apWT12k=;
 b=nkm0BSdW4F2rnfhKg9oUMiXnT8ngR4rt7GLwC+iQOxygo3fZkKi8T0NWPgnN+79wuUhaO4olJ8kpmyxnIgJ3AO6OQXCbAEGpdvhmtwGF0RbpAJKUhe4ASddlLeGBl5cj460uD5J5pPr3mSQlODb++pJIdqcjqCsCRQZCCM4x6NI=
Received: from MN2PR19MB2894.namprd19.prod.outlook.com (20.178.254.95) by
 MN2PR19MB3519.namprd19.prod.outlook.com (52.135.37.220) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 18:22:28 +0000
Received: from MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e]) by MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 18:22:28 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Alex Zhuravlev <azhuravlev@whamcloud.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: Re: [RFC] improve malloc for large filesystems
Thread-Topic: [RFC] improve malloc for large filesystems
Thread-Index: AQHVn45AfmzanBfwskq4XYElVj+Zs6eUXWuAgAACZYA=
Date:   Wed, 20 Nov 2019 18:22:28 +0000
Message-ID: <B5982325-9332-4F55-A989-9D51F172F500@whamcloud.com>
References: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
 <20191120181353.GG4262@mit.edu>
In-Reply-To: <20191120181353.GG4262@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [128.72.176.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 786cf345-cc14-4c1d-d45c-08d76de699a7
x-ms-traffictypediagnostic: MN2PR19MB3519:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR19MB35198401A6C6C479B5CF3E54CB4F0@MN2PR19MB3519.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(376002)(136003)(39850400004)(366004)(51914003)(189003)(199004)(78114003)(71190400001)(186003)(3846002)(478600001)(14444005)(256004)(66556008)(66476007)(33656002)(66446008)(64756008)(486006)(66946007)(316002)(2906002)(6916009)(8936002)(4326008)(76116006)(8676002)(91956017)(14454004)(6436002)(6512007)(76176011)(7736002)(305945005)(54906003)(6116002)(81156014)(81166006)(86362001)(6486002)(6506007)(99286004)(36756003)(26005)(229853002)(2171002)(446003)(66066001)(476003)(102836004)(71200400001)(2616005)(11346002)(25786009)(53546011)(6246003)(5660300002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB3519;H:MN2PR19MB2894.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KWNNwsLEExF/4GkVJD+v5OaAi2psJNvrPBYfDBn2sY2VSIiIZI+ZYVGqwr07/JegaDwI7I2fTq6Z4yUpm+bVRW81cWRt2d5pUfK4M4Qw0oo3JYHOL2MvdEIB4MQbcBVwbGYfcLKYdCQskPuoejT2NKRnqGafGHHSU20hVo5ZI8WjuZoKxLFJDmF+IgaaGzrJ1CqGOOV0RZdy6u+groiKgP4Dr5S+1AhYpJfzuKIZOqyp+Wd/elu19aRlXAHqQG0IuXvp/fUcNaO+gzzKioGWHngysjcLobcyxzPw+0h5X7nqEQHZ7UeLVoY+xs9dKQwO9hk2lDlIM4HVvYkNJOQWdaLXpCGZG+Q+50v/iR11N2ywYOpt7d7rPdn2fnYbrWSj9SkBazkroYXpvlEIrPVG33b7SJTgrapq82M8/yx2dEWJ9stkWlKzYVh7LSxjs76+
Content-Type: text/plain; charset="utf-8"
Content-ID: <07B0827CE3F67142BFAB1A889E43DCE2@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 786cf345-cc14-4c1d-d45c-08d76de699a7
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 18:22:28.2683
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: AWq4Ch8AmFKM8Pvm1flJwuYzCzPt+UEOolDjn81w+TeejlD2f2qcNn4J4VDm9NbJtN+tC0HR2kvM5C3liELcNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3519
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQoNClRoYW5rcyBmb3IgdGhlIGZlZWRiYWNrLg0KDQo+IE9uIDIwIE5vdiAyMDE5LCBhdCAyMTox
MywgVGhlb2RvcmUgWS4gVHMnbyA8dHl0c29AbWl0LmVkdT4gd3JvdGU6DQo+IA0KPiBIaSBBbGV4
LA0KPiANCj4gQSBjb3VwbGUgb2YgY29tbWVudHMuICBGaXJzdCwgcGxlYXNlIHNlcGFyYXRlIHRo
aXMgcGF0Y2ggc28gdGhhdCB0aGVzZQ0KPiB0d28gc2VwYXJhdGUgcGllY2VzIG9mIGZ1bmN0aW9u
YWxpdHkgY2FuIGJlIHJldmlld2VkIGFuZCB0ZXN0ZWQNCj4gc2VwYXJhdGVseToNCg0KU3VyZSwg
dGhhdCBtYWtlcyBzZW5zZS4NCg0KPiANCj4gQXMgZmFyIHRoZSBwcmVmZXRjaCBpcyBjb25jZXJu
ZWQsIHBsZWFzZSBub3RlIHRoYXQgdGhlIGJpdG1hcCBpcyBmaXJzdA0KPiByZWFkIGludG8gdGhl
IGJ1ZmZlciBjYWNoZSB2aWEgcmVhZF9ibG9ja19iaXRtYXBfbm93YWl0KCksIGJ1dCB0aGVuIGl0
DQo+IG5lZWRzIHRvIGJlIGNvcGllZCBpbnRvIGJ1ZGR5IGJpdG1hcCBwYWdlcyB3aGVyZSBpdCBp
cyBjYWNoZWQgYWxvbmcNCj4gc2lkZSB0aGUgYnVkZHkgYml0bWFwLiAgKFRoZSBjb3B5IGluIHRo
ZSBidWRkeSBiaXRtYXAgaXMgYSBjb21iaW5hdGlvbg0KPiBvZiB0aGUgb24tZGlzayBibG9jayBh
bGxvY2F0aW9uIGJpdG1hcCBwbHVzIGFueSBvdXRzdGFuZGluZw0KPiBwcmVhbGxvY2F0aW9ucy4p
ICBGcm9tIHRoYXQgY29weSBvZiBibG9jayBiaXRtYXAsIHdlIHRoZW4gZ2VuZXJhdGUgdGhlDQo+
IGJ1ZGR5IGJpdG1hcCBhbmQgYXMgYSBzaWRlIGVmZmVjdCwgaW5pdGlhbGl6ZSB0aGUgc3RhdGlz
dGljcw0KPiAoZ3JwLT5iYl9maXJzdF9mcmVlLCBncnAtPmJiX2xhcmdlc3RfZnJlZV9vcmRlciwg
Z3JwLT5iYl9jb3VudGVyc1tdKS4NCg0KPiBJdCBpcyB0aGVzZSBzdGF0aXN0aWNzIHRoYXQgd2Ug
bmVlZCB0byBiZSBhYmxlIHRvIG1ha2UgYWxsb2NhdGlvbg0KPiBkZWNpc2lvbnMgZm9yIGEgcGFy
dGljdWxhciBibG9jayBncm91cC4gIFNvIHBlcmhhcHMgd2Ugc2hvdWxkIGRyaXZlDQo+IHRoZSBy
ZWFkYWhlYWQgb2YgdGhlIGJpdG1hcHMgZnJvbSBleHQ0X21iX2luaXRfZ3JvdXAoKSAvDQo+IGV4
dDRfbWJfaW5pdF9jYWNoZSgpLCBhbmQgbWFrZSBzdXJlIHRoYXQgd2UgYWN0dWFsbHkgaW5pdGlh
bGl6ZSB0aGUNCj4gZXh0NF9ncm91cF9pbmZvIHN0cnVjdHVyZSwgYW5kIG5vdCBqdXN0IHJlYWQg
dGhlIGJpdG1hcCBpbnRvIGJ1ZmZlcg0KPiBjYWNoZSBhbmQgaG9wZSBpdCBnZXRzIHVzZWQgYmVm
b3JlIG1lbW9yeSBwcmVzc3VyZSBwdXNoZXMgaXQgb3V0IG9mDQo+IHRoZSBidWRkeSBjYWNoZS4N
Cg0KSW5kZWVkLCBidXQgdGhlIHBvaW50IGlzIHRoYXQgbWFqb3JpdHkgb2YgdGltZSBpcyBJTyBp
dHNlbGYsIHNvIGhhdmluZyBiaXRtYXANCkluIHRoZSBidWZmZXIgY2FjaGUgc2hvdWxkIGltcHJv
dmUsIHJpZ2h0PyBOb3QgdGhhdCBJ4oCZbSBhZ2FpbnN0IGJ1ZGR5DQpJbml0aWFsaXNhdGlvbiwg
YnV0IHRoaXMgd291bGQgYWRkIGV4dHJhIGNvbXBsZXhpdHkgYW5kIG5vdCB0aGF0IG11Y2ggb2YN
CnBlcmZvcm1hbmNlLCBJTU8NCg0KTWVtb3J5IHByZXNzdXJlIGlzIGEgZ29vZCBwb2ludCB0aG91
Z2guIERvIHlvdSB0aGluayB0b3VjaGluZyBiaXRtYXANCmJoL3BhZ2UgY291bGQgYmUgZW5vdWdo
IHRvIHByZXZlbnQgZWFybHkgZHJvcHBpbmc/DQpJIGNhbiBpbnRyb2R1Y2UgYW5vdGhlciBJTyBj
b21wbGV0aW9uIHJvdXRpbmUgdG8gc2NoZWR1bGUgYnVkZHkgaW5pdC4NCg0KPiBBbmRyZWFzIGhh
cyBzdWdnZXN0ZWQgZ29pbmcgZXZlbiBmYXJ0aGVyLCBhbmQgcGVyaGFwcyBzdG9yaW5nIHRoaXMN
Cj4gZGVyaXZlZCBpbmZvcm1hdGlvbiBmcm9tIHRoZSBhbGxvY2F0aW9uIGJpdG1hcHMgc29tZXBs
YWNlIGNvbnZlbmllbnQNCj4gb24gZGlzay4gIFRoaXMgaXMgYW4gb24tZGlzayBmb3JtYXQgY2hh
bmdlLCBzbyB3ZSB3b3VsZCB3YW50IHRvIHRoaW5rDQo+IHZlcnkgY2FyZWZ1bGx5IGJlZm9yZSBn
b2luZyBkb3duIHRoYXQgcGF0aC4gIEVzcGVjaWFsbHkgc2luY2UgaWYgd2UncmUNCj4gZ29pbmcg
dG8gZ28gdGhpcyBmYXIsIHBlcmhhcHMgd2Ugc2hvdWxkIGNvbnNpZGVyIHVzaW5nIGFuIG9uLWRp
c2sNCj4gYi10cmVlIHRvIHN0b3JlIHRoZSBhbGxvY2F0aW9uIGluZm9ybWF0aW9uLCB3aGljaCBj
b3VsZCBiZSBtb3JlDQo+IGVmZmljaWVudCB0aGFuIHVzaW5nIGFsbG9jYXRpb24gYml0bWFwcyBw
bHVzIGJ1ZGR5IGJpdG1hcHMuDQoNClRoaXMgaXMgd2hhdCBJIG5vcm1hbGx5IHRyeSB0byBhdm9p
ZCwgYnV0IGluIGdlbmVyYWwgbm8gb2JqZWN0aW9uLg0KDQpUaGFua3MsIEFsZXgNCg0K
