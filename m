Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D02B6385B8
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Jun 2019 09:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbfFGHvV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jun 2019 03:51:21 -0400
Received: from mail-eopbgr700087.outbound.protection.outlook.com ([40.107.70.87]:59744
        "EHLO NAM04-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726668AbfFGHvU (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 7 Jun 2019 03:51:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6cSWUm3ysr5+RNRb7RKW9RTe5YYg8e5nPGwdOzPJypw=;
 b=rR2sy65mGMjxcldvkuRv6S0yMQcnULTLx9aRxpo/23v+58E4myDwVMvDOpAfz9BSh0+rZM/bh8Kzojm6G/o1BUVOhqq/BwJWM+nfvORkqh3TzANHVk/74q9zDmaUWC3RkPiB+6RPKCDOVqchIWVehwttBRdm6jXey1F98fj8mp0=
Received: from MN2PR19MB3167.namprd19.prod.outlook.com (10.255.181.16) by
 MN2PR19MB2735.namprd19.prod.outlook.com (20.178.253.76) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.13; Fri, 7 Jun 2019 07:51:18 +0000
Received: from MN2PR19MB3167.namprd19.prod.outlook.com
 ([fe80::dc80:b43c:bae8:93ac]) by MN2PR19MB3167.namprd19.prod.outlook.com
 ([fe80::dc80:b43c:bae8:93ac%6]) with mapi id 15.20.1943.026; Fri, 7 Jun 2019
 07:51:18 +0000
From:   Wang Shilong <wshilong@ddn.com>
To:     Eric Biggers <ebiggers@kernel.org>,
        Wang Shilong <wangshilong1991@gmail.com>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Andreas Dilger <adilger@dilger.ca>
Subject: =?utf-8?B?5Zue5aSNOiBbZjJmcy1kZXZdIFtQQVRDSCAxLzJdIGV4dDQ6IG9ubHkgc2V0?=
 =?utf-8?Q?_project_inherit_bit_for_directory?=
Thread-Topic: =?utf-8?B?5Zue5aSNOiBbZjJmcy1kZXZdIFtQQVRDSCAxLzJdIGV4dDQ6IG9ubHkgc2V0?=
 =?utf-8?Q?_project_inherit_bit_for_directory?=
Thread-Index: AQHVHCDgP31HN+WHkUOSSixxIe14jqaPOs2AgAEcVks=
Date:   Fri, 7 Jun 2019 07:51:18 +0000
Message-ID: <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>,<20190606224525.GB84833@gmail.com>
In-Reply-To: <20190606224525.GB84833@gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wshilong@ddn.com; 
x-originating-ip: [36.62.197.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2640f44-2521-491f-52af-08d6eb1ced0a
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR19MB2735;
x-ms-traffictypediagnostic: MN2PR19MB2735:
x-microsoft-antispam-prvs: <MN2PR19MB27352A172E408ED1BC881488D4100@MN2PR19MB2735.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0061C35778
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39850400004)(376002)(366004)(136003)(346002)(396003)(189003)(199004)(43544003)(4326008)(476003)(14454004)(26005)(53936002)(446003)(66066001)(6506007)(99286004)(76176011)(52536014)(102836004)(224303003)(68736007)(7696005)(86362001)(11346002)(2906002)(25786009)(71190400001)(71200400001)(186003)(486006)(54906003)(110136005)(478600001)(33656002)(316002)(6436002)(66446008)(66556008)(64756008)(66476007)(305945005)(7736002)(8936002)(81166006)(55016002)(74316002)(5660300002)(81156014)(6116002)(73956011)(3846002)(76116006)(9686003)(4744005)(66946007)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB2735;H:MN2PR19MB3167.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: qVZM2XaB7Ael6yTX4efDK5+OJja/aGK9DiqI2PhFbXoHZQtVXALOW4JcOh6jK0AjMHagxIhpUgASjPuYV1yRVeMzSp3JrAAQnJqzQ9R0VpsdXZEnwhe4/AtssdITAtsiPiWT9gEGXUBaBp2odnFYLLGaxVhYoA/7/kDreiEO0uj4JI5eh8E2prhLKWQ8Q83CK9gdK6OV/M4r8kPa5NWIQrLnm63I9Ef/cG+iVfavUgR1v04t/3br5iklEGbqOpzeFHtgmENxWhSLLfpy5Np2qbbiTT+knkeJMzbRjyKlBRj3inmlPaJgwo8LZ3o8hSnw8uTDV57xtKVpBaC6hkqi3cQY5qPKczO8bu2Umo0il1k2yd4v/1EnxW5xTWsBLTJLh3dN4xw43ZdpU2DCdIXJ63p6AAthTrtvqY05zMk47DE=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2640f44-2521-491f-52af-08d6eb1ced0a
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Jun 2019 07:51:18.5603
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wshilong@ddn.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2735
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGksCgo+IC0tCj4gMi4yMS4wCgpXb24ndCB0aGlzIGJyZWFrICdjaGF0dHInIG9uIGZpbGVzIHRo
YXQgYWxyZWFkeSBoYXZlIHRoaXMgZmxhZyBzZXQ/CkZTX0lPQ19HRVRGTEFHUyB3aWxsIHJldHVy
biB0aGlzIGZsYWcsIHNvICdjaGF0dHInIHdpbGwgcGFzcyBpdCBiYWNrIHRvCkZTX0lPQ19TRVRG
TEFHUyB3aGljaCB3aWxsIHJldHVybiBFT1BOT1RTVVBQIGR1ZSB0byB0aGlzOgoKwqAgwqAgwqAg
wqAgaWYgKGV4dDRfbWFza19mbGFncyhpbm9kZS0+aV9tb2RlLCBmbGFncykgIT0gZmxhZ3MpCsKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIHJldHVybiAtRU9QTk9UU1VQUDsKCj4+Pj4KCllvdSBhcmUg
cmlnaHQgZm9yIHRoaXMgYW5kIHdlIGFsc28gbmVlZCB0YWtlIGNhcmUgb2YgdGhpcyBpbiBFWFQ0
X0lPQ19GU1NFVFhBVFRSLwp0aGlzIGlzIGEgYml0IHN0cmFuZ2UgYmVoYXZpb3IgYXMgY2hhdHRy
IHJlYWQgZXhpc3RlZCBmbGFncwpidXQgY291bGQgbm90IHNldCB0aGVtIGFnYWluLCB0aGVyZSBh
cmUgc2V2ZXJhbCBwb3NzaWJsZSB3YXlzIHRoYXQgSSBjb3VsZCB0aGluawpvZiB0byBmaXggdGhl
IGlzc3VlPwoKMSkgY2hhbmdlIGNoYXR0ciB0byBmaWx0ZXIgUHJvamVjdCBpbmhlcml0IGJpdCBi
ZWZvcmUgY2FsbCBGU19JT0NfU0VURkxBR1MKCjIpIHdlIGF1dG9tYXRpY2FsbHkgZml4ZWQgdGhl
IGZsYWcgYmVmb3JlIG1hc2sgY2hlY2ssIHNvbWV0aGluZyBsaWtlOgppZiByZWc6CiAgICAgZmxh
Z3MgJj0gflBST0pFQ1RfSU5IRVJUOwogICAgICBpZiAoZXh0NF9tYXNrX2ZsYWdzKGlub2RlLT5p
X21vZGUsIGZsYWdzKSAhPSBmbGFncykKwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgcmV0dXJuIC1F
T1BOT1RTVVBQOwpCdXQgdGhpcyBtaWdodCBiZSBub3QgZ29vZC4uCgpJIHdvdWxkIHByZWZlciBz
b2x1dGlvbiAxKQpXaGF0IGRvIHlvdSB0aGluaz8K
