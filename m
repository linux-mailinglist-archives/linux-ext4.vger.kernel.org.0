Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A2D05E91B5
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Sep 2022 10:51:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbiIYIvZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Sep 2022 04:51:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiIYIvX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Sep 2022 04:51:23 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA2F2DAAA;
        Sun, 25 Sep 2022 01:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1664095883; x=1695631883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Jd64G1ELGY+Szb0KFz4W+irMQzt8TG4hZRQWpxBwscg=;
  b=gNZroi7VIPgIQ9m3tfYrZM+A/GP+6fAhusX9EJYSQc0yqiP1YdUezFKg
   GcHK7vzyVT8jFmM041cx3JhhSJ5WxkgVnVi/JIoXXB/vnooyFD+D+9Ifm
   dVR9uag8rnMrI3DIzEUvLvzxR5EAn3HZko7PPp5FSTq/Om0wPkBGyZU88
   I=;
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-31df91b1.us-west-2.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 08:51:12 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-31df91b1.us-west-2.amazon.com (Postfix) with ESMTPS id B31F945BE9;
        Sun, 25 Sep 2022 08:51:10 +0000 (UTC)
Received: from EX13D23UWC002.ant.amazon.com (10.43.162.22) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Sun, 25 Sep 2022 08:51:10 +0000
Received: from EX19D017UWC003.ant.amazon.com (10.13.139.227) by
 EX13D23UWC002.ant.amazon.com (10.43.162.22) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Sun, 25 Sep 2022 08:51:09 +0000
Received: from EX19D017UWC003.ant.amazon.com ([fe80::78e9:1d67:81fd:68c5]) by
 EX19D017UWC003.ant.amazon.com ([fe80::78e9:1d67:81fd:68c5%6]) with mapi id
 15.02.1118.012; Sun, 25 Sep 2022 08:51:09 +0000
From:   "Lu, Davina" <davinalu@amazon.com>
To:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "Kiselev, Oleg" <okiselev@amazon.com>,
        "Liu, Frank" <franklmz@amazon.com>,
        "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
Subject: RE: significant drop  fio IOPS performance on v5.10
Thread-Topic: significant drop  fio IOPS performance on v5.10
Thread-Index: AdjO5vTzPItE0he4TsCHXHwBRGK6iAB1NzvQ
Date:   Sun, 25 Sep 2022 08:51:09 +0000
Message-ID: <1cdc68e6a98d4e93a95be5d887bcc75d@amazon.com>
References: <357ace228adf4e859df5e9f3f4f18b49@amazon.com>
In-Reply-To: <357ace228adf4e859df5e9f3f4f18b49@amazon.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.162.65]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-11.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

KyBhYnVlaGF6ZUBhbWF6b24uY29tDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9t
OiBMdSwgRGF2aW5hIA0KU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjMsIDIwMjIgMTA6NTUgQU0N
ClRvOiBsaW51eC1leHQ0QHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZw0KQ2M6IEtpc2VsZXYsIE9sZWcgPG9raXNlbGV2QGFtYXpvbi5jb20+OyBMaXUsIEZyYW5r
IDxmcmFua2xtekBhbWF6b24uY29tPg0KU3ViamVjdDogc2lnbmlmaWNhbnQgZHJvcCBmaW8gSU9Q
UyBwZXJmb3JtYW5jZSBvbiB2NS4xMA0KDQpIZWxsbywNCg0KSSB3YXMgcHJvZmlsaW5nIHRoZSA1
LjEwIGtlcm5lbCBhbmQgY29tcGFyaW5nIGl0IHRvIDQuMTQuICBPbiBhIHN5c3RlbSB3aXRoIDY0
IHZpcnR1YWwgQ1BVcyBhbmQgMjU2IEdpQiBvZiBSQU0sIEkgYW0gb2JzZXJ2aW5nIGEgc2lnbmlm
aWNhbnQgZHJvcCBpbiBJTyBwZXJmb3JtYW5jZS4gVXNpbmcgdGhlIGZvbGxvd2luZyBGSU8gd2l0
aCB0aGUgc2NyaXB0ICJzdWRvIGZ0ZXN0X3dyaXRlLnNoIDxkZXZfbmFtZT4iIGluIGF0dGFjaG1l
bnQsIEkgc2F3IEZJTyBpb3BzIHJlc3VsdCBkcm9wIGZyb20gMjJLIHRvIGxlc3MgdGhhbiAxSy4g
DQpUaGUgc2NyaXB0IHNpbXBseSBkb2VzOiBtb3VudCBhIHRoZSBFWFQ0IDE2R2lCIHZvbHVtZSB3
aXRoIG1heCBJT1BTIDY0MDAwSywgbW91bnRpbmcgb3B0aW9uIGlzICIgLW8gbm9hdGltZSxub2Rp
cmF0aW1lLGRhdGE9b3JkZXJlZCIsIHRoZW4gcnVuIGZpbyB3aXRoIDIwNDggZmlvIHdyaW5nIHRo
cmVhZCB3aXRoIDI4ODAwMDAwIGZpbGUgc2l6ZSB3aXRoIHsgLS1uYW1lPTE2a2JfcmFuZF93cml0
ZV9vbmx5XzIwNDhfam9icyAtLWRpcmVjdG9yeT0vcmRzZGJkYXRhMSAtLXJ3PXJhbmR3cml0ZSAt
LWlvZW5naW5lPXN5bmMgLS1idWZmZXJlZD0xIC0tYnM9MTZrIC0tbWF4LWpvYnM9MjA0OCAtLW51
bWpvYnM9MjA0OCAtLXJ1bnRpbWU9NjAgLS10aW1lX2Jhc2VkIC0tdGhyZWFkIC0tZmlsZXNpemU9
Mjg4MDAwMDAgLS1mc3luYz0xIC0tZ3JvdXBfcmVwb3J0aW5nIH0uDQoNCk15IGFuYWx5emluZyBp
cyB0aGF0IHRoZSBkZWdyYWRhdGlvbiBpcyBpbnRyb2R1Y2UgYnkgY29tbWl0IHsyNDRhZGY2NDI2
ZWUzMWE4M2YzOTdiNzAwZDk2NGNmZjEyYTI0N2QzfSBhbmQgdGhlIGlzc3VlIGlzIHRoZSBjb250
ZW50aW9uIG9uIHJzdl9jb252ZXJzaW9uX3dxLiAgVGhlIHNpbXBsZXN0IG9wdGlvbiBpcyB0byBp
bmNyZWFzZSB0aGUgam91cm5hbCBzaXplLCBidXQgdGhhdCBpbnRyb2R1Y2VzIG1vcmUgb3BlcmF0
aW9uYWwgY29tcGxleGl0eS4gIEFub3RoZXIgb3B0aW9uIGlzIHRvIGFkZCB0aGUgZm9sbG93aW5n
IGNoYW5nZSBpbiBhdHRhY2htZW50ICJhbGxvdyBtb3JlIGV4dDQtcnN2LWNvbnZlcnNpb24gd29y
a3F1ZXVlLnBhdGNoIg0KDQpGcm9tIDI3ZTFiMGUxNDI3NWEyODFiMzUyOWY2YTYwYzdiMjNhODEz
NTY3NTEgTW9uIFNlcCAxNyAwMDowMDowMCAyMDAxDQpGcm9tOiBkYXZpbmFsdSA8ZGF2aW5hbHVA
YW1hem9uLmNvbT4NCkRhdGU6IEZyaSwgMjMgU2VwIDIwMjIgMDA6NDM6NTMgKzAwMDANClN1Ympl
Y3Q6IFtQQVRDSF0gYWxsb3cgbW9yZSBleHQ0LXJzdi1jb252ZXJzaW9uIHdvcmtxdWV1ZSB0byBz
cGVlZHVwIGZpbyAgd3JpdGluZw0KLS0tDQogZnMvZXh0NC9zdXBlci5jIHwgMiArLQ0KIDEgZmls
ZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEv
ZnMvZXh0NC9zdXBlci5jIGIvZnMvZXh0NC9zdXBlci5jIGluZGV4IGEwYWY4MzNmN2RhNy4uNmIz
NDI5OGNkYzNiIDEwMDY0NA0KLS0tIGEvZnMvZXh0NC9zdXBlci5jDQorKysgYi9mcy9leHQ0L3N1
cGVyLmMNCkBAIC00OTYzLDcgKzQ5NjMsNyBAQCBzdGF0aWMgaW50IGV4dDRfZmlsbF9zdXBlcihz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB2b2lkICpkYXRhLCBpbnQgc2lsZW50KQ0KICAgICAgICAg
KiBjb25jdXJyZW5jeSBpc24ndCByZWFsbHkgbmVjZXNzYXJ5LiAgTGltaXQgaXQgdG8gMS4NCiAg
ICAgICAgICovDQogICAgICAgIEVYVDRfU0Ioc2IpLT5yc3ZfY29udmVyc2lvbl93cSA9DQotICAg
ICAgICAgICAgICAgYWxsb2Nfd29ya3F1ZXVlKCJleHQ0LXJzdi1jb252ZXJzaW9uIiwgV1FfTUVN
X1JFQ0xBSU0gfCBXUV9VTkJPVU5ELCAxKTsNCisgICAgICAgICAgICAgICBhbGxvY193b3JrcXVl
dWUoImV4dDQtcnN2LWNvbnZlcnNpb24iLCBXUV9NRU1fUkVDTEFJTSB8IA0KKyBXUV9VTkJPVU5E
IHwgX19XUV9PUkRFUkVELCAwKTsNCiAgICAgICAgaWYgKCFFWFQ0X1NCKHNiKS0+cnN2X2NvbnZl
cnNpb25fd3EpIHsNCiAgICAgICAgICAgICAgICBwcmludGsoS0VSTl9FUlIgIkVYVDQtZnM6IGZh
aWxlZCB0byBjcmVhdGUgd29ya3F1ZXVlXG4iKTsNCiAgICAgICAgICAgICAgICByZXQgPSAtRU5P
TUVNOw0KDQpNeSB0aG91Z2h0IGlzOiBJZiB0aGUgbWF4X2FjdGl2ZSBpcyAxLCBpdCBtZWFucyB0
aGUgIl9fV1FfT1JERVJFRCIgY29tYmluZWQgd2l0aCBXUV9VTkJPVU5EIHNldHRpbmcsIGJhc2Vk
IG9uIGFsbG9jX3dvcmtxdWV1ZSgpLiBTbyBJIGFkZGVkIGl0IC4NCkkgYW0gbm90IHN1cmUgc2hv
dWxkIHdlIG5lZWQgIl9fV1FfT1JERVJFRCIgb3Igbm90PyB3aXRob3V0ICJfX1dRX09SREVSRUQi
IGl0IGxvb2tzIGFsc28gd29yayBhdCBteSB0ZXN0YmVkLCBidXQgSSBhZGRlZCBzaW5jZSBub3Qg
bXVjaCBmaW8gVFAgZGlmZmVyZW5jZSBvbiBteSB0ZXN0YmVkIHJlc3VsdCB3aXRoL291dCAiX19X
UV9PUkRFUkVEIi4NCg0KRnJvbSBNeSB1bmRlcnN0YW5kaW5nIGFuZCBvYnNlcnZhdGlvbjogd2l0
aCBkaW9yZWFkX3VubG9jayBhbmQgZGVsYXlfYWxsb2MgYm90aCBlbmFibGVkLCAgdGhlICBiaW9f
ZW5kaW8oKSBhbmQgZXh0NF93cml0ZXBhZ2VzKCkgd2lsbCB0cmlnZ2VyIHRoaXMgd29yayBxdWV1
ZSB0byBleHQ0X2RvX2ZsdXNoX2NvbXBsZXRlZF9JTygpLiBMb29rcyBsaWtlIHRoZSB3b3JrIHF1
ZXVlIGlzIGFuIG9uZS1ieS1vbmUgdXBkYXRpbmc6IGF0IEVYVDQgZXh0ZW5kLmMgaW9fZW5kLT5s
aXN0X3ZlYyAgbGlzdCBvbmx5IGhhdmUgb25lIGlvX2VuZF92ZWMgZWFjaCB0aW1lLiBTbyBpZiB0
aGUgQklPIGhhcyBoaWdoIHBlcmZvcm1hbmNlLCBhbmQgd2UgaGF2ZSBvbmx5IG9uZSB0aHJlYWQg
dG8gZG8gRVhUNCBmbHVzaCB3aWxsIGJlIGFuIGJvdHRsZW5lY2sgaGVyZS4gVGhlICJleHQ0LXJz
di1jb252ZXJzaW9uIiB0aGlzIHdvcmtxdWV1ZSBpcyBtYWlubHkgZm9yIHVwZGF0ZSB0aGUgRVhU
NF9JT19FTkRfVU5XUklUVEVOIGV4dGVuZCBibG9jayhvbmx5IGV4aXN0IG9uIGRpb3JlYWRfdW5s
b2NrIGFuZCBkZWxheV9hbGxvYyBvcHRpb25zIGFyZSBzZXQpIGFuZCBleHRlbmQgc3RhdHVzICBp
ZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IGhlcmUuIEFtICBJIGNvcnJlY3Q/DQoNClRoaXMgd29y
a3Mgb24gbXkgdGVzdCBzeXN0ZW0gYW5kIHBhc3NlcyB4ZnN0ZXN0cywgYnV0ICB3aWxsIHRoaXMg
Y2F1c2UgYW55IGNvcnJ1cHRpb24gb24gZXh0NCBleHRlbmRzIGJsb2NrcyB1cGRhdGVzLCBub3Qg
ZXZlbiBzdXJlIGFib3V0IHRoZSBqb3VybmFsIHRyYW5zYWN0aW9uIHVwZGF0ZXMgZWl0aGVyPw0K
Q2FuIHlvdSB0ZWxsIG1lIHdoYXQgSSB3aWxsIGJyZWFrIGlmIHRoaXMgY2hhbmdlIGlzIG1hZGU/
DQoNClRoYW5rcw0KRGF2aW5hDQoNCg==
