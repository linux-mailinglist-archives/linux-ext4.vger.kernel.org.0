Return-Path: <linux-ext4+bounces-4997-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 238439C0A59
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 16:50:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1730283A31
	for <lists+linux-ext4@lfdr.de>; Thu,  7 Nov 2024 15:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632E5213ECF;
	Thu,  7 Nov 2024 15:50:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LWOsnoEc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A3729CF4
	for <linux-ext4@vger.kernel.org>; Thu,  7 Nov 2024 15:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730994621; cv=none; b=MVroFu4O5v5sTJz9OasvkABbfNYjU2dfMcrPErc196pD+Lslatn+hIKYVmJqIECb3LieqY8LuMHJf/n3HnK/yCfV7LVxHwEkivyw1zRUZfOkqTTix1fPmh/fWqRF29wXgUlXaCeeYffkNf4CKXFe79QEp8EsRqlKZQd69YcYMyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730994621; c=relaxed/simple;
	bh=T/QyO+GEkGtxP9agazyKR0OqhlkEwmHNQnSjVT8eplk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qSD/Fk64aIm+2RoTGNyxcrSznTKDygfgliojeYYlt+N8E6ZEXGkjgq8aU5nLMWImd3Me7GPKuc6DEBMo0LwN5Ws5fUx525jZ+vLOW0BG1vO1Cl4qCU/VDiJ+jFl5hUR6KQQtP2jDzp5y/gEtKAzvT5R4VWI5uk3BtwZ7XdM43Eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LWOsnoEc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8775BC4CECC;
	Thu,  7 Nov 2024 15:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1730994619;
	bh=T/QyO+GEkGtxP9agazyKR0OqhlkEwmHNQnSjVT8eplk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=LWOsnoEcy9p49Lvr0vQylxBMBr1jjP/uQDRhxEpy9fX2rELLSfgbYpuln3z6ydCPc
	 rH17sP42doUN3uOzpQhcqtuHB9rBBlbGh5ToIIdFVwryVcggr4AOWK3VpA2OvFkWt9
	 vMSpNtg+qF9kc55wnoNUtgIHtm5b/uMYuejqVjzCaiS8yqlpqDsfYd6D0uk3IJOz+1
	 bOeuNuYhz5m6nWkFLuCE77E7TAbXkfDeX2ZJ6OVDBJ8tGqhJkg2PkQRgWLVvnu6ug+
	 +SfMi5lfw7PsTgkjgBS21UoEFb/0CwuZ9Bj//BVCh3ZgWDh5tnV/tyG5CDWZkxRCSn
	 eZsEmONTEIHBg==
Date: Thu, 7 Nov 2024 07:50:18 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: Catherine Hoang <catherine.hoang@oracle.com>
Cc: linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v1] ext2: remove buffer heads from quota handling
Message-ID: <20241107155018.GL21832@frogsfrogsfrogs>
References: <20241029204501.47463-1-catherine.hoang@oracle.com>
 <20241105182950.GK21832@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105182950.GK21832@frogsfrogsfrogs>

On Tue, Nov 05, 2024 at 10:29:50AM -0800, Darrick J. Wong wrote:
> On Tue, Oct 29, 2024 at 01:45:01PM -0700, Catherine Hoang wrote:
> > This patch removes the use of buffer heads from the quota read and
> > write paths. To do so, we implement a new buffer cache using an
> > rhashtable. Each buffer stores data from an associated block, and
> > can be read or written to as needed.
> > 
> > Ultimately, we want to completely remove buffer heads from ext2.
> > This patch serves as an example than can be applied to other parts
> > of the filesystem.
> > 
> > Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>
> 
> Cool, thanks for sending this out publicly. :)
> 
> > ---
> >  fs/ext2/Makefile |   2 +-
> >  fs/ext2/cache.c  | 195 +++++++++++++++++++++++++++++++++++++++++++++++
> >  fs/ext2/ext2.h   |  30 ++++++++
> >  fs/ext2/inode.c  |  20 +++++
> >  fs/ext2/super.c  |  62 ++++++++-------
> >  5 files changed, 281 insertions(+), 28 deletions(-)
> >  create mode 100644 fs/ext2/cache.c
> > 
> > diff --git a/fs/ext2/Makefile b/fs/ext2/Makefile
> > index 8860948ef9ca..e8b38243058f 100644
> > --- a/fs/ext2/Makefile
> > +++ b/fs/ext2/Makefile
> > @@ -5,7 +5,7 @@
> >  
> >  obj-$(CONFIG_EXT2_FS) += ext2.o
> >  
> > -ext2-y := balloc.o dir.o file.o ialloc.o inode.o \
> > +ext2-y := balloc.o cache.o dir.o file.o ialloc.o inode.o \
> >  	  ioctl.o namei.o super.o symlink.o trace.o
> >  
> >  # For tracepoints to include our trace.h from tracepoint infrastructure
> > diff --git a/fs/ext2/cache.c b/fs/ext2/cache.c
> > new file mode 100644
> > index 000000000000..c58416392c52
> > --- /dev/null
> > +++ b/fs/ext2/cache.c
> > @@ -0,0 +1,195 @@
> > +// SPDX-License-Identifier: GPL-2.0-or-later
> > +/*
> > + * Copyright (c) 2024 Oracle. All rights reserved.
> > + */
> > +
> > +#include "ext2.h"
> > +#include <linux/bio.h>
> > +#include <linux/blkdev.h>
> > +#include <linux/rhashtable.h>
> > +#include <linux/mm.h>
> > +#include <linux/types.h>
> > +
> > +static const struct rhashtable_params buffer_cache_params = {
> > +	.key_len     = sizeof(sector_t),
> > +	.key_offset  = offsetof(struct ext2_buffer, b_block),
> > +	.head_offset = offsetof(struct ext2_buffer, b_rhash),
> > +	.automatic_shrinking = true,
> > +};
> > +
> > +static struct ext2_buffer *insert_buffer_cache(struct super_block *sb, struct ext2_buffer *new_buf)
> > +{
> > +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> > +	struct rhashtable *buffer_cache = &sbi->buffer_cache;
> > +	struct ext2_buffer *old_buf;
> > +
> > +	spin_lock(&sbi->buffer_cache_lock);
> > +	old_buf = rhashtable_lookup_get_insert_fast(buffer_cache,
> > +				&new_buf->b_rhash, buffer_cache_params);
> > +	spin_unlock(&sbi->buffer_cache_lock);
> > +
> > +	if (old_buf)
> > +		return old_buf;
> > +
> > +	return new_buf;
> 
> Doesn't rhashtable_lookup_get_insert_fast return whichever buffer is in
> the rhashtable?  So you can just do "return old_buf" here?
> 
> > +}
> > +
> > +static void buf_write_end_io(struct bio *bio)
> > +{
> > +	struct ext2_buffer *buf = bio->bi_private;
> > +
> > +	clear_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags);
> 
> If the bio fails, should we leave the dirty bit set?  The IO error could
> be temporary, and a future syncfs ought to retry the write.
> 
> Also I wonder if we ought to have a way to report to sync_buffers that
> one of the writes failed so that it can return EIO for syncfs?
> 
> Perhaps an atomic_t write failure counter in the buffer cache struct
> (see below) that we could bump from buf_write_end_io every time there's
> a failure?  Then sync_buffers could compare the write failure counter
> before issuing IOs and after they've all completed?
> 
> > +	bio_put(bio);
> > +}
> > +
> > +static int submit_buffer_read(struct super_block *sb, struct ext2_buffer *buf)
> > +{
> > +	struct bio_vec bio_vec;
> > +	struct bio bio;
> > +	sector_t sector = buf->b_block * (sb->s_blocksize >> 9);
> > +
> > +	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
> > +	bio.bi_iter.bi_sector = sector;
> > +
> > +	__bio_add_page(&bio, buf->b_page, buf->b_size, 0);
> > +
> > +	return submit_bio_wait(&bio);
> > +}
> > +
> > +static void submit_buffer_write(struct super_block *sb, struct ext2_buffer *buf)
> > +{
> > +	struct bio *bio;
> > +	sector_t sector = buf->b_block * (sb->s_blocksize >> 9);
> > +
> > +	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_WRITE, GFP_KERNEL);
> > +
> > +	bio->bi_iter.bi_sector = sector;
> > +	bio->bi_end_io = buf_write_end_io;
> > +	bio->bi_private = buf;
> > +
> > +	__bio_add_page(bio, buf->b_page, buf->b_size, 0);
> > +
> > +	submit_bio(bio);
> > +}
> > +
> > +int sync_buffers(struct super_block *sb)
> > +{
> > +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> > +	struct rhashtable *buffer_cache = &sbi->buffer_cache;
> > +	struct rhashtable_iter iter;
> > +	struct ext2_buffer *buf;
> > +	struct blk_plug plug;
> > +
> > +	blk_start_plug(&plug);
> > +	rhashtable_walk_enter(buffer_cache, &iter);
> > +	rhashtable_walk_start(&iter);
> > +	while ((buf = rhashtable_walk_next(&iter)) != NULL) {
> > +		if (IS_ERR(buf))
> > +			continue;
> > +		if (test_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags)) {
> > +			submit_buffer_write(sb, buf);
> > +		}
> > +	}
> > +	rhashtable_walk_stop(&iter);
> > +	rhashtable_walk_exit(&iter);
> > +	blk_finish_plug(&plug);
> 
> Hum.  I think this needs to wait for the writes to complete so that it
> can report any IO errors.  What do you think of adding a completion to
> ext2_buffer so that the end_io function can complete() on it, and this
> function can wait for each buffer?
> 
> (I think this is getting closer and closer to the delwri list code for
> xfs_buf...)
> 
> > +
> > +	return 0;
> > +}
> > +
> > +static struct ext2_buffer *lookup_buffer_cache(struct super_block *sb, sector_t block)
> > +{
> > +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> > +	struct rhashtable *buffer_cache = &sbi->buffer_cache;
> > +	struct ext2_buffer *found = NULL;
> > +
> > +	found = rhashtable_lookup_fast(buffer_cache, &block, buffer_cache_params);
> > +
> > +	return found;
> 
> Doesn't this need to take the rcu read lock before the lookup so that
> the rhashtable structures (and the ext2_buffer) cannot be freed while we
> try to grab a refcount on the buffer?  I think it also needs to
> refcount_inc_not_zero before dropping that read lock:
> 
> 	rcu_read_lock();
> 	found = rhashtable_lookup_fast(..);
> 	if (!found || !refcount_inc_not_zero(&found->b_refcount)) {
> 		rcu_read_unlock();
> 		return -ENOENT;
> 	}
> 	rcu_read_unlock();
> 
> 	return found;
> 
> > +}
> > +
> > +static int init_buffer(struct super_block *sb, sector_t block, struct ext2_buffer **buf_ptr)
> > +{
> > +	struct ext2_buffer *buf;
> > +
> > +	buf = kmalloc(sizeof(struct ext2_buffer), GFP_KERNEL);
> > +	if (!buf)
> > +		return -ENOMEM;
> > +
> > +	buf->b_block = block;
> > +	buf->b_size = sb->s_blocksize;
> > +	buf->b_flags = 0;
> > +
> > +	mutex_init(&buf->b_lock);
> > +	refcount_set(&buf->b_refcount, 1);
> > +
> > +	buf->b_page = alloc_page(GFP_KERNEL);
> 
> For s_blocksize < PAGE_SIZE filesystems, you could make this more memory
> efficient by doing slab allocations instead of a full page.
> 
> > +	if (!buf->b_page)
> > +		return -ENOMEM;
> 
> Needs to free buf.
> 
> > +
> > +	buf->b_data = page_address(buf->b_page);
> > +
> > +	*buf_ptr = buf;
> > +
> > +	return 0;
> > +}
> > +
> > +void put_buffer(struct ext2_buffer *buf)
> > +{
> > +	refcount_dec(&buf->b_refcount);
> > +	mutex_unlock(&buf->b_lock);
> 
> Buffers can get freed after the refcount drops, so you need to drop the
> mutex before dropping the ref.
> 
> I almost wonder if this function should take a (struct ext2_buffer **)
> so that you can null out the caller's pointer to avoid accidental UAF,
> but that might be too training wheels for the kernel.
> 
> > +}
> > +
> > +struct ext2_buffer *get_buffer(struct super_block *sb, sector_t block, bool need_uptodate)
> > +{
> > +	int err;
> > +	struct ext2_buffer *buf;
> > +	struct ext2_buffer *new_buf;
> > +
> > +	buf = lookup_buffer_cache(sb, block);
> > +
> > +	if (!buf) {
> > +		err = init_buffer(sb, block, &new_buf);
> 
> If you made init_buffer return either a (struct ext2_buffer *) or NULL,
> then you could remove the third parameter and the callsite becomes:
> 
> 		new_buf = init_buffer(sb, block);
> 		if (!new_buf)
> 			return ERR_PTR(-ENOMEM);
> 
> > +		if (err)
> > +			return ERR_PTR(err);
> > +
> > +		if (need_uptodate) {
> > +			err = submit_buffer_read(sb, new_buf);
> > +			if (err)
> > +				return ERR_PTR(err);
> 
> If you passed need_uptodate to init_buffer, then you could pass GFP_ZERO
> to alloc_page() in the !need_uptodate case, and the buffer would be
> clean (i.e. not contain any stale memory contents) if we're initializing
> a new block and don't care what's on disk.
> 
> Also I think you need a destroy_buffer call if the read fails.
> 
> > +		}
> > +
> > +		buf = insert_buffer_cache(sb, new_buf);
> > +		if (IS_ERR(buf))
> > +			kfree(new_buf);
> 
> I'm confused here -- insert_buffer_cache returns either a buffer that
> has been added to the cache since the lookup_buffer_cache call, or it
> adds new_buf and returns it.  Neither of those pointers are an IS_ERR,
> so if buf != new_buf (aka we lost the race to add the buffer), we'll end
> up leaking new_buf.
> 
> Also, new_buf has resources allocated to it, don't you need to call
> destroy_buffer here?
> 
> > +	}
> > +
> > +	mutex_lock(&buf->b_lock);
> > +	refcount_inc(&buf->b_refcount);
> > +
> > +	return buf;
> > +}
> 
> Some people dislike trivial helpers, but I think the callsites would
> read better if you did:
> 
> struct ext2_buffer *
> __get_buffer(struct ext2_buffer_cache *bufs, sector_t block,
> 		bool need_uptodate);
> 
> static inline struct ext2_buffer *
> get_buffer(struct ext2_buffer_cache *bufs, sector_t bno)
> {
> 	return __get_buffer(bufs, bno, false);
> }
> 
> static inline struct ext2_buffer *
> read_buffer(struct ext2_buffer_cache *bufs, sector_t bno)
> {
> 	return __get_buffer(bufs, bno, true);
> }
> 
> It's much easier for me to distinguish between reading a buffer so that
> we can update its contents vs. getting a buffer so that we can
> initialize a new block if the words are right there in the function name
> instead of a 0/1 argument:
> 
> 	if (offset || tocopy != EXT2_BLOCK_SIZE(sb))
> 		buf = get_buffer(sb, bno, 1);
> 	else
> 		buf = get_buffer(sb, bno, 0);
> 
> vs:
> 
> 	/*
> 	 * rmw a partial buffer or skip the read if we're doing the
> 	 * entire block.
> 	 */
> 	if (offset || tocopy != EXT2_BLOCK_SIZE(sb))
> 		buf = read_buffer(sb, bno);
> 	else
> 		buf = get_buffer(sb, bno);
> 
> > +void buffer_set_dirty(struct ext2_buffer *buf)
> > +{
> > +    set_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags);
> > +}
> 
> There ought to be a way to clear the dirty bit on a buffer if you're
> freeing it... though AFAICT we never actually free blocks from a quota
> file so I guess you don't need it yet.
> 
> > +
> > +int init_buffer_cache(struct rhashtable *buffer_cache)
> > +{
> > +	return rhashtable_init(buffer_cache, &buffer_cache_params);
> 
> Shouldn't this be in charge of initializing the spinlock?
> 
> > +}
> > +
> > +static void destroy_buffer(void *ptr, void *arg)
> > +{
> > +	struct ext2_buffer *buf = ptr;
> > +
> > +	WARN_ON(test_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags));
> > +	__free_page(buf->b_page);
> > +	kfree(buf);
> > +}
> > +
> > +void destroy_buffer_cache(struct rhashtable *buffer_cache)
> > +{
> > +	rhashtable_free_and_destroy(buffer_cache, destroy_buffer, NULL);
> > +}
> 
> Just as a note to everyone else: there needs to be a shrinker to clear
> out !dirty buffers during memory reclaim, and (most probably) a means to
> initiate a background writeout of dirty buffers when memory starts
> getting low.  Each of those is complex enough to warrant separate
> patches.
> 
> > diff --git a/fs/ext2/ext2.h b/fs/ext2/ext2.h
> > index f38bdd46e4f7..ce0bb03527e0 100644
> > --- a/fs/ext2/ext2.h
> > +++ b/fs/ext2/ext2.h
> > @@ -18,6 +18,7 @@
> >  #include <linux/rbtree.h>
> >  #include <linux/mm.h>
> >  #include <linux/highmem.h>
> > +#include <linux/rhashtable.h>
> >  
> >  /* XXX Here for now... not interested in restructing headers JUST now */
> >  
> > @@ -116,6 +117,8 @@ struct ext2_sb_info {
> >  	struct mb_cache *s_ea_block_cache;
> >  	struct dax_device *s_daxdev;
> >  	u64 s_dax_part_off;
> > +	struct rhashtable buffer_cache;
> > +	spinlock_t buffer_cache_lock;
> 
> These ought to be in a struct ext2_buffer_cache, so that you can pass a
> (struct ext2_buffer_cache *) to the {init,destroy}_buffer_cache
> functions.  That improves type safety, because the compiler can check
> for us that someone doesn't accidentally pass some other rhashtable into
> destroy_buffer_cache.
> 
> >  };
> >  
> >  static inline spinlock_t *
> > @@ -683,6 +686,24 @@ struct ext2_inode_info {
> >   */
> >  #define EXT2_STATE_NEW			0x00000001 /* inode is newly created */
> >  
> > +/*
> > + * ext2 buffer
> > + */
> > +struct ext2_buffer {
> > +	sector_t b_block;
> > +	struct rhash_head b_rhash;
> > +	struct page *b_page;
> > +	size_t b_size;
> > +	char *b_data;
> > +	unsigned long b_flags;
> > +	refcount_t b_refcount;
> > +	struct mutex b_lock;
> > +};
> > +
> > +/*
> > + * Buffer flags
> > + */
> > + #define EXT2_BUF_DIRTY_BIT 0
> >  
> >  /*
> >   * Function prototypes
> > @@ -716,6 +737,14 @@ extern int ext2_should_retry_alloc(struct super_block *sb, int *retries);
> >  extern void ext2_init_block_alloc_info(struct inode *);
> >  extern void ext2_rsv_window_add(struct super_block *sb, struct ext2_reserve_window_node *rsv);
> >  
> > +/* cache.c */
> > +extern int init_buffer_cache(struct rhashtable *);
> > +extern void destroy_buffer_cache(struct rhashtable *buffer_cache);
> > +extern int sync_buffers(struct super_block *);
> > +extern struct ext2_buffer *get_buffer(struct super_block *, sector_t, bool);
> > +extern void put_buffer(struct ext2_buffer *);
> > +extern void buffer_set_dirty(struct ext2_buffer *);
> > +
> >  /* dir.c */
> >  int ext2_add_link(struct dentry *, struct inode *);
> >  int ext2_inode_by_name(struct inode *dir,
> > @@ -741,6 +770,7 @@ extern int ext2_write_inode (struct inode *, struct writeback_control *);
> >  extern void ext2_evict_inode(struct inode *);
> >  void ext2_write_failed(struct address_space *mapping, loff_t to);
> >  extern int ext2_get_block(struct inode *, sector_t, struct buffer_head *, int);
> > +extern int ext2_get_block_bno(struct inode *, sector_t, int, u32 *, bool *);
> >  extern int ext2_setattr (struct mnt_idmap *, struct dentry *, struct iattr *);
> >  extern int ext2_getattr (struct mnt_idmap *, const struct path *,
> >  			 struct kstat *, u32, unsigned int);
> > diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
> > index 0caa1650cee8..7e7e6a5916c4 100644
> > --- a/fs/ext2/inode.c
> > +++ b/fs/ext2/inode.c
> > @@ -803,6 +803,26 @@ int ext2_get_block(struct inode *inode, sector_t iblock,
> >  
> >  }
> >  
> > +int ext2_get_block_bno(struct inode *inode, sector_t iblock,
> > +		int create, u32 *bno, bool *mapped)
> > +{
> > +	struct super_block *sb = inode->i_sb;
> > +	struct buffer_head tmp_bh;
> 
> This probably ought to be switched to iomap if the goal is to get rid of
> buffer heads.  But as I mutter somewhere else, maybe the quota code
> should just copy to and from the quota file pagecache and this effort
> target the other metadata of ext2. ;)
> 
> > +	int err;
> > +
> > +	tmp_bh.b_state = 0;
> > +	tmp_bh.b_size = sb->s_blocksize;
> > +
> > +	err = ext2_get_block(inode, iblock, &tmp_bh, 0);
> > +	if (err)
> > +		return err;
> > +
> > +	*mapped = buffer_mapped(&tmp_bh);
> > +	*bno = tmp_bh.b_blocknr;
> > +
> > +	return 0;
> > +}
> > 
> >  static int ext2_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
> >  		unsigned flags, struct iomap *iomap, struct iomap *srcmap)
> >  {
> > diff --git a/fs/ext2/super.c b/fs/ext2/super.c
> > index 37f7ce56adce..11d88882ad24 100644
> > --- a/fs/ext2/super.c
> > +++ b/fs/ext2/super.c
> > @@ -152,6 +152,8 @@ static void ext2_put_super (struct super_block * sb)
> >  	ext2_xattr_destroy_cache(sbi->s_ea_block_cache);
> >  	sbi->s_ea_block_cache = NULL;
> >  
> > +	destroy_buffer_cache(&sbi->buffer_cache);
> > +
> >  	if (!sb_rdonly(sb)) {
> >  		struct ext2_super_block *es = sbi->s_es;
> >  
> > @@ -835,6 +837,13 @@ static int ext2_fill_super(struct super_block *sb, void *data, int silent)
> >  	sbi->s_daxdev = fs_dax_get_by_bdev(sb->s_bdev, &sbi->s_dax_part_off,
> >  					   NULL, NULL);
> >  
> > +	spin_lock_init(&sbi->buffer_cache_lock);
> > +	ret = init_buffer_cache(&sbi->buffer_cache);
> > +	if (ret) {
> > +		ext2_msg(sb, KERN_ERR, "error: unable to create buffer cache");
> > +		goto failed_sbi;
> > +	}
> 
> If the subsequent initialization fails, shouldn't ext2_fill_super call
> destroy_buffer_cache to free the buffer cache object?
> 
> > +
> >  	spin_lock_init(&sbi->s_lock);
> >  	ret = -EINVAL;
> >  
> > @@ -1278,6 +1287,8 @@ static int ext2_sync_fs(struct super_block *sb, int wait)
> >  	 */
> >  	dquot_writeback_dquots(sb, -1);
> >  
> > +	sync_buffers(sb);
> 
> Assuming that sync_buffers (or really, sync_buffer_cache() called on the
> ext2_buffer_cache) starts returning io errors, any error code should be
> returned here:
> 
> 	int ret = 0, ret2;
> 
> 	ret2 = dquot_writeback_dquots(sb, -1);
> 	if (!ret && ret2)
> 		ret = ret2;
> 
> 	...
> 
> 	ret2 = sync_buffer_cache(&sb->buffer_cache);
> 	if (!ret && ret2)
> 		ret = ret2;
> 
> 	...
> 
> 	return ret;
> 
> 
> > +
> >  	spin_lock(&sbi->s_lock);
> >  	if (es->s_state & cpu_to_le16(EXT2_VALID_FS)) {
> >  		ext2_debug("setting valid to 0\n");
> > @@ -1491,9 +1502,10 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data,
> >  	int offset = off & (sb->s_blocksize - 1);
> >  	int tocopy;
> >  	size_t toread;
> > -	struct buffer_head tmp_bh;
> > -	struct buffer_head *bh;
> >  	loff_t i_size = i_size_read(inode);
> > +	struct ext2_buffer *buf;
> > +	u32 bno;
> > +	bool mapped;
> >  
> >  	if (off > i_size)
> >  		return 0;
> > @@ -1503,20 +1515,19 @@ static ssize_t ext2_quota_read(struct super_block *sb, int type, char *data,
> >  	while (toread > 0) {
> >  		tocopy = min_t(size_t, sb->s_blocksize - offset, toread);
> >  
> > -		tmp_bh.b_state = 0;
> > -		tmp_bh.b_size = sb->s_blocksize;
> > -		err = ext2_get_block(inode, blk, &tmp_bh, 0);
> > +		err = ext2_get_block_bno(inode, blk, 0, &bno, &mapped);
> >  		if (err < 0)
> >  			return err;
> > -		if (!buffer_mapped(&tmp_bh))	/* A hole? */
> > +		if (!mapped)	/* A hole? */
> >  			memset(data, 0, tocopy);
> >  		else {
> > -			bh = sb_bread(sb, tmp_bh.b_blocknr);
> > -			if (!bh)
> > -				return -EIO;
> > -			memcpy(data, bh->b_data+offset, tocopy);
> > -			brelse(bh);
> > +			buf = get_buffer(sb, bno, 1);
> > +			if (IS_ERR(buf))
> > +				return PTR_ERR(buf);
> > +			memcpy(data, buf->b_data+offset, tocopy);
> > +			put_buffer(buf);
> 
> I recognize that this is a RFC proof of concept, but I wonder why we
> don't just copy the dquot information to and from the pagecache?  And
> use the ext2_buffer for other non-file metadata things (e.g. bitmaps,
> indirect blocks, inodes, group descriptors)?

willy points out that there are good reasons for avoiding the pagecache
for quota file contents:
https://lore.kernel.org/linux-fsdevel/Yp%2F+fSoHgPIhiHQR@casper.infradead.org/

...so I withdraw the question.

--D

> >  		}
> > +
> >  		offset = 0;
> >  		toread -= tocopy;
> >  		data += tocopy;
> > @@ -1535,32 +1546,29 @@ static ssize_t ext2_quota_write(struct super_block *sb, int type,
> >  	int offset = off & (sb->s_blocksize - 1);
> >  	int tocopy;
> >  	size_t towrite = len;
> > -	struct buffer_head tmp_bh;
> > -	struct buffer_head *bh;
> > +	struct ext2_buffer *buf;
> > +	u32 bno;
> > +	bool mapped;
> >  
> >  	while (towrite > 0) {
> >  		tocopy = min_t(size_t, sb->s_blocksize - offset, towrite);
> >  
> > -		tmp_bh.b_state = 0;
> > -		tmp_bh.b_size = sb->s_blocksize;
> > -		err = ext2_get_block(inode, blk, &tmp_bh, 1);
> > +		err = ext2_get_block_bno(inode, blk, 1, &bno, &mapped);
> >  		if (err < 0)
> >  			goto out;
> > +
> >  		if (offset || tocopy != EXT2_BLOCK_SIZE(sb))
> > -			bh = sb_bread(sb, tmp_bh.b_blocknr);
> > +			buf = get_buffer(sb, bno, 1);
> >  		else
> > -			bh = sb_getblk(sb, tmp_bh.b_blocknr);
> > -		if (unlikely(!bh)) {
> > -			err = -EIO;
> > +			buf = get_buffer(sb, bno, 0);
> > +		if (IS_ERR(buf)) {
> > +			err = PTR_ERR(buf);
> >  			goto out;
> >  		}
> > -		lock_buffer(bh);
> > -		memcpy(bh->b_data+offset, data, tocopy);
> > -		flush_dcache_page(bh->b_page);
> > -		set_buffer_uptodate(bh);
> > -		mark_buffer_dirty(bh);
> > -		unlock_buffer(bh);
> > -		brelse(bh);
> > +		memcpy(buf->b_data+offset, data, tocopy);
> > +		buffer_set_dirty(buf);
> 
> I also wonder if this could be lifted a buffer_write() helper:
> 
> void buffer_write(struct ext2_buffer *buf, void *data,
> 		  unsigned int count, unsigned int offset)
> {
> 	WARN_ON(offset + count > buf->b_size);
> 
> 	memcpy(buf->b_data + offset, data, count);
> 	buffer_set_dirty(buf);
> }
> 
> 		buffer_write(buf, data, offset, tocopy);
> 
> > +		put_buffer(buf);
> > +
> >  		offset = 0;
> >  		towrite -= tocopy;
> >  		data += tocopy;
> > -- 
> > 2.43.0
> > 
> > 
> 

