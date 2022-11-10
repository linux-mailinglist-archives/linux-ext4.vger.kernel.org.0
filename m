Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21828624A9D
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 20:27:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiKJT1E (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Nov 2022 14:27:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiKJT1D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Nov 2022 14:27:03 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEC972ED56
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 11:27:01 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 931E120FFCBE; Thu, 10 Nov 2022 11:27:01 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 931E120FFCBE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668108421;
        bh=yHYCBIUipJov3H81o6PrzonqTm/WU1+IoeA1Oj+Fhek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C4cI9sJrLqdjdnek9aselJUyIO7h+cfWwxNm/E6lvzfpsl6PmouR/RgeHel4faw54
         qmbEXkxKTNgGDwGJ6EmPOk4h5QUISFXTCgYcfN6LmmORpvc8XxIkojpHNBQYOuoiG4
         bh34zPMgrDeC04xQg3JACAhl53Pj4YiUvl/qWFvQ=
Date:   Thu, 10 Nov 2022 11:27:01 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Thilo Fromm <t-lo@linux.microsoft.com>,
        Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221110192701.GA29083@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20221005151053.7jjgc7uhvquo6a5n@quack3>
 <20221010142410.GA1689@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
 <20221014132543.i3aiyx4ent4qwy4i@quack3>
 <d30f4e74-aa75-743d-3c89-80ec61d67c6c@linux.microsoft.com>
 <20221024104628.ozxjtdrotysq2haj@quack3>
 <643d007e-1041-4b3d-ed5e-ae47804f279d@linux.microsoft.com>
 <20221026101854.k6qgunxexhxthw64@quack3>
 <20221110125758.GA6919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <20221110152637.g64p4hycnd7bfnnr@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221110152637.g64p4hycnd7bfnnr@quack3>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-19.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Nov 10, 2022 at 04:26:37PM +0100, Jan Kara wrote:
> On Thu 10-11-22 04:57:58, Jeremi Piotrowski wrote:
> > On Wed, Oct 26, 2022 at 12:18:54PM +0200, Jan Kara wrote:
> > > On Mon 24-10-22 18:32:51, Thilo Fromm wrote:
> > > > Hello Honza,
> > > > 
> > > > > Yeah, I was pondering about this for some time but still I have no clue who
> > > > > could be holding the buffer lock (which blocks the task holding the
> > > > > transaction open) or how this could related to the commit you have
> > > > > identified. I have two things to try:
> > > > > 
> > > > > 1) Can you please check whether the deadlock reproduces also with 6.0
> > > > > kernel? The thing is that xattr handling code in ext4 has there some
> > > > > additional changes, commit 307af6c8793 ("mbcache: automatically delete
> > > > > entries from cache on freeing") in particular.
> > > > 
> > > > This would be complex; we currently do not integrate 6.0 with Flatcar and
> > > > would need to spend quite some effort ingesting it first (mostly, make sure
> > > > the new kernel does not break something unrelated). Flatcar is an
> > > > image-based distro, so kernel updates imply full distro updates.
> > > 
> > > OK, understood.
> > > 
> > > > > 2) I have created a debug patch (against 5.15.x stable kernel). Can you
> > > > > please reproduce the failure with it and post the output of "echo w
> > > > > > /proc/sysrq-trigger" and also the output the debug patch will put into the
> > > > > kernel log? It will dump the information about buffer lock owner if we > cannot get the lock for more than 32 seconds.
> > > > 
> > > > This would be more straightforward - I can reach out to one of our users
> > > > suffering from the issue; they can reliably reproduce it and don't shy away
> > > > from patching their kernel. Where can I find the patch?
> > > 
> > > Ha, my bad. I forgot to attach it. Here it is.
> > > 
> > 
> > Unfortunately this patch produced no output, but I have been able to repro so I
> > understand why: except for the hung tasks, we have 1+ tasks busy-looping through
> > the following code in ext4_xattr_block_set():
> > 
> > inserted:
> >         if (!IS_LAST_ENTRY(s->first)) {
> >                 new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
> >                                                      &ce);
> >                 if (new_bh) {
> >                         /* We found an identical block in the cache. */
> >                         if (new_bh == bs->bh)
> >                                 ea_bdebug(new_bh, "keeping");
> >                         else {
> >                                 u32 ref;
> > 
> >                                 WARN_ON_ONCE(dquot_initialize_needed(inode));
> > 
> >                                 /* The old block is released after updating
> >                                    the inode. */
> >                                 error = dquot_alloc_block(inode,
> >                                                 EXT4_C2B(EXT4_SB(sb), 1));
> >                                 if (error)
> >                                         goto cleanup;
> >                                 BUFFER_TRACE(new_bh, "get_write_access");
> >                                 error = ext4_journal_get_write_access(
> >                                                 handle, sb, new_bh,
> >                                                 EXT4_JTR_NONE);
> >                                 if (error)
> >                                         goto cleanup_dquot;
> >                                 lock_buffer(new_bh);
> >                                 /*
> >                                  * We have to be careful about races with
> >                                  * adding references to xattr block. Once we
> >                                  * hold buffer lock xattr block's state is
> >                                  * stable so we can check the additional
> >                                  * reference fits.
> >                                  */
> >                                 ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
> >                                 if (ref > EXT4_XATTR_REFCOUNT_MAX) {
> >                                         /*
> >                                          * Undo everything and check mbcache
> >                                          * again.
> >                                          */
> >                                         unlock_buffer(new_bh);
> >                                         dquot_free_block(inode,
> >                                                          EXT4_C2B(EXT4_SB(sb),
> >                                                                   1));
> >                                         brelse(new_bh);
> >                                         mb_cache_entry_put(ea_block_cache, ce);
> >                                         ce = NULL;
> >                                         new_bh = NULL;
> >                                         goto inserted;
> >                                 }
> > 
> > The tasks keep taking the 'goto inserted' branch, and never finish. I've been
> > able to repro with kernel v6.0.7 as well.
> 
> Interesting! That makes is much clearer (and also makes my debug patch
> unnecessary). So clearly the e_reusable variable in the mb_cache_entry got
> out of sync with the number of references really in the xattr block - in
> particular the block likely has h_refcount >= EXT4_XATTR_REFCOUNT_MAX but
> e_reusable is set to true. Now I can see how e_reusable can stay at false due
> to a race when refcount is actually smaller but I don't see how it could
> stay at true when refcount is big enough - that part seems to be locked
> properly. If you can reproduce reasonably easily, can you try reproducing
> with attached patch? Thanks!
> 

Sure, with that patch I'm getting the following output, reusable is false on
most items until we hit something with reusable true and then that loops
indefinitely:

...
[  218.947992] ce 00000000be9f0441 ref 1025 reusable 0
[  219.932155] ce 0000000057dbfc7a ref 1025 reusable 0
[  224.556261] ce 00000000555ee2ed ref 1025 reusable 0
[  225.844042] ce 000000006e895e6b ref 1025 reusable 0
[  226.088019] ce 000000009f8ba804 ref 1025 reusable 0
[  226.375898] ce 00000000785d2449 ref 1025 reusable 0
[  227.125387] ce 0000000047933e68 ref 1025 reusable 0
[  227.837900] ce 00000000a18723bb ref 1025 reusable 0
[  230.413104] ce 00000000bf25dd58 ref 1025 reusable 0
[  235.041915] ce 00000000b6371d2e ref 1025 reusable 0
[  236.605994] ce 00000000f59e23fd ref 1025 reusable 0
[  239.560110] ce 000000003adcddfa ref 1025 reusable 0
[  240.357104] ce 0000000019ce6812 ref 1025 reusable 0
[  242.100579] ce 00000000487d05d4 ref 1025 reusable 1
[  242.101028] ce 00000000487d05d4 ref 1025 reusable 1
[  242.101410] ce 00000000487d05d4 ref 1025 reusable 1
[  242.101790] ce 00000000487d05d4 ref 1025 reusable 1
[  242.102254] ce 00000000487d05d4 ref 1025 reusable 1
[  242.102667] ce 00000000487d05d4 ref 1025 reusable 1
[  242.103151] ce 00000000487d05d4 ref 1025 reusable 1
[  242.103519] ce 00000000487d05d4 ref 1025 reusable 1
[  242.103895] ce 00000000487d05d4 ref 1025 reusable 1
[  242.104312] ce 00000000487d05d4 ref 1025 reusable 1
[  242.110017] ce 00000000487d05d4 ref 1025 reusable 1
[  242.110388] ce 00000000487d05d4 ref 1025 reusable 1
... (repeats forever)
