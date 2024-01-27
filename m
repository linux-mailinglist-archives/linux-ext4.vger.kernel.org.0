Return-Path: <linux-ext4+bounces-979-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F17EA83E9AA
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 03:17:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 93370B297C9
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Jan 2024 02:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42BA922F1E;
	Sat, 27 Jan 2024 02:12:13 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4DFA41;
	Sat, 27 Jan 2024 02:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706321533; cv=none; b=Mxc4H1bJHcYwNdpTz9SkFIM8nEPeUXRWRbPLp9fyP6WoPy5SHA3/TmZTv9N+PcxA2JsUmaceIVlETE1PpGZSgJCYYOMhOamjslttnWqP6chwaKF8FDV+OIkBPngrvTTnKwd0GctzKvXylm+qjCjEnK37JzFUNyLnLBbpwXa1Nwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706321533; c=relaxed/simple;
	bh=tf+WNKBYAp/aBHcD33YlEBxj0WzGAIn3QhiVmSSBBXg=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=NQw+bUNjFtznHMoEZO71WLv2nH7Im0ABmAuPajse1L0ea9YnFoU3aF4RQZprcPnR45sBQsE0bDVaKLbqequUKg8FfuboSxU7CKKpR0AtLJt2ItHfTcgppGvp0Ta8J5jjEasewxT7i/f05SE0wHNGF8Tej7PB29FSJhp5gH03zBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TMJ28169dzsWYP;
	Sat, 27 Jan 2024 10:10:56 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 70D3F18007B;
	Sat, 27 Jan 2024 10:12:02 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 27 Jan 2024 10:12:01 +0800
Subject: Re: [PATCH 7/7] ext4: set the type of max_zeroout to unsigned int to
 avoid overflow
To: Baokun Li <libaokun1@huawei.com>, <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
	<ritesh.list@gmail.com>, <linux-kernel@vger.kernel.org>,
	<yangerkun@huawei.com>, <chengzhihao1@huawei.com>, <yukuai3@huawei.com>
References: <20240126085716.1363019-1-libaokun1@huawei.com>
 <20240126085716.1363019-8-libaokun1@huawei.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <5d4a3f94-453f-c3c3-390c-651d499b5c7b@huawei.com>
Date: Sat, 27 Jan 2024 10:12:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240126085716.1363019-8-libaokun1@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/1/26 16:57, Baokun Li wrote:
> The max_zeroout is of type int and the s_extent_max_zeroout_kb is of
> type uint, and the s_extent_max_zeroout_kb can be freely modified via
> the sysfs interface. When the block size is 1024, max_zeroout may
> overflow, so declare it as unsigned int to avoid overflow.
> 
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/extents.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 01299b55a567..8653b13e8248 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -3425,10 +3425,8 @@ static int ext4_ext_convert_to_initialized(handle_t *handle,
>  	struct ext4_extent zero_ex1, zero_ex2;
>  	struct ext4_extent *ex, *abut_ex;
>  	ext4_lblk_t ee_block, eof_block;
> -	unsigned int ee_len, depth, map_len = map->m_len;
> -	int allocated = 0, max_zeroout = 0;
> -	int err = 0;
> -	int split_flag = EXT4_EXT_DATA_VALID2;
> +	unsigned int ee_len, depth, map_len = map->m_len, max_zeroout = 0;
> +	int err = 0, allocated = 0, split_flag = EXT4_EXT_DATA_VALID2;
>  
>  	ext_debug(inode, "logical block %llu, max_blocks %u\n",
>  		  (unsigned long long)map->m_lblk, map_len);
> 

