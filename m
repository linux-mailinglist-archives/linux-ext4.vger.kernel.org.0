Return-Path: <linux-ext4+bounces-12707-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C06F3D0CABE
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jan 2026 02:00:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0A078302048A
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Jan 2026 01:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D7C219D071;
	Sat, 10 Jan 2026 01:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="3aLu52ZM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com [113.46.200.223])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676892A1BF
	for <linux-ext4@vger.kernel.org>; Sat, 10 Jan 2026 01:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.223
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768006836; cv=none; b=pZ4S2C0sv+D9mVq3b/yiF+7dortudKf5LQpFWuXrP278JadROEo+svYaaCeAcrRM3xHb+BIKjk4ah61v/l+YgE/WBE018GZ+vv1LqSM6MvDgWHzBYHGbtzifPR1HLP08Rx/ZlQ9eDi96YXOM1/ON9+LuLxWfOxgQYtt84EEjnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768006836; c=relaxed/simple;
	bh=Zrl/dj4KVHi9C7lwWP8ZX3V8X/JCVns/krpIbuT/kKE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=SH6d6E3DoICQbdwV3/gj/Z0LiNO53pGVDYiO2+V7cWY9vi6JrdVZgOl1UFMaP2BcKEM928aJJBfY6VNkN27ZjwFDzOq5wT3GILo9KbX41zeQZI4P58PhqzWFSN44RzI/zSt3/g+DHSWCS/JidWnfO1wDHj4i8dkW1y3kRkjnXtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=3aLu52ZM; arc=none smtp.client-ip=113.46.200.223
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=dcnfQwKs9iJzIVDgq+GPHWIqqP5NCKIS+UBvRAELGco=;
	b=3aLu52ZMoAnCPMnfHwzZR02ztVs+WV4totHEV7TREdIa/2ye6UQAxrIJL97w6OAGaqDNSR9gF
	bi8rryd7MmBa6ZMIbSWbI6ARRsSgJLGkVpGr67jGj9xhFtMT9yIgtQdd+mZIgzfAW3GdwWysv9/
	XMgogRtn8Bk+MQCZB/RKYwQ=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4dp0bZ2SPMzmV7q;
	Sat, 10 Jan 2026 08:57:14 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id EF7F740363;
	Sat, 10 Jan 2026 09:00:31 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Sat, 10 Jan
 2026 09:00:31 +0800
Message-ID: <531ee164-8dba-499b-957e-b23d2ec4997a@huawei.com>
Date: Sat, 10 Jan 2026 09:00:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] ext4: use optimized mballoc scanning regardless of
 inode format
Content-Language: en-GB
To: Jan Kara <jack@suse.cz>
CC: Ted Tso <tytso@mit.edu>, <linux-ext4@vger.kernel.org>
References: <20260109105007.27673-1-jack@suse.cz>
 <20260109105354.16008-4-jack@suse.cz>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20260109105354.16008-4-jack@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2026-01-09 18:53, Jan Kara wrote:
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

Makes sense. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/mballoc.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
> index f0e07bf11a93..cd98c472631e 100644
> --- a/fs/ext4/mballoc.c
> +++ b/fs/ext4/mballoc.c
> @@ -1145,8 +1145,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
>  		return 0;
>  	if (ac->ac_criteria >= CR_GOAL_LEN_SLOW)
>  		return 0;
> -	if (!ext4_test_inode_flag(ac->ac_inode, EXT4_INODE_EXTENTS))
> -		return 0;
>  	return 1;
>  }
>  



