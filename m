Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1276B10E710
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Dec 2019 09:50:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726142AbfLBIul (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Dec 2019 03:50:41 -0500
Received: from mail-eopbgr730040.outbound.protection.outlook.com ([40.107.73.40]:12123
        "EHLO NAM05-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725977AbfLBIul (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 2 Dec 2019 03:50:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CU9vvVaexkSLIk97+AeeWjGfdyBAvffdrW4z67U6LAmHjWkTdyssGbZZKCz52xuHoifIrSwMnzs9lhL+oNJ4CQwuXMHljM1kb7Ji+08JdbDOiefhKm7PPnZif+55u2jxFcJ2LW166GMtJgL0t6aFTMQyBEvQ0mEpXtu9vBtbtDu+3ER9cj3OYiHk0O52mH8kpn1a51eLUZPAEvrK6Kr3yTse1CmltlAkdjgEpt3CzTMO98yElJL9oeeTu0ufpAZkG4mBODUKqRh0Uua7nIxAAx9JySsYoT/QmjfkZCEYzJLjor9cl1979cJ9MRceDhyskbOC3VK3ww66Z4mQsw52uA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MABOVURBy2ILNPOiB2fHAU/B267EueqI3PaKYeao7aU=;
 b=GrwFRPgOeEeoKP2zj7wBpVsuO5OKFLaT+A3A1OfbhokO1cpe/PbWj7J8igV/33NLYzipEbvk+0pWWNSCt1pRBHnhOji58w7hayPh1nwgjPOECTtvOzeBx1tDdLPUzWnBVec282s1mHIVEruLz2xV2hp0Z0t3jawz3+a5T6p4IPuU49jgnqWact3Xfmi5FPVZ9nai9UJZnsilTKuuS+wpcBOlSzItYRR8gTyJ0AEG2E6iRuQ+k10U+DWS8V9QtOx5lJhuKH5gMpfaRu4kcBf8idVkmgQnh5qhIcNsLYE93hbFTmetrDWqRgH//YXYp3ZCesHn3xdYe78mx0g0qJT9KA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MABOVURBy2ILNPOiB2fHAU/B267EueqI3PaKYeao7aU=;
 b=29hqWa/cAis+md+F9/6pFZRXw3i3fqh6v1CbCIuoLK8qMqtOzG7mgJZcdzWP8sYQw91Ulov50aCIUr6UIdQS81JgpcJTWdF52v/O+VSkP1IIai8f2mHUR3Bxwj6X8EE+XEmj78aZ/bi9kfWXMK/fnZoB2sTDLK1f4WTQHYCs8NY=
Received: from MN2PR19MB2894.namprd19.prod.outlook.com (20.178.254.95) by
 MN2PR19MB2701.namprd19.prod.outlook.com (20.178.252.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.18; Mon, 2 Dec 2019 08:50:39 +0000
Received: from MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e]) by MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e%7]) with mapi id 15.20.2495.014; Mon, 2 Dec 2019
 08:50:39 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [RFC] improve malloc for large filesystems: limit scanning at cr=0
Thread-Topic: [RFC] improve malloc for large filesystems: limit scanning at
 cr=0
Thread-Index: AQHVqO2SLyKt9MGEFkuHdSLeZ9n73w==
Date:   Mon, 2 Dec 2019 08:50:39 +0000
Message-ID: <E1A7B691-30A3-403B-950E-ECD1B86A95A4@whamcloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [128.72.176.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 677871c1-fa44-4c8d-ce93-08d77704b508
x-ms-traffictypediagnostic: MN2PR19MB2701:
x-microsoft-antispam-prvs: <MN2PR19MB27013CC11E3FCFDA640DA7CACB430@MN2PR19MB2701.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0239D46DB6
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(376002)(346002)(366004)(39850400004)(396003)(189003)(199004)(26005)(91956017)(76116006)(8936002)(2906002)(71200400001)(71190400001)(33656002)(6116002)(3846002)(478600001)(2616005)(6512007)(5660300002)(36756003)(99286004)(2501003)(14454004)(305945005)(6506007)(2351001)(81156014)(66066001)(81166006)(7736002)(6916009)(14444005)(66556008)(66476007)(86362001)(64756008)(66446008)(66946007)(102836004)(8676002)(256004)(186003)(5640700003)(6436002)(25786009)(6486002)(316002)(4744005);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB2701;H:MN2PR19MB2894.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qHTRa3gcSaNB6UfyoB4BsycgmMsw8ldBfNwRzIvCijRn0mG3RQBs+b7ehl+7ZyofKHpaBboEr/lC6V/mS2PRx0VuGwg2h0fdtbHQh5KdR2czStUIDsocSTu3gF0i1NFBMVukOEqKzhWICWoeOOPYhala4Xo74ib4pNAJoVVWHQIXRHtb7HSGacUJ2QIA0JcOQut8NZlFIpqhY1j91QLCa2YHPuU3nhkdr+amKWEgl14hP/WIYMfyKyhzw7lKd454lW1flH9I5kBBQIwRledStqot7knkp/ShKv1hfh2tSXlnoAAEa4tk+hCDiJhDi6DNdlAuK4xGWy8pdxZbB/Mbyzxc7sR81m07gZOffnBDr6JBIH6JsJLQG7xPHu+BwZApJCZrkqN5sQryGokT8GBjCdxx/53M3uh5qDES3312wbSBFhoOiismtrjN3K0LH0FS
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <A6C2C5A681D7CD49A040654CC8F53835@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677871c1-fa44-4c8d-ce93-08d77704b508
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2019 08:50:39.4963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k3YYMbl5JBGmlX6gUQCSVs2WrZgDU66Tst2YyESP3rZoTA5xT9gWISiYqPg80fdusBWH/sCnp2p2TijZFtTRCA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB2701
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGksDQoNCkkgcmVmcmVzaGVkIHRoZSBwYXRjaGVzIGEgYml0Lg0KU28gdGhlIGluaXRpYWwgcGF0
Y2ggaXMganVzdCB0byBsaW1pdCBzY2FubmluZyBhdCBjcj0wIHRvIGluaXRpYWxpc2VkIGdyb3Vw
cy4NClRoZSBpZGVhIGlzIHRoYXQgc2Nhbm5pbmcgYXQgY3I9MCBpcyBhbiBvcHRpbWlzYXRpb24g
b24gaXRzIG93biAtIGNoZWFwIGFuZCBxdWljayB3YXkgdG8gZmluZCAyXk4gbGFyZ2UgY2h1bmtz
Lg0KSSB0aGluayBpdCBtYWtlcyBubyBzZW5zZSB0byB3YWl0IG9uIElPIGZldyBtaWxsaXNlY29u
ZHMganVzdCB0byBza2lwIGEgZ3JvdXAgYmVjYXVzZSBpdOKAmXMgbm90IHBlcmZlY3QuDQoNClRo
YW5rcywgQWxleA0KDQoNCi0tLSBsaW51eC00LjE4L2ZzL2V4dDQvbWJhbGxvYy5jCTIwMTktMTEt
MjggMTQ6NTU6MjYuNTAwNTQ1OTIwICswMzAwDQorKysgbGludXgtNC4xOC9mcy9leHQ0L21iYWxs
b2MuYwkyMDE5LTExLTI4IDE0OjUzOjE4LjYwMDA4NjAwOCArMDMwMA0KQEAgLTIwNjAsNyArMjA2
MCwxNSBAQCBzdGF0aWMgaW50IGV4dDRfbWJfZ29vZF9ncm91cChzdHJ1Y3QNCiANCiAJLyogV2Ug
b25seSBkbyB0aGlzIGlmIHRoZSBncnAgaGFzIG5ldmVyIGJlZW4gaW5pdGlhbGl6ZWQgKi8NCiAJ
aWYgKHVubGlrZWx5KEVYVDRfTUJfR1JQX05FRURfSU5JVChncnApKSkgew0KLQkJaW50IHJldCA9
IGV4dDRfbWJfaW5pdF9ncm91cChhYy0+YWNfc2IsIGdyb3VwLCBHRlBfTk9GUyk7DQorCQlpbnQg
cmV0Ow0KKw0KKwkJLyogY3I9MCBpcyBhIHZlcnkgb3B0aW1pc3RpYyBzZWFyY2ggdG8gZmluZCBs
YXJnZQ0KKwkJICogZ29vZCBjaHVua3MgYWxtb3N0IGZvciBmcmVlLiBpZiBidWRkeSBkYXRhIGlz
DQorCQkgKiBub3QgcmVhZHksIHRoZW4gdGhpcyBvcHRpbWl6YXRpb24gbWFrZXMgbm8gc2Vuc2Ug
Ki8NCisNCisJCWlmIChjciA9PSAwKQ0KKwkJCXJldHVybiAwOw0KKwkJcmV0ID0gZXh0NF9tYl9p
bml0X2dyb3VwKGFjLT5hY19zYiwgZ3JvdXAsIEdGUF9OT0ZTKTsNCiAJCWlmIChyZXQpDQogCQkJ
cmV0dXJuIHJldDsNCiAJfQ0KDQo=
