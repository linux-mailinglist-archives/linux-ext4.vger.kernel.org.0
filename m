Return-Path: <linux-ext4+bounces-12857-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9D2D24094
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 12:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2B3B5302AAF5
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jan 2026 11:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8EA836E464;
	Thu, 15 Jan 2026 11:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cKEXy6HN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="npDFFHZ0";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cKEXy6HN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="npDFFHZ0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2C536D51D
	for <linux-ext4@vger.kernel.org>; Thu, 15 Jan 2026 10:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768474800; cv=none; b=tmYXIrVUmKXAUH4TlNfp2JtKv/j6luYaxU+LJ//c9w/T+a1HpiwfE5Z2KT5+H9z+DtPdfinHqxhXoku24oAwrSMb/SL3GGMP5zVBJH5JwtALJSrp6wYXN30ZwaCcJSMPZ11pqKdbRDVB12csD3gfT2pdH226X8LIBxmUx110zWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768474800; c=relaxed/simple;
	bh=LUYfnx3gtc15tOD0P/1LdGPZ+9CptHIexRh3m01GRUc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgf3LUaNTyGfMmVIAdHDDadRlUF9NyZZWh3itr5gFPYMtuwaFFCpZL/+GBe+ebORVggk7T7m5aLn5cT7+hTXnLw8GGHCbnQKSd9ZAxbt91OFJZ2aUyKcCj37aJjU1EaVs3h12YclDwCvX2RjLDByQhYIAd2YBW62RDQHZGu82rY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cKEXy6HN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=npDFFHZ0; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=cKEXy6HN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=npDFFHZ0; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 46DE05BCF8;
	Thu, 15 Jan 2026 10:59:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768474797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uhtRTrVX+kb61cXRJ9eN9syKMhsEPnAzPxRlC4mbEhI=;
	b=cKEXy6HNIkjxDj423pbCjLIj16frurIZMkBj1HgJlqojYP9uhaRmu41iz29VM0Wu04ShcU
	bwFnezYu4911joAKfh+dMqm3JLvqRl+EaOsLJ4088e/w2njEOfT7E7rznIe2YYTP1qXGBU
	vrtBlSfz8h3NLDO8FUxW84WAtXZoh/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768474797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uhtRTrVX+kb61cXRJ9eN9syKMhsEPnAzPxRlC4mbEhI=;
	b=npDFFHZ04mVIAqQpE3S/AESWPK6e2XgxbG2wNbwYDcjkqLDOCTpPEJ2rEcIfKRXcplrUOd
	P09NpxPF4qMGb+Cg==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=cKEXy6HN;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=npDFFHZ0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768474797; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uhtRTrVX+kb61cXRJ9eN9syKMhsEPnAzPxRlC4mbEhI=;
	b=cKEXy6HNIkjxDj423pbCjLIj16frurIZMkBj1HgJlqojYP9uhaRmu41iz29VM0Wu04ShcU
	bwFnezYu4911joAKfh+dMqm3JLvqRl+EaOsLJ4088e/w2njEOfT7E7rznIe2YYTP1qXGBU
	vrtBlSfz8h3NLDO8FUxW84WAtXZoh/c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768474797;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uhtRTrVX+kb61cXRJ9eN9syKMhsEPnAzPxRlC4mbEhI=;
	b=npDFFHZ04mVIAqQpE3S/AESWPK6e2XgxbG2wNbwYDcjkqLDOCTpPEJ2rEcIfKRXcplrUOd
	P09NpxPF4qMGb+Cg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37E3F3EA63;
	Thu, 15 Jan 2026 10:59:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zbafDa3IaGl1IwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 15 Jan 2026 10:59:57 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EC2E5A090F; Thu, 15 Jan 2026 11:59:56 +0100 (CET)
Date: Thu, 15 Jan 2026 11:59:56 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/8] ext4: propagate flags to
 convert_initialized_extent()
Message-ID: <bycwydde47xioeeg6ot44cpf2q5kgmkn2rjehjvejoq5dm44gh@hoe4tupvdd6n>
References: <cover.1768402426.git.ojaswin@linux.ibm.com>
 <d2796ad80876b78ba19ed512b2eb734449bfe62e.1768402426.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d2796ad80876b78ba19ed512b2eb734449bfe62e.1768402426.git.ojaswin@linux.ibm.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,huawei.com,suse.cz];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.com:email]
X-Spam-Flag: NO
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: 46DE05BCF8
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 

On Wed 14-01-26 20:27:48, Ojaswin Mujoo wrote:
> Currently, ext4_zero_range passes EXT4_EX_NOCACHE flag to avoid caching
> extents however this is not respected by convert_initialized_extent().
> Hence, modify it to accept flags from the caller and to pass the flags
> on to other extent manipulation functions it calls. This makes
> sure the NOCACHE flag is respected throughout the code path.
> 
> Also, we no longer explicitly pass CONVERT_UNWRITTEN as the caller takes
> care of this. Account this behavior in Kunit tests as well.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

I don't see any changes in tests here as the changelog states. Otherwise it
looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

									Honza

> ---
>  fs/ext4/extents.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a581e9278d48..3d45abfb13cd 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3844,6 +3844,7 @@ static struct ext4_ext_path *
>  convert_initialized_extent(handle_t *handle, struct inode *inode,
>  			   struct ext4_map_blocks *map,
>  			   struct ext4_ext_path *path,
> +			   int flags,
>  			   unsigned int *allocated)
>  {
>  	struct ext4_extent *ex;
> @@ -3869,11 +3870,11 @@ convert_initialized_extent(handle_t *handle, struct inode *inode,
>  
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
>  		path = ext4_split_convert_extents(handle, inode, map, path,
> -				EXT4_GET_BLOCKS_CONVERT_UNWRITTEN, NULL);
> +						  flags, NULL);
>  		if (IS_ERR(path))
>  			return path;
>  
> -		path = ext4_find_extent(inode, map->m_lblk, path, 0);
> +		path = ext4_find_extent(inode, map->m_lblk, path, flags);
>  		if (IS_ERR(path))
>  			return path;
>  		depth = ext_depth(inode);
> @@ -4263,7 +4264,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  			if ((!ext4_ext_is_unwritten(ex)) &&
>  			    (flags & EXT4_GET_BLOCKS_CONVERT_UNWRITTEN)) {
>  				path = convert_initialized_extent(handle,
> -					inode, map, path, &allocated);
> +					inode, map, path, flags, &allocated);
>  				if (IS_ERR(path))
>  					err = PTR_ERR(path);
>  				goto out;
> -- 
> 2.52.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

