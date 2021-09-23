Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420C941560C
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Sep 2021 05:31:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239036AbhIWDcd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 22 Sep 2021 23:32:33 -0400
Received: from smtp-fw-80006.amazon.com ([99.78.197.217]:28203 "EHLO
        smtp-fw-80006.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238949AbhIWDcc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 22 Sep 2021 23:32:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1632367862; x=1663903862;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=5CxFtal/Hn//b40/IXDcrn/zqo0Xc0w0xzlHbUgywZQ=;
  b=lu0Er1gGlChnbLvIuCRP1wrC106QrfihzaWmv3ZR6KkYTNaTNopOt1PD
   JDrYQtB+SXo6Q1lBRQ40LgTCIFCAr2yDB4EFbCMs6H3l/JY9pmgyWyaJg
   06V0H6VyJJFZc8SaJ3s/tj5VJsLitAGGeXSD4BP9/hDoYrdXnWW6ik5FS
   k=;
X-IronPort-AV: E=Sophos;i="5.85,315,1624320000"; 
   d="scan'208";a="28983016"
Subject: Re: [PATCH] mke2fs: Add extended option for prezeroed storage devices
Thread-Topic: [PATCH] mke2fs: Add extended option for prezeroed storage devices
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-a264e6fe.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP; 23 Sep 2021 03:31:01 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-a264e6fe.us-west-2.amazon.com (Postfix) with ESMTPS id 6AD1E41A98;
        Thu, 23 Sep 2021 03:31:01 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.249) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 23 Sep 2021 03:31:01 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23; Thu, 23 Sep 2021 03:31:00 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.023;
 Thu, 23 Sep 2021 03:31:00 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
Thread-Index: AQHXrprBxoMQtoagsku2FNGJqOwSh6uvBTSAgAF/EQA=
Date:   Thu, 23 Sep 2021 03:31:00 +0000
Message-ID: <0A4B11C1-A119-4733-A841-683889E9DC7B@amazon.com>
References: <20210921034203.323950-1-sarthakkukreti@google.com>
 <C5A2A75B-F767-40AC-B500-C99D484E9E30@dilger.ca>
In-Reply-To: <C5A2A75B-F767-40AC-B500-C99D484E9E30@dilger.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.216]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9D84512861A0FC4EBAE30E77B916223D@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

V291bGRuJ3QgaXQgbWFrZSBtb3JlIHNlbnNlIHRvIHVzZSAid3JpdGUtc2FtZSIgb2YgMCBpbnN0
ZWFkIG9mIHdyaXRpbmcgYSBwYWdlIG9mIHplcm9zIGFuZCB0YXNrIHRoZSBsYXllcnMgdGhhdCBk
byB0aGluIHByb3Zpc2lvbmluZyBhbmQgcmV0dXJuIDAgb24gcmVhZCBmcm9tIHVuYWxsb2NhdGVk
IGJsb2NrcyB0byBjaGVjayBpZiBhIGJsb2NrIGV4aXN0cyBiZWZvcmUgd3JpdGluZyB6ZXJvcyB0
byBpdD8NCg0K77u/T24gOS8yMS8yMSwgMjo0MCBQTSwgIkFuZHJlYXMgRGlsZ2VyIiA8YWRpbGdl
ckBkaWxnZXIuY2E+IHdyb3RlOg0KDQogICAgT24gU2VwIDIwLCAyMDIxLCBhdCA5OjQyIFBNLCBT
YXJ0aGFrIEt1a3JldGkgPHNhcnRoYWtrdWtyZXRpQGNocm9taXVtLm9yZz4gd3JvdGU6DQogICAg
PiANCiAgICA+IEZyb206IFNhcnRoYWsgS3VrcmV0aSA8c2FydGhha2t1a3JldGlAY2hyb21pdW0u
b3JnPg0KICAgID4gDQogICAgPiBUaGlzIHBhdGNoIGFkZHMgYW4gZXh0ZW5kZWQgb3B0aW9uICJh
c3N1bWVfc3RvcmFnZV9wcmV6ZXJvZWQiIHRvDQogICAgPiBta2UyZnMuIFdoZW4gZW5hYmxlZCwg
dGhpcyBvcHRpb24gYWN0cyBhcyBhIGhpbnQgdG8gbWtlMmZzIHRoYXQNCiAgICA+IHRoZSB1bmRl
cmx5aW5nIGJsb2NrIGRldmljZSB3YXMgemVyb2VkIGJlZm9yZSBta2UyZnMgd2FzIGNhbGxlZC4N
CiAgICA+IFRoaXMgYWxsb3dzIG1rZTJmcyB0byBvcHRpbWl6ZSBvdXQgdGhlIHplcm9pbmcgb2Yg
dGhlIGlub2RlDQogICAgPiB0YWJsZSBhbmQgdGhlIGpvdXJuYWwsIHdoaWNoIHNwZWVkcyB1cCB0
aGUgZmlsZXN5c3RlbSBjcmVhdGlvbg0KICAgID4gdGltZS4NCiAgICA+IA0KICAgID4gQWRkaXRp
b25hbGx5LCBvbiB0aGlubHkgcHJvdmlzaW9uZWQgc3RvcmFnZSBkZXZpY2VzIChsaWtlIENlcGgs
DQogICAgPiBkbS10aGluKSwNCg0KICAgIC4uLiBhbmQgbmV3bHktY3JlYXRlZCBzcGFyc2UgbG9v
cGJhY2sgZmlsZXMNCg0KICAgID4gcmVhZHMgb24gdW5tYXBwZWQgZXh0ZW50cyByZXR1cm4gemVy
by4gVGhpcyBwcm9wZXJ0eQ0KICAgID4gYWxsb3dzIG1rZTJmcyAod2l0aCBhc3N1bWVfc3RvcmFn
ZV9wcmV6ZXJvZWQpIHRvIGF2b2lkDQogICAgPiBwcmUtYWxsb2NhdGluZyBtZXRhZGF0YSBzcGFj
ZSBmb3IgaW5vZGUgdGFibGVzIGZvciB0aGUgZW50aXJlDQogICAgPiBmaWxlc3lzdGVtIGFuZCBz
YXZlcyBzcGFjZSB0aGF0IHdvdWxkIG5vcm1hbGx5IGJlIHByZWFsbG9jYXRlZA0KICAgID4gZm9y
IHplcm8gaW5vZGUgdGFibGVzLg0KICAgID4gDQogICAgPiBUZXN0aW5nIG9uIENocm9tZU9TIChy
dW5uaW5nIGxpbnV4IGtlcm5lbCA0LjE5KSB3aXRoIGRtLXRoaW4NCiAgICA+IGFuZCAyMDBHQiB0
aGluIGxvZ2ljYWwgdm9sdW1lcyB1c2luZyAnbWtlMmZzIC10IGV4dDQgPGRldj4nOg0KICAgID4g
DQogICAgPiAtIFRpbWUgdGFrZW4gYnkgbWtlMmZzIGRyb3BzIGZyb20gMS4wN3MgdG8gMC4wOHMu
DQogICAgPiAtIEF2b2lkaW5nIHplcm9pbmcgb3V0IHRoZSBpbm9kZSB0YWJsZSBhbmQgam91cm5h
bCByZWR1Y2VzIHRoZQ0KICAgID4gIGluaXRpYWwgbWV0YWRhdGEgc3BhY2UgYWxsb2NhdGlvbiBm
cm9tIDAuNDglIHRvIDAuMDElLg0KICAgID4gLSBMYXp5IGlub2RlIHRhYmxlIHplcm9pbmcgcmVz
dWx0cyBpbiBhIGZ1cnRoZXIgMS40NSUgb2YgbG9naWNhbA0KICAgID4gIHZvbHVtZSBzcGFjZSBn
ZXR0aW5nIGFsbG9jYXRlZCBmb3IgaW5vZGUgdGFibGVzLCBldmVuIGlmIG5vdCBmaWxlDQogICAg
PiAgZGF0YSBpcyBhZGRlZCB0byB0aGUgZmlsZXN5c3RlbS4gV2l0aCBhc3N1bWVfc3RvcmFnZV9w
cmV6ZXJvZWQsDQogICAgPiAgdGhlIG1ldGFkYXRhIGFsbG9jYXRpb24gcmVtYWlucyBhdCAwLjAx
JS4NCg0KICAgIFRoaXMgc2VlbXMgYmVuZWZpY2lhbCwgYnV0IEknbSB3b25kZXJpbmcgaWYgdGhp
cyBjb3VsZCBhbHNvIGJlDQogICAgZG9uZSBhdXRvbWF0aWNhbGx5IHdoZW4gVFJJTS9ESVNDQVJE
IGlzIHVzZWQgYnkgbWtlMmZzIHRvIGVyYXNlDQogICAgYSBkZXZpY2U/DQoNCiAgICBPbmUgc2Fm
ZSBvcHRpb24gdG8gZG8gdGhpcyBhdXRvbWF0aWNhbGx5IHdvdWxkIGJlIHRvIHN0YXJ0IGJ5DQog
ICAgKnJlYWRpbmcqIHRoZSBkaXNrIGJsb2NrcyBhbmQgY2hlY2sgaWYgdGhleSBhcmUgYWxsIHpl
cm8sIGFuZCBvbmx5DQogICAgc3dpdGNoIHRvIHplcm8tYmxvY2sgd3JpdGVzIGlmIGFueSBibG9j
ayBpcyBmb3VuZCB3aXRoIG5vbi16ZXJvDQogICAgZGF0YS4gIFRoYXQgd291bGQgYXZvaWQgdGhl
IGV4dHJhIHNwYWNlIHVzYWdlIGZyb20gemVyby1ibG9jaw0KICAgIHdyaXRlcyBpbiB0aGUgYWJv
dmUgY2FzZXMsIGFuZCBhbHNvIHdvcmsgZm9yIHRoZSBodWdlIG1ham9yaXR5IG9mDQogICAgdXNl
cnMgdGhhdCB3b24ndCBrbm93IHRoZSAiYXNzdW1lX3N0b3JhZ2VfcHJlemVyb2VkIiBvcHRpb24g
ZXZlbg0KICAgIGV4aXRzLCB0aG91Z2ggaXQgd29uJ3QgbmVjZXNzYXJpbHkgcmVkdWNlIHRoZSBy
dW50aW1lLg0KDQogICAgPiBkaWZmIC0tZ2l0IGEvbWlzYy9ta2UyZnMuYyBiL21pc2MvbWtlMmZz
LmMNCiAgICA+IGluZGV4IDA0YjJmYmNlLi41MjkzZDliMCAxMDA2NDQNCiAgICA+IC0tLSBhL21p
c2MvbWtlMmZzLmMNCiAgICA+ICsrKyBiL21pc2MvbWtlMmZzLmMNCiAgICA+IEBAIC0zMDk1LDYg
KzMxMDIsMTggQEAgaW50IG1haW4gKGludCBhcmdjLCBjaGFyICphcmd2W10pDQogICAgPiAJCWlv
X2NoYW5uZWxfc2V0X29wdGlvbnMoZnMtPmlvLCBvcHRfc3RyaW5nKTsNCiAgICA+IAl9DQogICAg
PiANCiAgICA+ICsJaWYgKGFzc3VtZV9zdG9yYWdlX3ByZXplcm9lZCkgew0KICAgID4gKwkgIGlm
ICh2ZXJib3NlKQ0KICAgID4gKwkJCXByaW50ZigiJXMiLA0KICAgID4gKwkJCQkgICAgICAgXygi
QXNzdW1pbmcgdGhlIHN0b3JhZ2UgZGV2aWNlIGlzIHByZXplcm9lZCAiDQogICAgPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICItIHNraXBwaW5nIGlub2RlIHRhYmxlIGFuZCBqb3VybmFsIHdp
cGVcbiIpKTsNCiAgICA+ICsNCiAgICA+ICsJICBsYXp5X2l0YWJsZV9pbml0ID0gMTsNCiAgICA+
ICsJICBpdGFibGVfemVyb2VkID0gMTsNCiAgICA+ICsJICB6ZXJvX2h1Z2VmaWxlID0gMDsNCiAg
ICA+ICsJICBqb3VybmFsX2ZsYWdzIHw9IEVYVDJfTUtKT1VSTkFMX0xBWllJTklUOw0KICAgID4g
Kwl9DQoNCiAgICBJbmRlbnRhdGlvbiBhcHBlYXJzIHRvIGJlIGJyb2tlbiBoZXJlIC0gb25seSAy
IHNwYWNlcyBpbnN0ZWFkIG9mIGEgdGFiLg0KDQogICAgVGhpcyBpcyBhbHNvIG1pc3NpbmcgYW55
IGtpbmQgb2YgdGVzdCBjYXNlLiAgU2luY2UgYSBsYXJnZSBudW1iZXIgb2YNCiAgICB0aGUgZTJm
c2NrIHRlc3QgY2FzZXMgYXJlIHVzaW5nIGxvb3BiYWNrIGZpbGVzeXN0ZW1zIGNyZWF0ZWQgb24g
YSBzcGFyc2UNCiAgICBmaWxlLCB0aGlzIHdvdWxkIGJvdGggYmUgZ29vZCB0ZXN0IGNhc2VzLCBh
cyB3ZWxsIGFzIHJlZHVjaW5nIHRpbWUvc3BhY2UNCiAgICB1c2VkIGR1cmluZyB0ZXN0aW5nLg0K
DQogICAgQ2hlZXJzLCBBbmRyZWFzDQoNCg0KDQoNCg0KDQo=
