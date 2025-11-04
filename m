Return-Path: <linux-ext4+bounces-11453-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB6C31953
	for <lists+linux-ext4@lfdr.de>; Tue, 04 Nov 2025 15:42:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBEA71899935
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Nov 2025 14:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEFE330307;
	Tue,  4 Nov 2025 14:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dl21BZ0M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4NfgpPlh";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="dl21BZ0M";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="4NfgpPlh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAD4B1865FA
	for <linux-ext4@vger.kernel.org>; Tue,  4 Nov 2025 14:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762267008; cv=none; b=rf/H9z4Kt0zidQJMHTf812lnRBiNfcEomRVRiKHbIaOwSJIsWnNO5TSosDdfaJiyPG0QvvtF26DnDgKOXEvcZiheNyhZnLvrY5+H63i1qoSYdTwRml+WJzh8DzhmoYT1CMlOqGPVrpnSQV2C7KXZuGExqge979Jz+hqW6MgKF30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762267008; c=relaxed/simple;
	bh=qmHssPKxh6lklfdIwlA/gLKGVGPVCUTMRMR3qysoL4E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j7jmdY3rUqOPIDSoCddPGiahqalEUR5gi+pLUfUrTiPw65Zhu2L/8WBCRwhywSxY5KBHOdlncfeHjUWrapAVsr8RWYVxbCFSlttzxSTnVyXnu9QeC22u0EqTf3XjFQodUHbp1EoaNuaycZDqXy2QMi1IW6dq3reW+r2Ww73dqMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dl21BZ0M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4NfgpPlh; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=dl21BZ0M; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=4NfgpPlh; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 73994211BA;
	Tue,  4 Nov 2025 14:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762267004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LLkKliZNztgfuE1BTf5pjgdXyIRrVnT4czXT/w3tjw=;
	b=dl21BZ0MfSqFBADItCTCwf6gWa0R9NBgkt9+fwgvqVdz9uhmOTY0TxroAdi/Upo29V+pe3
	4G7HOsANDYhp6tLU7n7oyFXKLNl6zlpJFZtxA6fs/szYq6eShIMEHLCMfMd1nQ/E7JLJNU
	ZmKjXlpG2uNyWZtw5GwI9bRZ+qkbpXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762267004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LLkKliZNztgfuE1BTf5pjgdXyIRrVnT4czXT/w3tjw=;
	b=4NfgpPlhTSasaW7Ew8lbsm2q32hd7IELKNkx8GUlhTPZRMwwV6XTMZ7tvmA8m5P0tMRbbB
	ECuighzMX7VIKXDw==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=dl21BZ0M;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=4NfgpPlh
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762267004; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LLkKliZNztgfuE1BTf5pjgdXyIRrVnT4czXT/w3tjw=;
	b=dl21BZ0MfSqFBADItCTCwf6gWa0R9NBgkt9+fwgvqVdz9uhmOTY0TxroAdi/Upo29V+pe3
	4G7HOsANDYhp6tLU7n7oyFXKLNl6zlpJFZtxA6fs/szYq6eShIMEHLCMfMd1nQ/E7JLJNU
	ZmKjXlpG2uNyWZtw5GwI9bRZ+qkbpXE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762267004;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2LLkKliZNztgfuE1BTf5pjgdXyIRrVnT4czXT/w3tjw=;
	b=4NfgpPlhTSasaW7Ew8lbsm2q32hd7IELKNkx8GUlhTPZRMwwV6XTMZ7tvmA8m5P0tMRbbB
	ECuighzMX7VIKXDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 68A1A136D1;
	Tue,  4 Nov 2025 14:36:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 8VqMGXwPCmkbVgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 04 Nov 2025 14:36:44 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 1A559A28EA; Tue,  4 Nov 2025 15:36:44 +0100 (CET)
Date: Tue, 4 Nov 2025 15:36:44 +0100
From: Jan Kara <jack@suse.cz>
To: Yang Erkun <yangerkun@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, yi.zhang@huawei.com, libaokun1@huawei.com, 
	yangerkun@huaweicloud.com
Subject: Re: [PATCH v2 3/4] ext4: cleanup for ext4_map_blocks
Message-ID: <bivcbbfa2ej5uljkvjry42fjkmjx3unmly2u4zgbhl435omudz@bcx6ygcsi6v3>
References: <20251104131750.1581541-1-yangerkun@huawei.com>
 <20251104131750.1581541-3-yangerkun@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251104131750.1581541-3-yangerkun@huawei.com>
X-Spam-Level: 
X-Spam-Flag: NO
X-Rspamd-Queue-Id: 73994211BA
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.cz:dkim,suse.cz:email,suse.com:email,huawei.com:email];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Spam-Score: -4.01

On Tue 04-11-25 21:17:49, Yang Erkun wrote:
> Retval from ext4_map_create_blocks means we really create some blocks,
> cannot happened with m_flags without EXT4_MAP_UNWRITTEN and
> EXT4_MAP_MAPPED.
> 
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/inode.c | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index e8bac93ca668..3d8ada26d5cd 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -799,7 +799,13 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  	down_write(&EXT4_I(inode)->i_data_sem);
>  	retval = ext4_map_create_blocks(handle, inode, map, flags);
>  	up_write((&EXT4_I(inode)->i_data_sem));
> -	if (retval > 0 && map->m_flags & EXT4_MAP_MAPPED) {
> +
> +	if (retval < 0)
> +		ext_debug(inode, "failed with err %d\n", retval);
> +	if (retval <= 0)
> +		return retval;
> +
> +	if (map->m_flags & EXT4_MAP_MAPPED) {
>  		ret = check_block_validity(inode, map);
>  		if (ret != 0)
>  			return ret;
> @@ -828,12 +834,8 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
>  				return ret;
>  		}
>  	}
> -	if (retval > 0 && (map->m_flags & EXT4_MAP_UNWRITTEN ||
> -				map->m_flags & EXT4_MAP_MAPPED))
> -		ext4_fc_track_range(handle, inode, map->m_lblk,
> -					map->m_lblk + map->m_len - 1);
> -	if (retval < 0)
> -		ext_debug(inode, "failed with err %d\n", retval);
> +	ext4_fc_track_range(handle, inode, map->m_lblk, map->m_lblk +
> +			    map->m_len - 1);
>  	return retval;
>  }
>  
> -- 
> 2.39.2
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

