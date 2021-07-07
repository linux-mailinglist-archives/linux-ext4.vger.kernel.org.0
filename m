Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C985E3BE2F6
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Jul 2021 08:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230280AbhGGGVj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 7 Jul 2021 02:21:39 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6761 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhGGGVi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 7 Jul 2021 02:21:38 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GKTd45b9rzXqKS;
        Wed,  7 Jul 2021 14:13:28 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Wed, 7 Jul 2021 14:18:57 +0800
Subject: Re: [RFC PATCH 1/4] ext4: check and update i_disksize properly
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20210706024210.746788-1-yi.zhang@huawei.com>
 <20210706024210.746788-2-yi.zhang@huawei.com>
 <20210706121123.GB7922@quack2.suse.cz>
 <32946f62-631e-d752-9fcf-e89b568e2e7f@huawei.com>
 <20210706152633.GB17149@quack2.suse.cz>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <8c7597d1-7983-c024-d7c1-88b741afc2ad@huawei.com>
Date:   Wed, 7 Jul 2021 14:18:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210706152633.GB17149@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/7/6 23:26, Jan Kara wrote:
> On Tue 06-07-21 22:40:46, Zhang Yi wrote:
>> On 2021/7/6 20:11, Jan Kara wrote:
>>> On Tue 06-07-21 10:42:07, Zhang Yi wrote:
>>>> After commit 3da40c7b0898 ("ext4: only call ext4_truncate when size <=
>>>> isize"), i_disksize could always be updated to i_size in ext4_setattr(),
>>>> and it seems that there is no other way that could appear
>>>> i_disksize < i_size besides the delalloc write. In the case of delay
>>>
>>> Well, there are also direct IO writes which have temporarily i_disksize <
>>> i_size but when you hold i_rwsem, you're right that delalloc is the only
>>> reason why you can see i_disksize < i_size AFAIK.
>>>
>>>> alloc write, ext4_writepages() could update i_disksize for the new delay
>>>> allocated blocks properly. So we could switch to check i_size instead
>>>> of i_disksize in ext4_da_write_end() when write to the end of the file.
>>>
>>> I agree that since ext4_da_should_update_i_disksize() needs to return true
>>> for us to touch i_disksize, writeback has to have already allocated block
>>> underlying the end of write (new_i_size position) and thus we are
>>> guaranteed that writeback will also soon update i_disksize after the
>>> new_i_size position. So I agree that your switch to testing i_size instead
>>> of i_disksize should not have any bad effect... Thinking about this some
>>> more why do we need i_disksize update in ext4_da_write_end() at all? The
>>> page will be dirtied and when writeback will happen we will update
>>> i_disksize to i_size. Updating i_disksize earlier brings no benefit - the user
>>> will see zeros instead of valid data if we crash before the writeback
>>> happened. Am I missing something guys?
>>>
>>
>> Hi, Jan.
>>
>> Do you remember the patch and question I asked 2 years ago[1][2]? The
>> case of new_i_size > i_size && ext4_da_should_update_i_disksize() here
>> means partial block append write,
> 
> Agreed.
> 
>> ext4_writepages() does not update i_disksize for this case now.
> 
> Doesn't it? Hmm, so mpage_map_and_submit_extent() certainly does make sure
> we update i_size properly. But you are actually correct that
> ext4_writepage() does not update i_disksize and neither does
> mpage_prepare_extent_to_map() which can also writeback fully mapped pages.
> Changing mpage_prepare_extent_to_map() to handle i_disksize update would be
> trivial but dealing with ext4_writepage() would be difficult. So yes, let's
> keep the i_disksize update in ext4_da_write_end() for now. But please add a
> comment there explaining the situation. Like:
> 
> 	/*
> 	 * Since we are holding inode lock, we are sure i_disksize <=
> 	 * i_size. We also know that if i_disksize < i_size, there are
> 	 * delalloc writes pending in the range upto i_size. If the end of
> 	 * the current write is <= i_size, there's no need to touch
> 	 * i_disksize since writeback will push i_disksize upto i_size
> 	 * eventually. If the end of the current write is > i_size and
> 	 * inside an allocated block (ext4_da_should_update_i_disksize()
> 	 * check), we need to update i_disksize here as neither
> 	 * ext4_writepage() nor certain ext4_writepages() paths not
> 	 * allocating blocks update i_disksize.
> 	 *
> 	 * Note that we defer inode dirtying to generic_write_end() /
> 	 * ext4_da_write_inline_data_end().
> 	 */
> 

Yeah, it makes things clear, I will add this comments in the next iteration.

Thanks,
Yi.
