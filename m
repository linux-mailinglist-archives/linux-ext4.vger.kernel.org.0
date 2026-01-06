Return-Path: <linux-ext4+bounces-12592-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B8CBECF8CE6
	for <lists+linux-ext4@lfdr.de>; Tue, 06 Jan 2026 15:34:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C38BA3023D14
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jan 2026 14:34:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554D0313E07;
	Tue,  6 Jan 2026 14:34:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eN4MT4NV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tFnSUbXf";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="eN4MT4NV";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="tFnSUbXf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28516203710
	for <linux-ext4@vger.kernel.org>; Tue,  6 Jan 2026 14:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767710091; cv=none; b=W+1/rm7LnhO6pfEcnDPRKCQBoYh31ObRwDK12JhEeL7QxU4Y0Px5Cshr0v3omV+X+Zlzov07OqmRuo7DxFPvFIsJX5xBv9HjjtTVB2Anp90x8LeHPVARi+dqgSJPf+PwInmkHiL2XHCVClYXZUevddK/KRqYNaR2mByVOWg+zuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767710091; c=relaxed/simple;
	bh=iGcnnbQtjeCITTYnL4L8g7L8J35mejCHBc3FVDByc3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fX3BvtH9Zn0uios1m8HnlLQEUMKevjf2Y/dJnzPkORLNMh80FCsm3Hi53Wsy/U0gZ61qIz72BbedI/tXb323tzdBKcyvEfG++0Jazwo3Y0RB1G+pgDZGSCI9SQAsmK08TklVxj/+Sn4B5I1aAgD0zC4bjHpW7NLbYLinL9mH1O4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eN4MT4NV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tFnSUbXf; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=eN4MT4NV; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=tFnSUbXf; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 5C6223368F;
	Tue,  6 Jan 2026 14:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767710088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwxIuwKyRTvZiZYwC7vWPeBlJGrGgcMHx7Y2F4xv9pM=;
	b=eN4MT4NVIQAtrOogJA6z9rgkTUcqSDxcPg8cu8jEQ77G9xh1WcN9mB9UvBRkACzUzb+tyr
	YzubiIx5HpDRXhOlaErkIdOvmDYsVyykml/OmgFBM6FWfX0G9N41b+t9ZGuShWnHmwTc10
	9b7p0HBFHmNK6f2imgjaPF8GN5qsl+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767710088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwxIuwKyRTvZiZYwC7vWPeBlJGrGgcMHx7Y2F4xv9pM=;
	b=tFnSUbXf/67vWG5AsW6/8w1Ur7rKJvBYPJq44+1hHc0pf3J1I9Ac1GJwCkMHkbRmqORUNc
	4nV1BnfFg9JVYaAw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=eN4MT4NV;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=tFnSUbXf
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1767710088; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwxIuwKyRTvZiZYwC7vWPeBlJGrGgcMHx7Y2F4xv9pM=;
	b=eN4MT4NVIQAtrOogJA6z9rgkTUcqSDxcPg8cu8jEQ77G9xh1WcN9mB9UvBRkACzUzb+tyr
	YzubiIx5HpDRXhOlaErkIdOvmDYsVyykml/OmgFBM6FWfX0G9N41b+t9ZGuShWnHmwTc10
	9b7p0HBFHmNK6f2imgjaPF8GN5qsl+0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1767710088;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VwxIuwKyRTvZiZYwC7vWPeBlJGrGgcMHx7Y2F4xv9pM=;
	b=tFnSUbXf/67vWG5AsW6/8w1Ur7rKJvBYPJq44+1hHc0pf3J1I9Ac1GJwCkMHkbRmqORUNc
	4nV1BnfFg9JVYaAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5381C3EA63;
	Tue,  6 Jan 2026 14:34:48 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id NZZgFIgdXWnxeAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 06 Jan 2026 14:34:48 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A41BA0A4F; Tue,  6 Jan 2026 15:34:48 +0100 (CET)
Date: Tue, 6 Jan 2026 15:34:48 +0100
From: Jan Kara <jack@suse.cz>
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>, 
	Ritesh Harjani <ritesh.list@gmail.com>, Zhang Yi <yi.zhang@huawei.com>, Jan Kara <jack@suse.cz>, 
	libaokun1@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/7] ext4: propagate flags to
 ext4_convert_unwritten_extents_endio()
Message-ID: <7ihf44dqscsmv7qz3bv7kmdyv5mrqukxcfjbeegozu73r4dc4r@svcfw7fvm5xx>
References: <cover.1767528171.git.ojaswin@linux.ibm.com>
 <25edb28eeba7bea4610b765001d562cf402f1aba.1767528171.git.ojaswin@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <25edb28eeba7bea4610b765001d562cf402f1aba.1767528171.git.ojaswin@linux.ibm.com>
X-Spamd-Result: default: False [-2.51 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	SUSPICIOUS_RECIPS(1.50)[];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,gmail.com,huawei.com,suse.cz];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email,suse.com:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spam-Level: 
X-Rspamd-Queue-Id: 5C6223368F
X-Spam-Flag: NO
X-Spam-Score: -2.51

On Sun 04-01-26 17:49:17, Ojaswin Mujoo wrote:
> Currently, callers like ext4_convert_unwritten_extents() pass
> EXT4_EX_NOCACHE flag to avoid caching extents however this is not
> respected by ext4_convert_unwritten_extents_endio(). Hence, modify it to
> accept flags from the caller and to pass the flags on to other extent
> manipulation functions it calls. This makes sure the NOCACHE flag is
> respected throughout the code path.
> 
> Also, since the caller already passes METADATA_NOFAIL and CONVERT flags
> we don't need to explicitly pass it anymore.
> 
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 5228196f5ad4..460a70e6dae0 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3785,7 +3785,7 @@ static struct ext4_ext_path *ext4_split_convert_extents(handle_t *handle,
>  static struct ext4_ext_path *
>  ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  				     struct ext4_map_blocks *map,
> -				     struct ext4_ext_path *path)
> +				     struct ext4_ext_path *path, int flags)
>  {
>  	struct ext4_extent *ex;
>  	ext4_lblk_t ee_block;
> @@ -3802,9 +3802,6 @@ ext4_convert_unwritten_extents_endio(handle_t *handle, struct inode *inode,
>  		  (unsigned long long)ee_block, ee_len);
>  
>  	if (ee_block != map->m_lblk || ee_len > map->m_len) {
> -		int flags = EXT4_GET_BLOCKS_CONVERT |
> -			    EXT4_GET_BLOCKS_METADATA_NOFAIL;
> -
>  		path = ext4_split_convert_extents(handle, inode, map, path,
>  						  flags, NULL);
>  		if (IS_ERR(path))
> @@ -3943,7 +3940,7 @@ ext4_ext_handle_unwritten_extents(handle_t *handle, struct inode *inode,
>  	/* IO end_io complete, convert the filled extent to written */
>  	if (flags & EXT4_GET_BLOCKS_CONVERT) {
>  		path = ext4_convert_unwritten_extents_endio(handle, inode,
> -							    map, path);
> +							    map, path, flags);
>  		if (IS_ERR(path))
>  			return path;
>  		ext4_update_inode_fsync_trans(handle, inode, 1);
> -- 
> 2.51.0
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

