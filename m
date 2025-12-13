Return-Path: <linux-ext4+bounces-12352-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A188CCBA6CE
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Dec 2025 08:45:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AA505302EFD9
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Dec 2025 07:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5CA4248176;
	Sat, 13 Dec 2025 07:45:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 921A620298D
	for <linux-ext4@vger.kernel.org>; Sat, 13 Dec 2025 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765611920; cv=none; b=eTQp9YP30Gina7Ge2lE5soMCqzWcNNnZQ1GA+oGCISCPc2n0+XCWg03BP1t+RzitIExOtG6q8LQSYHbiMhRjWEFWMk8umrZLjjJJubywJcVgZOXZQVKKKqoXLTFPtU+br+B4jqxsVsT31eHXCNAVnGZmWo2jmGKa9nRiRTUuZ0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765611920; c=relaxed/simple;
	bh=zOpVueSqmeLvv4XoyMkU3LuiW+y6VZ3oCkPikfLDaMU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MQysR/6pGisFncjHoQ8ussFfuYd4URS00xM2/0Pfh6Cf7tlKvlR0zkMd+x0Y1LLwm7W6Uu54dzX8+A0U3wCrRh8jaXdgU5QfJVoilHIQp7Q24Q5tnem0FEO8iuFhRR2L96RWM3OCpsw5nyPbEb7lNSehABAdBPL+poGRkkQNuM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4dSyyr3NgbzYQtrb
	for <linux-ext4@vger.kernel.org>; Sat, 13 Dec 2025 15:44:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 491151A0194
	for <linux-ext4@vger.kernel.org>; Sat, 13 Dec 2025 15:45:12 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP4 (Coremail) with SMTP id gCh0CgDXOPmGGT1p3IUUAA--.5170S3;
	Sat, 13 Dec 2025 15:45:12 +0800 (CST)
Message-ID: <34bce2ba-dbee-453c-a456-838cef094d50@huaweicloud.com>
Date: Sat, 13 Dec 2025 15:45:10 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: fix iloc.bh leak in ext4_xattr_inode_update_ref
To: Yang Erkun <yangerkun@huawei.com>
Cc: libaokun1@huawei.com, yangerkun@huaweicloud.com, tytso@mit.edu,
 adilger.kernel@dilger.ca, eraykrdg1@gmail.com,
 albinbabuvarghese20@gmail.com, linux-ext4@vger.kernel.org
References: <20251213055706.3417529-1-yangerkun@huawei.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251213055706.3417529-1-yangerkun@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXOPmGGT1p3IUUAA--.5170S3
X-Coremail-Antispam: 1UD129KBjvdXoWrtry8tFW3tF4kWw43CF48Zwb_yoWfuFc_GF
	ZFvr48Gr45Xrn5GF4kZF4aq3ZYvF18Gr15WFyktr18Z3W5tayvvryvqryDCr1UWw4UJr98
	Zrn7Ar4ayF9IgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbwkYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxG
	rwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4
	vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IY
	x2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26c
	xKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAF
	wI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHDUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 12/13/2025 1:57 PM, Yang Erkun wrote:
> The error branch for ext4_xattr_inode_update_ref forget to release the
> refcount for iloc.bh. Find this when review code.
> 
> Fixes: 57295e835408 ("ext4: guard against EA inode refcount underflow in xattr update")
> Signed-off-by: Yang Erkun <yangerkun@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

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


