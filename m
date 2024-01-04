Return-Path: <linux-ext4+bounces-674-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 03B20823FBD
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 11:46:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2E41F25267
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 10:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3633D21A1C;
	Thu,  4 Jan 2024 10:45:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2AShXaHw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jej9803v";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="2AShXaHw";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="Jej9803v"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377B5210E9;
	Thu,  4 Jan 2024 10:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 503371F800;
	Thu,  4 Jan 2024 10:45:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704365112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qrIGhLv2SxdSJiBgvJ6RBN/JBcW+xFNE2ns/9BE/9Dc=;
	b=2AShXaHwXqOM/NWK4V3NBLuFMDgR5Cyis/b6BCVMQw3Jw7rx2yBiD5GBhno8DQZFz0FiUX
	WSkU2EqOiaXVZGOx7VUVz3IS3+TTqvpdZ6HZCE0MYa2f2wwSrW15SYdD9qc2ht1yg2trli
	XsC+Jt3bvqD6CFpV0g0Q45htWLVd8Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704365112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qrIGhLv2SxdSJiBgvJ6RBN/JBcW+xFNE2ns/9BE/9Dc=;
	b=Jej9803vYI774QiOY3bC15dEnx+FHitaYbS+GYSZix5ViiukKuFCDSPwuFLzABWSI1TSZF
	S64HoCI109htWAAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704365112; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qrIGhLv2SxdSJiBgvJ6RBN/JBcW+xFNE2ns/9BE/9Dc=;
	b=2AShXaHwXqOM/NWK4V3NBLuFMDgR5Cyis/b6BCVMQw3Jw7rx2yBiD5GBhno8DQZFz0FiUX
	WSkU2EqOiaXVZGOx7VUVz3IS3+TTqvpdZ6HZCE0MYa2f2wwSrW15SYdD9qc2ht1yg2trli
	XsC+Jt3bvqD6CFpV0g0Q45htWLVd8Fg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704365112;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qrIGhLv2SxdSJiBgvJ6RBN/JBcW+xFNE2ns/9BE/9Dc=;
	b=Jej9803vYI774QiOY3bC15dEnx+FHitaYbS+GYSZix5ViiukKuFCDSPwuFLzABWSI1TSZF
	S64HoCI109htWAAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3AD8F13722;
	Thu,  4 Jan 2024 10:45:12 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id nFxbDjiMlmVGdwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 10:45:12 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id EF757A07EF; Thu,  4 Jan 2024 11:45:11 +0100 (CET)
Date: Thu, 4 Jan 2024 11:45:11 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 6/8] ext4: avoid allocating blocks from corrupted
 group in ext4_mb_try_best_found()
Message-ID: <20240104104511.axpp3k4tti6xbk2l@quack3>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
 <20231221150558.2740823-7-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221150558.2740823-7-libaokun1@huawei.com>
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Score: 1.69
X-Spamd-Bar: +
X-Spam-Flag: NO
X-Spamd-Result: default: False [1.69 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-0.00)[37.96%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DKIM_TRACE(0.00)[suse.cz:+];
	 MX_GOOD(-0.01)[];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:dkim,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[];
	 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=2AShXaHw;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=Jej9803v
X-Spam-Level: *
X-Rspamd-Queue-Id: 503371F800

On Thu 21-12-23 23:05:56, Baokun Li wrote:
> Determine if the group block bitmap is corrupted before using ac_b_ex in
> ext4_mb_try_best_found() to avoid allocating blocks from a group with a
> corrupted block bitmap in the following concurrency and making the
> situation worse.
> 
> ext4_mb_regular_allocator
>   ext4_lock_group(sb, group)
>   ext4_mb_good_group
>    // check if the group bbitmap is corrupted
>   ext4_mb_complex_scan_group
>    // Scan group gets ac_b_ex but doesn't use it
>   ext4_unlock_group(sb, group)
>                            ext4_mark_group_bitmap_corrupted(group)
>                            // The block bitmap was corrupted during
>                            // the group unlock gap.
>   ext4_mb_try_best_found
>     ext4_lock_group(ac->ac_sb, group)
>     ext4_mb_use_best_found
>       mb_mark_used
>       // Allocating blocks in block bitmap corrupted group
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/mballoc.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 03500aec43ac..2bb29f0077bd 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -2303,6 +2303,9 @@ void ext4_mb_try_best_found(struct ext4_allocation_context *ac,
>  		return;
>  
>  	ext4_lock_group(ac->ac_sb, group);
> +	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
> +		goto out;
> +
>  	max = mb_find_extent(e4b, ex.fe_start, ex.fe_len, &ex);
>  
>  	if (max > 0) {
> @@ -2310,6 +2313,7 @@ void ext4_mb_try_best_found(struct ext4_allocation_context *ac,
>  		ext4_mb_use_best_found(ac, e4b);
>  	}
>  
> +out:
>  	ext4_unlock_group(ac->ac_sb, group);
>  	ext4_mb_unload_buddy(e4b);
>  }
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

