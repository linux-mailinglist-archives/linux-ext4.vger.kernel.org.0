Return-Path: <linux-ext4+bounces-1910-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A2B489AEDB
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 08:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E5FA1C2157F
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 06:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C716F7483;
	Sun,  7 Apr 2024 06:31:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41C9A1C0DF9;
	Sun,  7 Apr 2024 06:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712471482; cv=none; b=JQ8qNmz0rmtQmH38vJ/CX7RDun/nvU09qLTGgcZch6b2LRZjIHtvWH+NmEMiXF4AaxkJV5/k37F6wB1nXMyMhjj7jNqo6QDGhXFJMGnINDhRa3ec07VnlbJYgzy9ASCFgzl3vgMJ6m6JKG3YHmXMeleOJDI3j32MjUMVcEvGk1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712471482; c=relaxed/simple;
	bh=3JWEWAeIVJ459wbNNlX3ilFIm7zaw0kMCtuDrp3HQqs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YCZhd72hpBq4DsdkRNyMSfRg9Ecx5qYU6Xfg2KNlZOAPqXi+bjmcNfH5hx+mg1a/pmWkEFgOUmqq8PpFuvWjUxWovHitD1chJePPDfjyan6f70tAitQ/9XMV7SgwCLLt1XDkdwbH9pgItDhwNfbJTHFTSPfFzaaGrqcxX72UqA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VC2Rc6Gshz4f3kp7;
	Sun,  7 Apr 2024 14:31:08 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 8FE6E1A0175;
	Sun,  7 Apr 2024 14:31:15 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgDXpg+yPRJmqZJGJQ--.52650S2;
	Sun, 07 Apr 2024 14:31:15 +0800 (CST)
Subject: Re: [PATCH 3/5] ext4: call ext4_mb_mark_free_simple in mb_mark_used
 to clear bits
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
 <20240326213823.528302-4-shikemeng@huaweicloud.com>
 <20240404141619.xrgtjhtpcae3kqk6@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <c213a5ca-87c9-76ae-2c0d-a80e13491ac1@huaweicloud.com>
Date: Sun, 7 Apr 2024 14:31:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240404141619.xrgtjhtpcae3kqk6@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgDXpg+yPRJmqZJGJQ--.52650S2
X-Coremail-Antispam: 1UD129KBjvJXoW3AF1ruw18tFW3Aw4xtryUtrb_yoW7uw48pF
	W2gFWfGr4vqryv9F4DWw1jq34xtw4xtFW7CryrG3W5JwnxAr9a9r48Kry5Z3WkZrs3CryI
	yF4Uu398Grs7KFDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkjb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrZr1j6s0DMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIE
	c7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 4/4/2024 10:16 PM, Jan Kara wrote:
> On Wed 27-03-24 05:38:21, Kemeng Shi wrote:
>> Function ext4_mb_mark_free_simple could search order for bit clearing in
>> O(1) cost while mb_mark_used will search order in O(distance from chunk
>> order to target order) and introduce unnecessary bit flips.
> 
> Let me see if I understand you right. I agree that mb_mark_used() is
> actually O(log(bitmap_size)^2) because each call to
> mb_find_order_for_block() is O(log(bitmap_size)). Do I understand your
> concern right?
Sorry for the confusion. Actually it's times to do bit clear after
mb_find_order_for_block to mark partial part of block chunk free.

In mb_mark_used, we will find free chunk and mark it in use. For chunk
in mid of passed range, we could simply mark whole chunk in use. For chunk
in end of range, we need to mark partial part of chunk inuse. To only mark
partial part of chunk inuse, we firstly mark whole chunk inuse and then
do serveral times of bit clear work by "mb_find_buddy(...);
mb_clear_bit(...); ..." mark partial part of chunk free. The times to call
"mb_find_buddy(); ..." is [order of free chunk] - [last order to free partial
part of chunk], which is what I mean "distance from chunk order to target order"
in changelog.

The repeat "mb_find_buddy(...); ..." aims to mark continuous range blocks
free which is excat the work ext4_mb_mark_free_simple has done and
ext4_mb_mark_free_simple does in a more effective way than code to free
blocks in mb_mark_used. So we can simply find the range need to set free in
chunk at end of range and call ext4_mb_mark_free_simple to use the effective
and exsiting code to free a continuous range of blocks.

> 
>> Consider we have 4 continuous free bits and going to mark bit 0-2 inuse.
>> initial state of buddy bitmap:
>> order 2 |           0           |
>> order 1 |     1     |     1     |
>> order 0 |  1  |  1  |  1  |  1  |
>>
>> mark whole chunk inuse
>> order 2 |           1           |
>> order 1 |     1     |     1     |
>> order 0 |  1  |  1  |  1  |  1  |
>>
>> split chunk to order 1
>> order 2 |           1           |
>> order 1 |     0     |     0     |
>> order 0 |  1  |  1  |  1  |  1  |
>>
>> set the first bit in order 1 to mark bit 0-1 inuse
>> set the second bit in order 1 for split
>> order 2 |           1           |
>> order 1 |     1     |     1     |
>> order 0 |  1  |  1  |  1  |  1  |
>>
>> step 3: split the second bit in order 1 to order 0
>> order 2 |           1           |
>> order 1 |     1     |     1     |
>> order 0 |  1  |  1  |  0  |  0  |
>>
>> step 4: set the third bit in order 0 to mark bit 2 inuse.
>> order 2 |           1           |
>> order 1 |     1     |     1     |
>> order 0 |  1  |  1  |  1  |  0  |
>> There are two unnecessary splits and three unnecessary bit flips.
>>
>> With ext4_mb_mark_free_simple, we will clear the 4th bit in order 0
>> with O(1) search and no extra bit flip.
> 
> However this looks like a bit ugly way to speed it up, I'm not even sure
> this would result in practical speedups and asymptotically, I think the
> complexity is still O(log^2). Also the extra bit flips are not really a
> concern I'd say as they are in the same cacheline anyway. The unnecessary
> overhead (if at all measurable) comes from the O(log^2) behavior. And there
> I agree we could do better by not starting the block order search from 1 in
> all the cases - we know the found order will be first increasing for some
> time and then decreasing again so with some effort we could amortize all
> block order searches to O(log) time. But it makes the code more complex and
> I'm not conviced this is all worth it. So if you want to go this direction,
> then please provide (micro-)benchmarks from real hardware (not just
> theoretical cost estimations) showing the benefit. Thanks.
> 
> 								Honza
> 
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index a61fc52956b2..62d468379722 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2040,13 +2040,12 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
>>  	int ord;
>>  	int mlen = 0;
>>  	int max = 0;
>> -	int cur;
>>  	int start = ex->fe_start;
>>  	int len = ex->fe_len;
>>  	unsigned ret = 0;
>>  	int len0 = len;
>>  	void *buddy;
>> -	bool split = false;
>> +	int ord_start, ord_end;
>>  
>>  	BUG_ON(start + len > (e4b->bd_sb->s_blocksize << 3));
>>  	BUG_ON(e4b->bd_group != ex->fe_group);
>> @@ -2071,16 +2070,12 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
>>  
>>  	/* let's maintain buddy itself */
>>  	while (len) {
>> -		if (!split)
>> -			ord = mb_find_order_for_block(e4b, start);
>> +		ord = mb_find_order_for_block(e4b, start);
>>  
>>  		if (((start >> ord) << ord) == start && len >= (1 << ord)) {
>>  			/* the whole chunk may be allocated at once! */
>>  			mlen = 1 << ord;
>> -			if (!split)
>> -				buddy = mb_find_buddy(e4b, ord, &max);
>> -			else
>> -				split = false;
>> +			buddy = mb_find_buddy(e4b, ord, &max);
>>  			BUG_ON((start >> ord) >= max);
>>  			mb_set_bit(start >> ord, buddy);
>>  			e4b->bd_info->bb_counters[ord]--;
>> @@ -2094,20 +2089,28 @@ static int mb_mark_used(struct ext4_buddy *e4b, struct ext4_free_extent *ex)
>>  		if (ret == 0)
>>  			ret = len | (ord << 16);
>>  
>> -		/* we have to split large buddy */
>>  		BUG_ON(ord <= 0);
>>  		buddy = mb_find_buddy(e4b, ord, &max);
>>  		mb_set_bit(start >> ord, buddy);
>>  		e4b->bd_info->bb_counters[ord]--;
>>  
>> -		ord--;
>> -		cur = (start >> ord) & ~1U;
>> -		buddy = mb_find_buddy(e4b, ord, &max);
>> -		mb_clear_bit(cur, buddy);
>> -		mb_clear_bit(cur + 1, buddy);
>> -		e4b->bd_info->bb_counters[ord]++;
>> -		e4b->bd_info->bb_counters[ord]++;
>> -		split = true;
>> +		ord_start = (start >> ord) << ord;
>> +		ord_end = ord_start + (1 << ord);
>> +		if (start > ord_start)
>> +			ext4_mb_mark_free_simple(e4b->bd_sb, e4b->bd_buddy,
>> +						 ord_start, start - ord_start,
>> +						 e4b->bd_info);
>> +
>> +		if (start + len < ord_end) {
>> +			ext4_mb_mark_free_simple(e4b->bd_sb, e4b->bd_buddy,
>> +						 start + len,
>> +						 ord_end - (start + len),
>> +						 e4b->bd_info);
>> +			break;
>> +		}
>> +
>> +		len = start + len - ord_end;
>> +		start = ord_end;
>>  	}
>>  	mb_set_largest_free_order(e4b->bd_sb, e4b->bd_info);
>>  
>> -- 
>> 2.30.0
>>


