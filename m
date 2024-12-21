Return-Path: <linux-ext4+bounces-5835-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA229F9F1B
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2024 08:44:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE90D18914E1
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2024 07:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C76F11EBFE4;
	Sat, 21 Dec 2024 07:44:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34291EC4D2;
	Sat, 21 Dec 2024 07:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734767080; cv=none; b=EXOEjyM29DcFnvfUPq/Afgpm/HKlm810czMFNNXhOUeeOMAmJFXHklxjritIXw7ptGF4Ef1A2LorAKbudXsQf226LdHEWM/M5iiuUbasHWnA83mMXQo0GEn/wa51ZwvvHVC0cE39HRVoS48GTyXapwdDsLfSjDD8vZSfElEze9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734767080; c=relaxed/simple;
	bh=pkvyRcjKfRzQaQrX8zkTJjrQeAWcVrBAYzlkgKWRKes=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ux5cD3lwVtQbvlmsYwQjxWX3vSnI5KAcATViwht5g2PoOfPmRQOLtgvdLmA9hf0h/bz1nbsSqsqg6D5szXB8+j8L696e9FcIj375XD/j+K41+OeErpa7hdXVADgZ/W4+Evm319g2/31T9ihRUbeqPFUDgATRpLkxu2R16AdgZrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4YFbrs1JVTz4f3jcj;
	Sat, 21 Dec 2024 15:44:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BE7241A018D;
	Sat, 21 Dec 2024 15:44:32 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDH7oLfcWZnEx_XFA--.42163S3;
	Sat, 21 Dec 2024 15:44:32 +0800 (CST)
Message-ID: <a002a2bd-f8ff-4bf2-bb4d-e686cfeea6ac@huaweicloud.com>
Date: Sat, 21 Dec 2024 15:44:31 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/6] ext4: remove unneeded check in get_dx_countlimit
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-5-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241219110027.1440876-5-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDH7oLfcWZnEx_XFA--.42163S3
X-Coremail-Antispam: 1UD129KBjvdXoWrZFy7Xw45CF18XF1DAw1DKFg_yoW3Cwc_Xw
	nYvrn7JFWfXr1xGF1fG39xXFZxKa4rAr15Jryrtry2qr98tFZYv3srJr1SyFyDWF47JrWY
	kF95ZFyakFyxZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbcxFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_
	Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IY64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1D
	MxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr
	0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0E
	wIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JV
	WxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAI
	cVC2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbb_-PUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/19 19:00, Kemeng Shi wrote:
> The "offset" is always non-NULL, remove unneeded NULL check of "offset".
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

I agree with Ojaswin, the check strengthens the function, and I'd
suggest that we'd better to keep it for now.

Thanks,
Yi.

> ---
>  fs/ext4/namei.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 33670cebdedc..07a1bb570deb 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -434,8 +434,7 @@ static struct dx_countlimit *get_dx_countlimit(struct inode *inode,
>  	} else
>  		return NULL;
>  
> -	if (offset)
> -		*offset = count_offset;
> +	*offset = count_offset;
>  	return (struct dx_countlimit *)(((void *)dirent) + count_offset);
>  }
>  


