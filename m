Return-Path: <linux-ext4+bounces-11805-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2443FC50C57
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 07:54:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 144563ACE24
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Nov 2025 06:54:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B55512E041D;
	Wed, 12 Nov 2025 06:54:25 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1ECA2DA76A;
	Wed, 12 Nov 2025 06:54:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762930465; cv=none; b=SRe/YVf1isCPkj2Qtt9cm1fqGmGduhPubl1Zu3+njOEHJvsbC/2lzzeZo6bReou2dJst9XPUVTTRCej6KeM/CkeSMI/izpmtbEM6A5mXxP4tEMPUUjg6pLw1DT+OY5WZ90K8oGuALKwAkt+iyFdzuL8F6CF+WVVgMPwWBIJ2nw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762930465; c=relaxed/simple;
	bh=F8u4FNBKzDsM0w8MPUutJAIWU93CjlFju+gFuY4cRFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Bfk+WTWn8fkRNm/BzDUXDXGsLfGDHXQtJx/u4w9X6PoO4hRLlGYH1BKCWTHssb2XmCLIKs3TyTsVLuRQBRgobI/zTc2BhbsfTbOu6aiSGRlrUSvoF5WinobASi8HccfWLI6Qytl6NmgSRyuBjwWT+syzGkSXp/hOE9R1Yqf6GIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTPS id 4d5vJJ10v5zYQtwS;
	Wed, 12 Nov 2025 14:53:52 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 27DBC1A110A;
	Wed, 12 Nov 2025 14:54:20 +0800 (CST)
Received: from [10.174.178.152] (unknown [10.174.178.152])
	by APP2 (Coremail) with SMTP id Syh0CgAHZXsbLxRps53ZAQ--.3291S3;
	Wed, 12 Nov 2025 14:54:19 +0800 (CST)
Message-ID: <29aebfa7-99ed-42e7-b94e-e6c15223aa8c@huaweicloud.com>
Date: Wed, 12 Nov 2025 14:54:18 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/24] ext4: support verifying data from large folios
 with fs-verity
To: libaokun@huaweicloud.com, linux-ext4@vger.kernel.org
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, jack@suse.cz,
 linux-kernel@vger.kernel.org, kernel@pankajraghav.com, mcgrof@kernel.org,
 ebiggers@kernel.org, willy@infradead.org, yangerkun@huawei.com,
 chengzhihao1@huawei.com, libaokun1@huawei.com
References: <20251111142634.3301616-1-libaokun@huaweicloud.com>
 <20251111142634.3301616-23-libaokun@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20251111142634.3301616-23-libaokun@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAHZXsbLxRps53ZAQ--.3291S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr4kWr15Aw4UXF1rJw4fZrb_yoWkZrgEk3
	yv9w48A3ySgws2kay5Ar13Xryq9F4kGr129aySqr1av3yfZ395A3ZrKr4YkanrWa17WFZ8
	CFsxAF42yryqvjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbxxYFVCjjxCrM7AC8VAFwI0_Gr0_Xr1l1xkIjI8I6I8E6xAIw20E
	Y4v20xvaj40_Wr0E3s1l1IIY67AEw4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwV
	A0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x02
	67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4
	xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43
	MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I
	0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWU
	JVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOB
	MKDUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 11/11/2025 10:26 PM, libaokun@huaweicloud.com wrote:
> From: Baokun Li <libaokun1@huawei.com>
> 
> Eric Biggers already added support for verifying data from large folios
> several years ago in commit 5d0f0e57ed90 ("fsverity: support verifying
> data from large folios").
> 
> With ext4 now supporting large block sizes, the fs-verity tests
> `kvm-xfstests -c ext4/64k -g verity -x encrypt` pass without issues.
> 
> Therefore, remove the restriction and allow large folios to be enabled
> together with fs-verity.
> 
> Cc: Eric Biggers <ebiggers@kernel.org>
> Signed-off-by: Baokun Li <libaokun1@huawei.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/inode.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
> index 613a989bf750..7b979e64f481 100644
> --- a/fs/ext4/inode.c
> +++ b/fs/ext4/inode.c
> @@ -5152,8 +5152,6 @@ static bool ext4_should_enable_large_folio(struct inode *inode)
>  
>  	if (!S_ISREG(inode->i_mode))
>  		return false;
> -	if (ext4_has_feature_verity(sb))
> -		return false;
>  	if (ext4_has_feature_encrypt(sb))
>  		return false;
>  


