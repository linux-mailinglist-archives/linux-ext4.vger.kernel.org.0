Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824FF4F548C
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Apr 2022 07:21:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231199AbiDFFNI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 6 Apr 2022 01:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842658AbiDFBdx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 5 Apr 2022 21:33:53 -0400
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4584CAFAD6
        for <linux-ext4@vger.kernel.org>; Tue,  5 Apr 2022 16:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1649200524; x=1680736524;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=ANAdw/0TaHmH51iUKn9K2uuD/a3QoIGsVTIpJ7lc9a8=;
  b=hjH1c4ZuI9XkL1uTt39aLLmkqj7Sdn0WH4v5nZoELjUplNKW7U1Sgx0x
   veFIksGiIKPz/hoL0lIP/qTf4PAtXfOuwb208yKyF9ZFFJtsAj7NVZv7w
   oVnKWcgZ1Bu4hh0UonyFtL/zXdum9AsNgSF0ZqGx/djfqHuCWRuaYFyt/
   A=;
X-IronPort-AV: E=Sophos;i="5.90,238,1643673600"; 
   d="scan'208";a="190753397"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP; 05 Apr 2022 23:15:23 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-0085f2c8.us-west-2.amazon.com (Postfix) with ESMTPS id D090A41027
        for <linux-ext4@vger.kernel.org>; Tue,  5 Apr 2022 23:15:22 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 5 Apr 2022 23:15:22 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.32; Tue, 5 Apr 2022 23:15:22 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.033;
 Tue, 5 Apr 2022 23:15:22 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     linux-ext4 <linux-ext4@vger.kernel.org>
Subject: e2fsprogs builds and installs obsolete version of blkid
Thread-Topic: e2fsprogs builds and installs obsolete version of blkid
Thread-Index: AQHYSUMGB1x25g21i0KlSX4qire5eA==
Date:   Tue, 5 Apr 2022 23:15:22 +0000
Message-ID: <4EF2E5CC-E4E7-4463-893C-274EA9535EC1@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.65]
Content-Type: text/plain; charset="utf-8"
Content-ID: <0779162112A34744B77710A1C6EE4608@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

VGhlIGUyZnNwcm9ncyBjb250YWlucyBhIHZlcnNpb24gMS4wLjAgb2YgYGJsa2lkYC4gIFRoaXMg
dmVyc2lvbiBkb2VzIG5vdCBzdXBwb3J0IGZsYWdzIHRoYXQgdGhlIGN1cnJlbnQga2VybmVsIGlu
c3RhbGwgc2NyaXB0cyBwYXNzIHRvIGBibGtpZGAuICBCeSBidWlsZGluZyBhbmQgaW5zdGFsbGlu
ZyBlMmZzcHJvZ3MgSSBlbmRlZCB1cCByZXBsYWNpbmcgYmxraWQgMi4zMC4yIHdpdGggMS4wLjAs
IHdoaWNoIGJyb2tlIGtlcm5lbCBwYWNrYWdpbmcuICBUaGlzIGlzIGVhc2lseSBmaXhlZCBieSBk
b2luZyBgeXVtIHJlaW5zdGFsbCB1dGlsLWxpbnV4YCwgd2hpY2ggcmVpbnN0YWxscyB0aGUgY29y
cmVjdCB2ZXJzaW9uIGJsa2lkLiAgDQoNClRoaXMgbWVzcyBjb3VsZCBiZSBhdm9pZGVkIGlmIGUy
ZnNwcm9ncyBlaXRoZXIgaW5jbHVkZWQgYSBtb3JlIG1vZGVybiB2ZXJzaW9uIG9mIGJsa2lkLCBv
ciBwZXJoYXBzIGRpZCBub3QgaW5jbHVkZSBibGtpZCBhdCBhbGwsIHNpbmNlIGEgbW9yZSBjdXJy
ZW50IHZlcnNpb24gb2YgdGhpcyB1dGlsaXR5IGlzIG1haW50YWluZWQgYW5kIGluc3RhbGxlZCB0
aHJvdWdoIG90aGVyIHBhY2thZ2VzLg0KDQooRmluZGluZyBodHRwczovL2ZvcnVtcy5jZW50b3Mu
b3JnL3ZpZXd0b3BpYy5waHA/dD02OTY1NSBoZWxwZWQgYSBsb3QgaW4gZmlndXJpbmcgb3V0IHdo
eSBteSBrZXJuZWwgYnVpbGQgc3RhcnRlZCBmYWlsaW5nIGFsbCBvZiBhIHN1ZGRlbikNCg0K
