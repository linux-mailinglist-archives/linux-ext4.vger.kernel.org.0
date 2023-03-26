Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425B06C9490
	for <lists+linux-ext4@lfdr.de>; Sun, 26 Mar 2023 15:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231941AbjCZNhn convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Sun, 26 Mar 2023 09:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbjCZNhm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 26 Mar 2023 09:37:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50C849E2
        for <linux-ext4@vger.kernel.org>; Sun, 26 Mar 2023 06:37:41 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-321-t_AconkZO9GXXT1EuNSm8g-1; Sun, 26 Mar 2023 14:37:38 +0100
X-MC-Unique: t_AconkZO9GXXT1EuNSm8g-1
Received: from AcuMS.Aculab.com (10.202.163.6) by AcuMS.aculab.com
 (10.202.163.6) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 26 Mar
 2023 14:37:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 26 Mar 2023 14:37:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Theodore Ts'o <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        Andy Shevchenko <andy@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Subject: RE: [PATCH v2 3/3] kobject: Use return value of strreplace()
Thread-Topic: [PATCH v2 3/3] kobject: Use return value of strreplace()
Thread-Index: AQHZXYQhzqw/OapVckW+rwurhit0ga8NFE/w
Date:   Sun, 26 Mar 2023 13:37:37 +0000
Message-ID: <55ddb6da555a408da801f56577845a09@AcuMS.aculab.com>
References: <20230323123704.37983-1-andriy.shevchenko@linux.intel.com>
 <20230323123704.37983-4-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20230323123704.37983-4-andriy.shevchenko@linux.intel.com>
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

From: Andy Shevchenko
> Sent: 23 March 2023 12:37
>
> Since strreplace() returns the pointer to the string itself,
> we may use it directly in the code.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  lib/kobject.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/lib/kobject.c b/lib/kobject.c
> index f79a434e1231..16d530f9c174 100644
> --- a/lib/kobject.c
> +++ b/lib/kobject.c
> @@ -281,8 +281,7 @@ int kobject_set_name_vargs(struct kobject *kobj, const char *fmt,
>  		kfree_const(s);
>  		if (!t)
>  			return -ENOMEM;
> -		strreplace(t, '/', '!');
> -		s = t;
> +		s = strreplace(t, '/', '!');

Why do this? It just makes the code harder to read because
you have to know another 'silly fact' about a function.

Possibly useful return values might be:
1) The address of the first changed character.
2) The address of the last changed characher.
3) The '\0' terminator.
4) void.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

