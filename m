Return-Path: <linux-ext4+bounces-3438-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D93DA93B780
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 21:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3E2BBB24131
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 19:18:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 252A1169AC5;
	Wed, 24 Jul 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vspilufM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g5vAGKU6";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="vspilufM";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="g5vAGKU6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0036A1684A4;
	Wed, 24 Jul 2024 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848572; cv=none; b=fCmEDiPZdWjfdoalda48iYD3/5L2wgsO2nPumNj/U/SfmPMtrIOqGDNKu9P/SmcJYFxPonQWcjDPjiusFytqity/ZqCc0umV6BF+1DmkjuUt/FMGybGe9HzWQZnrkktsbjylrliw6nsdeGhelytB7GAxbG8SqWzWR5NzkmYbLb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848572; c=relaxed/simple;
	bh=8C15POnSra0WrDdNUiT89AuDrH8cygOtfZefZQAVMoc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=An2pfFUKVV1a1ESOMydp49gXTSLZfFWYpBz5kAcSVDonvXR0V1YfDRa/pzg80shyfIjO+DNOnfaG8OeLg/h4QTYRYI/R6GM4R6kwnzd3LgPDM8oF5e+kdeW02vmEsiY/ZSqWHeeNp8YLOti+cZB6WayqEnB5wKhodEQrFb5JXFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vspilufM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g5vAGKU6; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=vspilufM; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=g5vAGKU6; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 14AAE219F2;
	Wed, 24 Jul 2024 19:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721848569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtKHsTuV1Atgv43GeraVX25iqZ0nrqPFuV4hB+eesmg=;
	b=vspilufMNI8N1QCToGWyYbFfd7CfzXG37epO0JbCjPdM8j7g6e/Nv/ZOSIAVPhlsojK9oL
	i89/dRgp3QCYxg1UmuBqtGPtSSkmk3hEph8ZQw6eFikj7Pgl6qPwapdHlsosnM2glSE7OO
	IlXYsWz+aQIyZyprtiDORPb61TcDjGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721848569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtKHsTuV1Atgv43GeraVX25iqZ0nrqPFuV4hB+eesmg=;
	b=g5vAGKU69f/0bXHqwQlbptIg1ehjxH1gIc191LH8J1gaf2AxX+SjKSRWD/WMEQX18RseZ3
	QZrQB5T/GgSLVTAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1721848569; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtKHsTuV1Atgv43GeraVX25iqZ0nrqPFuV4hB+eesmg=;
	b=vspilufMNI8N1QCToGWyYbFfd7CfzXG37epO0JbCjPdM8j7g6e/Nv/ZOSIAVPhlsojK9oL
	i89/dRgp3QCYxg1UmuBqtGPtSSkmk3hEph8ZQw6eFikj7Pgl6qPwapdHlsosnM2glSE7OO
	IlXYsWz+aQIyZyprtiDORPb61TcDjGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1721848569;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xtKHsTuV1Atgv43GeraVX25iqZ0nrqPFuV4hB+eesmg=;
	b=g5vAGKU69f/0bXHqwQlbptIg1ehjxH1gIc191LH8J1gaf2AxX+SjKSRWD/WMEQX18RseZ3
	QZrQB5T/GgSLVTAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0425413411;
	Wed, 24 Jul 2024 19:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 7t2iAPlSoWZccQAAD6G6ig
	(envelope-from <jack@suse.cz>); Wed, 24 Jul 2024 19:16:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 9ED70A08F2; Wed, 24 Jul 2024 21:16:04 +0200 (CEST)
Date: Wed, 24 Jul 2024 21:16:04 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH 06/20] ext4: avoid use-after-free in ext4_ext_show_leaf()
Message-ID: <20240724191604.6grmtu4t7gmvtlec@quack3>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-7-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240710040654.1714672-7-libaokun@huaweicloud.com>
X-Spamd-Result: default: False [-2.10 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	MIME_GOOD(-0.10)[text/plain];
	TAGGED_RCPT(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ARC_NA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -2.10

On Wed 10-07-24 12:06:40, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> In ext4_find_extent(), path may be freed by error or be reallocated, so
> using a previously saved *ppath may have been freed and thus may trigger
> use-after-free, as follows:
> 
> ext4_split_extent
>   path = *ppath;
>   ext4_split_extent_at(ppath)
>   path = ext4_find_extent(ppath)
>   ext4_split_extent_at(ppath)
>     // ext4_find_extent fails to free path
>     // but zeroout succeeds
>   ext4_ext_show_leaf(inode, path)
>     eh = path[depth].p_hdr
>     // path use-after-free !!!
> 
> Similar to ext4_split_extent_at(), we use *ppath directly as an input to
> ext4_ext_show_leaf(). Fix a spelling error by the way.
> 
> Same problem in ext4_ext_handle_unwritten_extents(). Since 'path' is only
> used in ext4_ext_show_leaf(), remove 'path' and use *ppath directly.
> 
> This issue is triggered only when EXT_DEBUG is defined and therefore does
> not affect functionality.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

I'd just note that this shows that modifying ppath in the called function
was not a great idea as it makes possible use-after-free issues due to
cached values being used very hard to spot and very easy to introduce...

								Honza

> ---
>  fs/ext4/extents.c | 9 ++++-----
>  1 file changed, 4 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 3a70a0739af8..1660434fbfc7 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3328,7 +3328,7 @@ static int ext4_split_extent_at(handle_t *handle,
>  }
>  
>  /*
> - * ext4_split_extents() splits an extent and mark extent which is covered
> + * ext4_split_extent() splits an extent and mark extent which is covered
>   * by @map as split_flags indicates
>   *
>   * It may result in splitting the extent into multiple extents (up to three)
> @@ -3404,7 +3404,7 @@ static int ext4_split_extent(handle_t *handle,
>  			goto out;
>  	}
>  
> -	ext4_ext_show_leaf(inode, path);
> +	ext4_ext_show_leaf(inode, *ppath);
>  out:
>  	return err ? err : allocated;
>  }
> @@ -3869,14 +3869,13 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  			struct ext4_ext_path **ppath, int flags,
>  			unsigned int allocated, ext4_fsblk_t newblock)
>  {
> -	struct ext4_ext_path __maybe_unused *path = *ppath;
>  	int ret = 0;
>  	int err = 0;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u, flags 0x%x, allocated %u\n",
>  		  (unsigned long long)map->m_lblk, map->m_len, flags,
>  		  allocated);
> -	ext4_ext_show_leaf(inode, path);
> +	ext4_ext_show_leaf(inode, *ppath);
>  
>  	/*
>  	 * When writing into unwritten space, we should not fail to
> @@ -3973,7 +3972,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	if (allocated > map->m_len)
>  		allocated = map->m_len;
>  	map->m_len = allocated;
> -	ext4_ext_show_leaf(inode, path);
> +	ext4_ext_show_leaf(inode, *ppath);
>  out2:
>  	return err ? err : allocated;
>  }
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

