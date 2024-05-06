Return-Path: <linux-ext4+bounces-2301-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 735C18BC4F8
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 02:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE5631C209AF
	for <lists+linux-ext4@lfdr.de>; Mon,  6 May 2024 00:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D59133B781;
	Mon,  6 May 2024 00:59:30 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197EB38F91
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 00:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714957170; cv=none; b=Af5rMmLOBXne/078U/8pI3iAYww0D/IcM6I+DM/rxHAtPAuQGEWTgL3LnqrnUbesHsCoDaFusdndSNmsc8zI2bTjrxK9y9wKvj4FrcDU26ja+iBOBXF+TlfL63/8SBAigVrRYpoScyyOPfiTWMl81uhKIXXzV8rvoS26oVZVHw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714957170; c=relaxed/simple;
	bh=k1QUYHjTwg9ScrGUxfSE1dgf3CKWDUZ4xyW0gZeKzkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmi5li2c6t2/g32Kf2pNlpD/EiiOCbhNW3tBcjWxoPC174lTa3LTYSfiW0XIdFcAe5ChdloHU9GEJFGB7hGVtBW/+pO7z21++UKuwRcqCAKzeqm4Y38djQQoh+5NQ8gl3Cza89MT6mk+jnpGLj2oUZnav5CYyCVsPF3m69fu+xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VXjjF4fnRz4f3kjc
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 08:59:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id E10A11A0D91
	for <linux-ext4@vger.kernel.org>; Mon,  6 May 2024 08:59:18 +0800 (CST)
Received: from [10.174.177.210] (unknown [10.174.177.210])
	by APP1 (Coremail) with SMTP id cCh0CgCXaBFlKzhmjcF_Lw--.27978S3;
	Mon, 06 May 2024 08:59:18 +0800 (CST)
Message-ID: <dedf5caf-4ced-0a7d-ca3a-e0f68b59043a@huaweicloud.com>
Date: Mon, 6 May 2024 08:59:17 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] ext4: clear EXT4_GROUP_INFO_WAS_TRIMMED_BIT even mount
 with discard
To: yangerkun <yangerkun@huawei.com>, Jan Kara <jack@suse.cz>,
 "Theodore Y . Ts'o" <tytso@mit.edu>
Cc: adilger.kernel@dilger.ca, boyu.mt@taobao.com, linux-ext4@vger.kernel.org
References: <20231230070654.178638-1-yangerkun@huaweicloud.com>
 <20240221111852.olo7jeycctz7xntj@quack3>
 <7953c617-2f74-faa4-2aa4-c6ef9de2c28e@huawei.com>
From: yangerkun <yangerkun@huaweicloud.com>
In-Reply-To: <7953c617-2f74-faa4-2aa4-c6ef9de2c28e@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgCXaBFlKzhmjcF_Lw--.27978S3
X-Coremail-Antispam: 1UD129KBjvJXoWxXr4kuw4rtry5Aw1kJr1DZFb_yoW5Zryfpr
	1ktF1jyry5Xr109r4jqr1jqFy8tw4UJw1UXr1UXF48JrZrtr1agr17Xr1j9ryUJF48Jr1U
	XF15Xry3ZF1UArDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: 51dqwvhunx0q5kxd4v5lfo033gof0z/

Hi, Ted,

Ping again...

在 2024/3/30 16:04, yangerkun 写道:
> Hi, Ted,
> 
> Ping for this patch.
> 
> 
> 在 2024/2/21 19:18, Jan Kara 写道:
>> On Sat 30-12-23 15:06:54, yangerkun wrote:
>>> Commit 3d56b8d2c74c ("ext4: Speed up FITRIM by recording flags in
>>> ext4_group_info") speed up fstrim by skipping trim trimmed group. We
>>> also has the chance to clear trimmed once there exists some block free
>>> for this group(mount without discard), and the next trim for this group
>>> will work well too.
>>>
>>> For mount with discard, we will issue dicard when we free blocks, so
>>> leave trimmed flag keep alive to skip useless trim trigger from
>>> userspace seems reasonable. But for some case like ext4 build on
>>> dm-thinpool(ext4 blocksize 4K, pool blocksize 128K), discard from ext4
>>> maybe unaligned for dm thinpool, and thinpool will just finish this
>>> discard(see process_discard_bio when begein equals to end) without
>>> actually process discard. For this case, trim from userspace can really
>>> help us to free some thinpool block.
>>>
>>> So convert to clear trimmed flag for all case no matter mounted with
>>> discard or not.
>>>
>>> Fixes: 3d56b8d2c74c ("ext4: Speed up FITRIM by recording flags in 
>>> ext4_group_info")
>>> Signed-off-by: yangerkun <yangerkun@huaweicloud.com>
>>
>> Thanks for the fix. It looks good. Feel free to add:
>>
>> Reviewed-by: Jan Kara <jack@suse.cz>
>>
>>                                 Honza
>>
>>> ---
>>>   fs/ext4/mballoc.c | 10 ++++------
>>>   1 file changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>> index d72b5e3c92ec..69240ae775f1 100644
>>> --- a/fs/ext4/mballoc.c
>>> +++ b/fs/ext4/mballoc.c
>>> @@ -3855,11 +3855,8 @@ static void ext4_free_data_in_buddy(struct 
>>> super_block *sb,
>>>       /*
>>>        * Clear the trimmed flag for the group so that the next
>>>        * ext4_trim_fs can trim it.
>>> -     * If the volume is mounted with -o discard, online discard
>>> -     * is supported and the free blocks will be trimmed online.
>>>        */
>>> -    if (!test_opt(sb, DISCARD))
>>> -        EXT4_MB_GRP_CLEAR_TRIMMED(db);
>>> +    EXT4_MB_GRP_CLEAR_TRIMMED(db);
>>>       if (!db->bb_free_root.rb_node) {
>>>           /* No more items in the per group rb tree
>>> @@ -6481,8 +6478,9 @@ static void ext4_mb_clear_bb(handle_t *handle, 
>>> struct inode *inode,
>>>                        " group:%u block:%d count:%lu failed"
>>>                        " with %d", block_group, bit, count,
>>>                        err);
>>> -        } else
>>> -            EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
>>> +        }
>>> +
>>> +        EXT4_MB_GRP_CLEAR_TRIMMED(e4b.bd_info);
>>>           ext4_lock_group(sb, block_group);
>>>           mb_free_blocks(inode, &e4b, bit, count_clusters);
>>> -- 
>>> 2.39.2
>>>
>>>


