Return-Path: <linux-ext4+bounces-1285-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1283985B0A2
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Feb 2024 02:55:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD27B1F221F5
	for <lists+linux-ext4@lfdr.de>; Tue, 20 Feb 2024 01:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAB73374EB;
	Tue, 20 Feb 2024 01:55:17 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC4612E5B
	for <linux-ext4@vger.kernel.org>; Tue, 20 Feb 2024 01:55:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394117; cv=none; b=fWPSOLvJ1fVx04SfVKIDd0COxaxwnrVZ8hw3DZAwi9NniCJhY9rwepUGYGxOLHKXlCNdZxvYUnYUg0aGRz69nIzIUU9PTx4uqqTINpq36nmd0GWGTajZ/GlaQsbSaKJIylHlFA484d/a081wGBLIsi5BrArp1VRnLiYcghph/QA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394117; c=relaxed/simple;
	bh=RCm5R+47q6RJzdnlRGItUunB0aZelJdUXLfSaQ+x3Po=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=l8cKcdByLvxdzOG7n6NsSANOS9JgS31dXudg5yDQjk3mnV5I/DAUkQae7o8b9SksouvRrV5MAc997jXiLiWOgGFsKO9hGpd+tO6UmUoNf7Z7Hi0N7IJ2GIqBPCugCkrVqKrg05Bml8/iavJ7zvPunZiDBSKAI42+B//dB0P43kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Tf2WM1h9Pz1xnMy;
	Tue, 20 Feb 2024 09:53:51 +0800 (CST)
Received: from canpemm500005.china.huawei.com (unknown [7.192.104.229])
	by mail.maildlp.com (Postfix) with ESMTPS id 5F1FF140120;
	Tue, 20 Feb 2024 09:55:12 +0800 (CST)
Received: from [10.174.176.34] (10.174.176.34) by
 canpemm500005.china.huawei.com (7.192.104.229) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 20 Feb 2024 09:55:12 +0800
Subject: Re: [PATCH v2] ext4: Verify s_clusters_per_group even without
 bigalloc
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, Ted Tso <tytso@mit.edu>
References: <20240219171033.22882-1-jack@suse.cz>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <a426f70f-1553-4850-3b0e-0584f8cbdb71@huawei.com>
Date: Tue, 20 Feb 2024 09:55:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240219171033.22882-1-jack@suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500005.china.huawei.com (7.192.104.229)

On 2024/2/20 1:10, Jan Kara wrote:
> Currently we ignore s_clusters_per_group field in the on-disk superblock
> if bigalloc feature is not enabled. However e2fsprogs don't even open
> the filesystem if s_clusters_per_group is invalid. This results in an
> odd state where kernel happily works with the filesystem while even
> e2fsck refuses to touch it. Verify that s_clusters_per_group is valid
> even if bigalloc feature is not enabled to make things consistent. Due
> to current e2fsprogs behavior it is unlikely there are filesystems out
> in the wild (except for intentionally fuzzed ones) with invalid
> s_clusters_per_group counts.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/super.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
> 
> Changes since v1:
> * share code checking s_clusters_per_group for !bigalloc & bigalloc configs
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index 0f931d0c227d..0a34e0b23541 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -4422,22 +4422,6 @@ static int ext4_handle_clustersize(struct super_block *sb)
>  		}
>  		sbi->s_cluster_bits = le32_to_cpu(es->s_log_cluster_size) -
>  			le32_to_cpu(es->s_log_block_size);
> -		sbi->s_clusters_per_group =
> -			le32_to_cpu(es->s_clusters_per_group);
> -		if (sbi->s_clusters_per_group > sb->s_blocksize * 8) {
> -			ext4_msg(sb, KERN_ERR,
> -				 "#clusters per group too big: %lu",
> -				 sbi->s_clusters_per_group);
> -			return -EINVAL;
> -		}
> -		if (sbi->s_blocks_per_group !=
> -		    (sbi->s_clusters_per_group * (clustersize / sb->s_blocksize))) {
> -			ext4_msg(sb, KERN_ERR, "blocks per group (%lu) and "
> -				 "clusters per group (%lu) inconsistent",
> -				 sbi->s_blocks_per_group,
> -				 sbi->s_clusters_per_group);
> -			return -EINVAL;
> -		}
>  	} else {
>  		if (clustersize != sb->s_blocksize) {
>  			ext4_msg(sb, KERN_ERR,
> @@ -4451,9 +4435,21 @@ static int ext4_handle_clustersize(struct super_block *sb)
>  				 sbi->s_blocks_per_group);
>  			return -EINVAL;
>  		}
> -		sbi->s_clusters_per_group = sbi->s_blocks_per_group;
>  		sbi->s_cluster_bits = 0;
>  	}
> +	sbi->s_clusters_per_group = le32_to_cpu(es->s_clusters_per_group);
> +	if (sbi->s_clusters_per_group > sb->s_blocksize * 8) {
> +		ext4_msg(sb, KERN_ERR, "#clusters per group too big: %lu",
> +			 sbi->s_clusters_per_group);
> +		return -EINVAL;
> +	}
> +	if (sbi->s_blocks_per_group !=
> +	    (sbi->s_clusters_per_group * (clustersize / sb->s_blocksize))) {
> +		ext4_msg(sb, KERN_ERR,
> +			 "blocks per group (%lu) and clusters per group (%lu) inconsistent",
> +			 sbi->s_blocks_per_group, sbi->s_clusters_per_group);
> +		return -EINVAL;
> +	}
>  	sbi->s_cluster_ratio = clustersize / sb->s_blocksize;
>  
>  	/* Do we have standard group size of clustersize * 8 blocks ? */
> 

