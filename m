Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DE9D6B7274
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 10:25:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjCMJZc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Mon, 13 Mar 2023 05:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjCMJZ2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 05:25:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AF1926840
        for <linux-ext4@vger.kernel.org>; Mon, 13 Mar 2023 02:25:26 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-28-h8tNDMM5MS-91DoXe4fcQg-1; Mon, 13 Mar 2023 09:25:24 +0000
X-MC-Unique: h8tNDMM5MS-91DoXe4fcQg-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.47; Mon, 13 Mar
 2023 09:25:21 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.047; Mon, 13 Mar 2023 09:25:20 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Theodore Ts'o' <tytso@mit.edu>, Yangtao Li <frank.li@vivo.com>
CC:     "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>
Subject: RE: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Thread-Topic: [PATCH] ext4: convert to DIV_ROUND_UP() in
 mpage_process_page_bufs()
Thread-Index: AQHZU6cIVd7TlGe9BUuq0KVFS4jPEK74cpWQ
Date:   Mon, 13 Mar 2023 09:25:20 +0000
Message-ID: <6135e1e118724e5ea3a1f7640b705cb5@AcuMS.aculab.com>
References: <20230310060734.8780-1-frank.li@vivo.com>
 <20230310232107.GE860405@mit.edu>
In-Reply-To: <20230310232107.GE860405@mit.edu>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

...
> On 32-bit platforms --- i386 in particular --- the 64-bit division
> results in an out-of-line call to a helper function that is not
> supplied in the kernel compilation environment, so not only is it
> slower, it Just Doesn't Work.

Even on some 64-bit systems a 64bit divide can be significantly
slower than a 32-bit divide - even with the same arguments.
IIRC Intel x86-64 a 64-bit divide (128-bit dividend) is about
twice the clocks of a 32-bit one. On AMD cpu they are much the same.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

