Return-Path: <linux-ext4+bounces-5834-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C409E9F9F15
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2024 08:35:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35CF116BCF6
	for <lists+linux-ext4@lfdr.de>; Sat, 21 Dec 2024 07:35:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07161EBFE4;
	Sat, 21 Dec 2024 07:34:56 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80791DEFD6;
	Sat, 21 Dec 2024 07:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734766496; cv=none; b=W4UT9FBrzq70EOMPAfhw1iT2YU8e+tLYfG7vlvg1XPJsPqjPtzmvw6xE/S5okKR6C9N1g5YR3rrpBQtUA2B60EHLn/ZHViD0Wlnkp7xc+S3J0SGkVNJpERimW/a7zQwBmYeocgSGZKFnf4/ewxzMwFr1iVuQoPXYQs8sBkdqCq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734766496; c=relaxed/simple;
	bh=HEkjc+B7PaNE7zt7uDx5owEzAMUWRrF0yd/+sYEwVyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rIKuoaEueTexMbVMn8zuFVvi3riyCy/rCADGj/KHcJvJFj39pFO26MmjmYRcSa6evEtwR8lbvl0FzFdLtL3I82jsZXONVidoTlphSyyqj5//CrukvOzojuak+uNkjVvnZEiaoRwoPYX3dmEaApj8LBtQuuGiP90X5omhlFq1wGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=none smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4YFbdl6kPqz4f3jqr;
	Sat, 21 Dec 2024 15:34:35 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 7677B1A018D;
	Sat, 21 Dec 2024 15:34:50 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCngYWZb2ZnyXzWFA--.10328S3;
	Sat, 21 Dec 2024 15:34:50 +0800 (CST)
Message-ID: <89727a60-89f4-4ebd-8113-ea5e64729f24@huaweicloud.com>
Date: Sat, 21 Dec 2024 15:34:49 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] ext4: remove unneeded forward declaration in namei.c
To: Kemeng Shi <shikemeng@huaweicloud.com>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, tytso@mit.edu,
 adilger.kernel@dilger.ca
References: <20241219110027.1440876-1-shikemeng@huaweicloud.com>
 <20241219110027.1440876-4-shikemeng@huaweicloud.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241219110027.1440876-4-shikemeng@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCngYWZb2ZnyXzWFA--.10328S3
X-Coremail-Antispam: 1UD129KBjvJXoW7Cw1ktrWfWw1fJr15WF1fCrg_yoW8KFW5pF
	4fJ3W5Kr48XF1DuFW0vw48Ar4S9w1vgry7Jr47G34rKF9rtw1SgFnrJr4IyF9Yyry8WF13
	AFs8KFy5Ga1vq3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkq14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7VUbhvttUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/12/19 19:00, Kemeng Shi wrote:
> Remove unneeded forward declaration in namei.c
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>

Looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

> ---
>  fs/ext4/namei.c | 30 ------------------------------
>  1 file changed, 30 deletions(-)
> 
> diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> index 8ff840ef4730..33670cebdedc 100644
> --- a/fs/ext4/namei.c
> +++ b/fs/ext4/namei.c
> @@ -291,36 +291,6 @@ struct dx_tail {
>  	__le32 dt_checksum;	/* crc32c(uuid+inum+dirblock) */
>  };
>  
> -static inline ext4_lblk_t dx_get_block(struct dx_entry *entry);
> -static void dx_set_block(struct dx_entry *entry, ext4_lblk_t value);
> -static inline unsigned dx_get_hash(struct dx_entry *entry);
> -static void dx_set_hash(struct dx_entry *entry, unsigned value);
> -static unsigned dx_get_count(struct dx_entry *entries);
> -static unsigned dx_get_limit(struct dx_entry *entries);
> -static void dx_set_count(struct dx_entry *entries, unsigned value);
> -static void dx_set_limit(struct dx_entry *entries, unsigned value);
> -static unsigned dx_root_limit(struct inode *dir, unsigned infosize);
> -static unsigned dx_node_limit(struct inode *dir);
> -static struct dx_frame *dx_probe(struct ext4_filename *fname,
> -				 struct inode *dir,
> -				 struct dx_hash_info *hinfo,
> -				 struct dx_frame *frame);
> -static void dx_release(struct dx_frame *frames);
> -static int dx_make_map(struct inode *dir, struct buffer_head *bh,
> -		       struct dx_hash_info *hinfo,
> -		       struct dx_map_entry *map_tail);
> -static void dx_sort_map(struct dx_map_entry *map, unsigned count);
> -static struct ext4_dir_entry_2 *dx_move_dirents(struct inode *dir, char *from,
> -					char *to, struct dx_map_entry *offsets,
> -					int count, unsigned int blocksize);
> -static struct ext4_dir_entry_2 *dx_pack_dirents(struct inode *dir, char *base,
> -						unsigned int blocksize);
> -static void dx_insert_block(struct dx_frame *frame,
> -					u32 hash, ext4_lblk_t block);
> -static int ext4_htree_next_block(struct inode *dir, __u32 hash,
> -				 struct dx_frame *frame,
> -				 struct dx_frame *frames,
> -				 __u32 *start_hash);
>  static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
>  		struct ext4_filename *fname,
>  		struct ext4_dir_entry_2 **res_dir);


