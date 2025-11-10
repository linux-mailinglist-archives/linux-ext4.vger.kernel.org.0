Return-Path: <linux-ext4+bounces-11710-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id A8D25C45AD8
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 10:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 51C424E9E55
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Nov 2025 09:37:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED0F43002B3;
	Mon, 10 Nov 2025 09:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h43l8Jnk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gQG+aeq7";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="h43l8Jnk";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gQG+aeq7"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4C723AB90
	for <linux-ext4@vger.kernel.org>; Mon, 10 Nov 2025 09:37:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762767469; cv=none; b=cd29PEXhCDCHLRK9et6pFG3bEMRL/hI9tIdEXxM8IQ048YGpKghP5BM8Aox/M3NRLXu1PAhghJLAbCB+kOumeAM1RB8MIkwdFYqPhmKzFb0lVdcvhOoVfyLCis/oxvcJ2Z4f04Zf1BJITABZPolnlNJExlJ/Z1tOc2fzjpYGf7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762767469; c=relaxed/simple;
	bh=jw/la7DeqalrYvLph9jFpYzXqIRRejMsBYB6jD8FHww=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qTAoAoOYY6b69xHx32zpNn/V2LUTZZJ42p27YTuzSJDUgAZEgpFsYtV8tn1lpegHrBh1IZ5z3iRtZd/gSmHj4KIkLCf4XRYy52GBbB0AXrGP1detYah0rfaSEgOoWWczprvkM0gGn/dnUJe0l3tHdG4sHfyIY5Ka5LIL5u03Nl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h43l8Jnk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gQG+aeq7; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=h43l8Jnk; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gQG+aeq7; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 4D05D33737;
	Mon, 10 Nov 2025 09:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762767461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5Uwfi+hsbCX9KsUvfJ4tbtrWLFW7xrzHPIV51bu7p4=;
	b=h43l8JnkiodHyPr7X8fw5WeoyQdl5ih+ZqSFz+JJc/V7JWXJA3KJGyiv773iBe2g7Bf/2T
	d1aICICsixuwn2NHonPFjff/MAhcW3JGif7t0Ipn8ZCsy5ViTwwt3F291BDRfpulbqot/m
	vyTwma3ZDYesiOnPQ6pHVacK5SxrO+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762767461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5Uwfi+hsbCX9KsUvfJ4tbtrWLFW7xrzHPIV51bu7p4=;
	b=gQG+aeq7XIL+8Q2+swdNromZrqw2tIScAWqAB8dP219C6wbMeIPXKDvXpBWFLm5xC442IS
	tUxAhnSXgeyJvRDA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=h43l8Jnk;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=gQG+aeq7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1762767461; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5Uwfi+hsbCX9KsUvfJ4tbtrWLFW7xrzHPIV51bu7p4=;
	b=h43l8JnkiodHyPr7X8fw5WeoyQdl5ih+ZqSFz+JJc/V7JWXJA3KJGyiv773iBe2g7Bf/2T
	d1aICICsixuwn2NHonPFjff/MAhcW3JGif7t0Ipn8ZCsy5ViTwwt3F291BDRfpulbqot/m
	vyTwma3ZDYesiOnPQ6pHVacK5SxrO+c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1762767461;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=c5Uwfi+hsbCX9KsUvfJ4tbtrWLFW7xrzHPIV51bu7p4=;
	b=gQG+aeq7XIL+8Q2+swdNromZrqw2tIScAWqAB8dP219C6wbMeIPXKDvXpBWFLm5xC442IS
	tUxAhnSXgeyJvRDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4099413BF8;
	Mon, 10 Nov 2025 09:37:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id JH7JD2WyEWl8cQAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 10 Nov 2025 09:37:41 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id D95EBA28B1; Mon, 10 Nov 2025 10:37:40 +0100 (CET)
Date: Mon, 10 Nov 2025 10:37:40 +0100
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca, 
	jack@suse.cz, linux-kernel@vger.kernel.org, kernel@pankajraghav.com, 
	mcgrof@kernel.org, ebiggers@kernel.org, willy@infradead.org, yi.zhang@huawei.com, 
	yangerkun@huawei.com, chengzhihao1@huawei.com, libaokun1@huawei.com
Subject: Re: [PATCH v2 10/24] ext4: add EXT4_LBLK_TO_PG and EXT4_PG_TO_LBLK
 for block/page conversion
Message-ID: <qxinnyyfnpnliy65cgcifmoqp3giit2lzy5qpn7to7pi5qoy6h@7ckyifljv44e>
References: <20251107144249.435029-1-libaokun@huaweicloud.com>
 <20251107144249.435029-11-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251107144249.435029-11-libaokun@huaweicloud.com>
X-Spam-Level: 
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spamd-Result: default: False [-0.21 / 50.00];
	SEM_URIBL(3.50)[huaweicloud.com:email];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	R_DKIM_ALLOW(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	URIBL_BLOCKED(0.00)[huawei.com:email,suse.cz:dkim,suse.cz:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email,suse.com:email];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.cz:email]
X-Spamd-Bar: /
X-Rspamd-Queue-Id: 4D05D33737
X-Rspamd-Action: no action
X-Spam-Flag: NO
X-Spam-Score: -0.21

On Fri 07-11-25 22:42:35, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> As BS > PS support is coming, all block number to page index (and
> vice-versa) conversions must now go via bytes. Added EXT4_LBLK_TO_PG()
> and EXT4_PG_TO_LBLK() macros to simplify these conversions and handle
> both BS <= PS and BS > PS scenarios cleanly.
> 
> Suggested-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/ext4.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
> index c00ce6db69f0..4bc0b2b7288a 100644
> --- a/fs/ext4/ext4.h
> +++ b/fs/ext4/ext4.h
> @@ -370,6 +370,12 @@ struct ext4_io_submit {
>  	(round_up((offset), i_blocksize(inode)) >> (inode)->i_blkbits)
>  #define EXT4_LBLK_TO_B(inode, lblk) ((loff_t)(lblk) << (inode)->i_blkbits)
>  
> +/* Translate a block number to a page index */
> +#define EXT4_LBLK_TO_PG(inode, lblk)	(EXT4_LBLK_TO_B((inode), (lblk)) >> \
> +					 PAGE_SHIFT)
> +/* Translate a page index to a block number */
> +#define EXT4_PG_TO_LBLK(inode, pnum)	(((loff_t)(pnum) << PAGE_SHIFT) >> \
> +					 (inode)->i_blkbits)
>  /* Translate a block number to a cluster number */
>  #define EXT4_B2C(sbi, blk)	((blk) >> (sbi)->s_cluster_bits)
>  /* Translate a cluster number to a block number */
> -- 
> 2.46.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

