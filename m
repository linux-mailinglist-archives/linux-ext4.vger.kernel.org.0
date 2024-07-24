Return-Path: <linux-ext4+bounces-3428-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2729993B6FA
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 20:44:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D072E2854F4
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 18:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 893A916B399;
	Wed, 24 Jul 2024 18:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hWaHe4ON";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8I2qiAnC";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="hWaHe4ON";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="8I2qiAnC"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C2A16A938;
	Wed, 24 Jul 2024 18:44:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721846678; cv=none; b=Ko3v5upr9m0b5lNJm/PUuthc7okQVN+p0do0hL6P3uW1culN4BZIVSWGkY0KHdszVrZ71zfNzkNIRl16eL7YwXkHjyphI1jDsQf3a8BEMIeLvOczaCM0WJ+saDc5Nqd/Mlt9Ij3xxcrfGlhier2H0kqqheQrhH4M2NP/KaY8NYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721846678; c=relaxed/simple;
	bh=EX2zHoBW3B4HB+bS8lwXQLuhZuCaknrOwMg3q2Gljc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mouxks0PIN6BRthhkLrt4OjriYuAJk358hTUz1RhPLgSgSXlcgywLvobKST4NYbA4pU1XrWh0CvAioVQLoHMF3gIHn+CGtuCMl5RJc7774sMH6Awr5Pg9NP0j4Uco6VYY+cqDantzu5GHVjLI7R8TOGVCFunghHpsc/UPY5Hm6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hWaHe4ON; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8I2qiAnC; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=hWaHe4ON; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=8I2qiAnC; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 97DEB1FBF2;
	Wed, 24 Jul 2024 18:44:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721846673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnNqvzAk/xF1TkOu8ZpdB3WtO4suUv+S3p6hBA3II2c=;
	b=hWaHe4ONAO7v+Xfn44CMFn2t4kYjPUXmok/oy/eg/tNlaX9B5VYzNcDUAH0GY1yS9xOFUt
	qeYGIqgtf3DgxBB2dQDO/2uO6K1gUZ33zRbmJLCrMg67CRh2GI94EX2YNy700YgjYZ8dLL
	Os4WLnC9q7ERWw40dY0xGuO4qWkvn2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721846673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnNqvzAk/xF1TkOu8ZpdB3WtO4suUv+S3p6hBA3II2c=;
	b=8I2qiAnCuEYiBPbqLX2v/rXThK5c5J5i9E81BHZp/kDWG5Xq+tG+g+IiB4Rdr6P4sJkqo4
	pqIh2SOV3U1Vp5BA==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=hWaHe4ON;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=8I2qiAnC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721846673; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnNqvzAk/xF1TkOu8ZpdB3WtO4suUv+S3p6hBA3II2c=;
	b=hWaHe4ONAO7v+Xfn44CMFn2t4kYjPUXmok/oy/eg/tNlaX9B5VYzNcDUAH0GY1yS9xOFUt
	qeYGIqgtf3DgxBB2dQDO/2uO6K1gUZ33zRbmJLCrMg67CRh2GI94EX2YNy700YgjYZ8dLL
	Os4WLnC9q7ERWw40dY0xGuO4qWkvn2Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721846673;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hnNqvzAk/xF1TkOu8ZpdB3WtO4suUv+S3p6hBA3II2c=;
	b=8I2qiAnCuEYiBPbqLX2v/rXThK5c5J5i9E81BHZp/kDWG5Xq+tG+g+IiB4Rdr6P4sJkqo4
	pqIh2SOV3U1Vp5BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 890B813411;
	Wed, 24 Jul 2024 18:44:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id CdwqIZFLoWZYagAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 18:44:33 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 2C130A08F2; Wed, 24 Jul 2024 20:44:33 +0200 (CEST)
Date: Wed, 24 Jul 2024 20:44:33 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 01/20] ext4: refactor ext4_ext_rm_idx() to index 'path'
Message-ID: <20240724184433.awap74owddwfm3dm@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-2-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240710040654.1714672-2-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	URIBL_BLOCKED(0.00)[suse.cz:email,suse.cz:dkim,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:email,huawei.com:email];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -2.31
X-Rspamd-Queue-Id: 97DEB1FBF2

On Wed 10-07-24 12:06:35, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> As suggested by Honza in Link，modify ext4_ext_rm_idx() to leave 'path'
> alone and just index it like ext4_ext_correct_indexes() does it. This
> facilitates adding error handling later. No functional changes.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://lore.kernel.org/all/20230216130305.nrbtd42tppxhbynn@quack3/
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Yeah, nice. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 32 +++++++++++++++-----------------
>  1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e067f2dd0335..bff3666c891a 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2279,27 +2279,26 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>  {
>  	int err;
>  	ext4_fsblk_t leaf;
> +	int k = depth - 1;
>  
>  	/* free index block */
> -	depth--;
> -	path = path + depth;
> -	leaf = ext4_idx_pblock(path->p_idx);
> -	if (unlikely(path->p_hdr->eh_entries == 0)) {
> -		EXT4_ERROR_INODE(inode, "path->p_hdr->eh_entries == 0");
> +	leaf = ext4_idx_pblock(path[k].p_idx);
> +	if (unlikely(path[k].p_hdr->eh_entries == 0)) {
> +		EXT4_ERROR_INODE(inode, "path[%d].p_hdr->eh_entries == 0", k);
>  		return -EFSCORRUPTED;
>  	}
> -	err = ext4_ext_get_access(handle, inode, path);
> +	err = ext4_ext_get_access(handle, inode, path + k);
>  	if (err)
>  		return err;
>  
> -	if (path->p_idx != EXT_LAST_INDEX(path->p_hdr)) {
> -		int len = EXT_LAST_INDEX(path->p_hdr) - path->p_idx;
> +	if (path[k].p_idx != EXT_LAST_INDEX(path[k].p_hdr)) {
> +		int len = EXT_LAST_INDEX(path[k].p_hdr) - path[k].p_idx;
>  		len *= sizeof(struct ext4_extent_idx);
> -		memmove(path->p_idx, path->p_idx + 1, len);
> +		memmove(path[k].p_idx, path[k].p_idx + 1, len);
>  	}
>  
> -	le16_add_cpu(&path->p_hdr->eh_entries, -1);
> -	err = ext4_ext_dirty(handle, inode, path);
> +	le16_add_cpu(&path[k].p_hdr->eh_entries, -1);
> +	err = ext4_ext_dirty(handle, inode, path + k);
>  	if (err)
>  		return err;
>  	ext_debug(inode, "index is empty, remove it, free block %llu\n", leaf);
> @@ -2308,15 +2307,14 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>  	ext4_free_blocks(handle, inode, NULL, leaf, 1,
>  			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
>  
> -	while (--depth >= 0) {
> -		if (path->p_idx != EXT_FIRST_INDEX(path->p_hdr))
> +	while (--k >= 0) {
> +		if (path[k + 1].p_idx != EXT_FIRST_INDEX(path[k + 1].p_hdr))
>  			break;
> -		path--;
> -		err = ext4_ext_get_access(handle, inode, path);
> +		err = ext4_ext_get_access(handle, inode, path + k);
>  		if (err)
>  			break;
> -		path->p_idx->ei_block = (path+1)->p_idx->ei_block;
> -		err = ext4_ext_dirty(handle, inode, path);
> +		path[k].p_idx->ei_block = path[k + 1].p_idx->ei_block;
> +		err = ext4_ext_dirty(handle, inode, path + k);
>  		if (err)
>  			break;
>  	}
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

