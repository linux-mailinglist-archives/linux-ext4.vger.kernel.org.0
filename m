Return-Path: <linux-ext4+bounces-6400-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CE85A2F413
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 17:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25369162C7A
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Feb 2025 16:48:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF19B2586C7;
	Mon, 10 Feb 2025 16:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="aiiLJv/3";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Oa4Zd3Jr";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="CbluEba2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1Ox9phsn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682832586C5
	for <linux-ext4@vger.kernel.org>; Mon, 10 Feb 2025 16:47:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739206074; cv=none; b=qkrXK4V4stHYnsPhnuCtzEMh5ng749hqZzEvreG/ovRSZYyVvFuk9wFVyNqJzI3kVxQlOWLoz4jnIoB3utG+4a4U5/qYuux/tYvsXIJvtQU750MoRf9W8E4GzBh4DC11b/Yvm7lYBH+hnBGOU6l4VUgaGQE2mIB2a1tmuAQoup4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739206074; c=relaxed/simple;
	bh=fMEk+o4n6IuIDE40B7rZIBWoqe2qCTBkQVrFJmLvb4g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DTzmSNQHDH35ARy2iEMQkWwYTsYQ7BkwqDwCK2dWHUNgeId++HSn5EopVcC2MqbtlPMjkuDyUXU6EWG8zekCuW0Qwz0ZYoesoRcwdaog7Peul8Wyir1Zf0lWOp7EAa1n/KG+U97Gdtyd8GX96J8vAcaUZDniFKadEz3LXMfvWxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=aiiLJv/3; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=Oa4Zd3Jr; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=CbluEba2; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=1Ox9phsn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4AEF321111;
	Mon, 10 Feb 2025 16:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739206070; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BAs6xwqD76rxOgsXb2gW1zc1x+qIWYctyh7/Cm2aV2k=;
	b=aiiLJv/3iNSYdHOdGdzWT8LZP+YRpK0pehTFhEu0WB29BxDMdxml62UCVWMCLkfztzuT+m
	9QoRKW3L1GMkBeVrT+RdaJdkSGxSM6B0jincak5hjAb8Z8f3r7v3rOsb+mrlUXkRUgr/xY
	GWSGRpCMG5Yd25I70Gveazwslkx1KAU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739206070;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BAs6xwqD76rxOgsXb2gW1zc1x+qIWYctyh7/Cm2aV2k=;
	b=Oa4Zd3Jr8gn9+PIVUNLLnfoSUU7/wCD4iODBup0YTLfDmXfSo5jBKghTECBg9/+vlBAZ+W
	J3xR8lj2wG1+p+Cw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=CbluEba2;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=1Ox9phsn
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1739206069; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BAs6xwqD76rxOgsXb2gW1zc1x+qIWYctyh7/Cm2aV2k=;
	b=CbluEba2s7A1lxO1CsspQZwz4qX6xryzMWMd9IZDzrCsXVDL4nYWgvTXHFVJaXiSwhNbPd
	f7kd1qrn2Uxj5BGdxM9U89Ndiy4Ec4CnHmmAh5dA9R3V8KJduJSffRKYSQ8lJxiAg6Dw3G
	w8gIf4izE1sXqQkU3PYusH6BV4D6nNg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1739206069;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BAs6xwqD76rxOgsXb2gW1zc1x+qIWYctyh7/Cm2aV2k=;
	b=1Ox9phsnw/RraX8Qf7ysIMvL4G1+0XI7ArSDozxYYKNc1yhBpAPtlFA6MMVgwYsd7ppXLT
	GKlqwB8iv1SgO0Bw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 200C413707;
	Mon, 10 Feb 2025 16:47:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id WKPPB7UtqmcsUwAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Feb 2025 16:47:49 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9CD83A095C; Mon, 10 Feb 2025 17:47:44 +0100 (CET)
Date: Mon, 10 Feb 2025 17:47:44 +0100
From: Jan Kara <jack@suse.cz>
To: Ye Bin <yebin@huaweicloud.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, 
	jack@suse.cz
Subject: Re: [PATCH v2 2/2] ext4: fix out-of-bound read in
 ext4_xattr_inode_dec_ref_all()
Message-ID: <qqakibtcdtelsimkdghuoigdwtqhxwpii3ts5wohcw2qdt5rrz@vl2v72yxhk5n>
References: <20250208063141.1539283-1-yebin@huaweicloud.com>
 <20250208063141.1539283-3-yebin@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250208063141.1539283-3-yebin@huaweicloud.com>
X-Rspamd-Queue-Id: 4AEF321111
X-Spam-Level: 
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,iloc.bh:url];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -4.01
X-Spam-Flag: NO

On Sat 08-02-25 14:31:41, Ye Bin wrote:
> From: Ye Bin <yebin10@huawei.com>
> 
> There's issue as follows:
> BUG: KASAN: use-after-free in ext4_xattr_inode_dec_ref_all+0x6ff/0x790
> Read of size 4 at addr ffff88807b003000 by task syz-executor.0/15172
> 
> CPU: 3 PID: 15172 Comm: syz-executor.0
> Call Trace:
>  __dump_stack lib/dump_stack.c:82 [inline]
>  dump_stack+0xbe/0xfd lib/dump_stack.c:123
>  print_address_description.constprop.0+0x1e/0x280 mm/kasan/report.c:400
>  __kasan_report.cold+0x6c/0x84 mm/kasan/report.c:560
>  kasan_report+0x3a/0x50 mm/kasan/report.c:585
>  ext4_xattr_inode_dec_ref_all+0x6ff/0x790 fs/ext4/xattr.c:1137
>  ext4_xattr_delete_inode+0x4c7/0xda0 fs/ext4/xattr.c:2896
>  ext4_evict_inode+0xb3b/0x1670 fs/ext4/inode.c:323
>  evict+0x39f/0x880 fs/inode.c:622
>  iput_final fs/inode.c:1746 [inline]
>  iput fs/inode.c:1772 [inline]
>  iput+0x525/0x6c0 fs/inode.c:1758
>  ext4_orphan_cleanup fs/ext4/super.c:3298 [inline]
>  ext4_fill_super+0x8c57/0xba40 fs/ext4/super.c:5300
>  mount_bdev+0x355/0x410 fs/super.c:1446
>  legacy_get_tree+0xfe/0x220 fs/fs_context.c:611
>  vfs_get_tree+0x8d/0x2f0 fs/super.c:1576
>  do_new_mount fs/namespace.c:2983 [inline]
>  path_mount+0x119a/0x1ad0 fs/namespace.c:3316
>  do_mount+0xfc/0x110 fs/namespace.c:3329
>  __do_sys_mount fs/namespace.c:3540 [inline]
>  __se_sys_mount+0x219/0x2e0 fs/namespace.c:3514
>  do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
>  entry_SYSCALL_64_after_hwframe+0x67/0xd1
> 
> Memory state around the buggy address:
>  ffff88807b002f00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
>  ffff88807b002f80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> >ffff88807b003000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                    ^
>  ffff88807b003080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff88807b003100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> 
> Above issue happens as ext4_xattr_delete_inode() isn't check xattr
> is valid if xattr is in inode.
> To solve above issue call xattr_check_inode() check if xattr if valid
> in inode. In fact, we can directly verify in ext4_iget_extra_inode(),
> so that there is no divergent verification.
> 
> Fixes: e50e5129f384 ("ext4: xattr-in-inode support")
> Signed-off-by: Ye Bin <yebin10@huawei.com>

Nice! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c |  5 +++++
>  fs/ext4/xattr.c | 26 +-------------------------
>  fs/ext4/xattr.h |  7 +++++++
>  3 files changed, 13 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 7c54ae5fcbd4..af735386aa44 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -4674,6 +4674,11 @@ static inline int ext4_iget_extra_inode(struct inode *inode,
>  	    *magic == cpu_to_le32(EXT4_XATTR_MAGIC)) {
>  		int err;
>  
> +		err = xattr_check_inode(inode, IHDR(inode, raw_inode),
> +					ITAIL(inode, raw_inode));
> +		if (err)
> +			return err;
> +
>  		ext4_set_inode_state(inode, EXT4_STATE_XATTR);
>  		err = ext4_find_inline_data_nolock(inode);
>  		if (!err && ext4_has_inline_data(inode))
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 0e4494863d15..a10fb8a9d02d 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -308,7 +308,7 @@ __ext4_xattr_check_block(struct inode *inode, struct buffer_head *bh,
>  	__ext4_xattr_check_block((inode), (bh),  __func__, __LINE__)
>  
>  
> -static inline int
> +int
>  __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
>  			 void *end, const char *function, unsigned int line)
>  {
> @@ -316,9 +316,6 @@ __xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
>  			    function, line);
>  }
>  
> -#define xattr_check_inode(inode, header, end) \
> -	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
> -
>  static int
>  xattr_find_entry(struct inode *inode, struct ext4_xattr_entry **pentry,
>  		 void *end, int name_index, const char *name, int sorted)
> @@ -650,9 +647,6 @@ ext4_xattr_ibody_get(struct inode *inode, int name_index, const char *name,
>  	raw_inode = ext4_raw_inode(&iloc);
>  	header = IHDR(inode, raw_inode);
>  	end = ITAIL(inode, raw_inode);
> -	error = xattr_check_inode(inode, header, end);
> -	if (error)
> -		goto cleanup;
>  	entry = IFIRST(header);
>  	error = xattr_find_entry(inode, &entry, end, name_index, name, 0);
>  	if (error)
> @@ -783,7 +777,6 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  	struct ext4_xattr_ibody_header *header;
>  	struct ext4_inode *raw_inode;
>  	struct ext4_iloc iloc;
> -	void *end;
>  	int error;
>  
>  	if (!ext4_test_inode_state(inode, EXT4_STATE_XATTR))
> @@ -793,14 +786,9 @@ ext4_xattr_ibody_list(struct dentry *dentry, char *buffer, size_t buffer_size)
>  		return error;
>  	raw_inode = ext4_raw_inode(&iloc);
>  	header = IHDR(inode, raw_inode);
> -	end = ITAIL(inode, raw_inode);
> -	error = xattr_check_inode(inode, header, end);
> -	if (error)
> -		goto cleanup;
>  	error = ext4_xattr_list_entries(dentry, IFIRST(header),
>  					buffer, buffer_size);
>  
> -cleanup:
>  	brelse(iloc.bh);
>  	return error;
>  }
> @@ -868,7 +856,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
>  	struct ext4_xattr_ibody_header *header;
>  	struct ext4_xattr_entry *entry;
>  	qsize_t ea_inode_refs = 0;
> -	void *end;
>  	int ret;
>  
>  	lockdep_assert_held_read(&EXT4_I(inode)->xattr_sem);
> @@ -879,10 +866,6 @@ int ext4_get_inode_usage(struct inode *inode, qsize_t *usage)
>  			goto out;
>  		raw_inode = ext4_raw_inode(&iloc);
>  		header = IHDR(inode, raw_inode);
> -		end = ITAIL(inode, raw_inode);
> -		ret = xattr_check_inode(inode, header, end);
> -		if (ret)
> -			goto out;
>  
>  		for (entry = IFIRST(header); !IS_LAST_ENTRY(entry);
>  		     entry = EXT4_XATTR_NEXT(entry))
> @@ -2237,9 +2220,6 @@ int ext4_xattr_ibody_find(struct inode *inode, struct ext4_xattr_info *i,
>  	is->s.here = is->s.first;
>  	is->s.end = ITAIL(inode, raw_inode);
>  	if (ext4_test_inode_state(inode, EXT4_STATE_XATTR)) {
> -		error = xattr_check_inode(inode, header, is->s.end);
> -		if (error)
> -			return error;
>  		/* Find the named attribute. */
>  		error = xattr_find_entry(inode, &is->s.here, is->s.end,
>  					 i->name_index, i->name, 0);
> @@ -2790,10 +2770,6 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
>  	min_offs = end - base;
>  	total_ino = sizeof(struct ext4_xattr_ibody_header) + sizeof(u32);
>  
> -	error = xattr_check_inode(inode, header, end);
> -	if (error)
> -		goto cleanup;
> -
>  	ifree = ext4_xattr_free_space(base, &min_offs, base, &total_ino);
>  	if (ifree >= isize_diff)
>  		goto shift;
> diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
> index 5197f17ffd9a..1fedf44d4fb6 100644
> --- a/fs/ext4/xattr.h
> +++ b/fs/ext4/xattr.h
> @@ -209,6 +209,13 @@ extern int ext4_xattr_ibody_set(handle_t *handle, struct inode *inode,
>  extern struct mb_cache *ext4_xattr_create_cache(void);
>  extern void ext4_xattr_destroy_cache(struct mb_cache *);
>  
> +extern int
> +__xattr_check_inode(struct inode *inode, struct ext4_xattr_ibody_header *header,
> +		    void *end, const char *function, unsigned int line);
> +
> +#define xattr_check_inode(inode, header, end) \
> +	__xattr_check_inode((inode), (header), (end), __func__, __LINE__)
> +
>  #ifdef CONFIG_EXT4_FS_SECURITY
>  extern int ext4_init_security(handle_t *handle, struct inode *inode,
>  			      struct inode *dir, const struct qstr *qstr);
> -- 
> 2.34.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

