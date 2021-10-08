Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6643F42624D
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Oct 2021 04:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234771AbhJHCHJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Oct 2021 22:07:09 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:23354 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234740AbhJHCHH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Oct 2021 22:07:07 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4HQWcZ6w2Lzbd3n;
        Fri,  8 Oct 2021 10:00:46 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2308.8; Fri, 8 Oct 2021 10:05:09 +0800
Received: from [10.174.177.210] (10.174.177.210) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2308.8; Fri, 8 Oct 2021 10:05:00 +0800
Message-ID: <0ed79ac7-9025-8be5-33fd-b80007a99c55@huawei.com>
Date:   Fri, 8 Oct 2021 10:04:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Subject: Re: [PATCH 3/3] ext4: stop use path once restart journal in
 ext4_ext_shift_path_extents
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>, <yukuai3@huawei.com>
References: <20210903062748.4118886-1-yangerkun@huawei.com>
 <20210903062748.4118886-4-yangerkun@huawei.com>
 <20210930164309.GC17404@quack2.suse.cz>
From:   yangerkun <yangerkun@huawei.com>
In-Reply-To: <20210930164309.GC17404@quack2.suse.cz>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.177.210]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



在 2021/10/1 0:43, Jan Kara 写道:
> Let me improve English a bit:
> 
> On Fri 03-09-21 14:27:48, yangerkun wrote:
>> We get a BUG as follow:
> 
> We hit the following bug:
> 
>>
>> [52117.465187] ------------[ cut here ]------------
>> [52117.465686] kernel BUG at fs/ext4/extents.c:1756!
>> ...
>> [52117.478306] Call Trace:
>> [52117.478565]  ext4_ext_shift_extents+0x3ee/0x710
>> [52117.479020]  ext4_fallocate+0x139c/0x1b40
>> [52117.479405]  ? __do_sys_newfstat+0x6b/0x80
>> [52117.479805]  vfs_fallocate+0x151/0x4b0
>> [52117.480177]  ksys_fallocate+0x4a/0xa0
>> [52117.480533]  __x64_sys_fallocate+0x22/0x30
>> [52117.480930]  do_syscall_64+0x35/0x80
>> [52117.481277]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [52117.481769] RIP: 0033:0x7fa062f855ca
>>
>> static int ext4_ext_try_to_merge_right(struct inode *inode,
>>                                   struct ext4_ext_path *path,
>>                                   struct ext4_extent *ex)
>> {
>>          struct ext4_extent_header *eh;
>>          unsigned int depth, len;
>>          int merge_done = 0, unwritten;
>>
>>          depth = ext_depth(inode);
>>          BUG_ON(path[depth].p_hdr == NULL); <=== trigger here
>>          eh = path[depth].p_hdr;
>>
>> Normally, we protect extent tree with i_data_sem, and once we really
>> need drop i_data_sem, we should reload the ext4_ext_path array after we
>> recatch i_data_sem since extent tree may has changed, the 'again' in
>> ext4_ext_remove_space give us a sample. But the other case
>> ext4_ext_shift_path_extents seems forget to do this(ext4_access_path may
>> drop i_data_sem and recatch it with not enough credits), and will lead
>> the upper BUG when there is a parallel extents split which will grow the
>> extent tree.
> 
> Normally, the extent tree is protected by i_data_sem and if we drop
> i_data_sem in ext4_datasem_ensure_credits(), we need to reload
> ext4_ext_path array after reacquiring i_data_sem since the extent tree may
> have changed. The 'again' label in ext4_ext_remove_space() is an example of
> this. But ext4_ext_shift_path_extents() forgets to reload ext4_ext_path and
> thus can cause the above mentioned BUG when there is a parallel extents
> split which will grow the extent tree.
> 
>>
>> Fix it by introduce the again in ext4_ext_shift_extents.
>>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/ext4/extents.c | 14 +++++++++++++-
>>   1 file changed, 13 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index a6fb0350f062..0aa14f6ca914 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -5009,8 +5009,11 @@ ext4_ext_shift_path_extents(struct ext4_ext_path *path, ext4_lblk_t shift,
>>   			restart_credits = ext4_writepage_trans_blocks(inode);
>>   			err = ext4_datasem_ensure_credits(handle, inode, credits,
>>   					restart_credits, 0);
>> -			if (err)
>> +			if (err) {
>> +				if (err > 0)
>> +					err = -EAGAIN;
>>   				goto out;
>> +			}
> 
> Hum, I'd note that the previous patch actually broke
> ext4_ext_shift_path_extents() which could return 1 after patch 2/3 and
> probably confuse code upwards in the stack and now you fix it up in this
> patch. Can you perhaps fixup the previous patch by changing the condition
> to:
> 	if (err < 0)
> 
> and then change it here?

Thanks for your review! Ted has fix this by add some comments in patch 2/3!


> 
>>   
>>   			err = ext4_ext_get_access(handle, inode, path + depth);
>>   			if (err)
>> @@ -5084,6 +5087,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>>   	int ret = 0, depth;
>>   	struct ext4_extent *extent;
>>   	ext4_lblk_t stop, *iterator, ex_start, ex_end;
>> +	ext4_lblk_t tmp = EXT_MAX_BLOCKS;
> 
> Can you perhaps name this more descriptively than 'tmp'? Something like
> restart_lblk or something like that?

Agree. I'll pay attention next time!

>    
>>   	/* Let path point to the last extent */
>>   	path = ext4_find_extent(inode, EXT_MAX_BLOCKS - 1, NULL,
>> @@ -5137,11 +5141,15 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>>   	 * till we reach stop. In case of right shift, iterator points to stop
>>   	 * and it is decreased till we reach start.
>>   	 */
>> +again:
>>   	if (SHIFT == SHIFT_LEFT)
>>   		iterator = &start;
>>   	else
>>   		iterator = &stop;
>>   
>> +	if (tmp != EXT_MAX_BLOCKS)
>> +		*iterator = tmp;
>> +
>>   	/*
>>   	 * Its safe to start updating extents.  Start and stop are unsigned, so
>>   	 * in case of right shift if extent with 0 block is reached, iterator
>> @@ -5170,6 +5178,7 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>>   			}
>>   		}
>>   
>> +		tmp = *iterator;
>>   		if (SHIFT == SHIFT_LEFT) {
>>   			extent = EXT_LAST_EXTENT(path[depth].p_hdr);
>>   			*iterator = le32_to_cpu(extent->ee_block) +
>> @@ -5188,6 +5197,9 @@ ext4_ext_shift_extents(struct inode *inode, handle_t *handle,
>>   		}
>>   		ret = ext4_ext_shift_path_extents(path, shift, inode,
>>   				handle, SHIFT);
>> +		/* iterator can be NULL which means we should break */
>> +		if (ret == -EAGAIN)
>> +			goto again;
> 
> Hum, but while we dropped i_data_sem, the extent depth may have increased
> so we may need larger 'path' now?
> 
> Otherwise the patch looks good.

The ext4_find_extent in ext4_ext_shift_extents can handle this case. It 
seems OK.


> 
> 								Honza
> 
