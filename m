Return-Path: <linux-ext4+bounces-4530-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67F5A994D75
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 15:05:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 825481C248D9
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Oct 2024 13:05:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEA01DED48;
	Tue,  8 Oct 2024 13:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tKY1fVDS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UV8i1l5C";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="tKY1fVDS";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="UV8i1l5C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 053391DFD1;
	Tue,  8 Oct 2024 13:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392735; cv=none; b=KemnYgJ5yZ6dbaioJRy3x3/SnhcvWYvvWQgRNjo6wcn788csXTuHGiLg7V1FzMZhsQlStyJfzGn5WY6mkfke/7WifFnQbt+4socRzFgRIpGObo4E239tWnG30ckQFH1UXVvbs+ozfLB+zNku2EQrLpRh3fCFDNOwQxwfxZuE02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392735; c=relaxed/simple;
	bh=jD0jjZGnqRLlvplv38ot434t6s83meJWovIVnwKMRFE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTPg90SHq00/bIttb77uXCybzRaxaiM2flNIJhMenKdEn6a+YztKspmPOyB79Ax/+AM3gOe72hDdpmc97sYuAoHFBx/vYsxOVMOJC+lQFTlu5ICyBtyfs49i8sr/EnxK6Ye+/H2Z6+6Bn9Z2BGkNIcZ+mV87OzanFgwbm6m2b4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tKY1fVDS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UV8i1l5C; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=tKY1fVDS; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=UV8i1l5C; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id AD3221FB52;
	Tue,  8 Oct 2024 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728392729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVyELl6o/F4I9t4aYsMMGs+kdDbJ/MNuBGCTx/ubf5c=;
	b=tKY1fVDSZqziketyeg2QyHkTkYxUWbc1p611sUtV5/dIiBCBiS/4pRP5svR4+Omo6Z/ATA
	wYFEXPR+N+vTA0GoRCpakmv23DvPYHjpa9zvSf5a+5WGxlvD/2n7sifSYygiLJ6KtwLlBo
	i3fmgB1Uv4BpyOxgmkBmDHcMQFy90ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728392729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVyELl6o/F4I9t4aYsMMGs+kdDbJ/MNuBGCTx/ubf5c=;
	b=UV8i1l5CXojpBw2wOT5a+2d1I6MX50f4E1HgIavwPQnHTrTa4coKPgQOiVvwda+CIqZhDS
	REpbWtfDTaNLotBw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1728392729; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVyELl6o/F4I9t4aYsMMGs+kdDbJ/MNuBGCTx/ubf5c=;
	b=tKY1fVDSZqziketyeg2QyHkTkYxUWbc1p611sUtV5/dIiBCBiS/4pRP5svR4+Omo6Z/ATA
	wYFEXPR+N+vTA0GoRCpakmv23DvPYHjpa9zvSf5a+5WGxlvD/2n7sifSYygiLJ6KtwLlBo
	i3fmgB1Uv4BpyOxgmkBmDHcMQFy90ic=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1728392729;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=uVyELl6o/F4I9t4aYsMMGs+kdDbJ/MNuBGCTx/ubf5c=;
	b=UV8i1l5CXojpBw2wOT5a+2d1I6MX50f4E1HgIavwPQnHTrTa4coKPgQOiVvwda+CIqZhDS
	REpbWtfDTaNLotBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 9BCD7137CF;
	Tue,  8 Oct 2024 13:05:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 2yzCJRkuBWcQBAAAD6G6ig
	(envelope-from <jack@suse.cz>); Tue, 08 Oct 2024 13:05:29 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id ECB3CA08BD; Tue,  8 Oct 2024 15:05:28 +0200 (CEST)
Date: Tue, 8 Oct 2024 15:05:28 +0200
From: Jan Kara <jack@suse.cz>
To: libaokun@huaweicloud.com
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
	yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>
Subject: Re: [PATCH] ext4: show the default enabled prefetch_block_bitmaps
 option
Message-ID: <20241008130528.snt2iflir7pm5co6@quack3>
References: <20241008120134.3758097-1-libaokun@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241008120134.3758097-1-libaokun@huaweicloud.com>
X-Spam-Score: -3.80
X-Spamd-Result: default: False [-3.80 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	RCVD_COUNT_THREE(0.00)[3];
	ARC_NA(0.00)[];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,imap1.dmz-prg2.suse.org:helo,huaweicloud.com:email,suse.com:email]
X-Spam-Flag: NO
X-Spam-Level: 

On Tue 08-10-24 20:01:34, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> After commit 21175ca434c5 ("ext4: make prefetch_block_bitmaps default"),
> we enable 'prefetch_block_bitmaps' by default, but this is not shown in
> the '/proc/fs/ext4/sdx/options' procfs interface.
> 
> This makes it impossible to distinguish whether the feature is enabled by
> default or not, so 'prefetch_block_bitmaps' is shown in the 'options'
> procfs interface when prefetch_block_bitmaps is enabled by default.
> 
> This makes it easy to notice changes to the default mount options between
> versions through the '/proc/fs/ext4/sdx/options' procfs interface.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/super.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index b77acba4a719..c88a47639e9c 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -3030,6 +3030,9 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
>  		SEQ_OPTS_PUTS("mb_optimize_scan=1");
>  	}
>  
> +	if (!test_opt(sb, NO_PREFETCH_BLOCK_BITMAPS))
> +		SEQ_OPTS_PUTS("prefetch_block_bitmaps");
> +
>  	ext4_show_quota_options(seq, sb);
>  	return 0;
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

