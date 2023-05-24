Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A826870F891
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 16:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231633AbjEXOZS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 May 2023 10:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjEXOZR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 May 2023 10:25:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E4C11D
        for <linux-ext4@vger.kernel.org>; Wed, 24 May 2023 07:25:15 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-81-wc-N6zKoP7yG22TS9cklZg-1; Wed, 24 May 2023 15:25:13 +0100
X-MC-Unique: wc-N6zKoP7yG22TS9cklZg-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 24 May
 2023 15:25:11 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Wed, 24 May 2023 15:25:11 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jan Kara' <jack@suse.cz>, Amir Goldstein <amir73il@gmail.com>
CC:     Ted Tso <tytso@mit.edu>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] ext4: Fix possible corruption when moving a directory
 with RENAME_EXCHANGE
Thread-Topic: [PATCH] ext4: Fix possible corruption when moving a directory
 with RENAME_EXCHANGE
Thread-Index: AQHZjXiOnO+KSeLc6k+5S1Un0bHvlK9n30WAgAGbIlGAAABrgA==
Date:   Wed, 24 May 2023 14:25:11 +0000
Message-ID: <58ea6b856874446c85c6c302016f9a61@AcuMS.aculab.com>
References: <20230523131408.13470-1-jack@suse.cz>
 <48d1f20b2fc1418080c96a1736f6249b@AcuMS.aculab.com>
 <20230524105148.wgjj7ayrbeol6cdx@quack3>
 <CAOQ4uxgizNA9e3rXmktU-pqCzoxg-=n4u_PAHczo1bgquba5Og@mail.gmail.com>
 <20230524141852.gu75mudt4snub4ed@quack3>
In-Reply-To: <20230524141852.gu75mudt4snub4ed@quack3>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

RnJvbTogSmFuIEthcmENCj4gU2VudDogMjQgTWF5IDIwMjMgMTU6MTkNCi4uLi4NCj4gUmlnaHQs
IHNvIHRoaXMgY2FzZSBpbmRlZWQgbG9va3MgcG9zc2libGUgYW5kIEkgZGlkbid0IHRoaW5rIGFi
b3V0IGl0Lg0KPiBUaGFua3MgZm9yIHNwb3R0aW5nIHRoaXMhIExldCBtZSB0cnkgdG8gcGVyc3Vh
ZGUgQWwgYWdhaW4gdG8gZG8gdGhlDQo+IG5lY2Vzc2FyeSBsb2NraW5nIGluIFZGUyBhcyBpdCBp
cyBnZXR0aW5nIHJlYWxseSBoYWlyeSBhbmQgbmVlZHMgVkZTDQo+IGNoYW5nZXMgYW55d2F5Lg0K
DQpJIHRoaW5rIGl0IHdhcyBOZXRCU0QgdGhhdCBzdGFydGVkIHVzaW5nIGEgZ2xvYmFsIGxvY2sg
Zm9yDQpub24tdHJpdmFsIHJlbmFtZXMgYmVjYXVzZSBvdGhlcndpc2UgaXQgaXMgYWxsICdqdXN0
IHRvbyBoYXJkJy4NCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVzcyBMYWtlc2lkZSwg
QnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEgMVBULCBVSw0KUmVn
aXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

