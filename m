Return-Path: <linux-ext4+bounces-5010-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1F4A9C29A8
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Nov 2024 04:12:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ECEB284E70
	for <lists+linux-ext4@lfdr.de>; Sat,  9 Nov 2024 03:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDDFC4086A;
	Sat,  9 Nov 2024 03:12:39 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA96E364A9
	for <linux-ext4@vger.kernel.org>; Sat,  9 Nov 2024 03:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731121959; cv=none; b=nVN3HBaFlkThNWFwee7AXGo8LOFObgyBizgS/L/MlUS8f5ufZHEoIBzma3bQYAJ5jwaJ3/2URFMgmevfgwQGA+FK0PopOIUK4agaGTqc+bwO6XGWCgjIIt281ENa9hJAZvIxHNQBlizYe7DwU563UiCJ0OqS0L7eXhwIil8QILg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731121959; c=relaxed/simple;
	bh=Q2Xzi7E7Do5zqbXxFokm49zoy9zvvU33mr/Ff1GtLCk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LZ8vwHbIopm9VkLYvV4uyDCdL9X9Tuub9zGn/bLWZowTimTS5Qz3oKg328Vn0UVXbxL1vKpEhdulepZc/KSaJzNmyhMXohh0B9Li57ehjVk0YVWAj0lRjg130h3jNXhC62b477bqxy3wj3PVdalw2yYsrerr31RYKnXVCm00dGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4XlgpW1nvyz4f3kJt
	for <linux-ext4@vger.kernel.org>; Sat,  9 Nov 2024 11:12:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 3C58F1A07B6
	for <linux-ext4@vger.kernel.org>; Sat,  9 Nov 2024 11:12:32 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgCngYUe0y5nL10LBQ--.59930S3;
	Sat, 09 Nov 2024 11:12:32 +0800 (CST)
Message-ID: <acaa68b3-9884-415e-9808-e426068fac53@huaweicloud.com>
Date: Sat, 9 Nov 2024 11:12:30 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2] jbd2: use rhashtable for revoke records during replay
To: Jan Kara <jack@suse.cz>, Li Dongyang <dongyangli@ddn.com>
Cc: linux-ext4@vger.kernel.org, Andreas Dilger <adilger@dilger.ca>,
 Alex Zhuravlev <bzzz@whamcloud.com>
References: <20241105034428.578701-1-dongyangli@ddn.com>
 <20241108103358.ziocxsyapli2pexv@quack3>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <20241108103358.ziocxsyapli2pexv@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgCngYUe0y5nL10LBQ--.59930S3
X-Coremail-Antispam: 1UD129KBjvJXoWxCFyftw4kKry7Xw1UCr18uFg_yoWrXrWUpF
	WkGa4fKFZ0vFy8ZF1kXw4DWFyI9rWkury2gr1qgwsxtws0kr9rXr47tryYgFyYyrZY93WF
	vrWjg3yrCws5tFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUylb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x02
	67AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/11/8 18:33, Jan Kara wrote:
> On Tue 05-11-24 14:44:28, Li Dongyang wrote:
>> Resizable hashtable should improve journal replay time when
>> we have million of revoke records.
>> Notice that rhashtable is used during replay only,
>> as removal with list_del() is less expensive and it's still used
>> during regular processing.
>>
>> before:
>> 1048576 records - 95 seconds
>> 2097152 records - 580 seconds
> 
> These are really high numbers of revoke records. Deleting couple GB of
> metadata doesn't happen so easily. Are they from a real workload or just
> a stress test?
>  
>> after:
>> 1048576 records - 2 seconds
>> 2097152 records - 3 seconds
>> 4194304 records - 7 seconds
> 
> The gains are very nice :).
> 
>> Signed-off-by: Alex Zhuravlev <bzzz@whamcloud.com>
>> Signed-off-by: Li Dongyang <dongyangli@ddn.com>
> 
>> diff --git a/fs/jbd2/recovery.c b/fs/jbd2/recovery.c
>> index 667f67342c52..d9287439171c 100644
>> --- a/fs/jbd2/recovery.c
>> +++ b/fs/jbd2/recovery.c
>> @@ -294,6 +294,10 @@ int jbd2_journal_recover(journal_t *journal)
>>  	memset(&info, 0, sizeof(info));
>>  	sb = journal->j_superblock;
>>  
>> +	err = jbd2_journal_init_recovery_revoke(journal);
>> +	if (err)
>> +		return err;
>> +
>>  	/*
>>  	 * The journal superblock's s_start field (the current log head)
>>  	 * is always zero if, and only if, the journal was cleanly
>> diff --git a/fs/jbd2/revoke.c b/fs/jbd2/revoke.c
>> index 4556e4689024..d6e96099e9c9 100644
>> --- a/fs/jbd2/revoke.c
>> +++ b/fs/jbd2/revoke.c
>> @@ -90,6 +90,7 @@
>>  #include <linux/bio.h>
>>  #include <linux/log2.h>
>>  #include <linux/hash.h>
>> +#include <linux/rhashtable.h>
>>  #endif
>>  
>>  static struct kmem_cache *jbd2_revoke_record_cache;
>> @@ -101,7 +102,10 @@ static struct kmem_cache *jbd2_revoke_table_cache;
>>  
>>  struct jbd2_revoke_record_s
>>  {
>> -	struct list_head  hash;
>> +	union {
>> +		struct list_head  hash;
>> +		struct rhash_head linkage;
>> +	};
>>  	tid_t		  sequence;	/* Used for recovery only */
>>  	unsigned long long	  blocknr;
>>  };
>> @@ -680,13 +684,22 @@ static void flush_descriptor(journal_t *journal,
>>   * single block.
>>   */
>>  
>> +static const struct rhashtable_params revoke_rhashtable_params = {
>> +	.key_len     = sizeof(unsigned long long),
>> +	.key_offset  = offsetof(struct jbd2_revoke_record_s, blocknr),
>> +	.head_offset = offsetof(struct jbd2_revoke_record_s, linkage),
>> +};
>> +
> 
> I'd probably view your performance results as: "JOURNAL_REVOKE_DEFAULT_HASH
> is just too small for replays of a journal with huge numbers of revoked
> blocks". Or did you observe that JOURNAL_REVOKE_DEFAULT_HASH is causing
> performance issues also during normal operation when we track there revokes
> for the current transaction?
> 
> If my interpretation is correct, then rhashtable is unnecessarily huge
> hammer for this. Firstly, as the big hash is needed only during replay,
> there's no concurrent access to the data structure. Secondly, we just fill
> the data structure in the PASS_REVOKE scan and then use it. Thirdly, we
> know the number of elements we need to store in the table in advance (well,
> currently we don't but it's trivial to modify PASS_SCAN to get that
> number). 
> 
> So rather than playing with rhashtable, I'd modify PASS_SCAN to sum up
> number of revoke records we're going to process and then prepare a static
> hash of appropriate size for replay (we can just use the standard hashing
> fs/jbd2/revoke.c uses, just with differently sized hash table allocated for
> replay and point journal->j_revoke to it). And once recovery completes
> jbd2_journal_clear_revoke() can free the table and point journal->j_revoke
> back to the original table. What do you think?
> 

Sounds reasonable to me. I'd vote for this solution, this is a really simple
and clear solution, and I believe it can achieve similar gains as rhashtable.

Thanks,
Yi.


