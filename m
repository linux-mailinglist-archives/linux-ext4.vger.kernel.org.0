Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAAEE64CE8E
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Dec 2022 18:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239016AbiLNRBd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 14 Dec 2022 12:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239204AbiLNRBa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 14 Dec 2022 12:01:30 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38C9924967
        for <linux-ext4@vger.kernel.org>; Wed, 14 Dec 2022 09:01:27 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 94B4F21E08;
        Wed, 14 Dec 2022 17:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1671037286; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22S/fGzqW30IWGORbp8AUghRrhMDXErEhAhWU6h1KX4=;
        b=Wyeq7BF9883kk6ILzxrWEc721I7VM35lGs/i0SQGIZiw3pMoXZdFOhcJ3toX+mtpN+Fv7F
        f8xFFvuWe8Nde5ahEZ4ueUnOToDr/iB+1Xef6CgBDbkZIdWp6kUmd1xFnj9v9sMtw6KEkL
        ji5bm+103tkdjSNeyckXB6i+WvjVB9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1671037286;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=22S/fGzqW30IWGORbp8AUghRrhMDXErEhAhWU6h1KX4=;
        b=deKp7fupP/RIkMSMQlPlq+CJdezgI83Fr2konuWGFIlwQ+/bAvWL+cIWkC/f6aJFg42t6C
        vaEElyqNS9WbxcCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6B5361333E;
        Wed, 14 Dec 2022 17:01:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fEwsGmYBmmPrfgAAMHmgww
        (envelope-from <jack@suse.cz>); Wed, 14 Dec 2022 17:01:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 79754A0727; Wed, 14 Dec 2022 18:01:25 +0100 (CET)
Date:   Wed, 14 Dec 2022 18:01:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huawei.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huaweicloud.com,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH] ext4: dio take shared inode lock when overwriting
 preallocated blocks
Message-ID: <20221214170125.bixz46ybm76rtbzf@quack3>
References: <20221203103956.3691847-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221203103956.3691847-1-yi.zhang@huawei.com>
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 03-12-22 18:39:56, Zhang Yi wrote:
> In the dio write path, we only take shared inode lock for the case of
> aligned overwriting initialized blocks inside EOF. But for overwriting
> preallocated blocks, it may only need to split unwritten extents, this
> procedure has been protected under i_data_sem lock, it's safe to
> release the exclusive inode lock and take shared inode lock.
> 
> This could give a significant speed up for multi-threaded writes. Test
> on Intel Xeon Gold 6140 and nvme SSD with below fio parameters.
> 
>  direct=1
>  ioengine=libaio
>  iodepth=10
>  numjobs=10
>  runtime=60
>  rw=randwrite
>  size=100G
> 
> And the test result are:
> Before:
>  bs=4k       IOPS=11.1k, BW=43.2MiB/s
>  bs=16k      IOPS=11.1k, BW=173MiB/s
>  bs=64k      IOPS=11.2k, BW=697MiB/s
> 
> After:
>  bs=4k       IOPS=41.4k, BW=162MiB/s
>  bs=16k      IOPS=41.3k, BW=646MiB/s
>  bs=64k      IOPS=13.5k, BW=843MiB/s
> 
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
> ---
>  It passed xfstests auto mode with 1k and 4k blocksize.

Besides some naming nits (see below) I think this should work. But I have
to say I'm a bit uneasy about this because we will now be changing block
mapping from unwritten to written only with shared i_rwsem. OTOH that
happens during writeback as well so we should be fine and the gain is very
nice.

Out of curiosity do you have a real usecase for this?

>  fs/ext4/file.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index a7a597c727e6..7edac94025ac 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -202,8 +202,9 @@ ext4_extending_io(struct inode *inode, loff_t offset, size_t len)
>  	return false;
>  }
>  
> -/* Is IO overwriting allocated and initialized blocks? */
> -static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
> +/* Is IO overwriting allocated or initialized blocks? */
> +static bool ext4_overwrite_io(struct inode *inode,
> +			      loff_t pos, loff_t len, bool *inited)

'inited' just sounds weird. Correct is 'initialized' which is a bit long.
Maybe just negate the meaning and call this 'unwritten'?

>  {
>  	struct ext4_map_blocks map;
>  	unsigned int blkbits = inode->i_blkbits;
> @@ -217,12 +218,15 @@ static bool ext4_overwrite_io(struct inode *inode, loff_t pos, loff_t len)
>  	blklen = map.m_len;
>  
>  	err = ext4_map_blocks(NULL, inode, &map, 0);
> +	if (err != blklen)
> +		return false;
>  	/*
>  	 * 'err==len' means that all of the blocks have been preallocated,
> -	 * regardless of whether they have been initialized or not. To exclude
> -	 * unwritten extents, we need to check m_flags.
> +	 * regardless of whether they have been initialized or not. We need to
> +	 * check m_flags to distinguish the unwritten extents.
>  	 */
> -	return err == blklen && (map.m_flags & EXT4_MAP_MAPPED);
> +	*inited = !!(map.m_flags & EXT4_MAP_MAPPED);
> +	return true;
>  }
>  
>  static ssize_t ext4_generic_write_checks(struct kiocb *iocb,
> @@ -431,11 +435,16 @@ static const struct iomap_dio_ops ext4_dio_write_ops = {
>   * - For extending writes case we don't take the shared lock, since it requires
>   *   updating inode i_disksize and/or orphan handling with exclusive lock.
>   *
> - * - shared locking will only be true mostly with overwrites. Otherwise we will
> - *   switch to exclusive i_rwsem lock.
> + * - shared locking will only be true mostly with overwrites, include
> + *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
> + *   we protects splitting extents by i_data_sem in ext4_inode_info, so we can
> + *   also release exclusive i_rwsem lock.
> + *
> + * - Otherwise we will switch to exclusive i_rwsem lock.
>   */
>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
> -				     bool *ilock_shared, bool *extend)
> +				     bool *ilock_shared, bool *extend,
> +				     bool *overwrite)

And it would be good to preserve the argument name in other functions as
well - i.e., keep using 'unwritten' here as well.

>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
> @@ -459,7 +468,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  	 * in file_modified().
>  	 */
>  	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
> -	     !ext4_overwrite_io(inode, offset, count))) {
> +	     !ext4_overwrite_io(inode, offset, count, overwrite))) {
>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>  			ret = -EAGAIN;
>  			goto out;
> @@ -491,7 +500,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	loff_t offset = iocb->ki_pos;
>  	size_t count = iov_iter_count(from);
>  	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
> -	bool extend = false, unaligned_io = false;
> +	bool extend = false, unaligned_io = false, overwrite = false;
>  	bool ilock_shared = true;
>  
>  	/*
> @@ -534,7 +543,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		return ext4_buffered_write_iter(iocb, from);
>  	}
>  
> -	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend);
> +	ret = ext4_dio_write_checks(iocb, from,
> +				    &ilock_shared, &extend, &overwrite);
>  	if (ret <= 0)
>  		return ret;
>  
> @@ -582,7 +592,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ext4_journal_stop(handle);
>  	}
>  
> -	if (ilock_shared)
> +	if (overwrite)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
