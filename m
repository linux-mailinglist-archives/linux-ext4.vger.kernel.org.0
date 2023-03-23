Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3676B6C7307
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Mar 2023 23:23:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbjCWWXZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 23 Mar 2023 18:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjCWWXR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Mar 2023 18:23:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 398791C31C
        for <linux-ext4@vger.kernel.org>; Thu, 23 Mar 2023 15:23:16 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-318-GssVaGDXNU-4V6G9zXH1MQ-1; Thu, 23 Mar 2023 22:23:13 +0000
X-MC-Unique: GssVaGDXNU-4V6G9zXH1MQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 23 Mar
 2023 22:23:11 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Thu, 23 Mar 2023 22:23:11 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v1 2/3] lib/string_helpers: Change returned value of the
 strreplace()
Thread-Topic: [PATCH v1 2/3] lib/string_helpers: Change returned value of the
 strreplace()
Thread-Index: AQHZXN6Z4nf0cPig9kGqruJ2q+Vnpa8I8J1A
Date:   Thu, 23 Mar 2023 22:23:11 +0000
Message-ID: <989d091b100a4dfcbce0dce81b48e672@AcuMS.aculab.com>
References: <20230322141206.56347-1-andriy.shevchenko@linux.intel.com>
 <20230322141206.56347-3-andriy.shevchenko@linux.intel.com>
 <641b320b.a70a0220.2bb1d.30fc@mx.google.com>
In-Reply-To: <641b320b.a70a0220.2bb1d.30fc@mx.google.com>
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
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=0.0 required=5.0 tests=PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Kees Cook
> Sent: 22 March 2023 16:51
> 
> On Wed, Mar 22, 2023 at 04:12:05PM +0200, Andy Shevchenko wrote:
> > It's more useful to return the original string with strreplace(),

Won't that break anything that is using the result?

> I found the use of "original" confusing here and in the comments. This
> just returns arg 1, yes? i.e. it's not the original (unreplaced) string,
> but rather just the string itself.
> 
> I agree, though, that's much more useful than a pointer to the end of
> the string.

If you want a pointer to the start of the string, you've
already got it.
Almost all the time you can do the assignment first.

But if you want a pointer to the end you'll need to scan it again.

I have a feeling that the reason many of the string functions
return the original pointer is a historic side effect of
the original implementation.
Going back to before C had a 'return' statement.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

