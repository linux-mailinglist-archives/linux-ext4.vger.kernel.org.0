Return-Path: <linux-ext4+bounces-12503-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 977DFCDB15E
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Dec 2025 02:39:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4AD330245FE
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Dec 2025 01:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AD4279DAF;
	Wed, 24 Dec 2025 01:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="FVR38gVr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF9F119F11B;
	Wed, 24 Dec 2025 01:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766540357; cv=none; b=qL2Xfj7dr0gTPAQCy57Yhmzcd5F8VHUXd++JmcqJpj5bIk/FwevfYEWHUjlehXjaiWK0/n0iCAKd+Uu6znhnCtz7Oom7FJKw3JNSXYYoXVOfA1Kz4aNm7Q1ZcshmXy2yZXyk9D/SHbXw5bK3y6lr2B1V1lcnYFpk4lolpTWMXR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766540357; c=relaxed/simple;
	bh=c4rp59GrnxfBa9b+ZQAugwTTfXqcFs40yuy9HG1Vmn0=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=AjsQHObdRzfRpiIOec6Gb2Mg7UCNwiqhlEh35FFsMuyDgshtf5+fYUeoPbwaRnrCFYVhPItZhdQSlhUyufHnu7p5D05X4IyXfPeYfw7B/9KDAA48Ilrd7BqBFjd2MTGvkJyYhvE+3DMhZSg5ttuwylEjpJ8qgzFzyH+etnVKRQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=FVR38gVr; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vJzqNYW0GY6ZNfseR5giYfjmiT49xxHGMuFLcEB4Ldw=;
	b=FVR38gVrvHqFpzc3XSiyKSxi4vDwIYHzSU2n6BGXyLKM0Mss98FoYfPWUpFZ1wy2CIioFMrHM
	EQdQ0KpUshxJpX98Rot+CPcmR5ZYTdLJLs++EbyACEaMPJ2w0JU/69QrZOJ+GOnkED4VCOjHxTU
	BOZFxFhJLt6G8+4RgY2cQCA=
Received: from mail.maildlp.com (unknown [172.19.163.214])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4dbZG134W5znTV6;
	Wed, 24 Dec 2025 09:35:53 +0800 (CST)
Received: from dggpemf500013.china.huawei.com (unknown [7.185.36.188])
	by mail.maildlp.com (Postfix) with ESMTPS id 0783140539;
	Wed, 24 Dec 2025 09:39:06 +0800 (CST)
Received: from [127.0.0.1] (10.174.178.254) by dggpemf500013.china.huawei.com
 (7.185.36.188) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 24 Dec
 2025 09:39:04 +0800
Message-ID: <b09e6934-6924-4f9a-a866-82599fe64879@huawei.com>
Date: Wed, 24 Dec 2025 09:39:03 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fs/ext4: Initialize new folios before use
To: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <david.hunter.linux@gmail.com>,
	<skhan@linuxfoundation.org>, <khalid@kernel.org>,
	<linux-kernel-mentees@lists.linux.dev>,
	<syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com>
References: <20251223215855.2486271-1-kubik.bartlomiej@gmail.com>
Content-Language: en-GB
From: Baokun Li <libaokun1@huawei.com>
In-Reply-To: <20251223215855.2486271-1-kubik.bartlomiej@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500013.china.huawei.com (7.185.36.188)

Hi Bartlomiej,

On 2025-12-24 05:58, Bartlomiej Kubik wrote:
> KMSAN reports an uninitialized value in adiantum_crypt, created at
> write_begin_get_folio(). New folios are allocated with the FGP_CREAT
> flag and may be returned uninitialized. These uninitialized folios are
> then used without proper initialization.
>
> Fixes: b799474b9aeb ("mm/pagemap: add write_begin_get_folio() helper function")
> Tested-by: syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
> Reported-by: syzbot+703d8a2cd20971854b06@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=703d8a2cd20971854b06
>
> Signed-off-by: Bartlomiej Kubik <kubik.bartlomiej@gmail.com>
> ---
>  include/linux/pagemap.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index 31a848485ad9..31bbc8299e08 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -787,7 +787,8 @@ static inline struct folio *write_begin_get_folio(const struct kiocb *iocb,
>                  fgp_flags |= FGP_DONTCACHE;
>
>          return __filemap_get_folio(mapping, index, fgp_flags,
> -                                   mapping_gfp_mask(mapping));
> +				mapping_gfp_mask(mapping)|
> +				__GFP_ZERO);
We do need to perform some initialization, but doing it in this common
path is clearly unreasonable. It would introduce unnecessary zeroing
overhead even for non-crypto scenarios.

Therefore, I suspect something was missed in certain crypto-related
initialization paths where the zeroing should have been handled instead.


Cheers,
Baokun


