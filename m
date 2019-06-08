Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1A63E399FF
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Jun 2019 03:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729794AbfFHBPE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 7 Jun 2019 21:15:04 -0400
Received: from mail-eopbgr820050.outbound.protection.outlook.com ([40.107.82.50]:17920
        "EHLO NAM01-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729685AbfFHBPE (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 7 Jun 2019 21:15:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nVcJQKO+5t3F77zqiSVgDZwlPu6eEgTWX9MpY3F5fxM=;
 b=Ax780CPEBIrLboYCMcV6LxkoHHtO1pUxpW47N/QN88/6PHmrjxJc79AEtBx8JN7RDcaJV4Ep9GBhEk5NnOhuGZQZdHBPa4HxYyLoKdT5jDb6HN9p9D9a8yVmX3mf069gugFcOc5sF3AocsSEGLeA3v40PZY4u+/T1Eg6oaSGbxk=
Received: from MN2PR19MB3167.namprd19.prod.outlook.com (10.255.181.16) by
 MN2PR19MB2590.namprd19.prod.outlook.com (20.179.81.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1965.14; Sat, 8 Jun 2019 01:15:00 +0000
Received: from MN2PR19MB3167.namprd19.prod.outlook.com
 ([fe80::dc80:b43c:bae8:93ac]) by MN2PR19MB3167.namprd19.prod.outlook.com
 ([fe80::dc80:b43c:bae8:93ac%6]) with mapi id 15.20.1943.026; Sat, 8 Jun 2019
 01:15:00 +0000
From:   Wang Shilong <wshilong@ddn.com>
To:     Eric Biggers <ebiggers@kernel.org>
CC:     Wang Shilong <wangshilong1991@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        Andreas Dilger <adilger@dilger.ca>
Subject: =?gb2312?B?u9i4tDogu9i4tDogW2YyZnMtZGV2XSBbUEFUQ0ggMS8yXSBleHQ0OiBvbmx5?=
 =?gb2312?Q?_set_project_inherit_bit_for_directory?=
Thread-Topic: =?gb2312?B?u9i4tDogu9i4tDogW2YyZnMtZGV2XSBbUEFUQ0ggMS8yXSBleHQ0OiBvbmx5?=
 =?gb2312?Q?_set_project_inherit_bit_for_directory?=
Thread-Index: AQHVHCDgP31HN+WHkUOSSixxIe14jqaPOs2AgAEcVkuAACpoAIAA+SiR
Date:   Sat, 8 Jun 2019 01:15:00 +0000
Message-ID: <MN2PR19MB316710380735D81840557886D4110@MN2PR19MB3167.namprd19.prod.outlook.com>
References: <1559795545-17290-1-git-send-email-wshilong1991@gmail.com>
 <20190606224525.GB84833@gmail.com>
 <MN2PR19MB3167ED3E8C9C85AE510F7BF4D4100@MN2PR19MB3167.namprd19.prod.outlook.com>,<20190607181452.GC648@sol.localdomain>
In-Reply-To: <20190607181452.GC648@sol.localdomain>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=wshilong@ddn.com; 
x-originating-ip: [36.62.197.185]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 783413a5-8d2d-496a-c0be-08d6ebaebaa9
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR19MB2590;
x-ms-traffictypediagnostic: MN2PR19MB2590:
x-microsoft-antispam-prvs: <MN2PR19MB2590DBBE1D80B516507F9978D4110@MN2PR19MB2590.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0062BDD52C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(346002)(39850400004)(136003)(396003)(199004)(43544003)(189003)(52536014)(25786009)(74316002)(99286004)(76176011)(5660300002)(86362001)(8936002)(54906003)(71190400001)(71200400001)(6506007)(486006)(53936002)(81166006)(81156014)(446003)(102836004)(305945005)(7736002)(26005)(476003)(186003)(11346002)(316002)(6916009)(478600001)(6436002)(14454004)(3846002)(6116002)(4326008)(224303003)(55016002)(68736007)(14444005)(256004)(33656002)(73956011)(66446008)(66946007)(2906002)(66556008)(76116006)(64756008)(66476007)(9686003)(7696005)(66066001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB2590;H:MN2PR19MB3167.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: ddn.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pqnXbRjTeD4oMZM6+5iMCOKkHOi15Tp2KoKz1mRjXim1ZHyNyilxNwsDgOhLULvacCTqY5rIJ7PnsLfOOdl3Pg+Bi0rbBeZcRPuDHEyUw7At2XhgXvyvu2NmY1yR4hpD1Cclm8ikIRAm0jTv81+WqHAzRbDTgNnkiLm+guwurYBDfRQqClM4Pq4eUEahh/amZ3CuzVI6v3tuPV00lVLJp5IISWdjMV3MfH/1uESo7IEgcEf0oc3CcMGAOVFpKYnh9ayPvBGHmnQcqG02A3zTYq/GXdq7TZmt3NTC4+G5RaxWevttmulwxVm18NhTf5TiRKjVdDMgS21hQJuVt4I2Q/wFj7J73LmNQuseqRKiFpHtOywIx/LjZGk6MJzkIIFkkkjGA0Un3tF2kAV3ZO7bYnV8LStqtfa3MmwRmST/PCs=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: ddn.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 783413a5-8d2d-496a-c0be-08d6ebaebaa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2019 01:15:00.5729
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wshilong@ddn.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2590
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGksCgoKPiBZb3UgYXJlIHJpZ2h0IGZvciB0aGlzIGFuZCB3ZSBhbHNvIG5lZWQgdGFrZSBjYXJl
IG9mIHRoaXMgaW4gRVhUNF9JT0NfRlNTRVRYQVRUUi8KPiB0aGlzIGlzIGEgYml0IHN0cmFuZ2Ug
YmVoYXZpb3IgYXMgY2hhdHRyIHJlYWQgZXhpc3RlZCBmbGFncwo+IGJ1dCBjb3VsZCBub3Qgc2V0
IHRoZW0gYWdhaW4sIHRoZXJlIGFyZSBzZXZlcmFsIHBvc3NpYmxlIHdheXMgdGhhdCBJIGNvdWxk
IHRoaW5rCj4gb2YgdG8gZml4IHRoZSBpc3N1ZT8KPgo+IDEpIGNoYW5nZSBjaGF0dHIgdG8gZmls
dGVyIFByb2plY3QgaW5oZXJpdCBiaXQgYmVmb3JlIGNhbGwgRlNfSU9DX1NFVEZMQUdTCj4KPiAy
KSB3ZSBhdXRvbWF0aWNhbGx5IGZpeGVkIHRoZSBmbGFnIGJlZm9yZSBtYXNrIGNoZWNrLCBzb21l
dGhpbmcgbGlrZToKPiBpZiByZWc6Cj4gICAgICBmbGFncyAmPSB+UFJPSkVDVF9JTkhFUlQ7Cj4g
ICAgICAgaWYgKGV4dDRfbWFza19mbGFncyhpbm9kZS0+aV9tb2RlLCBmbGFncykgIT0gZmxhZ3Mp
Cj4gICAgICAgICAgICAgICAgIHJldHVybiAtRU9QTk9UU1VQUDsKPiBCdXQgdGhpcyBtaWdodCBi
ZSBub3QgZ29vZC4uCj4KPiBJIHdvdWxkIHByZWZlciBzb2x1dGlvbiAxKQo+IFdoYXQgZG8geW91
IHRoaW5rPwoKRXhpc3RpbmcgdmVyc2lvbnMgb2YgY2hhdHRyIGNhbid0IGJlIGNoYW5nZWQsIGFu
ZCBwZW9wbGUgZG9uJ3QgbmVjZXNzYXJpbHkKdXBncmFkZSB0aGUga2VybmVsIGFuZCBlMmZzcHJv
Z3MgYXQgdGhlIHNhbWUgdGltZS4gIFNvICgxKSB3b3VsZG4ndCByZWFsbHkgd29yay4KCkEgYmV0
dGVyIHNvbHV0aW9uIG1pZ2h0IGJlIHRvIG1ha2UgRlNfSU9DX0dFVEZMQUdTIGFuZCBGU19JT0Nf
RlNHRVRYQVRUUiBuZXZlcgpyZXR1cm4gdGhlIHByb2plY3QgaW5oZXJpdCBmbGFnIG9uIHJlZ3Vs
YXIgZmlsZXMuCgotIEVyaWMKCj4+Pj4+PgoKSG93IGFib3V0IGZpeCBpdCBpbiAgX19leHQ0X2ln
ZXQoKToKCiAgZWktPmlfZmxhZ3MgPSBsZTMyX3RvX2NwdShyYXdfaW5vZGUtPmlfZmxhZ3MpOwog
IGlmIChTX0lTUkVHKGlub2RlLT5pX21vZGUpKQogICAgICAgZWktPmlfZmxhZ3MgJj0gfkVYVDRf
UFJPSklOSEVSSVRfRkw7CgpUaGlzIHdheSB3aWxsIGdpdmUgYSBiaWcgY2hhbmNlIGZsYWcgd2ls
bCBiZSBhdXRvbWF0aWNhbGx5IGZpeGVkCm5leHQgdGltZSB3aGVuZXZlciBpbm9kZSBpcyBkaXJ0
aWVkLgoKVGhhbmtzLApTaGlsb25n
