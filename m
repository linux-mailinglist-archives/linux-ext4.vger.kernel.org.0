Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1568C1037A5
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Nov 2019 11:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728032AbfKTKfo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Nov 2019 05:35:44 -0500
Received: from mail-eopbgr800073.outbound.protection.outlook.com ([40.107.80.73]:22270
        "EHLO NAM03-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727697AbfKTKfo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 20 Nov 2019 05:35:44 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KL3DBsayNv30+jibsrFH7RDc1G0KUynlty5bqoAVlDmVrZYCmthm3hphH1GY36u+C9FMXk5uQtRZoKlF8F+vcV/1K4rE6iKZtibHGb1H8ifzZ1RiIvleYcvqaiYzECVUEyGiV931NJWetNO7ALTXxtq49cyhaFgIQehvyNmd5VcRI49k4vsyxAWStt+RMrHgGgGY7Q9SFxWrCfiRgK5m6MNqc01DLJRIAYDYnGlTT+l0SPJgxFYjIEsflMdx81YmTAP3b9LY+W12LiFBSKLT2xasWAo6WD39vcb8BwW2l3Fmo4+nCMfqTsQqwojL0ZpoZxSMskQRauQQ34HJarP9ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLKphau/c/1NtVuDl+kZANf0p8L4oZafsDWsGPi0NC8=;
 b=U+19ZKPOsxHHsJzO6lnSTf5FoP7UQkiZMW1beWYuDnEYzS0o9zOFftKfmtpLsifeppIvVriANCfIdQA1ZSNDZfTAo/3YiwhKTN/AS38TyK0K5O4BE6Ni6uMoUiBrm7zp+QEgICqtMLgA0kgumyIB0u6gJNAXpA2XCG8BMY8vG79j8SNemUjaJO8I+mq2L2hkWklBPFhMvdXICGYsDN0GmWTNWuZjl4bskF9bUDBNN7XOoiT84dsQL0F6xPeb5CiIeu8nUmpUlaeijE3SeXgSIbGUDQmNIZ+gRhyUizWkHGtnI6ktXaj9KYumoLEwf6ucU+Zw4PxVGF/TDdiEGDs9+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=whamcloud.com; dmarc=pass action=none
 header.from=whamcloud.com; dkim=pass header.d=whamcloud.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=whamcloud.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bLKphau/c/1NtVuDl+kZANf0p8L4oZafsDWsGPi0NC8=;
 b=I8NLHc3mIi8zYyx1o6UAPUC4VvNSrmEuo7naqAoOdXmh6OYkwrwcKotOkMiKRg8vDoxRNwJG1nY0NcsiZbdx1HKSI41RerdZrKZ65XWAWNaxBSyY0afhx5kKQhiNuLLtA5PKgMVBm/yD1+oOaYnrNM5WBPP7zW/UN5u7lpienxE=
Received: from MN2PR19MB2894.namprd19.prod.outlook.com (20.178.254.95) by
 MN2PR19MB3742.namprd19.prod.outlook.com (10.186.145.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2474.17; Wed, 20 Nov 2019 10:35:38 +0000
Received: from MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e]) by MN2PR19MB2894.namprd19.prod.outlook.com
 ([fe80::a499:dae8:b1c1:b08e%7]) with mapi id 15.20.2451.029; Wed, 20 Nov 2019
 10:35:38 +0000
From:   Alex Zhuravlev <azhuravlev@whamcloud.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Subject: [RFC] improve malloc for large filesystems
Thread-Topic: [RFC] improve malloc for large filesystems
Thread-Index: AQHVn44/D8VmnxREB0i1ZrsSwjwsLA==
Date:   Wed, 20 Nov 2019 10:35:38 +0000
Message-ID: <8738E8FF-820F-48A5-9150-7FF64219ED42@whamcloud.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=azhuravlev@whamcloud.com; 
x-originating-ip: [128.72.176.24]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f31c7f73-6be5-44a8-9862-08d76da56285
x-ms-traffictypediagnostic: MN2PR19MB3742:
x-microsoft-antispam-prvs: <MN2PR19MB37426DF1CA8A06E58B839DBCCB4F0@MN2PR19MB3742.namprd19.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-forefront-prvs: 02272225C5
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(346002)(396003)(376002)(366004)(39850400004)(51874003)(199004)(189003)(71200400001)(71190400001)(14444005)(6506007)(256004)(5660300002)(6436002)(186003)(26005)(6486002)(5640700003)(6916009)(6512007)(76116006)(91956017)(305945005)(7736002)(66946007)(66476007)(66556008)(64756008)(66446008)(476003)(2616005)(102836004)(486006)(25786009)(33656002)(36756003)(478600001)(14454004)(86362001)(2906002)(2501003)(3846002)(6116002)(66066001)(99286004)(8936002)(8676002)(81156014)(81166006)(316002)(2351001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR19MB3742;H:MN2PR19MB2894.namprd19.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: whamcloud.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jER+D7J087JtvsKT2AN9raGlWNKiza6Y+GbEo1ziJ5jN8dpMDX70tE6lktVUrQlOi7L3ZfTQ4JVRx8R65y8ouGX4jkjPU30usNB2fJvYMYVScMw/qY7zoUApV/Z1bFMnEiBLAigRDlOXRdWWlAgJLFOrz1fZArbhi+wnqJlOGT0wKnbcxXODTtv7KZq+/OTBF+gtGR0B3MjCfgDZw6Tkl/9Rrh2RJEWFIy7arIkw12AdLQt84cVSovAAe7k69n/Pjr6ipFIlUseOMeXlo0bEDELTR6P8zogRfi/Fbbx0LJUJgyB3BZaiBGObX0qW2fn7noqC5PlYKWXzdbtVmuiOHWY9Zy+Oj4Gi96uytZuyTLf1DznPiQ6L7BE6eBTQcHF/qi1aUX+I9rfwazrha6PGE0nlWfO3Mz18RMS4SKT9B4RPLEBXc86B3ucIvcF5ST3g
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="utf-8"
Content-ID: <30E394C70E494B409F54532A044639EE@namprd19.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: whamcloud.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f31c7f73-6be5-44a8-9862-08d76da56285
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Nov 2019 10:35:38.3749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lEAcEVQfdertdDngXzwkq49hiGY/jPWW93Ou2xIbo8nEQ6Yrn8fOGznC9fwYGH2XpNm9n8kPswoK6mRcqRFq+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR19MB3742
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGksDQoNCldl4oCZdmUgc2VlbiBmZXcgcmVwb3J0cyB3aGVyZSBhIGh1Z2UgZnJhZ21lbnRlZCBm
aWxlc3lzdGVtIHNwZW5kcyBhIGxvdCBvZiB0aW1lIGxvb2tpbmcgZm9yIGEgZ29vZCBjaHVua3Mg
b2YgZnJlZSBzcGFjZS4NClR3byBpc3N1ZXMgaGF2ZSBiZWVuIGlkZW50aWZpZWQgc28gZmFyOg0K
MSkgbWJhbGxvYyB0cmllcyB0b28gaGFyZCB0byBmaW5kIHRoZSBiZXN0IGNodW5rIHdoaWNoIGlz
IGNvdW50ZXJwcm9kdWN0aXZlIC0gaXQgbWFrZXMgc2Vuc2UgdG8gbGltaXQgdGhpcyBwcm9jZXNz
DQoyKSBkdXJpbmcgc2Nhbm5pbmcgdGhlIGJpdG1hcHMgYXJlIGxvYWRlZCBvbmUgYnkgb25lLCBz
eW5jaHJvbm91c2x5ICAtIGl0IG1ha2VzIHNlbnNlIHRvIHByZWZldGNoIGZldyBncm91cHMgYXQg
b25jZQ0KSGVyZSBpcyBhIHBhdGNoIGZvciBjb21tZW50cywgbm90IHJlYWxseSB0ZXN0ZWQgYXQg
c2NhbGUsIGJ1dCBpdOKAmWQgYmUgZ3JlYXQgdG8gc2VlIHRoZSBjb21tZW50cy4NCg0KVGhhbmtz
IGluIGFkdmFuY2UsIEFsZXgNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4dDQvYmFsbG9jLmMgYi9mcy9l
eHQ0L2JhbGxvYy5jDQppbmRleCAwYjIwMmUwMGQ5M2YuLjc2NTQ3NjAxMzg0YiAxMDA2NDQNCi0t
LSBhL2ZzL2V4dDQvYmFsbG9jLmMNCisrKyBiL2ZzL2V4dDQvYmFsbG9jLmMNCkBAIC00MDQsNyAr
NDA0LDggQEAgc3RhdGljIGludCBleHQ0X3ZhbGlkYXRlX2Jsb2NrX2JpdG1hcChzdHJ1Y3Qgc3Vw
ZXJfYmxvY2sgKnNiLA0KICAqIFJldHVybiBidWZmZXJfaGVhZCBvbiBzdWNjZXNzIG9yIE5VTEwg
aW4gY2FzZSBvZiBmYWlsdXJlLg0KICAqLw0KIHN0cnVjdCBidWZmZXJfaGVhZCAqDQotZXh0NF9y
ZWFkX2Jsb2NrX2JpdG1hcF9ub3dhaXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgZXh0NF9ncm91
cF90IGJsb2NrX2dyb3VwKQ0KK2V4dDRfcmVhZF9ibG9ja19iaXRtYXBfbm93YWl0KHN0cnVjdCBz
dXBlcl9ibG9jayAqc2IsIGV4dDRfZ3JvdXBfdCBibG9ja19ncm91cCwNCisJCQkJIGludCBpZ25v
cmVfbG9ja2VkKQ0KIHsNCiAJc3RydWN0IGV4dDRfZ3JvdXBfZGVzYyAqZGVzYzsNCiAJc3RydWN0
IGV4dDRfc2JfaW5mbyAqc2JpID0gRVhUNF9TQihzYik7DQpAQCAtNDM1LDYgKzQzNiwxMyBAQCBl
eHQ0X3JlYWRfYmxvY2tfYml0bWFwX25vd2FpdChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBleHQ0
X2dyb3VwX3QgYmxvY2tfZ3JvdXApDQogCWlmIChiaXRtYXBfdXB0b2RhdGUoYmgpKQ0KIAkJZ290
byB2ZXJpZnk7DQogDQorCWlmIChpZ25vcmVfbG9ja2VkICYmIGJ1ZmZlcl9sb2NrZWQoYmgpKSB7
DQorCQkvKiBidWZmZXIgdW5kZXIgSU8gYWxyZWFkeSwgZG8gbm90IHdhaXQNCisJCSAqIGlmIGNh
bGxlZCBmb3IgcHJlZmV0Y2hpbmcgKi8NCisJCWVyciA9IDA7DQorCQlnb3RvIG91dDsNCisJfQ0K
Kw0KIAlsb2NrX2J1ZmZlcihiaCk7DQogCWlmIChiaXRtYXBfdXB0b2RhdGUoYmgpKSB7DQogCQl1
bmxvY2tfYnVmZmVyKGJoKTsNCkBAIC01MjQsNyArNTMyLDcgQEAgZXh0NF9yZWFkX2Jsb2NrX2Jp
dG1hcChzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBleHQ0X2dyb3VwX3QgYmxvY2tfZ3JvdXApDQog
CXN0cnVjdCBidWZmZXJfaGVhZCAqYmg7DQogCWludCBlcnI7DQogDQotCWJoID0gZXh0NF9yZWFk
X2Jsb2NrX2JpdG1hcF9ub3dhaXQoc2IsIGJsb2NrX2dyb3VwKTsNCisJYmggPSBleHQ0X3JlYWRf
YmxvY2tfYml0bWFwX25vd2FpdChzYiwgYmxvY2tfZ3JvdXAsIDEpOw0KIAlpZiAoSVNfRVJSKGJo
KSkNCiAJCXJldHVybiBiaDsNCiAJZXJyID0gZXh0NF93YWl0X2Jsb2NrX2JpdG1hcChzYiwgYmxv
Y2tfZ3JvdXAsIGJoKTsNCmRpZmYgLS1naXQgYS9mcy9leHQ0L2V4dDQuaCBiL2ZzL2V4dDQvZXh0
NC5oDQppbmRleCAwM2RiM2U3MTY3NmMuLjIzMjBkN2UyZjhkNiAxMDA2NDQNCi0tLSBhL2ZzL2V4
dDQvZXh0NC5oDQorKysgYi9mcy9leHQ0L2V4dDQuaA0KQEAgLTE0ODAsNiArMTQ4MCw5IEBAIHN0
cnVjdCBleHQ0X3NiX2luZm8gew0KIAkvKiB3aGVyZSBsYXN0IGFsbG9jYXRpb24gd2FzIGRvbmUg
LSBmb3Igc3RyZWFtIGFsbG9jYXRpb24gKi8NCiAJdW5zaWduZWQgbG9uZyBzX21iX2xhc3RfZ3Jv
dXA7DQogCXVuc2lnbmVkIGxvbmcgc19tYl9sYXN0X3N0YXJ0Ow0KKwl1bnNpZ25lZCBpbnQgc19t
Yl90b3NjYW4wOw0KKwl1bnNpZ25lZCBpbnQgc19tYl90b3NjYW4xOw0KKwl1bnNpZ25lZCBpbnQg
c19tYl9wcmVmZXRjaDsNCiANCiAJLyogc3RhdHMgZm9yIGJ1ZGR5IGFsbG9jYXRvciAqLw0KIAlh
dG9taWNfdCBzX2JhbF9yZXFzOwkvKiBudW1iZXIgb2YgcmVxcyB3aXRoIGxlbiA+IDEgKi8NCkBA
IC0yMzMzLDcgKzIzMzYsOCBAQCBleHRlcm4gc3RydWN0IGV4dDRfZ3JvdXBfZGVzYyAqIGV4dDRf
Z2V0X2dyb3VwX2Rlc2Moc3RydWN0IHN1cGVyX2Jsb2NrICogc2IsDQogZXh0ZXJuIGludCBleHQ0
X3Nob3VsZF9yZXRyeV9hbGxvYyhzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCBpbnQgKnJldHJpZXMp
Ow0KIA0KIGV4dGVybiBzdHJ1Y3QgYnVmZmVyX2hlYWQgKmV4dDRfcmVhZF9ibG9ja19iaXRtYXBf
bm93YWl0KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQotCQkJCQkJZXh0NF9ncm91cF90IGJsb2Nr
X2dyb3VwKTsNCisJCQkJCQlleHQ0X2dyb3VwX3QgYmxvY2tfZ3JvdXAsDQorCQkJCQkJaW50IGln
bm9yZV9sb2NrZWQpOw0KIGV4dGVybiBpbnQgZXh0NF93YWl0X2Jsb2NrX2JpdG1hcChzdHJ1Y3Qg
c3VwZXJfYmxvY2sgKnNiLA0KIAkJCQkgIGV4dDRfZ3JvdXBfdCBibG9ja19ncm91cCwNCiAJCQkJ
ICBzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoKTsNCmRpZmYgLS1naXQgYS9mcy9leHQ0L21iYWxsb2Mu
YyBiL2ZzL2V4dDQvbWJhbGxvYy5jDQppbmRleCBhM2UyNzY3YmRmMmYuLmVhYzRlZTIyNTUyNyAx
MDA2NDQNCi0tLSBhL2ZzL2V4dDQvbWJhbGxvYy5jDQorKysgYi9mcy9leHQ0L21iYWxsb2MuYw0K
QEAgLTg2MSw3ICs4NjEsNyBAQCBzdGF0aWMgaW50IGV4dDRfbWJfaW5pdF9jYWNoZShzdHJ1Y3Qg
cGFnZSAqcGFnZSwgY2hhciAqaW5jb3JlLCBnZnBfdCBnZnApDQogCQkJYmhbaV0gPSBOVUxMOw0K
IAkJCWNvbnRpbnVlOw0KIAkJfQ0KLQkJYmhbaV0gPSBleHQ0X3JlYWRfYmxvY2tfYml0bWFwX25v
d2FpdChzYiwgZ3JvdXApOw0KKwkJYmhbaV0gPSBleHQ0X3JlYWRfYmxvY2tfYml0bWFwX25vd2Fp
dChzYiwgZ3JvdXAsIDApOw0KIAkJaWYgKElTX0VSUihiaFtpXSkpIHsNCiAJCQllcnIgPSBQVFJf
RVJSKGJoW2ldKTsNCiAJCQliaFtpXSA9IE5VTEw7DQpAQCAtMjA5NSwxMCArMjA5NSw1MiBAQCBz
dGF0aWMgaW50IGV4dDRfbWJfZ29vZF9ncm91cChzdHJ1Y3QgZXh0NF9hbGxvY2F0aW9uX2NvbnRl
eHQgKmFjLA0KIAlyZXR1cm4gMDsNCiB9DQogDQorLyoNCisgKiBlYWNoIGFsbG9jYXRpb24gY29u
dGV4dCAoaS5lLiBhIHRocmVhZCBkb2luZyBhbGxvY2F0aW9uKSBoYXMgb3duDQorICogc2xpZGlu
ZyBwcmVmZXRjaCB3aW5kb3cgb2YgQHNfbWJfcHJlZmV0Y2ggc2l6ZSB3aGljaCBzdGFydHMgYXQg
dGhlDQorICogdmVyeSBmaXJzdCBnb2FsIGFuZCBtb3ZlcyBhaGVhZCBvZiBzY2FuaW5nLg0KKyAq
IGEgc2lkZSBlZmZlY3QgaXMgdGhhdCBzdWJzZXF1ZW50IGFsbG9jYXRpb25zIHdpbGwgbGlrZWx5
IGZpbmQNCisgKiB0aGUgYml0bWFwcyBpbiBjYWNoZSBvciBhdCBsZWFzdCBpbi1mbGlnaHQuDQor
ICovDQorc3RhdGljIHZvaWQNCitleHQ0X21iX3ByZWZldGNoKHN0cnVjdCBleHQ0X2FsbG9jYXRp
b25fY29udGV4dCAqYWMsDQorCQkgICAgZXh0NF9ncm91cF90IHN0YXJ0KQ0KK3sNCisJZXh0NF9n
cm91cF90IG5ncm91cHMgPSBleHQ0X2dldF9ncm91cHNfY291bnQoYWMtPmFjX3NiKTsNCisJc3Ry
dWN0IGV4dDRfc2JfaW5mbyAqc2JpID0gRVhUNF9TQihhYy0+YWNfc2IpOw0KKwlzdHJ1Y3QgZXh0
NF9ncm91cF9pbmZvICpncnA7DQorCWV4dDRfZ3JvdXBfdCBncm91cCA9IHN0YXJ0Ow0KKwlzdHJ1
Y3QgYnVmZmVyX2hlYWQgKmJoOw0KKwlpbnQgbnI7DQorDQorCS8qIGJhdGNoIHByZWZldGNoaW5n
IHRvIGdldCBmZXcgUkVBRHMgaW4gZmxpZ2h0ICovDQorCWlmIChncm91cCArIChzYmktPnNfbWJf
cHJlZmV0Y2ggPj4gMSkgPCBhYy0+YWNfcHJlZmV0Y2gpDQorCQlyZXR1cm47DQorDQorCW5yID0g
c2JpLT5zX21iX3ByZWZldGNoOw0KKwl3aGlsZSAobnIgPiAwKSB7DQorCQlpZiAoKytncm91cCA+
PSBuZ3JvdXBzKQ0KKwkJCWdyb3VwID0gMDsNCisJCWlmICh1bmxpa2VseShncm91cCA9PSBzdGFy
dCkpDQorCQkJYnJlYWs7DQorCQlncnAgPSBleHQ0X2dldF9ncm91cF9pbmZvKGFjLT5hY19zYiwg
Z3JvdXApOw0KKwkJLyogaWdub3JlIGVtcHR5IGdyb3VwcyAtIHRob3NlIHdpbGwgYmUgc2tpcHBl
ZA0KKwkJICogZHVyaW5nIHRoZSBzY2FubmluZyBhcyB3ZWxsICovDQorCQlpZiAoZ3JwLT5iYl9m
cmVlID09IDApDQorCQkJY29udGludWU7DQorCQluci0tOw0KKwkJaWYgKCFFWFQ0X01CX0dSUF9O
RUVEX0lOSVQoZ3JwKSkNCisJCQljb250aW51ZTsNCisJCWJoID0gZXh0NF9yZWFkX2Jsb2NrX2Jp
dG1hcF9ub3dhaXQoYWMtPmFjX3NiLCBncm91cCwgMSk7DQorCQlicmVsc2UoYmgpOw0KKwl9DQor
CWFjLT5hY19wcmVmZXRjaCA9IGdyb3VwOw0KK30NCisNCiBzdGF0aWMgbm9pbmxpbmVfZm9yX3N0
YWNrIGludA0KIGV4dDRfbWJfcmVndWxhcl9hbGxvY2F0b3Ioc3RydWN0IGV4dDRfYWxsb2NhdGlv
bl9jb250ZXh0ICphYykNCiB7DQotCWV4dDRfZ3JvdXBfdCBuZ3JvdXBzLCBncm91cCwgaTsNCisJ
ZXh0NF9ncm91cF90IG5ncm91cHMsIHRvc2NhbiwgZ3JvdXAsIGk7DQogCWludCBjcjsNCiAJaW50
IGVyciA9IDAsIGZpcnN0X2VyciA9IDA7DQogCXN0cnVjdCBleHQ0X3NiX2luZm8gKnNiaTsNCkBA
IC0yMTYwLDYgKzIyMDIsOSBAQCBleHQ0X21iX3JlZ3VsYXJfYWxsb2NhdG9yKHN0cnVjdCBleHQ0
X2FsbG9jYXRpb25fY29udGV4dCAqYWMpDQogCSAqIGNyID09IDAgdHJ5IHRvIGdldCBleGFjdCBh
bGxvY2F0aW9uLA0KIAkgKiBjciA9PSAzICB0cnkgdG8gZ2V0IGFueXRoaW5nDQogCSAqLw0KKw0K
KwlhYy0+YWNfcHJlZmV0Y2ggPSBhYy0+YWNfZ19leC5mZV9ncm91cDsNCisNCiByZXBlYXQ6DQog
CWZvciAoOyBjciA8IDQgJiYgYWMtPmFjX3N0YXR1cyA9PSBBQ19TVEFUVVNfQ09OVElOVUU7IGNy
KyspIHsNCiAJCWFjLT5hY19jcml0ZXJpYSA9IGNyOw0KQEAgLTIxNjksNyArMjIxNCwxNSBAQCBl
eHQ0X21iX3JlZ3VsYXJfYWxsb2NhdG9yKHN0cnVjdCBleHQ0X2FsbG9jYXRpb25fY29udGV4dCAq
YWMpDQogCQkgKi8NCiAJCWdyb3VwID0gYWMtPmFjX2dfZXguZmVfZ3JvdXA7DQogDQotCQlmb3Ig
KGkgPSAwOyBpIDwgbmdyb3VwczsgZ3JvdXArKywgaSsrKSB7DQorCQkvKiBsaW1pdCBudW1iZXIg
b2YgZ3JvdXBzIHRvIHNjYW4gYXQgdGhlIGZpcnN0IHR3byByb3VuZHMNCisJCSAqIHdoZW4gd2Ug
aG9wZSB0byBmaW5kIHNvbWV0aGluZyByZWFsbHkgZ29vZCAqLw0KKwkJdG9zY2FuID0gbmdyb3Vw
czsNCisJCWlmIChjciA9PSAwKQ0KKwkJCXRvc2NhbiA9IHNiaS0+c19tYl90b3NjYW4wOw0KKwkJ
ZWxzZSBpZiAoY3IgPT0gMSkNCisJCQl0b3NjYW4gPSBzYmktPnNfbWJfdG9zY2FuMTsNCisNCisJ
CWZvciAoaSA9IDA7IGkgPCB0b3NjYW47IGdyb3VwKyssIGkrKykgew0KIAkJCWludCByZXQgPSAw
Ow0KIAkJCWNvbmRfcmVzY2hlZCgpOw0KIAkJCS8qDQpAQCAtMjE3OSw2ICsyMjMyLDggQEAgZXh0
NF9tYl9yZWd1bGFyX2FsbG9jYXRvcihzdHJ1Y3QgZXh0NF9hbGxvY2F0aW9uX2NvbnRleHQgKmFj
KQ0KIAkJCWlmIChncm91cCA+PSBuZ3JvdXBzKQ0KIAkJCQlncm91cCA9IDA7DQogDQorCQkJZXh0
NF9tYl9wcmVmZXRjaChhYywgZ3JvdXApOw0KKw0KIAkJCS8qIFRoaXMgbm93IGNoZWNrcyB3aXRo
b3V0IG5lZWRpbmcgdGhlIGJ1ZGR5IHBhZ2UgKi8NCiAJCQlyZXQgPSBleHQ0X21iX2dvb2RfZ3Jv
dXAoYWMsIGdyb3VwLCBjcik7DQogCQkJaWYgKHJldCA8PSAwKSB7DQpAQCAtMjg3Miw2ICsyOTI3
LDkgQEAgdm9pZCBleHQ0X3Byb2Nlc3NfZnJlZWRfZGF0YShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNi
LCB0aWRfdCBjb21taXRfdGlkKQ0KIAkJCWJpb19wdXQoZGlzY2FyZF9iaW8pOw0KIAkJfQ0KIAl9
DQorCXNiaS0+c19tYl90b3NjYW4wID0gMTAyNDsNCisJc2JpLT5zX21iX3Rvc2NhbjEgPSA0MDk2
Ow0KKwlzYmktPnNfbWJfcHJlZmV0Y2ggPSAzMjsNCiANCiAJbGlzdF9mb3JfZWFjaF9lbnRyeV9z
YWZlKGVudHJ5LCB0bXAsICZmcmVlZF9kYXRhX2xpc3QsIGVmZF9saXN0KQ0KIAkJZXh0NF9mcmVl
X2RhdGFfaW5fYnVkZHkoc2IsIGVudHJ5KTsNCmRpZmYgLS1naXQgYS9mcy9leHQ0L21iYWxsb2Mu
aCBiL2ZzL2V4dDQvbWJhbGxvYy5oDQppbmRleCA4OGM5OGYxN2UzZDkuLjliYTVjNzVlNjQ5MCAx
MDA2NDQNCi0tLSBhL2ZzL2V4dDQvbWJhbGxvYy5oDQorKysgYi9mcy9leHQ0L21iYWxsb2MuaA0K
QEAgLTE3NSw2ICsxNzUsNyBAQCBzdHJ1Y3QgZXh0NF9hbGxvY2F0aW9uX2NvbnRleHQgew0KIAlz
dHJ1Y3QgcGFnZSAqYWNfYnVkZHlfcGFnZTsNCiAJc3RydWN0IGV4dDRfcHJlYWxsb2Nfc3BhY2Ug
KmFjX3BhOw0KIAlzdHJ1Y3QgZXh0NF9sb2NhbGl0eV9ncm91cCAqYWNfbGc7DQorCWV4dDRfZ3Jv
dXBfdCBhY19wcmVmZXRjaDsNCiB9Ow0KIA0KICNkZWZpbmUgQUNfU1RBVFVTX0NPTlRJTlVFCTEN
CmRpZmYgLS1naXQgYS9mcy9leHQ0L3N5c2ZzLmMgYi9mcy9leHQ0L3N5c2ZzLmMNCmluZGV4IGVi
MWVmYWQwZTIwYS4uNDQ3NmQ4Mjg0MzliIDEwMDY0NA0KLS0tIGEvZnMvZXh0NC9zeXNmcy5jDQor
KysgYi9mcy9leHQ0L3N5c2ZzLmMNCkBAIC0xOTgsNiArMTk4LDkgQEAgRVhUNF9ST19BVFRSX0VT
X1VJKGVycm9yc19jb3VudCwgc19lcnJvcl9jb3VudCk7DQogRVhUNF9BVFRSKGZpcnN0X2Vycm9y
X3RpbWUsIDA0NDQsIGZpcnN0X2Vycm9yX3RpbWUpOw0KIEVYVDRfQVRUUihsYXN0X2Vycm9yX3Rp
bWUsIDA0NDQsIGxhc3RfZXJyb3JfdGltZSk7DQogRVhUNF9BVFRSKGpvdXJuYWxfdGFzaywgMDQ0
NCwgam91cm5hbF90YXNrKTsNCitFWFQ0X1JXX0FUVFJfU0JJX1VJKG1iX3Rvc2NhbjAsIHNfbWJf
dG9zY2FuMCk7DQorRVhUNF9SV19BVFRSX1NCSV9VSShtYl90b3NjYW4xLCBzX21iX3Rvc2NhbjEp
Ow0KK0VYVDRfUldfQVRUUl9TQklfVUkobWJfcHJlZmV0Y2gsIHNfbWJfcHJlZmV0Y2gpOw0KIA0K
IHN0YXRpYyB1bnNpZ25lZCBpbnQgb2xkX2J1bXBfdmFsID0gMTI4Ow0KIEVYVDRfQVRUUl9QVFIo
bWF4X3dyaXRlYmFja19tYl9idW1wLCAwNDQ0LCBwb2ludGVyX3VpLCAmb2xkX2J1bXBfdmFsKTsN
CkBAIC0yMjgsNiArMjMxLDkgQEAgc3RhdGljIHN0cnVjdCBhdHRyaWJ1dGUgKmV4dDRfYXR0cnNb
XSA9IHsNCiAJQVRUUl9MSVNUKGZpcnN0X2Vycm9yX3RpbWUpLA0KIAlBVFRSX0xJU1QobGFzdF9l
cnJvcl90aW1lKSwNCiAJQVRUUl9MSVNUKGpvdXJuYWxfdGFzayksDQorCUFUVFJfTElTVChtYl90
b3NjYW4wKSwNCisJQVRUUl9MSVNUKG1iX3Rvc2NhbjEpLA0KKwlBVFRSX0xJU1QobWJfcHJlZmV0
Y2gpLA0KIAlOVUxMLA0KIH07DQogQVRUUklCVVRFX0dST1VQUyhleHQ0KTsNCg0K
