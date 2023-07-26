Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 156D9763FA2
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jul 2023 21:30:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbjGZTau (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jul 2023 15:30:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjGZTat (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jul 2023 15:30:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0C7010DB;
        Wed, 26 Jul 2023 12:30:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36D6861CB1;
        Wed, 26 Jul 2023 19:30:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEC3C433C8;
        Wed, 26 Jul 2023 19:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1690399847;
        bh=RV8tXL7RQ7wnolCqR1y4PyPALTKooCyEOhzhJRXcm/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=SVgBXvcrYNhex0+1z06NCyli0sUblvDQ90P7N/xe5kJ0+Q0OeP9lBlMuWohBd599E
         X0HwNQlpDq4CCkcsveKBraRfvaJNSyGF5bPHYv15pSAWcbsia2p99BVqHMVZ9ZvqOY
         0doZpYRXWnSGvBupT8LtftvO3Yru9jMJIrV7gPkQ=
Date:   Wed, 26 Jul 2023 12:30:46 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Ming Lei <tom.leiming@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        linux-block <linux-block@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, Song Liu <song@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Alasdair Kergon <agk@redhat.com>, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        dm-devel@redhat.com, linux-ext4@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
Subject: Re: [dm-devel] Processes hung in "D" state in ext4, mm, md and
 dmcrypt
Message-Id: <20230726123046.a001b6963da19ca883045271@linux-foundation.org>
In-Reply-To: <CACVXFVM8rcGJu-f+6zOgY8t4KPPR0J=giYD5dnCLL8_XVo234w@mail.gmail.com>
References: <4919.1690365747@warthog.procyon.org.uk>
        <CACVXFVM8rcGJu-f+6zOgY8t4KPPR0J=giYD5dnCLL8_XVo234w@mail.gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, 26 Jul 2023 23:29:51 +0800 Ming Lei <tom.leiming@gmail.com> wrote:

> On Wed, Jul 26, 2023 at 6:02 PM David Howells <dhowells@redhat.com> wrote:
> >
> > Hi,
> >
> > With 6.5-rc2 (6.5.0-0.rc2.20230721gitf7e3a1bafdea.20.fc39.x86_64), I'm seeing
> > a bunch of processes getting stuck in the D state on my desktop after a few
> > hours of reading email and compiling stuff.  It's happened every day this week
> > so far and I managed to grab stack traces of the stuck processes this morning
> > (see attached).
> >
> > There are two blockdevs involved below, /dev/md2 and /dev/md3.  md3 is a raid1
> > array with two partitions with an ext4 partition on it.  md2 is similar but
> > it's dm-crypted and ext4 is on top of that.
> >
> ...
> 
> > ===117547===
> >     PID TTY      STAT   TIME COMMAND
> >  117547 ?        D      5:12 [kworker/u16:8+flush-9:3]
> > [<0>] blk_mq_get_tag+0x11e/0x2b0
> > [<0>] __blk_mq_alloc_requests+0x1bc/0x350
> > [<0>] blk_mq_submit_bio+0x2c7/0x680
> > [<0>] __submit_bio+0x8b/0x170
> > [<0>] submit_bio_noacct_nocheck+0x159/0x370
> > [<0>] __block_write_full_folio+0x1e1/0x400
> > [<0>] writepage_cb+0x1a/0x70
> > [<0>] write_cache_pages+0x144/0x3b0
> > [<0>] do_writepages+0x164/0x1e0
> > [<0>] __writeback_single_inode+0x3d/0x360
> > [<0>] writeback_sb_inodes+0x1ed/0x4b0
> > [<0>] __writeback_inodes_wb+0x4c/0xf0
> > [<0>] wb_writeback+0x298/0x310
> > [<0>] wb_workfn+0x35b/0x510
> > [<0>] process_one_work+0x1de/0x3f0
> > [<0>] worker_thread+0x51/0x390
> > [<0>] kthread+0xe5/0x120
> > [<0>] ret_from_fork+0x31/0x50
> > [<0>] ret_from_fork_asm+0x1b/0x30
> 
> BTW, -rc3 fixes one similar issue on the above code path, so please try -rc3.
> 
> 106397376c03 sbitmap: fix batching wakeup

That patch really needs a Fixes:, please.  And consideration for a
-stable backport.

Looking at what has changed recently in sbitmap, it seems unlikely that
106397376c03 fixes an issue that just appeared in 6.5-rcX.  But maybe
the issue you have identified has recently become easier to hit; we'll
see.

