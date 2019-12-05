Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 885F711393F
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Dec 2019 02:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfLEBXb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Dec 2019 20:23:31 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:45270 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727146AbfLEBXb (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 4 Dec 2019 20:23:31 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 86B9320323A9A0248481;
        Thu,  5 Dec 2019 09:23:29 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.179) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Dec 2019
 09:23:20 +0800
Subject: Re: [PATCH v3 3/4] jbd2: make sure ESHUTDOWN to be recorded in the
 journal superblock
To:     Jan Kara <jack@suse.cz>, <tytso@mit.edu>
CC:     <linux-ext4@vger.kernel.org>, <jack@suse.com>,
        <adilger.kernel@dilger.ca>, <liangyun2@huawei.com>,
        <luoshijie1@huawei.com>
References: <20191204124614.45424-1-yi.zhang@huawei.com>
 <20191204124614.45424-4-yi.zhang@huawei.com>
 <20191204170528.GH8206@quack2.suse.cz>
From:   "zhangyi (F)" <yi.zhang@huawei.com>
Message-ID: <1f8eb86e-53c0-a547-a1e5-b7411d36ac3e@huawei.com>
Date:   Thu, 5 Dec 2019 09:23:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191204170528.GH8206@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.179]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2019/12/5 1:05, Jan Kara wrote:
> On Wed 04-12-19 20:46:13, zhangyi (F) wrote:
>> Commit fb7c02445c49 ("ext4: pass -ESHUTDOWN code to jbd2 layer") want
>> to allow jbd2 layer to distinguish shutdown journal abort from other
>> error cases. So the ESHUTDOWN should be taken precedence over any other
>> errno which has already been recoded after EXT4_FLAGS_SHUTDOWN is set,
>> but it only update errno in the journal suoerblock now if the old errno
>> is 0.
>>
>> Fixes: fb7c02445c49 ("ext4: pass -ESHUTDOWN code to jbd2 layer")
>> Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
> 
> Yeah, I think this is correct if I understand the logic correctly but I'd
> like Ted to have a look at this. Anyway, feel free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 

Thanks for review.

Hi Ted, do you have time to look at this patch?

Thanks,
Yi.

> 
>> ---
>>  fs/jbd2/journal.c | 3 +--
>>  1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index b2d6e7666d0f..93be6e0311da 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -2109,8 +2109,7 @@ static void __journal_abort_soft (journal_t *journal, int errno)
>>  
>>  	if (journal->j_flags & JBD2_ABORT) {
>>  		write_unlock(&journal->j_state_lock);
>> -		if (!old_errno && old_errno != -ESHUTDOWN &&
>> -		    errno == -ESHUTDOWN)
>> +		if (old_errno != -ESHUTDOWN && errno == -ESHUTDOWN)
>>  			jbd2_journal_update_sb_errno(journal);
>>  		return;
>>  	}
>> -- 
>> 2.17.2
>>

