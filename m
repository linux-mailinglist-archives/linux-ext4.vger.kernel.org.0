Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A90CE537366
	for <lists+linux-ext4@lfdr.de>; Mon, 30 May 2022 03:50:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiE3BuL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 29 May 2022 21:50:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232197AbiE3BuK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 29 May 2022 21:50:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1758C15A32
        for <linux-ext4@vger.kernel.org>; Sun, 29 May 2022 18:50:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24U1nxUt018714
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 29 May 2022 21:50:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1653875401; bh=cTUY1sv9ZGo8D3Qu6Dm5T+g8dwxHrBx5V3NznCCsoR4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=VNwECk3LNLOeogf11wZy/5egu75vUhHLUhpS24v/koed8NmWC4tPOb/wJofCEjGmZ
         oHeU4gQlQk142QqLLEcHdPQh29UWAdljJXQk6W2b1X7I5b9g1QUoPa23lrxjaBQHog
         3iezlxd0w/XU3z5qOmFvmhbO/YbqxZU8V/XBR+vuh4RsWfwDTkFrhJKg6NDTTfHMia
         rhmdpfO+tx8V3KrcUctxdhDy0fzPnEg1Z6G1WzPEq7gWuuAfKk2W21e955Nu9FlWdf
         dL//v6KVH5Y2UKoHCLLhCRN17fJYYGBBLHu2lgYvvoBmaIrEM9OD9FFsRqd6k9rI6h
         ouj0ILTQBnmFA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id DFE2915C009C; Sun, 29 May 2022 21:49:58 -0400 (EDT)
Date:   Sun, 29 May 2022 21:49:58 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Stephen E. Baker" <baker.stephen.e@gmail.com>
Cc:     adilger.kernel@dilger.ca, hch@lst.de, linux-ext4@vger.kernel.org
Subject: Re: simplify ext4_sb_read_encoding regression
Message-ID: <YpQixl+ljcC1VHNU@mit.edu>
References: <CAFDdnB1Rq3vNe_qt_0u+inzOuL4vrGhgbOoQZKBwfBktni=Npw@mail.gmail.com>
 <YpLLTkje/QUYPP9z@mit.edu>
 <YpNk4bQlRKmgDw8E@mit.edu>
 <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFDdnB0a3mfcoY7rg5N4dO13qMeSsV+PkA2YHeerEOFRv8484Q@mail.gmail.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, May 29, 2022 at 06:49:01PM -0400, Stephen E. Baker wrote:
> On Sun, May 29, 2022 at 8:19 AM Theodore Ts'o <tytso@mit.edu> wrote:
> 
> I had misidentified the commit, but after being more careful with my bisect and
> kernel config I ended up in the same patch set. The actual
> first bad commit is 2b3d047870120bcd46d7cc257d19ff49328fd585
> "unicode: Add utf8-data module"

What kernel config are you using?  If you have configured
CONFIG_UNICODE_UTF8_DATA is a module, that's probably your problem.
At the point when you are mounting the root file system, the Unicode
UTF-8 module is not present unless you are using an initial ramdisk
and you have set things up to include the Unicode data module in the
initrd.  That would certainly explain why the root file system failed
to mount, and since you don't have access to the early boot output,
this wouldn't have been as obvious to you.

Try configuing CONFIG_UNICODE_UTF8_DATA=y (as opposed to =m or =n),
and hopefully that will fix things for you.

Cheers,

					- Ted
