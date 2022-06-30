Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9106F560F05
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Jun 2022 04:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbiF3CRY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 29 Jun 2022 22:17:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbiF3CRX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 29 Jun 2022 22:17:23 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C7663EABF
        for <linux-ext4@vger.kernel.org>; Wed, 29 Jun 2022 19:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1656555443; x=1688091443;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=JwEI1ut9YMRYTsPMvuyB7Z+xTXHC5w0qEyt9W/mRxt0=;
  b=WM91I1WRc3ZnNVHnKzAG3r91KrlSqeORpasS9k0ggIQe3tROF5ZEJ1Q4
   kyFwGNgauXMkDRThAN5PTS6hDca9Mr+NKZTY/DJ/+yU6WmiiPQOLIIoUl
   r4YfaLR/8PBlCedIVlbw/jru4wo2GsUoCWD6NOgkYbONfNAUqDrNkf+5F
   s=;
X-IronPort-AV: E=Sophos;i="5.92,232,1650931200"; 
   d="scan'208";a="1029491558"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP; 30 Jun 2022 02:17:22 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2b-1f9d5b26.us-west-2.amazon.com (Postfix) with ESMTPS id 9589043302;
        Thu, 30 Jun 2022 02:17:22 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 30 Jun 2022 02:17:22 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 30 Jun 2022 02:17:22 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.036;
 Thu, 30 Jun 2022 02:17:22 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 2/2] ext4: avoid resizing to a partial cluster size
Thread-Topic: [PATCH 2/2] ext4: avoid resizing to a partial cluster size
Thread-Index: AQHYjCeHznXf09jkSEaK4G9Qmq42ig==
Date:   Thu, 30 Jun 2022 02:17:22 +0000
Message-ID: <9CDF7393-5645-4E8A-9D68-01CF7F4C4955@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.98]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7903C8041CDE5A4A93A454359590A121@amazon.com>
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

VGhpcyBwYXRjaCBhdm9pZHMgYW4gYXR0ZW1wdCB0byByZXNpemUgdGhlIGZpbGVzeXN0ZW0gdG8g
YW4NCnVuYWxpZ25lZCBjbHVzdGVyIGJvdW5kYXJ5LiAgQW4gb25saW5lIHJlc2l6ZSB0byBhIHNp
emUgdGhhdCBpcyBub3QNCmludGVncmFsIHRvIGNsdXN0ZXIgc2l6ZSByZXN1bHRzIGluIHRoZSBs
YXN0IGl0ZXJhdGlvbiBhdHRlbXB0aW5nIHRvDQpncm93IHRoZSBmcyBieSBhIG5lZ2F0aXZlIGFt
b3VudCwgd2hpY2ggdHJpcHMgYSBCVUdfT04gYW5kIGxlYXZlcyB0aGUgZnMNCndpdGggYSBjb3Jy
dXB0ZWQgaW4tbWVtb3J5IHN1cGVyYmxvY2suDQoNClNpZ25lZC1vZmYtYnk6IE9sZWcgS2lzZWxl
diA8b2tpc2VsZXZAYW1hem9uLmNvbT4NCi0tLQ0KIGZzL2V4dDQvcmVzaXplLmMgfCAzICsrLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAt
LWdpdCBhL2ZzL2V4dDQvcmVzaXplLmMgYi9mcy9leHQ0L3Jlc2l6ZS5jDQppbmRleCAyYWNjOWZj
YTk5ZWEuLjg4MDM5MDU5MDdkZSAxMDA2NDQNCi0tLSBhL2ZzL2V4dDQvcmVzaXplLmMNCisrKyBi
L2ZzL2V4dDQvcmVzaXplLmMNCkBAIC0xNjI0LDcgKzE2MjQsOCBAQCBzdGF0aWMgaW50IGV4dDRf
c2V0dXBfbmV4dF9mbGV4X2dkKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQoNCiAJb19ibG9ja3Nf
Y291bnQgPSBleHQ0X2Jsb2Nrc19jb3VudChlcyk7DQoNCi0JaWYgKG9fYmxvY2tzX2NvdW50ID09
IG5fYmxvY2tzX2NvdW50KQ0KKwlpZiAoKG9fYmxvY2tzX2NvdW50ID09IG5fYmxvY2tzX2NvdW50
KSB8fA0KKwkgICAgKChuX2Jsb2Nrc19jb3VudCAtIG9fYmxvY2tzX2NvdW50KSA8IHNiaS0+c19j
bHVzdGVyX3JhdGlvKSkNCiAJCXJldHVybiAwOw0KDQogCWV4dDRfZ2V0X2dyb3VwX25vX2FuZF9v
ZmZzZXQoc2IsIG9fYmxvY2tzX2NvdW50LCAmZ3JvdXAsICZsYXN0KTsNCi0tDQoyLjMyLjANCg0K
