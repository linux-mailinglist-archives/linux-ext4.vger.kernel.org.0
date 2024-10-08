Return-Path: <linux-ext4+bounces-4531-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7D95994F20
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 15:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51FC21F25AD1
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 13:24:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4ACA1DEFED;
	Tue,  8 Oct 2024 13:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="drqRb01n";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="lYnveOEA";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZCsk1F6O";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="CBRLZZqe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB4C21DF25E;
	Tue,  8 Oct 2024 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393810; cv=none; b=AcXjHh4x5BSVdSCCp0Pml+Waky+2FX3mvm6t17rR8+9L6zY2fsQC+MMtk70xUrT/YTcGIQYh1oPyX7+ViVhcxkRhObIYoTh8uArZ6enLHy3juHDp/wN/9l1CiHjWCKIidqZvQdkexm/b8uag+CbNcrq1XRaNzCTexlFeC8tcrJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393810; c=relaxed/simple;
	bh=Wh1MPUuG9REcw4C5g/SS1luY/EOpRzW3YCdoZY5VREM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cdIRhTa7aFEqNbdkNUaVugcr6bm6KZg0mwCC/ighaaSWYuxp3AtgIw1Ag+Ot+5CYwXB34PoXJ068cJ4DeVlgcUgJeooNvPbQwjKtyIHVUmirHfwF5laB4OJZrBPZzff8+NRBHZ8LpgNwR2TdG+L+oSSLIIrRRigOmCgoauVG4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=drqRb01n; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=lYnveOEA; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZCsk1F6O; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=CBRLZZqe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CE62621D51;
	Tue,  8 Oct 2024 13:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728393807; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvbaumAUlIXBU4sou9sD9COtn47vcD6H0iRhP+ieaIc=;
	b=drqRb01nPTDy6KKd0MmfT83JiNaMR34Qx2x5Mw2Ax+OODYxk2dfN68oR2x/WMSRmk+FZYO
	yHR18KdUq8ev6qc3YpdAAwAyZsqhO33sOfJ7Eu1zfCpXqwhtBm+nUaRJfnEbmVTps8WpTU
	lWYaBURM8ITyzlRBkFa2ebxSuEMLZlM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728393807;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvbaumAUlIXBU4sou9sD9COtn47vcD6H0iRhP+ieaIc=;
	b=lYnveOEAv29TjiXGUMoto6FW2ZUH2Dy3MZUMQk5TSMZRM3PrRD2CWdS7h5MJt+CV4Zde7K
	lkkcwjhTwZ4Ws4AA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=ZCsk1F6O;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=CBRLZZqe
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728393806; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvbaumAUlIXBU4sou9sD9COtn47vcD6H0iRhP+ieaIc=;
	b=ZCsk1F6OFrDToThFlY2k3oNzn/StFABPjiltoYpBwyba3W9Is6qPRzVZ+7D/oK6z05pkKv
	fQoFVpL1KMoj3gVH5I3O9N6vmoNWumesjG83mI7Je1WMqy/NtO+7GgIpbQ4Nzas0XfN5Fu
	aH3xA7HLXsPdOV/IxHws8j/t8VB72Eg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728393806;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FvbaumAUlIXBU4sou9sD9COtn47vcD6H0iRhP+ieaIc=;
	b=CBRLZZqe448v/enWIKsBK6A0KkLJPdmouL0Ke5AR9hzjMEZPyUgTw+DaWIz6UpXAEfFxm8
	3Og1CJMT1KU2uBDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C37961340C;
	Tue,  8 Oct 2024 13:23:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DumyL04yBWfGCgAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Oct 2024 13:23:26 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 8306CA08CA; Tue,  8 Oct 2024 15:23:26 +0200 (CEST)
Date: Tue, 8 Oct 2024 15:23:26 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] ext4: WARN if a full dir leaf block has only one dentry
Message-ID: <20241008132326.yfejlgfithqqkoff@quack3>
References: <20241008121152.3771906-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008121152.3771906-1-libaokun@huaweicloud.com>
X-Rspamd-Queue-Id: CE62621D51
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	ARC_NA(0.00)[];
	MISSING_XM_UA(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MIME_TRACE(0.00)[0:+];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,huaweicloud.com:email,suse.com:email,suse.cz:email,suse.cz:dkim];
	RCVD_COUNT_THREE(0.00)[3];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 08-10-24 20:11:52, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> The maximum length of a filename is 255 and the minimum block size is 1024,
> so it is always guaranteed that the number of entries is greater than or
> equal to 2 when do_split() is called. So unless ext4_dx_add_entry() and
> make_indexed_dir() or some other functions are buggy, 'split == 0' will
> not occur.
> 
> Setting 'continued' to 0 in this case masks the problem that the file
> system has become corrupted, even though it prevents possible out-of-bounds
> access. Hence WARN_ON_ONCE() is used to check if 'split' is 0, and if it is
> then warns and returns an error to abort split.
> 
> Suggested-by: Theodore Ts'o <tytso@mit.edu>
> Link: https://lore.kernel.org/r/20240823160518.GA424729@mit.edu
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/namei.c | 14 ++++++++++++--
>  1 file changed, 12 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 790db7eac6c2..08d15cd2b594 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2000,8 +2000,17 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
>  	else
>  		split = count/2;
>  
> +	if (WARN_ON_ONCE(split == 0)) {
> +		/* Should never happen, but avoid out-of-bounds access below */
> +		ext4_error_inode_block(dir, (*bh)->b_blocknr, 0,
> +			"bad indexed directory? hash=%08x:%08x count=%d move=%u",
> +			hinfo->hash, hinfo->minor_hash, count, move);
> +		err = -EFSCORRUPTED;
> +		goto out;
> +	}
> +
>  	hash2 = map[split].hash;
> -	continued = split > 0 ? hash2 == map[split - 1].hash : 0;
> +	continued = hash2 == map[split - 1].hash;
>  	dxtrace(printk(KERN_INFO "Split block %lu at %x, %i/%i\n",
>  			(unsigned long)dx_get_block(frame->at),
>  					hash2, split, count-split));
> @@ -2043,10 +2052,11 @@ static struct ext4_dir_entry_2 *do_split(handle_t *handle, struct inode *dir,
>  	return de;
>  
>  journal_error:
> +	ext4_std_error(dir->i_sb, err);
> +out:
>  	brelse(*bh);
>  	brelse(bh2);
>  	*bh = NULL;
> -	ext4_std_error(dir->i_sb, err);
>  	return ERR_PTR(err);
>  }
>  
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

