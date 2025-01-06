Return-Path: <linux-ext4+bounces-5910-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 54E2DA02F6D
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 19:03:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 38DA8162586
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D04701DE8B0;
	Mon,  6 Jan 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S/EWoyFw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5CUvSET4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="S/EWoyFw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5CUvSET4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CE67081E
	for <linux-ext4@vger.kernel.org>; Mon,  6 Jan 2025 18:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736186590; cv=none; b=Jb1ofgMBegkRlgLQ1BYvSqXvC4S2jCvNfL+w7eCzdMpOVV2HbxEWWSe7u2RI7oh62+usszAPP2ue33c83M7Axlp1U/E6kzKOEBFruTPriBTZabWuRqKGsNJUXx3MLyE55is6yG+/y9KsfrYR0VdA86gkMHXaX0GHc8NiFEmsjuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736186590; c=relaxed/simple;
	bh=yWxJAiLZ01YeD516C0csPeKSqBdpTn7Yf8RejtV1qrQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H5qFL1TjcF7EsKBHd0fnCIiX73GGVN3vHIgemTMBUbGyP5WCy+tVw21qugoeQGEaH7blIsFAKympNs+GTl+momcfJ4QQvyUbvwElFXq9vP/Uf8cwguRH4jh53yxhmN2YhvT7m6UcX9SdEDwDwZwLqtdUuOGCa9oaZlVaVws9luE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S/EWoyFw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5CUvSET4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=S/EWoyFw; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=5CUvSET4; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id A00FD21166;
	Mon,  6 Jan 2025 18:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736186586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kKIEBS3Olub2M8QQjkOWn8fy1O0sdw+O2gTeJEjzKxU=;
	b=S/EWoyFwl+qmlBr7PJ9nzjm6ce9+lPqDYChVdyY53+CagT20cSBvmT7ZpboSVpcz5mmwps
	hmpf5wbq3NDjMikzYTs4mASPpAFwYW1CbcCFGfZgnTApGDargg+h/enRjlDNN/7g53cEp5
	u0X7Q965ETJPc0dKZMXWVgMzX2H1gAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736186586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kKIEBS3Olub2M8QQjkOWn8fy1O0sdw+O2gTeJEjzKxU=;
	b=5CUvSET4y5zJFMJ8EIGrVCLa5kfDExn95fL1ryau8/Xlm6/uLQPc1fOv3lI7ierzxkwH66
	eEGBYeY88uovfpBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736186586; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kKIEBS3Olub2M8QQjkOWn8fy1O0sdw+O2gTeJEjzKxU=;
	b=S/EWoyFwl+qmlBr7PJ9nzjm6ce9+lPqDYChVdyY53+CagT20cSBvmT7ZpboSVpcz5mmwps
	hmpf5wbq3NDjMikzYTs4mASPpAFwYW1CbcCFGfZgnTApGDargg+h/enRjlDNN/7g53cEp5
	u0X7Q965ETJPc0dKZMXWVgMzX2H1gAE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736186586;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kKIEBS3Olub2M8QQjkOWn8fy1O0sdw+O2gTeJEjzKxU=;
	b=5CUvSET4y5zJFMJ8EIGrVCLa5kfDExn95fL1ryau8/Xlm6/uLQPc1fOv3lI7ierzxkwH66
	eEGBYeY88uovfpBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 397DF139AB;
	Mon,  6 Jan 2025 18:03:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id PZUCDtoafGcecQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 18:03:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 348B9A089C; Mon,  6 Jan 2025 19:03:03 +0100 (CET)
Date: Mon, 6 Jan 2025 19:03:03 +0100
From: Jan Kara <jack@suse.cz>
To: Catherine Hoang <catherine.hoang@oracle.com>
Cc: linux-ext4@vger.kernel.org, djwong@kernel.org
Subject: Re: [RFC PATCH v1] ext2: remove buffer heads from quota handling
Message-ID: <wqnn2xgfenyeyt65sgskdraslmw2gkzwxkyqvty2kmusbftvt6@ncfa7lwjap25>
References: <20241029204501.47463-1-catherine.hoang@oracle.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241029204501.47463-1-catherine.hoang@oracle.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-0.999];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_HAS_DN(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 29-10-24 13:45:01, Catherine Hoang wrote:
> This patch removes the use of buffer heads from the quota read and
> write paths. To do so, we implement a new buffer cache using an
> rhashtable. Each buffer stores data from an associated block, and
> can be read or written to as needed.
> 
> Ultimately, we want to completely remove buffer heads from ext2.
> This patch serves as an example than can be applied to other parts
> of the filesystem.
> 
> Signed-off-by: Catherine Hoang <catherine.hoang@oracle.com>

Thanks for the patch and sorry for the delay. Overall I'd say this is a bit
too rudimentary :). See below.

> diff --git a/fs/ext2/cache.c b/fs/ext2/cache.c
> new file mode 100644
> index 000000000000..c58416392c52
> --- /dev/null
> +++ b/fs/ext2/cache.c
> @@ -0,0 +1,195 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (c) 2024 Oracle. All rights reserved.
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
> +static struct ext2_buffer *insert_buffer_cache(struct super_block *sb, struct ext2_buffer *new_buf)
> +{
> +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> +	struct rhashtable *buffer_cache = &sbi->buffer_cache;
> +	struct ext2_buffer *old_buf;
> +
> +	spin_lock(&sbi->buffer_cache_lock);
> +	old_buf = rhashtable_lookup_get_insert_fast(buffer_cache,
> +				&new_buf->b_rhash, buffer_cache_params);
> +	spin_unlock(&sbi->buffer_cache_lock);
> +
> +	if (old_buf)
> +		return old_buf;
> +
> +	return new_buf;
> +}
> +
> +static void buf_write_end_io(struct bio *bio)
> +{
> +	struct ext2_buffer *buf = bio->bi_private;
> +
> +	clear_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags);

Clearing the bit after IO has finished is too late. There can be
modifications done to the buffer while the IO is running and this way you
could clear the bit while not all changes in the buffer are written out.

> +	bio_put(bio);
> +}
> +
> +static int submit_buffer_read(struct super_block *sb, struct ext2_buffer *buf)
> +{
> +	struct bio_vec bio_vec;
> +	struct bio bio;
> +	sector_t sector = buf->b_block * (sb->s_blocksize >> 9);
> +
> +	bio_init(&bio, sb->s_bdev, &bio_vec, 1, REQ_OP_READ);
> +	bio.bi_iter.bi_sector = sector;
> +
> +	__bio_add_page(&bio, buf->b_page, buf->b_size, 0);
> +
> +	return submit_bio_wait(&bio);
> +}
> +
> +static void submit_buffer_write(struct super_block *sb, struct ext2_buffer *buf)
> +{
> +	struct bio *bio;
> +	sector_t sector = buf->b_block * (sb->s_blocksize >> 9);
> +
> +	bio = bio_alloc(sb->s_bdev, 1, REQ_OP_WRITE, GFP_KERNEL);
> +
> +	bio->bi_iter.bi_sector = sector;
> +	bio->bi_end_io = buf_write_end_io;
> +	bio->bi_private = buf;
> +
> +	__bio_add_page(bio, buf->b_page, buf->b_size, 0);
> +
> +	submit_bio(bio);
> +}
> +
> +int sync_buffers(struct super_block *sb)
> +{
> +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> +	struct rhashtable *buffer_cache = &sbi->buffer_cache;
> +	struct rhashtable_iter iter;
> +	struct ext2_buffer *buf;
> +	struct blk_plug plug;
> +
> +	blk_start_plug(&plug);
> +	rhashtable_walk_enter(buffer_cache, &iter);
> +	rhashtable_walk_start(&iter);
> +	while ((buf = rhashtable_walk_next(&iter)) != NULL) {
> +		if (IS_ERR(buf))
> +			continue;
> +		if (test_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags)) {
> +			submit_buffer_write(sb, buf);
> +		}
> +	}
> +	rhashtable_walk_stop(&iter);
> +	rhashtable_walk_exit(&iter);
> +	blk_finish_plug(&plug);
> +
> +	return 0;
> +}

I think we need some kind of periodic writeback as well. Also fsync(2) will
need to flush appropriate metadata buffers as well and we need to track
them together with the inode to which metadata belongs.

> +static struct ext2_buffer *lookup_buffer_cache(struct super_block *sb, sector_t block)
> +{
> +	struct ext2_sb_info *sbi = EXT2_SB(sb);
> +	struct rhashtable *buffer_cache = &sbi->buffer_cache;
> +	struct ext2_buffer *found = NULL;
> +
> +	found = rhashtable_lookup_fast(buffer_cache, &block, buffer_cache_params);
> +
> +	return found;
> +}
> +
> +static int init_buffer(struct super_block *sb, sector_t block, struct ext2_buffer **buf_ptr)
> +{
> +	struct ext2_buffer *buf;
> +
> +	buf = kmalloc(sizeof(struct ext2_buffer), GFP_KERNEL);
> +	if (!buf)
> +		return -ENOMEM;
> +
> +	buf->b_block = block;
> +	buf->b_size = sb->s_blocksize;
> +	buf->b_flags = 0;
> +
> +	mutex_init(&buf->b_lock);
> +	refcount_set(&buf->b_refcount, 1);
> +
> +	buf->b_page = alloc_page(GFP_KERNEL);
> +	if (!buf->b_page)
> +		return -ENOMEM;
> +
> +	buf->b_data = page_address(buf->b_page);
> +
> +	*buf_ptr = buf;
> +
> +	return 0;
> +}
> +
> +void put_buffer(struct ext2_buffer *buf)
> +{
> +	refcount_dec(&buf->b_refcount);
> +	mutex_unlock(&buf->b_lock);
> +}
> +
> +struct ext2_buffer *get_buffer(struct super_block *sb, sector_t block, bool need_uptodate)
> +{
> +	int err;
> +	struct ext2_buffer *buf;
> +	struct ext2_buffer *new_buf;
> +
> +	buf = lookup_buffer_cache(sb, block);
> +
> +	if (!buf) {
> +		err = init_buffer(sb, block, &new_buf);
> +		if (err)
> +			return ERR_PTR(err);
> +
> +		if (need_uptodate) {
> +			err = submit_buffer_read(sb, new_buf);
> +			if (err)
> +				return ERR_PTR(err);
> +		}
> +
> +		buf = insert_buffer_cache(sb, new_buf);

So this can return the old buffer as well in which case you need to free
the new one.

> +		if (IS_ERR(buf))
> +			kfree(new_buf);
> +	}
> +
> +	mutex_lock(&buf->b_lock);
> +	refcount_inc(&buf->b_refcount);

So currently I don't see any use of the refcount. It's always incremented
when locking b_lock and decremented before unlocking it.

Also locking b_lock whenever acquiring the buffer more or less works for
quota code but for more complex locking scenarios (xattrs come to mind) it
will not be really usable so we probably shouldn't mix get/put buffer and
locking of b_lock?

> +void buffer_set_dirty(struct ext2_buffer *buf)
> +{
> +    set_bit(EXT2_BUF_DIRTY_BIT, &buf->b_flags);
> +}
> +
> +int init_buffer_cache(struct rhashtable *buffer_cache)
> +{
> +	return rhashtable_init(buffer_cache, &buffer_cache_params);
> +}
> +

...

> +int ext2_get_block_bno(struct inode *inode, sector_t iblock,
> +		int create, u32 *bno, bool *mapped)
> +{
> +	struct super_block *sb = inode->i_sb;
> +	struct buffer_head tmp_bh;
> +	int err;
> +
> +	tmp_bh.b_state = 0;
> +	tmp_bh.b_size = sb->s_blocksize;
> +
> +	err = ext2_get_block(inode, iblock, &tmp_bh, 0);

I suppose you need to pass the 'create' argument here?

> +	if (err)
> +		return err;
> +
> +	*mapped = buffer_mapped(&tmp_bh);
> +	*bno = tmp_bh.b_blocknr;
> +
> +	return 0;
> +}
> +

So overall I'd say there's more functionality needed to be able to replace
the buffer cache even for ext2.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

