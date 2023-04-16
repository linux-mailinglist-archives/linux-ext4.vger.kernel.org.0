Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7AE6E353C
	for <lists+linux-ext4@lfdr.de>; Sun, 16 Apr 2023 07:51:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229472AbjDPFrs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 Apr 2023 01:47:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229593AbjDPFrr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 16 Apr 2023 01:47:47 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A922D79
        for <linux-ext4@vger.kernel.org>; Sat, 15 Apr 2023 22:47:46 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id B7B1A67373; Sun, 16 Apr 2023 07:47:42 +0200 (CEST)
Date:   Sun, 16 Apr 2023 07:47:42 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     William McVicker <willmcvicker@google.com>
Cc:     Theodore Ts'o <tytso@mit.edu>, hch@lst.de,
        linux-ext4@vger.kernel.org,
        "Stephen E. Baker" <baker.stephen.e@gmail.com>,
        adilger.kernel@dilger.ca
Subject: Re: simplify ext4_sb_read_encoding regression
Message-ID: <20230416054742.GA5427@lst.de>
References: <YpLLTkje/QUYPP9z@mit.edu> <YpNk4bQlRKmgDw8E@mit.edu> <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com> <YpQixl+ljcC1VHNU@mit.edu> <CAFDdnB1WxrqddeLJwjsqqgoij1q_QGa=SBs-i=j31W2QbksJ=Q@mail.gmail.com> <YpVeeKRH1bycP7P1@mit.edu> <YpVxYchs1wScNRDw@mit.edu> <CAFDdnB1KJVSXXzXKOc+T+g1Qewr11AS4f9tFJqSMLvfpiX-5Lg@mail.gmail.com> <YpjNf8WGfYh31F+2@mit.edu> <ZDnbW1qYmBLycefL@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZDnbW1qYmBLycefL@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Apr 14, 2023 at 04:01:47PM -0700, William McVicker wrote:
> I believe I figured out what is going on here since I am hitting a similar
> issue with CONFIG_UNICODE. If you take a look at the .config from Stephen's
> message, you'll see that he sets:
> 
>   CONFIG_TRIM_UNUSED_KSYMS=y
>   CONFIG_UNUSED_KSYMS_WHITELIST=""
> 
> When trimming is enabled, kbuild will strip all exported symbols that are not
> listed in the whitelist. As a result, when utf8-core.c calls:
> 
>   um->tables = symbol_request(utf8_data_table);
> 
> it will fail since `utf8_data_table` doesn't exist in the exported section of
> the kernel symbol table. For me on Android, this leads to the userdata
> partition failing to mount. To be clear, this happens when CONFIG_UNICODE=y.
> 
> One question I have is -- Why are we using symbol_request()/symbol_put() when
> `utf8_data_table` is exported? Why can't we directly reference the
> `utf8_data_table` symbol?

We could, but that would require to always include the huge utf8
case folding tables into the kernel.

The idea here is that there is no sane way to move the utf8 handling code
into a module that only gets used some times, because common file systems
like ext4 call into it.  But they only actually use the case folding for
the very rare case of someone actually using the case insensitive file
system feature, so we only load the module containing the table for that
case.

> If we need to use symbol_request() when CONFIG_UNICODE=m, then can we apply the
> below patch to fix this when CONFIG_UNICODE=y? I have verified this works for
> me with CONFIG_UNICODE=y and CONFIG_TRIM_UNUSED_KSYMS=y.

We could do that, but it seems a bit ugly.  What prevents symbol_request
from working properly for this case in your setup?
