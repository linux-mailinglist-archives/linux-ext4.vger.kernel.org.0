Return-Path: <linux-ext4+bounces-7010-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0558DA75058
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 19:25:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C2AE16E035
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 18:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C68E11DF72F;
	Fri, 28 Mar 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rNm0kMSJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69A4314A0BC
	for <linux-ext4@vger.kernel.org>; Fri, 28 Mar 2025 18:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743186280; cv=none; b=bHxhebJDlvQGj3s+2+cwSQAK0u2NflAG9S4pAmPsf8Jop6ZBiFRjweISHM2zXQM/zOXi/wFntAdOzWKJcWknGDy2VdZ6H1rKUCzesKV88muFXW4JAC9rIuE5n9tSNFNVX5NkevrmtVTzDKyL+yWRlO3mtlLw5iJ7uL/n6f/tL5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743186280; c=relaxed/simple;
	bh=Qfbxz/lfahvhATjzEDkFWFnXLu6AQi5uItAsXBxrKtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QvmW6uitAz8M9d2GdSyvMupKuc2y8S4+ZD+N65rCSv9vPacq4CvA+HeBIxFAqKsmOZ+llrSe5WA/YH5z8XqhSn0k3zf+pCRv/GbYLsRBogDNLWbdD+QsuFOsoeVF0PWZXRsu/TYlVLCtZs1zK9kJ+8qMX1kvNXL18C19rnLGJlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rNm0kMSJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D04ACC4CEE4;
	Fri, 28 Mar 2025 18:24:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743186279;
	bh=Qfbxz/lfahvhATjzEDkFWFnXLu6AQi5uItAsXBxrKtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rNm0kMSJshNUvpgFi4JeNW4RNt0FuGgFLPeypiEobI0vTZ0IMfFGKJjwrVYpP+Kvn
	 4QeazIQDVmrqZGiXaHzr4OeWIPHDgf4XnmZYLLTB3jLLqaje7dMMKOwORXarksY3K6
	 uYtd3n0gtoCW1iEpNcmK2/UZCQd0pYdgsIZ4qjYyO2VQFZLXKQ5pNGo4VzYmHZiEUB
	 LJylpJ0k0U3sTd7w1FzZkVaKdWHEhm2vwPlgC26jxsMS7okCpUFH7aUqXIzd9/dKkV
	 5Zj89MW6SH4RwngsnAADD3tHATps2cRuJrcspDDRLnL0DmyTytPkVESBVTT1kYfHoq
	 FtoOhR2H0qkaQ==
Date: Fri, 28 Mar 2025 11:24:39 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Catherine Hoang <catherine.hoang@oracle.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] ext2: remove buffer heads from superblock
Message-ID: <20250328182439.GD2803723@frogsfrogsfrogs>
References: <20250326014928.61507-1-catherine.hoang@oracle.com>
 <20250326014928.61507-2-catherine.hoang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250326014928.61507-2-catherine.hoang@oracle.com>

On Tue, Mar 25, 2025 at 06:49:25PM -0700, Catherine Hoang wrote:
> The superblock is stored in the buffer_head s_sbh in struct ext2_sb_info.
> Replace this buffer head with the new ext2_buffer and update the buffer
> functions accordingly. This patch also introduces new buffer cache code
> needed for future patches.
> 
> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> ---
>  fs/ext2/Makefile |   2 +-
>  fs/ext2/cache.c  | 302 +++++++++++++++++++++++++++++++++++++++++++++++
>  fs/ext2/ext2.h   |  43 ++++++-
>  fs/ext2/super.c  |  52 +++++---
>  fs/ext2/xattr.c  |   2 +-
>  5 files changed, 379 insertions(+), 22 deletions(-)
>  create mode 100644 fs/ext2/cache.c
> 
> diff --git a/fs/ext2/Makefile b/fs/ext2/Makefile
> index 8860948ef9ca..e8b38243058f 100644
> --- a/fs/ext2/Makefile
> +++ b/fs/ext2/Makefile
> @@ -5,7 +5,7 @@
>  
>  obj-$(CONFIG_EXT2_FS) += ext2.o
>  
> -ext2-y := balloc.o dir.o file.o ialloc.o inode.o \
> +ext2-y := balloc.o cache.o dir.o file.o ialloc.o inode.o \
>  	  ioctl.o namei.o super.o symlink.o trace.o
>  
>  # For tracepoints to include our trace.h from tracepoint infrastructure
> diff --git a/fs/ext2/cache.c b/fs/ext2/cache.c
> new file mode 100644
> index 000000000000..464c506ba1b6
> --- /dev/null
> +++ b/fs/ext2/cache.c
> @@ -0,0 +1,302 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2025 Oracle. All rights reserved.
> + */
> +
> +#include "ext2.h"
> +#include <linux/bio.h>
> +#include <linux/blkdev.h>
> +#include <linux/rhashtable.h>
> +#include <linux/mm.h>
> +#include <linux/types.h>
> +
> +static const struct rhashtable_params buffer_cache_params = {
> +	.key_len     = sizeof(sector_t),
> +	.key_offset  = offsetof(struct ext2_buffer, b_block),
> +	.head_offset = offsetof(struct ext2_buffer, b_rhash),
> +	.automatic_shrinking = true,
> +};
> +
> +void ext2_buffer_lock(struct ext2_buffer *buf)
> +{
> +	mutex_lock(&buf->b_lock);
> +}
> +
> +void ext2_buffer_unlock(struct ext2_buffer *buf)
> +{
> +	mutex_unlock(&buf->b_lock);
> +}
> +
> +void ext2_buffer_set_dirty(struct ext2_buffer *buf)
> +{
> +    set_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags);
> +}
> +
> +static int ext2_buffer_uptodate(struct ext2_buffer *buf)
> +{
> +    return test_bit(EXT2_BUF_UPTODATE_BIT, &buf->b_flags);
> +}
> +
> +void ext2_buffer_set_uptodate(struct ext2_buffer *buf)
> +{
> +    set_bit(EXT2_BUF_UPTODATE_BIT, &buf->b_flags);
> +}
> +
> +void ext2_buffer_clear_uptodate(struct ext2_buffer *buf)
> +{
> +    clear_bit(EXT2_BUF_UPTODATE_BIT, &buf->b_flags);
> +}
> +
> +int ext2_buffer_error(struct ext2_buffer *buf)
> +{
> +       return buf->b_error;
> +}
> +
> +void ext2_buffer_clear_error(struct ext2_buffer *buf)
> +{
> +       buf->b_error = 0;
> +}

Indenting errors in these previous two functions.

> +static struct ext2_buffer *ext2_insert_buffer_cache(struct super_block *sb, struct ext2_buffer *new_buf)
> +{
> +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> +	struct ext2_buffer_cache *bc = &sbi->s_buffer_cache;
> +	struct rhashtable *buffer_cache = &bc->bc_hash;
> +	struct ext2_buffer *old_buf;
> +
> +	rcu_read_lock();
> +	old_buf = rhashtable_lookup_get_insert_fast(buffer_cache,
> +				&new_buf->b_rhash, buffer_cache_params);
> +
> +	if (old_buf) {
> +		refcount_inc(&old_buf->b_refcount);
> +		rcu_read_unlock();
> +		return old_buf;
> +	}
> +
> +	refcount_inc(&new_buf->b_refcount);

I think the b_refcount model is clearer this time around -- buffers are
created with refcount==1, the cache owns that refcount when it's added
to the rhashtable, and cache users get their own refcount.
sync_buffers* takes its own refcount while writes are in progress.

(Can this please be captured in the design documentation, please?)

> +	rcu_read_unlock();
> +	return new_buf;
> +}
> +
> +static void ext2_buf_write_end_io(struct bio *bio)
> +{
> +	struct ext2_buffer *buf = bio->bi_private;
> +	int err = blk_status_to_errno(bio->bi_status);
> +
> +	buf->b_error = err;

buf->b_error = blk_status_to_errno(bio->bi_status);

> +	complete(&buf->b_complete);
> +	mutex_unlock(&buf->b_lock);
> +	bio_put(bio);
> +}
> +
> +static int ext2_submit_buffer_read(struct super_block *sb, struct ext2_buffer *buf)
> +{
> +	struct bio_vec bio_vec;
> +	struct bio bio;
> +	sector_t sector = buf->b_block * (sb->s_blocksize >> 9);
> +	int error;
> +
> +	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
> +	bio.bi_iter.bi_sector = sector;
> +
> +	buf->b_size = sb->s_blocksize;
> +	__bio_add_page(&bio, buf->b_page, buf->b_size, 0);
> +
> +	mutex_lock(&buf->b_lock);
> +	error = submit_bio_wait(&bio);
> +	ext2_buffer_set_uptodate(buf);
> +	mutex_unlock(&buf->b_lock);

Hmm.  So the cache itself holds b_lock whenever IO is in progress, and
the quota code locks the buffer whenever it's copying dquot data into
the ext2_buffer.  That makes sense, we want to avoid sync_buffer* racing
with something that's writing to b_data.  But why doesn't the existing
code do that for group descriptor or superblock bufferheads?

I think we don't need to lock the ext2_buffer to read its contents
because the get/read functions always return to us an uptodate buffer.

> +
> +	return error;
> +}
> +
> +static void ext2_submit_buffer_write(struct super_block *sb, struct ext2_buffer *buf)
> +{
> +	struct bio *bio;
> +	sector_t sector = buf->b_block * (sb->s_blocksize >> 9);
> +
> +	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_WRITE, GFP_KERNEL);
> +
> +	bio->bi_iter.bi_sector = sector;
> +	bio->bi_end_io = ext2_buf_write_end_io;
> +	bio->bi_private = buf;
> +
> +	__bio_add_page(bio, buf->b_page, buf->b_size, 0);
> +
> +	mutex_lock(&buf->b_lock);
> +	submit_bio(bio);
> +}
> +
> +static int ext2_sync_buffer_cache_wait(struct list_head *submit_list)
> +{
> +	struct ext2_buffer *buf, *n;
> +	int error = 0, error2;
> +
> +	list_for_each_entry_safe(buf, n, submit_list, b_list) {
> +		wait_for_completion(&buf->b_complete);
> +		refcount_dec(&buf->b_refcount);
> +		error2 = buf->b_error;
> +		if (!error)
> +			error = error2;
> +	}
> +
> +	return error;
> +}
> +
> +int ext2_sync_buffer_wait(struct super_block *sb, struct ext2_buffer *buf)
> +{
> +	if (test_and_clear_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags)) {
> +		ext2_submit_buffer_write(sb, buf);
> +		wait_for_completion(&buf->b_complete);
> +		return buf->b_error;
> +	}
> +
> +	return 0;
> +}
> +
> +int ext2_sync_buffer_cache(struct super_block *sb)
> +{
> +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> +	struct ext2_buffer_cache *bc = &sbi->s_buffer_cache;
> +	struct rhashtable *buffer_cache = &bc->bc_hash;
> +	struct rhashtable_iter iter;
> +	struct ext2_buffer *buf, *n;
> +	struct blk_plug plug;
> +	LIST_HEAD(submit_list);
> +
> +	rhashtable_walk_enter(buffer_cache, &iter);
> +	rhashtable_walk_start(&iter);
> +	while ((buf = rhashtable_walk_next(&iter)) != NULL) {
> +		if (IS_ERR(buf))
> +			continue;
> +		if (test_and_clear_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags)) {
> +			refcount_inc(&buf->b_refcount);
> +			list_add(&buf->b_list, &submit_list);
> +		}
> +	}
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);
> +
> +	blk_start_plug(&plug);
> +	list_for_each_entry_safe(buf, n, &submit_list, b_list) {
> +		ext2_submit_buffer_write(sb, buf);
> +	}
> +	blk_finish_plug(&plug);
> +
> +	return ext2_sync_buffer_cache_wait(&submit_list);
> +}
> +
> +static struct ext2_buffer *ext2_lookup_buffer_cache(struct super_block *sb, sector_t block)
> +{
> +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> +	struct ext2_buffer_cache *bc = &sbi->s_buffer_cache;
> +	struct rhashtable *buffer_cache = &bc->bc_hash;
> +	struct ext2_buffer *found = NULL;
> +
> +	rcu_read_lock();
> +	found = rhashtable_lookup(buffer_cache, &block, buffer_cache_params);
> +	if (found && !refcount_inc_not_zero(&found->b_refcount))
> +		found = NULL;
> +	rcu_read_unlock();
> +
> +	return found;
> +}
> +
> +static struct ext2_buffer *ext2_init_buffer(struct super_block *sb, sector_t block, bool need_uptodate)
> +{
> +	struct ext2_buffer *buf;
> +	gfp_t gfp = GFP_KERNEL;
> +
> +	buf = kmalloc(sizeof(struct ext2_buffer), GFP_KERNEL);
> +	if (!buf)
> +		return NULL;
> +
> +	buf->b_block = block;
> +	buf->b_size = sb->s_blocksize;
> +	buf->b_flags = 0;
> +	buf->b_error = 0;
> +
> +	mutex_init(&buf->b_lock);
> +	refcount_set(&buf->b_refcount, 1);
> +	init_completion(&buf->b_complete);
> +
> +	if (!need_uptodate)
> +		gfp |= __GFP_ZERO;

Should this set uptodate if the allocation actually zeroed the buffer?

> +
> +	buf->b_page = alloc_page(gfp);

Note: This could be trimmed to slab allocations for blocksize < pagesize
filesystems; and folio_alloc for pagesize > blocksize allocations, like
hch's recent xfs_buf changes.

> +static struct ext2_buffer *ext2_find_get_buffer(struct super_block *sb, sector_t block, bool need_uptodate)
> +{
> +	int err;
> +	struct ext2_buffer *buf;
> +	struct ext2_buffer *new_buf;
> +
> +	buf = ext2_lookup_buffer_cache(sb, block);
> +
> +	if (!buf) {
> +		new_buf = ext2_init_buffer(sb, block, need_uptodate);
> +		if (!new_buf)
> +			return ERR_PTR(-ENOMEM);
> +
> +		buf = ext2_insert_buffer_cache(sb, new_buf);
> +		if (IS_ERR(buf) || buf != new_buf)
> +			ext2_destroy_buffer(new_buf, NULL);
> +	}
> +
> +	if (need_uptodate && !ext2_buffer_uptodate(buf)) {
> +		err = ext2_submit_buffer_read(sb, buf);
> +		if (err)
> +			return ERR_PTR(err);
> +	}
> +
> +	return buf;
> +}

Looking better now :)

> diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> index f38bdd46e4f7..bfed70fd6430 100644
> --- a/fs/ext2/ext2.h
> +++ b/fs/ext2/ext2.h
> @@ -18,6 +18,7 @@
>  #include <linux/rbtree.h>
>  #include <linux/mm.h>
>  #include <linux/highmem.h>
> +#include <linux/rhashtable.h>
>  
>  /* XXX Here for now... not interested in restructing headers JUST now */
>  
> @@ -61,6 +62,29 @@ struct ext2_block_alloc_info {
>  	ext2_fsblk_t		last_alloc_physical_block;
>  };
>  
> +struct ext2_buffer {
> +	sector_t b_block;
> +	struct rhash_head b_rhash;
> +	struct rcu_head b_rcu;
> +	struct page *b_page;
> +	size_t b_size;
> +	char *b_data;
> +	unsigned long b_flags;
> +	refcount_t b_refcount;
> +	struct mutex b_lock;
> +	struct completion b_complete;
> +	struct list_head b_list;
> +	int b_error;
> +};
> +
> +/* ext2_buffer flags */
> +#define EXT2_BUF_DIRTY_BIT 0
> +#define EXT2_BUF_UPTODATE_BIT 1
> +
> +struct ext2_buffer_cache {
> +	struct rhashtable bc_hash;
> +};
> +
>  #define rsv_start rsv_window._rsv_start
>  #define rsv_end rsv_window._rsv_end
>  
> @@ -79,7 +103,7 @@ struct ext2_sb_info {
>  	unsigned long s_groups_count;	/* Number of groups in the fs */
>  	unsigned long s_overhead_last;  /* Last calculated overhead */
>  	unsigned long s_blocks_last;    /* Last seen block count */
> -	struct buffer_head * s_sbh;	/* Buffer containing the super block */
> +	struct ext2_buffer * s_sbuf;	/* Buffer containing the super block */
>  	struct ext2_super_block * s_es;	/* Pointer to the super block in the buffer */
>  	struct buffer_head ** s_group_desc;
>  	unsigned long  s_mount_opt;
> @@ -116,6 +140,7 @@ struct ext2_sb_info {
>  	struct mb_cache *s_ea_block_cache;
>  	struct dax_device *s_daxdev;
>  	u64 s_dax_part_off;
> +	struct ext2_buffer_cache s_buffer_cache;
>  };
>  
>  static inline spinlock_t *
> @@ -716,6 +741,22 @@ extern int ext2_should_retry_alloc(struct super_block *sb, int *retries);
>  extern void ext2_init_block_alloc_info(struct inode *);
>  extern void ext2_rsv_window_add(struct super_block *sb, struct ext2_reserve_window_node *rsv);
>  
> +/* cache.c */
> +extern void ext2_buffer_lock(struct ext2_buffer *);
> +extern void ext2_buffer_unlock(struct ext2_buffer *);
> +extern int ext2_init_buffer_cache(struct ext2_buffer_cache *);
> +extern void ext2_destroy_buffer_cache(struct ext2_buffer_cache *);
> +extern int ext2_sync_buffer_wait(struct super_block *, struct ext2_buffer *);
> +extern int ext2_sync_buffer_cache(struct super_block *);
> +extern struct ext2_buffer *ext2_get_buffer(struct super_block *, sector_t);
> +extern struct ext2_buffer *ext2_read_buffer(struct super_block *, sector_t);
> +extern void ext2_put_buffer(struct super_block *, struct ext2_buffer *);
> +extern void ext2_buffer_set_dirty(struct ext2_buffer *);
> +extern void ext2_buffer_set_uptodate(struct ext2_buffer *);
> +extern void ext2_buffer_clear_uptodate(struct ext2_buffer *);
> +extern int ext2_buffer_error(struct ext2_buffer *);
> +extern void ext2_buffer_clear_error(struct ext2_buffer *);

No need for externs on functions.

> +
>  /* dir.c */
>  int ext2_add_link(struct dentry *, struct inode *);
>  int ext2_inode_by_name(struct inode *dir,
> diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> index 37f7ce56adce..ac53f587d140 100644
> --- a/fs/ext2/super.c
> +++ b/fs/ext2/super.c
> @@ -168,7 +168,8 @@ static void ext2_put_super (struct super_block * sb)
>  	percpu_counter_destroy(&sbi->s_freeblocks_counter);
>  	percpu_counter_destroy(&sbi->s_freeinodes_counter);
>  	percpu_counter_destroy(&sbi->s_dirs_counter);
> -	brelse (sbi->s_sbh);
> +	ext2_put_buffer (sb, sbi->s_sbuf);
> +	ext2_destroy_buffer_cache(&sbi->s_buffer_cache);
>  	sb->s_fs_info = NULL;
>  	kfree(sbi->s_blockgroup_lock);
>  	fs_put_dax(sbi->s_daxdev, NULL);
> @@ -803,7 +804,7 @@ static unsigned long descriptor_loc(struct super_block *sb,
>  
>  static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  {
> -	struct buffer_head * bh;
> +	struct ext2_buffer * buf;
>  	struct ext2_sb_info * sbi;
>  	struct ext2_super_block * es;
>  	struct inode *root;
> @@ -835,6 +836,12 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
>  					   NULL, NULL);
>  
> +	ret = ext2_init_buffer_cache(&sbi->s_buffer_cache);
> +	if (ret) {
> +		ext2_msg(sb, KERN_ERR, "error: unable to create buffer cache");
> +		goto failed_sbi;
> +	}
> +
>  	spin_lock_init(&sbi->s_lock);
>  	ret = -EINVAL;
>  
> @@ -862,7 +869,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  		logic_sb_block = sb_block;
>  	}
>  
> -	if (!(bh = sb_bread(sb, logic_sb_block))) {
> +	if (IS_ERR(buf = ext2_read_buffer(sb, logic_sb_block))) {
>  		ext2_msg(sb, KERN_ERR, "error: unable to read superblock");
>  		goto failed_sbi;

I think this would be better expanded to avoid assigning and comparing
in the same line.  Then you can even extract the real error code and
return it:

	buf = ext2_read_buffer(...);
	if (IS_ERR(buf)) {
		ext2_msg(...);
		ret = PTR_ERR(buf);
		goto failed_sbi;
	}

I also wonder if you could have decreased the diff size by retaining the
"bh" variable name even if it's no longer short for bufferhead.

>  	}
> @@ -870,7 +877,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	 * Note: s_es must be initialized as soon as possible because
>  	 *       some ext2 macro-instructions depend on its value
>  	 */
> -	es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
> +	es = (struct ext2_super_block *) (((char *)buf->b_data) + offset);

Should b_data be declared (void *) and we can simplify all this casting?

>  	sbi->s_es = es;
>  	sb->s_magic = le16_to_cpu(es->s_magic);
>  
> @@ -966,7 +973,8 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  
>  	/* If the blocksize doesn't match, re-read the thing.. */
>  	if (sb->s_blocksize != blocksize) {
> -		brelse(bh);
> +		ext2_buffer_clear_uptodate(buf);
> +		ext2_put_buffer(sb, buf);

Should we instead have a way to purge a cached buffer instead of letting
it stick around (with the wrong size?) in the cache?

>  
>  		if (!sb_set_blocksize(sb, blocksize)) {
>  			ext2_msg(sb, KERN_ERR,
> @@ -976,13 +984,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  
>  		logic_sb_block = (sb_block*BLOCK_SIZE) / blocksize;
>  		offset = (sb_block*BLOCK_SIZE) % blocksize;
> -		bh = sb_bread(sb, logic_sb_block);
> -		if(!bh) {
> +		buf = ext2_read_buffer(sb, logic_sb_block);
> +		if(IS_ERR(buf)) {
>  			ext2_msg(sb, KERN_ERR, "error: couldn't read"
>  				"superblock on 2nd try");
>  			goto failed_sbi;
>  		}
> -		es = (struct ext2_super_block *) (((char *)bh->b_data) + offset);
> +		es = (struct ext2_super_block *) (((char *)buf->b_data) + offset);
>  		sbi->s_es = es;
>  		if (es->s_magic != cpu_to_le16(EXT2_SUPER_MAGIC)) {
>  			ext2_msg(sb, KERN_ERR, "error: magic mismatch");

Future refactoring question: Do the ext* developers want to move all
this validation code into a per-buffer-type validators like XFS does?

> @@ -1021,7 +1029,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  					sbi->s_inodes_per_block;
>  	sbi->s_desc_per_block = sb->s_blocksize /
>  					sizeof (struct ext2_group_desc);
> -	sbi->s_sbh = bh;
> +	sbi->s_sbuf = buf;
>  	sbi->s_mount_state = le16_to_cpu(es->s_state);
>  	sbi->s_addr_per_block_bits =
>  		ilog2 (EXT2_ADDR_PER_BLOCK(sb));
> @@ -1031,7 +1039,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	if (sb->s_magic != EXT2_SUPER_MAGIC)
>  		goto cantfind_ext2;
>  
> -	if (sb->s_blocksize != bh->b_size) {
> +	if (sb->s_blocksize != buf->b_size) {
>  		if (!silent)
>  			ext2_msg(sb, KERN_ERR, "error: unsupported blocksize");
>  		goto failed_mount;
> @@ -1213,7 +1221,7 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  	kvfree(sbi->s_group_desc);
>  	kfree(sbi->s_debts);
>  failed_mount:
> -	brelse(bh);
> +	ext2_put_buffer(sb, buf);
>  failed_sbi:
>  	fs_put_dax(sbi->s_daxdev, NULL);
>  	sb->s_fs_info = NULL;
> @@ -1224,9 +1232,9 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
>  
>  static void ext2_clear_super_error(struct super_block *sb)
>  {
> -	struct buffer_head *sbh = EXT2_SB(sb)->s_sbh;
> +	struct ext2_buffer *sbuf = EXT2_SB(sb)->s_sbuf;
>  
> -	if (buffer_write_io_error(sbh)) {
> +	if (ext2_buffer_error(sbuf)) {
>  		/*
>  		 * Oh, dear.  A previous attempt to write the
>  		 * superblock failed.  This could happen because the
> @@ -1237,8 +1245,8 @@ static void ext2_clear_super_error(struct super_block *sb)
>  		 */
>  		ext2_msg(sb, KERN_ERR,
>  		       "previous I/O error to superblock detected");
> -		clear_buffer_write_io_error(sbh);
> -		set_buffer_uptodate(sbh);
> +		ext2_buffer_clear_error(sbuf);
> +		ext2_buffer_set_uptodate(sbuf);

I wonder if setting uptodate should just clear b_error.

>  	}
>  }
>  
> @@ -1252,9 +1260,9 @@ void ext2_sync_super(struct super_block *sb, struct ext2_super_block *es,
>  	es->s_wtime = cpu_to_le32(ktime_get_real_seconds());
>  	/* unlock before we do IO */
>  	spin_unlock(&EXT2_SB(sb)->s_lock);
> -	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
> +	ext2_buffer_set_dirty(EXT2_SB(sb)->s_sbuf);
>  	if (wait)
> -		sync_dirty_buffer(EXT2_SB(sb)->s_sbh);
> +		ext2_sync_buffer_wait(sb, EXT2_SB(sb)->s_sbuf);
>  }
>  
>  /*
> @@ -1271,13 +1279,19 @@ static int ext2_sync_fs(struct super_block *sb, int wait)
>  {
>  	struct ext2_sb_info *sbi = EXT2_SB(sb);
>  	struct ext2_super_block *es = EXT2_SB(sb)->s_es;
> +	int err = 0;
>  
>  	/*
>  	 * Write quota structures to quota file, sync_blockdev() will write
>  	 * them to disk later
>  	 */
> -	dquot_writeback_dquots(sb, -1);
> +	err = dquot_writeback_dquots(sb, -1);
> +	if (err)
> +		goto out;
> +
> +	err = ext2_sync_buffer_cache(sb);

Shouldn't we try to write the buffer cache to disk even if dquot writing
fails?

	err = dquot_writeback_dquots(...);

	err2 = ext2_sync_buffer_cache(...);
	if (err2 && !err)
		err = err2;
	...
	return err;

--D

>  
> +out:
>  	spin_lock(&sbi->s_lock);
>  	if (es->s_state & cpu_to_le16(EXT2_VALID_FS)) {
>  		ext2_debug("setting valid to 0\n");
> @@ -1285,7 +1299,7 @@ static int ext2_sync_fs(struct super_block *sb, int wait)
>  	}
>  	spin_unlock(&sbi->s_lock);
>  	ext2_sync_super(sb, es, wait);
> -	return 0;
> +	return err;
>  }
>  
>  static int ext2_freeze(struct super_block *sb)
> diff --git a/fs/ext2/xattr.c b/fs/ext2/xattr.c
> index c885dcc3bd0d..1eb4a8607f67 100644
> --- a/fs/ext2/xattr.c
> +++ b/fs/ext2/xattr.c
> @@ -387,7 +387,7 @@ static void ext2_xattr_update_super_block(struct super_block *sb)
>  	ext2_update_dynamic_rev(sb);
>  	EXT2_SET_COMPAT_FEATURE(sb, EXT2_FEATURE_COMPAT_EXT_ATTR);
>  	spin_unlock(&EXT2_SB(sb)->s_lock);
> -	mark_buffer_dirty(EXT2_SB(sb)->s_sbh);
> +	ext2_buffer_set_dirty(EXT2_SB(sb)->s_sbuf);
>  }
>  
>  /*
> -- 
> 2.43.0
> 
> 

