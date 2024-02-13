Return-Path: <linux-ext4+bounces-1228-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8BD853661
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 17:44:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 383C928CB00
	for <lists+linux-ext4@lfdr.de>; Tue, 13 Feb 2024 16:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB7895F866;
	Tue, 13 Feb 2024 16:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="yFOTRpEs";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="C9ZCRDpn";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="fYscvBW0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="oJa3cnAe"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47185DF05;
	Tue, 13 Feb 2024 16:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707842648; cv=none; b=AZGQgHtjDXwnNp8ygaXVbPqTFvE5Zw672XliZiKdDbH4oFAMLzj8RUsJIk0pvlnIZZmEMmCT//iqwRQhj/SNl//n9aoAg3qA8kupvMhRCefuOQSH5KxFz8cr6ikBiYDrH4DrjU5Kf0ntF79K2SuzBCCBVPS0l5VPQ6Z0skiX4q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707842648; c=relaxed/simple;
	bh=BIw4eDY+yiYJj2TXjDx68WGzcvejATb1x7mhn036r24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TJQY/OEkJMtMbDG+ubvGmYwIwXwshHycL2WW/kD1anM8c4h/pQ5LkAKJbKTFCI/UaD6WzjbVoP4gl0phPBfPxTz/tkT95cQQ1DaTbMzfDIvrMB0bABcNVeJr6FV6lRj0PbesNKl16s4dWujyfvzge49jbcazCho9eayQhSYHjSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=yFOTRpEs; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=C9ZCRDpn; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=fYscvBW0; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=oJa3cnAe; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id CAF5521D04;
	Tue, 13 Feb 2024 16:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707842643; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UQOz75ggfLw1WB47VC2EzAGSHOnNFvfwVqTF6Fqtqs=;
	b=yFOTRpEsQsI9W13Gb5rsvObCah43piNM8xmeZ2T7Mhy82/CPK6mQxxAdPZjPLBhTjpZqh/
	/jluPSQpfe5lwMzL1zBMDk5IG2CIHeFhvJsFXTZY0zvI1RH05IlJB0SBXT3yyttmxgyNbI
	IOrEvZ5YxLpqSwBZUPUcUzY/LiaGN04=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707842643;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UQOz75ggfLw1WB47VC2EzAGSHOnNFvfwVqTF6Fqtqs=;
	b=C9ZCRDpnM7zNu6CTb0iijZU9efSFXKs4xsT2Dpq3jcSzT+29KrNnRQMrJ+kgcvhInI+mx/
	8dVs9pHXG/JC9JCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1707842642; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UQOz75ggfLw1WB47VC2EzAGSHOnNFvfwVqTF6Fqtqs=;
	b=fYscvBW0UgkMswdDVGpsxrdsWFvm6T5lbhIoK3M2U7mxLNn+T4F2Vw3+3sImqfbjAYCeg/
	X41d8X8MUgYG9k9ZpaX3EK/dsZdx0sh+5hYtLvKeCjcedzRl60aPLLDKRFkQkN2kjqQCaA
	8eVSumy+NCnSzW45IuFSQ5qxc5h8FZE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1707842642;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UQOz75ggfLw1WB47VC2EzAGSHOnNFvfwVqTF6Fqtqs=;
	b=oJa3cnAeSalrpjlNHcGXSvnr70yH4UmF+HojnNLB+mJn/e1mhA9Q6MjhDhUeGLj4LlJF81
	yybHAbg5NhfpMCDw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id BC5751329E;
	Tue, 13 Feb 2024 16:44:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id xq/1LVKcy2UdDwAAn2gu4w
	(envelope-from <jack@suse.cz>); Tue, 13 Feb 2024 16:44:02 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id 65B47A0809; Tue, 13 Feb 2024 17:44:02 +0100 (CET)
Date: Tue, 13 Feb 2024 17:44:02 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com, chengzhihao1@huawei.com,
	yukuai3@huawei.com
Subject: Re: [PATCH 3/7] ext4: refactor out ext4_generic_attr_show()
Message-ID: <20240213164402.u7pph3egnguxv7du@quack3>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-4-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240126085716.1363019-4-libaokun1@huawei.com>
Authentication-Results: smtp-out1.suse.de;
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
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email,suse.cz:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Flag: NO

On Fri 26-01-24 16:57:12, Baokun Li wrote:
> Refactor out the function ext4_generic_attr_show() to handle the reading
> of values of various common types, with no functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/sysfs.c | 74 +++++++++++++++++++++----------------------------
>  1 file changed, 32 insertions(+), 42 deletions(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 834f9a0eb641..a5d657fa05cb 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -366,13 +366,42 @@ static ssize_t __print_tstamp(char *buf, __le32 lo, __u8 hi)
>  #define print_tstamp(buf, es, tstamp) \
>  	__print_tstamp(buf, (es)->tstamp, (es)->tstamp ## _hi)
>  
> +static ssize_t ext4_generic_attr_show(struct ext4_attr *a,
> +				      struct ext4_sb_info *sbi, char *buf)
> +{
> +	void *ptr = calc_ptr(a, sbi);
> +
> +	if (!ptr)
> +		return 0;
> +
> +	switch (a->attr_id) {
> +	case attr_inode_readahead:
> +	case attr_pointer_ui:
> +		if (a->attr_ptr == ptr_ext4_super_block_offset)
> +			return sysfs_emit(buf, "%u\n", le32_to_cpup(ptr));
> +		return sysfs_emit(buf, "%u\n", *((unsigned int *) ptr));
> +	case attr_pointer_ul:
> +		return sysfs_emit(buf, "%lu\n", *((unsigned long *) ptr));
> +	case attr_pointer_u8:
> +		return sysfs_emit(buf, "%u\n", *((unsigned char *) ptr));
> +	case attr_pointer_u64:
> +		if (a->attr_ptr == ptr_ext4_super_block_offset)
> +			return sysfs_emit(buf, "%llu\n", le64_to_cpup(ptr));
> +		return sysfs_emit(buf, "%llu\n", *((unsigned long long *) ptr));
> +	case attr_pointer_string:
> +		return sysfs_emit(buf, "%.*s\n", a->attr_size, (char *) ptr);
> +	case attr_pointer_atomic:
> +		return sysfs_emit(buf, "%d\n", atomic_read((atomic_t *) ptr));
> +	}
> +	return 0;
> +}
> +
>  static ssize_t ext4_attr_show(struct kobject *kobj,
>  			      struct attribute *attr, char *buf)
>  {
>  	struct ext4_sb_info *sbi = container_of(kobj, struct ext4_sb_info,
>  						s_kobj);
>  	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
> -	void *ptr = calc_ptr(a, sbi);
>  
>  	switch (a->attr_id) {
>  	case attr_delayed_allocation_blocks:
> @@ -391,45 +420,6 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>  		return sysfs_emit(buf, "%llu\n",
>  				(unsigned long long)
>  			percpu_counter_sum(&sbi->s_sra_exceeded_retry_limit));
> -	case attr_inode_readahead:
> -	case attr_pointer_ui:
> -		if (!ptr)
> -			return 0;
> -		if (a->attr_ptr == ptr_ext4_super_block_offset)
> -			return sysfs_emit(buf, "%u\n",
> -					le32_to_cpup(ptr));
> -		else
> -			return sysfs_emit(buf, "%u\n",
> -					*((unsigned int *) ptr));
> -	case attr_pointer_ul:
> -		if (!ptr)
> -			return 0;
> -		return sysfs_emit(buf, "%lu\n",
> -				*((unsigned long *) ptr));
> -	case attr_pointer_u8:
> -		if (!ptr)
> -			return 0;
> -		return sysfs_emit(buf, "%u\n",
> -				*((unsigned char *) ptr));
> -	case attr_pointer_u64:
> -		if (!ptr)
> -			return 0;
> -		if (a->attr_ptr == ptr_ext4_super_block_offset)
> -			return sysfs_emit(buf, "%llu\n",
> -					le64_to_cpup(ptr));
> -		else
> -			return sysfs_emit(buf, "%llu\n",
> -					*((unsigned long long *) ptr));
> -	case attr_pointer_string:
> -		if (!ptr)
> -			return 0;
> -		return sysfs_emit(buf, "%.*s\n", a->attr_size,
> -				(char *) ptr);
> -	case attr_pointer_atomic:
> -		if (!ptr)
> -			return 0;
> -		return sysfs_emit(buf, "%d\n",
> -				atomic_read((atomic_t *) ptr));
>  	case attr_feature:
>  		return sysfs_emit(buf, "supported\n");
>  	case attr_first_error_time:
> @@ -438,9 +428,9 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>  		return print_tstamp(buf, sbi->s_es, s_last_error_time);
>  	case attr_journal_task:
>  		return journal_task_show(sbi, buf);
> +	default:
> +		return ext4_generic_attr_show(a, sbi, buf);
>  	}
> -
> -	return 0;
>  }
>  
>  static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

