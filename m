Return-Path: <linux-ext4+bounces-5900-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC6E5A0296C
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 16:23:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07C0C188059C
	for <lists+linux-ext4@lfdr.de>; Mon,  6 Jan 2025 15:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D63E8224CC;
	Mon,  6 Jan 2025 15:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lAPpuajE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IgqK3Nkk";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="lAPpuajE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="IgqK3Nkk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B398F1514F6;
	Mon,  6 Jan 2025 15:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736176990; cv=none; b=UJqNJ/IIN/XvCyE1ivZ5qEDdWefttyeZP0LOwpvVaNepgaEgcU1wfgCNV2uMT5Z3OG5EPG7ScWYwjUjtlTZltsWzClNbnB8+JVzaLghmvjtOGqtlnYuRoNMeWf3V/BxSDeGCSbIGE58CXOIJq5i0Mt4OIcKBc3GEgcFPJcNRCk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736176990; c=relaxed/simple;
	bh=3xKmfsjjaTsj2AhOhJ2VCN7avuRKj+ZAn/6v0QB62sA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NsyTWqhVNQeySoE/B+aerbcJE34nnfR8iHxfuX2y1f05XpytgQMHdmlUlGsHdxkbAmtJa/8gQNx3sj8U30pT7GNltmvY4zj++YfqkKRCWFuKiy+WBBNxHQlpiaTrcBaxUX5EGLRiGHeHO+7YvNfoOx9te2TYVyEjVOqNusKPR8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lAPpuajE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IgqK3Nkk; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=lAPpuajE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=IgqK3Nkk; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id C0F5E1F392;
	Mon,  6 Jan 2025 15:23:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736176986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJFR0J+40bluwkO0Ao7PBBatZ1DM05CKylye+zp5RcM=;
	b=lAPpuajEWEXsgaRhHm2k/gVcaKJ+Dva8d5Ke1hucx9GNF3U64/lqZjsNvDRSDO6Aqsj1FI
	q0IhojAhpO67CCaMKgKkXEzj6myCbYkuj4AQ20kBtwi6p/WDgML7FfM6yiXEk9UNvyj/4t
	UxCSYUezlyJyRK7GpLPxatZZdbRdIJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736176986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJFR0J+40bluwkO0Ao7PBBatZ1DM05CKylye+zp5RcM=;
	b=IgqK3Nkk3EzX08qVAFZHwTU4CfPWT03J65JWLY+vDO4h3cdd5Ujh2VYi409qZFuuxokiGZ
	Qze7BQZRF6zpNoBw==
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=lAPpuajE;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=IgqK3Nkk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1736176986; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJFR0J+40bluwkO0Ao7PBBatZ1DM05CKylye+zp5RcM=;
	b=lAPpuajEWEXsgaRhHm2k/gVcaKJ+Dva8d5Ke1hucx9GNF3U64/lqZjsNvDRSDO6Aqsj1FI
	q0IhojAhpO67CCaMKgKkXEzj6myCbYkuj4AQ20kBtwi6p/WDgML7FfM6yiXEk9UNvyj/4t
	UxCSYUezlyJyRK7GpLPxatZZdbRdIJw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1736176986;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YJFR0J+40bluwkO0Ao7PBBatZ1DM05CKylye+zp5RcM=;
	b=IgqK3Nkk3EzX08qVAFZHwTU4CfPWT03J65JWLY+vDO4h3cdd5Ujh2VYi409qZFuuxokiGZ
	Qze7BQZRF6zpNoBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A1A96139AB;
	Mon,  6 Jan 2025 15:23:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id zVUzJ1r1e2fjSAAAD6G6ig
	(envelope-from <jack@suse.cz>); Mon, 06 Jan 2025 15:23:06 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 079F8A089C; Mon,  6 Jan 2025 16:23:05 +0100 (CET)
Date: Mon, 6 Jan 2025 16:23:05 +0100
From: Jan Kara <jack@suse.cz>
To: Julian Sun <sunjunchao2870@gmail.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
	tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz, boyu.mt@taobao.com, 
	tm@tao.ma
Subject: Re: [PATCH 2/7] ext4: Remove a redundant return statement
Message-ID: <z2tjc43ijg3s62ys7ncji6cxoi5yd4ugyd6cctld5pnvtc27dw@twrkbsqncucw>
References: <20241220151625.19769-1-sunjunchao2870@gmail.com>
 <20241220151625.19769-3-sunjunchao2870@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241220151625.19769-3-sunjunchao2870@gmail.com>
X-Rspamd-Queue-Id: C0F5E1F392
X-Spam-Score: -4.01
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.01 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_COUNT_THREE(0.00)[3];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	TO_DN_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	FREEMAIL_ENVRCPT(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DKIM_TRACE(0.00)[suse.cz:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Fri 20-12-24 23:16:20, Julian Sun wrote:
> Remove a redundant return statements in the
> ext4_es_remove_extent() function.
> 
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/extents_status.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index c786691dabd3..c56fb682a27e 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -1551,7 +1551,6 @@ void ext4_es_remove_extent(struct inode *inode, ext4_lblk_t lblk,
>  
>  	ext4_es_print_tree(inode);
>  	ext4_da_release_space(inode, reserved);
> -	return;
>  }
>  
>  static int __es_shrink(struct ext4_sb_info *sbi, int nr_to_scan,
> -- 
> 2.39.5
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

