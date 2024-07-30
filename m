Return-Path: <linux-ext4+bounces-3511-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D37940C29
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 10:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64022B27405
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 08:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BEDE190071;
	Tue, 30 Jul 2024 08:48:10 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350C515622E;
	Tue, 30 Jul 2024 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329290; cv=none; b=C8WATWK2dPaGCQXXDLfsVc0YXUAbdGnClDJp1D6/ph2YOj2V3S8XNREzAMDPF+MRU9WcIOgYsDoJiwCBuOTWbgOjN/kga9wHpKFZg3mBUOn/SVTVx3nFnI0L9fIHQoWBSmSWoqR3aES2gcqinq34ksXU2rJ9aIANDfCckxsZK0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329290; c=relaxed/simple;
	bh=lq1KcLg7657jrT1q/4bPk4dtfAmTaV99K1JJQT+YGd8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HtrtZXDr8BBz7TbudG4za0znys66gBsyC7GbykgDz7/ZUc5TUEhFBJKvgrAZRRD63f1kNf87AVNWq/00HLnFkRqr5Q20xodJwmSBv7mWgQeB6VJ1IgZlGTizx6Ry9uN/6SOnXWzvqz/zMBVpPQr9u8JiVVWKHu1Hc4Or/n7h1CI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WY84g3mxjz4f3jsD;
	Tue, 30 Jul 2024 16:47:47 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 5D91C1A162F;
	Tue, 30 Jul 2024 16:48:00 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4W8qKhmpa8TAQ--.10295S3;
	Tue, 30 Jul 2024 16:48:00 +0800 (CST)
Message-ID: <4147a862-df2c-457c-8ebd-4c04f121b93e@huaweicloud.com>
Date: Tue, 30 Jul 2024 16:47:56 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/20] ext4: fix double brelse() the buffer of the extents
 path
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 stable@kernel.org, Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-4-libaokun@huaweicloud.com>
 <ZqOMQ6cIHd0hZqhY@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <ZqOMQ6cIHd0hZqhY@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4W8qKhmpa8TAQ--.10295S3
X-Coremail-Antispam: 1UD129KBjvJXoW3WF1ruw15JrW8Ww47Kw4fuFg_yoWxJrWkpr
	sakFyxGryDt3y8KrWUJr4UJry0vw45Gw47JrWrG3WjyFyjyr4YqFyIg3W09FyUWrW8uF1Y
	qrW8try5uF1UGa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUd-B_UUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAQAABWaoo-wCIwAAs0

On 2024/7/26 19:45, Ojaswin Mujoo wrote:
> On Wed, Jul 10, 2024 at 12:06:37PM +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> In ext4_ext_try_to_merge_up(), set path[1].p_bh to NULL after it has been
>> released, otherwise it may be released twice.
>>
>> An example of what triggers this is as follows:
>>
>>    split2    map    split1
>> |--------|-------|--------|
>>
>> ext4_ext_map_blocks
>>   ext4_ext_handle_unwritten_extents
>>    ext4_split_convert_extents
>>     // path->p_depth == 0
>>     ext4_split_extent
>>       // 1. do split1
>>       ext4_split_extent_at
>>         ext4_ext_insert_extent
>>           ext4_ext_create_new_leaf
>>             ext4_ext_grow_indepth
>>               le16_add_cpu(&neh->eh_depth, 1)
>>             ext4_find_extent
>>               path->p_depth = 1
>>           ext4_ext_try_to_merge
>>             ext4_ext_try_to_merge_up
>>               path->p_depth = 0
>>               brelse(path[1].p_bh)  ---> not set to NULL here
>>       // 2. update path
>>       ext4_find_extent
>>       // 3. do split2
>>       ext4_split_extent_at
>>         ext4_ext_insert_extent
>>           ext4_ext_create_new_leaf
>>             ext4_ext_grow_indepth
>>               le16_add_cpu(&neh->eh_depth, 1)
>>             ext4_find_extent
>>               path[0].p_bh = NULL;
>>               path->p_depth = 1
>>               read_extent_tree_block  ---> return err
>>               // path[1].p_bh is still the old value
>>   ext4_free_ext_path
>>    ext4_ext_drop_refs
>>     // path->p_depth == 1
>>     brelse(path[1].p_bh)  ---> brelse a buffer twice
> Hi Baokun,
>
> If i'm not wrong, in this trace, we'll enter ext4_ext_insert_extent() with
> gb_flags having EXT4_GET_BLOCKS_PRE_IO so we won't actually go for a
> merge_up.
>
> That being said, there seems to be a few places where we follow the
> split-insert pattern and it might be possible that one of those call
> sites might not be passing EXT4_GET_BLOCKS_PRE_IO and we'll the double
> free issue you mentioned. I'll check and update if I see anything.
Hi Ojaswin,

You're right. I am very sorry for the confusion.

The trace here is wrong, this patch should actually be placed after the two
UAF patches. Here ext4_ext_try_to_merge() is called when trying zeroout in
ext4_split_extent_at(). It is called when trying zeroout with or without
EXT4_GET_BLOCKS_PRE_IO.The correct trace is as follows:

   split2    map    split1
|--------|-------|--------|

ext4_ext_map_blocks
  ext4_ext_handle_unwritten_extents
   ext4_split_convert_extents
    // path->p_depth == 0
    ext4_split_extent
      // 1. do split1
      ext4_split_extent_at
        |ext4_ext_insert_extent
        |  ext4_ext_create_new_leaf
        |    ext4_ext_grow_indepth
        |      le16_add_cpu(&neh->eh_depth, 1)
        |    ext4_find_extent
        |      // return -ENOMEM
        |// get error and try zeroout
        |path = ext4_find_extent
        |  path->p_depth = 1
        |ext4_ext_try_to_merge
        |  ext4_ext_try_to_merge_up
        |    path->p_depth = 0
        |    brelse(path[1].p_bh)  ---> not set to NULL here
        |// zeroout success
      // 2. update path
      ext4_find_extent
      // 3. do split2
      ext4_split_extent_at
        ext4_ext_insert_extent
          ext4_ext_create_new_leaf
            ext4_ext_grow_indepth
              le16_add_cpu(&neh->eh_depth, 1)
            ext4_find_extent
              path[0].p_bh = NULL;
              path->p_depth = 1
              read_extent_tree_block  ---> return err
              // path[1].p_bh is still the old value
  ext4_free_ext_path
   ext4_ext_drop_refs
    // path->p_depth == 1
    brelse(path[1].p_bh)  ---> brelse a buffer twice

I'll adjust the order of the patches and correct the trace in the next 
version.
> On a separate note, isn't it a bit weird that we grow the tree indepth
> (which includes allocation, marking buffer dirty etc) only to later
> merge it up again and throwing all the changes we did while growing the
> tree. Surely we could optimize this particular case somehow right?
Sorry that my trace misled you. It seems reasonable to try to merge extent
in error handling.
>> Finally got the following WARRNING when removing the buffer from lru:
>>
>> ============================================
>> VFS: brelse: Trying to free free buffer
>> WARNING: CPU: 2 PID: 72 at fs/buffer.c:1241 __brelse+0x58/0x90
>> CPU: 2 PID: 72 Comm: kworker/u19:1 Not tainted 6.9.0-dirty #716
>> RIP: 0010:__brelse+0x58/0x90
>> Call Trace:
>>   <TASK>
>>   __find_get_block+0x6e7/0x810
>>   bdev_getblk+0x2b/0x480
>>   __ext4_get_inode_loc+0x48a/0x1240
>>   ext4_get_inode_loc+0xb2/0x150
>>   ext4_reserve_inode_write+0xb7/0x230
>>   __ext4_mark_inode_dirty+0x144/0x6a0
>>   ext4_ext_insert_extent+0x9c8/0x3230
>>   ext4_ext_map_blocks+0xf45/0x2dc0
>>   ext4_map_blocks+0x724/0x1700
>>   ext4_do_writepages+0x12d6/0x2a70
>> [...]
>> ============================================
>>
>> Fixes: ecb94f5fdf4b ("ext4: collapse a single extent tree block into the inode if possible")
>> Cc: stable@kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/extents.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 4d589d34b30e..657baf3991c1 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -1888,6 +1888,7 @@ static void ext4_ext_try_to_merge_up(handle_t *handle,
>>   	path[0].p_hdr->eh_max = cpu_to_le16(max_root);
>>   
>>   	brelse(path[1].p_bh);
>> +	path[1].p_bh = NULL;
> Anyways, I agree that adding this here is the right thing to do:
>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>
> Thanks,
> Ojaswin
Thanks for the review!
>>   	ext4_free_blocks(handle, inode, NULL, blk, 1,
>>   			 EXT4_FREE_BLOCKS_METADATA | EXT4_FREE_BLOCKS_FORGET);
>>   }
>> -- 
>> 2.39.2
>>
-- 
With Best Regards,
Baokun Li


