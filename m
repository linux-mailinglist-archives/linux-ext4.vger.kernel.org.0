Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 369273B836D
	for <lists+linux-ext4@lfdr.de>; Wed, 30 Jun 2021 15:46:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234961AbhF3NtW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 30 Jun 2021 09:49:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234877AbhF3NtV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625060812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JdGTR+O2z4+aEqMiqnp7ojJegc31cT+QFRVOOJo4xoI=;
        b=My/ujL4BIc9qMIKE/Il511c13CFSDZrtnr0GmH6gKW9aaqWHAz568eO1L2TpIOJ/vH9GF7
        ap8SJE8NFAWkEBPilhECHLZEANV6qSDfn9dJ8UjcF39ocNWghCVoyShovXGO2/0WjLBBVg
        inKlffIVtGMVaFqyZ22+IOxu7vO98cM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-8-_tLhQ-T9N2iLPKp7WXibDA-1; Wed, 30 Jun 2021 09:46:41 -0400
X-MC-Unique: _tLhQ-T9N2iLPKp7WXibDA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 74A3B1812640;
        Wed, 30 Jun 2021 13:46:40 +0000 (UTC)
Received: from work (unknown [10.40.193.220])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 6697C5DA2D;
        Wed, 30 Jun 2021 13:46:39 +0000 (UTC)
Date:   Wed, 30 Jun 2021 15:46:35 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 4/4] ext4: Improve scalability of ext4 orphan file
 handling
Message-ID: <20210630134635.fcdlsase45iotavs@work>
References: <20210616105655.5129-1-jack@suse.cz>
 <20210616105655.5129-5-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210616105655.5129-5-jack@suse.cz>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 16, 2021 at 12:56:55PM +0200, Jan Kara wrote:
> Even though the length of the critical section when adding / removing
> orphaned inodes was significantly reduced by using orphan file, the
> contention of lock protecting orphan file still appears high in profiles
> for truncate / unlink intensive workloads with high number of threads.
> 
> This patch makes handling of orphan file completely lockless. Also to
> reduce conflicts between CPUs different CPUs start searching for empty
> slot in orphan file in different blocks.
> 
> Performance comparison of locked orphan file handling, lockless orphan
> file handling, and completely disabled orphan inode handling
> from 80 CPU Xeon Server with 526 GB of RAM, filesystem located on
> SAS SSD disk, average of 5 runs:
> 
> stress-orphan (microbenchmark truncating files byte-by-byte from N
> processes in parallel)
> 
> Threads Time            Time            Time
>         Orphan locked   Orphan lockless No orphan
>   1       0.945600       0.939400        0.891200
>   2       1.331800       1.246600        1.174400
>   4       1.995000       1.780600        1.713200
>   8       6.424200       4.900000        4.106000
>  16      14.937600       8.516400        8.138000
>  32      33.038200      24.565600       24.002200
>  64      60.823600      39.844600       38.440200
> 128     122.941400      70.950400       69.315000
> 
> So we can see that with lockless orphan file handling, addition /
> deletion of orphaned inodes got almost completely out of picture even
> for a microbenchmark stressing it.
> 
> For reaim creat_clo workload on ramdisk there are also noticeable gains
> (average of 5 runs):
> 
> Clients         Vanilla (ops/s)        Patched (ops/s)
> creat_clo-1     14705.88 (   0.00%)    14354.07 *  -2.39%*
> creat_clo-3     27108.43 (   0.00%)    28301.89 (   4.40%)
> creat_clo-5     37406.48 (   0.00%)    45180.73 *  20.78%*
> creat_clo-7     41338.58 (   0.00%)    54687.50 *  32.29%*
> creat_clo-9     45226.13 (   0.00%)    62937.07 *  39.16%*
> creat_clo-11    44000.00 (   0.00%)    65088.76 *  47.93%*
> creat_clo-13    36516.85 (   0.00%)    68661.97 *  88.03%*
> creat_clo-15    30864.20 (   0.00%)    69551.78 * 125.35%*
> creat_clo-17    27478.45 (   0.00%)    67729.08 * 146.48%*
> creat_clo-19    25000.00 (   0.00%)    61621.62 * 146.49%*
> creat_clo-21    18772.35 (   0.00%)    63829.79 * 240.02%*
> creat_clo-23    16698.94 (   0.00%)    61938.96 * 270.92%*
> creat_clo-25    14973.05 (   0.00%)    56947.61 * 280.33%*
> creat_clo-27    16436.69 (   0.00%)    65008.03 * 295.51%*
> creat_clo-29    13949.01 (   0.00%)    69047.62 * 395.00%*
> creat_clo-31    14283.52 (   0.00%)    67982.45 * 375.95%*
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/ext4.h   |  3 +--
>  fs/ext4/orphan.c | 55 +++++++++++++++++++++++++++---------------------
>  2 files changed, 32 insertions(+), 26 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index 83298c0b6dae..d08927e19b76 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -1480,7 +1480,7 @@ static inline int ext4_inodes_per_orphan_block(struct super_block *sb)
>  }
>  
>  struct ext4_orphan_block {
> -	int ob_free_entries;	/* Number of free orphan entries in block */
> +	atomic_t ob_free_entries;	/* Number of free orphan entries in block */
>  	struct buffer_head *ob_bh;	/* Buffer for orphan block */
>  };
>  
> @@ -1488,7 +1488,6 @@ struct ext4_orphan_block {
>   * Info about orphan file.
>   */
>  struct ext4_orphan_info {
> -	spinlock_t of_lock;
>  	int of_blocks;			/* Number of orphan blocks in a file */
>  	__u32 of_csum_seed;		/* Checksum seed for orphan file */
>  	struct ext4_orphan_block *of_binfo;	/* Array with info about orphan
> diff --git a/fs/ext4/orphan.c b/fs/ext4/orphan.c
> index ac22667b7fd5..010222cde4f7 100644
> --- a/fs/ext4/orphan.c
> +++ b/fs/ext4/orphan.c
> @@ -10,16 +10,30 @@
>  
>  static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
>  {
> -	int i, j;
> +	int i, j, start;
>  	struct ext4_orphan_info *oi = &EXT4_SB(inode->i_sb)->s_orphan_info;
>  	int ret = 0;
> +	bool found = false;
>  	__le32 *bdata;
>  	int inodes_per_ob = ext4_inodes_per_orphan_block(inode->i_sb);
>  
> -	spin_lock(&oi->of_lock);
> -	for (i = 0; i < oi->of_blocks && !oi->of_binfo[i].ob_free_entries; i++);
> -	if (i == oi->of_blocks) {
> -		spin_unlock(&oi->of_lock);
> +	/*
> +	 * Find block with free orphan entry. Use CPU number for a naive hash
> +	 * for a search start in the orphan file
> +	 */
> +	start = raw_smp_processor_id()*13 % oi->of_blocks;
> +	i = start;
> +	do {
> +		if (atomic_dec_if_positive(&oi->of_binfo[i].ob_free_entries)
> +		    >= 0) {
> +			found = true;
> +			break;
> +		}
> +		if (++i >= oi->of_blocks)
> +			i = 0;
> +	} while (i != start);
> +
> +	if (!found) {
>  		/*
>  		 * For now we don't grow or shrink orphan file. We just use
>  		 * whatever was allocated at mke2fs time. The additional
> @@ -28,28 +42,24 @@ static int ext4_orphan_file_add(handle_t *handle, struct inode *inode)
>  		 */
>  		return -ENOSPC;
>  	}
> -	oi->of_binfo[i].ob_free_entries--;
> -	spin_unlock(&oi->of_lock);
>  
> -	/*
> -	 * Get access to orphan block. We have dropped of_lock but since we
> -	 * have decremented number of free entries we are guaranteed free entry
> -	 * in our block.
> -	 */
>  	ret = ext4_journal_get_write_access(handle, inode->i_sb,
>  				oi->of_binfo[i].ob_bh, EXT4_JTR_ORPHAN_FILE);
>  	if (ret)
>  		return ret;
>  
>  	bdata = (__le32 *)(oi->of_binfo[i].ob_bh->b_data);
> -	spin_lock(&oi->of_lock);
>  	/* Find empty slot in a block */
> -	for (j = 0; j < inodes_per_ob && bdata[j]; j++);
> -	BUG_ON(j == inodes_per_ob);
> -	bdata[j] = cpu_to_le32(inode->i_ino);
> +	j = 0;
> +	do {
> +		while (bdata[j]) {
> +			if (++j >= inodes_per_ob)
> +				j = 0;
> +		}
> +	} while (cmpxchg(&bdata[j], 0, cpu_to_le32(inode->i_ino)) != 0);

In case there is any sort of corruption on disk or in memory we can
potentially get stuck here forever right ? Not sure if that matters
all that much.

Other than that it looks good and negates some of my comments on the
previous patch, sorry about that ;)

You can add

Reviewed-by: Lukas Czerner <lczerner@redhat.com>


> +
>  	EXT4_I(inode)->i_orphan_idx = i * inodes_per_ob + j;
>  	ext4_set_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
> -	spin_unlock(&oi->of_lock);
>  
>  	return ext4_handle_dirty_metadata(handle, NULL, oi->of_binfo[i].ob_bh);
>  }
> @@ -178,10 +188,8 @@ static int ext4_orphan_file_del(handle_t *handle, struct inode *inode)
>  		goto out;
>  
>  	bdata = (__le32 *)(oi->of_binfo[blk].ob_bh->b_data);
> -	spin_lock(&oi->of_lock);
>  	bdata[off] = 0;
> -	oi->of_binfo[blk].ob_free_entries++;
> -	spin_unlock(&oi->of_lock);
> +	atomic_inc(&oi->of_binfo[blk].ob_free_entries);
>  	ret = ext4_handle_dirty_metadata(handle, NULL, oi->of_binfo[blk].ob_bh);
>  out:
>  	ext4_clear_inode_state(inode, EXT4_STATE_ORPHAN_FILE);
> @@ -534,8 +542,6 @@ int ext4_init_orphan_info(struct super_block *sb)
>  	struct ext4_orphan_block_tail *ot;
>  	ino_t orphan_ino = le32_to_cpu(EXT4_SB(sb)->s_es->s_orphan_file_inum);
>  
> -	spin_lock_init(&oi->of_lock);
> -
>  	if (!ext4_has_feature_orphan_file(sb))
>  		return 0;
>  
> @@ -579,7 +585,7 @@ int ext4_init_orphan_info(struct super_block *sb)
>  		for (j = 0; j < inodes_per_ob; j++)
>  			if (bdata[j] == 0)
>  				free++;
> -		oi->of_binfo[i].ob_free_entries = free;
> +		atomic_set(&oi->of_binfo[i].ob_free_entries, free);
>  	}
>  	iput(inode);
>  	return 0;
> @@ -601,7 +607,8 @@ int ext4_orphan_file_empty(struct super_block *sb)
>  	if (!ext4_has_feature_orphan_file(sb))
>  		return 1;
>  	for (i = 0; i < oi->of_blocks; i++)
> -		if (oi->of_binfo[i].ob_free_entries != inodes_per_ob)
> +		if (atomic_read(&oi->of_binfo[i].ob_free_entries) !=
> +		    inodes_per_ob)
>  			return 0;
>  	return 1;
>  }
> -- 
> 2.26.2
> 

