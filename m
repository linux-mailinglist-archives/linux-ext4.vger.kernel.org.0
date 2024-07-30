Return-Path: <linux-ext4+bounces-3512-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78E23940C78
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 10:58:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9AA4B1C23F0A
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 08:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFF581946A5;
	Tue, 30 Jul 2024 08:57:44 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AF96194158;
	Tue, 30 Jul 2024 08:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722329864; cv=none; b=sUoaQwGFJIsWeKnhIYNSixNUDX+2CyxFCUAUcDIL/d/kFdPIxPXDUxPpYaZbYrXH0QdONEY2KDe6e4GcQT15HD3gvHJCWgvce784727ZKTCcxJV96IopwMZ9htPz5GMBuVu8Mcm5i1fcP/ONttGUune2WI/bZ9h0Av8QpvkrDDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722329864; c=relaxed/simple;
	bh=kH7qY9oF3vk39PrIT6eusZykGR6LUc8X4VdZu4qu+DY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=si1W0fATl7hNs2pM3G2EBwd6yBblh3q6bfWWOgvXPMC76zDRMRpNdaS+Xvhq2QWxyEp5ik45x7hRo8948Tk8FkRiW8nPR7ga2N6U1jnlVmRiDSVX2DqUq3eLLM+eDHJmb7MI90z+p+k1O8GXHVE5P2whvbwS5GslGEJKsa3cDdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WY8Hs6bK9z4f3k5c;
	Tue, 30 Jul 2024 16:57:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 885A41A058E;
	Tue, 30 Jul 2024 16:57:38 +0800 (CST)
Received: from [10.174.177.174] (unknown [10.174.177.174])
	by APP4 (Coremail) with SMTP id gCh0CgB3n4X_qqhm9FEUAQ--.10779S3;
	Tue, 30 Jul 2024 16:57:38 +0800 (CST)
Message-ID: <deec537f-b9f9-46b4-960a-44e70e272d79@huaweicloud.com>
Date: Tue, 30 Jul 2024 16:57:35 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/20] ext4: fix slab-use-after-free in
 ext4_split_extent_at()
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: linux-ext4@vger.kernel.org, tytso@mit.edu, adilger.kernel@dilger.ca,
 jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
 yi.zhang@huawei.com, yangerkun@huawei.com, Baokun Li <libaokun1@huawei.com>,
 stable@kernel.org, Baokun Li <libaokun@huaweicloud.com>
References: <20240710040654.1714672-1-libaokun@huaweicloud.com>
 <20240710040654.1714672-6-libaokun@huaweicloud.com>
 <ZqTNtWchBMRIVmqL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Language: en-US
From: Baokun Li <libaokun@huaweicloud.com>
In-Reply-To: <ZqTNtWchBMRIVmqL@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgB3n4X_qqhm9FEUAQ--.10779S3
X-Coremail-Antispam: 1UD129KBjvJXoW3XrW8Wr47Gw43Jr4kAr45Awb_yoW7Xryrpr
	WkCFWfGr1Utr9rWrW7JF1DXr1I9w47Gr47JrWfGw1rGFyUtryfWFnrt3W5KF98KrW8u34Y
	vr48trWDW3WUtaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26F1j6w1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0JUZYFZUUUUU=
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/1tbiAgAABWaopJYC3QABsl

On 2024/7/27 18:36, Ojaswin Mujoo wrote:
> On Wed, Jul 10, 2024 at 12:06:39PM +0800, libaokun@huaweicloud.com wrote:
>> From: Baokun Li <libaokun1@huawei.com>
>>
>> We hit the following use-after-free:
>>
>> ==================================================================
>> BUG: KASAN: slab-use-after-free in ext4_split_extent_at+0xba8/0xcc0
>> Read of size 2 at addr ffff88810548ed08 by task kworker/u20:0/40
>> CPU: 0 PID: 40 Comm: kworker/u20:0 Not tainted 6.9.0-dirty #724
>> Call Trace:
>>   <TASK>
>>   kasan_report+0x93/0xc0
>>   ext4_split_extent_at+0xba8/0xcc0
>>   ext4_split_extent.isra.0+0x18f/0x500
>>   ext4_split_convert_extents+0x275/0x750
>>   ext4_ext_handle_unwritten_extents+0x73e/0x1580
>>   ext4_ext_map_blocks+0xe20/0x2dc0
>>   ext4_map_blocks+0x724/0x1700
>>   ext4_do_writepages+0x12d6/0x2a70
>> [...]
>>
>> Allocated by task 40:
>>   __kmalloc_noprof+0x1ac/0x480
>>   ext4_find_extent+0xf3b/0x1e70
>>   ext4_ext_map_blocks+0x188/0x2dc0
>>   ext4_map_blocks+0x724/0x1700
>>   ext4_do_writepages+0x12d6/0x2a70
>> [...]
>>
>> Freed by task 40:
>>   kfree+0xf1/0x2b0
>>   ext4_find_extent+0xa71/0x1e70
>>   ext4_ext_insert_extent+0xa22/0x3260
>>   ext4_split_extent_at+0x3ef/0xcc0
>>   ext4_split_extent.isra.0+0x18f/0x500
>>   ext4_split_convert_extents+0x275/0x750
>>   ext4_ext_handle_unwritten_extents+0x73e/0x1580
>>   ext4_ext_map_blocks+0xe20/0x2dc0
>>   ext4_map_blocks+0x724/0x1700
>>   ext4_do_writepages+0x12d6/0x2a70
>> [...]
>> ==================================================================
>>
>> The flow of issue triggering is as follows:
>>
>> ext4_split_extent_at
>>    path = *ppath
>>    ext4_ext_insert_extent(ppath)
>>      ext4_ext_create_new_leaf(ppath)
>>        ext4_find_extent(orig_path)
>>          path = *orig_path
>>          read_extent_tree_block
>>            // return -ENOMEM or -EIO
>>          ext4_free_ext_path(path)
>>            kfree(path)
>>          *orig_path = NULL
>>    a. If err is -ENOMEM:
>>    ext4_ext_dirty(path + path->p_depth)
>>    // path use-after-free !!!
>>    b. If err is -EIO and we have EXT_DEBUG defined:
>>    ext4_ext_show_leaf(path)
>>      eh = path[depth].p_hdr
>>      // path also use-after-free !!!
>>
>> So when trying to zeroout or fix the extent length, call ext4_find_extent()
>> to update the path.
>>
>> In addition we use *ppath directly as an ext4_ext_show_leaf() input to
>> avoid possible use-after-free when EXT_DEBUG is defined, and to avoid
>> unnecessary path updates.
>>
>> Fixes: dfe5080939ea ("ext4: drop EXT4_EX_NOFREE_ON_ERR from rest of extents handling code")
>> Cc: stable@kernel.org
>> Signed-off-by: Baokun Li <libaokun1@huawei.com>
>> ---
>>   fs/ext4/extents.c | 21 ++++++++++++++++++++-
>>   1 file changed, 20 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index 6e5b5baf3aa6..3a70a0739af8 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -3252,6 +3252,25 @@ static int ext4_split_extent_at(handle_t *handle,
>>    if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
>>      goto out;
>>   
>> + /*
>> +  * Update path is required because previous ext4_ext_insert_extent()
>> +  * may have freed or reallocated the path. Using EXT4_EX_NOFAIL
>> +  * guarantees that ext4_find_extent() will not return -ENOMEM,
>> +  * otherwise -ENOMEM will cause a retry in do_writepages(), and a
>> +  * WARN_ON may be triggered in ext4_da_update_reserve_space() due to
>> +  * an incorrect ee_len causing the i_reserved_data_blocks exception.
>> +  */
>> + path = ext4_find_extent(inode, ee_block, ppath,
>> +       flags | EXT4_EX_NOFAIL);
>> + if (IS_ERR(path)) {
>> +   EXT4_ERROR_INODE(inode, "Failed split extent on %u, err %ld",
>> +        split, PTR_ERR(path));
>> +   return PTR_ERR(path);
>> + }
>> + depth = ext_depth(inode);
>> + ex = path[depth].p_ext;
>> + *ppath = path;
>> +
> Hi Baokun, nice catch!
>
> I was just wondering if it makes more sense to only update path if we
> encounter an error:
>
>    err = ext4_ext_insert_extent(handle, inode, ppath, &newex, flags);
>    if (err != -ENOSPC && err != -EDQUOT && err != -ENOMEM)
>      goto out;
>    else if (err < 0) {
>      ...
>      path = ext4_find_extent(inode, ee_block, ppath, flags | EXT4_EX_NOFAIL);
>    }
>
> I believe that's the only time we'd end up with the use after free issue
> and this way we can avoid the (maybe tiny) performance overhead of calling
> the extra find extent. What are your thoughts?
>
> regards,
> ojaswin
Hi Ojaswin,

We're already there now, updating the path only on recoverable,
non-critical errors (-ENOSPC, -EDQUOT, and -ENOMEM).

Thanks,
Baokun
>>    if (EXT4_EXT_MAY_ZEROOUT & split_flag) {
>>      if (split_flag & (EXT4_EXT_DATA_VALID1|EXT4_EXT_DATA_VALID2)) {
>>        if (split_flag & EXT4_EXT_DATA_VALID1) {
>> @@ -3304,7 +3323,7 @@ static int ext4_split_extent_at(handle_t *handle,
>>    ext4_ext_dirty(handle, inode, path + path->p_depth);
>>    return err;
>>   out:
>> - ext4_ext_show_leaf(inode, path);
>> + ext4_ext_show_leaf(inode, *ppath);
>>    return err;
>>   }
>>   
>> -- 
>> 2.39.2
>>
-- 
With Best Regards,
Baokun Li


