Return-Path: <linux-ext4+bounces-932-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B30F183D924
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 12:16:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5DBB3861E
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 10:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0896022626;
	Fri, 26 Jan 2024 09:37:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A9622618;
	Fri, 26 Jan 2024 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261834; cv=none; b=UXlDE+585Su9rifhEzgLQCt2/hEu7316b19or1JmT9X23JrpvcRqujQS6SEzdZkSd+KQTzJ+JlN5wUuKXAJNH+OFikCWRR4+eqfhC59BUGNVTTepRu7YZ9s70bgfoGa1QpRWOuJ5dsVHTdrE/4o70HDF6oHMI+5P5ukmQKmjJRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261834; c=relaxed/simple;
	bh=MnwdyDHgKekVvz5ZpnRDJKwN9N7olHD2GGXpvIAr13A=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YrEURBuIKiKkrEJvl7LXey/It/Qt8OhU3S9hUX+ZWlgjZiHSCbCh/H/rVAtzB75Cd0fVdEWlD4VfSrC608ISG6my83fimnKvYUD4yBT4nzu2lUhBIXeHntrm66YG31INl5KE++EOgP4oqRTWOO8ta4wSwJb2vvoRbcxVglXjF6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4TLsyQ4QTvz1xm67;
	Fri, 26 Jan 2024 17:36:14 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 298101A0172;
	Fri, 26 Jan 2024 17:37:09 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 17:37:08 +0800
Subject: Re: [PATCH 2/7] ext4: refactor out ext4_generic_attr_store()
To: Baokun Li <libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-3-libaokun1@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <e29dae35-8aa1-f390-ecb9-c5e6d02ca13c@huawei.com>
Date: Fri, 26 Jan 2024 17:37:08 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240126085716.1363019-3-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/1/26 16:57, Baokun Li wrote:
> Refactor out the function ext4_generic_attr_store() to handle the setting
> of values of various common types, with no functional changes.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/sysfs.c | 49 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 28 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 3671a8aaf4af..834f9a0eb641 100644
> --- a/fs/ext4/sysfs.c
> +++ b/fs/ext4/sysfs.c
> @@ -443,26 +443,22 @@ static ssize_t ext4_attr_show(struct kobject *kobj,
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
> -	unsigned long t;
>  	int ret;
> +	unsigned long t;
> +	void *ptr = calc_ptr(a, sbi);
> +
> +	if (!ptr)
> +		return 0;
> +	ret = kstrtoul(skip_spaces(buf), 0, &t);
> +	if (ret)
> +		return ret;
>  
>  	switch (a->attr_id) {
> -	case attr_reserved_clusters:
> -		return reserved_clusters_store(sbi, buf, len);
>  	case attr_pointer_ui:
> -		if (!ptr)
> -			return 0;
> -		ret = kstrtoul(skip_spaces(buf), 0, &t);
> -		if (ret)
> -			return ret;
>  		if (t != (unsigned int)t)
>  			return -EINVAL;
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
> @@ -471,19 +467,30 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>  			*((unsigned int *) ptr) = t;
>  		return len;
>  	case attr_pointer_ul:
> -		if (!ptr)
> -			return 0;
> -		ret = kstrtoul(skip_spaces(buf), 0, &t);
> -		if (ret)
> -			return ret;
>  		*((unsigned long *) ptr) = t;
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
> 

