Return-Path: <linux-ext4+bounces-12688-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AD9AD06C7B
	for <lists+linux-ext4@lfdr.de>; Fri, 09 Jan 2026 03:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 29686300CB49
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jan 2026 02:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47A6B2236F0;
	Fri,  9 Jan 2026 02:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="y3za0GIO";
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="y3za0GIO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F47E220F2C
	for <linux-ext4@vger.kernel.org>; Fri,  9 Jan 2026 02:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767924043; cv=none; b=jXWeWE4ltFmzqAM4eGTtDZYo/w+5DhovGnnu+fcsqqME66KR6MqAjoXzcBErUFTE+kf4de9TIe1LxBVe5TKEXfTFnfGCfkdOuIXMfLRYMYULFi0TD/nSFc6dTws8Dey8rTRNthDUMcJ1Cd4JJzG9xfEw9G8s0yMg1DD2v6e7+pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767924043; c=relaxed/simple;
	bh=mFdfOcoDeYq4anQRIRGzIdfONiJXXWkj88aiE5Himsw=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=GaEB0JZKdb7QHMCeVYKHi2c36UnTSOuwdLJs4R9ZGzYZOIhrnABSVbUIXOMV3oNEhyinpy76UVn56QTjtlMH4TvsQ3In+FS1eCy4tSPwIX4ZpwDLSf6hBMkEqi3gSzhv7NwrRxz6DyLrF+b1WRK10e+uTaFpqd0HB/ZhqzXLgek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=y3za0GIO; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=y3za0GIO; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nC0MXh3O5pT1J0l/P7EQp2WRC0UsMVcmG9aYJlmeeB0=;
	b=y3za0GIOGmEp1pFX3lC8pqpNgfJniKgwMkrPIFRYHV74bUnhSXOL2zhdmZ6Dup8+psTXjHYcz
	6yk3ElzU35uUyP0UiQuC4Q09cP2Is2du5JJUAC9WKISM6/u/bTgSeRz2euZnRAxU/67FsNvdyYB
	j3dO8up4V/Lp7HZvgilZnHY=
Received: from canpmsgout03.his.huawei.com (unknown [172.19.92.159])
	by szxga01-in.huawei.com (SkyGuard) with ESMTPS id 4dnQ213MtMz1BG7J
	for <linux-ext4@vger.kernel.org>; Fri,  9 Jan 2026 09:59:37 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nC0MXh3O5pT1J0l/P7EQp2WRC0UsMVcmG9aYJlmeeB0=;
	b=y3za0GIOGmEp1pFX3lC8pqpNgfJniKgwMkrPIFRYHV74bUnhSXOL2zhdmZ6Dup8+psTXjHYcz
	6yk3ElzU35uUyP0UiQuC4Q09cP2Is2du5JJUAC9WKISM6/u/bTgSeRz2euZnRAxU/67FsNvdyYB
	j3dO8up4V/Lp7HZvgilZnHY=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4dnPzC1kmZzpSt8;
	Fri,  9 Jan 2026 09:57:11 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 706AD2012A;
	Fri,  9 Jan 2026 10:00:35 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 9 Jan
 2026 10:00:34 +0800
Message-ID: <4b18f416-28da-45d3-8887-48f804d9e84a@huawei.com>
Date: Fri, 9 Jan 2026 10:00:33 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Use optimized mballoc scanning regardless of inode
 format
To: Jan Kara <jack@suse.cz>
CC: <linux-ext4@vger.kernel.org>, Ted Tso <tytso@mit.edu>,
	<libaokun9@gmail.com>
References: <20260108160907.24892-2-jack@suse.cz>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20260108160907.24892-2-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2026-01-09 00:09, Jan Kara wrote:
> Currently we don't used mballoc optimized scanning (using max free
> extent order and avg free extent order group lists) for inodes with
> indirect block based format. This is confusing for users and I don't see
> a good reason for that. Even with indirect block based inode format we
> can spend big amount of time searching for free blocks for large
> filesystems with fragmented free space. To add to the confusion before
> commit 077d0c2c78df ("ext4: make mb_optimize_scan performance mount
> option work with extents") optimized scanning was applied *only* to
> indirect block based inodes so that commit appears as a performance
> regression to some users. Just use optimized scanning whenever it is
> enabled by mount options.
>
> Signed-off-by: Jan Kara <jack@suse.cz>

Makes sense. Block allocation should not be tied to the inode format,
and we should remove this restriction.

However, inodes with the indirect block based format only support
32-bit physical block numbers. We already check the maximum supported
block group in ext4_mb_scan_groups_linear, but we don’t perform the
same check in ext4_mb_scan_groups_xa_range.

So if we want to drop this restriction, we need to specify the
appropriate end value for inodes using the indirect block based format
in ext4_mb_scan_groups_xa_range; otherwise, an overflow could occur and
lead to corrupted block allocation.


Regards,
Baokun

> ---
>  fs/ext4/mballoc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index 56d50fd3310b..4ee7ab4ce86e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1133,8 +1133,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
>  		return 0;
>  	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
>  		return 0;
> -	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> -		return 0;
>  	return 1;
>  }
>  



