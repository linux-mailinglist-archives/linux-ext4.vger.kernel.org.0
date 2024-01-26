Return-Path: <linux-ext4+bounces-933-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 151CE83D81C
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 11:29:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABF64296376
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 10:29:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B5F014298;
	Fri, 26 Jan 2024 10:08:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA6814276;
	Fri, 26 Jan 2024 10:08:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706263699; cv=none; b=ogvpC+b/DXHfSbUHlDsp/e2i4yuRISM5SHpVRBC6rHduXfvDNv0UZBWjh9fvwksEZrzOv/9Tjk80XaWhdDKfYWQ/wtbAjRnhL1k4+lNQfsjRtCRNPvw/PmXAgmcPpxTCP6GNSbyICa5/m5s/1M3nADWE90U5fM27NwZnToteyI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706263699; c=relaxed/simple;
	bh=X4835XH9cy69dNBnX/jYfdyJwUuvrtSl0fq/UaRdAQA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Mtzkzi+9tm8wQCcnZpGidzXGwdvxEvr+Jxc2FA0GR/C6T9ltDELGdybpuQ5ZPOPKZodpXPbxznRVWLDGY0DvV6ZoZ0d7umh7VoGgVs0p+P4EWERy8emCR0H4C8C/glDDSzBcLjzdP97AbdX+tQGhir+mZuqZR1L3YlcKWMasNOU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4TLtdt1HCkzXgt9;
	Fri, 26 Jan 2024 18:06:58 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 71384180078;
	Fri, 26 Jan 2024 18:08:13 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 18:08:12 +0800
Subject: Re: [PATCH 3/7] ext4: refactor out ext4_generic_attr_show()
To: Baokun Li <libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-4-libaokun1@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <dcfcfdce-9ad1-5eea-4037-cd624591284e@huawei.com>
Date: Fri, 26 Jan 2024 18:08:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240126085716.1363019-4-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/1/26 16:57, Baokun Li wrote:
> Refactor out the function ext4_generic_attr_show() to handle the reading
> of values of various common types, with no functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

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
> 

