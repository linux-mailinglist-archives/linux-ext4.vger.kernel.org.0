Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF2CC3BD88F
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Jul 2021 16:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbhGFOnb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Jul 2021 10:43:31 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:6072 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232397AbhGFOna (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Jul 2021 10:43:30 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4GK4pb5WSFzXphc;
        Tue,  6 Jul 2021 22:35:19 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 6 Jul 2021 22:40:47 +0800
Subject: Re: [RFC PATCH 1/4] ext4: check and update i_disksize properly
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20210706024210.746788-1-yi.zhang@huawei.com>
 <20210706024210.746788-2-yi.zhang@huawei.com>
 <20210706121123.GB7922@quack2.suse.cz>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <32946f62-631e-d752-9fcf-e89b568e2e7f@huawei.com>
Date:   Tue, 6 Jul 2021 22:40:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210706121123.GB7922@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/7/6 20:11, Jan Kara wrote:
> On Tue 06-07-21 10:42:07, Zhang Yi wrote:
>> After commit 3da40c7b0898 ("ext4: only call ext4_truncate when size <=
>> isize"), i_disksize could always be updated to i_size in ext4_setattr(),
>> and it seems that there is no other way that could appear
>> i_disksize < i_size besides the delalloc write. In the case of delay
> 
> Well, there are also direct IO writes which have temporarily i_disksize <
> i_size but when you hold i_rwsem, you're right that delalloc is the only
> reason why you can see i_disksize < i_size AFAIK.
> 
>> alloc write, ext4_writepages() could update i_disksize for the new delay
>> allocated blocks properly. So we could switch to check i_size instead
>> of i_disksize in ext4_da_write_end() when write to the end of the file.
> 
> I agree that since ext4_da_should_update_i_disksize() needs to return true
> for us to touch i_disksize, writeback has to have already allocated block
> underlying the end of write (new_i_size position) and thus we are
> guaranteed that writeback will also soon update i_disksize after the
> new_i_size position. So I agree that your switch to testing i_size instead
> of i_disksize should not have any bad effect... Thinking about this some
> more why do we need i_disksize update in ext4_da_write_end() at all? The
> page will be dirtied and when writeback will happen we will update
> i_disksize to i_size. Updating i_disksize earlier brings no benefit - the user
> will see zeros instead of valid data if we crash before the writeback
> happened. Am I missing something guys?
> 

Hi, Jan.

Do you remember the patch and question I asked 2 years ago[1][2]? The case of
new_i_size > i_size && ext4_da_should_update_i_disksize() here means partial
block append write, ext4_writepages() does not update i_disksize for this case
now. And the journal data=ordered mode also cannot guarantee write data before
metadata. So we cannot guarantee we cannot see zeros where data was written after
crash.

Thanks,
Yi.

[1]https://lore.kernel.org/linux-ext4/20190404101823.GA22313@quack2.suse.cz/
[2]https://lore.kernel.org/linux-ext4/20190405091258.GA1600@quack2.suse.cz/

> 
>> we also could remove ext4_mark_inode_dirty() together because
>> generic_write_end() will dirty the inode.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/ext4/inode.c | 21 ++++++++-------------
>>  1 file changed, 8 insertions(+), 13 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index d8de607849df..6f6a61f3ae5f 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -3087,32 +3087,27 @@ static int ext4_da_write_end(struct file *file,
>>  	 * generic_write_end() will run mark_inode_dirty() if i_size
>>  	 * changes.  So let's piggyback the i_disksize mark_inode_dirty
>>  	 * into that.
>> +	 *
>> +	 * Check i_size not i_disksize here because ext4_writepages() could
>> +	 * update i_disksize from i_size for delay allocated blocks properly.
>>  	 */
>>  	new_i_size = pos + copied;
>> -	if (copied && new_i_size > EXT4_I(inode)->i_disksize) {
>> +	if (copied && new_i_size > inode->i_size) {
>>  		if (ext4_has_inline_data(inode) ||
>> -		    ext4_da_should_update_i_disksize(page, end)) {
>> +		    ext4_da_should_update_i_disksize(page, end))
>>  			ext4_update_i_disksize(inode, new_i_size);
>> -			/* We need to mark inode dirty even if
>> -			 * new_i_size is less that inode->i_size
>> -			 * bu greater than i_disksize.(hint delalloc)
>> -			 */
>> -			ret = ext4_mark_inode_dirty(handle, inode);
>> -		}
>>  	}
>>  
>>  	if (write_mode != CONVERT_INLINE_DATA &&
>>  	    ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
>>  	    ext4_has_inline_data(inode))
>> -		ret2 = ext4_da_write_inline_data_end(inode, pos, len, copied,
>> +		ret = ext4_da_write_inline_data_end(inode, pos, len, copied,
>>  						     page);
>>  	else
>> -		ret2 = generic_write_end(file, mapping, pos, len, copied,
>> +		ret = generic_write_end(file, mapping, pos, len, copied,
>>  							page, fsdata);
>>  
>> -	copied = ret2;
>> -	if (ret2 < 0)
>> -		ret = ret2;
>> +	copied = ret;
>>  	ret2 = ext4_journal_stop(handle);
>>  	if (unlikely(ret2 && !ret))
>>  		ret = ret2;
>> -- 
>> 2.31.1
>>
