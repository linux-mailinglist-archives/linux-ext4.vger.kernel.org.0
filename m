Return-Path: <linux-ext4+bounces-3453-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 293FD93C09C
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 13:14:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 958651F221D8
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 11:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDE081991C9;
	Thu, 25 Jul 2024 11:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q2opgp2x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uwUcucuJ";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q2opgp2x";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="uwUcucuJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5612B132492;
	Thu, 25 Jul 2024 11:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721906076; cv=none; b=JPwko0dOtaPnlSClzR0S8H2l+jDfrEtFtSYXLH37dFyqebwZobgJ32QT5l7w1Bjqx1TRWiJ5l140jrM7shu/Ni4QtPTOJdz51bPTNdlX097JkeXlD9VBqAFmNyDQlztJGA1FiTCDK/0htTplbA9xtkAPEcbw9+AFxN8727Vjgr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721906076; c=relaxed/simple;
	bh=+yO49i2F94ap2NyeAO/SLtx3klpmtDfQbUf59znw70g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pxJcYYWVd5YC2rBipdln5fRjnkvKynybshcLDtMptGSi3h9lF54A4DVAxu4lBHDafteAUHZn01YsM6VfNDxNaf8ZVbR+jd/f2YEqsWFETYqpsdgYnnUwCVE5snIiIRaHx2pmLwE9zJJ9MK9VROCmmM0EprMZ8TblPBqTpRQKHRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q2opgp2x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uwUcucuJ; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=Q2opgp2x; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=uwUcucuJ; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5F34021903;
	Thu, 25 Jul 2024 11:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721906072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDCy6K/dKkl/n8DknqaZMbGrdGJRue7VlG1IzWqYk18=;
	b=Q2opgp2xtvSB/RJ7PEiuo4bmDEy/DCwSS0RCpoZg+MOuVIVqx8ZwFFPB22wMupcBFXxQVC
	+1u7VgxKyeyJrNJVinikgDpQulLxDa4ZuKIrZuNLkFoCBvKiD/Y1nZGE7q5u1X0GB219R0
	KSC58wzS4T6Z8C+SFIYduPJcWowqdXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721906072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDCy6K/dKkl/n8DknqaZMbGrdGJRue7VlG1IzWqYk18=;
	b=uwUcucuJFgrYp/1pma2UJ6o+5WcTdLldtbkq0kEKjQpIjX97t/7aHjKerRguJv6/JiA3LN
	wrbBjtutyCWfEICA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=Q2opgp2x;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=uwUcucuJ
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721906072; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDCy6K/dKkl/n8DknqaZMbGrdGJRue7VlG1IzWqYk18=;
	b=Q2opgp2xtvSB/RJ7PEiuo4bmDEy/DCwSS0RCpoZg+MOuVIVqx8ZwFFPB22wMupcBFXxQVC
	+1u7VgxKyeyJrNJVinikgDpQulLxDa4ZuKIrZuNLkFoCBvKiD/Y1nZGE7q5u1X0GB219R0
	KSC58wzS4T6Z8C+SFIYduPJcWowqdXQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721906072;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gDCy6K/dKkl/n8DknqaZMbGrdGJRue7VlG1IzWqYk18=;
	b=uwUcucuJFgrYp/1pma2UJ6o+5WcTdLldtbkq0kEKjQpIjX97t/7aHjKerRguJv6/JiA3LN
	wrbBjtutyCWfEICA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 523BC13874;
	Thu, 25 Jul 2024 11:14:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RKMNFJgzomZOWAAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 25 Jul 2024 11:14:32 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 0FE46A0996; Thu, 25 Jul 2024 13:14:28 +0200 (CEST)
Date: Thu, 25 Jul 2024 13:14:28 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 13/20] ext4: get rid of ppath in
 ext4_force_split_extent_at()
Message-ID: <20240725111428.m3boj5le2cidgmwb@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-14-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-14-libaokun@huaweicloud.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: 5F34021903
X-Spam-Score: -2.31
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.31 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	DWL_DNSWL_BLOCKED(0.00)[suse.cz:dkim];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:email,suse.cz:dkim,suse.com:email]

On Wed 10-07-24 12:06:47, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The use of path and ppath is now very confusing, so to make the code more
> readable, pass path between functions uniformly, and get rid of ppath.
> 
> To get rid of the ppath in ext4_force_split_extent_at(), the following is
> done here:
> 
>  * The ext4_find_extent() can update the extent path so it doesn't have to
>    allocate and free path repeatedly, thus reducing the consumption of
>    memory allocation and freeing in ext4_swap_extents().
> 
> No functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 117 ++++++++++++++++++++++++----------------------
>  1 file changed, 60 insertions(+), 57 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index c86b1bb7720f..0bd068ed324f 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -328,27 +328,20 @@ static inline int ext4_ext_space_root_idx(struct inode *inode, int check)
>  	return size;
>  }
>  
> -static inline int
> +static inline struct ext4_ext_path *
>  ext4_force_split_extent_at(handle_t *handle, struct inode *inode,
> -			   struct ext4_ext_path **ppath, ext4_lblk_t lblk,
> +			   struct ext4_ext_path *path, ext4_lblk_t lblk,
>  			   int nofail)
>  {
> -	struct ext4_ext_path *path = *ppath;
>  	int unwritten = ext4_ext_is_unwritten(path[path->p_depth].p_ext);
>  	int flags = EXT4_EX_NOCACHE | EXT4_GET_BLOCKS_PRE_IO;
>  
>  	if (nofail)
>  		flags |= EXT4_GET_BLOCKS_METADATA_NOFAIL | EXT4_EX_NOFAIL;
>  
> -	path = ext4_split_extent_at(handle, inode, path, lblk, unwritten ?
> +	return ext4_split_extent_at(handle, inode, path, lblk, unwritten ?
>  			EXT4_EXT_MARK_UNWRIT1|EXT4_EXT_MARK_UNWRIT2 : 0,
>  			flags);
> -	if (IS_ERR(path)) {
> -		*ppath = NULL;
> -		return PTR_ERR(path);
> -	}
> -	*ppath = path;
> -	return 0;
>  }
>  
>  static int
> @@ -2906,11 +2899,12 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>  			 * fail removing space due to ENOSPC so try to use
>  			 * reserved block if that happens.
>  			 */
> -			err = ext4_force_split_extent_at(handle, inode, &path,
> -							 end + 1, 1);
> -			if (err < 0)
> +			path = ext4_force_split_extent_at(handle, inode, path,
> +							  end + 1, 1);
> +			if (IS_ERR(path)) {
> +				err = PTR_ERR(path);
>  				goto out;
> -
> +			}
>  		} else if (sbi->s_cluster_ratio > 1 && end >= ex_end &&
>  			   partial.state == initial) {
>  			/*
> @@ -5707,25 +5701,21 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  		int e1_len, e2_len, len;
>  		int split = 0;
>  
> -		path1 = ext4_find_extent(inode1, lblk1, NULL, EXT4_EX_NOCACHE);
> +		path1 = ext4_find_extent(inode1, lblk1, path1, EXT4_EX_NOCACHE);
>  		if (IS_ERR(path1)) {
>  			*erp = PTR_ERR(path1);
> -			path1 = NULL;
> -		finish:
> -			count = 0;
> -			goto repeat;
> +			goto errout;
>  		}
> -		path2 = ext4_find_extent(inode2, lblk2, NULL, EXT4_EX_NOCACHE);
> +		path2 = ext4_find_extent(inode2, lblk2, path2, EXT4_EX_NOCACHE);
>  		if (IS_ERR(path2)) {
>  			*erp = PTR_ERR(path2);
> -			path2 = NULL;
> -			goto finish;
> +			goto errout;
>  		}
>  		ex1 = path1[path1->p_depth].p_ext;
>  		ex2 = path2[path2->p_depth].p_ext;
>  		/* Do we have something to swap ? */
>  		if (unlikely(!ex2 || !ex1))
> -			goto finish;
> +			goto errout;
>  
>  		e1_blk = le32_to_cpu(ex1->ee_block);
>  		e2_blk = le32_to_cpu(ex2->ee_block);
> @@ -5747,7 +5737,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  				next2 = e2_blk;
>  			/* Do we have something to swap */
>  			if (next1 == EXT_MAX_BLOCKS || next2 == EXT_MAX_BLOCKS)
> -				goto finish;
> +				goto errout;
>  			/* Move to the rightest boundary */
>  			len = next1 - lblk1;
>  			if (len < next2 - lblk2)
> @@ -5757,28 +5747,32 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  			lblk1 += len;
>  			lblk2 += len;
>  			count -= len;
> -			goto repeat;
> +			continue;
>  		}
>  
>  		/* Prepare left boundary */
>  		if (e1_blk < lblk1) {
>  			split = 1;
> -			*erp = ext4_force_split_extent_at(handle, inode1,
> -						&path1, lblk1, 0);
> -			if (unlikely(*erp))
> -				goto finish;
> +			path1 = ext4_force_split_extent_at(handle, inode1,
> +							   path1, lblk1, 0);
> +			if (IS_ERR(path1)) {
> +				*erp = PTR_ERR(path1);
> +				goto errout;
> +			}
>  		}
>  		if (e2_blk < lblk2) {
>  			split = 1;
> -			*erp = ext4_force_split_extent_at(handle, inode2,
> -						&path2,  lblk2, 0);
> -			if (unlikely(*erp))
> -				goto finish;
> +			path2 = ext4_force_split_extent_at(handle, inode2,
> +							   path2, lblk2, 0);
> +			if (IS_ERR(path2)) {
> +				*erp = PTR_ERR(path2);
> +				goto errout;
> +			}
>  		}
>  		/* ext4_split_extent_at() may result in leaf extent split,
>  		 * path must to be revalidated. */
>  		if (split)
> -			goto repeat;
> +			continue;
>  
>  		/* Prepare right boundary */
>  		len = count;
> @@ -5789,30 +5783,34 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  
>  		if (len != e1_len) {
>  			split = 1;
> -			*erp = ext4_force_split_extent_at(handle, inode1,
> -						&path1, lblk1 + len, 0);
> -			if (unlikely(*erp))
> -				goto finish;
> +			path1 = ext4_force_split_extent_at(handle, inode1,
> +							path1, lblk1 + len, 0);
> +			if (IS_ERR(path1)) {
> +				*erp = PTR_ERR(path1);
> +				goto errout;
> +			}
>  		}
>  		if (len != e2_len) {
>  			split = 1;
> -			*erp = ext4_force_split_extent_at(handle, inode2,
> -						&path2, lblk2 + len, 0);
> -			if (*erp)
> -				goto finish;
> +			path2 = ext4_force_split_extent_at(handle, inode2,
> +							path2, lblk2 + len, 0);
> +			if (IS_ERR(path2)) {
> +				*erp = PTR_ERR(path2);
> +				goto errout;
> +			}
>  		}
>  		/* ext4_split_extent_at() may result in leaf extent split,
>  		 * path must to be revalidated. */
>  		if (split)
> -			goto repeat;
> +			continue;
>  
>  		BUG_ON(e2_len != e1_len);
>  		*erp = ext4_ext_get_access(handle, inode1, path1 + path1->p_depth);
>  		if (unlikely(*erp))
> -			goto finish;
> +			goto errout;
>  		*erp = ext4_ext_get_access(handle, inode2, path2 + path2->p_depth);
>  		if (unlikely(*erp))
> -			goto finish;
> +			goto errout;
>  
>  		/* Both extents are fully inside boundaries. Swap it now */
>  		tmp_ex = *ex1;
> @@ -5830,7 +5828,7 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  		*erp = ext4_ext_dirty(handle, inode2, path2 +
>  				      path2->p_depth);
>  		if (unlikely(*erp))
> -			goto finish;
> +			goto errout;
>  		*erp = ext4_ext_dirty(handle, inode1, path1 +
>  				      path1->p_depth);
>  		/*
> @@ -5840,17 +5838,17 @@ ext4_swap_extents(handle_t *handle, struct inode *inode1,
>  		 * aborted anyway.
>  		 */
>  		if (unlikely(*erp))
> -			goto finish;
> +			goto errout;
> +
>  		lblk1 += len;
>  		lblk2 += len;
>  		replaced_count += len;
>  		count -= len;
> -
> -	repeat:
> -		ext4_free_ext_path(path1);
> -		ext4_free_ext_path(path2);
> -		path1 = path2 = NULL;
>  	}
> +
> +errout:
> +	ext4_free_ext_path(path1);
> +	ext4_free_ext_path(path2);
>  	return replaced_count;
>  }
>  
> @@ -5965,24 +5963,29 @@ int ext4_ext_replay_update_ex(struct inode *inode, ext4_lblk_t start,
>  		ext4_ext_get_actual_len(ex) != len) {
>  		/* We need to split this extent to match our extent first */
>  		down_write(&EXT4_I(inode)->i_data_sem);
> -		ret = ext4_force_split_extent_at(NULL, inode, &path, start, 1);
> +		path = ext4_force_split_extent_at(NULL, inode, path, start, 1);
>  		up_write(&EXT4_I(inode)->i_data_sem);
> -		if (ret)
> +		if (IS_ERR(path)) {
> +			ret = PTR_ERR(path);
>  			goto out;
> +		}
>  
>  		path = ext4_find_extent(inode, start, path, 0);
>  		if (IS_ERR(path))
>  			return PTR_ERR(path);
> +
>  		ex = path[path->p_depth].p_ext;
>  		WARN_ON(le32_to_cpu(ex->ee_block) != start);
>  
>  		if (ext4_ext_get_actual_len(ex) != len) {
>  			down_write(&EXT4_I(inode)->i_data_sem);
> -			ret = ext4_force_split_extent_at(NULL, inode, &path,
> -							 start + len, 1);
> +			path = ext4_force_split_extent_at(NULL, inode, path,
> +							  start + len, 1);
>  			up_write(&EXT4_I(inode)->i_data_sem);
> -			if (ret)
> +			if (IS_ERR(path)) {
> +				ret = PTR_ERR(path);
>  				goto out;
> +			}
>  
>  			path = ext4_find_extent(inode, start, path, 0);
>  			if (IS_ERR(path))
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

