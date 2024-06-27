Return-Path: <linux-ext4+bounces-2987-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AAA919F7B
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 08:43:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1AF891F22C90
	for <lists+linux-ext4@lfdr.de>; Thu, 27 Jun 2024 06:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD21B35894;
	Thu, 27 Jun 2024 06:43:35 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A419324B5B;
	Thu, 27 Jun 2024 06:43:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719470615; cv=none; b=esUWwlgYyXw1DabeMA6wVOImW7e1PxwMikPILav6wuFGqxP0YmjClbN3oyPQCu7AO5PfXoMkgtY+IjV0mPUbc4IQcr6GNohqYi49jc2qp/FZaeGzV4TcUvkD38jPsYD9Se+tcu2J9veHxwlylE5Qeel9u4OCMzdH8wR+P8yX9JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719470615; c=relaxed/simple;
	bh=V8nNxRX82azS3Il70BdZJU9iGwORZyga6YY97iogvxw=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DqpYea3dyoR8gYGPbEH19V92MZ6Cq4NshZRJbhhhHDmsfYewm2I4FI2ZPCOKjJ/fH7XECofzYTn1MC03CFihv1Nl0/rfKz8YZdkxN5WB27RM19DKY73bdIO1xKm1tOuWRnlPZ0oLqEMsXzvp65PM4jwfDPtbRILqv5idcaK+VBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4W8ptC1BNRz4f3jq6;
	Thu, 27 Jun 2024 14:43:15 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 4A3AA1A0181;
	Thu, 27 Jun 2024 14:43:22 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAnkYYICn1mpk7hAQ--.14394S3;
	Thu, 27 Jun 2024 14:43:22 +0800 (CST)
Subject: Re: [PATCH v2 3/4] jbd2: Avoid infinite transaction commit loop
To: Jan Kara <jack@suse.cz>
Cc: linux-ext4@vger.kernel.org, Alexander Coffin
 <alex.coffin@maticrobots.com>, stable@vger.kernel.org,
 Ted Tso <tytso@mit.edu>, chengzhihao1@huawei.com
References: <20240624165406.12784-1-jack@suse.cz>
 <20240624170127.3253-3-jack@suse.cz>
 <2d49e3de-d7e7-2fd1-0b7a-9a3f9e04cd4d@huawei.com>
 <20240626112254.cu4un6lua2glkfkn@quack3>
 <e5a3187c-b333-ec5b-0d8b-a02934a37b06@huaweicloud.com>
 <20240626145516.xopg62cxcztte3ek@quack3>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <15b42439-0bab-1dcc-5391-446b345fda39@huaweicloud.com>
Date: Thu, 27 Jun 2024 14:43:20 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240626145516.xopg62cxcztte3ek@quack3>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnkYYICn1mpk7hAQ--.14394S3
X-Coremail-Antispam: 1UD129KBjvJXoWxWrW3Ar1xZr1rAFy3CFWfKrg_yoWrKr17pr
	WrCay7t398Xry5Ar10qF48XrW0qF4UAFyUWrZ8KF93Ja1DKwnakFW2gry2kFWqvryruw1F
	qF1UC3sxGr4jk37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/6/26 22:55, Jan Kara wrote:
> On Wed 26-06-24 21:24:13, Zhang Yi wrote:
>> On 2024/6/26 19:22, Jan Kara wrote:
>>> On Wed 26-06-24 15:38:42, Zhang Yi wrote:
>>>> On 2024/6/25 1:01, Jan Kara wrote:
>>>>> Commit 9f356e5a4f12 ("jbd2: Account descriptor blocks into
>>>>> t_outstanding_credits") started to account descriptor blocks into
>>>>> transactions outstanding credits. However it didn't appropriately
>>>>> decrease the maximum amount of credits available to userspace. Thus if
>>>>> the filesystem requests a transaction smaller than
>>>>> j_max_transaction_buffers but large enough that when descriptor blocks
>>>>> are added the size exceeds j_max_transaction_buffers, we confuse
>>>>> add_transaction_credits() into thinking previous handles have grown the
>>>>> transaction too much and enter infinite journal commit loop in
>>>>> start_this_handle() -> add_transaction_credits() trying to create
>>>>> transaction with enough credits available.
>>>>
>>>> I understand that the incorrect max transaction limit in
>>>> start_this_handle() could lead to infinite loop in
>>>> start_this_handle()-> add_transaction_credits() with large enough
>>>> userspace credits (from j_max_transaction_buffers - overheads to
>>>> j_max_transaction_buffers), but I don't get how could it lead to ran
>>>> out of space in the journal commit traction? IIUC, below codes in
>>>> add_transaction_credits() could make sure that we have enough space
>>>> when committing traction:
>>>>
>>>> static int add_transaction_credits()
>>>> {
>>>> ...
>>>> 	if (jbd2_log_space_left(journal) < journal->j_max_transaction_buffers) {
>>>> 		...
>>>> 		return 1;
>>>> 		...
>>>> 	}
>>>> ...
>>>> }
>>>>
>>>> I can't open and download the image Alexander gave, so I can't get to
>>>> the bottom of this issue, please let me know what happened with
>>>> jbd2_journal_next_log_block().
>>>
>>> Sure. So what was exactly happening is a loop like this:
>>>
>>> start_this_handle()
>>>   blocks = 252 (handle->h_total_credits)
>>>   - starts a new transaction
>>>     - t_outstanding_credits set to 6 to account for the commit block and
>>>       descriptor blocks
>>>   add_transaction_credits(journal, 252, 0)
>>>      needed = atomic_add_return(252, &t->t_outstanding_credits);
>>>      if (needed > journal->j_max_transaction_buffers) {
>>> 	/* Yes, this is exceeded due to descriptor blocks being in
>>> 	 * t_outstanding_credits */
>>>         ...
>>>         wait_transaction_locked(journal);
>>> 	  - this commits an empty transaction - contains only the commit
>>> 	    block
>>>         return 1
>>>   goto repeat
>>>
>>> So we commit single block transactions in a loop until we exhaust all the
>>> journal space. The condition in add_transaction_credits() whether there's
>>> enough space in the journal is never reached so we don't ever push the
>>> journal tail to make space in the journal.
>>>     
>>
>> mm-hm, ha, yeah, this will lead to submit an empty transaction in each loop,
>> but I still have one question, although the journal tail can't be updated
>> in add_transaction_credits(), I think the journal tail should be updated in
>> jbd2_journal_commit_transaction()->jbd2_update_log_tail() since we don't
>> add empty transactions to journal->j_checkpoint_transactions list, the loop
>> in jbd2_journal_commit_transaction() should like this:
>>
>> ...
>> jbd2_journal_commit_transaction()
>>   update_tail = jbd2_journal_get_log_tail()
>>     //journal->j_checkpoint_transactions should be NULL, tid is the
>>     //committing transaction's tid, which should be large than the
>>     //tail tid since the second loop, so this should be true after
>>     //the second loop
>>   if (freed < journal->j_max_transaction_buffers)
>>     update_tail = 0;
>>     //update_tail should be true after j_max_transaction_buffers loop
>>
>> jbd2_update_log_tail()  //j_free should be increased in each
>>                         //j_max_transaction_buffers loop
>>   if (tid_gt(tid, journal->j_tail_sequence)) //it's true
>>   __jbd2_update_log_tail()
>>     journal->j_free += freed; //update log tail and increase j_free
>>                               //j_max_transaction_buffers blocks
>> ...
>>
>> As I understand it, the journal space can't be exhausted, I don't know how
>> it happened, am I missing something?
> 
> Well, at the beginning of the journal there are a few non-empty
> transactions whose buffers didn't get checkpointed before we entered the
> commit loop. So we cannot just push the journal tail without doing a
> checkpoint and we never call into the checkpointing code in the commit
> loop...

Oh, indeed, I see, thanks for explaining and this patch looks good to me.

Reviewed-by: Zhang Yi <yi.zhang@huawei.com>

Thanks,
Yi.


