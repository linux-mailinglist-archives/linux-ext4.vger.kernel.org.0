Return-Path: <linux-ext4+bounces-12357-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C74ACBC388
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 03:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF4C93004D11
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Dec 2025 02:02:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7038419F464;
	Mon, 15 Dec 2025 02:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="6nPOMgg0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com [113.46.200.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E96051A254E
	for <linux-ext4@vger.kernel.org>; Mon, 15 Dec 2025 02:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765764163; cv=none; b=U/gNGi0xdOPhQWTIswQl4WVck0Y+3gnPaVUjhDICVmxLFAFqP52fygKAau+xc40p/E1FnQmYsn7/bf1TlNeSou7R1Ihdiq+dKDRsqCPQLRECk8qzwKAd1wU5a4JbetCqyUi3MyMkQikEGynwy8FnRGMiqlVHS+bohjRmy0gSLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765764163; c=relaxed/simple;
	bh=Q2yrEDWWO7bVgKGw8xd6fs+XnJW/XLxyUeoy0I6aTJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Ku3kLVxnCEysSVHITZNDpQB4fkBvBpwQwHwPfzCe85aFTogFQ6sFsof8QzZ1F9Ut97zyssXQjZIcnmm3ihwRFjLurV4LDnN62f5S5O8R4u8ROuEIpeN2ERXvILPtb8CrFX5KrC3Ixc/J1XV5kh5KSdBBsUrKnuNc68aD5kp0I6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=6nPOMgg0; arc=none smtp.client-ip=113.46.200.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=c3y+wtDihnjqDOnGtfordNjEgryc+mGOGO+bKVHbmCI=;
	b=6nPOMgg0tnmvqdYIndL6Bcn+ZuZNqT5G+zVYDnsd7uuzFRTu42Fs86vgc0vtC3Q6vzAwxAc/p
	qW3KNVJRI5vHFF2Xl/dC9bRqFv2CLXgFApJaQjvhJqGC+jwj9fn6rZfPueqOzEs08R8i6yhi4Pi
	E0MOlChDoANITFVF8YpDJvg=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dV3DY6HRkz1T4J5;
	Mon, 15 Dec 2025 10:00:29 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id C8BA8140203;
	Mon, 15 Dec 2025 10:02:38 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 15 Dec
 2025 10:02:38 +0800
Message-ID: <3631525a-1df6-47a4-b0b8-f20ab137264d@huawei.com>
Date: Mon, 15 Dec 2025 10:02:37 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref
Content-Language: en-GB
To: Yang Erkun <yangerkun@huawei.com>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <eraykrdg1@gmail.com>,
	<albinbabuvarghese20@gmail.com>, <linux-ext4@vger.kernel.org>,
	<yi.zhang@huawei.com>, <yangerkun@huaweicloud.com>
References: <20251213055706.3417529-1-yangerkun@huawei.com>
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251213055706.3417529-1-yangerkun@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500013.china.huawei.com (7.185.36.188)

On 2025-12-13 13:57, Yang Erkun wrote:
> The error branch for ext4_xattr_inode_update_ref forget to release the
> refcount for iloc.bh. Find this when review code.
>
> Fixes: 57295e835408 ("ext4: guard against EA inode refcount underflow in xattr update")
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Nice catch! The patch looks good so feel free to add:

Reviewed-by: Baokun Li <libaokun1@huawei.com>

> ---
>  fs/ext4/xattr.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
> index 2e02efbddaac..4ed8ddf2a60b 100644
> --- a/fs/ext4/xattr.c
> +++ b/fs/ext4/xattr.c
> @@ -1037,6 +1037,7 @@ static int ext4_xattr_inode_update_ref(handle_t *handle, struct inode *ea_inode,
>  		ext4_error_inode(ea_inode, __func__, __LINE__, 0,
>  			"EA inode %lu ref wraparound: ref_count=%lld ref_change=%d",
>  			ea_inode->i_ino, ref_count, ref_change);
> +		brelse(iloc.bh);
>  		ret = -EFSCORRUPTED;
>  		goto out;
>  	}



