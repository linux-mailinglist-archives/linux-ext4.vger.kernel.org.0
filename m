Return-Path: <linux-ext4+bounces-4275-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 014AC97EA9D
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 13:24:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 54342B21352
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Sep 2024 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47ECF197A9B;
	Mon, 23 Sep 2024 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mph1deyy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dDQKXqd+";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Mph1deyy";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="dDQKXqd+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C60B7944E;
	Mon, 23 Sep 2024 11:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727090629; cv=none; b=S9lDzb3WOfaQHUgyv6e8vuwyVHKsJgh0q1TiPOI6DWSQUS76l8bXsM+chstWTCfjfz7zF6qPWX6dlMHGKj3YPfFuBsXPex+umuQW+Cw2AOQtvTYwm8ITNyKR0JtWa6yIxUHwU8QPSR5IlJDUr6xUeWOQ0mqEh2tAUGciP6Jki3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727090629; c=relaxed/simple;
	bh=J1FZc9lUJ8SyGx26HH0Zdfid/G+1gNXuBCYuEkGIvg4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oMhM7k9FcLtAK2pZG9YaJErHxpnNT8gqtlqyNWmJm8n1kC59lGFm2mj9I3P6ZaGM/RlN9p2vmU9RKcdBN2F2LwPLTftT9LtOCzWEzV3VvvlWn2KDBO120xN8kuHlCF6eOH0GLhPSqwMGcXN5Ent5ynp7Ju/FyC40hNNUpbRyUzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mph1deyy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dDQKXqd+; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Mph1deyy; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=dDQKXqd+; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 072191FB87;
	Mon, 23 Sep 2024 11:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727090626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/eNAImhPdQF07yVCj2Vp+eSbcnuKFb/NjewBKPoSe/E=;
	b=Mph1deyy1s77ryFP81HzuENP5N/6vjkWrlYznoJikKsAZcpVif3icetkh2105dIIF0XLbF
	KFBAYqzhcIy4E1nREJKDX58Vmt4CGbN6nR2iLPZGQY0WAS4JAXIDDd92Mc5jr7kToGYpLR
	wYT6Wq+nK04f7NAx2AN6Vj/uEq7qlc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727090626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/eNAImhPdQF07yVCj2Vp+eSbcnuKFb/NjewBKPoSe/E=;
	b=dDQKXqd+2Y0vbM2Ao269q4hCX0zStUxazKBp7EOdFXLwr3SnLNSPV1jna5yxos+eqv1P6t
	n29d61VFAuTP6wCg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1727090626; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/eNAImhPdQF07yVCj2Vp+eSbcnuKFb/NjewBKPoSe/E=;
	b=Mph1deyy1s77ryFP81HzuENP5N/6vjkWrlYznoJikKsAZcpVif3icetkh2105dIIF0XLbF
	KFBAYqzhcIy4E1nREJKDX58Vmt4CGbN6nR2iLPZGQY0WAS4JAXIDDd92Mc5jr7kToGYpLR
	wYT6Wq+nK04f7NAx2AN6Vj/uEq7qlc8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1727090626;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/eNAImhPdQF07yVCj2Vp+eSbcnuKFb/NjewBKPoSe/E=;
	b=dDQKXqd+2Y0vbM2Ao269q4hCX0zStUxazKBp7EOdFXLwr3SnLNSPV1jna5yxos+eqv1P6t
	n29d61VFAuTP6wCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB9061347F;
	Mon, 23 Sep 2024 11:23:45 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id pYAqOcFP8WYNKAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 23 Sep 2024 11:23:45 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 96E19A0844; Mon, 23 Sep 2024 13:23:41 +0200 (CEST)
Date: Mon, 23 Sep 2024 13:23:41 +0200
From: Jan Kara <jack@suse.cz>
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	Harshad Shirwadkar <harshadshirwadkar@gmail.com>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ext4: use handle to mark fc as ineligible in
 __track_dentry_update()
Message-ID: <20240923112341.tz3s5uww5fzkilkj@quack3>
References: <20240923104909.18342-1-luis.henriques@linux.dev>
 <20240923104909.18342-2-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240923104909.18342-2-luis.henriques@linux.dev>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[mit.edu,dilger.ca,suse.cz,gmail.com,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Mon 23-09-24 11:49:08, Luis Henriques (SUSE) wrote:
> Calling ext4_fc_mark_ineligible() with a NULL handle is racy and may result
> in a fast-commit being done before the filesystem is effectively marked as
> ineligible.  This patch fixes the calls to this function in
> __track_dentry_update() by adding an extra parameter to the callback used in
> ext4_fc_track_template().
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/fast_commit.c | 19 +++++++++++--------
>  1 file changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
> index 3926a05eceee..c330efd771d1 100644
> --- a/fs/ext4/fast_commit.c
> +++ b/fs/ext4/fast_commit.c
> @@ -372,7 +372,7 @@ void ext4_fc_mark_ineligible(struct super_block *sb, int reason, handle_t *handl
>   */
>  static int ext4_fc_track_template(
>  	handle_t *handle, struct inode *inode,
> -	int (*__fc_track_fn)(struct inode *, void *, bool),
> +	int (*__fc_track_fn)(handle_t *handle, struct inode *, void *, bool),
>  	void *args, int enqueue)
>  {
>  	bool update = false;
> @@ -389,7 +389,7 @@ static int ext4_fc_track_template(
>  		ext4_fc_reset_inode(inode);
>  		ei->i_sync_tid = tid;
>  	}
> -	ret = __fc_track_fn(inode, args, update);
> +	ret = __fc_track_fn(handle, inode, args, update);
>  	mutex_unlock(&ei->i_fc_lock);
>  
>  	if (!enqueue)
> @@ -413,7 +413,8 @@ struct __track_dentry_update_args {
>  };
>  
>  /* __track_fn for directory entry updates. Called with ei->i_fc_lock. */
> -static int __track_dentry_update(struct inode *inode, void *arg, bool update)
> +static int __track_dentry_update(handle_t *handle, struct inode *inode,
> +				 void *arg, bool update)
>  {
>  	struct ext4_fc_dentry_update *node;
>  	struct ext4_inode_info *ei = EXT4_I(inode);
> @@ -428,14 +429,14 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>  
>  	if (IS_ENCRYPTED(dir)) {
>  		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_ENCRYPTED_FILENAME,
> -					NULL);
> +					handle);
>  		mutex_lock(&ei->i_fc_lock);
>  		return -EOPNOTSUPP;
>  	}
>  
>  	node = kmem_cache_alloc(ext4_fc_dentry_cachep, GFP_NOFS);
>  	if (!node) {
> -		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, NULL);
> +		ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, handle);
>  		mutex_lock(&ei->i_fc_lock);
>  		return -ENOMEM;
>  	}
> @@ -447,7 +448,7 @@ static int __track_dentry_update(struct inode *inode, void *arg, bool update)
>  		node->fcd_name.name = kmalloc(dentry->d_name.len, GFP_NOFS);
>  		if (!node->fcd_name.name) {
>  			kmem_cache_free(ext4_fc_dentry_cachep, node);
> -			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, NULL);
> +			ext4_fc_mark_ineligible(sb, EXT4_FC_REASON_NOMEM, handle);
>  			mutex_lock(&ei->i_fc_lock);
>  			return -ENOMEM;
>  		}
> @@ -569,7 +570,8 @@ void ext4_fc_track_create(handle_t *handle, struct dentry *dentry)
>  }
>  
>  /* __track_fn for inode tracking */
> -static int __track_inode(struct inode *inode, void *arg, bool update)
> +static int __track_inode(handle_t *handle, struct inode *inode, void *arg,
> +			 bool update)
>  {
>  	if (update)
>  		return -EEXIST;
> @@ -607,7 +609,8 @@ struct __track_range_args {
>  };
>  
>  /* __track_fn for tracking data updates */
> -static int __track_range(struct inode *inode, void *arg, bool update)
> +static int __track_range(handle_t *handle, struct inode *inode, void *arg,
> +			 bool update)
>  {
>  	struct ext4_inode_info *ei = EXT4_I(inode);
>  	ext4_lblk_t oldstart;
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

