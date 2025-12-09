Return-Path: <linux-ext4+bounces-12235-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C40CAF465
	for <lists+linux-ext4@lfdr.de>; Tue, 09 Dec 2025 09:23:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id ADF40304D9E7
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Dec 2025 08:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425D026F280;
	Tue,  9 Dec 2025 08:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cO/tLvk0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9024123F26A
	for <linux-ext4@vger.kernel.org>; Tue,  9 Dec 2025 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765268581; cv=none; b=a9OtwUMZzbMEHJEcPvdT43fsGsreiCIy/Ef34M2PWrkztJBqZdOkrMS61ybjfd31CQuGa6kuJ6QocwEAHXgP1LV7EZoVcDKswl5PavfhIAYYd24pxy0WonZgbzUo3vqEXVqVwuqEk7TQh5Y3t6IjTJOWYizoATwi5OMUR3dhPw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765268581; c=relaxed/simple;
	bh=JPDuokiFhdzbBUZ3iYJZHSFjQramtyAYPl7PsiEnb7w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=WDnTWUVYG6GA/leq8zOghhxZZyjqM7klo2hKHZFrdywCy/mBRjZ87mNpR7xY4RKslIKSg9vx6fN83ypFSr14g63NUO1So9irAjQE315dq38KkhT3aoXWvG4YUfaXfnhpsd7fVXC/XHAILAKvYCIvEZ37OUGwO4aJmPn91qX3zTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cO/tLvk0; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=gN6/cgeb/TDYIeEwCPMLNJc3fV3NKkGMKYLhOqZLPGA=;
	b=cO/tLvk0EEpUDyLGGtXOQ9d0FUlJ2VHb9dKsezs+NegpwzDBTYvo3a2hEJMGaGur7z0LQG1sA
	oGdpDrFmdbRlbDFpobDJFYFAuA5QX2WTKthut4CVsEJYK9UT4oki+ee85wH/g++R0UUqfABaG+b
	rkpk0CYo3nLWNied5MpNLu0=
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dQWyG58Yfz1T4GD;
	Tue,  9 Dec 2025 16:20:54 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 93051140158;
	Tue,  9 Dec 2025 16:22:55 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 9 Dec
 2025 16:22:54 +0800
Message-ID: <4f7979f0-aeca-41c9-a496-6eefd578d816@huawei.com>
Date: Tue, 9 Dec 2025 16:22:53 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: add missing down_write_data_sem in
 mext_move_extent().
Content-Language: en-GB
To: Julian Sun <sunjunchao@bytedance.com>, <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <yi.zhang@huawei.com>, <jack@suse.cz>, Baokun Li
	<libaokun1@huawei.com>
References: <20251208123713.1971068-1-sunjunchao@bytedance.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251208123713.1971068-1-sunjunchao@bytedance.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-08 20:37, Julian Sun wrote:
> Commit 962e8a01eab9 ("ext4: introduce mext_move_extent()") attempts to
> call ext4_swap_extents() on the failure path to recover the swapped
> extents, but fails to acquire locks for the two inode->i_data_sem,
> triggering the BUG_ON statement in ext4_swap_extents().
>
> This issue can be fixed by calling ext4_double_down_write_data_sem()
> before ext4_swap_extents().
>
> Signed-off-by: Julian Sun <sunjunchao@bytedance.com>
> Reported-by: syzbot+4ea6bd8737669b423aae@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/69368649.a70a0220.38f243.0093.GAE@google.com/
> Fixes: 962e8a01eab9 ("ext4: introduce mext_move_extent()")

Usually, tags like Reported-by, Closes, and Fixes are placed before
Signed-off-by. Otherwise looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/move_extent.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/fs/ext4/move_extent.c b/fs/ext4/move_extent.c
> index 0550fd30fd10..635fb8a52e0c 100644
> --- a/fs/ext4/move_extent.c
> +++ b/fs/ext4/move_extent.c
> @@ -393,9 +393,11 @@ static int mext_move_extent(struct mext_data *mext, u64 *m_len)
>  
>  repair_branches:
>  	ret2 = 0;
> +	ext4_double_down_write_data_sem(orig_inode, donor_inode);
>  	r_len = ext4_swap_extents(handle, donor_inode, orig_inode,
>  				  mext->donor_lblk, orig_map->m_lblk,
>  				  *m_len, 0, &ret2);
> +	ext4_double_up_write_data_sem(orig_inode, donor_inode);
>  	if (ret2 || r_len != *m_len) {
>  		ext4_error_inode_block(orig_inode, (sector_t)(orig_map->m_lblk),
>  				       EIO, "Unable to copy data block, data will be lost!");



