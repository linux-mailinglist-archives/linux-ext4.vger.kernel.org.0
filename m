Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 828621461FD
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2020 07:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725930AbgAWG2o (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jan 2020 01:28:44 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:9238 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgAWG2o (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Jan 2020 01:28:44 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 3606EE19C5279C7D7579;
        Thu, 23 Jan 2020 14:28:43 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.42) by DGGEMS413-HUB.china.huawei.com
 (10.3.19.213) with Microsoft SMTP Server id 14.3.439.0; Thu, 23 Jan 2020
 14:28:41 +0800
Subject: Re: [PATCH] ext4,jbd2: fix comment and code style
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>
References: <20200122072625.16487-1-luoshijie1@huawei.com>
 <20200122084702.GA12845@quack2.suse.cz>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <f0a754a9-fd73-10cb-9d25-b2e107ef3d25@huawei.com>
Date:   Thu, 23 Jan 2020 14:28:40 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200122084702.GA12845@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.173.222.42]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2020/1/22 16:47, Jan Kara wrote:
> On Wed 22-01-20 02:26:25, Shijie Luo wrote:
>> Fix comment and remove unnecessary blank.
>>
>> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Looks good. You can add:
>
> Reviewed-by: Jan Kara <jack@suse.cz>
>
> 								Honza
Thanks for your review.
>> ---
>>   fs/ext4/inline.c      | 2 +-
>>   fs/jbd2/transaction.c | 2 +-
>>   2 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
>> index 2fec62d764fa..a6695e1d246c 100644
>> --- a/fs/ext4/inline.c
>> +++ b/fs/ext4/inline.c
>> @@ -849,7 +849,7 @@ static int ext4_da_convert_inline_data_to_extent(struct address_space *mapping,
>>   
>>   /*
>>    * Prepare the write for the inline data.
>> - * If the the data can be written into the inode, we just read
>> + * If the data can be written into the inode, we just read
>>    * the page and make it uptodate, and start the journal.
>>    * Otherwise read the page, makes it dirty so that it can be
>>    * handle in writepages(the i_disksize update is left to the
>> diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
>> index 27b9f9dee434..f7a9da75b160 100644
>> --- a/fs/jbd2/transaction.c
>> +++ b/fs/jbd2/transaction.c
>> @@ -1595,7 +1595,7 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
>>    * Allow this call even if the handle has aborted --- it may be part of
>>    * the caller's cleanup after an abort.
>>    */
>> -int jbd2_journal_forget (handle_t *handle, struct buffer_head *bh)
>> +int jbd2_journal_forget(handle_t *handle, struct buffer_head *bh)
>>   {
>>   	transaction_t *transaction = handle->h_transaction;
>>   	journal_t *journal;
>> -- 
>> 2.19.1
>>

