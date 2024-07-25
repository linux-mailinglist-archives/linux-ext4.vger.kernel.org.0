Return-Path: <linux-ext4+bounces-3449-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0596A93C036
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 12:42:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B608A281B31
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 10:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F2441991A3;
	Thu, 25 Jul 2024 10:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="OzptXv91";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="554nF6J4";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZiQU00SF";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="HHKT8WFH"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E061991A0;
	Thu, 25 Jul 2024 10:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721904071; cv=none; b=UbvChlF2v0rMBf1WHfSW/RDaPoZHU2xIc0pzYcqSPDYQ7ysJ5ppEoJBwcW4Wiu5KpuwgT9rzl4OVIMBvSh1Dtvf3SbxiXJfaU5SCHNRoAPZdHJr34+fmpgrT48/OvKbEHAH6975Par7qwF3zWe80LhBrL+aVgZebnBfWpwQDaB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721904071; c=relaxed/simple;
	bh=nGWAWAg+bLrpw5jqBhZxWTPAahTHXUCFq2Wvh8tsIbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CzzUCEd0o2VVV7YwEUOfZl7McRg8cfr2riuIrjVyF5GKPwuMCT97bQUHXmPNijdos9gQpMxennluIKGNeT/YO+/5J/yQvPB2qeKzJhjqp0B/BzVSVnqRPdA01Wp7nwQ7yOK+p2PTbJsdmvgvChtRnpZEmB12MjcpxGEAmQc0ysg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=OzptXv91; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=554nF6J4; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZiQU00SF; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=HHKT8WFH; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id AA82921A9E;
	Thu, 25 Jul 2024 10:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721904067; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IaynsW6MsLBzNbPu7NqwIL3MqshyR0+ZWoe+eptybgM=;
	b=OzptXv91pfAeqgmJNlPgB7wIPq/LS4ss6QSzw4jpQDBscYehhQ2G8wv17a8mv/VsSN+n7O
	0wNWdsPTOIIxh8gkieysv/aolwYjkPrIRTfx6penKTKHLD+5aj/untiwkUA4/yFNFZtjKK
	FPmraXVFhDA+UOVvdbuoE50/KIyqOa0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721904067;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IaynsW6MsLBzNbPu7NqwIL3MqshyR0+ZWoe+eptybgM=;
	b=554nF6J4F3hgl3S+MHBiajf0dHZbGct6YoraGRpw0Q7s9ozsImV5n9O0JwAP0nbz8EyVZB
	12jCtzvixcx7ReAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721904065; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IaynsW6MsLBzNbPu7NqwIL3MqshyR0+ZWoe+eptybgM=;
	b=ZiQU00SFM5yT6V9HHZG/0R7Au7URDi7S7oDF6IP4yOlPQX/Vy/IuN58PGCnKWTB1TYeK6s
	EdOr+1Z8USPw5RNZKL8l65X5PcRutxPRRWsSjGIue3DDqDy9q7U8kx5n8PvZ9XvTYYN0c7
	9UlcY9ncM1MTJpS26RvciFEcfsKfrx0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721904065;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IaynsW6MsLBzNbPu7NqwIL3MqshyR0+ZWoe+eptybgM=;
	b=HHKT8WFHBgIBwVrM2kDX4eQ8j5Kdn4z8s0Hu/kpnI+lw6yVuV/oHR/l+0CPwMzDWZqJ/ZY
	Cx79RFrHNOP79XDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8D7D613874;
	Thu, 25 Jul 2024 10:41:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id d9o0IsErombFTQAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 10:41:05 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 393B1A0996; Thu, 25 Jul 2024 12:41:05 +0200 (CEST)
Date: Thu, 25 Jul 2024 12:41:05 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 09/20] ext4: get rid of ppath in get_ext_path()
Message-ID: <20240725104105.5xtgze6cbhbqjsfv@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-10-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-10-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,huaweicloud.com:email,suse.cz:email,huawei.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Wed 10-07-24 12:06:43, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> After getting rid of ppath in get_ext_path(), its caller may pass an error
> pointer to ext4_free_ext_path(), so it needs to teach ext4_free_ext_path()
> and ext4_ext_drop_refs() to skip the error pointer. No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c     |  5 +++--
>  fs/ext4/move_extent.c | 34 +++++++++++++++++-----------------
>  2 files changed, 20 insertions(+), 19 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 5217e6f53467..6dfb5d03e197 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -116,7 +116,7 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
>  {
>  	int depth, i;
>  
> -	if (!path)
> +	if (IS_ERR_OR_NULL(path))
>  		return;
>  	depth = path->p_depth;
>  	for (i = 0; i <= depth; i++, path++)
> @@ -125,6 +125,8 @@ static void ext4_ext_drop_refs(struct ext4_ext_path *path)
>  
>  void ext4_free_ext_path(struct ext4_ext_path *path)
>  {
> +	if (IS_ERR_OR_NULL(path))
> +		return;
>  	ext4_ext_drop_refs(path);
>  	kfree(path);
>  }
> @@ -4191,7 +4193,6 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  	path = ext4_find_extent(inode, map->m_lblk, NULL, 0);
>  	if (IS_ERR(path)) {
>  		err = PTR_ERR(path);
> -		path = NULL;
>  		goto out;
>  	}
>  
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index b0ab19a913bf..a7186d63725a 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -17,27 +17,23 @@
>   * get_ext_path() - Find an extent path for designated logical block number.
>   * @inode:	inode to be searched
>   * @lblock:	logical block number to find an extent path
> - * @ppath:	pointer to an extent path pointer (for output)
> + * @path:	pointer to an extent path
>   *
> - * ext4_find_extent wrapper. Return 0 on success, or a negative error value
> - * on failure.
> + * ext4_find_extent wrapper. Return an extent path pointer on success,
> + * or an error pointer on failure.
>   */
> -static inline int
> +static inline struct ext4_ext_path *
>  get_ext_path(struct inode *inode, ext4_lblk_t lblock,
> -		struct ext4_ext_path **ppath)
> +	     struct ext4_ext_path *path)
>  {
> -	struct ext4_ext_path *path = *ppath;
> -
> -	*ppath = NULL;
>  	path = ext4_find_extent(inode, lblock, path, EXT4_EX_NOCACHE);
>  	if (IS_ERR(path))
> -		return PTR_ERR(path);
> +		return path;
>  	if (path[ext_depth(inode)].p_ext == NULL) {
>  		ext4_free_ext_path(path);
> -		return -ENODATA;
> +		return ERR_PTR(-ENODATA);
>  	}
> -	*ppath = path;
> -	return 0;
> +	return path;
>  }
>  
>  /**
> @@ -95,9 +91,11 @@ mext_check_coverage(struct inode *inode, ext4_lblk_t from, ext4_lblk_t count,
>  	int ret = 0;
>  	ext4_lblk_t last = from + count;
>  	while (from < last) {
> -		*err = get_ext_path(inode, from, &path);
> -		if (*err)
> -			goto out;
> +		path = get_ext_path(inode, from, path);
> +		if (IS_ERR(path)) {
> +			*err = PTR_ERR(path);
> +			return ret;
> +		}
>  		ext = path[ext_depth(inode)].p_ext;
>  		if (unwritten != ext4_ext_is_unwritten(ext))
>  			goto out;
> @@ -624,9 +622,11 @@ ext4_move_extents(struct file *o_filp, struct file *d_filp, __u64 orig_blk,
>  		int offset_in_page;
>  		int unwritten, cur_len;
>  
> -		ret = get_ext_path(orig_inode, o_start, &path);
> -		if (ret)
> +		path = get_ext_path(orig_inode, o_start, path);
> +		if (IS_ERR(path)) {
> +			ret = PTR_ERR(path);
>  			goto out;
> +		}
>  		ex = path[path->p_depth].p_ext;
>  		cur_blk = le32_to_cpu(ex->ee_block);
>  		cur_len = ext4_ext_get_actual_len(ex);
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

