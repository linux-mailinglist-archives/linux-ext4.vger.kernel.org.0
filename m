Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28AC16C03C9
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Mar 2023 19:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229473AbjCSSgY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Mar 2023 14:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjCSSgY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Mar 2023 14:36:24 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D46FE4
        for <linux-ext4@vger.kernel.org>; Sun, 19 Mar 2023 11:36:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A6923CE0F93
        for <linux-ext4@vger.kernel.org>; Sun, 19 Mar 2023 18:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D54C433D2;
        Sun, 19 Mar 2023 18:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679250979;
        bh=N1TzSjBDBmrPUNN9cZiZfV1bKnTXXWx5pZLnuGNwA+0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6tqxQhZy4IYqgaaY1YSy/VM1jBwoogMcDo6MR5d7vBsY+j7i0U2KYW/KH+/4r/Zk
         IaSOVomJzxGHcsN7rJT1I7DzG5Lq8inRqtPZaAFumkyri9QbgKgXr/5DwuuFq7tJXj
         f9vYqwSXEqSUDLw2N1FKCPQqfW1x3mVpYjVSvXo2V4AQn9VxS12mtxcVOXe7WPG60U
         JaLn28XNqokmcC1BxFdUpz4EWsu5d4ENn/29oWniv5LviERbPthgcAdZvKrNl/l3rA
         4HUd9Il58sTcF3FI/UKVER/YnrPrCpwI8QVnc464/oTBIlf3Dg4YpvnqgqJMTErESq
         isemdqCT0OWYA==
Date:   Sun, 19 Mar 2023 11:36:17 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix warnings when freezing filesystem with
 journaled data
Message-ID: <20230319183617.GA896@sol.localdomain>
References: <20230308142528.12384-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308142528.12384-1-jack@suse.cz>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan,

On Wed, Mar 08, 2023 at 03:25:28PM +0100, Jan Kara wrote:
> Test generic/390 in data=journal mode often triggers a warning that
> ext4_do_writepages() tries to start a transaction on frozen filesystem.
> This happens because although all dirty data is properly written, jbd2
> checkpointing code writes data through submit_bh() and as a result only
> buffer dirty bits are cleared but page dirty bits stay set. Later when
> the filesystem is frozen, writeback code comes, tries to write
> supposedly dirty pages and the warning triggers. Fix the problem by
> calling sync_filesystem() once more after flushing the whole journal to
> clear stray page dirty bits.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/inode.c | 15 ++++++++++++++-
>  fs/ext4/super.c | 11 +++++++++++
>  2 files changed, 25 insertions(+), 1 deletion(-)
> 
>   This patch fixes warnings for generic/390 test. Admittedly it is a bit of a
> hack and the right fix is to change jbd2 code to avoid leaving stray page dirty
> bits but that is actually surprisingly difficult to do due to locking
> constraints without regressing metadata intensive workloads. Applies on top of
> my data=journal cleanup series.
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 4a45d320fda8..d86efa3d959d 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2410,6 +2410,7 @@ static int mpage_journal_page_buffers(handle_t *handle,
>  static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  {
>  	struct address_space *mapping = mpd->inode->i_mapping;
> +	struct super_block *sb = mpd->inode->i_sb;
>  	struct folio_batch fbatch;
>  	unsigned int nr_folios;
>  	pgoff_t index = mpd->first_page;
> @@ -2427,7 +2428,15 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  	else
>  		tag = PAGECACHE_TAG_DIRTY;
>  
> -	if (ext4_should_journal_data(mpd->inode)) {
> +	/*
> +	 * Start a transaction for writeback of journalled data. We don't start
> +	 * start the transaction if the filesystem is frozen. In that case we
> +	 * should not have any dirty data to write anymore but possibly there
> +	 * are stray page dirty bits left by the checkpointing code so this
> +	 * loop clears them.
> +	 */
> +	if (ext4_should_journal_data(mpd->inode) &&
> +	    sb->s_writers.frozen >= SB_FREEZE_FS) {
>  		handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
>  					    bpp);
>  		if (IS_ERR(handle))
> @@ -2520,12 +2529,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
>  			 */
>  			if (!mpd->can_map) {
>  				if (ext4_page_nomap_can_writeout(&folio->page)) {
> +					WARN_ON_ONCE(sb->s_writers.frozen ==
> +						     SB_FREEZE_COMPLETE);
>  					err = mpage_submit_page(mpd, &folio->page);
>  					if (err < 0)
>  						goto out;
>  				}
>  				/* Pending dirtying of journalled data? */
>  				if (PageChecked(&folio->page)) {
> +					WARN_ON_ONCE(sb->s_writers.frozen >=
> +						     SB_FREEZE_FS);
>  					err = mpage_journal_page_buffers(handle,
>  						mpd, &folio->page);
>  					if (err < 0)
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 88f7b8a88c76..8cdf1a4e0011 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -6259,6 +6259,17 @@ static int ext4_freeze(struct super_block *sb)
>  		if (error < 0)
>  			goto out;
>  
> +		/*
> +		 * Do another sync. We really should not have any dirty data
> +		 * anymore but our checkpointing code does not clear page dirty
> +		 * bits due to locking constraints so writeback still can get
> +		 * started for inodes with journalled data which triggers
> +		 * annoying warnings.
> +		 */
> +		error = sync_filesystem(sb);
> +		if (error < 0)
> +			goto out;
> +
>  		/* Journal blocked and flushed, clear needs_recovery flag. */
>  		ext4_clear_feature_journal_needs_recovery(sb);
>  		if (ext4_orphan_file_empty(sb))

This patch causes a NULL dereference of 'handle' in mpage_journal_page_buffers()
when running the fsverity stress test generic/579 with data journaling enabled.
To reproduce:

	kvm-xfstests -c ext4/data_journal generic/579

First, isn't the condition 'ext4_should_journal_data(mpd->inode) &&
sb->s_writers.frozen >= SB_FREEZE_FS' wrong?  Shouldn't it check
'sb->s_writers.frozen < SB_FREEZE_FS' instead?

That fixes the crash by itself.  However, the other reason this happens is that
the PG_checked bit is being used by both data=journal (to mark DMA-pinned dirty
pages?) and by fsverity (to mark Merkle tree pages that have been verified).

These two uses of PG_checked shouldn't actually collide, since fsverity files
are read-only, and FS_IOC_ENABLE_VERITY calls filemap_write_and_wait() before
finishing enabling fsverity.  PG_checked isn't used for fsverity until after
fsverity has finished being enabled, at which point there should no longer be
any dirty pages.  But, they are in fact colliding somehow.  Is it expected that
dirty pages are still left after filemap_write_and_wait()?

- Eric
