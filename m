Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D59956242A7
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Nov 2022 13:58:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiKJM6D (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Nov 2022 07:58:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiKJM6D (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Nov 2022 07:58:03 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BE0C701A2
        for <linux-ext4@vger.kernel.org>; Thu, 10 Nov 2022 04:57:59 -0800 (PST)
Received: by linux.microsoft.com (Postfix, from userid 1112)
        id 0413E20E67C1; Thu, 10 Nov 2022 04:57:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0413E20E67C1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1668085079;
        bh=c/8yTwHNqIAZ34LBEK2zXKFNG3UMsuCzGQykXvc3lFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IzaCO4LF4vdFmNycLWBPBnSa1krWdxasCclp3R574fgj75Y3i5gCzre8LtiFDPuad
         iEGXa19foEj7lJakk2aqu8Mkl6/R3u05Gji0q1ckIfzrRDfrftkXjEfnBszdb/oGN6
         udtKpydv+CzW4TVmEyxHBgVuDfqZ12LJWxP7F0Ao=
Date:   Thu, 10 Nov 2022 04:57:58 -0800
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Thilo Fromm <t-lo@linux.microsoft.com>,
        Ye Bin <yebin10@huawei.com>, jack@suse.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, regressions@lists.linux.dev
Subject: Re: [syzbot] possible deadlock in jbd2_journal_lock_updates
Message-ID: <20221110125758.GA6919@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20221004091035.idjgo2xyscf6ovnv@quack3>
 <eeb17fca-4e79-b39f-c394-a6fa6873eb26@linux.microsoft.com>
 <20221005151053.7jjgc7uhvquo6a5n@quack3>
 <20221010142410.GA1689@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <2ede5fce-7077-6e64-93a9-a7d993bc498f@linux.microsoft.com>
 <20221014132543.i3aiyx4ent4qwy4i@quack3>
 <d30f4e74-aa75-743d-3c89-80ec61d67c6c@linux.microsoft.com>
 <20221024104628.ozxjtdrotysq2haj@quack3>
 <643d007e-1041-4b3d-ed5e-ae47804f279d@linux.microsoft.com>
 <20221026101854.k6qgunxexhxthw64@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221026101854.k6qgunxexhxthw64@quack3>
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

On Wed, Oct 26, 2022 at 12:18:54PM +0200, Jan Kara wrote:
> On Mon 24-10-22 18:32:51, Thilo Fromm wrote:
> > Hello Honza,
> > 
> > > Yeah, I was pondering about this for some time but still I have no clue who
> > > could be holding the buffer lock (which blocks the task holding the
> > > transaction open) or how this could related to the commit you have
> > > identified. I have two things to try:
> > > 
> > > 1) Can you please check whether the deadlock reproduces also with 6.0
> > > kernel? The thing is that xattr handling code in ext4 has there some
> > > additional changes, commit 307af6c8793 ("mbcache: automatically delete
> > > entries from cache on freeing") in particular.
> > 
> > This would be complex; we currently do not integrate 6.0 with Flatcar and
> > would need to spend quite some effort ingesting it first (mostly, make sure
> > the new kernel does not break something unrelated). Flatcar is an
> > image-based distro, so kernel updates imply full distro updates.
> 
> OK, understood.
> 
> > > 2) I have created a debug patch (against 5.15.x stable kernel). Can you
> > > please reproduce the failure with it and post the output of "echo w
> > > > /proc/sysrq-trigger" and also the output the debug patch will put into the
> > > kernel log? It will dump the information about buffer lock owner if we > cannot get the lock for more than 32 seconds.
> > 
> > This would be more straightforward - I can reach out to one of our users
> > suffering from the issue; they can reliably reproduce it and don't shy away
> > from patching their kernel. Where can I find the patch?
> 
> Ha, my bad. I forgot to attach it. Here it is.
> 

Unfortunately this patch produced no output, but I have been able to repro so I
understand why: except for the hung tasks, we have 1+ tasks busy-looping through
the following code in ext4_xattr_block_set():

inserted:
        if (!IS_LAST_ENTRY(s->first)) {
                new_bh = ext4_xattr_block_cache_find(inode, header(s->base),
                                                     &ce);
                if (new_bh) {
                        /* We found an identical block in the cache. */
                        if (new_bh == bs->bh)
                                ea_bdebug(new_bh, "keeping");
                        else {
                                u32 ref;

                                WARN_ON_ONCE(dquot_initialize_needed(inode));

                                /* The old block is released after updating
                                   the inode. */
                                error = dquot_alloc_block(inode,
                                                EXT4_C2B(EXT4_SB(sb), 1));
                                if (error)
                                        goto cleanup;
                                BUFFER_TRACE(new_bh, "get_write_access");
                                error = ext4_journal_get_write_access(
                                                handle, sb, new_bh,
                                                EXT4_JTR_NONE);
                                if (error)
                                        goto cleanup_dquot;
                                lock_buffer(new_bh);
                                /*
                                 * We have to be careful about races with
                                 * adding references to xattr block. Once we
                                 * hold buffer lock xattr block's state is
                                 * stable so we can check the additional
                                 * reference fits.
                                 */
                                ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
                                if (ref > EXT4_XATTR_REFCOUNT_MAX) {
                                        /*
                                         * Undo everything and check mbcache
                                         * again.
                                         */
                                        unlock_buffer(new_bh);
                                        dquot_free_block(inode,
                                                         EXT4_C2B(EXT4_SB(sb),
                                                                  1));
                                        brelse(new_bh);
                                        mb_cache_entry_put(ea_block_cache, ce);
                                        ce = NULL;
                                        new_bh = NULL;
                                        goto inserted;
                                }

The tasks keep taking the 'goto inserted' branch, and never finish. I've been
able to repro with kernel v6.0.7 as well.

> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

> >From feaf5e5ca0b22da6a285dc97eb756e0190fa7411 Mon Sep 17 00:00:00 2001
> From: Jan Kara <jack@suse.cz>
> Date: Mon, 24 Oct 2022 12:02:59 +0200
> Subject: [PATCH] Debug buffer_head lock
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/buffer.c                 | 13 ++++++++++++-
>  include/linux/buffer_head.h | 17 +++++++++++------
>  2 files changed, 23 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/buffer.c b/fs/buffer.c
> index f6d283579491..4514a810f072 100644
> --- a/fs/buffer.c
> +++ b/fs/buffer.c
> @@ -66,7 +66,18 @@ EXPORT_SYMBOL(touch_buffer);
>  
>  void __lock_buffer(struct buffer_head *bh)
>  {
> -	wait_on_bit_lock_io(&bh->b_state, BH_Lock, TASK_UNINTERRUPTIBLE);
> +	int loops = 0;
> +
> +	for (;;) {
> +		wait_on_bit_timeout(&bh->b_state, BH_Lock, TASK_UNINTERRUPTIBLE, HZ);
> +		if (trylock_buffer(bh))
> +			return;
> +		loops++;
> +		if (WARN_ON(!(loops & 31))) {
> +			printk("Waiting for buffer %llu state %lx page flags %lx for %d loops.\n", (unsigned long long)bh->b_blocknr, bh->b_state, bh->b_page->flags, loops);
> +			printk("Owner: pid %u file %s:%d\n", bh->lock_pid, bh->lock_file, bh->lock_line);
> +		}
> +	}
>  }
>  EXPORT_SYMBOL(__lock_buffer);
>  
> diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
> index 25b4263d66d7..67259a959bac 100644
> --- a/include/linux/buffer_head.h
> +++ b/include/linux/buffer_head.h
> @@ -76,6 +76,9 @@ struct buffer_head {
>  	spinlock_t b_uptodate_lock;	/* Used by the first bh in a page, to
>  					 * serialise IO completion of other
>  					 * buffers in the page */
> +	char *lock_file;
> +	unsigned int lock_line;
> +	unsigned int lock_pid;
>  };
>  
>  /*
> @@ -395,12 +398,14 @@ static inline int trylock_buffer(struct buffer_head *bh)
>  	return likely(!test_and_set_bit_lock(BH_Lock, &bh->b_state));
>  }
>  
> -static inline void lock_buffer(struct buffer_head *bh)
> -{
> -	might_sleep();
> -	if (!trylock_buffer(bh))
> -		__lock_buffer(bh);
> -}
> +#define lock_buffer(bh) do {		\
> +	might_sleep();			\
> +	if (!trylock_buffer(bh))	\
> +		__lock_buffer(bh);	\
> +	(bh)->lock_line = __LINE__;	\
> +	(bh)->lock_file = __FILE__;	\
> +	(bh)->lock_pid = current->pid;	\
> +} while (0)
>  
>  static inline struct buffer_head *getblk_unmovable(struct block_device *bdev,
>  						   sector_t block,
> -- 
> 2.35.3
> 

