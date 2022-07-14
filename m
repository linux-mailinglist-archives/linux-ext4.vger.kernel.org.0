Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EA6575604
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 21:53:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiGNTxm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 15:53:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237574AbiGNTxk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 15:53:40 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F4BEDEA2
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 12:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1657828419; x=1689364419;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=XSCASme/40gs1UQMvf+RVemMdiBmFl1ZPtaxO7k67yA=;
  b=XPWS29pcH7M5KJgaPgBIQVT0FgiIxGEwxoimYHqnLfJObPBhObR2Tbi9
   +7YNoblPPIl90kYfXH8jmK0PJ0XjNfEDYP94hgEhScCNX729VdEPdQZCj
   f9iAfN+wTq/D0sgZdbIyOhIWyyn1i5WghMenq2f4ROTzMvwuEDkbzNkHJ
   8=;
X-IronPort-AV: E=Sophos;i="5.92,272,1650931200"; 
   d="scan'208";a="108502538"
Subject: Re: [PATCH 1/2] ext4: reduce computation of overhead during resize
Thread-Topic: [PATCH 1/2] ext4: reduce computation of overhead during resize
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2c-51ba86d8.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 14 Jul 2022 19:53:38 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-51ba86d8.us-west-2.amazon.com (Postfix) with ESMTPS id AF0C9141C66;
        Thu, 14 Jul 2022 19:53:38 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 14 Jul 2022 19:53:38 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Thu, 14 Jul 2022 19:53:38 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.036;
 Thu, 14 Jul 2022 19:53:38 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     Jan Kara <jack@suse.cz>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Thread-Index: AQHYjCeH91+dMyGz00Kz59z9i8AzhK19+ACAgABmgYA=
Date:   Thu, 14 Jul 2022 19:53:38 +0000
Message-ID: <63A35E4E-C7B9-4B2C-BBCC-F43BECDFEA6A@amazon.com>
References: <D03FEE2D-DCAE-44A7-B0D3-0047808426BB@amazon.com>
 <20220714134645.r4gqax4au5el2pox@quack3>
In-Reply-To: <20220714134645.r4gqax4au5el2pox@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.189]
Content-Type: text/plain; charset="utf-8"
Content-ID: <1320C450520B274A9852BB4D670C921C@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-12.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmV2aWV3LCBKYW4uDQoNCj4gT24gSnVsIDE0LCAyMDIyLCBhdCA2OjQ2
IEFNLCBKYW4gS2FyYSA8amFja0BzdXNlLmN6PiB3cm90ZToNCj4gDQo+IENBVVRJT046IFRoaXMg
ZW1haWwgb3JpZ2luYXRlZCBmcm9tIG91dHNpZGUgb2YgdGhlIG9yZ2FuaXphdGlvbi4gRG8gbm90
IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBjYW4gY29uZmlybSB0
aGUgc2VuZGVyIGFuZCBrbm93IHRoZSBjb250ZW50IGlzIHNhZmUuDQo+IA0KPiANCj4gDQo+IE9u
IFRodSAzMC0wNi0yMiAwMjoxNzoyMSwgS2lzZWxldiwgT2xlZyB3cm90ZToNCj4+IFRoaXMgcGF0
Y2ggYXZvaWRzIGRvaW5nIGFuIE8obioqMiktY29tcGxleGl0eSB3YWxrIHRocm91Z2ggZXZlcnkg
ZmxleCBncm91cC4NCj4+IEluc3RlYWQsIGl0IHVzZXMgdGhlIGFscmVhZHkgY29tcHV0ZWQgb3Zl
cmhlYWQgaW5mb3JtYXRpb24gZm9yIHRoZSBuZXdseQ0KPj4gYWxsb2NhdGVkIHNwYWNlLCBhbmQg
c2ltcGx5IGFkZHMgaXQgdG8gdGhlIHByZXZpb3VzbHkgY2FsY3VsYXRlZA0KPj4gb3ZlcmhlYWQg
c3RvcmVkIGluIHRoZSBzdXBlcmJsb2NrLiAgVGhpcyBkcmFzdGljYWxseSByZWR1Y2VzIHRoZSB0
aW1lDQo+PiB0YWtlbiB0byByZXNpemUgdmVyeSBsYXJnZSBiaWdhbGxvYyBmaWxlc3lzdGVtcyAo
ZnJvbSAzKyBob3VycyBmb3IgYQ0KPj4gNjRUQiBmcyBkb3duIHRvIG1pbGxpc2Vjb25kcykuDQo+
PiANCj4+IFNpZ25lZC1vZmYtYnk6IE9sZWcgS2lzZWxldiA8b2tpc2VsZXZAYW1hem9uLmNvbT4N
Cj4+IC0tLQ0KPj4gZnMvZXh0NC9yZXNpemUuYyB8IDIwICsrKysrKysrKysrKysrKysrKystDQo+
PiAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiANCj4g
T3ZlcmFsbCB0aGlzIGxvb2tzIGZpbmUsIGEgZmV3IHNtYWxsZXIgY29tbWVudHMgYmVsb3cuDQo+
IA0KPj4gDQo+PiBkaWZmIC0tZ2l0IGEvZnMvZXh0NC9yZXNpemUuYyBiL2ZzL2V4dDQvcmVzaXpl
LmMNCj4+IGluZGV4IDhiNzBhNDcwMTI5My4uMmFjYzlmY2E5OWVhIDEwMDY0NA0KPj4gLS0tIGEv
ZnMvZXh0NC9yZXNpemUuYw0KPj4gKysrIGIvZnMvZXh0NC9yZXNpemUuYw0KPj4gQEAgLTEzODAs
NiArMTM4MCwxNiBAQCBzdGF0aWMgaW50IGV4dDRfc2V0dXBfbmV3X2Rlc2NzKGhhbmRsZV90ICpo
YW5kbGUsIHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQo+PiAgICAgIHJldHVybiBlcnI7DQo+PiB9
DQo+PiANCj4+ICtzdGF0aWMgdm9pZCBleHQ0X3NldF9vdmVyaGVhZChzdHJ1Y3Qgc3VwZXJfYmxv
Y2sgKnNiLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY29uc3QgZXh0NF9ncnBi
bGtfdCBvdmVyaGVhZCkNCj4+ICt7DQo+IA0KPiBleHQ0X2FkZF9vdmVyaGVhZCgpIHdvdWxkIGJl
IGEgYmV0dGVyIG5hbWUgSSBzdXBwb3NlLiBBbHNvIHRoZSAnb3ZlcmhlYWQnDQo+IHNob3VsZCBy
YXRoZXIgYmUgZXh0NF9mc2Jsa190IHRvIGJlIG9uIHRoZSBzYWZlIHNpZGUuLi4NCg0KRG9uZS4N
Cg0KPiANCj4+ICsgICAgICAgc3RydWN0IGV4dDRfc2JfaW5mbyAqc2JpID0gRVhUNF9TQihzYik7
DQo+PiArICAgICAgIHN0cnVjdCBleHQ0X3N1cGVyX2Jsb2NrICplcyA9IHNiaS0+c19lczsNCj4g
DQo+IEVtcHR5IGxpbmUgYmV0d2VlbiB2YXJpYWJsZSBkZWNsYXJhdGlvbnMgYW5kIHRoZSBjb2Rl
IHBsZWFzZS4NCg0KRG9uZQ0KDQo+IA0KPj4gKyAgICAgICBzYmktPnNfb3ZlcmhlYWQgKz0gb3Zl
cmhlYWQ7DQo+PiArICAgICAgIGVzLT5zX292ZXJoZWFkX2NsdXN0ZXJzID0gY3B1X3RvX2xlMzIo
KHVuc2lnbmVkIGxvbmcpIHNiaS0+c19vdmVyaGVhZCk7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgXl5eIHRoZSB0eXBlY2FzdCBsb29rcw0KPiBib2d1
cyBoZXJlLi4uDQoNClRoaXMgY2FzdCBpcyB0aGUgcmV2ZXJzZSBvZiBsZTMyX3RvX2NwdSgpIGNh
c3QgZG9uZSBpbiBmcy9leHQ0L3N1cGVyLmM6X19leHQ0X2ZpbGxfc3VwZXIoKToNCiAgICAgICAg
c2JpLT5zX292ZXJoZWFkID0gbGUzMl90b19jcHUoZXMtPnNfb3ZlcmhlYWRfY2x1c3RlcnMpOw0K
QW5kIGZvbGxvd3MgdGhlIGxvZ2ljIG9mIGNhc3RpbmcgZG9uZSBpbiBmcy9leHQ0L2lvY3RsLmM6
c2V0X292ZXJoZWFkKCkgYW5kIGZzL2V4dDQvaW9jdGwuYzpleHQ0X3VwZGF0ZV9vdmVyaGVhZCgp
LiANCg0KPiANCj4+ICsgICAgICAgc21wX3dtYigpOw0KPj4gK30NCj4gDQo+IFRoZSBiYXJyaWVy
IHdpdGhvdXQgYW55IGNvbW1lbnQgbWFrZXMgbWUgcmVhbGx5IHdvbmRlciB3aHkgaXQgaXMgaGVy
ZS4uLg0KPiBCdXQgSSBnZXQgZXh0NF9jYWxjdWxhdGVfb3ZlcmhlYWQoKSBoYXMgaXMgYXMgd2Vs
bCBzbyB5b3UncmUganVzdCBrZWVwaW5nDQo+IGl0Lg0KDQpZZXMsIGV4YWN0bHkuICBJIGFtIGF3
YXJlIG9mIG9ubHkgb25lIHBsYWNlIHdoZXJlIHNfb3ZlcmhlYWQgYW5kIHNfb3ZlcmhlYWRfY2x1
c3RlcnMgaGF2ZSB0byBiZSBjb2hlcmVudCwgaW4gZXh0NF91cGRhdGVfb3ZlcmhlYWQoKSwgd2hp
Y2ggcG90ZW50aWFsbHkgbWF5IGJlIGNhbGxlZCBjb25jdXJyZW50bHkgd2l0aCB0aGUgcmVzaXpl
LiAgS2VlcGluZyB0aGUgd3JpdGUgYmFycmllciBoZXJlIHNlZW1lZCBsaWtlIGEgc2FmZSBjaG9p
Y2UsIHNpbmNlIGl04oCZcyBub3QgaW4gdGhlIHJlZ3VsYXIgSU8gcGF0aCwgc28gdGhlIGFkZGVk
IGV4cGVuc2UgaXMgaW5jdXJyZWQgb25seSB2ZXJ5IHJhcmVseS4gDQoNCj4gDQo+PiArDQo+PiAv
Kg0KPj4gICogZXh0NF91cGRhdGVfc3VwZXIoKSB1cGRhdGVzIHRoZSBzdXBlciBibG9jayBzbyB0
aGF0IHRoZSBuZXdseSBhZGRlZA0KPj4gICogZ3JvdXBzIGNhbiBiZSBzZWVuIGJ5IHRoZSBmaWxl
c3lzdGVtLg0KPj4gQEAgLTE0ODIsOCArMTQ5MiwxNiBAQCBzdGF0aWMgdm9pZCBleHQ0X3VwZGF0
ZV9zdXBlcihzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPj4gDQo+PiAgICAgIC8qDQo+PiAgICAg
ICAqIFVwZGF0ZSB0aGUgZnMgb3ZlcmhlYWQgaW5mb3JtYXRpb24NCj4+ICsgICAgICAqDQo+PiAr
ICAgICAgKiBGb3IgYmlnYWxsb2MsIGlmIHRoZSBzdXBlcmJsb2NrIGFscmVhZHkgaGFzIGEgcHJv
cGVybHkgY2FsY3VsYXRlZA0KPj4gKyAgICAgICogb3ZlcmhlYWQsIHVwZGF0ZSBpdCB3dGggYSB2
YWx1ZSBiYXNlZCBvbiBudW1iZXJzIGFscmVhZHkgY29tcHV0ZWQNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIF5eIHdpdGgNCj4gDQo+PiArICAgICAgKiBhYm92ZSBmb3IgdGhlIG5l
d2x5IGFsbG9jYXRlZCBjYXBhY2l0eS4NCj4+ICAgICAgICovDQo+PiAtICAgICBleHQ0X2NhbGN1
bGF0ZV9vdmVyaGVhZChzYik7DQo+PiArICAgICBpZiAoZXh0NF9oYXNfZmVhdHVyZV9iaWdhbGxv
YyhzYikgJiYgKHNiaS0+c19vdmVyaGVhZCAhPSAwKSkNCj4+ICsgICAgICAgICAgICAgZXh0NF9z
ZXRfb3ZlcmhlYWQoc2IsDQo+PiArICAgICAgICAgICAgICAgICAgICAgRVhUNF9OVU1fQjJDKHNi
aSwgYmxvY2tzX2NvdW50IC0gZnJlZV9ibG9ja3MpKTsNCj4+ICsgICAgIGVsc2UNCj4+ICsgICAg
ICAgICAgICAgZXh0NF9jYWxjdWxhdGVfb3ZlcmhlYWQoc2IpOw0KPj4gDQo+PiAgICAgIGlmICh0
ZXN0X29wdChzYiwgREVCVUcpKQ0KPj4gICAgICAgICAgICAgIHByaW50ayhLRVJOX0RFQlVHICJF
WFQ0LWZzOiBhZGRlZCBncm91cCAldToiDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb256YQ0KPiAtLQ0KPiBKYW4g
S2FyYSA8amFja0BzdXNlLmNvbT4NCj4gU1VTRSBMYWJzLCBDUg0KDQpJ4oCZbGwgcmVzdWJtaXQg
dGhlIHVwZGF0ZWQgcGF0Y2gu
