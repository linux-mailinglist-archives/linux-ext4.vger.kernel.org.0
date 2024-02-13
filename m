Return-Path: <linux-ext4+bounces-1230-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0533A8536AE
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 17:58:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29D9E1C2319C
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 16:58:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6C0A5FB94;
	Tue, 13 Feb 2024 16:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="ZAYaUhvN";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kDPKGOiG";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="UcCKUZfJ";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="jsFOrGhF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8660241;
	Tue, 13 Feb 2024 16:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707843495; cv=none; b=emkZvdaC9mVShDaaAEXFvHlCZo215b/3KOgourBAi5rC2ZhgAl7wix5Nk4m9vCdY2aPnPeLX4M0eIlQ3ePtMCKlXJ9b75mO7J1+BNULQxyFS6HejERv1LA8MHy6xAAGCGtQn1zC1Moh0b2EI9IYYJBJWqxs1C04lkTEmzXZFLX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707843495; c=relaxed/simple;
	bh=1kPoM7mZIIwydFIJLphtxyj9PWUrvsLk9s5/kBBQ/Uo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Lbbu0gFAxoG6efgjgxJelm0BVQ2Zd+lldzfCx2Lm6lsXgR0kr/SPRUbtHE5xSQU1qBSucJGXPQVckdrOZRw9zEVbkxTfMHSeaiKsJoX12CJY58pAQy5WHzYmo6lXljOzI+vjt8Mup+JW6PxwazYtsSoKs1HRX6HUBFQpR7bcCY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=ZAYaUhvN; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kDPKGOiG; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=UcCKUZfJ; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=jsFOrGhF; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id E05CA1FCE8;
	Tue, 13 Feb 2024 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707843491; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N841xdJKomiyZQlx/u13JNWKGG1AmBMzEzrwG9MLa+Q=;
	b=ZAYaUhvN5i2lv/ydKS1Ks12M1eguZmwwAJX3LELH8cEqHwmMnVo6tkqiuZbn2KI2xi6B9q
	z4su5T/33umCnNdYml2assfoLbWbZFSNqcyyCC34N79l4N4eDUXQcaYFWk+SpTnhYVkJh8
	jF/jnIdY5zir68xxzFU1NS0ThZGElUY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707843491;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N841xdJKomiyZQlx/u13JNWKGG1AmBMzEzrwG9MLa+Q=;
	b=kDPKGOiGjS8VMgLE/RbXD6exsvUhQhnMHvD8RVtndvSsh2VBxvbM/SYMKxuYF6tH5LRx2n
	STB3WfqQYmePuhDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707843490; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N841xdJKomiyZQlx/u13JNWKGG1AmBMzEzrwG9MLa+Q=;
	b=UcCKUZfJGxJ0HZI1z7IDjthzeQOy/HgFQG4G9+iT6QooZv0UpShZ5/1bseR8aCcwbTkznr
	A7CD1VeDdPrrdheXVfzM2KSk5aSqhb7hqxo1h13LRhqwPU7J2x9OIWeJeuxZMv7T23nBip
	hwwuBXsdvvGEs7bHPd3AZNczqwKfGOw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707843490;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=N841xdJKomiyZQlx/u13JNWKGG1AmBMzEzrwG9MLa+Q=;
	b=jsFOrGhF69+Rj/4GLnifEpR7+kwqRafT+9h1BaWgFRM02QPTCQCAie/KZDm5v68DhzoQSY
	kXo/8NMD7c2/nZAA==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id CBC6713583;
	Tue, 13 Feb 2024 16:58:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Oe+9MaKfy2VIEgAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 16:58:10 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 5FE59A0809; Tue, 13 Feb 2024 17:58:10 +0100 (CET)
Date: Tue, 13 Feb 2024 17:58:10 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com, stable@vger.kernel.org
Subject: Re: [PATCH 4/7] ext4: add positive int attr pointer to avoid sysfs
 variables overflow
Message-ID: <20240213165810.3k4lnxaqzdwrdj35@quack3>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-5-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126085716.1363019-5-libaokun1@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out2.suse.de;
	dkim=pass header.d=suse.cz header.s=susede2_rsa header.b=UcCKUZfJ;
	dkim=pass header.d=suse.cz header.s=susede2_ed25519 header.b=jsFOrGhF
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-2.51 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 R_DKIM_ALLOW(-0.20)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 BAYES_HAM(-3.00)[100.00%];
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
	 RCPT_COUNT_TWELVE(0.00)[12];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -2.51
X-Rspamd-Queue-Id: E05CA1FCE8
X-Spam-Flag: NO

On Fri 26-01-24 16:57:13, Baokun Li wrote:
> We can easily trigger a BUG_ON by using the following commands:
> 
>     mount /dev/$disk /tmp/test
>     echo 2147483650 > /sys/fs/ext4/$disk/mb_group_prealloc
>     echo test > /tmp/test/file && sync
> 
> ==================================================================
> kernel BUG at fs/ext4/mballoc.c:2029!
> invalid opcode: 0000 [#1] PREEMPT SMP PTI
> CPU: 3 PID: 320 Comm: kworker/u36:1 Not tainted 6.8.0-rc1 #462
> RIP: 0010:mb_mark_used+0x358/0x370
> [...]
> Call Trace:
>  ext4_mb_use_best_found+0x56/0x140
>  ext4_mb_complex_scan_group+0x196/0x2f0
>  ext4_mb_regular_allocator+0xa92/0xf00
>  ext4_mb_new_blocks+0x302/0xbc0
>  ext4_ext_map_blocks+0x95a/0xef0
>  ext4_map_blocks+0x2b1/0x680
>  ext4_do_writepages+0x733/0xbd0
> [...]
> ==================================================================
> 
> In ext4_mb_normalize_group_request():
>     ac->ac_g_ex.fe_len = EXT4_SB(sb)->s_mb_group_prealloc;
> 
> Here fe_len is of type int, but s_mb_group_prealloc is of type unsigned
> int, so setting s_mb_group_prealloc to 2147483650 overflows fe_len to a
> negative number, which ultimately triggers a BUG_ON() in mb_mark_used().
> 
> Therefore, we add attr_pointer_pi (aka positive int attr pointer) with a
> value range of 0-INT_MAX to avoid the above problem. In addition to the
> mb_group_prealloc sysfs interface, the following interfaces also have uint
> to int conversions that result in overflows, and are also fixed.
> 
>   err_ratelimit_burst
>   msg_ratelimit_burst
>   warning_ratelimit_burst
>   err_ratelimit_interval_ms
>   msg_ratelimit_interval_ms
>   warning_ratelimit_interval_ms
>   mb_best_avail_max_trim_order
> 
> CC: stable@vger.kernel.org
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

I don't think you need to change s_mb_group_prealloc here and then restrict
it even further in the next patch. I'd just leave it alone here.

Also I think that limiting mb_best_avail_max_trim_order to 64 instead of
INT_MAX will make us more resilient to surprises in the future :) But I
don't really insist.

								Honza

> ---
>  fs/ext4/sysfs.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index a5d657fa05cb..6f9f96e00f2f 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -30,6 +30,7 @@ typedef enum {
>  	attr_first_error_time,
>  	attr_last_error_time,
>  	attr_feature,
> +	attr_pointer_pi,
>  	attr_pointer_ui,
>  	attr_pointer_ul,
>  	attr_pointer_u64,
> @@ -178,6 +179,9 @@ static struct ext4_attr ext4_attr_##_name = {			\
>  #define EXT4_RO_ATTR_ES_STRING(_name,_elname,_size)			\
>  	EXT4_ATTR_STRING(_name, 0444, _size, ext4_super_block, _elname)
>  
> +#define EXT4_RW_ATTR_SBI_PI(_name,_elname)      \
> +	EXT4_ATTR_OFFSET(_name, 0644, pointer_pi, ext4_sb_info, _elname)
> +
>  #define EXT4_RW_ATTR_SBI_UI(_name,_elname)	\
>  	EXT4_ATTR_OFFSET(_name, 0644, pointer_ui, ext4_sb_info, _elname)
>  
> @@ -213,17 +217,17 @@ EXT4_RW_ATTR_SBI_UI(mb_max_to_scan, s_mb_max_to_scan);
>  EXT4_RW_ATTR_SBI_UI(mb_min_to_scan, s_mb_min_to_scan);
>  EXT4_RW_ATTR_SBI_UI(mb_order2_req, s_mb_order2_reqs);
>  EXT4_RW_ATTR_SBI_UI(mb_stream_req, s_mb_stream_request);
> -EXT4_RW_ATTR_SBI_UI(mb_group_prealloc, s_mb_group_prealloc);
> +EXT4_RW_ATTR_SBI_PI(mb_group_prealloc, s_mb_group_prealloc);
>  EXT4_RW_ATTR_SBI_UI(mb_max_linear_groups, s_mb_max_linear_groups);
>  EXT4_RW_ATTR_SBI_UI(extent_max_zeroout_kb, s_extent_max_zeroout_kb);
>  EXT4_ATTR(trigger_fs_error, 0200, trigger_test_error);
> -EXT4_RW_ATTR_SBI_UI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
> -EXT4_RW_ATTR_SBI_UI(err_ratelimit_burst, s_err_ratelimit_state.burst);
> -EXT4_RW_ATTR_SBI_UI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.interval);
> -EXT4_RW_ATTR_SBI_UI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
> -EXT4_RW_ATTR_SBI_UI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
> -EXT4_RW_ATTR_SBI_UI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
> -EXT4_RW_ATTR_SBI_UI(mb_best_avail_max_trim_order, s_mb_best_avail_max_trim_order);
> +EXT4_RW_ATTR_SBI_PI(err_ratelimit_interval_ms, s_err_ratelimit_state.interval);
> +EXT4_RW_ATTR_SBI_PI(err_ratelimit_burst, s_err_ratelimit_state.burst);
> +EXT4_RW_ATTR_SBI_PI(warning_ratelimit_interval_ms, s_warning_ratelimit_state.interval);
> +EXT4_RW_ATTR_SBI_PI(warning_ratelimit_burst, s_warning_ratelimit_state.burst);
> +EXT4_RW_ATTR_SBI_PI(msg_ratelimit_interval_ms, s_msg_ratelimit_state.interval);
> +EXT4_RW_ATTR_SBI_PI(msg_ratelimit_burst, s_msg_ratelimit_state.burst);
> +EXT4_RW_ATTR_SBI_PI(mb_best_avail_max_trim_order, s_mb_best_avail_max_trim_order);
>  #ifdef CONFIG_EXT4_DEBUG
>  EXT4_RW_ATTR_SBI_UL(simulate_fail, s_simulate_fail);
>  #endif
> @@ -376,6 +380,7 @@ static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
>  
>  	switch (a->attr_id) {
>  	case attr_inode_readahead:
> +	case attr_pointer_pi:
>  	case attr_pointer_ui:
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
>  			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
> @@ -448,6 +453,10 @@ static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
>  		return ret;
>  
>  	switch (a->attr_id) {
> +	case attr_pointer_pi:
> +		if ((int)t < 0)
> +			return -EINVAL;
> +		fallthrough;
>  	case attr_pointer_ui:
>  		if (t != (unsigned int)t)
>  			return -EINVAL;
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

