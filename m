Return-Path: <linux-ext4+bounces-2509-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98D9E8C57B8
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 16:11:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E80E2852CC
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 14:11:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07BC5144D0F;
	Tue, 14 May 2024 14:11:15 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AB571448EE;
	Tue, 14 May 2024 14:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715695874; cv=none; b=O1MoTymiDOaVznMAKP9Nk3xnmxoTfs2uGYmfSHY0h+B+Y5FPLhBo8ImmaHzy56NVAIY9AxfL53oPeKP5EvfvTLABGozbyDR3PAMWTsdH7bRD2eMkvf7rTBvsGDsWpZMn+D+yVmAMmVPYRs2R8BATQFmUpMdVsd9htQ911h5hgvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715695874; c=relaxed/simple;
	bh=NuDUH3lQEQUkn5ow0R+rr288QiNXrvK2VyecYrRxQDM=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=gX0lS9nr/hkzJ3ozE6FCOQzvHHibXPmQ01YE9PWScU1rxBeLO75F55GzdEKuXI9A/vkz00oKdTQ3cfwb764u06WE5WAWY+dmOCYZT2R2FjAVLzXwYADracs4BqVCG0DOc2PTq8NQRsQPKQuWuPkPkxlr87UIcVMfZOjQu9rGz0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4Vdyv73vgpz4f3jJ6;
	Tue, 14 May 2024 22:10:59 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 2D4CE1A0B00;
	Tue, 14 May 2024 22:11:08 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDH6w76cENmwvTQMw--.36155S3;
	Tue, 14 May 2024 22:11:08 +0800 (CST)
Subject: Re: [PATCH v2 4/9] jbd2: jump to new copy_done tag when b_frozen_data
 is created concurrently
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 jack@suse.com
References: <20240514112438.1269037-1-shikemeng@huaweicloud.com>
 <20240514112438.1269037-5-shikemeng@huaweicloud.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <28548c0f-f900-4382-b648-bca4d8e0e739@huaweicloud.com>
Date: Tue, 14 May 2024 22:11:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240514112438.1269037-5-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDH6w76cENmwvTQMw--.36155S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1xKrW3Cw13Xr43tr48Crg_yoW8ArW5pr
	yfKF1jv34vq3srtrn7Wa1DZFW0g3ykWF1jkFZxCrsxJFW3K34kWF1jvw48Kw1UAF97J3yr
	XFyj9aykWwsIyFUanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7I2V7IY0VAS07AlzVAY
	IcxG8wCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6rWUJVWrZr1UMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUywZ
	7UUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/14 19:24, Kemeng Shi wrote:
> If b_frozen_data is created concurrently, we can update new_folio and
> new_offset with b_frozen_data and then move forward
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

It's more straight forward, looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/jbd2/journal.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
> index 714e2ef0115a..5fb5062cf7ae 100644
> --- a/fs/jbd2/journal.c
> +++ b/fs/jbd2/journal.c
> @@ -351,7 +351,6 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  	atomic_set(&new_bh->b_count, 1);
>  
>  	spin_lock(&jh_in->b_state_lock);
> -repeat:
>  	/*
>  	 * If a new transaction has already done a buffer copy-out, then
>  	 * we use that version of the data for the commit.
> @@ -399,22 +398,22 @@ int jbd2_journal_write_metadata_buffer(transaction_t *transaction,
>  		spin_lock(&jh_in->b_state_lock);
>  		if (jh_in->b_frozen_data) {
>  			jbd2_free(tmp, bh_in->b_size);
> -			goto repeat;
> +			goto copy_done;
>  		}
>  
>  		jh_in->b_frozen_data = tmp;
>  		memcpy_from_folio(tmp, new_folio, new_offset, bh_in->b_size);
> -
> -		new_folio = virt_to_folio(tmp);
> -		new_offset = offset_in_folio(new_folio, tmp);
> -		done_copy_out = 1;
> -
>  		/*
>  		 * This isn't strictly necessary, as we're using frozen
>  		 * data for the escaping, but it keeps consistency with
>  		 * b_frozen_data usage.
>  		 */
>  		jh_in->b_frozen_triggers = jh_in->b_triggers;
> +
> +copy_done:
> +		new_folio = virt_to_folio(jh_in->b_frozen_data);
> +		new_offset = offset_in_folio(new_folio, jh_in->b_frozen_data);
> +		done_copy_out = 1;
>  	}
>  
>  	/*
> 


