Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D4387E7E99
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Nov 2023 18:46:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344174AbjKJRqf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Nov 2023 12:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345909AbjKJRpj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Nov 2023 12:45:39 -0500
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B4FE83FF
        for <linux-ext4@vger.kernel.org>; Thu,  9 Nov 2023 23:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1699601158; x=1731137158;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=0UbiSjv/qo/IidGnexf4/9OpMAuc77py2/DsWcWOHKs=;
  b=UvIgCYkii/IAbXxn2JBYse34b4JTT5+7HthFUNrlsMVytpzUjCOJXFzx
   hT3LeYTAxroFZIdoDxpiIBGaYHnl8ErNciu8NxKJk69StBt9fxPfTmj8K
   L6fhLuUclqLS7JDb0c78fCFgs67Fv4Fd3cV1lVgHj8o+CHZVKUIL+CD9v
   w=;
X-IronPort-AV: E=Sophos;i="6.03,291,1694736000"; 
   d="scan'208";a="594240173"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2023 07:25:57 +0000
Received: from smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev (pdx2-ws-svc-p26-lb5-vlan3.pdx.amazon.com [10.39.38.70])
        by email-inbound-relay-pdx-2c-m6i4x-fad5e78e.us-west-2.amazon.com (Postfix) with ESMTPS id 5457CA1160;
        Fri, 10 Nov 2023 07:25:55 +0000 (UTC)
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:54712]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.255:2525] with esmtp (Farcaster)
 id 930b67d4-e81d-45c1-a350-5a3e959901a0; Fri, 10 Nov 2023 07:25:54 +0000 (UTC)
X-Farcaster-Flow-ID: 930b67d4-e81d-45c1-a350-5a3e959901a0
Received: from EX19D001UWA003.ant.amazon.com (10.13.138.211) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.39; Fri, 10 Nov 2023 07:25:50 +0000
Received: from EX19D001UWA004.ant.amazon.com (10.13.138.251) by
 EX19D001UWA003.ant.amazon.com (10.13.138.211) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.39;
 Fri, 10 Nov 2023 07:25:49 +0000
Received: from EX19D001UWA004.ant.amazon.com ([fe80::2a53:56d5:307c:7d5]) by
 EX19D001UWA004.ant.amazon.com ([fe80::2a53:56d5:307c:7d5%5]) with mapi id
 15.02.1118.039; Fri, 10 Nov 2023 07:25:49 +0000
From:   "Bandi, Ravi Kumar" <ravib@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>
Subject: [bigalloc] ext4 filesystem creation fails with specific sizes
Thread-Topic: [bigalloc] ext4 filesystem creation fails with specific sizes
Thread-Index: AQHaE6chVIZJbiUIU0K4KOjENXW1qA==
Date:   Fri, 10 Nov 2023 07:25:49 +0000
Message-ID: <EB278E44-20B7-45F3-B5CA-2986B35E60AC@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.106.100.9]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB2CE30315537C4187B189B796651F4A@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

SGksDQoNCkknbSBzZWVpbmcgdGhpcyBpc3N1ZSB3aXRoIGV4dDQgZmlsZXN5c3RlbSBjcmVhdGlv
biB3aXRoIGNsdXN0ZXINCmFsbG9jYXRpb24gKGJpZ2FsbG9jKS4gIEZpbGVzeXN0ZW0gY3JlYXRp
b24gZmFpbHMgaWYgc2l6ZSBzcGVjaWZpZWQNCmFzIGJsb2NrIGNvdW50IGFuZCBpZiB0aGF0IGJs
b2NrIGNvdW50IHJlc3VsdHMgaW4gdGhlIG51bWJlciBvZg0KYmxvY2tzIGluIHRoZSBsYXN0IGJs
b2NrIGdyb3VwIGlzIGxlc3MgdGhhbiB0aGUgbnVtYmVyIG9mIG92ZXJoZWFkDQpibG9ja3MuICBU
aGlzIGxlYWQgdG8gdGhlIGNvbXB1dGF0aW9uIG9mIGlub2Rlcy1wZXItZ3JvdXAgdG8gb3ZlcnNo
b290DQp0aGUgbGltaXQgY2F1c2luZyBmaWxlc3lzdGVtIGNyZWF0aW9uIGZhaWx1cmUuDQoNCk9i
c2VydmF0aW9uIGlzLCB0aGUgbnVtYmVyIG9mIGJsb2NrcyBmb3IgdGhlIGZpbGVzeXN0ZW0gZG9l
cyBub3QNCnNlZW0gdG8gYmUgYWRqdXN0ZWQgdG8gYWNjb3VudCBmb3IgdGhpcyBhcyBpcyBkb25l
IGluIHBsYWluIGV4dDQNCmZpbGVzeXN0ZW0gKHdpdGhvdXQgYmlnYWxsb2MpLiAgSSB0aGluayB3
ZSBzaG91bGQgZG8gdGhlIHNhbWUNCnVuZGVyIGJpZ2FsbG9jIGNvbmZpZ3VyYXRpb24gYXMgd2Vs
bC4NCg0KVG8gc29sdmUgdGhlIGlzc3VlLCB3aGVuIGZpbGVzeXN0ZW0gY3JlYXRpb24gZmFpbHMg
Zm9yIGEgc3BlY2lmaWMNCmJsb2NrIGNvdW50LCBJIG5lZWQgdG8gcmV0cnkgdGhlIG9wZXJhdGlv
biB3aXRoIGJsb2NrIGNvdW50IHJvdW5kZWQNCnRvIHRoZSBibG9jayBncm91cCBib3VuZGFyeS4N
Cg0KT3IsIGFtIEknbSBtaXNzaW5nIHNvbWV0aGluZz8NCg0KVGhhbmtzLA0KUmF2aQ0KDQpFLmcu
DQpGYWlsdXJlOg0KICAgIG1rZTJmcyAtbSAxIC10IGV4dDQgLU8gYmlnYWxsb2MgLUMgMTYzODQg
LWIgNDA5NiAvZGV2L252bWUxbjEgNTI0MjkyDQoNClJvdW5kIHRoZSB0b3RhbCBibG9jayBjb3Vu
dCB0byB0aGUgYmxvY2tzLXBlci1ncm91cCAoMTMxMDcyKSBib3VuZGFyeToNCiAgICAjIGVjaG8g
JCgoKDUyNDI5MiAmIH4weDFmZmZmKSkpDQogICAgNTI0Mjg4DQogICAgIw0KU3VjY2VzczoNCiAg
ICBta2UyZnMgLW0gMSAtdCBleHQ0IC1PIGJpZ2FsbG9jIC1DIDE2Mzg0IC1iIDQwOTYgL2Rldi9u
dm1lMW4xIDUyNDI4OA0KDQpDdXJyZW50IGNvbmZpZ3VyYXRpb24gd2l0aCBleDQgcHJvZmlsZToN
CiAgICBbZGVmYXVsdHNdDQogICAgICAgICAgICBibG9ja3NpemUgPSA0MDk2DQogICAgICAgICAg
ICBpbm9kZV9zaXplID0gMjU2DQogICAgICAgICAgICBpbm9kZV9yYXRpbyA9IDE2Mzg0DQogICAg
ICAgICAgICBbLi4uXQ0KICAgIFsuLi5dDQoNCldpdGggdGhpcyBjb25maWd1cmF0aW9uLCBiaWdh
bGxvYyB3aXRoIGNsdXN0ZXIgc2l6ZSAxNkssICdCbG9ja3MgcGVyIGdyb3VwJyBpcyAxMzEwNzIg
YW5kICdJbm9kZXMgcGVyIGdyb3VwJyBpcyAzMjc2OC4NCiAgICAjIG1rZTJmcyAtbSAxIC10IGV4
dDQgLU8gYmlnYWxsb2MgLUMgMTYzODQgLWIgNDA5NiAvZGV2L252bWUxbjEgNTI0Mjg4DQogICAg
IyB0dW5lMmZzIC1sIC9kZXYvbnZtZTFuMQ0KICAgIFsuLi5dDQogICAgQmxvY2tzIHBlciBncm91
cDogICAgICAgICAxMzEwNzINCiAgICBJbm9kZXMgcGVyIGdyb3VwOiAgICAgICAgIDMyNzY4DQog
ICAgWy4uLl0NCiAgICAjDQoNCkV4YW1wbGUgZmFpbHVyZSAjMToNCj0tPS09LT0tPS09PS09LT0t
PQ0KICAgICMgbWtlMmZzIC1tIDEgLXQgZXh0NCAtTyBiaWdhbGxvYyAtQyAxNjM4NCAtYiA0MDk2
IC9kZXYvbnZtZTFuMSA1MjQyOTINCiAgICBta2UyZnMgMS40Ny4wICg1LUZlYi0yMDIzKQ0KICAg
IC9kZXYvbnZtZTFuMTogQ2Fubm90IGNyZWF0ZSBmaWxlc3lzdGVtIHdpdGggcmVxdWVzdGVkIG51
bWJlciBvZiBpbm9kZXMgd2hpbGUgc2V0dGluZyB1cCBzdXBlcmJsb2NrDQogICAgIw0KDQogICAg
SW4gdGhpcyBjYXNlLCB0aGUgbGFzdCBibG9jayBncm91cCBoYXMgNCBibG9ja3MsIGJ1dCB0aGUg
b3ZlcmhlYWQNCiAgICBpcyAxNjQxIGJsb2Nrcy4gIFRoZSBpbm9kZXMtcGVyLWdyb3VwIGlzIGNv
bXB1dGVkIHRvIDMyNzY5ICgxIG1vcmUNCiAgICB0aGFuIHRoZSBsaW1pdCBiYXNlZCBvbiB0aGUg
aW5vZGVfcmF0aW8pDQoNCiAgICBUaGlzIGRvZXMgbm90IGhhcHBlbiBvbiBwbGFpbiBleHQ0IGZp
bGVzeXN0ZW0gKHdpdGhvdXQgYmlnYWxsb2MpLg0KDQpFeGFtcGxlIGZhaWx1cmUgIzI6DQo9LT0t
PS09LT0tLT0tPS09LT0NCiAgICAjIHdpcGVmcyAtYSAvZGV2L252bWUxbjE7IG1rZTJmcyAtbSAx
IC10IGV4dDQgLU8gYmlnYWxsb2MgLUMgMTYzODQgLWIgNDA5NiAvZGV2L252bWUxbjEgMjA5NzMw
MA0KICAgIG1rZTJmcyAxLjQ3LjAgKDUtRmViLTIwMjMpDQogICAgL2Rldi9udm1lMW4xOiBDYW5u
b3QgY3JlYXRlIGZpbGVzeXN0ZW0gd2l0aCByZXF1ZXN0ZWQgbnVtYmVyIG9mIGlub2RlcyB3aGls
ZSBzZXR0aW5nIHVwIHN1cGVyYmxvY2sNCiAgICAjDQoNCiAgICBJbiB0aGlzIGNhc2UsIGxhc3Qg
YmxvY2sgZ3JvdXAgaGFzIDE0OCBibG9ja3MsIGJ1dCB0aGUgb3ZlcmhlYWQgaXMNCiAgICAxOTMw
LiAgVGhlIGlub2Rlcy1wZXItZ3JvdXAgaXMgY29tcHV0ZWQgdG8gMzI3NzEgYW5kIGl0IGZhaWxz
Lg0KICAgIFJvdW5kIHRoZSBibG9ja3MgdG8gYmxvY2sgZ3JvdXAgYm91bmRhcnkgdG8gc3VjY2Vl
ZC4NCiAgICAjIGVjaG8gJCgoKDIwOTczMDAgJiB+MHgxZmZmZikpKQ0KICAgIDIwOTcxNTINCiAg
ICAjDQogICAgIyBta2UyZnMgLW0gMSAtdCBleHQ0IC1PIGJpZ2FsbG9jIC1DIDE2Mzg0IC1iIDQw
OTYgL2Rldi9udm1lMW4xIDIwOTcxNTINCg0KRXhhbXBsZSBmYWlsdXJlICMzOg0KPS09LT0tPS09
LS09LT0tPS09DQogICAgIyB3aXBlZnMgLWEgL2Rldi9udm1lMW4xOyBta2UyZnMgLW0gMSAtdCBl
eHQ0IC1PIGJpZ2FsbG9jIC1DIDE2Mzg0IC1iIDQwOTYgL2Rldi9udm1lMW4xIDE2Nzc4MDAwDQog
ICAgbWtlMmZzIDEuNDcuMCAoNS1GZWItMjAyMykNCiAgICAvZGV2L252bWUxbjE6IENhbm5vdCBj
cmVhdGUgZmlsZXN5c3RlbSB3aXRoIHJlcXVlc3RlZCBudW1iZXIgb2YgaW5vZGVzIHdoaWxlIHNl
dHRpbmcgdXAgc3VwZXJibG9jaw0KICAgICMNCg0KICAgIEhlcmUsIGxhc3QgYmxvY2sgZ3JvdXAg
aGFzIDc4NCBibG9ja3MsIG92ZXJoZWFkIGlzIDIwMzUgYW5kDQogICAgaW5vZGVzLXBlci1ncm91
cCBpcyBjb21wdXRlZCB0byBiZSAzMjc3MCBhbmQgZmFpbHMuDQogICAgUm91bmQgdGhlIGJsb2Nr
IGNvdW50IHRvIHN1Y2Nlc3NmdWxseSBjcmVhdGUgdGhlIGZpbGVzeXN0ZW0uDQogICAgIyBlY2hv
ICQoKCgxNjc3ODAwMCAmIH4weDFmZmZmKSkpDQogICAgMTY3NzcyMTYNCiAgICAjDQogICAgIyBt
a2UyZnMgLW0gMSAtdCBleHQ0IC1PIGJpZ2FsbG9jIC1DIDE2Mzg0IC1iIDQwOTYgL2Rldi9udm1l
MW4xIDE2Nzc3MjE2DQoNCg==
