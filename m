Return-Path: <linux-ext4+bounces-671-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DCB823F7C
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 11:33:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE293B21767
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Jan 2024 10:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 020E720B05;
	Thu,  4 Jan 2024 10:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cQZiEYD6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zhkhrPo";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="cQZiEYD6";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="7zhkhrPo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00F1620DC6;
	Thu,  4 Jan 2024 10:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 048AE21F5E;
	Thu,  4 Jan 2024 10:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704364417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXZ4BRQC/CGS+exrggKY4p1MXmkXTl4f0SwYBKvZwqk=;
	b=cQZiEYD67DA0vS96eJlXHFELMCj8tuZ5jJSqHs5rqFeaBH6eib4nP8gmeHS3Yb61xEATZ2
	oOeLCcEIX0LsoSCPRCuaM3iod19e/5lHZc/ebzpV9XUYOaUzSZCnsQ4lQXCoXLcmbbfwjy
	MfgrDGMfPL6lEf3ZJ7w0protD3hsV9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704364417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXZ4BRQC/CGS+exrggKY4p1MXmkXTl4f0SwYBKvZwqk=;
	b=7zhkhrPopIgLb/0D6WzvlUOH2QQfqU4B4km7NYe6aeGDU+ZxtG8HY7YQS241zyhEP9Z8Z1
	BV7d194H53TklyDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704364417; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXZ4BRQC/CGS+exrggKY4p1MXmkXTl4f0SwYBKvZwqk=;
	b=cQZiEYD67DA0vS96eJlXHFELMCj8tuZ5jJSqHs5rqFeaBH6eib4nP8gmeHS3Yb61xEATZ2
	oOeLCcEIX0LsoSCPRCuaM3iod19e/5lHZc/ebzpV9XUYOaUzSZCnsQ4lQXCoXLcmbbfwjy
	MfgrDGMfPL6lEf3ZJ7w0protD3hsV9Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704364417;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=HXZ4BRQC/CGS+exrggKY4p1MXmkXTl4f0SwYBKvZwqk=;
	b=7zhkhrPopIgLb/0D6WzvlUOH2QQfqU4B4km7NYe6aeGDU+ZxtG8HY7YQS241zyhEP9Z8Z1
	BV7d194H53TklyDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E893813C96;
	Thu,  4 Jan 2024 10:33:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dxdfOICJlmWqcwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 04 Jan 2024 10:33:36 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 631F8A07EF; Thu,  4 Jan 2024 11:33:36 +0100 (CET)
Date: Thu, 4 Jan 2024 11:33:36 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v2 3/8] ext4: regenerate buddy after block freeing failed
 if under fc replay
Message-ID: <20240104103336.fjwhqiv2maezquef@quack3>
References: <20231221150558.2740823-1-libaokun1@huawei.com>
 <20231221150558.2740823-4-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231221150558.2740823-4-libaokun1@huawei.com>
X-Spam-Level: 
X-Spam-Level: 
X-Spamd-Result: default: False [-1.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 BAYES_HAM(-3.00)[100.00%];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[10];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Score: -1.10
X-Spam-Flag: NO

On Thu 21-12-23 23:05:53, Baokun Li wrote:
> This reverts [Fixes] under fast commit replay. When we are freeing blocks
> that have already been freed, the buddy may be corrupted, and we need to
> regenerate the buddy when the fast commit is being replayed in order to
> avoid using an corrupted buddy, since it will not mark the group block
> bitmap as corrupted at that point.

I'd rephrase the changelog as:

This mostly reverts commit 6bd97bf273bd ("ext4: remove redundant
mb_regenerate_buddy()") and reintroduces mb_regenerate_buddy(). Based on
code in mb_free_blocks(), fast commit replay can end up marking as free
blocks that are already marked as such. This causes corruption of the
buddy bitmap so we need to regenerate it in that case.

Otherwise the patch looks good to me so feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza
> 
> Reported-by: Jan Kara <jack@suse.cz>
> Fixes: 6bd97bf273bd ("ext4: remove redundant mb_regenerate_buddy()")
> Signed-off-by: Baokun Li <libaokun1@huawei.com>
> ---
>  fs/ext4/mballoc.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index a95fa6e2b0f9..f6131ba514c8 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1233,6 +1233,24 @@ void ext4_mb_generate_buddy(struct super_block *sb,
>  	atomic64_add(period, &sbi->s_mb_generation_time);
>  }
>  
> +static void mb_regenerate_buddy(struct ext4_buddy *e4b)
> +{
> +	int count;
> +	int order = 1;
> +	void *buddy;
> +
> +	while ((buddy = mb_find_buddy(e4b, order++, &count)))
> +		mb_set_bits(buddy, 0, count);
> +
> +	e4b->bd_info->bb_fragments = 0;
> +	memset(e4b->bd_info->bb_counters, 0,
> +		sizeof(*e4b->bd_info->bb_counters) *
> +		(e4b->bd_sb->s_blocksize_bits + 2));
> +
> +	ext4_mb_generate_buddy(e4b->bd_sb, e4b->bd_buddy,
> +		e4b->bd_bitmap, e4b->bd_group, e4b->bd_info);
> +}
> +
>  /* The buddy information is attached the buddy cache inode
>   * for convenience. The information regarding each group
>   * is loaded via ext4_mb_load_buddy. The information involve
> @@ -1921,6 +1939,8 @@ static void mb_free_blocks(struct inode *inode, struct ext4_buddy *e4b,
>  			ext4_mark_group_bitmap_corrupted(
>  				sb, e4b->bd_group,
>  				EXT4_GROUP_INFO_BBITMAP_CORRUPT);
> +		} else {
> +			mb_regenerate_buddy(e4b);
>  		}
>  		goto done;
>  	}
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

