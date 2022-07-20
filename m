Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8F4257AFFB
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jul 2022 06:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiGTE01 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 00:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiGTE01 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 00:26:27 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1266B75F
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jul 2022 21:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1658291186; x=1689827186;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=dXr/z2rB0mlHtVWRiTMP4OY3WOHVNwROp2x+bLmGsS8=;
  b=nUeOj8EJFxSNkjJ+kr4rOWBOD3mBMl5ix6XIZm7LHyE0sY3JrFj4DkKT
   CRw0cakRcRlES6zT5Pe7RshQiEa05Pe4IL4EFBbu6BC77NLIChMhbBzJw
   ForS/Q5vp4MpOddETBFm7QHiz3eQ5WFaed/EcqZVKODoMqwxpQvbHMhEw
   4=;
X-IronPort-AV: E=Sophos;i="5.92,286,1650931200"; 
   d="scan'208";a="110300193"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1e-fc41acad.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP; 20 Jul 2022 04:26:25 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-fc41acad.us-east-1.amazon.com (Postfix) with ESMTPS id E0261C3D66;
        Wed, 20 Jul 2022 04:26:23 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Wed, 20 Jul 2022 04:26:23 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Wed, 20 Jul 2022 04:26:23 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.036;
 Wed, 20 Jul 2022 04:26:22 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH -V2 1/2] ext4: reduce computation of overhead during resize
Thread-Topic: [PATCH -V2 1/2] ext4: reduce computation of overhead during
 resize
Thread-Index: AQHYm/DeoJ8on2whjESOU4DZyDfP9Q==
Date:   Wed, 20 Jul 2022 04:26:22 +0000
Message-ID: <CE4F359F-4779-45E6-B6A9-8D67FDFF5AE2@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B7AEF659FB1DB41965470C9EFC03BB5@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

VGhpcyBwYXRjaCBhdm9pZHMgZG9pbmcgYW4gTyhuKioyKS1jb21wbGV4aXR5IHdhbGsgdGhyb3Vn
aCBldmVyeSBmbGV4IGdyb3VwLg0KSW5zdGVhZCwgaXQgdXNlcyB0aGUgYWxyZWFkeSBjb21wdXRl
ZCBvdmVyaGVhZCBpbmZvcm1hdGlvbiBmb3IgdGhlIG5ld2x5DQphbGxvY2F0ZWQgc3BhY2UsIGFu
ZCBzaW1wbHkgYWRkcyBpdCB0byB0aGUgcHJldmlvdXNseSBjYWxjdWxhdGVkDQpvdmVyaGVhZCBz
dG9yZWQgaW4gdGhlIHN1cGVyYmxvY2suICBUaGlzIGRyYXN0aWNhbGx5IHJlZHVjZXMgdGhlIHRp
bWUNCnRha2VuIHRvIHJlc2l6ZSB2ZXJ5IGxhcmdlIGJpZ2FsbG9jIGZpbGVzeXN0ZW1zIChmcm9t
IDMrIGhvdXJzIGZvciBhDQo2NFRCIGZzIGRvd24gdG8gbWlsbGlzZWNvbmRzKS4NCg0KU2lnbmVk
LW9mZi1ieTogT2xlZyBLaXNlbGV2IDxva2lzZWxldkBhbWF6b24uY29tPg0KLS0tDQp2MjoNCiAg
LSBjaGFuZ2VkIHN0YXRpYyBmdW5jdGlvbidzIG5hbWUgdG8gYmUgbW9yZSBkZXNjcmlwdGl2ZQ0K
ICAtIHJlbW92ZWQgdXNlbGVzcyBjYXN0DQotLS0NCiBmcy9leHQ0L3Jlc2l6ZS5jIHwgMjMgKysr
KysrKysrKysrKysrKysrKysrLS0NCiAxIGZpbGUgY2hhbmdlZCwgMjEgaW5zZXJ0aW9ucygrKSwg
MiBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4dDQvcmVzaXplLmMgYi9mcy9leHQ0
L3Jlc2l6ZS5jDQppbmRleCA4YjcwYTQ3MDEyOTMuLmE2OTExM2I0Y2U0ZSAxMDA2NDQNCi0tLSBh
L2ZzL2V4dDQvcmVzaXplLmMNCisrKyBiL2ZzL2V4dDQvcmVzaXplLmMNCkBAIC0xMzgwLDYgKzEz
ODAsMTcgQEAgc3RhdGljIGludCBleHQ0X3NldHVwX25ld19kZXNjcyhoYW5kbGVfdCAqaGFuZGxl
LCBzdHJ1Y3QsDQogCXJldHVybiBlcnI7DQogfQ0KDQorc3RhdGljIHZvaWQgZXh0NF9hZGRfb3Zl
cmhlYWQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwNCisgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBjb25zdCBleHQ0X2ZzYmxrX3Qgb3ZlcmhlYWQpDQorew0KKyAgICAgICBzdHJ1Y3QgZXh0
NF9zYl9pbmZvICpzYmkgPSBFWFQ0X1NCKHNiKTsNCisgICAgICAgc3RydWN0IGV4dDRfc3VwZXJf
YmxvY2sgKmVzID0gc2JpLT5zX2VzOw0KKw0KKyAgICAgICBzYmktPnNfb3ZlcmhlYWQgKz0gb3Zl
cmhlYWQ7DQorICAgICAgIGVzLT5zX292ZXJoZWFkX2NsdXN0ZXJzID0gY3B1X3RvX2xlMzIoc2Jp
LT5zX292ZXJoZWFkKTsNCisgICAgICAgc21wX3dtYigpOw0KK30NCisNCiAvKg0KICAqIGV4dDRf
dXBkYXRlX3N1cGVyKCkgdXBkYXRlcyB0aGUgc3VwZXIgYmxvY2sgc28gdGhhdCB0aGUgbmV3bHkg
YWRkZWQNCiAgKiBncm91cHMgY2FuIGJlIHNlZW4gYnkgdGhlIGZpbGVzeXN0ZW0uDQpAQCAtMTQ4
MSw5ICsxNDkyLDE3IEBAIHN0YXRpYyB2b2lkIGV4dDRfdXBkYXRlX3N1cGVyKHN0cnVjdCBzdXBl
cl9ibG9jayAqc2IsDQogCX0NCg0KIAkvKg0KLQkgKiBVcGRhdGUgdGhlIGZzIG92ZXJoZWFkIGlu
Zm9ybWF0aW9uDQorCSAqIFVwZGF0ZSB0aGUgZnMgb3ZlcmhlYWQgaW5mb3JtYXRpb24uDQorCSAq
DQorCSAqIEZvciBiaWdhbGxvYywgaWYgdGhlIHN1cGVyYmxvY2sgYWxyZWFkeSBoYXMgYSBwcm9w
ZXJseSBjYWxjdWxhdGVkDQorCSAqIG92ZXJoZWFkLCB1cGRhdGUgaXQgd2l0aCBhIHZhbHVlIGJh
c2VkIG9uIG51bWJlcnMgYWxyZWFkeSBjb21wdXRlZA0KKwkgKiBhYm92ZSBmb3IgdGhlIG5ld2x5
IGFsbG9jYXRlZCBjYXBhY2l0eS4NCiAJICovDQotCWV4dDRfY2FsY3VsYXRlX292ZXJoZWFkKHNi
KTsNCisJaWYgKGV4dDRfaGFzX2ZlYXR1cmVfYmlnYWxsb2Moc2IpICYmIChzYmktPnNfb3Zlcmhl
YWQgIT0gMCkpDQorCQlleHQ0X2FkZF9vdmVyaGVhZChzYiwNCisJCQlFWFQ0X05VTV9CMkMoc2Jp
LCBibG9ja3NfY291bnQgLSBmcmVlX2Jsb2NrcykpOw0KKwllbHNlDQorCQlleHQ0X2NhbGN1bGF0
ZV9vdmVyaGVhZChzYik7DQoNCiAJaWYgKHRlc3Rfb3B0KHNiLCBERUJVRykpDQogCQlwcmludGso
S0VSTl9ERUJVRyAiRVhUNC1mczogYWRkZWQgZ3JvdXAgJXU6Ig0KLS0NCjIuMzQuMw0KDQo=
