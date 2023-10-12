Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6947C7160
	for <lists+linux-ext4@lfdr.de>; Thu, 12 Oct 2023 17:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379338AbjJLPZp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 12 Oct 2023 11:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbjJLPZn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 12 Oct 2023 11:25:43 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3B8CF
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 08:25:40 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-5859e22c7daso808738a12.1
        for <linux-ext4@vger.kernel.org>; Thu, 12 Oct 2023 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697124340; x=1697729140; darn=vger.kernel.org;
        h=in-reply-to:subject:cc:to:from:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Qe1isgQWXgdxEKBlAOlQSbBmPwNboMNMS5un+ykqyTM=;
        b=ly3BtmLKCkEUQojr7ivYEfsC3hOIzrknu+GQIaq2ofCqPIWpkIm0ql+/eYoxKlGQ87
         chkSF+8LsTe+w9Vr0mjfrRRbzopwveh56O475sG4QGtJ9P5abW4QIE3fAVHAoXFC5zsK
         66jDwZ69xrMidx35XWMR0vAQ4gRL5QKqsErMOMV5GYaXipX29WxofxqjbTdfQYUcvI4d
         GRv/s/YMiCokShRdBh1t5fmGehWq+dqGF5SXYoCqDVe66n6UmsV0QDPEk+fezzpCA2Ks
         0fXZ9nx1fmZkHQXDGVrZZ7Y1EjbKPXrIe8ygD9tu5I7fEzOAB2w+ghG+A67J2swgR0KY
         EYqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697124340; x=1697729140;
        h=in-reply-to:subject:cc:to:from:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qe1isgQWXgdxEKBlAOlQSbBmPwNboMNMS5un+ykqyTM=;
        b=M1ITfqMg4EaJdXSYVvKTZ8Yuq8Q/LKKePbDdmGmk7qH2jRIi6L4150MjUWZ/V5v2HH
         8BIEE59iE/BURFa0Rzo9ldmM+hbD25cu0r9v4nU7rOiLSIXdOA9onwg2PZ7ODEf0Tmdr
         Rw1xopnWLys8t4V4Lx9DDzd+nYUuPCvo8tb5CFRlfQSWZSqCMig9uRf7KQhXQYNYHwko
         XkpEoRGVfoqAEC86yvEVfHRJeSwMnmopkgth5LoN2Dy3d7yvY/jQKZ82FM81IjlyVzyl
         MQEQtNJExgjk9VtNVWon9Brm/h+vqQd1PJocsoeDCEn9FgcGiAto7nzlvdPc2axOICct
         OIqw==
X-Gm-Message-State: AOJu0YwrTC3OV03wIUtMHQzFbEcfd1NFTHDw3hhY/9kStfdmfj30p3Ie
        nWFxAoro+704sXyL9ToqgGxpMRN9cKg=
X-Google-Smtp-Source: AGHT+IFbP4GDbvsfPdlMj4G2ESrU4VixsEy10AAYHNl1TA2uUVZr+7TBADPArz2cg1otPGczLcB+Eg==
X-Received: by 2002:a17:90a:f68a:b0:27d:e18:810d with SMTP id cl10-20020a17090af68a00b0027d0e18810dmr4018323pjb.11.1697124340186;
        Thu, 12 Oct 2023 08:25:40 -0700 (PDT)
Received: from dw-tp ([2401:4900:1cc4:c403:d76d:9a77:e4fd:36be])
        by smtp.gmail.com with ESMTPSA id i5-20020a17090a2a0500b00277326038dasm2134357pjd.39.2023.10.12.08.25.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 08:25:39 -0700 (PDT)
Date:   Thu, 12 Oct 2023 20:55:29 +0530
Message-Id: <87il7bj21i.fsf@doe.com>
From:   Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org,
        Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] ext4: Properly sync file size update after O_SYNC direct IO
In-Reply-To: <20231011142155.19328-1-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Jan Kara <jack@suse.cz> writes:

> Gao Xiang has reported that on ext4 O_SYNC direct IO does not properly
> sync file size update and thus if we crash at unfortunate moment, the
> file can have smaller size although O_SYNC IO has reported successful
> completion. The problem happens because update of on-disk inode size is
> handled in ext4_dio_write_iter() *after* iomap_dio_rw() (and thus
> dio_complete() in particular) has returned and generic_file_sync() gets
> called by dio_complete(). Fix the problem by handling on-disk inode size
> update directly in our ->end_io completion handler.
>
> References: https://lore.kernel.org/all/02d18236-26ef-09b0-90ad-030c4fe3ee20@linux.alibaba.com
> Reported-by: Gao Xiang <hsiangkao@linux.alibaba.com>
> Signed-off-by: Jan Kara <jack@suse.cz>

Guess we need a fixes tag.

> ---
>  fs/ext4/file.c | 139 ++++++++++++++++++-------------------------------
>  1 file changed, 52 insertions(+), 87 deletions(-)
>
> So finally I've hopefully got all the corner cases right ;) At least fstest
> pass now.
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 1492b1ae21f4..d0711c1a9b06 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -306,80 +306,34 @@ static ssize_t ext4_buffered_write_iter(struct kiocb *iocb,
>  }
>  
>  static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
> -					   ssize_t written, size_t count)
> +					   ssize_t count)
>  {
>  	handle_t *handle;
> -	bool truncate = false;
> -	u8 blkbits = inode->i_blkbits;
> -	ext4_lblk_t written_blk, end_blk;
> -	int ret;
> -
> -	/*
> -	 * Note that EXT4_I(inode)->i_disksize can get extended up to
> -	 * inode->i_size while the I/O was running due to writeback of delalloc
> -	 * blocks. But, the code in ext4_iomap_alloc() is careful to use
> -	 * zeroed/unwritten extents if this is possible; thus we won't leave
> -	 * uninitialized blocks in a file even if we didn't succeed in writing
> -	 * as much as we intended.
> -	 */
> -	WARN_ON_ONCE(i_size_read(inode) < EXT4_I(inode)->i_disksize);
> -	if (offset + count <= EXT4_I(inode)->i_disksize) {
> -		/*
> -		 * We need to ensure that the inode is removed from the orphan
> -		 * list if it has been added prematurely, due to writeback of
> -		 * delalloc blocks.
> -		 */
> -		if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> -			handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> -
> -			if (IS_ERR(handle)) {
> -				ext4_orphan_del(NULL, inode);
> -				return PTR_ERR(handle);
> -			}
> -
> -			ext4_orphan_del(handle, inode);
> -			ext4_journal_stop(handle);
> -		}
> -
> -		return written;
> -	}
> -
> -	if (written < 0)
> -		goto truncate;
>  
> +	lockdep_assert_held_write(&inode->i_rwsem);
>  	handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
> -	if (IS_ERR(handle)) {
> -		written = PTR_ERR(handle);
> -		goto truncate;
> -	}
> +	if (IS_ERR(handle))
> +		return PTR_ERR(handle);
>  
> -	if (ext4_update_inode_size(inode, offset + written)) {
> -		ret = ext4_mark_inode_dirty(handle, inode);
> +	if (ext4_update_inode_size(inode, offset + count)) {
> +		int ret = ext4_mark_inode_dirty(handle, inode);
>  		if (unlikely(ret)) {
> -			written = ret;
>  			ext4_journal_stop(handle);
> -			goto truncate;
> +			return ret;
>  		}
>  	}
>  
> -	/*
> -	 * We may need to truncate allocated but not written blocks beyond EOF.
> -	 */
> -	written_blk = ALIGN(offset + written, 1 << blkbits);
> -	end_blk = ALIGN(offset + count, 1 << blkbits);
> -	if (written_blk < end_blk && ext4_can_truncate(inode))
> -		truncate = true;
> -
> -	/*
> -	 * Remove the inode from the orphan list if it has been extended and
> -	 * everything went OK.
> -	 */
> -	if (!truncate && inode->i_nlink)
> +	if (inode->i_nlink)
>  		ext4_orphan_del(handle, inode);
>  	ext4_journal_stop(handle);
>  
> -	if (truncate) {
> -truncate:
> +	return count;
> +}
> +
> +static void ext4_inode_extension_cleanup(struct inode *inode, ssize_t count)
> +{
> +	lockdep_assert_held_write(&inode->i_rwsem);
> +	if (count < 0) {
>  		ext4_truncate_failed_write(inode);
>  		/*
>  		 * If the truncate operation failed early, then the inode may
> @@ -388,9 +342,28 @@ static ssize_t ext4_handle_inode_extension(struct inode *inode, loff_t offset,
>  		 */
>  		if (inode->i_nlink)
>  			ext4_orphan_del(NULL, inode);
> +		return;
>  	}
> +	/*
> +	 * If i_disksize got extended due to writeback of delalloc blocks while
> +	 * the DIO was running we could fail to cleanup the orphan list in
> +	 * ext4_handle_inode_extension(). Do it now.
> +	 */
> +	if (!list_empty(&EXT4_I(inode)->i_orphan) && inode->i_nlink) {
> +		handle_t *handle = ext4_journal_start(inode, EXT4_HT_INODE, 2);
>  
> -	return written;
> +		if (IS_ERR(handle)) {
> +			/*
> +			 * The write has successfully completed. Not much to
> +			 * do with the error here so just cleanup the orphan
> +			 * list and hope for the best.
> +			 */
> +			ext4_orphan_del(NULL, inode);
> +			return;
> +		}
> +		ext4_orphan_del(handle, inode);
> +		ext4_journal_stop(handle);
> +	}
>  }
>  
>  static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
> @@ -399,31 +372,22 @@ static int ext4_dio_write_end_io(struct kiocb *iocb, ssize_t size,
>  	loff_t pos = iocb->ki_pos;
>  	struct inode *inode = file_inode(iocb->ki_filp);
>  
> +	if (!error && size && flags & IOMAP_DIO_END_UNWRITTEN)

Do we have IOMAP_DIO_END_UNWRITTEN? or should it be IOMAP_DIO_UNWRITTEN?
Also we don't need to check !error case if we return early in case of an error.

> +		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
>  	if (error)
>  		return error;
> -
> -	if (size && flags & IOMAP_DIO_END_UNWRITTEN) {

ditto.

> -		error = ext4_convert_unwritten_extents(NULL, inode, pos, size);
> -		if (error < 0)
> -			return error;
> -	}
>  	/*
> -	 * If we are extending the file, we have to update i_size here before
> -	 * page cache gets invalidated in iomap_dio_rw(). Otherwise racing
> -	 * buffered reads could zero out too much from page cache pages. Update
> -	 * of on-disk size will happen later in ext4_dio_write_iter() where
> -	 * we have enough information to also perform orphan list handling etc.
> -	 * Note that we perform all extending writes synchronously under
> -	 * i_rwsem held exclusively so i_size update is safe here in that case.
> -	 * If the write was not extending, we cannot see pos > i_size here
> -	 * because operations reducing i_size like truncate wait for all
> -	 * outstanding DIO before updating i_size.
> +	 * Note that EXT4_I(inode)->i_disksize can get extended up to
> +	 * inode->i_size while the I/O was running due to writeback of delalloc
> +	 * blocks. But the code in ext4_iomap_alloc() is careful to use
> +	 * zeroed/unwritten extents if this is possible; thus we won't leave
> +	 * uninitialized blocks in a file even if we didn't succeed in writing
> +	 * as much as we intended.
>  	 */
> -	pos += size;
> -	if (pos > i_size_read(inode))
> -		i_size_write(inode, pos);
> -
> -	return 0;
> +	WARN_ON_ONCE(i_size_read(inode) < READ_ONCE(EXT4_I(inode)->i_disksize));
> +	if (pos + size <= READ_ONCE(EXT4_I(inode)->i_disksize))
> +		return 0;
> +	return ext4_handle_inode_extension(inode, pos, size);
>  }

Although it is not a problem, but we are sometimes returning 0 and
sometimes count here.

>  
>  static const struct iomap_dio_ops ext4_dio_write_ops = {
> @@ -606,9 +570,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  			   dio_flags, NULL, 0);
>  	if (ret == -ENOTBLK)
>  		ret = 0;
> -
>  	if (extend)
> -		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> +		ext4_inode_extension_cleanup(inode, ret);
>  
>  out:
>  	if (ilock_shared)
> @@ -689,8 +652,10 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  
>  	ret = dax_iomap_rw(iocb, from, &ext4_iomap_ops);
>  
> -	if (extend)
> -		ret = ext4_handle_inode_extension(inode, offset, ret, count);
> +	if (extend) {
> +		ret = ext4_handle_inode_extension(inode, offset, ret);
> +		ext4_inode_extension_cleanup(inode, ret);

ok, looks like we are using that return value here.

> +	}
>  out:
>  	inode_unlock(inode);
>  	if (ret > 0)
> -- 
> 2.35.3

Otherwise it looks good to me.

-ritesh
