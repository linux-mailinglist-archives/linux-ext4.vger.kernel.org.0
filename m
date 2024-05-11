Return-Path: <linux-ext4+bounces-2454-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CECF8C2FD2
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2024 08:24:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99CEBB23037
	for <lists+linux-ext4@lfdr.de>; Sat, 11 May 2024 06:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D1824F5FE;
	Sat, 11 May 2024 06:24:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0A34F215;
	Sat, 11 May 2024 06:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715408667; cv=none; b=NMA4j2ugwxnPFmdV+vlIZz1YLAAgyD7leDGgQZhJvOGeUBmBhPFqmkTK0bPoiSytfKRzA8GWe3FJZIc6S+MDMNzB4M+hQZ7fRUsSrL7tOf5LJClLNQvrBOA81K5uz8MA7Vz79dZ2XUy6LL0vLI1nJ/kSjpwJ2FCjscwqFegv+rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715408667; c=relaxed/simple;
	bh=5xv07f5Ibu51HbaqexyG2XEUvbwQjsn0EnRz/MNOTuw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=Bg2JnbBZBicJJ+CMYKhXpOBjsZ7YGXwXd3UpBKO9WWzmaNcvoALRBZOQhA2iuSEOYFLQvYkUUMmneseSA9JBGRHPxh3l2YmxjzW+L7Am3kY52xzqLmFr7ou4z8N6EiTRCGn5AQr8ZfDgvU+cNDs8/XEHfZWiyMa3eWk9UhL0kIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Vbwgy0npsz4f3jJ6;
	Sat, 11 May 2024 14:24:14 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 812051A0572;
	Sat, 11 May 2024 14:24:19 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgBXfA8RDz9md1mUMg--.18691S3;
	Sat, 11 May 2024 14:24:19 +0800 (CST)
Subject: Re: [PATCH] ext4: fix infinite loop when replaying fast_commit
To: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
 Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20240510115252.11850-1-luis.henriques@linux.dev>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <2ee78957-b0a6-f346-5957-c4b2ebcea4ce@huaweicloud.com>
Date: Sat, 11 May 2024 14:24:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240510115252.11850-1-luis.henriques@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgBXfA8RDz9md1mUMg--.18691S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw13JFyrAFW5Zw48XF43Wrg_yoW5uFy8pF
	9Ivr1DGrs8Way0kay7Gw4UZF1Yka1xC3y7GryfGr1rGF98Jrn3ZF18tFyakas3WrW8J3WY
	vF40y34jkanIkaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/10 19:52, Luis Henriques (SUSE) wrote:
> When doing fast_commit replay an infinite loop may occur due to an
> uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
> not detect the replay and calls ext4_es_find_extent_range(), which will
> return immediately without initializing the 'es' variable.
> 
> Because 'es' contains garbage, an integer overflow may happen causing an
> infinite loop in this function, easily reproducible using fstest generic/039.
> 
> This commit fixes this issue by detecting the replay in function
> ext4_ext_determine_insert_hole().  It also adds initialization code to the
> error path in function ext4_es_find_extent_range().
> 
> Thanks to Zhang Yi, for figuring out the real problem!
> 
> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
> ---
> Hi!
> 
> Two comments:
> 1) The change in ext4_ext_map_blocks() could probably use the min_not_zero
>    macro instead.  I decided not to do so simply because I wasn't sure if
>    that would be safe, but I'm fine changing that if you think it is.
> 
> 2) I thought about returning 'EXT_MAX_BLOCKS' instead of '0' in
>    ext4_lblk_t ext4_ext_determine_insert_hole(), which would then avoid
>    the extra change to ext4_ext_map_blocks().  '0' sounds like the right
>    value to return, but I'm also OK using 'EXT_MAX_BLOCKS' instead.
> 
> And again thanks to Zhang Yi for pointing me the *real* problem!
> 
>  fs/ext4/extents.c        | 6 +++++-
>  fs/ext4/extents_status.c | 5 ++++-
>  2 files changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
> index e57054bdc5fd..b5bfcb6c18a0 100644
> --- a/fs/ext4/extents.c
> +++ b/fs/ext4/extents.c
> @@ -4052,6 +4052,9 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
>  	ext4_lblk_t hole_start, len;
>  	struct extent_status es;
>  
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +		return 0;
> +

Sorry, I think it's may not correct. When replaying the jouranl, although
we don't use the extent statue tree, we still need to query the accurate
hole length, e.g. please see skip_hole(). If you do this, the hole length
becomes incorrect, right?

Thanks,
Yi.

>  	hole_start = lblk;
>  	len = ext4_ext_find_hole(inode, path, &hole_start);
>  again:
> @@ -4226,7 +4229,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>  		len = ext4_ext_determine_insert_hole(inode, path, map->m_lblk);
>  
>  		map->m_pblk = 0;
> -		map->m_len = min_t(unsigned int, map->m_len, len);
> +		if (len > 0)
> +			map->m_len = min_t(unsigned int, map->m_len, len);
>  		goto out;
>  	}
>  
> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
> index 4a00e2f019d9..acb9616ca119 100644
> --- a/fs/ext4/extents_status.c
> +++ b/fs/ext4/extents_status.c
> @@ -310,8 +310,11 @@ void ext4_es_find_extent_range(struct inode *inode,
>  			       ext4_lblk_t lblk, ext4_lblk_t end,
>  			       struct extent_status *es)
>  {
> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) {
> +		/* Initialize extent to zero */
> +		es->es_lblk = es->es_len = es->es_pblk = 0;
>  		return;
> +	}
>  
>  	trace_ext4_es_find_extent_range_enter(inode, lblk);
>  
> 


