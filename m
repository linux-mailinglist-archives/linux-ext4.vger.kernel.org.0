Return-Path: <linux-ext4+bounces-9011-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A1CF4B05A95
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 14:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44AB01AA5E1F
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Jul 2025 12:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07C65214A64;
	Tue, 15 Jul 2025 12:50:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B271FCF7C;
	Tue, 15 Jul 2025 12:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752583823; cv=none; b=j74CCC5pK61UDvXxU8b/981rTZSqtYpPzb6iMkX01wDb3DDORdd4ggik1Fv1y6dJFD3bKF21jPnNhIv124T4Ao9GYmIA5fXr5hOWS/3wwqt6fBK2cZqEOfXjP+cpgbcDfW1HU8uYT+6q7K3B01laGt09VQE7Gf0i9FGQNBwTGY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752583823; c=relaxed/simple;
	bh=751SwGHIm+Oeos9FblY1Ty8+lkNjyNlamQiw0R7c7pY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=dotNrj4kvECeboqyhEiwRRWIUNqpxbOs10VLJpXeZWbhsCfk5I852nSvln2MG4H9dx6XN5SttPMmwtBO7jIUBHiqXGkW68+eL1Mq5gWZ+y/mJc3QftTYfAvyJK0uIUkkP8GVfWXLSIVdADKX2zTQsXI7CY5NXaI3ngVmGiSEugk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bhJsh4YyRztSkN;
	Tue, 15 Jul 2025 20:49:12 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 0DDD71401F3;
	Tue, 15 Jul 2025 20:50:18 +0800 (CST)
Received: from [10.174.179.80] (10.174.179.80) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 15 Jul 2025 20:50:17 +0800
Message-ID: <f42f9a79-75cf-491e-bf46-5ea036cf6656@huawei.com>
Date: Tue, 15 Jul 2025 20:50:16 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] ext4: add FALLOC_FL_ALLOCATE_RANGE to supported flags
 mask
To: chuguangqing <chuguangqing@inspur.com>
CC: <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Theodore
 Ts'o <tytso@mit.edu>, Andreas Dilger <adilger.kernel@dilger.ca>
References: <20250715043808.5808-2-chuguangqing@inspur.com>
 <20250715064536.12053-1-chuguangqing@inspur.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huawei.com>
In-Reply-To: <20250715064536.12053-1-chuguangqing@inspur.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemf100017.china.huawei.com (7.202.181.16)

On 2025/7/15 14:45, chuguangqing wrote:
> Note that since FALLOC_FL_ALLOCATE_RANGE is defined as 0x00, this addition
> has no functional modifications.
> 
> Signed-off-by: chuguangqing <chuguangqing@inspur.com>
> ---
>  fs/ext4/extents.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index b43aa82c1b39..f0f9363fd9fd 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4784,9 +4784,9 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
>  		return -EOPNOTSUPP;
>  
>  	/* Return error if mode is not supported */
> -	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE |
> -		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_COLLAPSE_RANGE |
> -		     FALLOC_FL_INSERT_RANGE | FALLOC_FL_WRITE_ZEROES))
> +	if (mode & ~(FALLOC_FL_ALLOCATE_RANGE | FALLOC_FL_KEEP_SIZE |
> +		     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
> +		     FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE))
>  		return -EOPNOTSUPP;
>  
>  	inode_lock(inode);

Why did you remove the FALLOC_FL_WRITE_ZEROES support?

Regards,
Yi.

