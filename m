Return-Path: <linux-ext4+bounces-4761-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 305339AFA9C
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 09:06:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 52FA41C22102
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Oct 2024 07:06:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C301B395C;
	Fri, 25 Oct 2024 07:06:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A117C67A0D
	for <linux-ext4@vger.kernel.org>; Fri, 25 Oct 2024 07:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729839994; cv=none; b=QCLu8sB9hIaf4irYpMZIn2Q/f+iwIUo37Cr+cH3EkO349LPnFYonwMsYdLOiQdR76GwROB2RH1mfOGYJHoBGSQgdgPq56Iw4ZlZziidei8YfqCPFW7kNgFt2bBYB41FtuAtWkoGAa2kW+W/72Vx53FXfFrqiK9DAf7oFBqNdQUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729839994; c=relaxed/simple;
	bh=qcm7Xi+rhEO/enyB/8dvde4tl0JE33EbartEYkdV+pw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Iu9WSpfvztCoaOiGMxNkKXFuwHef9JSE0wOLR9mlZeqGmi6N1MBCM6mY1vsCCAuCgRQneedgxKX5Qj7uPoHTSe/cAszNSJ42q929VSwJIPFJVa6D5z2+A3f+gHHZgPRLyY4FMwXFA4ABmndNZq8p0WDha6vWXNyBb3i83rh0xE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4XZYfK5whpzdkNt;
	Fri, 25 Oct 2024 15:03:37 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 0622B1800A5;
	Fri, 25 Oct 2024 15:06:09 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 25 Oct 2024 15:06:08 +0800
Message-ID: <cf776ce1-596f-4b04-a79b-2fe7b5b83f6e@huawei.com>
Date: Fri, 25 Oct 2024 15:06:07 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix FS_IOC_GETFSMAP handling
To: Theodore Ts'o <tytso@mit.edu>
CC: "Darrick J. Wong" <djwong@kernel.org>, Ext4 Developers List
	<linux-ext4@vger.kernel.org>
References: <20241023135949.3745142-1-tytso@mit.edu>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20241023135949.3745142-1-tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/10/23 21:59, Theodore Ts'o wrote:
> The original implementation ext4's FS_IOC_GETFSMAP handling only
> worked when the range of queried blocks included at least one free
> (unallocated) block range.  This is because how the metadata blocks
> were emitted was as a side effect of ext4_mballoc_query_range()
> calling ext4_getfsmap_datadev_helper(), and that function was only
> called when a free block range was identified.  As a result, this
> caused generic/365 to fail.
> 
> Fix this by creating a new function ext4_getfsmap_meta_helper() which
> gets called so that blocks before the first free block range in a
> block group can get properly reported.
> 
> Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> ---
>  fs/ext4/fsmap.c   | 54 ++++++++++++++++++++++++++++++++++++++++++++++-
>  fs/ext4/mballoc.c | 18 ++++++++++++----
>  fs/ext4/mballoc.h |  1 +
>  3 files changed, 68 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ext4/fsmap.c b/fs/ext4/fsmap.c
> index df853c4d3a8c..383c6edea6dd 100644
> --- a/fs/ext4/fsmap.c
> +++ b/fs/ext4/fsmap.c
> @@ -185,6 +185,56 @@ static inline ext4_fsblk_t ext4_fsmap_next_pblk(struct ext4_fsmap *fmr)
>  	return fmr->fmr_physical + fmr->fmr_length;
>  }
>  
> +static int ext4_getfsmap_meta_helper(struct super_block *sb,
> +				     ext4_group_t agno, ext4_grpblk_t start,
> +				     ext4_grpblk_t len, void *priv)
> +{
> +	struct ext4_getfsmap_info *info = priv;
> +	struct ext4_fsmap *p;
> +	struct ext4_fsmap *tmp;
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	ext4_fsblk_t fsb, fs_start, fs_end;
> +	int error;
> +
> +	fs_start = fsb = (EXT4_C2B(sbi, start) +
> +			  ext4_group_first_block_no(sb, agno));
> +	fs_end = fs_start + EXT4_C2B(sbi, len);
> +
> +	/* Return relevant extents from the meta_list */
> +	list_for_each_entry_safe(p, tmp, &info->gfi_meta_list, fmr_list) {
> +		if (p->fmr_physical < info->gfi_next_fsblk) {
> +			list_del(&p->fmr_list);
> +			kfree(p);
> +			continue;
> +		}
> +		if (p->fmr_physical <= fs_start ||
> +		    p->fmr_physical + p->fmr_length <= fs_end) {
> +			/* Emit the retained free extent record if present */
> +			if (info->gfi_lastfree.fmr_owner) {
> +				error = ext4_getfsmap_helper(sb, info,
> +							&info->gfi_lastfree);
> +				if (error)
> +					return error;
> +				info->gfi_lastfree.fmr_owner = 0;
> +			}
> +			error = ext4_getfsmap_helper(sb, info, p);
> +			if (error)
> +				return error;
> +			fsb = p->fmr_physical + p->fmr_length;
> +			if (info->gfi_next_fsblk < fsb)
> +				info->gfi_next_fsblk = fsb;
> +			list_del(&p->fmr_list);
> +			kfree(p);
> +			continue;
> +		}
> +	}
> +	if (info->gfi_next_fsblk < fsb)
> +		info->gfi_next_fsblk = fsb;
> +
> +	return 0;
> +}
> +
> +
>  /* Transform a blockgroup's free record into a fsmap */
>  static int ext4_getfsmap_datadev_helper(struct super_block *sb,
>  					ext4_group_t agno, ext4_grpblk_t start,
> @@ -539,6 +589,7 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
>  		error = ext4_mballoc_query_range(sb, info->gfi_agno,
>  				EXT4_B2C(sbi, info->gfi_low.fmr_physical),
>  				EXT4_B2C(sbi, info->gfi_high.fmr_physical),
> +				ext4_getfsmap_meta_helper,
>  				ext4_getfsmap_datadev_helper, info);
>  		if (error)
>  			goto err;
> @@ -560,7 +611,8 @@ static int ext4_getfsmap_datadev(struct super_block *sb,
>  
>  	/* Report any gaps at the end of the bg */
>  	info->gfi_last = true;
> -	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster, 0, info);
> +	error = ext4_getfsmap_datadev_helper(sb, end_ag, last_cluster + 1,
> +					     0, info);
>  	if (error)
>  		goto err;
>  
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index d73e38323879..92f49d7eb3c0 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -6999,13 +6999,14 @@ int
>  ext4_mballoc_query_range(
>  	struct super_block		*sb,
>  	ext4_group_t			group,
> -	ext4_grpblk_t			start,
> +	ext4_grpblk_t			first,
>  	ext4_grpblk_t			end,
> +	ext4_mballoc_query_range_fn	meta_formatter,
>  	ext4_mballoc_query_range_fn	formatter,
>  	void				*priv)
>  {
>  	void				*bitmap;
> -	ext4_grpblk_t			next;
> +	ext4_grpblk_t			start, next;
>  	struct ext4_buddy		e4b;
>  	int				error;
>  
> @@ -7016,10 +7017,19 @@ ext4_mballoc_query_range(
>  
>  	ext4_lock_group(sb, group);
>  
> -	start = max(e4b.bd_info->bb_first_free, start);
> +	start = max(e4b.bd_info->bb_first_free, first);
>  	if (end >= EXT4_CLUSTERS_PER_GROUP(sb))
>  		end = EXT4_CLUSTERS_PER_GROUP(sb) - 1;
> -
> +	if (meta_formatter && start != first) {
> +		if (start > end)
> +			start = end;
> +		ext4_unlock_group(sb, group);
> +		error = meta_formatter(sb, group, first, start - first,
> +				       priv);
> +		if (error)
> +			goto out_unload;
> +		ext4_lock_group(sb, group);
> +	}

Hi, Ted!

Now it seems to be able to handle all the necessary metadata in the
query range here, can we remove the processing of info->gfi_meta_list
in ext4_getfsmap_datadev_helper() as well?

Thanks,
Yi.

>  	while (start <= end) {
>  		start = mb_find_next_zero_bit(bitmap, end + 1, start);
>  		if (start > end)
> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
> index d8553f1498d3..f8280de3e882 100644
> --- a/fs/ext4/mballoc.h
> +++ b/fs/ext4/mballoc.h
> @@ -259,6 +259,7 @@ ext4_mballoc_query_range(
>  	ext4_group_t			agno,
>  	ext4_grpblk_t			start,
>  	ext4_grpblk_t			end,
> +	ext4_mballoc_query_range_fn	meta_formatter,
>  	ext4_mballoc_query_range_fn	formatter,
>  	void				*priv);
>  


