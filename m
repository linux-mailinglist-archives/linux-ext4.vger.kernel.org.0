Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029F35E91DF
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Sep 2022 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiIYJ0y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 25 Sep 2022 05:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiIYJ0x (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 25 Sep 2022 05:26:53 -0400
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB022CDD3;
        Sun, 25 Sep 2022 02:26:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1664098013; x=1695634013;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=C1WNuK8i9+rScudM5R/eMlSRwLCORy8FMQKS6qcwcyI=;
  b=gWFP5YnxsbbN04U1cm5jIjJZnYMBQWMIAxEcSbAm3zC5WK0X91cJH9hX
   LWVc7IC9f8EtlZ+aBnUbniaf9SPW8eGXHRGGK0YfIvMpUcLpZkPZazdC1
   27zFwaccRygABzzzEJuifJg2aDJgX0/GyxjW5iyUGh9G1kbno4nMY9sto
   M=;
X-IronPort-AV: E=Sophos;i="5.93,344,1654560000"; 
   d="scan'208";a="228403461"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-d9fba5dd.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2022 09:26:37 +0000
Received: from EX13MTAUWC002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2c-d9fba5dd.us-west-2.amazon.com (Postfix) with ESMTPS id F06FB45859;
        Sun, 25 Sep 2022 09:26:35 +0000 (UTC)
Received: from EX13D23UWC004.ant.amazon.com (10.43.162.219) by
 EX13MTAUWC002.ant.amazon.com (10.43.162.240) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Sun, 25 Sep 2022 09:26:35 +0000
Received: from EX19D018EUA004.ant.amazon.com (10.252.50.85) by
 EX13D23UWC004.ant.amazon.com (10.43.162.219) with Microsoft SMTP Server (TLS)
 id 15.0.1497.38; Sun, 25 Sep 2022 09:26:34 +0000
Received: from EX19D018EUA004.ant.amazon.com ([fe80::fd00:35b8:2b90:a79e]) by
 EX19D018EUA004.ant.amazon.com ([fe80::fd00:35b8:2b90:a79e%3]) with mapi id
 15.02.1118.012; Sun, 25 Sep 2022 09:26:33 +0000
From:   "Mohamed Abuelfotoh, Hazem" <abuehaze@amazon.com>
To:     "Lu, Davina" <davinalu@amazon.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
CC:     "Kiselev, Oleg" <okiselev@amazon.com>,
        "Liu, Frank" <franklmz@amazon.com>
Subject: Re: significant drop  fio IOPS performance on v5.10
Thread-Topic: significant drop  fio IOPS performance on v5.10
Thread-Index: AdjO5vTzPItE0he4TsCHXHwBRGK6iAB1NzvQAANdpYA=
Date:   Sun, 25 Sep 2022 09:26:33 +0000
Message-ID: <89273C3B-010F-46A4-B5CD-86EBAF91C188@amazon.com>
References: <357ace228adf4e859df5e9f3f4f18b49@amazon.com>
 <1cdc68e6a98d4e93a95be5d887bcc75d@amazon.com>
In-Reply-To: <1cdc68e6a98d4e93a95be5d887bcc75d@amazon.com>
Accept-Language: en-GB, en-US
Content-Language: en-GB
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.43.166.209]
Content-Type: text/plain; charset="utf-8"
Content-ID: <736D7C937B1CA04AA28FBDCD143B3B9A@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-12.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

VGhpcyBpcyBjb250aW51YXRpb24gZm9yIHRoZSBkaXNjdXNzaW9uIEkgcmFpc2VkIGluIGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2FsbC9DQUNYNnZvRGhHeGl5QXhhRXUwT0wraEhGREQ5a2lnc28t
WVZyV1RrNGpjYnZZWktWZXdAbWFpbC5nbWFpbC5jb20vdC8gc28gSSBhbSBhZGRpbmcgVGhlbyB0
byB0aGUgdGhyZWFkLg0KDQpIYXplbQ0KDQrvu79PbiAyNS8wOS8yMDIyLCAwOTo1MSwgIkx1LCBE
YXZpbmEiIDxkYXZpbmFsdUBhbWF6b24uY29tPiB3cm90ZToNCg0KICAgICsgYWJ1ZWhhemVAYW1h
em9uLmNvbQ0KDQogICAgLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCiAgICBGcm9tOiBMdSwg
RGF2aW5hIA0KICAgIFNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDIzLCAyMDIyIDEwOjU1IEFNDQog
ICAgVG86IGxpbnV4LWV4dDRAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnDQogICAgQ2M6IEtpc2VsZXYsIE9sZWcgPG9raXNlbGV2QGFtYXpvbi5jb20+OyBMaXUs
IEZyYW5rIDxmcmFua2xtekBhbWF6b24uY29tPg0KICAgIFN1YmplY3Q6IHNpZ25pZmljYW50IGRy
b3AgZmlvIElPUFMgcGVyZm9ybWFuY2Ugb24gdjUuMTANCg0KICAgIEhlbGxvLA0KDQogICAgSSB3
YXMgcHJvZmlsaW5nIHRoZSA1LjEwIGtlcm5lbCBhbmQgY29tcGFyaW5nIGl0IHRvIDQuMTQuICBP
biBhIHN5c3RlbSB3aXRoIDY0IHZpcnR1YWwgQ1BVcyBhbmQgMjU2IEdpQiBvZiBSQU0sIEkgYW0g
b2JzZXJ2aW5nIGEgc2lnbmlmaWNhbnQgZHJvcCBpbiBJTyBwZXJmb3JtYW5jZS4gVXNpbmcgdGhl
IGZvbGxvd2luZyBGSU8gd2l0aCB0aGUgc2NyaXB0ICJzdWRvIGZ0ZXN0X3dyaXRlLnNoIDxkZXZf
bmFtZT4iIGluIGF0dGFjaG1lbnQsIEkgc2F3IEZJTyBpb3BzIHJlc3VsdCBkcm9wIGZyb20gMjJL
IHRvIGxlc3MgdGhhbiAxSy4gDQogICAgVGhlIHNjcmlwdCBzaW1wbHkgZG9lczogbW91bnQgYSB0
aGUgRVhUNCAxNkdpQiB2b2x1bWUgd2l0aCBtYXggSU9QUyA2NDAwMEssIG1vdW50aW5nIG9wdGlv
biBpcyAiIC1vIG5vYXRpbWUsbm9kaXJhdGltZSxkYXRhPW9yZGVyZWQiLCB0aGVuIHJ1biBmaW8g
d2l0aCAyMDQ4IGZpbyB3cmluZyB0aHJlYWQgd2l0aCAyODgwMDAwMCBmaWxlIHNpemUgd2l0aCB7
IC0tbmFtZT0xNmtiX3JhbmRfd3JpdGVfb25seV8yMDQ4X2pvYnMgLS1kaXJlY3Rvcnk9L3Jkc2Ri
ZGF0YTEgLS1ydz1yYW5kd3JpdGUgLS1pb2VuZ2luZT1zeW5jIC0tYnVmZmVyZWQ9MSAtLWJzPTE2
ayAtLW1heC1qb2JzPTIwNDggLS1udW1qb2JzPTIwNDggLS1ydW50aW1lPTYwIC0tdGltZV9iYXNl
ZCAtLXRocmVhZCAtLWZpbGVzaXplPTI4ODAwMDAwIC0tZnN5bmM9MSAtLWdyb3VwX3JlcG9ydGlu
ZyB9Lg0KDQogICAgTXkgYW5hbHl6aW5nIGlzIHRoYXQgdGhlIGRlZ3JhZGF0aW9uIGlzIGludHJv
ZHVjZSBieSBjb21taXQgezI0NGFkZjY0MjZlZTMxYTgzZjM5N2I3MDBkOTY0Y2ZmMTJhMjQ3ZDN9
IGFuZCB0aGUgaXNzdWUgaXMgdGhlIGNvbnRlbnRpb24gb24gcnN2X2NvbnZlcnNpb25fd3EuICBU
aGUgc2ltcGxlc3Qgb3B0aW9uIGlzIHRvIGluY3JlYXNlIHRoZSBqb3VybmFsIHNpemUsIGJ1dCB0
aGF0IGludHJvZHVjZXMgbW9yZSBvcGVyYXRpb25hbCBjb21wbGV4aXR5LiAgQW5vdGhlciBvcHRp
b24gaXMgdG8gYWRkIHRoZSBmb2xsb3dpbmcgY2hhbmdlIGluIGF0dGFjaG1lbnQgImFsbG93IG1v
cmUgZXh0NC1yc3YtY29udmVyc2lvbiB3b3JrcXVldWUucGF0Y2giDQoNCiAgICBGcm9tIDI3ZTFi
MGUxNDI3NWEyODFiMzUyOWY2YTYwYzdiMjNhODEzNTY3NTEgTW9uIFNlcCAxNyAwMDowMDowMCAy
MDAxDQogICAgRnJvbTogZGF2aW5hbHUgPGRhdmluYWx1QGFtYXpvbi5jb20+DQogICAgRGF0ZTog
RnJpLCAyMyBTZXAgMjAyMiAwMDo0Mzo1MyArMDAwMA0KICAgIFN1YmplY3Q6IFtQQVRDSF0gYWxs
b3cgbW9yZSBleHQ0LXJzdi1jb252ZXJzaW9uIHdvcmtxdWV1ZSB0byBzcGVlZHVwIGZpbyAgd3Jp
dGluZw0KICAgIC0tLQ0KICAgICBmcy9leHQ0L3N1cGVyLmMgfCAyICstDQogICAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KDQogICAgZGlmZiAtLWdpdCBh
L2ZzL2V4dDQvc3VwZXIuYyBiL2ZzL2V4dDQvc3VwZXIuYyBpbmRleCBhMGFmODMzZjdkYTcuLjZi
MzQyOThjZGMzYiAxMDA2NDQNCiAgICAtLS0gYS9mcy9leHQ0L3N1cGVyLmMNCiAgICArKysgYi9m
cy9leHQ0L3N1cGVyLmMNCiAgICBAQCAtNDk2Myw3ICs0OTYzLDcgQEAgc3RhdGljIGludCBleHQ0
X2ZpbGxfc3VwZXIoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdm9pZCAqZGF0YSwgaW50IHNpbGVu
dCkNCiAgICAgICAgICAgICAqIGNvbmN1cnJlbmN5IGlzbid0IHJlYWxseSBuZWNlc3NhcnkuICBM
aW1pdCBpdCB0byAxLg0KICAgICAgICAgICAgICovDQogICAgICAgICAgICBFWFQ0X1NCKHNiKS0+
cnN2X2NvbnZlcnNpb25fd3EgPQ0KICAgIC0gICAgICAgICAgICAgICBhbGxvY193b3JrcXVldWUo
ImV4dDQtcnN2LWNvbnZlcnNpb24iLCBXUV9NRU1fUkVDTEFJTSB8IFdRX1VOQk9VTkQsIDEpOw0K
ICAgICsgICAgICAgICAgICAgICBhbGxvY193b3JrcXVldWUoImV4dDQtcnN2LWNvbnZlcnNpb24i
LCBXUV9NRU1fUkVDTEFJTSB8IA0KICAgICsgV1FfVU5CT1VORCB8IF9fV1FfT1JERVJFRCwgMCk7
DQogICAgICAgICAgICBpZiAoIUVYVDRfU0Ioc2IpLT5yc3ZfY29udmVyc2lvbl93cSkgew0KICAg
ICAgICAgICAgICAgICAgICBwcmludGsoS0VSTl9FUlIgIkVYVDQtZnM6IGZhaWxlZCB0byBjcmVh
dGUgd29ya3F1ZXVlXG4iKTsNCiAgICAgICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsNCg0K
ICAgIE15IHRob3VnaHQgaXM6IElmIHRoZSBtYXhfYWN0aXZlIGlzIDEsIGl0IG1lYW5zIHRoZSAi
X19XUV9PUkRFUkVEIiBjb21iaW5lZCB3aXRoIFdRX1VOQk9VTkQgc2V0dGluZywgYmFzZWQgb24g
YWxsb2Nfd29ya3F1ZXVlKCkuIFNvIEkgYWRkZWQgaXQgLg0KICAgIEkgYW0gbm90IHN1cmUgc2hv
dWxkIHdlIG5lZWQgIl9fV1FfT1JERVJFRCIgb3Igbm90PyB3aXRob3V0ICJfX1dRX09SREVSRUQi
IGl0IGxvb2tzIGFsc28gd29yayBhdCBteSB0ZXN0YmVkLCBidXQgSSBhZGRlZCBzaW5jZSBub3Qg
bXVjaCBmaW8gVFAgZGlmZmVyZW5jZSBvbiBteSB0ZXN0YmVkIHJlc3VsdCB3aXRoL291dCAiX19X
UV9PUkRFUkVEIi4NCg0KICAgIEZyb20gTXkgdW5kZXJzdGFuZGluZyBhbmQgb2JzZXJ2YXRpb246
IHdpdGggZGlvcmVhZF91bmxvY2sgYW5kIGRlbGF5X2FsbG9jIGJvdGggZW5hYmxlZCwgIHRoZSAg
YmlvX2VuZGlvKCkgYW5kIGV4dDRfd3JpdGVwYWdlcygpIHdpbGwgdHJpZ2dlciB0aGlzIHdvcmsg
cXVldWUgdG8gZXh0NF9kb19mbHVzaF9jb21wbGV0ZWRfSU8oKS4gTG9va3MgbGlrZSB0aGUgd29y
ayBxdWV1ZSBpcyBhbiBvbmUtYnktb25lIHVwZGF0aW5nOiBhdCBFWFQ0IGV4dGVuZC5jIGlvX2Vu
ZC0+bGlzdF92ZWMgIGxpc3Qgb25seSBoYXZlIG9uZSBpb19lbmRfdmVjIGVhY2ggdGltZS4gU28g
aWYgdGhlIEJJTyBoYXMgaGlnaCBwZXJmb3JtYW5jZSwgYW5kIHdlIGhhdmUgb25seSBvbmUgdGhy
ZWFkIHRvIGRvIEVYVDQgZmx1c2ggd2lsbCBiZSBhbiBib3R0bGVuZWNrIGhlcmUuIFRoZSAiZXh0
NC1yc3YtY29udmVyc2lvbiIgdGhpcyB3b3JrcXVldWUgaXMgbWFpbmx5IGZvciB1cGRhdGUgdGhl
IEVYVDRfSU9fRU5EX1VOV1JJVFRFTiBleHRlbmQgYmxvY2sob25seSBleGlzdCBvbiBkaW9yZWFk
X3VubG9jayBhbmQgZGVsYXlfYWxsb2Mgb3B0aW9ucyBhcmUgc2V0KSBhbmQgZXh0ZW5kIHN0YXR1
cyAgaWYgSSB1bmRlcnN0YW5kIGNvcnJlY3RseSBoZXJlLiBBbSAgSSBjb3JyZWN0Pw0KDQogICAg
VGhpcyB3b3JrcyBvbiBteSB0ZXN0IHN5c3RlbSBhbmQgcGFzc2VzIHhmc3Rlc3RzLCBidXQgIHdp
bGwgdGhpcyBjYXVzZSBhbnkgY29ycnVwdGlvbiBvbiBleHQ0IGV4dGVuZHMgYmxvY2tzIHVwZGF0
ZXMsIG5vdCBldmVuIHN1cmUgYWJvdXQgdGhlIGpvdXJuYWwgdHJhbnNhY3Rpb24gdXBkYXRlcyBl
aXRoZXI/DQogICAgQ2FuIHlvdSB0ZWxsIG1lIHdoYXQgSSB3aWxsIGJyZWFrIGlmIHRoaXMgY2hh
bmdlIGlzIG1hZGU/DQoNCiAgICBUaGFua3MNCiAgICBEYXZpbmENCg0KDQo=
