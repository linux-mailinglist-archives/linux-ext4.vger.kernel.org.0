Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F37136D7BD0
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 13:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237804AbjDELpS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 07:45:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237936AbjDELpQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 07:45:16 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BAB5527F
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 04:44:48 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-246-6ghQMl58PVCD9K9Rjt0DSg-1; Wed, 05 Apr 2023 12:43:49 +0100
X-MC-Unique: 6ghQMl58PVCD9K9Rjt0DSg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 5 Apr
 2023 12:43:47 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 5 Apr 2023 12:43:47 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'chi wu' <wuchi.zero@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ojaswin@linux.ibm.com" <ojaswin@linux.ibm.com>,
        "ritesh.list@gmail.com" <ritesh.list@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ext4: simplify 32bit calculation of lblk
Thread-Topic: [PATCH] ext4: simplify 32bit calculation of lblk
Thread-Index: AQHZZ5teJkhs7xpdHUusWw1uRGHlOq8ckyfA
Date:   Wed, 5 Apr 2023 11:43:47 +0000
Message-ID: <d04ead6617314074b297c10458010d6b@AcuMS.aculab.com>
References: <20230403135304.19858-1-wuchi.zero@gmail.com>
 <ZC0J6I1pYNZBB30y@infradead.org>
 <CA+tQmHA_3_Oc-0AQ0a29DTwU4mkEqhOiAE6gXa4Ly4gZGpn5Vw@mail.gmail.com>
In-Reply-To: <CA+tQmHA_3_Oc-0AQ0a29DTwU4mkEqhOiAE6gXa4Ly4gZGpn5Vw@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

RnJvbTogY2hpIHd1DQo+IFNlbnQ6IDA1IEFwcmlsIDIwMjMgMDk6NDgNCj4gDQo+IENocmlzdG9w
aCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4g5LqOMjAyM+W5tDTmnIg15pel5ZGo5LiJIDEz
OjQw5YaZ6YGT77yaDQo+ID4NCj4gPiBPbiBNb24sIEFwciAwMywgMjAyMyBhdCAwOTo1MzowNFBN
ICswODAwLCB3dWNoaSB3cm90ZToNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICBpZiAoYmxv
Y2sgPiBleHRfYmxvY2spDQo+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1
cm4gZXh0X3BibGsgKyAoYmxvY2sgLSBleHRfYmxvY2spOw0KPiA+ID4gLSAgICAgICAgICAgICAg
ICAgICAgIGVsc2UNCj4gPiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBl
eHRfcGJsayAtIChleHRfYmxvY2sgLSBibG9jayk7DQo+ID4gPiArICAgICAgICAgICAgICAgICAg
ICAgcmV0dXJuIGV4dF9wYmxrICsgKChzaWduZWQgbG9uZyBsb25nKWJsb2NrIC0gKHNpZ25lZCBs
b25nIGxvbmcpZXh0X2Jsb2NrKTsNCj4gPg0KPiA+IEFuZCB3aGF0IGV4YWN0bHkgaXMgdGhlIHZh
bHVlIGFkZCBoZXJlLCBleGNlcHQgZm9yIHR1cm5pbmcgYW4gZWFzeQ0KPiA+IHRvIHBhcnNlIHN0
YXRlbWVudCBpbnRvIGEgY29tcGxleCBleHByZXNzaW9uIHVzaW5nIGNhc3RzPw0KPiA+DQo+IFll
c++8jGl0IHdpbGwgYmUgbW9yZSBjb21wbGV4LiB0aGUgb3JpZ2luYWwgaW50ZW50aW9uIGlzIHRv
IHJlZHVjZSB0aGUNCj4gY29uZGl0aW9uYWwgYnJhbmNoLg0KDQpXaGF0IGlzIHdyb25nIHdpdGgg
anVzdDoNCglyZXR1cm4gZXh0X3BibGsgKyBibG9jayAtIGV4dF9ibG9jazsNCig2NGJpdCArIDMy
Yml0IC0gMzJiaXQpDQoNCglEYXZpZA0KDQotDQpSZWdpc3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUs
IEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9uIEtleW5lcywgTUsxIDFQVCwgVUsNClJl
Z2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

