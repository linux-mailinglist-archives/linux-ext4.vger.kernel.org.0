Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 975667C7243
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Oct 2023 18:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235752AbjJLQRe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Oct 2023 12:17:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbjJLQRd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Oct 2023 12:17:33 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DC0B94
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 09:17:31 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id ADE021F8A8;
        Thu, 12 Oct 2023 16:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1697127449; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYLugpxLYkR/wRauykkgcPn7zpy2HAhB0eqyUN2mCbg=;
        b=SPPo/1pU3A//zAT66TMj/SfTIXM3FFbAhVWvIn3l+yI/Bs46bdSh2Ine7dbkBiYF1N1CSG
        cYNyo+qW2MfsfBoQ1jCren5yugQxBN3Kzu4or9svBTq2xo6h9ziLP/tBIX2+hwIWn+RGgE
        bPFjH60ueqPMlsqZVqleE6kvVpNrTQo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1697127449;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KYLugpxLYkR/wRauykkgcPn7zpy2HAhB0eqyUN2mCbg=;
        b=1MOBTHFnSvzcTWYZ02glitNJRI2ZTf9Ii/h44rNDHzRi9ysUK7zZEnHDlPaVKRq0+tviSj
        6pX3W7N6SKW1lnAg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 9CCE3139ED;
        Thu, 12 Oct 2023 16:17:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 5DI7JhkcKGWkTQAAMHmgww
        (envelope-from <jack@suse.cz>); Thu, 12 Oct 2023 16:17:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 23A77A06B0; Thu, 12 Oct 2023 18:17:29 +0200 (CEST)
Date:   Thu, 12 Oct 2023 18:17:29 +0200
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: Re: [PATCH] ext4: Properly sync file size update after O_SYNC direct
 IO
Message-ID: <20231012161729.qxdkz52odhixpu55@quack3>
References: <20231011142155.19328-1-jack@suse.cz>
 <87il7bj21i.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87il7bj21i.fsf@doe.com>
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Level: 
X-Spam-Score: -5.10
X-Spamd-Result: default: False [-5.10 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         BAYES_HAM(-3.00)[100.00%];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         FREEMAIL_ENVRCPT(0.00)[gmail.com];
         TAGGED_RCPT(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         NEURAL_HAM_LONG(-3.00)[-1.000];
         RCPT_COUNT_FIVE(0.00)[5];
         DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
         NEURAL_HAM_SHORT(-1.00)[-1.000];
         FREEMAIL_TO(0.00)[gmail.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         MID_RHS_NOT_FQDN(0.50)[];
         RCVD_COUNT_TWO(0.00)[2];
         RCVD_TLS_ALL(0.00)[];
         SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 12-10-23 20:55:29, Ritesh Harjani wrote:
> Jan Kara <jack@suse.cz> writes:
> 
> > Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
> > sync file size update and thus if we crash at unfortunate moment, the
> > file can have smaller size although O_SYNC IO has reported successful
> > completion. The problem happens because update of on-disk inode size is
> > handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
> > dio_complete() in particular) has returned and generic_file_sync() gets
> > called by dio_complete(). Fix the problem by handling on-disk inode size
> > update directly in our ->end_io completion handler.
> >
> > References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
> > Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> > Signed-off-by: Jan Kara <jack@suse.cz>
> 
> Guess we need a fixes tag.

Good point, will add.

> > ---
> >  fs/ext4/file.c | 139 ++++++++++++++++++-------------------------------
> >  1 file changed, 52 insertions(+), 87 deletions(-)
> >
> > So finally I've hopefully got all the corner cases right ;) At least fstest
> > pass now.
> >
> > diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> > index 1492b1ae21f4..d0711c1a9b06 100644
> > --- a/fs/ext4/file.c
> > +++ b/fs/ext4/file.c
> > @@ -306,80 +306,34 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
> >  }
> >  
> >  static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> > -					   ssize_t written, size_t count)
> > +					   ssize_t count)
> >  {
> >  	handle_t *handle;
> > -	bool truncate = false;
> > -	u8 blkbits = inode->i_blkbits;
> > -	ext4_lblk_t written_blk, end_blk;
> > -	int ret;
> > -
> > -	/*
> > -	 * Note that EXT4_I(inode)->i_disksize can get extended up to
> > -	 * inode->i_size while the I/O was running due to writeback of delalloc
> > -	 * blocks. But, the code in ext4_iomap_alloc() is careful to use
> > -	 * zeroed/unwritten extents if this is possible; thus we won't leave
> > -	 * uninitialized blocks in a file even if we didn't succeed in writing
> > -	 * as much as we intended.
> > -	 */
> > -	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
> > -	if (offset + count <= EXT4_I(inode)->i_disksize) {
> > -		/*
> > -		 * We need to ensure that the inode is removed from the orphan
> > -		 * list if it has been added prematurely, due to writeback of
> > -		 * delalloc blocks.
> > -		 */
> > -		if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> > -			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > -
> > -			if (IS_ERR(handle)) {
> > -				ext4_orphan_del(NULL, inode);
> > -				return PTR_ERR(handle);
> > -			}
> > -
> > -			ext4_orphan_del(handle, inode);
> > -			ext4_journal_stop(handle);
> > -		}
> > -
> > -		return written;
> > -	}
> > -
> > -	if (written < 0)
> > -		goto truncate;
> >  
> > +	lockdep_assert_held_write(&inode->i_rwsem);
> >  	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> > -	if (IS_ERR(handle)) {
> > -		written = PTR_ERR(handle);
> > -		goto truncate;
> > -	}
> > +	if (IS_ERR(handle))
> > +		return PTR_ERR(handle);
> >  
> > -	if (ext4_update_inode_size(inode, offset + written)) {
> > -		ret = ext4_mark_inode_dirty(handle, inode);
> > +	if (ext4_update_inode_size(inode, offset + count)) {
> > +		int ret = ext4_mark_inode_dirty(handle, inode);
> >  		if (unlikely(ret)) {
> > -			written = ret;
> >  			ext4_journal_stop(handle);
> > -			goto truncate;
> > +			return ret;
> >  		}
> >  	}
> >  
> > -	/*
> > -	 * We may need to truncate allocated but not written blocks beyond EOF.
> > -	 */
> > -	written_blk = ALIGN(offset + written, 1 << blkbits);
> > -	end_blk = ALIGN(offset + count, 1 << blkbits);
> > -	if (written_blk < end_blk && ext4_can_truncate(inode))
> > -		truncate = true;
> > -
> > -	/*
> > -	 * Remove the inode from the orphan list if it has been extended and
> > -	 * everything went OK.
> > -	 */
> > -	if (!truncate && inode->i_nlink)
> > +	if (inode->i_nlink)
> >  		ext4_orphan_del(handle, inode);
> >  	ext4_journal_stop(handle);
> >  
> > -	if (truncate) {
> > -truncate:
> > +	return count;
> > +}
> > +
> > +static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
> > +{
> > +	lockdep_assert_held_write(&inode->i_rwsem);
> > +	if (count < 0) {
> >  		ext4_truncate_failed_write(inode);
> >  		/*
> >  		 * If the truncate operation failed early, then the inode may
> > @@ -388,9 +342,28 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> >  		 */
> >  		if (inode->i_nlink)
> >  			ext4_orphan_del(NULL, inode);
> > +		return;
> >  	}
> > +	/*
> > +	 * If i_disksize got extended due to writeback of delalloc blocks while
> > +	 * the DIO was running we could fail to cleanup the orphan list in
> > +	 * ext4_handle_inode_extension(). Do it now.
> > +	 */
> > +	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> > +		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> >  
> > -	return written;
> > +		if (IS_ERR(handle)) {
> > +			/*
> > +			 * The write has successfully completed. Not much to
> > +			 * do with the error here so just cleanup the orphan
> > +			 * list and hope for the best.
> > +			 */
> > +			ext4_orphan_del(NULL, inode);
> > +			return;
> > +		}
> > +		ext4_orphan_del(handle, inode);
> > +		ext4_journal_stop(handle);
> > +	}
> >  }
> >  
> >  static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> > @@ -399,31 +372,22 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> >  	loff_t pos = iocb->ki_pos;
> >  	struct inode *inode = file_inode(iocb->ki_filp);
> >  
> > +	if (!error && size && flags & IOMAP_DIO_END_UNWRITTEN)
> 
> Do we have IOMAP_DIO_END_UNWRITTEN? or should it be IOMAP_DIO_UNWRITTEN?
> Also we don't need to check !error case if we return early in case of an error.

It should be IOMAP_DIO_UNWRITTEN. Unrelated iomap cleanup snuck under this
patch in my tree (because older versions of the patch needed it).

> > +		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
> >  	if (error)
> >  		return error;
> > -
> > -	if (size && flags & IOMAP_DIO_END_UNWRITTEN) {
> 
> ditto.
> 
> > -		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
> > -		if (error < 0)
> > -			return error;
> > -	}
> >  	/*
> > -	 * If we are extending the file, we have to update i_size here before
> > -	 * page cache gets invalidated in iomap_dio_rw(). Otherwise racing
> > -	 * buffered reads could zero out too much from page cache pages. Update
> > -	 * of on-disk size will happen later in ext4_dio_write_iter() where
> > -	 * we have enough information to also perform orphan list handling etc.
> > -	 * Note that we perform all extending writes synchronously under
> > -	 * i_rwsem held exclusively so i_size update is safe here in that case.
> > -	 * If the write was not extending, we cannot see pos > i_size here
> > -	 * because operations reducing i_size like truncate wait for all
> > -	 * outstanding DIO before updating i_size.
> > +	 * Note that EXT4_I(inode)->i_disksize can get extended up to
> > +	 * inode->i_size while the I/O was running due to writeback of delalloc
> > +	 * blocks. But the code in ext4_iomap_alloc() is careful to use
> > +	 * zeroed/unwritten extents if this is possible; thus we won't leave
> > +	 * uninitialized blocks in a file even if we didn't succeed in writing
> > +	 * as much as we intended.
> >  	 */
> > -	pos += size;
> > -	if (pos > i_size_read(inode))
> > -		i_size_write(inode, pos);
> > -
> > -	return 0;
> > +	WARN_ON_ONCE(i_size_read(inode) < READ_ONCE(EXT4_I(inode)->i_disksize));
> > +	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize))
> > +		return 0;
> > +	return ext4_handle_inode_extension(inode, pos, size);
> >  }
> 
> Although it is not a problem, but we are sometimes returning 0 and
> sometimes count here.

Yeah. iomap_dio_complete() actually fixes this up but I agree it is
confusing a bit. Let's return 'size' here.

							Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
