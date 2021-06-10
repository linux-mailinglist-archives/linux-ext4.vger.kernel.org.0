Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD61E3A2220
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Jun 2021 04:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbhFJCHL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Jun 2021 22:07:11 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5363 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229937AbhFJCHK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Jun 2021 22:07:10 -0400
Received: from dggeme752-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4G0nJd11rSz6w3X;
        Thu, 10 Jun 2021 10:01:21 +0800 (CST)
Received: from [10.174.178.134] (10.174.178.134) by
 dggeme752-chm.china.huawei.com (10.3.19.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Thu, 10 Jun 2021 10:05:13 +0800
Subject: Re: [RFC PATCH v3 4/8] jbd2: remove redundant buffer io error checks
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <adilger.kernel@dilger.ca>, <yukuai3@huawei.com>
References: <20210527135641.420514-1-yi.zhang@huawei.com>
 <20210527135641.420514-5-yi.zhang@huawei.com>
 <20210603162859.GN23647@quack2.suse.cz>
From:   Zhang Yi <yi.zhang@huawei.com>
Message-ID: <8ff5d45c-8195-adf9-4bfe-87ac33e522f8@huawei.com>
Date:   Thu, 10 Jun 2021 10:05:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20210603162859.GN23647@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.178.134]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggeme752-chm.china.huawei.com (10.3.19.98)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 2021/6/4 0:28, Jan Kara wrote:
> On Thu 27-05-21 21:56:37, Zhang Yi wrote:
>> Now that __jbd2_journal_remove_checkpoint() can detect buffer io error
>> and mark journal checkpoint error, then we abort the journal later
>> before updating log tail to ensure the filesystem works consistently.
>> So we could remove other redundant buffer io error checkes.
>>
>> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
>> ---
>>  fs/jbd2/checkpoint.c | 7 +------
>>  1 file changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
>> index 2cbac0e3cff3..c1f746a5cc1a 100644
>> --- a/fs/jbd2/checkpoint.c
>> +++ b/fs/jbd2/checkpoint.c
>> @@ -91,8 +91,7 @@ static int __try_to_free_cp_buf(struct journal_head *jh)
>>  	int ret = 0;
>>  	struct buffer_head *bh = jh2bh(jh);
>>  
>> -	if (jh->b_transaction == NULL && !buffer_locked(bh) &&
>> -	    !buffer_dirty(bh) && !buffer_write_io_error(bh)) {
>> +	if (!jh->b_transaction && !buffer_locked(bh) && !buffer_dirty(bh)) {
>>  		JBUFFER_TRACE(jh, "remove from checkpoint list");
>>  		ret = __jbd2_journal_remove_checkpoint(jh) + 1;
>>  	}
>> @@ -295,8 +294,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>>  			goto restart;
>>  		}
>>  		if (!buffer_dirty(bh)) {
>> -			if (unlikely(buffer_write_io_error(bh)) && !result)
>> -				result = -EIO;
>>  			BUFFER_TRACE(bh, "remove from checkpoint");
>>  			if (__jbd2_journal_remove_checkpoint(jh))
>>  				/* The transaction was released; we're done */
>> @@ -356,8 +353,6 @@ int jbd2_log_do_checkpoint(journal_t *journal)
>>  			spin_lock(&journal->j_list_lock);
>>  			goto restart2;
>>  		}
>> -		if (unlikely(buffer_write_io_error(bh)) && !result)
>> -			result = -EIO;
>>  
>>  		/*
>>  		 * Now in whatever state the buffer currently is, we
> 
> You can also drop:
> 
> 	if (result < 0)
>                 jbd2_journal_abort(journal, result);
> 
> in jbd2_log_do_checkpoint() as there's now nothing which can set 'result'
> in the loops... Otherwise looks good. Feel free to add:
> 

Yes, I will remove it in the next iteration, thanks for the review.

Thanks,
Yi.
