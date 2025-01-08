Return-Path: <linux-ext4+bounces-5971-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51140A050EB
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 03:40:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAF733A3962
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jan 2025 02:40:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8541632D9;
	Wed,  8 Jan 2025 02:40:06 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E41F7E765;
	Wed,  8 Jan 2025 02:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736304006; cv=none; b=uRni9R1gh7BmI6g7xdA3B+wGW2B8KpKHco0w1rH+OEYErTh21+NeYiN3Zc4hb9XXqIUFKwNRmqMlU48M9CvapahYfZmxONTBXX/41QstZ7poE2A9sdxx6g4drx8QLqmLq2RTDT+4Mnt2aGWhPvKuDpXU81rm6iq3MNYSfXKLlD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736304006; c=relaxed/simple;
	bh=yg+ggpZ1KU5czquyD/GfrSz/ZqL43lcJBNVsVc3Jyec=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lQVexMjjerueVU/YxQVI2VB0M/YCYu+qn+cenEJQsXYMQn7aO2TKeYYDx22aYHJr+uCxwg1roL2L4dH9kdSwggtyDEP7mVyF85mwDhoFHr9jl5EboPmTAy5ilBNDesKT3o2QGWbV+Ndka+iTL3ztcgRCoFJC27/FzxVoIlrje7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YSXF06yqkz4f3lfH;
	Wed,  8 Jan 2025 10:39:32 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 55D801A0E37;
	Wed,  8 Jan 2025 10:39:54 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgAXe1945X1nwYlkAQ--.53473S3;
	Wed, 08 Jan 2025 10:39:54 +0800 (CST)
Message-ID: <5f302532-82fc-42af-b650-bd729be08fa2@huaweicloud.com>
Date: Wed, 8 Jan 2025 10:39:52 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] jbd2: remove unused h_jdata flag of handle
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20241224202707.1530558-1-shikemeng@huaweicloud.com>
 <20241224202707.1530558-2-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241224202707.1530558-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAXe1945X1nwYlkAQ--.53473S3
X-Coremail-Antispam: 1UD129KBjvdXoW7Gr1kJr13Kr4kZw1xJFWrKrg_yoWDtwb_Aw
	4vyr4kWr4xZFn3ZF12kFsrAF43GFW8Jr18WF1Fqr4v9ryDZayrGwn7tFZ8XFW7Wan7Ar43
	WF1kWrWxKwnI9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbc8FF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s
	1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0
	cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8Jw
	ACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/25 4:27, Kemeng Shi wrote:
> Flag h_jdata is not used, just remove it.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  include/linux/jbd2.h | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> index 50f7ea8714bf..c7fdb2b1b9a6 100644
> --- a/include/linux/jbd2.h
> +++ b/include/linux/jbd2.h
> @@ -459,7 +459,6 @@ struct jbd2_revoke_table_s;
>   * @h_ref: Reference count on this handle.
>   * @h_err: Field for caller's use to track errors through large fs operations.
>   * @h_sync: Flag for sync-on-close.
> - * @h_jdata: Flag to force data journaling.
>   * @h_reserved: Flag for handle for reserved credits.
>   * @h_aborted: Flag indicating fatal error on handle.
>   * @h_type: For handle statistics.
> @@ -491,7 +490,6 @@ struct jbd2_journal_handle
>  
>  	/* Flags [no locking] */
>  	unsigned int	h_sync:		1;
> -	unsigned int	h_jdata:	1;
>  	unsigned int	h_reserved:	1;
>  	unsigned int	h_aborted:	1;
>  	unsigned int	h_type:		8;


