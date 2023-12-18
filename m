Return-Path: <linux-ext4+bounces-494-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6A5E8173FD
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 15:44:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 637701F23BE4
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 14:44:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7AF3787E;
	Mon, 18 Dec 2023 14:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UXf5xKNI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q8X0/aQi";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UXf5xKNI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Q8X0/aQi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB48D1D132;
	Mon, 18 Dec 2023 14:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id EBDBE21F2E;
	Mon, 18 Dec 2023 14:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702910627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d8GrftnGjxPKzceHJS6yGcWMugVOXmdYuVtBRV+I0mM=;
	b=UXf5xKNIqQe5GVWIakWF12limsR4ecoCOgCy773GvIhJGVEw/k3zLBvtZ5ZnWv+Dnpu2Bg
	v9z+bKViKz1GGHx/Uz3YtWx0vyfe/r9fnKXnu3hzn33AhTYig/Ume5uDOXHVg7mnrN42MQ
	JPSB6FAD9K9wWXVyPROib9yjIQoeMVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702910627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d8GrftnGjxPKzceHJS6yGcWMugVOXmdYuVtBRV+I0mM=;
	b=Q8X0/aQia3CZ+g2cFg/vk5DmfxY4jnMzhoYyKOHZzp+NHyI8keqw1JRlkzP0Vxo1sbgRsR
	K2xGi1aVFsLUKnBQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1702910627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d8GrftnGjxPKzceHJS6yGcWMugVOXmdYuVtBRV+I0mM=;
	b=UXf5xKNIqQe5GVWIakWF12limsR4ecoCOgCy773GvIhJGVEw/k3zLBvtZ5ZnWv+Dnpu2Bg
	v9z+bKViKz1GGHx/Uz3YtWx0vyfe/r9fnKXnu3hzn33AhTYig/Ume5uDOXHVg7mnrN42MQ
	JPSB6FAD9K9wWXVyPROib9yjIQoeMVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1702910627;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=d8GrftnGjxPKzceHJS6yGcWMugVOXmdYuVtBRV+I0mM=;
	b=Q8X0/aQia3CZ+g2cFg/vk5DmfxY4jnMzhoYyKOHZzp+NHyI8keqw1JRlkzP0Vxo1sbgRsR
	K2xGi1aVFsLUKnBQ==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DAAA713927;
	Mon, 18 Dec 2023 14:43:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id FU0SNaJagGUccQAAn2gu4w
	(envelope-from <jack@suse.cz>); Mon, 18 Dec 2023 14:43:46 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 7E230A07E0; Mon, 18 Dec 2023 15:43:42 +0100 (CET)
Date: Mon, 18 Dec 2023 15:43:42 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 4/4] ext4: avoid dividing by 0 in
 mb_update_avg_fragment_size() when block bitmap corrupt
Message-ID: <20231218144342.2we3j2dtyedulfga@quack3>
References: <20231218141814.1477338-1-libaokun1@huawei.com>
 <20231218141814.1477338-5-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231218141814.1477338-5-libaokun1@huawei.com>
X-Spam-Level: **
X-Spam-Level: 
X-Spamd-Bar: /
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UXf5xKNI;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b="Q8X0/aQi"
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [0.49 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:98:from];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:dkim,suse.com:email,huawei.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: 0.49
X-Rspamd-Queue-Id: EBDBE21F2E
X-Spam-Flag: NO

On Mon 18-12-23 22:18:14, Baokun Li wrote:
> When bb_free is not 0 but bb_fragments is 0, return directly to avoid
> system crash due to division by zero.

How could this possibly happen? bb_fragments is the number of free space
extents and bb_free is the number of free blocks. No free space extents =>
no free blocks seems pretty obvious? You can see the logic in
ext4_mb_generate_buddy()...

								Honza

> 
> Fixes: 83e80a6e3543 ("ext4: use buckets for cr 1 block scan instead of rbtree")
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 2fbee0f0f5c3..e2a167240335 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -845,6 +845,9 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>  	if (!test_opt2(sb, MB_OPTIMIZE_SCAN) || grp->bb_free == 0)
>  		return;
>  
> +	if (unlikely(grp->bb_fragments == 0))
> +		return;
> +
>  	new_order = mb_avg_fragment_size_order(sb,
>  					grp->bb_free / grp->bb_fragments);
>  	if (new_order == grp->bb_avg_fragment_size_order)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

