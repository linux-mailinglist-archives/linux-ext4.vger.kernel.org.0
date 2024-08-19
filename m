Return-Path: <linux-ext4+bounces-3776-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6F76956AE9
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 14:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8419E281106
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 12:31:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 671D016A920;
	Mon, 19 Aug 2024 12:31:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3211D696;
	Mon, 19 Aug 2024 12:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724070696; cv=none; b=O/k+MPrH0G1SqXjOTOLX832Gf1VJ5ZHdn/UJ103RZ8WjFQ2CJA6a8Gi6c0KMzl4mBxzaQDIs22CXcSGnKNUVrpd3Ll78NAYCYt8t95bO73F3hMyaimY7qATTCTm63bse0r+hnxKTLU18qh4NDFmEQEIKd3yVKGTZWpcCOMMW7VQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724070696; c=relaxed/simple;
	bh=jiHI89cr2OtZ0yqVDeBtuyKUDHchFNjLsFYBla3XE9M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=PAQ0EW11ERleAw+T9HFIinbjl/TCtZgwwXg5Tk5wQRxTkUp6FWmuzFFcqfHONBcq/7DJvrrJCUNzSGp+JsfIQYj61rSmQuTJSfAGrHaJ5xoxMhCCpaep4/m7FhptcUVhJQ0EX/cAS9w77orLMZTaUBF6/feyHRUG28KEgu86swo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WnX5F30M1z4f3nT6;
	Mon, 19 Aug 2024 20:31:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 6687F1A1350;
	Mon, 19 Aug 2024 20:31:28 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgAnmoAeO8NmSeSDCA--.18470S2;
	Mon, 19 Aug 2024 20:31:28 +0800 (CST)
Subject: Re: [PATCH 1/2] ext4: Check stripe size compatibility on remount as
 well
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>, linux-ext4@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, linux-kernel@vger.kernel.org,
 syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
References: <957d29b85e06f415ee125de141809d2b9e084003.1723794770.git.ojaswin@linux.ibm.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <2475f15a-d332-bef1-4ea6-70461f7ef3bb@huaweicloud.com>
Date: Mon, 19 Aug 2024 20:31:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <957d29b85e06f415ee125de141809d2b9e084003.1723794770.git.ojaswin@linux.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgAnmoAeO8NmSeSDCA--.18470S2
X-Coremail-Antispam: 1UD129KBjvJXoWxXF4UZFW5WF17uF48Cr1Utrb_yoW5urWfpr
	ySk3W5KrWUWFnF9a17Xr4rXrySg3yxuFWUJ3yxGryUuFyDtFWxGr92q3Z09Fy2grW8WryS
	qFZ0934xur1DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7
	UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 8/16/2024 3:57 PM, Ojaswin Mujoo wrote:
> We disable stripe size in __ext4_fill_super if it is not a multiple of
> the cluster ratio however this check is missed when trying to remount.
> This can leave us with cases where stripe < cluster_ratio after
> remount:set making EXT4_B2C(sbi->s_stripe) become 0 that can cause some
> unforeseen bugs like divide by 0.
> 
> Fix that by adding the check in remount path as well.
> 
> Additionally, change the users of EXT4_B2C(sbi->s_stripe) to
> EXT4_NUM_B2C() so that if we ever accidentally hit this again, we can
> avoid the value becoming 0. This should not change existing functionality.
It's better to mention this change is in following patch or simply remove
it from this patch.

Other than that, looks good to me. Feel free to add:

Reviewed-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Reported-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
> Tested-by: syzbot+1ad8bac5af24d01e2cbd@syzkaller.appspotmail.com
> Fixes: c3defd99d58c ("ext4: treat stripe in block unit")
> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> ---
>  fs/ext4/super.c | 29 ++++++++++++++++++++++-------
>  1 file changed, 22 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> index e72145c4ae5a..9d495d78d262 100644
> --- a/fs/ext4/super.c
> +++ b/fs/ext4/super.c
> @@ -5165,6 +5165,18 @@ static int ext4_block_group_meta_init(struct super_block *sb, int silent)
>  	return 0;
>  }
>  
> +/*
> + * It's hard to get stripe aligned blocks if stripe is not aligned with
> + * cluster, just disable stripe and alert user to simpfy code and avoid
> + * stripe aligned allocation which will rarely successes.
> + */
> +static bool ext4_is_stripe_incompatible(struct super_block *sb, unsigned long stripe)
> +{
> +	struct ext4_sb_info *sbi = EXT4_SB(sb);
> +	return (stripe > 0 && sbi->s_cluster_ratio > 1 &&
> +		stripe % sbi->s_cluster_ratio != 0);
> +}
> +
>  static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  {
>  	struct ext4_super_block *es = NULL;
> @@ -5272,13 +5284,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
>  		goto failed_mount3;
>  
>  	sbi->s_stripe = ext4_get_stripe_size(sbi);
> -	/*
> -	 * It's hard to get stripe aligned blocks if stripe is not aligned with
> -	 * cluster, just disable stripe and alert user to simpfy code and avoid
> -	 * stripe aligned allocation which will rarely successes.
> -	 */
> -	if (sbi->s_stripe > 0 && sbi->s_cluster_ratio > 1 &&
> -	    sbi->s_stripe % sbi->s_cluster_ratio != 0) {
> +	if (ext4_is_stripe_incompatible(sb, sbi->s_stripe)) {
>  		ext4_msg(sb, KERN_WARNING,
>  			 "stripe (%lu) is not aligned with cluster size (%u), "
>  			 "stripe is disabled",
> @@ -6441,6 +6447,15 @@ static int __ext4_remount(struct fs_context *fc, struct super_block *sb)
>  
>  	}
>  
> +	if ((ctx->spec & EXT4_SPEC_s_stripe) &&
> +	    ext4_is_stripe_incompatible(sb, ctx->s_stripe)) {
> +		ext4_msg(sb, KERN_WARNING,
> +			 "stripe (%lu) is not aligned with cluster size (%u), "
> +			 "stripe is disabled",
> +			 ctx->s_stripe, sbi->s_cluster_ratio);
> +		ctx->s_stripe = 0;
> +	}
> +
>  	/*
>  	 * Changing the DIOREAD_NOLOCK or DELALLOC mount options may cause
>  	 * two calls to ext4_should_dioread_nolock() to return inconsistent
> 


