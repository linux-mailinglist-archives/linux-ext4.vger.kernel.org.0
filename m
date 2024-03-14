Return-Path: <linux-ext4+bounces-1625-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E193387BB1F
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 11:18:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECB852848C5
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Mar 2024 10:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 539F26E611;
	Thu, 14 Mar 2024 10:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="i5/M6tRI";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="kBBCi5gH";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="r8nSH9aE";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="DjetoKLc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49666BFCA;
	Thu, 14 Mar 2024 10:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411489; cv=none; b=fbz+Pu+eOEr0VdpsaS9S4S8THcMuYwAnsxrvyV3dzU8rzWZADXD7I2srMv7dxA7NMkxWnr/ypTk1PX40hg+2JS10ZbeSq2Z6iW4ss5CU8CkeDVnCnqTXvFPvS3hqn/41Ud1K0imkjfBpuQK3e/w+r1mu58KXFj9NDYXmYSUnHuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411489; c=relaxed/simple;
	bh=AnAuQT37YaWQZAMz+AR/werPdZqgwJ/zbc/zH39GRGg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SvUjQlNBbOOzZFbh7yrgAIo7I6t9FtwqS6qP98hdROLKoZj9rP5s7vfAZbHGabxcP8JWFiDpd7zYsN6DwZneFLg4uZaW/094McVtSs0xK5qAQs+7RRgX2u54I8Q4agU++fwcbpDZMdRb05aME6F+KfSspbSAFM4+//7JPUYQeok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=i5/M6tRI; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=kBBCi5gH; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=r8nSH9aE; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=DjetoKLc; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1E1CE21AC4;
	Thu, 14 Mar 2024 10:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710411486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySog/zjDpUYOch58AJ2FaM4msCGRe+Q230M1NHr8hDU=;
	b=i5/M6tRI2o5y1I8Si/twRVmGFpf1zZfzjXA2LKTTWSn8y8uLTc4Jq0RVoazSlNwh72x/K7
	Q6N20w3s8XrQyv+jzslx5Cc/pCEgntyMq/RWzNQjIlti6M4qNIWMeq91vGZsVeIQGWCPOy
	Nyknp06Rx69VfOKbvDMmKF0uKZez61k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710411486;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySog/zjDpUYOch58AJ2FaM4msCGRe+Q230M1NHr8hDU=;
	b=kBBCi5gHaWV33DzWUtXvuhplDLm+OaDTUfyIneeNrf0QA5uc/XT7zY5Yf1AVjtrzf2q4bb
	GK8DNfw208ZsCmDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1710411484; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySog/zjDpUYOch58AJ2FaM4msCGRe+Q230M1NHr8hDU=;
	b=r8nSH9aEJvFunFdCgOWaQYEUL8oe1NdntORsb1/A6nQx6fATn+m2P0dSkK3iYzBtjYGGdJ
	vbygmYDW4a9q/rtsTK8bCHilJPV4WV6f63oU3U5i+3+fFNWqH+GbecMrkBbZ3nBCV4XPjz
	MnAxEpbJ7dqihExColyuZdgK2t1B04g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1710411484;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ySog/zjDpUYOch58AJ2FaM4msCGRe+Q230M1NHr8hDU=;
	b=DjetoKLc1nsKEc/8b5BnnW3OGEdoU1zcVuuFmEIcl3LVdOelPrUs0iginEJIG2bS74nA4N
	A07X+kHFpGV/bsCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0712113929;
	Thu, 14 Mar 2024 10:18:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id ABguAdzO8mUuSwAAD6G6ig
	(envelope-from <jack@suse.cz>); Thu, 14 Mar 2024 10:18:04 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
	id AE557A07D9; Thu, 14 Mar 2024 11:18:03 +0100 (CET)
Date: Thu, 14 Mar 2024 11:18:03 +0100
From: Jan Kara <jack@suse.cz>
To: Baokun Li <libaokun1@huawei.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
	jack@suse.cz, ritesh.list@gmail.com, ojaswin@linux.ibm.com,
	adobriyan@gmail.com, linux-kernel@vger.kernel.org,
	yi.zhang@huawei.com, yangerkun@huawei.com
Subject: Re: [PATCH v2 2/9] ext4: refactor out ext4_generic_attr_store()
Message-ID: <20240314101803.vmqiq6p2cgnriyzy@quack3>
References: <20240227091148.178435-1-libaokun1@huawei.com>
 <20240227091148.178435-3-libaokun1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240227091148.178435-3-libaokun1@huawei.com>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
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
	 RCPT_COUNT_SEVEN(0.00)[11];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[huawei.com:email,suse.cz:email,suse.com:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 FREEMAIL_CC(0.00)[vger.kernel.org,mit.edu,dilger.ca,suse.cz,gmail.com,linux.ibm.com,huawei.com];
	 RCVD_TLS_ALL(0.00)[];
	 SUSPICIOUS_RECIPS(1.50)[]
X-Spam-Score: -1.10
X-Spam-Flag: NO

On Tue 27-02-24 17:11:41, Baokun Li wrote:
> Refactor out the function ext4_generic_attr_store() to handle the setting
> of values of various common types, with no functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good! Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/ext4/sysfs.c | 40 +++++++++++++++++++++++++---------------
>  1 file changed, 25 insertions(+), 15 deletions(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index ca820620b974..2b1c529b7fdf 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -443,24 +443,20 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
>  	return 0;
>  }
>  
> -static ssize_t ext4_attr_store(struct kobject *kobj,
> -			       struct attribute *attr,
> -			       const char *buf, size_t len)
> +static ssize_t ext4_generic_attr_store(struct ext4_attr *a,
> +				       struct ext4_sb_info *sbi,
> +				       const char *buf, size_t len)
>  {
> -	struct ext4_sb_info *sbi = container_of(kobj, struct ext4_sb_info,
> -						s_kobj);
> -	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
> -	void *ptr = calc_ptr(a, sbi);
> +	int ret;
>  	unsigned int t;
>  	unsigned long lt;
> -	int ret;
> +	void *ptr = calc_ptr(a, sbi);
> +
> +	if (!ptr)
> +		return 0;
>  
>  	switch (a->attr_id) {
> -	case attr_reserved_clusters:
> -		return reserved_clusters_store(sbi, buf, len);
>  	case attr_pointer_ui:
> -		if (!ptr)
> -			return 0;
>  		ret = kstrtouint(skip_spaces(buf), 0, &t);
>  		if (ret)
>  			return ret;
> @@ -470,19 +466,33 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>  			*((unsigned int *) ptr) = t;
>  		return len;
>  	case attr_pointer_ul:
> -		if (!ptr)
> -			return 0;
>  		ret = kstrtoul(skip_spaces(buf), 0, &lt);
>  		if (ret)
>  			return ret;
>  		*((unsigned long *) ptr) = lt;
>  		return len;
> +	}
> +	return 0;
> +}
> +
> +static ssize_t ext4_attr_store(struct kobject *kobj,
> +			       struct attribute *attr,
> +			       const char *buf, size_t len)
> +{
> +	struct ext4_sb_info *sbi = container_of(kobj, struct ext4_sb_info,
> +						s_kobj);
> +	struct ext4_attr *a = container_of(attr, struct ext4_attr, attr);
> +
> +	switch (a->attr_id) {
> +	case attr_reserved_clusters:
> +		return reserved_clusters_store(sbi, buf, len);
>  	case attr_inode_readahead:
>  		return inode_readahead_blks_store(sbi, buf, len);
>  	case attr_trigger_test_error:
>  		return trigger_test_error(sbi, buf, len);
> +	default:
> +		return ext4_generic_attr_store(a, sbi, buf, len);
>  	}
> -	return 0;
>  }
>  
>  static void ext4_sb_release(struct kobject *kobj)
> -- 
> 2.31.1
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR

