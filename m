Return-Path: <linux-ext4+bounces-1624-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC9987BB1C
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 11:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 622FC1F23791
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 10:16:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BBCA6E615;
	Thu, 14 Mar 2024 10:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EfuBXD8K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/DnoVl1J";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="EfuBXD8K";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="/DnoVl1J"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 144376BFCA;
	Thu, 14 Mar 2024 10:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411373; cv=none; b=S81R9FJu3GqVGCi5qzvuj3MtSJj/KZ6066ZSZDqoXL/FPPr1tUlZjy4oPU8BNyG/F0BkUYTwhZP13ZikBsz5NCdW8Aqh8+MPZ0JlsgQhIo6w9kEVOrE9AwqIvU51j+L7Eb6Iua6QTQVuo6f2FwJAaNZ8Ra+vvKjOlLD7WERoMfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411373; c=relaxed/simple;
	bh=A+VI2AvXcbV/uX0e6KUMlv51QQ9MOcpmNNlefrIsMAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UnVCVGpIbJ5Wc0toP6L3WQVich7HYsB4t5oloyyGthbrO3+ByBoDm+C1OnuVCjq5x4P6DGT9cI4zRxA+OkhbxA9bhaHB1To1TjyEGtI9InzOPJj0edTPrkSk0ZUgISstnO1QkZ4oNeNHmiFbXh9QFVMObg45X5IGkGGjogqPyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EfuBXD8K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/DnoVl1J; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=EfuBXD8K; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=/DnoVl1J; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 23F6A1F844;
	Thu, 14 Mar 2024 10:16:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710411369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGqtFojTtFdfdsD45yqBIxESVH8PwlsO9g9NMB44wFg=;
	b=EfuBXD8KgjzmUSrFivKV03ymVF85GjaKcUuXWcVQdI+P7aSihJSriln3K8J4yWD5VyoCyQ
	gIMSXTo3z2gyg3JuFkpUTvuAUGm+w0ZQ4eEQPHDY43KjklGHLm4BE6oYKe3RKo/1eP5+R2
	Tu1ek5TrqukWeQM7CzD18FbRcPWnBHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710411369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGqtFojTtFdfdsD45yqBIxESVH8PwlsO9g9NMB44wFg=;
	b=/DnoVl1JuzbnghKOTpY/P+3aC445w3Gi5/0xRds8ZJjQi9D/7RiygEkwV27/dPyeQtWmv7
	0fFcnumbOZVcwfCg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710411369; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGqtFojTtFdfdsD45yqBIxESVH8PwlsO9g9NMB44wFg=;
	b=EfuBXD8KgjzmUSrFivKV03ymVF85GjaKcUuXWcVQdI+P7aSihJSriln3K8J4yWD5VyoCyQ
	gIMSXTo3z2gyg3JuFkpUTvuAUGm+w0ZQ4eEQPHDY43KjklGHLm4BE6oYKe3RKo/1eP5+R2
	Tu1ek5TrqukWeQM7CzD18FbRcPWnBHc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710411369;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eGqtFojTtFdfdsD45yqBIxESVH8PwlsO9g9NMB44wFg=;
	b=/DnoVl1JuzbnghKOTpY/P+3aC445w3Gi5/0xRds8ZJjQi9D/7RiygEkwV27/dPyeQtWmv7
	0fFcnumbOZVcwfCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 156E913929;
	Thu, 14 Mar 2024 10:16:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id DfY1BWnO8mWVSgAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 10:16:09 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id A821FA07D9; Thu, 14 Mar 2024 11:16:08 +0100 (CET)
Date: Thu, 14 Mar 2024 11:16:08 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 1/9] ext4: avoid overflow when setting values via sysfs
Message-ID: <20240314101608.6tcgu3myognxxh3j@quack3>
References: <20240227091148.178435-1-libaokun1@huawei.com>
 <20240227091148.178435-2-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227091148.178435-2-libaokun1@huawei.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.30
X-Spamd-Result: default: False [-2.30 / 50.00];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_SEVEN(0.00)[11];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 FREEMAIL_ENVRCPT(0.00)[gmail.com];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 TAGGED_RCPT(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Tue 27-02-24 17:11:40, Baokun Li wrote:
> When setting values of type unsigned int through sysfs, we use kstrtoul()
> to parse it and then truncate part of it as the final set value, when the
> set value is greater than UINT_MAX, the set value will not match what we
> see because of the truncation. As follows:
> 
>   $ echo 4294967296 > /sys/fs/ext4/sda/mb_max_linear_groups
>   $ cat /sys/fs/ext4/sda/mb_max_linear_groups
>     0
> 
> So we use kstrtouint() to parse the attr_pointer_ui type to avoid the
> inconsistency described above. In addition, a judgment is added to avoid
> setting s_resv_clusters less than 0.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks! The patch looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/sysfs.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 6d332dff79dd..ca820620b974 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -104,7 +104,7 @@ static ssize_t reserved_clusters_store(struct ext4_sb_info *sbi,
>  	int ret;
>  
>  	ret = kstrtoull(skip_spaces(buf), 0, &val);
> -	if (ret || val >= clusters)
> +	if (ret || val >= clusters || (s64)val < 0)
>  		return -EINVAL;
>  
>  	atomic64_set(&sbi->s_resv_clusters, val);
> @@ -451,7 +451,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>  						s_kobj);
>  	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
>  	void *ptr = calc_ptr(a, sbi);
> -	unsigned long t;
> +	unsigned int t;
> +	unsigned long lt;
>  	int ret;
>  
>  	switch (a->attr_id) {
> @@ -460,7 +461,7 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>  	case attr_pointer_ui:
>  		if (!ptr)
>  			return 0;
> -		ret = kstrtoul(skip_spaces(buf), 0, &t);
> +		ret = kstrtouint(skip_spaces(buf), 0, &t);
>  		if (ret)
>  			return ret;
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
> @@ -471,10 +472,10 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>  	case attr_pointer_ul:
>  		if (!ptr)
>  			return 0;
> -		ret = kstrtoul(skip_spaces(buf), 0, &t);
> +		ret = kstrtoul(skip_spaces(buf), 0, &lt);
>  		if (ret)
>  			return ret;
> -		*((unsigned long *) ptr) = t;
> +		*((unsigned long *) ptr) = lt;
>  		return len;
>  	case attr_inode_readahead:
>  		return inode_readahead_blks_store(sbi, buf, len);
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

