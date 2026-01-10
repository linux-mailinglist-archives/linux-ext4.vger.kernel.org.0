Return-Path: <linux-ext4+bounces-12706-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id A8254D0CAB7
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jan 2026 01:59:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 31675300CF03
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jan 2026 00:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD962046BA;
	Sat, 10 Jan 2026 00:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Qf9j4NFT"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F0E2AD20
	for <linux-ext4@vger.kernel.org>; Sat, 10 Jan 2026 00:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006754; cv=none; b=ibaIKaiUrb88peh1AZuIRoMnWguD1yUcYZYrvZ9BFplePo61vx2Ak+8yZ/Jg0paR9jKo2A3chUHFKajFWE+sAUxHP7VNkGxdlxkGyD5GG/5nWLfrcNZFH5n5LVjLc2KAKFsvdj7JwQdnmRDGys6Fwx93emCQajEV2oogDTWGb6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006754; c=relaxed/simple;
	bh=g5DrPawdXl0Pp0SSoJmhUvJ0ZhIz1651mSd8n10aXS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=rty8MiDNsIY2AXCWI1HNI1THerFGgyEoAxTqYdZBzDvwJ2P+zou3wFEtcSgCwTq6XP4Ho/Yp6iXXT2tmK0woXrI5R8meuw0aajXNMEIewDLbyAakfYj5nMY7/6N84HzWP0IEnvEi3+IMsaOS/cFU9Xi88iDCNjo2hU3Hbj3QkX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Qf9j4NFT; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KeBNxVSWcxYd5hNT0Cn77SZ5BXaxFG1sTfJ5/waK/qI=;
	b=Qf9j4NFTynPbmoTJbjytE+q1+5Ymro00Ad9WjGXwt6u8TTWWUwftvn4xDOmlj76bMJgJ3QirI
	UpLAn7o9CNJtKPkxOTLwALIpDSYZMYYMHvy8haTI0quSpAqQNpOcPmllPxVFSN7sOHHEtZ2Ac1W
	pgcH8jUMnpLgxficJLvzvdA=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dp0Yj0gcvzpSw0;
	Sat, 10 Jan 2026 08:55:37 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id F3C3F40569;
	Sat, 10 Jan 2026 08:59:02 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 10 Jan
 2026 08:59:02 +0800
Message-ID: <79ccd2c3-e8f8-4d4e-a61e-01d7b32fa8b6@huawei.com>
Date: Sat, 10 Jan 2026 08:59:01 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ext4: always allocate blocks only from groups inode
 can use
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
CC: Ted Tso <tytso@mit.edu>, <linux-ext4@vger.kernel.org>
References: <20260109105007.27673-1-jack@suse.cz>
 <20260109105354.16008-3-jack@suse.cz>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20260109105354.16008-3-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2026-01-09 18:53, Jan Kara wrote:
> For filesystems with more than 2^32 blocks inodes using indirect block
> based format cannot use blocks beyond the 32-bit limit.
> ext4_mb_scan_groups_linear() takes care to not select these unsupported
> groups for such inodes however other functions selecting groups for
> allocation don't. So far this is harmless because the other selection
> functions are used only with mb_optimize_scan and this is currently
> disabled for inodes with indirect blocks however in the following patch
> we want to enable mb_optimize_scan regardless of inode format.
>
> Signed-off-by: Jan Kara <jack@suse.cz>

Looks good, thanks for the patch!

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/mballoc.c | 26 +++++++++++++++++---------
>  1 file changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..f0e07bf11a93 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -892,6 +892,18 @@ mb_update_avg_fragment_size(struct super_block *sb, struct ext4_group_info *grp)
>  	}
>  }
>  
> +static ext4_group_t ext4_get_allocation_groups_count(
> +				struct ext4_allocation_context *ac)
> +{
> +	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
> +
> +	/* non-extent files are limited to low blocks/groups */
> +	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
> +		ngroups = EXT4_SB(ac->ac_sb)->s_blockfile_groups;
> +
> +	return ngroups;
> +}
> +
>  static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
>  					struct xarray *xa,
>  					ext4_group_t start, ext4_group_t end)
> @@ -899,7 +911,7 @@ static int ext4_mb_scan_groups_xa_range(struct ext4_allocation_context *ac,
>  	struct super_block *sb = ac->ac_sb;
>  	struct ext4_sb_info *sbi = EXT4_SB(sb);
>  	enum criteria cr = ac->ac_criteria;
> -	ext4_group_t ngroups = ext4_get_groups_count(sb);
> +	ext4_group_t ngroups = ext4_get_allocation_groups_count(ac);
>  	unsigned long group = start;
>  	struct ext4_group_info *grp;
>  
> @@ -951,7 +963,7 @@ static int ext4_mb_scan_groups_p2_aligned(struct ext4_allocation_context *ac,
>  	ext4_group_t start, end;
>  
>  	start = group;
> -	end = ext4_get_groups_count(ac->ac_sb);
> +	end = ext4_get_allocation_groups_count(ac);
>  wrap_around:
>  	for (i = ac->ac_2order; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
>  		ret = ext4_mb_scan_groups_largest_free_order_range(ac, i,
> @@ -1001,7 +1013,7 @@ static int ext4_mb_scan_groups_goal_fast(struct ext4_allocation_context *ac,
>  	ext4_group_t start, end;
>  
>  	start = group;
> -	end = ext4_get_groups_count(ac->ac_sb);
> +	end = ext4_get_allocation_groups_count(ac);
>  wrap_around:
>  	i = mb_avg_fragment_size_order(ac->ac_sb, ac->ac_g_ex.fe_len);
>  	for (; i < MB_NUM_ORDERS(ac->ac_sb); i++) {
> @@ -1083,7 +1095,7 @@ static int ext4_mb_scan_groups_best_avail(struct ext4_allocation_context *ac,
>  		min_order = fls(ac->ac_o_ex.fe_len);
>  
>  	start = group;
> -	end = ext4_get_groups_count(ac->ac_sb);
> +	end = ext4_get_allocation_groups_count(ac);
>  wrap_around:
>  	for (i = order; i >= min_order; i--) {
>  		int frag_order;
> @@ -1182,11 +1194,7 @@ static int ext4_mb_scan_groups(struct ext4_allocation_context *ac)
>  	int ret = 0;
>  	ext4_group_t start;
>  	struct ext4_sb_info *sbi = EXT4_SB(ac->ac_sb);
> -	ext4_group_t ngroups = ext4_get_groups_count(ac->ac_sb);
> -
> -	/* non-extent files are limited to low blocks/groups */
> -	if (!(ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS)))
> -		ngroups = sbi->s_blockfile_groups;
> +	ext4_group_t ngroups = ext4_get_allocation_groups_count(ac);
>  
>  	/* searching for the right group start from the goal value specified */
>  	start = ac->ac_g_ex.fe_group;



