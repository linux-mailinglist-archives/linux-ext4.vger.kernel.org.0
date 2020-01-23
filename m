Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 867B01461F8
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jan 2020 07:26:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725828AbgAWG03 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jan 2020 01:26:29 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:43612 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725818AbgAWG03 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 23 Jan 2020 01:26:29 -0500
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 5ABC5251AEB906ECCCD1;
        Thu, 23 Jan 2020 14:26:27 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.42) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 23 Jan 2020
 14:26:25 +0800
Subject: Re: [PATCH] jbd2: modify assert condition in
 __journal_remove_journal_head
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>
References: <20200122070548.64664-1-luoshijie1@huawei.com>
 <20200122085024.GB12845@quack2.suse.cz>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <9bbea221-f99e-45d5-039a-9663d0104ce5@huawei.com>
Date:   Thu, 23 Jan 2020 14:26:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200122085024.GB12845@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.173.222.42]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2020/1/22 16:50, Jan Kara wrote:
> On Wed 22-01-20 02:05:48, Shijie Luo wrote:
>> Only when jh->b_jcount = 0 in jbd2_journal_put_journal_head, we are allowed
>> to call __journal_remove_journal_head.
>>
>> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Thanks for the patch. You're right but given that
> __journal_remove_journal_head() has exactly one caller and that checks for
> jh->b_jcount == 0 just before calling __journal_remove_journal_head(), I
> think the assertion is pretty pointless. So I'd rather just remove it
> completely.
>
> 								Honza
Thanks for your review. It 's much better to remove the assertion.
>> ---
>>   fs/jbd2/journal.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
>> index 5e408ee24a1a..4f417a7f1ae0 100644
>> --- a/fs/jbd2/journal.c
>> +++ b/fs/jbd2/journal.c
>> @@ -2556,7 +2556,7 @@ static void __journal_remove_journal_head(struct buffer_head *bh)
>>   {
>>   	struct journal_head *jh = bh2jh(bh);
>>   
>> -	J_ASSERT_JH(jh, jh->b_jcount >= 0);
>> +	J_ASSERT_JH(jh, jh->b_jcount == 0);
>>   	J_ASSERT_JH(jh, jh->b_transaction == NULL);
>>   	J_ASSERT_JH(jh, jh->b_next_transaction == NULL);
>>   	J_ASSERT_JH(jh, jh->b_cp_transaction == NULL);
>> -- 
>> 2.19.1
>>

