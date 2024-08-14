Return-Path: <linux-ext4+bounces-3727-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E2ACC9516FB
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2024 10:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C0E21F21478
	for <lists+linux-ext4@lfdr.de>; Wed, 14 Aug 2024 08:49:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E72B3142904;
	Wed, 14 Aug 2024 08:48:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FC8137772;
	Wed, 14 Aug 2024 08:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625319; cv=none; b=DMSC2Oi63kQVwh+gHu2iAL7AkdlQmbycoReeZlmJK8FSYhF5WG2HQdLsfR77CJzqwui8C9uGXmkgV2FSu7KT+ri1o5RJqKU8L9k3wpRfddR2xVBv9Dhge7HYFhvOd3F0L7Kl4ZhhVQhjtkV4qNKdG8jK66eaXjIX8YS9bKbveTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625319; c=relaxed/simple;
	bh=69Ir8pqfruuAGKn5gHlIEQZArS4OW0abJVb6NIeD8Ek=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=REGPBJhvIBDDkXpw2j2PWhXLUTVKSOSUu5+Zl4quiyCHvSs/JgBaFaeaGX9FIcgKQAgw0Xkv6j0+rXVgBf6jNGE4/1alXtWHAj5HK+Ha9jlE0PCsRtjarCcBSobI3rPHybVEYyKKnMuL9Cu5bNTS9xYTkacBNsH+Dq8IAl7BRAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WkMH13cB1z2Cmft;
	Wed, 14 Aug 2024 16:43:41 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 63D471A016C;
	Wed, 14 Aug 2024 16:48:33 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 14 Aug 2024 16:48:32 +0800
Subject: Re: [PATCH 2/7] ext4: avoid potential buffer_head leak in
 __ext4_new_inode
To: Kemeng Shi <shikemeng@huaweicloud.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<tytso@mit.edu>, <adilger.kernel@dilger.ca>
References: <20240813120712.2592310-1-shikemeng@huaweicloud.com>
 <20240813120712.2592310-3-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huawei.com>
Message-ID: <0351b3b1-e84a-9e41-a492-743f5bbea910@huawei.com>
Date: Wed, 14 Aug 2024 16:48:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240813120712.2592310-3-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2024/8/13 20:07, Kemeng Shi wrote:
> If a group is marked EXT4_GROUP_INFO_IBITMAP_CORRUPT after it's inode
> bitmap buffer_head was successfully verified, then __ext4_new_inode
> will get a valid inode_bitmap_bh of a corrupted group from
> ext4_read_inode_bitmap in which case inode_bitmap_bh misses a release.
> Hnadle "IS_ERR(inode_bitmap_bh)" and group corruption separately like
> how ext4_free_inode does to avoid buffer_head leak.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> ---
>  fs/ext4/ialloc.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
> index ad7f13976dc6..f24a238b6b09 100644
> --- a/fs/ext4/ialloc.c
> +++ b/fs/ext4/ialloc.c
> @@ -1054,9 +1054,13 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
>  		brelse(inode_bitmap_bh);
>  		inode_bitmap_bh = ext4_read_inode_bitmap(sb, group);
>  		/* Skip groups with suspicious inode tables */
> -		if (((!(sbi->s_mount_state & EXT4_FC_REPLAY))
> -		     && EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) ||
> -		    IS_ERR(inode_bitmap_bh)) {
> +		if (IS_ERR(inode_bitmap_bh)) {
> +			inode_bitmap_bh = NULL;
> +			goto next_group;
> +		}
> +		if (!(sbi->s_mount_state & EXT4_FC_REPLAY) &&
> +		    EXT4_MB_GRP_IBITMAP_CORRUPT(grp)) {
> +			brelse(inode_bitmap_bh);
>  			inode_bitmap_bh = NULL;

Wouldn't the inode_bitmap_bh be brelsed in the next loop or the end of this
function? why not just goto next_group?

Thanks,
Yi.

>  			goto next_group;
>  		}
> 

