Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9A55758EF
	for <lists+linux-ext4@lfdr.de>; Fri, 15 Jul 2022 03:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240166AbiGOBAH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 21:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230407AbiGOBAF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 21:00:05 -0400
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 697AC558D2
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 18:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1657846805; x=1689382805;
  h=from:to:cc:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version:subject;
  bh=ENBTGJGkfRWNc1P1XVs2EHAYsLDVLh6FuE6ptvTf9Sk=;
  b=X4IzUglOnuZmcNzUiHBKYea97d3NbMMcTS1mMnqHBhzkxADdPpPI6V5/
   z5A3LEGgQJpJeAcZqG2hKhBt/xNYn5wbXja38WS0ZiUrPaNnjUjTymCAH
   uDMSat1b+//T3mvvKlo5G8O+xXQTSFrsbXBpUyyrWIr+e+VwUYo60ZlO3
   c=;
X-IronPort-AV: E=Sophos;i="5.92,272,1650931200"; 
   d="scan'208";a="238561806"
Subject: Re: [PATCH 2/2] ext4: avoid resizing to a partial cluster size
Thread-Topic: [PATCH 2/2] ext4: avoid resizing to a partial cluster size
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO email-inbound-relay-pdx-2b-02ee77e7.us-west-2.amazon.com) ([10.25.36.210])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP; 15 Jul 2022 01:00:04 +0000
Received: from EX13MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2b-02ee77e7.us-west-2.amazon.com (Postfix) with ESMTPS id 1373343BD5;
        Fri, 15 Jul 2022 01:00:02 +0000 (UTC)
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13MTAUWB001.ant.amazon.com (10.43.161.207) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Fri, 15 Jul 2022 01:00:01 +0000
Received: from EX13D23UWA003.ant.amazon.com (10.43.160.194) by
 EX13D23UWA003.ant.amazon.com (10.43.160.194) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Fri, 15 Jul 2022 01:00:01 +0000
Received: from EX13D23UWA003.ant.amazon.com ([10.43.160.194]) by
 EX13D23UWA003.ant.amazon.com ([10.43.160.194]) with mapi id 15.00.1497.036;
 Fri, 15 Jul 2022 01:00:01 +0000
From:   "Kiselev, Oleg" <okiselev@amazon.com>
To:     Jan Kara <jack@suse.cz>
CC:     "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>
Thread-Index: AQHYjCeHznXf09jkSEaK4G9Qmq42iq19+Z2AgAC6fgA=
Date:   Fri, 15 Jul 2022 01:00:01 +0000
Message-ID: <0CC0FCE1-F8A2-4966-B848-AD2D9DF9A713@amazon.com>
References: <9CDF7393-5645-4E8A-9D68-01CF7F4C4955@amazon.com>
 <20220714135231.aull3vo44yfa6azg@quack3>
In-Reply-To: <20220714135231.aull3vo44yfa6azg@quack3>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.232]
Content-Type: text/plain; charset="utf-8"
Content-ID: <DE25A683D5ECD74FBA7A2062183DDA2B@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-Spam-Status: No, score=-15.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

VGhhbmtzIGZvciB0aGUgcmV2aWV3LCBKYW4NCg0KPiBPbiBKdWwgMTQsIDIwMjIsIGF0IDY6NTIg
QU0sIEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+IHdyb3RlOg0KPiANCj4gQ0FVVElPTjogVGhpcyBl
bWFpbCBvcmlnaW5hdGVkIGZyb20gb3V0c2lkZSBvZiB0aGUgb3JnYW5pemF0aW9uLiBEbyBub3Qg
Y2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGNhbiBjb25maXJtIHRo
ZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNvbnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiANCj4gT24g
VGh1IDMwLTA2LTIyIDAyOjE3OjIyLCBLaXNlbGV2LCBPbGVnIHdyb3RlOg0KPj4gVGhpcyBwYXRj
aCBhdm9pZHMgYW4gYXR0ZW1wdCB0byByZXNpemUgdGhlIGZpbGVzeXN0ZW0gdG8gYW4NCj4+IHVu
YWxpZ25lZCBjbHVzdGVyIGJvdW5kYXJ5LiAgQW4gb25saW5lIHJlc2l6ZSB0byBhIHNpemUgdGhh
dCBpcyBub3QNCj4+IGludGVncmFsIHRvIGNsdXN0ZXIgc2l6ZSByZXN1bHRzIGluIHRoZSBsYXN0
IGl0ZXJhdGlvbiBhdHRlbXB0aW5nIHRvDQo+PiBncm93IHRoZSBmcyBieSBhIG5lZ2F0aXZlIGFt
b3VudCwgd2hpY2ggdHJpcHMgYSBCVUdfT04gYW5kIGxlYXZlcyB0aGUgZnMNCj4+IHdpdGggYSBj
b3JydXB0ZWQgaW4tbWVtb3J5IHN1cGVyYmxvY2suDQo+PiANCj4+IFNpZ25lZC1vZmYtYnk6IE9s
ZWcgS2lzZWxldiA8b2tpc2VsZXZAYW1hem9uLmNvbT4NCj4+IC0tLQ0KPiAuLi4NCj4gDQo+PiBA
QCAtMTYyNCw3ICsxNjI0LDggQEAgc3RhdGljIGludCBleHQ0X3NldHVwX25leHRfZmxleF9nZChz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KPj4gDQo+PiAgICAgIG9fYmxvY2tzX2NvdW50ID0gZXh0
NF9ibG9ja3NfY291bnQoZXMpOw0KPj4gDQo+PiAtICAgICBpZiAob19ibG9ja3NfY291bnQgPT0g
bl9ibG9ja3NfY291bnQpDQo+PiArICAgICBpZiAoKG9fYmxvY2tzX2NvdW50ID09IG5fYmxvY2tz
X2NvdW50KSB8fA0KPj4gKyAgICAgICAgICgobl9ibG9ja3NfY291bnQgLSBvX2Jsb2Nrc19jb3Vu
dCkgPCBzYmktPnNfY2x1c3Rlcl9yYXRpbykpDQo+PiAgICAgICAgICAgICAgcmV0dXJuIDA7DQo+
IA0KPiBTbyB3aHkgZG8geW91IHNpbGVudGx5IGRvIG5vdGhpbmcgd2l0aCB1bmFsaWduZWQgc2l6
ZT8gSSdkIGV4cGVjdCB3ZSBzaG91bGQNCj4gY2F0Y2ggdGhpcyBjb25kaXRpb24gYWxyZWFkeSBp
biBleHQ0X3Jlc2l6ZV9mcygpIGFuZCByZXR1cm4gRUlOVkFMIGluIHRoYXQNCj4gY2FzZS4uLg0K
DQpGYWlsaW5nIGEgcmVzaXplIHdpdGggYW4gZXJyb3Igd2lsbCBiZSBhbiB1bmV4cGVjdGVkIGJl
aGF2aW9yIHRoYXQgd2lsbCBicmVhayBzb2Z0d2FyZSB0aGF0IGNhbGxzIHJlc2l6ZTJmcyB3aXRo
b3V0IHNwZWNpZnlpbmcgdGhlIHNpemUuICBXZSByYW4gaW50byB0aGlzIGlzc3VlIGJlY2F1c2Ug
d2UgbWFrZSBvdXIgZmlsZXN5c3RlbXMgb24gdG9wIG9mIERSQkQgZGV2aWNlcywgYW5kIERSQkQg
YWxpZ25zIGl0cyBtZXRhZGF0YSBvbiA0SyBib3VuZGFyaWVzLiAgVGhpcyByZXN1bHRzIGluIHNw
YWNlIGF2YWlsYWJsZSBmb3IgdGhlIGZpbGVzeXN0ZW0gaGF2aW5nIGFuIOKAnG9kZOKAnSBzaXpl
LiAgT3VyIHByZWZlcmVuY2UgaXMgZm9yIHRoZSB1dGlsaXRpZXMgdG8gc2lsZW50bHkgZml4IHRo
ZSBmcyBzaXplIGRvd24gdG8gdGhlIG5lYXJlc3Qg4oCcc2FmZeKAnSBzaXplIHJhdGhlciB0aGFu
IGdldCBzcG9yYWRpYyBlcnJvcnMuICAgSSBoYWQgc3VibWl0dGVkIGEgcGF0Y2ggZm9yIHJlc2l6
ZTJmcyB0aGF0IHJvdW5kcyB0aGUgZnMgdGFyZ2V0IHNpemUgZG93biB0byB0aGUgbmVhcmVzdCBj
bHVzdGVyIGJvdW5kYXJ5LiAgSW4gcHJpbmNpcGxlIGl04oCZcyBzaW1pbGFyIHRvIHRoZSBzaXpl
LXJvdW5kaW5nIHRoYXQgaXMgZG9uZSBub3cgZm9yIDRLIGJsb2Nrcy4gICBVc2luZyB1cGRhdGVk
IGUyZnNwcm9ncyBpc27igJl0IG1hbmRhdG9yeSBmb3IgdXNpbmcgZXh0NCBpbiB0aGUgbmV3ZXIg
a2VybmVscywgc28gbWFraW5nIHRoZSBrZXJuZWwgc2FmZShyKSBmb3IgYmlnYWxsb2MgcmVzaXpl
cyBzZWVtcyBsaWtlIGEgZ29vZCBpZGVhLg0KDQo+IEFsc28gdGhpcyBjb2RlIGRvZXMgc29tZXRo
aW5nIGVsc2UgdGhhbiB3aGF0IHRoZSBjb21taXQgbG9nIHNheXMuIFlvdQ0KPiBhY3R1YWxseSBj
aGVjayB3aGV0aGVyIHRoZXJlIGFyZSBsZXNzIHRoYW4gb25lIGNsdXN0ZXIgd29ydGggb2YgYmxv
Y2tzDQo+IGluc3RlYWQgb2YgY2hlY2tpbmcgd2hldGhlciBuX2Jsb2Nrc19jb3VudCBpcyBwcm9w
ZXJseSBhbGlnbmVkLiBXaHkgaXMgdGhhdA0KPiBlbm91Z2g/DQoNClRoYXTigJlzIGEgZ29vZCBw
b2ludC4gIEkgcHV0IGEgZml4IGFzIGNsb3NlIHRvIHRoZSBwbGFjZSBpbiB0aGUgY29kZSB3aGVy
ZSB0aGlzIG1pc2FsaWdubWVudCBjYXVzZXMgYSBwcm9ibGVtLCBidXQgaXQgd291bGQgYmUgYmV0
dGVyIHRvIHB1dCBhIHNpemUgYWxpZ25tZW50IGNoZWNrIGluIGV4dDRfcmVzaXplX2ZzKCkgYW5k
IHRyaW0gdGhlIHJlcXVlc3QgdGhlcmUsIGluc3RlYWQuICBJIHdpbGwgbWFrZSB0aGF0IGNoYW5n
ZSBhbmQgcmVzdWJtaXQgdGhlIHBhdGNoLg0KDQo+IA0KPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBIb256YQ0KPiAtLQ0KPiBK
YW4gS2FyYSA8amFja0BzdXNlLmNvbT4NCj4gU1VTRSBMYWJzLCBDUg0KDQo=
