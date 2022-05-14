Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B4AD526F27
	for <lists+linux-ext4@lfdr.de>; Sat, 14 May 2022 09:15:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiENERY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 14 May 2022 00:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231629AbiENERW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 14 May 2022 00:17:22 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1DE2B09EB
        for <linux-ext4@vger.kernel.org>; Fri, 13 May 2022 21:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1652501840; x=1684037840;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=3S+E3MPtMhWz5GF6SctMTjlaW+Q8p3K4PJBYH1NzsNM=;
  b=KEwYyqCHPB3BSNwYf+9GYqeGUQvh2DTU5p41PQTVyThfIkYsSqVn/SQA
   Awu7N8MMXIB4e1gNY/MfJgpezOh9+nn5dFIktvLV17cl6R1hjebvtyHPN
   s1xqi6aEr5Zqb1NIlllFMtd6UNXZUYnfU+cyMS55w93REf+01FD6X+xYR
   Y=;
X-IronPort-AV: E=Sophos;i="5.91,225,1647302400"; 
   d="scan'208";a="88440285"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-iad-1d-7a21ed79.us-east-1.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 14 May 2022 04:17:19 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1d-7a21ed79.us-east-1.amazon.com (Postfix) with ESMTPS id 170B422156F;
        Sat, 14 May 2022 04:17:18 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sat, 14 May 2022 04:17:09 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Sat, 14 May 2022 04:17:09 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.033;
 Sat, 14 May 2022 04:17:09 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] resize2fs: trim resize to cluster boundary
Thread-Topic: [PATCH] resize2fs: trim resize to cluster boundary
Thread-Index: AQHYZ0l6LEgGHOTRZECljY67fqyoJA==
Date:   Sat, 14 May 2022 04:17:09 +0000
Message-ID: <FD65D2E2-16C1-48D6-8CB3-BA09CC35E6DB@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.203]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B3CB2D36E90B624884B74E0F5450D2B9@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

DQpUaGlzIHBhdGNoIHJvdW5kcyBkb3duIHRoZSBzaXplIHByb3ZpZGVkIHRvIHJlc2l6ZTJmcyB0
byB0aGUgbmVhcmVzdA0KY2x1c3RlciBib3VuZGFyeSBmb3IgYmlnYWxsb2MgZmlsZXN5c3RlbXMu
ICBUaGlzIGlzIHNpbWlsYXIgdG8gdGhlDQp0cmltbWluZyBhbHJlYWR5IGRvbmUgZm9yIHBhZ2Ug
Ym91bmRhcnkgYWxpZ25tZW50LiAgQWxpZ25pbmcgdGhlIHNpemUgaW4NCnRoZSB1c2VyIHNwYWNl
IHByb3ZpZGVzIHRoZSByaWdodCB2YWx1ZSBmZWVkYmFjayBmcm9tIHRoZSByZXNpemUyZnMNCmNv
bW1hbmQsIHdoaWNoIGlzIGEgYmV0dGVyIHVzZXIgZXhwZXJpZW5jZSB0aGFuIHRyaW1taW5nIHRo
ZSBzaXplDQppbiB0aGUga2VybmVsLg0KDQpTaWduZWQtb2ZmLWJ5OiBPbGVnIEtpc2VsZXYgPG9r
aXNlbGV2QGFtYXpvbi5jb20+DQotLS0NCiByZXNpemUvbWFpbi5jIHwgNiArKysrKysNCiAxIGZp
bGUgY2hhbmdlZCwgNiBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9yZXNpemUvbWFpbi5j
IGIvcmVzaXplL21haW4uYw0KaW5kZXggYmNlYWExNjc3ZTIxLi45M2ExZDVhMjYwZTEgMTAwNjQ0
DQotLS0gYS9yZXNpemUvbWFpbi5jDQorKysgYi9yZXNpemUvbWFpbi5jDQpAQCAtNTM3LDYgKzUz
NywxMiBAQCBpbnQgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKiogYXJndikNCiAJCQlnb3RvIGVycm91
dDsNCiAJCX0NCiAJfQ0KKw0KKwkvKiBJZiB1c2luZyBjbHVzdGVyIGFsbG9jYXRpb25zLCB0cmlt
IGRvd24gdG8gYSBjbHVzdGVyIGJvdW5kYXJ5ICovDQorCWlmIChleHQyZnNfaGFzX2ZlYXR1cmVf
YmlnYWxsb2MoZnMtPnN1cGVyKSkgew0KKwkJbmV3X3NpemUgJj0gfigoYmxrNjRfdCkoMSA8PCBm
cy0+Y2x1c3Rlcl9yYXRpb19iaXRzKSAtIDEpOw0KKwl9DQorDQogCW5ld19ncm91cF9kZXNjX2Nv
dW50ID0gZXh0MmZzX2RpdjY0X2NlaWwobmV3X3NpemUgLQ0KIAkJCQlmcy0+c3VwZXItPnNfZmly
c3RfZGF0YV9ibG9jaywNCiAJCQkJCQkgRVhUMl9CTE9DS1NfUEVSX0dST1VQKGZzLT5zdXBlcikp
Ow0KLS0NCjIuMzIuMA0KDQo=
