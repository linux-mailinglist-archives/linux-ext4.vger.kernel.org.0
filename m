Return-Path: <linux-ext4+bounces-5833-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 34CDB9F9F12
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2024 08:33:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69C9E16BD0D
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2024 07:33:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 310051E9B3A;
	Sat, 21 Dec 2024 07:33:24 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197F6B660;
	Sat, 21 Dec 2024 07:33:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734766404; cv=none; b=WEKSEeuuXHNNy3W0psF4xXYAhVim73fH4qZzcv5YHvb/3PbwZJdnmXAbIbVcUd6JYT2VJoyIzkpUNnQg1nGCDCVU19iNpWlsqhE9TtU3M88hMEqSC3+x9leDT1U9rLimL5Rj8d1AeroynsiJl8MbwWHfIO+nHPnGC23mQi0rwAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734766404; c=relaxed/simple;
	bh=McXi8OPkcGMY6TPJRgs1Cph7mtOdgGfUBg29QX+PvgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WnzImnPjgjpYwHZcPElo/4IPxk48BOX9ckMdu7WOLYnQFhww4ZNYbIlr39JH77v8D4fuCKKYbDAiT4NKKlsxVVqudy+VZcqvSwp4OtfQXfih9G7CG7bFAE1U2B3MSH8CqKaL3ej76sxL6NMGtYmllxEpqAFyfBSP0xB6tuPhdOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YFbbx2GYDz4f3jqC;
	Sat, 21 Dec 2024 15:33:01 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D2A6D1A018C;
	Sat, 21 Dec 2024 15:33:15 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgDnwoY6b2ZnxGHWFA--.44834S3;
	Sat, 21 Dec 2024 15:33:15 +0800 (CST)
Message-ID: <615d3a62-197a-4508-a792-cee718db4b73@huaweicloud.com>
Date: Sat, 21 Dec 2024 15:33:14 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] ext4: add missing brelse for bh2 in ext4_dx_add_entry
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-2-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241219110027.1440876-2-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDnwoY6b2ZnxGHWFA--.44834S3
X-Coremail-Antispam: 1UD129KBjvJXoW7tw4UZrWrCw48AryxZr4xWFg_yoW8urWDpr
	45Kas3ZFyxCF129F43Za4UXF17uw4xG347W3y7G34Skry7Zrn3KF92kw1rKFsrJ3y8u3W8
	XF4UKryq9w42yrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUjuHq7UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/19 19:00, Kemeng Shi wrote:
> Add missing brelse for bh2 in ext4_dx_add_entry.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

It's a good catch, looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/namei.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 1012781ae9b4..adec145b6f7d 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -2580,8 +2580,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  		BUFFER_TRACE(frame->bh, "get_write_access");
>  		err = ext4_journal_get_write_access(handle, sb, frame->bh,
>  						    EXT4_JTR_NONE);
> -		if (err)
> +		if (err) {
> +			brelse(bh2);
>  			goto journal_error;
> +		}
>  		if (!add_level) {
>  			unsigned icount1 = icount/2, icount2 = icount - icount1;
>  			unsigned hash2 = dx_get_hash(entries + icount1);
> @@ -2592,8 +2594,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  			err = ext4_journal_get_write_access(handle, sb,
>  							    (frame - 1)->bh,
>  							    EXT4_JTR_NONE);
> -			if (err)
> +			if (err) {
> +				brelse(bh2);
>  				goto journal_error;
> +			}
>  
>  			memcpy((char *) entries2, (char *) (entries + icount1),
>  			       icount2 * sizeof(struct dx_entry));
> @@ -2612,8 +2616,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  			dxtrace(dx_show_index("node",
>  			       ((struct dx_node *) bh2->b_data)->entries));
>  			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
> -			if (err)
> +			if (err) {
> +				brelse(bh2);
>  				goto journal_error;
> +			}
>  			brelse (bh2);
>  			err = ext4_handle_dirty_dx_node(handle, dir,
>  						   (frame - 1)->bh);
> @@ -2638,8 +2644,10 @@ static int ext4_dx_add_entry(handle_t *handle, struct ext4_filename *fname,
>  				       "Creating %d level index...\n",
>  				       dxroot->info.indirect_levels));
>  			err = ext4_handle_dirty_dx_node(handle, dir, frame->bh);
> -			if (err)
> +			if (err) {
> +				brelse(bh2);
>  				goto journal_error;
> +			}
>  			err = ext4_handle_dirty_dx_node(handle, dir, bh2);
>  			brelse(bh2);
>  			restart = 1;


