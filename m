Return-Path: <linux-ext4+bounces-12372-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B36CC1169
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 07:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B0EDE30698C7
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Dec 2025 06:21:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 138393376B0;
	Tue, 16 Dec 2025 06:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cdHnVoDA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F163191C0;
	Tue, 16 Dec 2025 06:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765865571; cv=none; b=kPvlIUPpsUaalZked3ISUPHuzH1KDwcFVjmkG05V5H76CeZgGNNeiQnK4GybgWgNAypeMp9UCUTgplx0s3js/4JH00keyZj809voq2/9giz1qVs+n9g09gXGd9kNlVLYp7CleS6qU1SrF/8YT0vJw6D9/Xd/1eT+eAwexvE+DiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765865571; c=relaxed/simple;
	bh=0N+TZZO86yzgJ6qiBdQVfvwnLrMc33puXaZaXbjhOmk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cbK3R0/MeIRRGMrjVSYO33K5Tv2LuB3LKKyVLnoW4MVno++ai8JypSGqpxPkZCWt7dL9JvhEuHqSlb/8TimGjU72dZurfc292yB2Rvpa1PXg6oztcJrhPdGpRgmDql3Z42kvDvl8BHgB6xIlHmWSHHoQRqkpJI6w6XwUOsI6xPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cdHnVoDA; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=/u8GqUm3dok5ZGfzmN1oYbh2HIhvIIX0fyM8sbkVkkM=;
	b=cdHnVoDAvpeP9zf79LE2XG1TwMgBtAIQA3wXfUWiqagusMmcna98e9ynmvyZWQ3Er35c4JfbW
	OL4mlQoLml7d4YqQM61jMDNWuPnEB0EPQTI7KCjPdAy7h4QXI+LpWg31+IVRaCSIWMKPADn6cpO
	qYoHBtDzH5E/4Szc1O4+Y6A=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4dVmkT2MFNz12LDy;
	Tue, 16 Dec 2025 14:10:25 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id B3DA9140132;
	Tue, 16 Dec 2025 14:12:39 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 16 Dec
 2025 14:12:38 +0800
Message-ID: <5d560ad4-98be-4827-b1fb-e9b2caca6cf1@huawei.com>
Date: Tue, 16 Dec 2025 14:12:37 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ext4: Remove unnecessary zero-initialization via
 memset
Content-Language: en-GB
To: Donglin Peng <dolinux.peng@gmail.com>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, pengdonglin <pengdonglin@xiaomi.com>
References: <20251211123829.2777009-1-dolinux.peng@gmail.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251211123829.2777009-1-dolinux.peng@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-11 20:38, Donglin Peng wrote:
> From: pengdonglin <pengdonglin@xiaomi.com>
>
> The d_path function does not require the caller to pre-zero the
> buffer.
>
> Signed-off-by: pengdonglin <pengdonglin@xiaomi.com>

Looks good. Feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/file.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/fs/ext4/file.c b/fs/ext4/file.c
> index 7a8b30932189..484cb7388802 100644
> --- a/fs/ext4/file.c
> +++ b/fs/ext4/file.c
> @@ -858,7 +858,6 @@ static int ext4_sample_last_mounted(struct super_block *sb,
>  	 * when trying to sort through large numbers of block
>  	 * devices or filesystem images.
>  	 */
> -	memset(buf, 0, sizeof(buf));
>  	path.mnt = mnt;
>  	path.dentry = mnt->mnt_root;
>  	cp = d_path(&path, buf, sizeof(buf));



