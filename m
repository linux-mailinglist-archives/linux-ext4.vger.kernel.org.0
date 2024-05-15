Return-Path: <linux-ext4+bounces-2525-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85E698C665B
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 14:28:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0E26B22146
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 12:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771C374E3F;
	Wed, 15 May 2024 12:28:01 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75AB2746D;
	Wed, 15 May 2024 12:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715776081; cv=none; b=NKJMr0zLg1wJmLiTrFlqnQl/+XQjREtsAmj2+2ITyErSydBWau5eXltwYXR/TRGGi8nOSxyj7MLOKO9PuW4hnzatnrRTDap4FVkc+sTGUZCKfUG3kpnpC3KYAWIkucl9htCPAdI3yRNHW7gVqHxWWg5WNaIg/ZNbTx7IWGjXSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715776081; c=relaxed/simple;
	bh=ppzDSmzaYbhuqGtfGiSLNmP0yC2n+xXzUY8/vULwOeE=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=g68roacDdHDO5/4hBms6Vf8cz5lJHuA2XU0FGfDxCo9OkIJakWogt0fXc3R/xzOrgg5qINYPWqUnS7LQtfjFeeeXXcoalrrotN/r11DfD/tgGAtaMKdbnpCp+AdMsCxu6dFzYL17Z7IaoX8eWBudQzB+bWwk+5Xj1UtVgmUAHxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VfXYZ1zdNz4f3jdS;
	Wed, 15 May 2024 20:27:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id EB29F1A0199;
	Wed, 15 May 2024 20:27:54 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgC32w5KqkRmenYqNA--.4809S3;
	Wed, 15 May 2024 20:27:54 +0800 (CST)
Subject: Re: [PATCH v2] ext4: fix infinite loop when replaying fast_commit
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
 Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20240515082857.32730-1-luis.henriques@linux.dev>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <1761896f-ce12-9aeb-616d-8451b1436943@huaweicloud.com>
Date: Wed, 15 May 2024 20:27:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240515082857.32730-1-luis.henriques@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC32w5KqkRmenYqNA--.4809S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar1rCF4kWF4UGw1rXw1xuFg_yoW8Xr47pa
	93uw1UGr18Z3y8Kay7Gw4xZF1Ykw4xG3y3GryfGrnY9F98Xrna9F18KFW5K3Z7W3yxJa4j
	qF40y3WDCa1qkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/15 16:28, Luis Henriques (SUSE) wrote:
> When doing fast_commit replay an infinite loop may occur due to an
> uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
> not detect the replay and calls ext4_es_find_extent_range(), which will
> return immediately without initializing the 'es' variable.
> 
> Because 'es' contains garbage, an integer overflow may happen causing an
> infinite loop in this function, easily reproducible using fstest generic/039.
> 
> This commit fixes this issue by unconditionally initializing the structure
> in function ext4_es_find_extent_range().
> 
> Thanks to Zhang Yi, for figuring out the real problem!
> 
> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>

Thanks for fixing this issue，looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/extents_status.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 4a00e2f019d9..3a53dbb85e15 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -310,6 +310,8 @@ void ext4_es_find_extent_range(struct inode *inode,
>  			       ext4_lblk_t lblk, ext4_lblk_t end,
>  			       struct extent_status *es)
>  {
> +	es->es_lblk = es->es_len = es->es_pblk = 0;
> +
>  	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>  		return;
>  
> 


