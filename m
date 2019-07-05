Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 820A6601CB
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Jul 2019 09:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727873AbfGEHwx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jul 2019 03:52:53 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8144 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725894AbfGEHwx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 5 Jul 2019 03:52:53 -0400
Received: from DGGEMS404-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 7064E3D7CA6B7F996B6D;
        Fri,  5 Jul 2019 15:52:48 +0800 (CST)
Received: from [127.0.0.1] (10.133.210.141) by DGGEMS404-HUB.china.huawei.com
 (10.3.19.204) with Microsoft SMTP Server id 14.3.439.0; Fri, 5 Jul 2019
 15:52:42 +0800
Subject: Re: [PATCH] ext4: fix warning when turn on dioread_nolock and
 inline_data
To:     Jan Kara <jack@suse.cz>
CC:     <tytso@mit.edu>, Jan Kara <jack@suse.com>, <houtao1@huawei.com>,
        <miaoxie@huawei.com>, <yi.zhang@huawei.com>,
        <linux-ext4@vger.kernel.org>
References: <1562244632-134963-1-git-send-email-yangerkun@huawei.com>
 <20190704145514.GC31037@quack2.suse.cz>
From:   yangerkun <yangerkun@huawei.com>
Message-ID: <f7658935-af7d-2e8b-235a-490d199adab8@huawei.com>
Date:   Fri, 5 Jul 2019 15:52:41 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190704145514.GC31037@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.133.210.141]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks a lot! Will resend the patch soon!

On 2019/7/4 22:55, Jan Kara wrote:
> On Thu 04-07-19 20:50:32, yangerkun wrote:
>> mkfs.ext4 -O inline_data /dev/vdb
>> mount -o dioread_nolock /dev/vdb /mnt
>> echo "some inline data..." >> /mnt/test-file
>> echo "some inline data..." >> /mnt/test-file
>> sync
>>
>> With upon script, system will trigger
>> "WARN_ON(!io_end->handle && sbi->s_journal)" since the wrong order
>> between rsv_blocks calculate and destroy inline data for dealloc.
> Thanks for the patch! Good catch! I'd just rephrase the last paragraph as:
>
> The above script will trigger "WARN_ON(!io_end->handle && sbi->s_journal)"
> because ext4_should_dioread_nolock() returns false for a file with inline
> data. Move the check to a place after we have already removed the inline
> data and prepared inode to write normal pages.
>
> Otherwise the patch looks good to me so feel free to add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
>
>> Signed-off-by: yangerkun <yangerkun@huawei.com>
>> ---
>>   fs/ext4/inode.c | 18 +++++++++---------
>>   1 file changed, 9 insertions(+), 9 deletions(-)
>>
>> diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
>> index c7f77c6..3f2a366 100644
>> --- a/fs/ext4/inode.c
>> +++ b/fs/ext4/inode.c
>> @@ -2769,15 +2769,6 @@ static int ext4_writepages(struct address_space *mapping,
>>   		goto out_writepages;
>>   	}
>>   
>> -	if (ext4_should_dioread_nolock(inode)) {
>> -		/*
>> -		 * We may need to convert up to one extent per block in
>> -		 * the page and we may dirty the inode.
>> -		 */
>> -		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
>> -						PAGE_SIZE >> inode->i_blkbits);
>> -	}
>> -
>>   	/*
>>   	 * If we have inline data and arrive here, it means that
>>   	 * we will soon create the block for the 1st page, so
>> @@ -2796,6 +2787,15 @@ static int ext4_writepages(struct address_space *mapping,
>>   		ext4_journal_stop(handle);
>>   	}
>>   
>> +	if (ext4_should_dioread_nolock(inode)) {
>> +		/*
>> +		 * We may need to convert up to one extent per block in
>> +		 * the page and we may dirty the inode.
>> +		 */
>> +		rsv_blocks = 1 + ext4_chunk_trans_blocks(inode,
>> +						PAGE_SIZE >> inode->i_blkbits);
>> +	}
>> +
>>   	if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX)
>>   		range_whole = 1;
>>   
>> -- 
>> 2.7.4
>>
>>

