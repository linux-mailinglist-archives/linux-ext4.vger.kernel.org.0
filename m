Return-Path: <linux-ext4+bounces-7009-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B043CA75001
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 19:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6E2857A67E0
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Mar 2025 18:02:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 617CF1F0994;
	Fri, 28 Mar 2025 17:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dBwjV0+P"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040BF1DED5B
	for <linux-ext4@vger.kernel.org>; Fri, 28 Mar 2025 17:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743184604; cv=none; b=L69FClgaodKdBP7Vnjk8Uv1ZdTqhFK/wqupjY4QO/zzOHCOp5ykKVbLyU4Z1iIcvMF1SEwYWPqEl9cIKq4+dPuO0YrKIb/MlM55BIolGYUO7CeEYrzdv2Y4BciwIYhED5n9RaQebGTcnyobgI8YwaYLLV1fc4+yfEbMzm7aKSCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743184604; c=relaxed/simple;
	bh=fNqhx+kcBJBik1mAK9b0gVs8F69f69/8/96HSLb1KEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W2DYkL8hqihlxi30YmoX8pWxoUzOPhXpgH6RcBBC3C1TVg709OIGRUvTe4Wnai99hfJfWIJEZZL2gigEJ/Ry3mAIriUPkjltv3GPoo5hAISnZyl4G6PqYtbV1bUHPgBRks87njY8ExqONMVIjnMKf3Vtsz1wFPwQkZDxDcDoXvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dBwjV0+P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C99BC4CEED;
	Fri, 28 Mar 2025 17:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743184601;
	bh=fNqhx+kcBJBik1mAK9b0gVs8F69f69/8/96HSLb1KEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dBwjV0+Pf8SDxUrhyWJBD9Jhr+nBduWdd3joyYNymhvdThyVUZL2sGlVsOJOnLEgf
	 BBeGRCojMwW6xZGVU7TblC8PFE9nceyNXdNEcd/tdipqQuVO5jv6vnhGRbO1QMym2h
	 Pd4PV3H8StaXktLLoRr2cfk6e4zTvJ0/TsF/xVeWEwBvchh7na5FsXbq35aXdFw2Vt
	 srQCUoT3VayjC3Is4Xom5Datb3YUJaonoF0j8A4DjOc2d2TbSCrEUvyD9ryx4pGsI9
	 CeZLm+WBHkqSalfYU/ArI41H3maFURgkTFlzyibgc68b2KH9kWVrxq3vJC0AHI3Esf
	 sdoJ0MR2is47w==
Date: Fri, 28 Mar 2025 10:56:40 -0700
From: "Darrick J. Wong" <djwong@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Catherine Hoang <catherine.hoang@oracle.com>,
	linux-ext4@vger.kernel.org
Subject: Re: [RFC PATCH v1] ext2: remove buffer heads from quota handling
Message-ID: <20250328175640.GC2803723@frogsfrogsfrogs>
References: <20241029204501.47463-1-catherine.hoang@oracle.com>
 <wqnn2xgfenyeyt65sgskdraslmw2gkzwxkyqvty2kmusbftvt6@ncfa7lwjap25>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <wqnn2xgfenyeyt65sgskdraslmw2gkzwxkyqvty2kmusbftvt6@ncfa7lwjap25>

On Mon, Jan 06, 2025 at 07:03:03PM +0100, Jan Kara wrote:
> On Tue 29-10-24 13:45:01, Catherine Hoang wrote:
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
> Thanks for the patch and sorry for the delay. Overall I'd say this is a bit
> too rudimentary :). See below.

Sorry myself for not noticing this until now. :/

I'll snip out pieces to keep this reply short.

> > +static void buf_write_end_io(struct bio *bio)
> > +{
> > +	struct ext2_buffer *buf = bio->bi_private;
> > +
> > +	clear_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags);
> 
> Clearing the bit after IO has finished is too late. There can be
> modifications done to the buffer while the IO is running and this way you
> could clear the bit while not all changes in the buffer are written out.

(This seems to have been changed to a completion in V2)

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
> > +
> > +	return 0;
> > +}
> 
> I think we need some kind of periodic writeback as well.

Agreed.  One of the downsides (I think) of moving away from the block
device pagecache is that we no longer get the automatic 30s dirty
writeout that takes care of this for the block_device.  Do you know how
to do this?

> Also fsync(2) will need to flush appropriate metadata buffers as well
> and we need to track them together with the inode to which metadata
> belongs.

Are you talking about the file mapping blocks?  I wonder if we could
(re)use mapping->i_private_list for that purpose, though that could be
messy given all the warnings in buffer.c about how that list tracks
bufferheads and they must belong to the blockdev.

But yes, it would be useful to be able to associate ext2_buffers with
the owning inode for file metadata so that fsync can perform a targeted
flush much the same way that we do for bufferheads now.

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
> > +		if (err)
> > +			return ERR_PTR(err);
> > +
> > +		if (need_uptodate) {
> > +			err = submit_buffer_read(sb, new_buf);
> > +			if (err)
> > +				return ERR_PTR(err);
> > +		}
> > +
> > +		buf = insert_buffer_cache(sb, new_buf);
> 
> So this can return the old buffer as well in which case you need to free
> the new one.

(It looks like this was fixed in V2)

> > +		if (IS_ERR(buf))
> > +			kfree(new_buf);
> > +	}
> > +
> > +	mutex_lock(&buf->b_lock);
> > +	refcount_inc(&buf->b_refcount);
> 
> So currently I don't see any use of the refcount. It's always incremented
> when locking b_lock and decremented before unlocking it.

I don't see very many uses of it either, though I think it's useful to
prevent UAF problems on the ext2_buffers themselves.  In the longer
term, I think this buffer cache needs a shrinker, and the shrinker will
want to ignore any buffers with refcount > 1.

> Also locking b_lock whenever acquiring the buffer more or less works for
> quota code but for more complex locking scenarios (xattrs come to mind) it
> will not be really usable so we probably shouldn't mix get/put buffer and
> locking of b_lock?

What are the locking rules for xattrs?  It looks like it locks the
bufferhead whenever making updates to the xattr contents or the bh
state; or when updating the mbcache.  The get/list code doesn't seem to
lock the bh, nor does the mbcache that provides deduplication.

So I gather that inode->i_rwsem is a higher level lock to coordinate
access to the xattr data, and the bh lock only coordinates updates to
b_data or the bh state itself?

> > +int ext2_get_block_bno(struct inode *inode, sector_t iblock,
> > +		int create, u32 *bno, bool *mapped)
> > +{
> > +	struct super_block *sb = inode->i_sb;
> > +	struct buffer_head tmp_bh;
> > +	int err;
> > +
> > +	tmp_bh.b_state = 0;
> > +	tmp_bh.b_size = sb->s_blocksize;
> > +
> > +	err = ext2_get_block(inode, iblock, &tmp_bh, 0);
> 
> I suppose you need to pass the 'create' argument here?

(I think this went away in V2)

> > +	if (err)
> > +		return err;
> > +
> > +	*mapped = buffer_mapped(&tmp_bh);
> > +	*bno = tmp_bh.b_blocknr;
> > +
> > +	return 0;
> > +}
> > +
> 
> So overall I'd say there's more functionality needed to be able to replace
> the buffer cache even for ext2.

Agreed -- periodic writeback, a shrinker, and porting for inodes, inode
bitmaps, mapping blocks, and xattr blocks are still to come before this
can exit rfc status.

--D

