Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC2BE6C9F5E
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Mar 2023 11:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjC0J3S (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Mar 2023 05:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232716AbjC0J3R (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 27 Mar 2023 05:29:17 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9165A3A92
        for <linux-ext4@vger.kernel.org>; Mon, 27 Mar 2023 02:29:16 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4721A21CC9;
        Mon, 27 Mar 2023 09:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1679909355; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O7/mfDYdTmddkxzIJzvR8nyMw+r0vlZsoI5ttFGpdi4=;
        b=hk57G70np7kBHd72I7rZAKTfaZPn7ZGLxldcncdgoppr+5LeWI+jVf5KOjk2c5W4upTRZ5
        uLdGbs17tzirZsecoYkDY8VICEruPsGnmW4encfIHTesppJNJvzOGwZAnNrFMqC94xUEtU
        rxg+77rE9bB/nPLTbx5nsIvlGmzzBys=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1679909355;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O7/mfDYdTmddkxzIJzvR8nyMw+r0vlZsoI5ttFGpdi4=;
        b=H7eUStJRp9NLAyYTBeqYdxr5rSyEXcG+M7PMRCsVAD3eXY4Dd5m7ehweEsrwi3NmTVj8lL
        XLKZlbcJo0wxdMCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 35EBD13482;
        Mon, 27 Mar 2023 09:29:15 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id NCAhDethIWTUZQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 27 Mar 2023 09:29:15 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id AA600A071C; Mon, 27 Mar 2023 11:29:14 +0200 (CEST)
Date:   Mon, 27 Mar 2023 11:29:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Chung-Chiang Cheng <cccheng@synology.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        shepjeng@gmail.com, kernel@cccheng.net,
        Robbie Ko <robbieko@synology.com>
Subject: Re: [PATCH] ext4: defer updating i_disksize until endio
Message-ID: <20230327092914.mzizhh52izbvjhhv@quack3>
References: <20230324092907.1341457-1-cccheng@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230324092907.1341457-1-cccheng@synology.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 24-03-23 17:29:07, Chung-Chiang Cheng wrote:
> During a buffer write, the on-disk inode size (i_disksize) gets updated
> at ext4_da_write_end() or mpage_map_and_submit_extent(). This update is
> then committed into the journal. However, at that point, the writeback
> process is not yet completed. If an interruption occurs, the content of
> the file may not be in a consistent state because the i_disksize is
> replayed by the journal, but the corresponding content may not have been
> actually submitted to the disk.
> 
>     $ mount -o commit=1 /dev/vdc /mnt
>     $ echo -n foo >> /mnt/test; sync
>     $ echo -n bar >> /mnt/test; sleep 3; echo b > /proc/sysrq-trigger
> 
>     $ xxd /mnt/test
>     00000000: 666f 6f00 0000                           foo...
> 
> After the above steps have been executed, there are padding zeros at the
> end of the file, which are obviously not part of the actual content.
> To fix this issue, we can defer updating i_disksize until the endio. The
> original ext4_end_io_rsv_work() was to convert unwritten extents to
> extents, but it now also updates the disk size.
> 
> Reviewed-by: Robbie Ko <robbieko@synology.com>
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>

As Zhang Yi already noted in his review, this is expected at least with
data=writeback mount option. With data=ordered this should not happen
though as the commit of the transaction with i_disksize update will wait
for page writeback to complete (this is exactly the reason why data=ordered
exists after all). Are you able to observe this problem with data=ordered
mount option?

								Honza

> ---
>  fs/ext4/inode.c   | 41 ++++--------------------------
>  fs/ext4/page-io.c | 64 +++++++++++++++++++++++++++++++++++++++--------
>  2 files changed, 58 insertions(+), 47 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 96517785a9f8..c3537cd603dc 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -2515,6 +2515,8 @@ static int mpage_map_and_submit_extent(handle_t *handle,
>  			goto update_disksize;
>  	} while (map->m_len);
>  
> +	return err;
> +
>  update_disksize:
>  	/*
>  	 * Update on-disk size after IO is submitted.  Races with
> @@ -3105,36 +3107,12 @@ static int ext4_da_write_begin(struct file *file, struct address_space *mapping,
>  	return ret;
>  }
>  
> -/*
> - * Check if we should update i_disksize
> - * when write to the end of file but not require block allocation
> - */
> -static int ext4_da_should_update_i_disksize(struct page *page,
> -					    unsigned long offset)
> -{
> -	struct buffer_head *bh;
> -	struct inode *inode = page->mapping->host;
> -	unsigned int idx;
> -	int i;
> -
> -	bh = page_buffers(page);
> -	idx = offset >> inode->i_blkbits;
> -
> -	for (i = 0; i < idx; i++)
> -		bh = bh->b_this_page;
> -
> -	if (!buffer_mapped(bh) || (buffer_delay(bh)) || buffer_unwritten(bh))
> -		return 0;
> -	return 1;
> -}
> -
>  static int ext4_da_write_end(struct file *file,
>  			     struct address_space *mapping,
>  			     loff_t pos, unsigned len, unsigned copied,
>  			     struct page *page, void *fsdata)
>  {
>  	struct inode *inode = mapping->host;
> -	loff_t new_i_size;
>  	unsigned long start, end;
>  	int write_mode = (int)(unsigned long)fsdata;
>  
> @@ -3155,22 +3133,13 @@ static int ext4_da_write_end(struct file *file,
>  	/*
>  	 * Since we are holding inode lock, we are sure i_disksize <=
>  	 * i_size. We also know that if i_disksize < i_size, there are
> -	 * delalloc writes pending in the range upto i_size. If the end of
> -	 * the current write is <= i_size, there's no need to touch
> -	 * i_disksize since writeback will push i_disksize upto i_size
> -	 * eventually. If the end of the current write is > i_size and
> -	 * inside an allocated block (ext4_da_should_update_i_disksize()
> -	 * check), we need to update i_disksize here as neither
> -	 * ext4_writepage() nor certain ext4_writepages() paths not
> -	 * allocating blocks update i_disksize.
> +	 * delalloc writes pending in the range upto i_size. There's no
> +	 * need to touch i_disksize since the endio of writeback will
> +	 * push i_disksize upto i_size eventually.
>  	 *
>  	 * Note that we defer inode dirtying to generic_write_end() /
>  	 * ext4_da_write_inline_data_end().
>  	 */
> -	new_i_size = pos + copied;
> -	if (copied && new_i_size > inode->i_size &&
> -	    ext4_da_should_update_i_disksize(page, end))
> -		ext4_update_i_disksize(inode, new_i_size);
>  
>  	return generic_write_end(file, mapping, pos, len, copied, page, fsdata);
>  }
> diff --git a/fs/ext4/page-io.c b/fs/ext4/page-io.c
> index 1e4db96a04e6..f893d26c4b88 100644
> --- a/fs/ext4/page-io.c
> +++ b/fs/ext4/page-io.c
> @@ -182,6 +182,10 @@ static int ext4_end_io_end(ext4_io_end_t *io_end)
>  		   "list->prev 0x%p\n",
>  		   io_end, inode->i_ino, io_end->list.next, io_end->list.prev);
>  
> +	/* Only reserved conversions from writeback should enter here */
> +	WARN_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
> +	WARN_ON(!io_end->handle && EXT4_SB(inode->i_sb)->s_journal);
> +
>  	io_end->handle = NULL;	/* Following call will use up the handle */
>  	ret = ext4_convert_unwritten_io_end_vec(handle, io_end);
>  	if (ret < 0 && !ext4_forced_shutdown(EXT4_SB(inode->i_sb))) {
> @@ -226,9 +230,6 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
>  	struct workqueue_struct *wq;
>  	unsigned long flags;
>  
> -	/* Only reserved conversions from writeback should enter here */
> -	WARN_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
> -	WARN_ON(!io_end->handle && sbi->s_journal);
>  	spin_lock_irqsave(&ei->i_completed_io_lock, flags);
>  	wq = sbi->rsv_conversion_wq;
>  	if (list_empty(&ei->i_rsv_conversion_list))
> @@ -237,6 +238,43 @@ static void ext4_add_complete_io(ext4_io_end_t *io_end)
>  	spin_unlock_irqrestore(&ei->i_completed_io_lock, flags);
>  }
>  
> +static int ext4_endio_update_disksize(ext4_io_end_t *io_end)
> +{
> +	int ret = 0;
> +	loff_t i_size, disksize = 0;
> +	handle_t *handle;
> +	struct ext4_io_end_vec *io_end_vec;
> +	struct inode *inode = io_end->inode;
> +	struct ext4_inode_info *ei = EXT4_I(inode);
> +
> +	list_for_each_entry(io_end_vec, &io_end->list_vec, list) {
> +		if (disksize < io_end_vec->offset + io_end_vec->size)
> +			disksize = io_end_vec->offset + io_end_vec->size;
> +	}
> +
> +	if (disksize > ei->i_disksize) {
> +		down_write(&ei->i_data_sem);
> +		i_size = inode->i_size;
> +		if (disksize > i_size)
> +			disksize = i_size;
> +		if (disksize > ei->i_disksize)
> +			WRITE_ONCE(ei->i_disksize, i_size);
> +		up_write(&ei->i_data_sem);
> +
> +		handle = ext4_journal_start(inode, EXT4_HT_INODE, 1);
> +		if (IS_ERR(handle))
> +			return PTR_ERR(handle);
> +
> +		ret = ext4_mark_inode_dirty(handle, inode);
> +		if (ret)
> +			ext4_error_err(inode->i_sb, ret, "Failed to mark inode %lu dirty",
> +				       inode->i_ino);
> +		ext4_journal_stop(handle);
> +	}
> +
> +	return ret;
> +}
> +
>  static int ext4_do_flush_completed_IO(struct inode *inode,
>  				      struct list_head *head)
>  {
> @@ -253,10 +291,16 @@ static int ext4_do_flush_completed_IO(struct inode *inode,
>  
>  	while (!list_empty(&unwritten)) {
>  		io_end = list_entry(unwritten.next, ext4_io_end_t, list);
> -		BUG_ON(!(io_end->flag & EXT4_IO_END_UNWRITTEN));
>  		list_del_init(&io_end->list);
>  
> -		err = ext4_end_io_end(io_end);
> +		err = ext4_endio_update_disksize(io_end);
> +		if (unlikely(!ret && err))
> +			ret = err;
> +
> +		if (io_end->flag & EXT4_IO_END_UNWRITTEN)
> +			err = ext4_end_io_end(io_end);
> +		else
> +			ext4_release_io_end(io_end);
>  		if (unlikely(!ret && err))
>  			ret = err;
>  	}
> @@ -264,7 +308,7 @@ static int ext4_do_flush_completed_IO(struct inode *inode,
>  }
>  
>  /*
> - * work on completed IO, to convert unwritten extents to extents
> + * work on completed IO, to convert unwritten extents to extents and update disksize
>   */
>  void ext4_end_io_rsv_work(struct work_struct *work)
>  {
> @@ -289,12 +333,10 @@ ext4_io_end_t *ext4_init_io_end(struct inode *inode, gfp_t flags)
>  void ext4_put_io_end_defer(ext4_io_end_t *io_end)
>  {
>  	if (refcount_dec_and_test(&io_end->count)) {
> -		if (!(io_end->flag & EXT4_IO_END_UNWRITTEN) ||
> -				list_empty(&io_end->list_vec)) {
> +		if (list_empty(&io_end->list_vec))
>  			ext4_release_io_end(io_end);
> -			return;
> -		}
> -		ext4_add_complete_io(io_end);
> +		else
> +			ext4_add_complete_io(io_end);
>  	}
>  }
>  
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
