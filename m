Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4059F560F06
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jun 2022 04:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbiF3CRZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 22:17:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbiF3CRY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 22:17:24 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBDA3ED06
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 19:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1656555443; x=1688091443;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=9jANJrW7ubZRP9TAdwc8HwoaUKBQJ2y9smDQOggWf+Q=;
  b=AXvJUPUYZ2gkouxixmcBJ3J1ZpgLWYOdgZUo7RyFo5YR6ajAtu5GOBg0
   /p19MD1dZg2JptFYbShpAEKFkd0OQsvXWeh3mr/xLZYezVC9rx7xKBTyV
   pMlvAiqTwobta58+wH7vV8LNoHRohe1iaTNdEryJjJTrB/w1vKtZumUcJ
   4=;
X-IronPort-AV: E=Sophos;i="5.92,232,1650931200"; 
   d="scan'208";a="1029491557"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-5bed4ba5.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 30 Jun 2022 02:17:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-5bed4ba5.us-west-2.amazon.com (Postfix) with ESMTPS id 6478FE3903;
        Thu, 30 Jun 2022 02:17:22 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 30 Jun 2022 02:17:21 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 30 Jun 2022 02:17:21 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.036;
 Thu, 30 Jun 2022 02:17:21 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 1/2] ext4: reduce computation of overhead during resize
Thread-Topic: [PATCH 1/2] ext4: reduce computation of overhead during resize
Thread-Index: AQHYjCeH91+dMyGz00Kz59z9i8AzhA==
Date:   Thu, 30 Jun 2022 02:17:21 +0000
Message-ID: <D03FEE2D-DCAE-44A7-B0D3-0047808426BB@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.98]
Content-Type: text/plain; charset="utf-8"
Content-ID: <484D0C63709E0B4392430A7CC8E10D30@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-12.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
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
LW9mZi1ieTogT2xlZyBLaXNlbGV2IDxva2lzZWxldkBhbWF6b24uY29tPg0KLS0tDQogZnMvZXh0
NC9yZXNpemUuYyB8IDIwICsrKysrKysrKysrKysrKysrKystDQogMSBmaWxlIGNoYW5nZWQsIDE5
IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4dDQvcmVz
aXplLmMgYi9mcy9leHQ0L3Jlc2l6ZS5jDQppbmRleCA4YjcwYTQ3MDEyOTMuLjJhY2M5ZmNhOTll
YSAxMDA2NDQNCi0tLSBhL2ZzL2V4dDQvcmVzaXplLmMNCisrKyBiL2ZzL2V4dDQvcmVzaXplLmMN
CkBAIC0xMzgwLDYgKzEzODAsMTYgQEAgc3RhdGljIGludCBleHQ0X3NldHVwX25ld19kZXNjcyho
YW5kbGVfdCAqaGFuZGxlLCBzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KIAlyZXR1cm4gZXJyOw0K
IH0NCg0KK3N0YXRpYyB2b2lkIGV4dDRfc2V0X292ZXJoZWFkKHN0cnVjdCBzdXBlcl9ibG9jayAq
c2IsDQorICAgICAgICAgICAgICAgICAgICAgICAgICAgICBjb25zdCBleHQ0X2dycGJsa190IG92
ZXJoZWFkKQ0KK3sNCisgICAgICAgc3RydWN0IGV4dDRfc2JfaW5mbyAqc2JpID0gRVhUNF9TQihz
Yik7DQorICAgICAgIHN0cnVjdCBleHQ0X3N1cGVyX2Jsb2NrICplcyA9IHNiaS0+c19lczsNCisg
ICAgICAgc2JpLT5zX292ZXJoZWFkICs9IG92ZXJoZWFkOw0KKyAgICAgICBlcy0+c19vdmVyaGVh
ZF9jbHVzdGVycyA9IGNwdV90b19sZTMyKCh1bnNpZ25lZCBsb25nKSBzYmktPnNfb3ZlcmhlYWQp
Ow0KKyAgICAgICBzbXBfd21iKCk7DQorfQ0KKw0KIC8qDQogICogZXh0NF91cGRhdGVfc3VwZXIo
KSB1cGRhdGVzIHRoZSBzdXBlciBibG9jayBzbyB0aGF0IHRoZSBuZXdseSBhZGRlZA0KICAqIGdy
b3VwcyBjYW4gYmUgc2VlbiBieSB0aGUgZmlsZXN5c3RlbS4NCkBAIC0xNDgyLDggKzE0OTIsMTYg
QEAgc3RhdGljIHZvaWQgZXh0NF91cGRhdGVfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwN
Cg0KIAkvKg0KIAkgKiBVcGRhdGUgdGhlIGZzIG92ZXJoZWFkIGluZm9ybWF0aW9uDQorCSAqDQor
CSAqIEZvciBiaWdhbGxvYywgaWYgdGhlIHN1cGVyYmxvY2sgYWxyZWFkeSBoYXMgYSBwcm9wZXJs
eSBjYWxjdWxhdGVkDQorCSAqIG92ZXJoZWFkLCB1cGRhdGUgaXQgd3RoIGEgdmFsdWUgYmFzZWQg
b24gbnVtYmVycyBhbHJlYWR5IGNvbXB1dGVkDQorCSAqIGFib3ZlIGZvciB0aGUgbmV3bHkgYWxs
b2NhdGVkIGNhcGFjaXR5Lg0KIAkgKi8NCi0JZXh0NF9jYWxjdWxhdGVfb3ZlcmhlYWQoc2IpOw0K
KwlpZiAoZXh0NF9oYXNfZmVhdHVyZV9iaWdhbGxvYyhzYikgJiYgKHNiaS0+c19vdmVyaGVhZCAh
PSAwKSkNCisJCWV4dDRfc2V0X292ZXJoZWFkKHNiLA0KKwkJCUVYVDRfTlVNX0IyQyhzYmksIGJs
b2Nrc19jb3VudCAtIGZyZWVfYmxvY2tzKSk7DQorCWVsc2UNCisJCWV4dDRfY2FsY3VsYXRlX292
ZXJoZWFkKHNiKTsNCg0KIAlpZiAodGVzdF9vcHQoc2IsIERFQlVHKSkNCiAJCXByaW50ayhLRVJO
X0RFQlVHICJFWFQ0LWZzOiBhZGRlZCBncm91cCAldToiDQotLQ0KMi4zMi4wDQoNCg==
