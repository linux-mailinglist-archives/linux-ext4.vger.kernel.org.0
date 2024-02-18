Return-Path: <linux-ext4+bounces-1263-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DBA5859424
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Feb 2024 03:36:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CD1A1F21CEC
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Feb 2024 02:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056A915C8;
	Sun, 18 Feb 2024 02:36:34 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B84CC81F
	for <linux-ext4@vger.kernel.org>; Sun, 18 Feb 2024 02:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708223793; cv=none; b=nY0WbgpVJiloN+GrRCXh5F6bEOPiTm1CNaid+jzSEDID/2B6LGFAJvZ+pwYRZ2K81BR8+e551MnZaktfRgnPQePlnE5rsihZkMFdmDDxmC9fhv7IB7RFunqZhMIaM0LyoUEfFQm3+NqvUyaxUraE9xoikFRF+GhUmEgsENCNe0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708223793; c=relaxed/simple;
	bh=/zGdM83v//sphRScl5OLUS5tiZ5NdqDhM8Grzm4+cMo=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nq1MI6S5PQeEw+/keVjxp8SQz9wD8AvDtQMiQ7Dmv3SFrg/BN9UsX2IVxNAMSShr8O5SZ5NRoc+IGEaydCy788UyYk1yyUJTo9hFbBCFAS/OfKXIIJOkI2Yw7pR7k/ZEfjvzNG15f8rmrivPIR/oYchV5EzpLxcCULd/7ZVAuP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Tcq5z04fgzbcKq;
	Sun, 18 Feb 2024 10:16:07 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 76A8214011B;
	Sun, 18 Feb 2024 10:16:41 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 18 Feb 2024 10:16:41 +0800
Subject: Re: [PATCH] ext4: Verify s_clusters_per_group even without bigalloc
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, Ted Tso <tytso@mit.edu>
References: <20240213101515.17328-1-jack@suse.cz>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <d448648e-29dd-6f43-d141-f424c594fae2@huawei.com>
Date: Sun, 18 Feb 2024 10:16:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240213101515.17328-1-jack@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500005.china.huawei.com (7.192.104.229)

Hello!

On 2024/2/13 18:15, Jan Kara wrote:
> Currently we ignore s_clusters_per_group field in the on-disk superblock
> if bigalloc feature is not enabled. However e2fsprogs don't even open
> the filesystem is s_clusters_per_group is invalid. This results in an
                 ^^
                 if
> odd state where kernel happily works with the filesystem while even
> e2fsck refuses to touch it. Verify that s_clusters_per_group is valid
> even if bigalloc feature is not enabled to make things consistent. Due
> to current e2fsprogs behavior it is unlikely there are filesystems out
> in the wild (except for intentionally fuzzed ones) with invalid
> s_clusters_per_group counts.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---
>  fs/ext4/super.c | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0f931d0c227d..522683075067 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4451,7 +4451,15 @@ static int ext4_handle_clustersize(struct super_block *sb)
>  				 sbi->s_blocks_per_group);
>  			return -EINVAL;
>  		}
> -		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
> +		sbi->s_clusters_per_group =
> +			le32_to_cpu(es->s_clusters_per_group);
> +		if (sbi->s_blocks_per_group != sbi->s_clusters_per_group) {
> +			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
> +				 "clusters per group (%lu) inconsistent",
> +				 sbi->s_blocks_per_group,
> +				 sbi->s_clusters_per_group);
> +			return -EINVAL;
> +		}

This is almost the same with the code snippet in bigalloc branch, would
it be better to factor them out and reuse this hunk in both branch, just
like the check e2fsprogs does?

Thanks,
Yi.

>  		sbi->s_cluster_bits = 0;
>  	}
>  	sbi->s_cluster_ratio = clustersize / sb->s_blocksize;
> 

