Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D51C65B335
	for <lists+linux-ext4@lfdr.de>; Mon,  2 Jan 2023 15:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229864AbjABOJV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 2 Jan 2023 09:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjABOJT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 2 Jan 2023 09:09:19 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F4B16586
        for <linux-ext4@vger.kernel.org>; Mon,  2 Jan 2023 06:09:18 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 389AF33F44;
        Mon,  2 Jan 2023 14:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1672668557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zrjhpu6n6gtUv2G+Uj5tge+mN5658kFaQm7IM8lLk7Y=;
        b=iGa4d8ODRtxtTyJ50bvMQztYya44SkJldnCA14YNwVxZlVC/M4fiK/sf/7mwLVlY+8edgA
        TAlzZCK2/6trdyACVC9bX3WRIKzfEwFhqmYVXUaYxNkxXgsYB1X7qkBuwsfiypxkGzVHk2
        jZ+S0ULsxC8ZVulHkqr6pvEqaidDBso=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1672668557;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Zrjhpu6n6gtUv2G+Uj5tge+mN5658kFaQm7IM8lLk7Y=;
        b=m7L/ci46RXznQaso6uLdY8Wrhs427BRfh0eYfP7sf0fAAimMRglGgfW8N6zafscRK9bzzJ
        ZsOb/LHhcffZuPCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 292E8139C8;
        Mon,  2 Jan 2023 14:09:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Eh0ECo3lsmMXQgAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 02 Jan 2023 14:09:17 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id A8075A073E; Mon,  2 Jan 2023 15:09:16 +0100 (CET)
Date:   Mon, 2 Jan 2023 15:09:16 +0100
From:   Jan Kara <jack@suse.cz>
To:     Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu,
        adilger.kernel@dilger.ca, jack@suse.cz, yi.zhang@huawei.com,
        yukuai3@huawei.com
Subject: Re: [RFC PATCH v2] ext4: dio take shared inode lock when overwriting
 preallocated blocks
Message-ID: <20230102140916.mjp6cwzmv5vf5y3r@quack3>
References: <20221226062015.3479416-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221226062015.3479416-1-yi.zhang@huaweicloud.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 26-12-22 14:20:15, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
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

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
> v2->v1:
>  - Negate the 'inited' related arguments to 'unwritten'.
> 
>  fs/ext4/file.c | 34 ++++++++++++++++++++++------------
>  1 file changed, 22 insertions(+), 12 deletions(-)
> 
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index a7a597c727e6..21abe95a0ee7 100644
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
> +			      loff_t pos, loff_t len, bool *unwritten)
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
> +	*unwritten = !(map.m_flags & EXT4_MAP_MAPPED);
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
> + * - shared locking will only be true mostly with overwrites, including
> + *   initialized blocks and unwritten blocks. For overwrite unwritten blocks
> + *   we protect splitting extents by i_data_sem in ext4_inode_info, so we can
> + *   also release exclusive i_rwsem lock.
> + *
> + * - Otherwise we will switch to exclusive i_rwsem lock.
>   */
>  static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
> -				     bool *ilock_shared, bool *extend)
> +				     bool *ilock_shared, bool *extend,
> +				     bool *unwritten)
>  {
>  	struct file *file = iocb->ki_filp;
>  	struct inode *inode = file_inode(file);
> @@ -459,7 +468,7 @@ static ssize_t ext4_dio_write_checks(struct kiocb *iocb, struct iov_iter *from,
>  	 * in file_modified().
>  	 */
>  	if (*ilock_shared && (!IS_NOSEC(inode) || *extend ||
> -	     !ext4_overwrite_io(inode, offset, count))) {
> +	     !ext4_overwrite_io(inode, offset, count, unwritten))) {
>  		if (iocb->ki_flags & IOCB_NOWAIT) {
>  			ret = -EAGAIN;
>  			goto out;
> @@ -491,7 +500,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  	loff_t offset = iocb->ki_pos;
>  	size_t count = iov_iter_count(from);
>  	const struct iomap_ops *iomap_ops = &ext4_iomap_ops;
> -	bool extend = false, unaligned_io = false;
> +	bool extend = false, unaligned_io = false, unwritten = false;
>  	bool ilock_shared = true;
>  
>  	/*
> @@ -534,7 +543,8 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		return ext4_buffered_write_iter(iocb, from);
>  	}
>  
> -	ret = ext4_dio_write_checks(iocb, from, &ilock_shared, &extend);
> +	ret = ext4_dio_write_checks(iocb, from,
> +				    &ilock_shared, &extend, &unwritten);
>  	if (ret <= 0)
>  		return ret;
>  
> @@ -582,7 +592,7 @@ static ssize_t ext4_dio_write_iter(struct kiocb *iocb, struct iov_iter *from)
>  		ext4_journal_stop(handle);
>  	}
>  
> -	if (ilock_shared)
> +	if (ilock_shared && !unwritten)
>  		iomap_ops = &ext4_iomap_overwrite_ops;
>  	ret = iomap_dio_rw(iocb, from, iomap_ops, &ext4_dio_write_ops,
>  			   (unaligned_io || extend) ? IOMAP_DIO_FORCE_WAIT : 0,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
