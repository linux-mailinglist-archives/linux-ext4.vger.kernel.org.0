Return-Path: <linux-ext4+bounces-6624-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 146A9A493D7
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2025 09:44:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2194816C158
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Feb 2025 08:44:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67A592528FA;
	Fri, 28 Feb 2025 08:44:49 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E932528EB
	for <linux-ext4@vger.kernel.org>; Fri, 28 Feb 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740732289; cv=none; b=NMx37dhyIxrJrmT5cnSCC6kkiyKw8WX2Twm++6IwUCxR/kbkbE92YJGtMMboPR5reWFYjaTmDb+oyEjAo/ZatNyy4AABhiySZQkVVVR5/xPRYOEhmY6cTO+IqTTG0lDvMO+Dyagvmcd6h/Rx2TIAXiE8YQuj3tRHtgno8RffO5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740732289; c=relaxed/simple;
	bh=9RNjP1pAUKQFDldYzspp0Qp+8epuDjFdwGMgxlY86Qk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=n2PepYLMKPvQEszJYiQIILflgZbsuh+Ix7d3DtYhoGN1wUCJWMET/ZKIumq5SChqZ+J7OZ7ibCqyh+caIG0Q1pe9AFhaYrhGQj5Ju+aVG04R3Yv/DQfGU5DQex58eFxGRRBjy24IW8lEiyyrturVp3Hb/2yZUEXxRtJMBTMTPZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4Z41r53Xq9z1dymd;
	Fri, 28 Feb 2025 16:40:37 +0800 (CST)
Received: from kwepemg500008.china.huawei.com (unknown [7.202.181.45])
	by mail.maildlp.com (Postfix) with ESMTPS id 3BA411A016C;
	Fri, 28 Feb 2025 16:44:44 +0800 (CST)
Received: from [127.0.0.1] (10.174.177.71) by kwepemg500008.china.huawei.com
 (7.202.181.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 28 Feb
 2025 16:44:43 +0800
Message-ID: <9be439b3-fd43-4a4b-96e5-0d0ec5fb1509@huawei.com>
Date: Fri, 28 Feb 2025 16:44:42 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ext4: remove unnecessary checks for __GFP_NOFAIL
 allocation.
To: Julian Sun <sunjunchao2870@gmail.com>, <linux-ext4@vger.kernel.org>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>, Yang Erkun
	<yangerkun@huawei.com>
References: <20250228081126.2634480-1-sunjunchao2870@gmail.com>
Content-Language: en-US
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20250228081126.2634480-1-sunjunchao2870@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemg500008.china.huawei.com (7.202.181.45)

On 2025/2/28 16:11, Julian Sun wrote:
> The __GFP_NOFAIL flag ensures that allocation will not fail.
> So remove the unnecessary checks.
Actually, even with __GFP_NOFAIL set, kcalloc() can still return NULL,
such as when the input parameters overflow.


Baokun
>
> Signed-off-by: Julian Sun <sunjunchao2870@gmail.com>
> ---
>   fs/ext4/extents.c | 4 ----
>   1 file changed, 4 deletions(-)
>
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index a07a98a4b97a..95debd5d6506 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -2940,10 +2940,6 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
>   	} else {
>   		path = kcalloc(depth + 1, sizeof(struct ext4_ext_path),
>   			       GFP_NOFS | __GFP_NOFAIL);
> -		if (path == NULL) {
> -			ext4_journal_stop(handle);
> -			return -ENOMEM;
> -		}
>   		path[0].p_maxdepth = path[0].p_depth = depth;
>   		path[0].p_hdr = ext_inode_hdr(inode);
>   		i = 0;



