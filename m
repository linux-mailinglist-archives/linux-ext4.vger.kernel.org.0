Return-Path: <linux-ext4+bounces-3266-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06D7931453
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 14:33:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8CF2818A7
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Jul 2024 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2125D18C322;
	Mon, 15 Jul 2024 12:33:40 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 267BA13BAC2;
	Mon, 15 Jul 2024 12:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721046819; cv=none; b=oq1N4/qj/4T/mbAEN56R6i/gNEvjtKydj/FRw1Lwl9e9ASVwfW73nGZU4P9h2qJlGsWkMwQyooHfvEJefu3WRMOM74uSLLc0Dx6xXfA6MtlMShmM2+abM22P/hxqYZE/CXmleu594QnagBVBcHyUYNiYVbR9De3tApPW0cyuYkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721046819; c=relaxed/simple;
	bh=pP6FPHjwBqkW3b6x322CUQERo2dxfvmbsq+dd+YcB8k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dJ3m6+yA0doIjSje5zXT35oxKkPYuzCoF2SNpU/LRUHAs9wfQVKdPFSDZtxFTw1tGOQ8QwvoAT2AdDnmPofNgbzdk8VXlwaPmFrtTFkzskb/NcZc8VCV7HnIFXJJKDbVj08UiWHPsftJMshug185DXg2bCeQLRiOEtnAy9CNffU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WN1nr0w1sz4f3n5g;
	Mon, 15 Jul 2024 20:33:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3DD031A058E;
	Mon, 15 Jul 2024 20:33:33 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgDXuTcXF5VmE+HPAA--.40070S3;
	Mon, 15 Jul 2024 20:33:31 +0800 (CST)
Message-ID: <9fd554c7-dc0c-4969-9f2a-1c99356fccce@huaweicloud.com>
Date: Mon, 15 Jul 2024 20:33:27 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/20] ext4: prevent partial update of the extents path
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 zhanchengbin <zhanchengbin1@huawei.com>, Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-3-libaokun@huaweicloud.com>
 <ZpPx3kuO36lp9/Um@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <ZpPx3kuO36lp9/Um@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgDXuTcXF5VmE+HPAA--.40070S3
X-Coremail-Antispam: 1UD129KBjvJXoWxKrWUAF4rGrykWF1ruFyfJFb_yoW7tw1fpr
	9akrnxCr4jg3W3uFZrtF4UJry2k3WrJ3yxtrZ2kryfXFy5ZrySqryxK3WrCF95ArWkWayY
	qrW8tw1DKr1DKFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
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
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAFBWaU3hQTkQABs5

Hi Ojaswin!

On 2024/7/14 23:42, Ojaswin Mujoo wrote:
> On Wed, Jul 10, 2024 at 12:06:36PM +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> In ext4_ext_rm_idx() and ext4_ext_correct_indexes(), there is no proper
>> rollback of already executed updates when updating a level of the extents
>> path fails, so we may get an inconsistent extents tree, which may trigger
>> some bad things in errors=continue mode.
>>
>> Hence clear the verified bit of modified extents buffers if the tree fails
>> to be updated in ext4_ext_rm_idx() or ext4_ext_correct_indexes(), which
>> forces the extents buffers to be checked in ext4_valid_extent_entries(),
>> ensuring that the extents tree is consistent.
>>
>> Signed-off-by: zhanchengbin <zhanchengbin1@huawei.com>
>> Link: https://lore.kernel.org/r/20230213080514.535568-3-zhanchengbin1@huawei.com/
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/extents.c | 31 +++++++++++++++++++++++++++----
>>   1 file changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index bff3666c891a..4d589d34b30e 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -1749,12 +1749,23 @@ static int ext4_ext_correct_indexes(handle_t *handle, struct inode *inode,
>>        break;
>>      err = ext4_ext_get_access(handle, inode, path + k);
>>      if (err)
>> -     break;
>> +     goto clean;
>>      path[k].p_idx->ei_block = border;
>>      err = ext4_ext_dirty(handle, inode, path + k);
>>      if (err)
>> -     break;
>> +     goto clean;
>>    }
>> + return 0;
>> +
>> +clean:
>> + /*
>> +  * The path[k].p_bh is either unmodified or with no verified bit
>> +  * set (see ext4_ext_get_access()). So just clear the verified bit
>> +  * of the successfully modified extents buffers, which will force
>> +  * these extents to be checked to avoid using inconsistent data.
>> +  */
>> + while (++k < depth)
>> +   clear_buffer_verified(path[k].p_bh);
>>   
>>    return err;
>>   }
>> @@ -2312,12 +2323,24 @@ static int ext4_ext_rm_idx(handle_t *handle, struct inode *inode,
>>        break;
>>      err = ext4_ext_get_access(handle, inode, path + k);
>>      if (err)
>> -     break;
>> +     goto clean;
>>      path[k].p_idx->ei_block = path[k + 1].p_idx->ei_block;
>>      err = ext4_ext_dirty(handle, inode, path + k);
>>      if (err)
>> -     break;
>> +     goto clean;
>>    }
>> + return 0;
>> +
>> +clean:
>> + /*
>> +  * The path[k].p_bh is either unmodified or with no verified bit
>> +  * set (see ext4_ext_get_access()). So just clear the verified bit
>> +  * of the successfully modified extents buffers, which will force
>> +  * these extents to be checked to avoid using inconsistent data.
>> +  */
>> + while (++k < depth)
>> +   clear_buffer_verified(path[k].p_bh);
>> +
>>    return err;
>>   }
> Hi Baokun,
>
> So I wanted to understand the extent handling paths for a whil and thought this
> patchset was a good chance to finally take sometime and do that.
>
> I do have a question based on my understanding of this extent deletion code:
>
> So IIUC, ext4_find_extent() will return a path where buffer of each node is
> verified (via bh = read_extent_tree_block()). So imagine we have the following
> path (d=depth, blk=idx.ei_block, v=verified, nv=not-verified):
>
> +------+     +------+     +------+     +------+     +------+
> |d=0   |     |d=1   |     |d=2   |     |d=3   |     |      |
> |blk=1 | --> |blk=1 | --> |blk=1 | --> |blk=1 | --> |pblk=1|
> |(v)   |     |(v)   |     |(v)   |     |(v)   |     |      |
> +------+     +------+     +------+     +------+     +------+
>                                         |d=3   |     +------+
>                                         |blk=2 | --> |      |
>                                         |(v)   |     |pblk=2|
>                                         +------+     |      |
>                                                      +------+
>
> Here, the the last column are the leaf nodes with only 1 extent in them.  Now,
> say we want to punch the leaf having pblk=1. We'll eventually call
> ext4_ext_rm_leaf() -> ext4_ext_rm_idx() to remove the index at depth = 3 and
> try fixin up the indices in path with ei_block = 2
>
> Suppose we error out at depth == 1. After the cleanup (introduced in this
> patch), we'll mark depth = 1 to 4 as non verified:
>
> +------+     +------+     +------+     +------+     +------+
> |d=0   |     |d=1   |     |d=2   |     |d=3   |     |      |
> |blk=1 | --> |blk=1 | --> |blk=2 | --> |blk=2 | --> |pblk=2|
> |(v)   |     |(nv)  |     |(nv)  |     |(nv)  |     |(nv)  |
> +------+     +------+     +------+     +------+     +------+
Exactly right!
>
> And we return and we won't actually mark the FS corrupt until we try to check
> the bh at depth = 1 above. In this case, the first node is still pointing to
> wrong ei_block but is marked valid. Aren't we silently leaving the tree in an
> inconsistent state which might lead to corrupted lookups until we actually
> touch the affected bh and realise that there's a corruption.
>
> Am I missing some codepath here? Should we maybe try to clear_valid for the
> whole tree?
>
> (I hope the formatting of diagram comes out correct :) )
>
> Regards,
> ojaswin
But the journal will ensure the consistency of the extents path after
this patch.

When ext4_ext_get_access() or ext4_ext_dirty() returns an error in
ext4_ext_rm_idx() and ext4_ext_correct_indexes(), this may cause
the extents tree to be inconsistent. But the inconsistency just
exists in memory and doesn't land on disk.

For ext4_ext_get_access(), the handle must have been aborted
when it returned an error, as follows:

ext4_ext_get_access
ext4_journal_get_write_access
__ext4_journal_get_write_access
err = jbd2_journal_get_write_access
if (err)
ext4_journal_abort_handle

For ext4_ext_dirty(), since path->p_bh must not be null and handle
must be valid, handle is aborted anyway when an error is returned:

ext4_ext_dirty __ext4_ext_dirty if (path->p_bh) 
__ext4_handle_dirty_metadata if (ext4_handle_valid(handle)) err = 
jbd2_journal_dirty_metadata if (!is_handle_aborted(handle) && 
WARN_ON_ONCE(err)) ext4_journal_abort_handle
Thus the extents tree will only be inconsistent in memory, so only
the verified bit of the modified buffer needs to be cleared to avoid
these inconsistent data being used in memory.

Regards,
Baokun


