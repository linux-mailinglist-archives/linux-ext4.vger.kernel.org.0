Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41EE96D7E25
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Apr 2023 15:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbjDENzc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Apr 2023 09:55:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbjDENza (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Apr 2023 09:55:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B67E71734
        for <linux-ext4@vger.kernel.org>; Wed,  5 Apr 2023 06:55:24 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-278-9dLbTwq9NiGEBp4om-cqZw-1; Wed, 05 Apr 2023 14:55:21 +0100
X-MC-Unique: 9dLbTwq9NiGEBp4om-cqZw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 5 Apr
 2023 14:55:19 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 5 Apr 2023 14:55:19 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'chi wu' <wuchi.zero@gmail.com>
CC:     Christoph Hellwig <hch@infradead.org>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "ojaswin@linux.ibm.com" <ojaswin@linux.ibm.com>,
        "ritesh.list@gmail.com" <ritesh.list@gmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] ext4: simplify 32bit calculation of lblk
Thread-Topic: [PATCH] ext4: simplify 32bit calculation of lblk
Thread-Index: AQHZZ5teJkhs7xpdHUusWw1uRGHlOq8ckyfAgAAGhICAACKd0A==
Date:   Wed, 5 Apr 2023 13:55:19 +0000
Message-ID: <1ee0b5d2914046f28616c0fc8beba237@AcuMS.aculab.com>
References: <20230403135304.19858-1-wuchi.zero@gmail.com>
 <ZC0J6I1pYNZBB30y@infradead.org>
 <CA+tQmHA_3_Oc-0AQ0a29DTwU4mkEqhOiAE6gXa4Ly4gZGpn5Vw@mail.gmail.com>
 <d04ead6617314074b297c10458010d6b@AcuMS.aculab.com>
 <CA+tQmHAwRNxvH+BBA60BdSoVYxK+NzzNyP6TW2Y_gsaWAhu9iQ@mail.gmail.com>
In-Reply-To: <CA+tQmHAwRNxvH+BBA60BdSoVYxK+NzzNyP6TW2Y_gsaWAhu9iQ@mail.gmail.com>
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

RnJvbTogY2hpIHd1DQo+IFNlbnQ6IDA1IEFwcmlsIDIwMjMgMTM6NDgNCj4gDQo+IERhdmlkIExh
aWdodCA8RGF2aWQuTGFpZ2h0QGFjdWxhYi5jb20+IOS6jjIwMjPlubQ05pyINeaXpeWRqOS4iSAx
OTo0M+WGmemBk++8mg0KPiA+DQo+ID4gRnJvbTogY2hpIHd1DQo+ID4gPiBTZW50OiAwNSBBcHJp
bCAyMDIzIDA5OjQ4DQo+ID4gPg0KPiA+ID4gQ2hyaXN0b3BoIEhlbGx3aWcgPGhjaEBpbmZyYWRl
YWQub3JnPiDkuo4yMDIz5bm0NOaciDXml6XlkajkuIkgMTM6NDDlhpnpgZPvvJoNCj4gPiA+ID4N
Cj4gPiA+ID4gT24gTW9uLCBBcHIgMDMsIDIwMjMgYXQgMDk6NTM6MDRQTSArMDgwMCwgd3VjaGkg
d3JvdGU6DQo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgIGlmIChibG9jayA+IGV4dF9i
bG9jaykNCj4gPiA+ID4gPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXh0
X3BibGsgKyAoYmxvY2sgLSBleHRfYmxvY2spOw0KPiA+ID4gPiA+IC0gICAgICAgICAgICAgICAg
ICAgICBlbHNlDQo+ID4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJu
IGV4dF9wYmxrIC0gKGV4dF9ibG9jayAtIGJsb2NrKTsNCj4gPiA+ID4gPiArICAgICAgICAgICAg
ICAgICAgICAgcmV0dXJuIGV4dF9wYmxrICsgKChzaWduZWQgbG9uZyBsb25nKWJsb2NrIC0gKHNp
Z25lZCBsb25nDQo+IGxvbmcpZXh0X2Jsb2NrKTsNCj4gPiA+ID4NCj4gPiA+ID4gQW5kIHdoYXQg
ZXhhY3RseSBpcyB0aGUgdmFsdWUgYWRkIGhlcmUsIGV4Y2VwdCBmb3IgdHVybmluZyBhbiBlYXN5
DQo+ID4gPiA+IHRvIHBhcnNlIHN0YXRlbWVudCBpbnRvIGEgY29tcGxleCBleHByZXNzaW9uIHVz
aW5nIGNhc3RzPw0KPiA+ID4gPg0KPiA+ID4gWWVz77yMaXQgd2lsbCBiZSBtb3JlIGNvbXBsZXgu
IHRoZSBvcmlnaW5hbCBpbnRlbnRpb24gaXMgdG8gcmVkdWNlIHRoZQ0KPiA+ID4gY29uZGl0aW9u
YWwgYnJhbmNoLg0KPiA+DQo+ID4gV2hhdCBpcyB3cm9uZyB3aXRoIGp1c3Q6DQo+ID4gICAgICAg
ICByZXR1cm4gZXh0X3BibGsgKyBibG9jayAtIGV4dF9ibG9jazsNCj4gPiAoNjRiaXQgKyAzMmJp
dCAtIDMyYml0KQ0KPiA+DQoNCj4gb2gsIEl0J3MgbXkgZmF1bHQuIEkgYW0gdHJhcHBlZCBpbiB0
aGF0IGV4dF9wYmxrICsgYmxvY2sgbWF5IG92ZXJmbG93LA0KPiBidXQgaXQgaXMgb2sgaGVyZS4g
dGhhbmtzLg0KDQpUaGF0IGRvZXNuJ3QgbWF0dGVyLCBpdCB3aWxsICd1bi1vdmVyZmxvdycgd2hl
biBleHRfYmxvY2sgaXMgc3VidHJhY3RlZC4NCllvdSBkbyBuZWVkIHRoZSAnKycgdG8gaGFwcGVu
IGJlZm9yZSB0aGUgJy0nLCBvayBiZWNhdXNlICsvLSBncm91cA0KbGVmdCB0byByaWdodCBpbiBD
Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJv
YWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24g
Tm86IDEzOTczODYgKFdhbGVzKQ0K

