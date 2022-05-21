Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A06252F79D
	for <lists+linux-ext4@lfdr.de>; Sat, 21 May 2022 04:39:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231324AbiEUCjG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 May 2022 22:39:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbiEUCjF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 May 2022 22:39:05 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0DC18FF0D
        for <linux-ext4@vger.kernel.org>; Fri, 20 May 2022 19:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1653100745; x=1684636745;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=FdqwmMPFuaOcbYK/WlyzBPLJMMZ0UFBArY1DuadAOSQ=;
  b=VQEtI+b9Wlyl45wsFYb0C4Q1ndrBUj9WZBTcoDdOyqH7OXnuYTgAWd6/
   +JmuufEVVVh2HVbsUx8zgvu0VghK4/xg/WF/yTQxkiF7+Djt7rz+VfCJy
   nN/Bx5zmf/GKVISsPbPr4LjucFxbHSaDkJKeyfK/oWmOUqCFy2PCQL0KB
   A=;
X-IronPort-AV: E=Sophos;i="5.91,240,1647302400"; 
   d="scan'208";a="196645124"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1e-98691110.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP; 21 May 2022 02:39:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1e-98691110.us-east-1.amazon.com (Postfix) with ESMTPS id 56666811A5;
        Sat, 21 May 2022 02:39:03 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sat, 21 May 2022 02:39:01 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Sat, 21 May 2022 02:39:01 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.036;
 Sat, 21 May 2022 02:39:01 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>
Subject: Does `-O bigalloc` still conflict with `delalloc`?
Thread-Topic: Does `-O bigalloc` still conflict with `delalloc`?
Thread-Index: AQHYbLvtEANX2mjL60Khy2lzFq3rcw==
Date:   Sat, 21 May 2022 02:39:00 +0000
Message-ID: <923065C9-2EFB-4F59-895E-139B4B9F9E98@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.98]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6B075750EA42714DB3E804DC7AFC0A2A@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-12.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

VGhlIGBleHQ0KDUpYCBtYW4gcGFnZSwgY29udGFpbmVkIGluIHRoZSBtb3N0IHJlY2VudCBlMmZz
cHJvZ3Mgc3RpbGwgc2F5czoNCg0KCVdhcm5pbmc6IFRoZSBiaWdhbGxvYyBmZWF0dXJlIGlzIHN0
aWxsIHVuZGVyIGRldmVsb3BtZW50LCBhbmQgbWF5IG5vdCBiZSBmdWxseSAgc3VwcG9ydGVkDQog
ICAgICAgICAgICAgIHdpdGggeW91ciBrZXJuZWwgb3IgbWF5IGhhdmUgdmFyaW91cyBidWdzLiAg
UGxlYXNlIHNlZSB0aGUgd2ViIHBhZ2UgaHR0cDovL2V4dDQud2lraS5rZXLigJANCiAgICAgICAg
ICAgICAgbmVsLm9yZy9pbmRleC5waHAvQmlnYWxsb2MgZm9yIGRldGFpbHMuICBNYXkgY2xhc2gg
d2l0aCBkZWxheWVkIGFsbG9jYXRpb24gKHNlZSAgbm9kZWxhbOKAkA0KICAgICAgICAgICAgICBs
b2MgbW91bnQgb3B0aW9uKS4NCg0KSXMgYSBiYWQgaW50ZXJhY3Rpb24gd2l0aCBgZGVsYWxsb2Ng
IHN0aWxsIGFuIGlzc3VlIGFuZCBzaG91bGQgd2UgYmUgdXNpbmcgdGhlIGBub2RlbGFsbG9jYCBv
cHRpb24/IA0KDQo=
