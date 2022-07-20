Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F062957AFFC
	for <lists+linux-ext4@lfdr.de>; Wed, 20 Jul 2022 06:28:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237758AbiGTE1w (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 20 Jul 2022 00:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236863AbiGTE1v (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 20 Jul 2022 00:27:51 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 524A16F7E6
        for <linux-ext4@vger.kernel.org>; Tue, 19 Jul 2022 21:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1658291271; x=1689827271;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=NhJ565ROf8TgCfppmteicCm3jNoqcnVO2dlUOtS2PKI=;
  b=UZWHfUE5epJalRaAjN4DNtrS54Cr5H1eJyDKw/Nwdx3a79ri0O6OzM1p
   Nq0w0pXk/PBFBGoPUgZRpXSX/SDvpjA4oBK2rC+bwysh+LnxqbQ8idg04
   CEfEsglC2ybK2C5RCvX3hUhAJ9ioTK85sb3mrtr4ZK0s2CQJjbmRfSto9
   A=;
X-IronPort-AV: E=Sophos;i="5.92,286,1650931200"; 
   d="scan'208";a="223610652"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 20 Jul 2022 04:27:50 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-87b71607.us-east-1.amazon.com (Postfix) with ESMTPS id 9A34D142CAA;
        Wed, 20 Jul 2022 04:27:49 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Wed, 20 Jul 2022 04:27:48 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Wed, 20 Jul 2022 04:27:48 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.036;
 Wed, 20 Jul 2022 04:27:48 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH -V2 2/2] ext4: avoid resizing to a partial cluster size
Thread-Topic: [PATCH -V2 2/2] ext4: avoid resizing to a partial cluster size
Thread-Index: AQHYm/ERz7da5TCnCUu/V675Ko13Kg==
Date:   Wed, 20 Jul 2022 04:27:48 +0000
Message-ID: <0E92A0AB-4F16-4F1A-94B7-702CC6504FDE@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C539A9E7001C346B9BEAE49B7E0B94E@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-12.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

VGhpcyBwYXRjaCBhdm9pZHMgYW4gYXR0ZW1wdCB0byByZXNpemUgdGhlIGZpbGVzeXN0ZW0gdG8g
YW4NCnVuYWxpZ25lZCBjbHVzdGVyIGJvdW5kYXJ5LiAgQW4gb25saW5lIHJlc2l6ZSB0byBhIHNp
emUgdGhhdCBpcyBub3QNCmludGVncmFsIHRvIGNsdXN0ZXIgc2l6ZSByZXN1bHRzIGluIHRoZSBs
YXN0IGl0ZXJhdGlvbiBhdHRlbXB0aW5nIHRvDQpncm93IHRoZSBmcyBieSBhIG5lZ2F0aXZlIGFt
b3VudCwgd2hpY2ggdHJpcHMgYSBCVUdfT04gYW5kIGxlYXZlcyB0aGUgZnMNCndpdGggYSBjb3Jy
dXB0ZWQgaW4tbWVtb3J5IHN1cGVyYmxvY2suDQoNClNpZ25lZC1vZmYtYnk6IE9sZWcgS2lzZWxl
diA8b2tpc2VsZXZAYW1hem9uLmNvbT4NCi0tLQ0KdjI6DQogIC0gTW92ZWQgdGhlIGNvZGUgaGln
aGVyIHVwIGluIHRoZSBjYWxsIHN0YWNrLCBjaGFuZ2VkIHRoZQ0KICAgIGltcGxlbWVudGF0aW9u
IHRvIHRyaW0gdGhlIHJlcXVlc3Qgc2l6ZQ0KLS0tDQogZnMvZXh0NC9yZXNpemUuYyB8IDEwICsr
KysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKQ0KDQpkaWZmIC0tZ2l0
IGEvZnMvZXh0NC9yZXNpemUuYyBiL2ZzL2V4dDQvcmVzaXplLmMNCmluZGV4IGE2OTExM2I0Y2U0
ZS4uYjY5ZmRhNDc4ZTlkIDEwMDY0NA0KLS0tIGEvZnMvZXh0NC9yZXNpemUuYw0KKysrIGIvZnMv
ZXh0NC9yZXNpemUuYw0KQEAgLTIwMDcsNiArMjAwNywxNiBAQCBpbnQgZXh0NF9yZXNpemVfZnMo
c3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgZXh0NF9mc2Jsa190ICkNCiAJfQ0KIAlicmVsc2UoYmgp
Ow0KDQorCS8qDQorCSAqIEZvciBiaWdhbGxvYywgdHJpbSB0aGUgcmVxdWVzdGVkIHNpemUgdG8g
dGhlIG5lYXJlc3QgY2x1c3Rlcg0KKwkgKiBib3VuZGFyeSB0byBhdm9pZCBjcmVhdGluZyBhbiB1
bnVzYWJsZSBmaWxlc3lzdGVtLiBXZSBkbyB0aGlzDQorCSAqIHNpbGVudGx5LCBpbnN0ZWFkIG9m
IHJldHVybmluZyBhbiBlcnJvciwgdG8gYXZvaWQgYnJlYWtpbmcNCisJICogY2FsbGVycyB0aGF0
IGJsaW5kbHkgcmVzaXplIHRoZSBmaWxlc3lzdGVtIHRvIHRoZSBmdWxsIHNpemUgb2YNCisJICog
dGhlIHVuZGVybHlpbmcgYmxvY2sgZGV2aWNlLg0KKwkgKi8NCisJaWYgKGV4dDRfaGFzX2ZlYXR1
cmVfYmlnYWxsb2Moc2IpKQ0KKwkJbl9ibG9ja3NfY291bnQgJj0gfigoMSA8PCBFWFQ0X0NMVVNU
RVJfQklUUyhzYikpIC0gMSk7DQorDQogcmV0cnk6DQogCW9fYmxvY2tzX2NvdW50ID0gZXh0NF9i
bG9ja3NfY291bnQoZXMpOw0KDQotLQ0KMi4zNC4zDQoNCg==
