Return-Path: <linux-ext4+bounces-12517-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B865CDD91E
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Dec 2025 10:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4B528301E91A
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Dec 2025 09:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08EBA3161A0;
	Thu, 25 Dec 2025 09:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KEhAR05d"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 646242F1FDD;
	Thu, 25 Dec 2025 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766653832; cv=none; b=is7LC7WaAz5z8PVuoKb0e8U9tGMAM0C03F5OEk+lx4f+6g6l664RdDSGDi4gohqpKXhUIBJH1cI8dLmf55XRKvFdWltrYX4UhjLSVf8JT5CJk5QMlQ0z9ChYjn0qUkogqtdls2XBKyrNK6VBFLxfvvz3jz5Kt7VSKFy9Yni6eHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766653832; c=relaxed/simple;
	bh=m5fB2cG1jVULSwoKIf9tu/Z8iGcM6q58dnTdLyL6aN0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=HRQ0HipdOtVs5raytTh4W4cadfRfbLi8l6zwPyrV5McZeTY9xy+Cg0cKPLRUA82sh4ymlEAf/gEbuqlo84LEXenTlVKwVlpuzTlB7sOVoVViLNPhfdHvepbdEV43GPwU9c5kjqoOu9tNTgOPmBLmWmD1BYG84GTokN75JURQFFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KEhAR05d; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=k/6dQUoI2eZxOY0meJaF2nNTS00FJ40wZ/essucL2c8=;
	b=KEhAR05dvuAEtxkgCAX2FD94bmpuVlYsxJK+Xa9lFX4gY1fM4oWpcjH9oCYzEhF1dJCTR/8lb
	qG1G9ktus84m98vmoGuZ55nK21Kdeo6LqmrNLHpimF833XNlI08e8RkvjrcHMyeT3zSdypxcjT/
	wL0EigX+X9I4ibl+asNWEtI=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4dcNDH15LZzcb0Q;
	Thu, 25 Dec 2025 17:07:11 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 325C740538;
	Thu, 25 Dec 2025 17:10:19 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 25 Dec
 2025 17:10:18 +0800
Message-ID: <7d0b0649-89db-4e04-a816-1c57dee31119@huawei.com>
Date: Thu, 25 Dec 2025 17:10:17 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: Fix memory leak in ext4_ext_shift_extents()
Content-Language: en-GB
To: Zilin Guan <zilin@seu.edu.cn>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jianhao.xu@seu.edu.cn>,
	<libaokun9@gmail.com>
References: <20251225084800.905701-1-zilin@seu.edu.cn>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251225084800.905701-1-zilin@seu.edu.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-25 16:48, Zilin Guan wrote:
> In ext4_ext_shift_extents(), if the extent is NULL in the while loop, the
> function returns immediately without releasing the path obtained via
> ext4_find_extent(), leading to a memory leak.
>
> Fix this by jumping to the out label to ensure the path is properly
> released.
>
> Fixes: a18ed359bdddc ("ext4: always check ext4_ext_find_extent result")
> Signed-off-by: Zilin Guan <zilin@seu.edu.cn>

Nice catch! The patch looks good so feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/extents.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index 2cf5759ba689..1d21943a09b0 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -5375,7 +5375,8 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>  		if (!extent) {
>  			EXT4_ERROR_INODE(inode, "unexpected hole at %lu",
>  					 (unsigned long) *iterator);
> -			return -EFSCORRUPTED;
> +			ret = -EFSCORRUPTED;
> +			goto out;
>  		}
>  		if (SHIFT == SHIFT_LEFT && *iterator >
>  		    le32_to_cpu(extent->ee_block)) {



