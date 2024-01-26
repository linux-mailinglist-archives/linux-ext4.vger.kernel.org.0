Return-Path: <linux-ext4+bounces-931-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC2D83D92B
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 12:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8097B37836
	for <lists+linux-ext4@lfdr.de>; Fri, 26 Jan 2024 10:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CCB81A29C;
	Fri, 26 Jan 2024 09:29:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB50220306;
	Fri, 26 Jan 2024 09:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706261346; cv=none; b=MF/ZtRRL2wnyXXOkKAAmATqWLLgZXxprb3yhsyoOsppprGRDCjD306bIQZBx6HOHh29aDrxaCXUg1cQL3MOHd+Cf5PHttMhQuZd8AV7I0+ss4+xmOl8dCVYy92fO6mjKFxeYjrodF1HWJjvllatBznd/GnP9Hr6Zv/73+DNjB6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706261346; c=relaxed/simple;
	bh=Hnzj1dbxPNTRvPfTPH6nZ90w/0sCk1rEYGZl/TqkXj4=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=G9uGo3z5f6BfPa4p1yShthABdF+JbXkTRc9uX3yazutRPobp7RiUhx8FkZlnDPDnxH4ZQRPpxfo9Od+Hhc+9QSbk1uW2OX9H/+5KuEUXVlm/NstmWydBVC5YmAJyanK0knD4L67UXBM/3gZT4lCFQ3hMLJxEiRyBl4eW3xiYCYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4TLsn16fWfzNlfX;
	Fri, 26 Jan 2024 17:28:05 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id D48F218006D;
	Fri, 26 Jan 2024 17:29:00 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 26 Jan 2024 17:29:00 +0800
Subject: Re: [PATCH 1/7] ext4: avoid overflow when setting values via sysfs
To: Baokun Li <libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-2-libaokun1@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <b1c09c5b-ec26-e59f-8e13-15b77227ca9a@huawei.com>
Date: Fri, 26 Jan 2024 17:28:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240126085716.1363019-2-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/1/26 16:57, Baokun Li wrote:
> When setting values of type unsigned int through sysfs, we use kstrtoul()
> to parse it and then truncate part of it as the final set value, when the
> set value is greater than UINT_MAX, the set value will not match what we
> see because of the truncation. As follows:
> 
>   $ echo 4294967296 > /sys/fs/ext4/sda/mb_max_linear_groups
>   $ cat /sys/fs/ext4/sda/mb_max_linear_groups
>     0
> 
> So when the value set is outside the variable type range, -EINVAL is
> returned to avoid the inconsistency described above. In addition, a
> judgment is added to avoid setting s_resv_clusters less than 0.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Thanks for the patch. Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/sysfs.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/sysfs.c b/fs/ext4/sysfs.c
> index 6d332dff79dd..3671a8aaf4af 100644
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
> @@ -463,6 +463,8 @@ static ssize_t ext4_attr_store(struct kobject *kobj,
>  		ret = kstrtoul(skip_spaces(buf), 0, &t);
>  		if (ret)
>  			return ret;
> +		if (t != (unsigned int)t)
> +			return -EINVAL;
>  		if (a->attr_ptr == ptr_ext4_super_block_offset)
>  			*((__le32 *) ptr) = cpu_to_le32(t);
>  		else
> 

