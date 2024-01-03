Return-Path: <linux-ext4+bounces-651-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DB5C822A10
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 10:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBF712824CA
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 09:15:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BBA182BE;
	Wed,  3 Jan 2024 09:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtVWzHuD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mmNbBV2C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="AtVWzHuD";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="mmNbBV2C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C6C18AE8;
	Wed,  3 Jan 2024 09:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 013DD21C64;
	Wed,  3 Jan 2024 09:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704273290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRZ2aUMbqlaAIRlYGl9VBJK21WKEAOCW3XaQryG78/A=;
	b=AtVWzHuDGz6J/vwxZq27QNZA4f5WAbMHAp4SmB9hZPYaAUcKZ8KtUrzdc4Z45r15R+hn6A
	msS8zcd8WJntRYlRiFi3w/XhYX1rIi4qpI+uIE7rJnSnPb7mPKAN/63843fwNE4bUkpH+q
	udn7kynxADRZI0TYIW/2rBE9Nn1Rusw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704273290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRZ2aUMbqlaAIRlYGl9VBJK21WKEAOCW3XaQryG78/A=;
	b=mmNbBV2CsaewPSvhMj8jx7XDV1HqVhNpTOk8RP+Y8viSMXPirP+Z2LEl0oL8y5uJ4dNfVC
	Dv/6j1RMIPgoKZCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704273290; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRZ2aUMbqlaAIRlYGl9VBJK21WKEAOCW3XaQryG78/A=;
	b=AtVWzHuDGz6J/vwxZq27QNZA4f5WAbMHAp4SmB9hZPYaAUcKZ8KtUrzdc4Z45r15R+hn6A
	msS8zcd8WJntRYlRiFi3w/XhYX1rIi4qpI+uIE7rJnSnPb7mPKAN/63843fwNE4bUkpH+q
	udn7kynxADRZI0TYIW/2rBE9Nn1Rusw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704273290;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MRZ2aUMbqlaAIRlYGl9VBJK21WKEAOCW3XaQryG78/A=;
	b=mmNbBV2CsaewPSvhMj8jx7XDV1HqVhNpTOk8RP+Y8viSMXPirP+Z2LEl0oL8y5uJ4dNfVC
	Dv/6j1RMIPgoKZCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DED2F13AA6;
	Wed,  3 Jan 2024 09:14:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 3glkNokllWVKawAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 03 Jan 2024 09:14:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7C30CA07EF; Wed,  3 Jan 2024 10:14:49 +0100 (CET)
Date: Wed, 3 Jan 2024 10:14:49 +0100
From: Jan Kara <jack@suse.cz>
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 8/9] ext4: remove unnecessary parameter "needed" in
 ext4_discard_preallocations
Message-ID: <20240103091449.djg4tepqfbizi75h@quack3>
References: <20240103102821.448134-1-shikemeng@huaweicloud.com>
 <20240103102821.448134-9-shikemeng@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240103102821.448134-9-shikemeng@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.31 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCVD_DKIM_ARC_DNSWL_HI(-1.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	 MIME_GOOD(-0.10)[text/plain];
	 RCPT_COUNT_FIVE(0.00)[6];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,huaweicloud.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_IN_DNSWL_HI(-0.50)[2a07:de40:b281:106:10:150:64:167:received];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=AtVWzHuD;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=mmNbBV2C
X-Spam-Score: -4.31
X-Rspamd-Queue-Id: 013DD21C64

On Wed 03-01-24 18:28:20, Kemeng Shi wrote:
> The "needed" controls the number of ext4_prealloc_space to discard in
> ext4_discard_preallocations. Function ext4_discard_preallocations is
> supposed to discard all non-used preallocated blocks when "needed"
> is 0 and now ext4_discard_preallocations is always called with "needed"
> = 0. Remove unnecessary parameter "needed" and remove all non-used
> preallocated spaces in ext4_discard_preallocations to simplify the
> code.
> 
> Note: If count of non-used preallocated spaces could be more than
> UINT_MAX, there was a memory leak as some non-used preallocated
> spaces are left ununsed and this commit will fix it. Otherwise,
> there is no behavior change.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h        |  2 +-
>  fs/ext4/extents.c     | 10 +++++-----
>  fs/ext4/file.c        |  2 +-
>  fs/ext4/indirect.c    |  2 +-
>  fs/ext4/inode.c       |  6 +++---
>  fs/ext4/ioctl.c       |  2 +-
>  fs/ext4/mballoc.c     | 10 +++-------
>  fs/ext4/move_extent.c |  4 ++--
>  fs/ext4/super.c       |  2 +-
>  9 files changed, 18 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index fb35cae16..2fd444034 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -2905,7 +2905,7 @@ extern int ext4_mb_init(struct super_block *);
>  extern void ext4_mb_release(struct super_block *);
>  extern ext4_fsblk_t ext4_mb_new_blocks(handle_t *,
>  				struct ext4_allocation_request *, int *);
> -extern void ext4_discard_preallocations(struct inode *, unsigned int);
> +extern void ext4_discard_preallocations(struct inode *);
>  extern int __init ext4_init_mballoc(void);
>  extern void ext4_exit_mballoc(void);
>  extern ext4_group_t ext4_mb_prefetch(struct super_block *sb,
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 880f383df..fd350889a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -100,7 +100,7 @@ static int ext4_ext_trunc_restart_fn(struct inode *inode, int *dropped)
>  	 * i_rwsem. So we can safely drop the i_data_sem here.
>  	 */
>  	BUG_ON(EXT4_JOURNAL(inode) == NULL);
> -	ext4_discard_preallocations(inode, 0);
> +	ext4_discard_preallocations(inode);
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  	*dropped = 1;
>  	return 0;
> @@ -4313,7 +4313,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  			 * not a good idea to call discard here directly,
>  			 * but otherwise we'd need to call it every free().
>  			 */
> -			ext4_discard_preallocations(inode, 0);
> +			ext4_discard_preallocations(inode);
>  			if (flags & EXT4_GET_BLOCKS_DELALLOC_RESERVE)
>  				fb_flags = EXT4_FREE_BLOCKS_NO_QUOT_UPDATE;
>  			ext4_free_blocks(handle, inode, NULL, newblock,
> @@ -5354,7 +5354,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  	ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_FALLOC_RANGE, handle);
>  
>  	down_write(&EXT4_I(inode)->i_data_sem);
> -	ext4_discard_preallocations(inode, 0);
> +	ext4_discard_preallocations(inode);
>  	ext4_es_remove_extent(inode, punch_start, EXT_MAX_BLOCKS - punch_start);
>  
>  	ret = ext4_ext_remove_space(inode, punch_start, punch_stop - 1);
> @@ -5362,7 +5362,7 @@ static int ext4_collapse_range(struct file *file, loff_t offset, loff_t len)
>  		up_write(&EXT4_I(inode)->i_data_sem);
>  		goto out_stop;
>  	}
> -	ext4_discard_preallocations(inode, 0);
> +	ext4_discard_preallocations(inode);
>  
>  	ret = ext4_ext_shift_extents(inode, handle, punch_stop,
>  				     punch_stop - punch_start, SHIFT_LEFT);
> @@ -5494,7 +5494,7 @@ static int ext4_insert_range(struct file *file, loff_t offset, loff_t len)
>  		goto out_stop;
>  
>  	down_write(&EXT4_I(inode)->i_data_sem);
> -	ext4_discard_preallocations(inode, 0);
> +	ext4_discard_preallocations(inode);
>  
>  	path = ext4_find_extent(inode, offset_lblk, NULL, 0);
>  	if (IS_ERR(path)) {
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 0166bb9ca..89cb28da8 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -174,7 +174,7 @@ static int ext4_release_file(struct inode *inode, struct file *filp)
>  			(atomic_read(&inode->i_writecount) == 1) &&
>  			!EXT4_I(inode)->i_reserved_data_blocks) {
>  		down_write(&EXT4_I(inode)->i_data_sem);
> -		ext4_discard_preallocations(inode, 0);
> +		ext4_discard_preallocations(inode);
>  		up_write(&EXT4_I(inode)->i_data_sem);
>  	}
>  	if (is_dx(inode) && filp->private_data)
> diff --git a/fs/ext4/indirect.c b/fs/ext4/indirect.c
> index a9f371611..d8ca7f64f 100644
> --- a/fs/ext4/indirect.c
> +++ b/fs/ext4/indirect.c
> @@ -714,7 +714,7 @@ static int ext4_ind_trunc_restart_fn(handle_t *handle, struct inode *inode,
>  	 * i_rwsem. So we can safely drop the i_data_sem here.
>  	 */
>  	BUG_ON(EXT4_JOURNAL(inode) == NULL);
> -	ext4_discard_preallocations(inode, 0);
> +	ext4_discard_preallocations(inode);
>  	up_write(&EXT4_I(inode)->i_data_sem);
>  	*dropped = 1;
>  	return 0;
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index d77323204..53ed4a0ad 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -371,7 +371,7 @@ void ext4_da_update_reserve_space(struct inode *inode,
>  	 */
>  	if ((ei->i_reserved_data_blocks == 0) &&
>  	    !inode_is_open_for_write(inode))
> -		ext4_discard_preallocations(inode, 0);
> +		ext4_discard_preallocations(inode);
>  }
>  
>  static int __check_block_validity(struct inode *inode, const char *func,
> @@ -4014,7 +4014,7 @@ int ext4_punch_hole(struct file *file, loff_t offset, loff_t length)
>  	if (stop_block > first_block) {
>  
>  		down_write(&EXT4_I(inode)->i_data_sem);
> -		ext4_discard_preallocations(inode, 0);
> +		ext4_discard_preallocations(inode);
>  
>  		ext4_es_remove_extent(inode, first_block,
>  				      stop_block - first_block);
> @@ -4167,7 +4167,7 @@ int ext4_truncate(struct inode *inode)
>  
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  
> -	ext4_discard_preallocations(inode, 0);
> +	ext4_discard_preallocations(inode);
>  
>  	if (ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
>  		err = ext4_ext_truncate(handle, inode);
> diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> index 0bfe2ce58..2e2bcd22b 100644
> --- a/fs/ext4/ioctl.c
> +++ b/fs/ext4/ioctl.c
> @@ -458,7 +458,7 @@ static long swap_inode_boot_loader(struct super_block *sb,
>  	ext4_reset_inode_seed(inode);
>  	ext4_reset_inode_seed(inode_bl);
>  
> -	ext4_discard_preallocations(inode, 0);
> +	ext4_discard_preallocations(inode);
>  
>  	err = ext4_mark_inode_dirty(handle, inode);
>  	if (err < 0) {
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index e6561a09d..0e6beb3b4 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -5469,7 +5469,7 @@ ext4_mb_discard_group_preallocations(struct super_block *sb,
>   *
>   * FIXME!! Make sure it is valid at all the call sites
>   */
> -void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
> +void ext4_discard_preallocations(struct inode *inode)
>  {
>  	struct ext4_inode_info *ei = EXT4_I(inode);
>  	struct super_block *sb = inode->i_sb;
> @@ -5491,15 +5491,12 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  	mb_debug(sb, "discard preallocation for inode %lu\n",
>  		 inode->i_ino);
>  	trace_ext4_discard_preallocations(inode,
> -			atomic_read(&ei->i_prealloc_active), needed);
> -
> -	if (needed == 0)
> -		needed = UINT_MAX;
> +			atomic_read(&ei->i_prealloc_active), 0);
>  
>  repeat:
>  	/* first, collect all pa's in the inode */
>  	write_lock(&ei->i_prealloc_lock);
> -	for (iter = rb_first(&ei->i_prealloc_node); iter && needed;
> +	for (iter = rb_first(&ei->i_prealloc_node); iter;
>  	     iter = rb_next(iter)) {
>  		pa = rb_entry(iter, struct ext4_prealloc_space,
>  			      pa_node.inode_node);
> @@ -5523,7 +5520,6 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>  			spin_unlock(&pa->pa_lock);
>  			rb_erase(&pa->pa_node.inode_node, &ei->i_prealloc_node);
>  			list_add(&pa->u.pa_tmp_list, &list);
> -			needed--;
>  			continue;
>  		}
>  
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 18a9e7c47..0abfc104a 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -689,8 +689,8 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  
>  out:
>  	if (*moved_len) {
> -		ext4_discard_preallocations(orig_inode, 0);
> -		ext4_discard_preallocations(donor_inode, 0);
> +		ext4_discard_preallocations(orig_inode);
> +		ext4_discard_preallocations(donor_inode);
>  	}
>  
>  	ext4_free_ext_path(path);
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index d062383ea..c0cfc3e46 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -1518,7 +1518,7 @@ void ext4_clear_inode(struct inode *inode)
>  	ext4_fc_del(inode);
>  	invalidate_inode_buffers(inode);
>  	clear_inode(inode);
> -	ext4_discard_preallocations(inode, 0);
> +	ext4_discard_preallocations(inode);
>  	ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
>  	dquot_drop(inode);
>  	if (EXT4_I(inode)->jinode) {
> -- 
> 2.30.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

