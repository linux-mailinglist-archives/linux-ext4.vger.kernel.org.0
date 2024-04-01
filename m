Return-Path: <linux-ext4+bounces-1805-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6C2389386D
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 08:34:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 26DD4B212FC
	for <lists+linux-ext4@lfdr.de>; Mon,  1 Apr 2024 06:34:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 706F59468;
	Mon,  1 Apr 2024 06:33:38 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF8761113;
	Mon,  1 Apr 2024 06:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711953218; cv=none; b=Vgr2kdJYcewgfFTCqIjKa+xDrH6Qjim4UvTwP/V3CxvGNs10JqQjub5IWk0hbglvrb3f6VjPH1ltNcrIW/CtB6RruSJBysxtxaPRC5v8L0RFmP6NunTWX2siBA6luqJMg3Zp+VODu6BDn7EAZuC+BHAsI0BjgwzVnbSluqfMRIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711953218; c=relaxed/simple;
	bh=PNG4VBts3Kg/mNdlbfPTrsTGd5iVBdJf5h8l6k0u7bw=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=nHIGgNC49rhWKbvwH28jU0VT7o+reFvF8XbjkhJPJxp+FvunYEUxxYqsrzHcivOCWycKSzinqYhy5uk30VhLhunv8fyH5MZZuLsEct38QhXzdgVQTkiBKpSL2oyvTUBDS3x04oVlmmKKgyYbn7j3teLB14QTt9Z5heNoNX//4As=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4V7Lk72Wzpz1QBw6;
	Mon,  1 Apr 2024 14:30:55 +0800 (CST)
Received: from canpemm500010.china.huawei.com (unknown [7.192.105.118])
	by mail.maildlp.com (Postfix) with ESMTPS id B21E41402E2;
	Mon,  1 Apr 2024 14:33:26 +0800 (CST)
Received: from [10.174.178.185] (10.174.178.185) by
 canpemm500010.china.huawei.com (7.192.105.118) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 1 Apr 2024 14:33:26 +0800
Subject: Re: [PATCH] jbd2: use shrink_type type instead of bool type for
 __jbd2_journal_clean_checkpoint_list()
To: "Darrick J. Wong" <djwong@kernel.org>
References: <20240401011614.3650958-1-yebin10@huawei.com>
 <20240401024417.GA739535@frogsfrogsfrogs>
CC: <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <linux-ext4@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <jack@suse.cz>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <660A5535.7080005@huawei.com>
Date: Mon, 1 Apr 2024 14:33:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240401024417.GA739535@frogsfrogsfrogs>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)



On 2024/4/1 10:44, Darrick J. Wong wrote:
> On Mon, Apr 01, 2024 at 09:16:14AM +0800, Ye Bin wrote:
>> "enum shrink_type" can clearly express the meaning of the parameter of
>> __jbd2_journal_clean_checkpoint_list(), and there is no need to use the
>> bool type.
>>
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/jbd2/checkpoint.c | 9 +++------
>>   fs/jbd2/commit.c     | 2 +-
>>   include/linux/jbd2.h | 4 +++-
>>   3 files changed, 7 insertions(+), 8 deletions(-)
>>
>> diff --git a/fs/jbd2/checkpoint.c b/fs/jbd2/checkpoint.c
>> index 1c97e64c4784..d6e8b80a4078 100644
>> --- a/fs/jbd2/checkpoint.c
>> +++ b/fs/jbd2/checkpoint.c
>> @@ -337,8 +337,6 @@ int jbd2_cleanup_journal_tail(journal_t *journal)
>>   
>>   /* Checkpoint list management */
>>   
>> -enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
>> -
>>   /*
>>    * journal_shrink_one_cp_list
>>    *
>> @@ -476,17 +474,16 @@ unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal,
>>    *
>>    * Called with j_list_lock held.
>>    */
>> -void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy)
>> +void __jbd2_journal_clean_checkpoint_list(journal_t *journal,
>> +					  enum shrink_type type)
>>   {
>>   	transaction_t *transaction, *last_transaction, *next_transaction;
>> -	enum shrink_type type;
>>   	bool released;
>>   
>>   	transaction = journal->j_checkpoint_transactions;
>>   	if (!transaction)
>>   		return;
>>   
>> -	type = destroy ? SHRINK_DESTROY : SHRINK_BUSY_STOP;
> What is supposed to happen if the caller passes in SHRINK_BUSY_SKIP?
>
> --D

If SHRING_BUSY_SKIP is passed, the buffers in use will be skipped during traversal
and release.Currently, SHRINKING_BUSY_SKIP is used in the memory reclamation process.

>>   	last_transaction = transaction->t_cpprev;
>>   	next_transaction = transaction;
>>   	do {
>> @@ -527,7 +524,7 @@ void jbd2_journal_destroy_checkpoint(journal_t *journal)
>>   			spin_unlock(&journal->j_list_lock);
>>   			break;
>>   		}
>> -		__jbd2_journal_clean_checkpoint_list(journal, true);
>> +		__jbd2_journal_clean_checkpoint_list(journal, SHRINK_DESTROY);
>>   		spin_unlock(&journal->j_list_lock);
>>   		cond_resched();
>>   	}
>> diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
>> index 5e122586e06e..78ebd04ac97d 100644
>> --- a/fs/jbd2/commit.c
>> +++ b/fs/jbd2/commit.c
>> @@ -501,7 +501,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
>>   	 * frees some memory
>>   	 */
>>   	spin_lock(&journal->j_list_lock);
>> -	__jbd2_journal_clean_checkpoint_list(journal, false);
>> +	__jbd2_journal_clean_checkpoint_list(journal, SHRINK_BUSY_STOP);
>>   	spin_unlock(&journal->j_list_lock);
>>   
>>   	jbd2_debug(3, "JBD2: commit phase 1\n");
>> diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
>> index 971f3e826e15..58a961999d70 100644
>> --- a/include/linux/jbd2.h
>> +++ b/include/linux/jbd2.h
>> @@ -1434,7 +1434,9 @@ void jbd2_update_log_tail(journal_t *journal, tid_t tid, unsigned long block);
>>   extern void jbd2_journal_commit_transaction(journal_t *);
>>   
>>   /* Checkpoint list management */
>> -void __jbd2_journal_clean_checkpoint_list(journal_t *journal, bool destroy);
>> +enum shrink_type {SHRINK_DESTROY, SHRINK_BUSY_STOP, SHRINK_BUSY_SKIP};
>> +
>> +void __jbd2_journal_clean_checkpoint_list(journal_t *journal, enum shrink_type type);
>>   unsigned long jbd2_journal_shrink_checkpoint_list(journal_t *journal, unsigned long *nr_to_scan);
>>   int __jbd2_journal_remove_checkpoint(struct journal_head *);
>>   int jbd2_journal_try_remove_checkpoint(struct journal_head *jh);
>> -- 
>> 2.31.1
>>
>>
> .
>


