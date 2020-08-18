Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FF2483EE
	for <lists+linux-ext4@lfdr.de>; Tue, 18 Aug 2020 13:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726689AbgHRLex (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 18 Aug 2020 07:34:53 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:9759 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726273AbgHRLdw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 18 Aug 2020 07:33:52 -0400
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 323F07CB18BC536593F5;
        Tue, 18 Aug 2020 19:33:40 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.226) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 19:33:31 +0800
Subject: Re: [PATCH] jbd2: remove useless variable chksum_seen in do_one_pass
To:     Jan Kara <jack@suse.cz>
CC:     <linux-ext4@vger.kernel.org>, <tytso@mit.edu>,
        <linfeilong@huawei.com>
References: <20200811022128.32690-1-luoshijie1@huawei.com>
 <20200818104826.GA1902@quack2.suse.cz>
From:   Shijie Luo <luoshijie1@huawei.com>
Message-ID: <ac6a4fd9-f2af-bad5-ce5d-ea728e9b64b2@huawei.com>
Date:   Tue, 18 Aug 2020 19:33:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200818104826.GA1902@quack2.suse.cz>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Originating-IP: [10.174.179.226]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 2020/8/18 18:48, Jan Kara wrote:
> On Mon 10-08-20 22:21:28, Shijie Luo wrote:
>> This variable only indicates that we do checksum success, while
>> chksum_err can also do. Moreover, condition "!chksum_seen" in else
>> if bracket is pointless.
>>
>> Signed-off-by: Shijie Luo <luoshijie1@huawei.com>
> Thanks for the patch! Some comments below.
>
>> @@ -709,11 +707,10 @@ static int do_one_pass(journal_t *journal,
>>   				    cbh->h_chksum_type == JBD2_CRC32_CHKSUM &&
>>   				    cbh->h_chksum_size ==
>>   						JBD2_CRC32_CHKSUM_SIZE)
>> -				       chksum_seen = 1;
>> +				       chksum_err = 0;
>>   				else if (!(cbh->h_chksum_type == 0 &&
>>   					     cbh->h_chksum_size == 0 &&
>> -					     found_chksum == 0 &&
>> -					     !chksum_seen))
>> +					     found_chksum == 0))
>>   				/*
>>   				 * If fs is mounted using an old kernel and then
>>   				 * kernel with journal_chksum is used then we
> I agree the use of chksum_err & chksum_seen looks rather arbitrary. In fact
> the code seems to be equivalent to:
>
> 				/* Neither checksum match nor unused? */
> 				if (!(crc32_sum == found_chksum &&
>                                       cbh->h_chksum_type == JBD2_CRC32_CHKSUM &&
>                                       cbh->h_chksum_size ==
>                                                  JBD2_CRC32_CHKSUM_SIZE) &&
> 				    !(cbh->h_chksum_type == 0 &&
>                                               cbh->h_chksum_size == 0 &&
>                                               found_chksum == 0)) {
> 					info->end_transaction = next_commit_ID;
> 					if (jbd2_has_feature_async_commit(journal)) {
> 						...
> 					}
> 				}
> 				crc32_sum = ~0;
>
> which would be even simpler...
>
> 								Honza

Thanks for your review，it 's definitely true to use these code as a 
substitute, but I think these are

a little bit hard to read.  By the way, I found a indentation error on 
"chksum_err = 1".

Do you think which one is better? I will take your opinion into account 
and send a v2 patch.


