Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E50D6C313A
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Mar 2023 13:06:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbjCUMG5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Mar 2023 08:06:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjCUMG5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Mar 2023 08:06:57 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3799C231D5
        for <linux-ext4@vger.kernel.org>; Tue, 21 Mar 2023 05:06:55 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id DAD7E21CFC;
        Tue, 21 Mar 2023 12:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679400413; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MP3VFALtpR8gvOUel1LxeLSW9BCT9mc760UNQiDULLM=;
        b=ZXoyf+Fo6UZmi8QGdJvaz5t56xzJoYa1pPMGSTxwVRJvpXdmg4ASOxr02v+ro871MMxWWk
        yemERZcorJ3jQXPhwZXRvmggauVy1/nmmy9gw79IxZs//Qo8cman6hBixl+Zgvh/wn0rd6
        DN86bJx7WVT19UpyYk2Qw6PIqgGGiGY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679400413;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MP3VFALtpR8gvOUel1LxeLSW9BCT9mc760UNQiDULLM=;
        b=T9jM9Kz4k8V8stXWMdIzZ2GzQ6MvU/0yGFJ4rQjz6Ga6dBoKB/jDY5dpPMw6GeOf2k1th8
        rQtEU5uJjX8evuDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id CB4C613451;
        Tue, 21 Mar 2023 12:06:53 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id iDeWMd2dGWQ0JgAAMHmgww
        (envelope-from <jack@suse.cz>); Tue, 21 Mar 2023 12:06:53 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 26DF0A071C; Tue, 21 Mar 2023 13:06:53 +0100 (CET)
Date:   Tue, 21 Mar 2023 13:06:53 +0100
From:   Jan Kara <jack@suse.cz>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix warnings when freezing filesystem with
 journaled data
Message-ID: <20230321120653.j5fpyqk4iat6wrvu@quack3>
References: <20230308142528.12384-1-jack@suse.cz>
 <20230319183617.GA896@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230319183617.GA896@sol.localdomain>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Eric,

On Sun 19-03-23 11:36:17, Eric Biggers wrote:
> On Wed, Mar 08, 2023 at 03:25:28PM +0100, Jan Kara wrote:
> > Test generic/390 in data=journal mode often triggers a warning that
> > ext4_do_writepages() tries to start a transaction on frozen filesystem.
> > This happens because although all dirty data is properly written, jbd2
> > checkpointing code writes data through submit_bh() and as a result only
> > buffer dirty bits are cleared but page dirty bits stay set. Later when
> > the filesystem is frozen, writeback code comes, tries to write
> > supposedly dirty pages and the warning triggers. Fix the problem by
> > calling sync_filesystem() once more after flushing the whole journal to
> > clear stray page dirty bits.
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/inode.c | 15 ++++++++++++++-
> >  fs/ext4/super.c | 11 +++++++++++
> >  2 files changed, 25 insertions(+), 1 deletion(-)
> > 
> >   This patch fixes warnings for generic/390 test. Admittedly it is a bit of a
> > hack and the right fix is to change jbd2 code to avoid leaving stray page dirty
> > bits but that is actually surprisingly difficult to do due to locking
> > constraints without regressing metadata intensive workloads. Applies on top of
> > my data=journal cleanup series.
> > 
> > diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> > index 4a45d320fda8..d86efa3d959d 100644
> > --- a/fs/ext4/inode.c
> > +++ b/fs/ext4/inode.c
> > @@ -2410,6 +2410,7 @@ static int mpage_journal_page_buffers(handle_t *handle,
> >  static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
> >  {
> >  	struct address_space *mapping = mpd->inode->i_mapping;
> > +	struct super_block *sb = mpd->inode->i_sb;
> >  	struct folio_batch fbatch;
> >  	unsigned int nr_folios;
> >  	pgoff_t index = mpd->first_page;
> > @@ -2427,7 +2428,15 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
> >  	else
> >  		tag = PAGECACHE_TAG_DIRTY;
> >  
> > -	if (ext4_should_journal_data(mpd->inode)) {
> > +	/*
> > +	 * Start a transaction for writeback of journalled data. We don't start
> > +	 * start the transaction if the filesystem is frozen. In that case we
> > +	 * should not have any dirty data to write anymore but possibly there
> > +	 * are stray page dirty bits left by the checkpointing code so this
> > +	 * loop clears them.
> > +	 */
> > +	if (ext4_should_journal_data(mpd->inode) &&
> > +	    sb->s_writers.frozen >= SB_FREEZE_FS) {
> >  		handle = ext4_journal_start(mpd->inode, EXT4_HT_WRITE_PAGE,
> >  					    bpp);
> >  		if (IS_ERR(handle))
> > @@ -2520,12 +2529,16 @@ static int mpage_prepare_extent_to_map(struct mpage_da_data *mpd)
> >  			 */
> >  			if (!mpd->can_map) {
> >  				if (ext4_page_nomap_can_writeout(&folio->page)) {
> > +					WARN_ON_ONCE(sb->s_writers.frozen ==
> > +						     SB_FREEZE_COMPLETE);
> >  					err = mpage_submit_page(mpd, &folio->page);
> >  					if (err < 0)
> >  						goto out;
> >  				}
> >  				/* Pending dirtying of journalled data? */
> >  				if (PageChecked(&folio->page)) {
> > +					WARN_ON_ONCE(sb->s_writers.frozen >=
> > +						     SB_FREEZE_FS);
> >  					err = mpage_journal_page_buffers(handle,
> >  						mpd, &folio->page);
> >  					if (err < 0)
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 88f7b8a88c76..8cdf1a4e0011 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -6259,6 +6259,17 @@ static int ext4_freeze(struct super_block *sb)
> >  		if (error < 0)
> >  			goto out;
> >  
> > +		/*
> > +		 * Do another sync. We really should not have any dirty data
> > +		 * anymore but our checkpointing code does not clear page dirty
> > +		 * bits due to locking constraints so writeback still can get
> > +		 * started for inodes with journalled data which triggers
> > +		 * annoying warnings.
> > +		 */
> > +		error = sync_filesystem(sb);
> > +		if (error < 0)
> > +			goto out;
> > +
> >  		/* Journal blocked and flushed, clear needs_recovery flag. */
> >  		ext4_clear_feature_journal_needs_recovery(sb);
> >  		if (ext4_orphan_file_empty(sb))
> 
> This patch causes a NULL dereference of 'handle' in mpage_journal_page_buffers()
> when running the fsverity stress test generic/579 with data journaling enabled.
> To reproduce:
> 
> 	kvm-xfstests -c ext4/data_journal generic/579
> 
> First, isn't the condition 'ext4_should_journal_data(mpd->inode) &&
> sb->s_writers.frozen >= SB_FREEZE_FS' wrong?  Shouldn't it check
> 'sb->s_writers.frozen < SB_FREEZE_FS' instead?

Indeed, I wonder how this has passed all the other testing I and Ted did :)
I'll send a fix.

> That fixes the crash by itself.  However, the other reason this happens is that
> the PG_checked bit is being used by both data=journal (to mark DMA-pinned dirty
> pages?) and by fsverity (to mark Merkle tree pages that have been verified).

Yup.

> These two uses of PG_checked shouldn't actually collide, since fsverity files
> are read-only, and FS_IOC_ENABLE_VERITY calls filemap_write_and_wait() before
> finishing enabling fsverity.  PG_checked isn't used for fsverity until after
> fsverity has finished being enabled, at which point there should no longer be
> any dirty pages.  But, they are in fact colliding somehow.  Is it expected that
> dirty pages are still left after filemap_write_and_wait()?

Sadly filemap_write_and_wait() is not enough to clean pages from a file
with journalled data. For couple of reasons:

1) Pages can be part of the running transaction so until we commit that
(which filemap_write_and_wait() does not do, only whole ext4_sync_file()
does that) they are not really stable.

2) Once the transaction commits, pages get marked as dirty for
checkpointing code to pick them up.

So to fully clean journaled data pages you need a sequence like:

filemap_write_and_wait() (to add PageChecked pages to the journal)
ext4_force_commit() (to commit the transaction with the pages)
filemap_write_and_wait() (to clean pages that need checkpointing)

I know this sucks and there are quite a few places that need special
handling of journalled data because of this. Ideally we'd hide all these
details in ext4_writepages() but the hard part is how to do this without
making performance go completely out of the window. But I think now that
the journalled data writeout path is simplified, we can handle it
reasonably.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
