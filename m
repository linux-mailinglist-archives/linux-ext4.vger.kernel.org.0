Return-Path: <linux-ext4+bounces-1909-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73C7E89AE43
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 05:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F263E1F21709
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Apr 2024 03:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18684107A8;
	Sun,  7 Apr 2024 03:21:08 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8701C101C6;
	Sun,  7 Apr 2024 03:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712460067; cv=none; b=kbU2gi54RxD81XLwn7Nt2Ij/OAxDFAwVzUBKYKHL36BNQ7oMCWjcAD4QzRV9alu7M3GnVYMk0hCP5a7j4l5Tf2gp006ehIpEvK0LnrgSEWBCkBD4Arf8zP6+fpcSA1ckWx/7/+eNwzwy6DX2cmsNuhBP+dojtYQiTVcibMM/0eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712460067; c=relaxed/simple;
	bh=RkAQVz1NwgLuqJBQzheIGUTZ0PnsFJ6BSh0laUYiZGs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YhmGKp7kftl/Q/es/sn4h49hzrD8qmr99a5wE0lx7K+e7JoVxtYs+3nCfQGmDuCm/4hHdjZz9iztDBjWgwQ9uO1GHGXsm4uq9WQrU5CKe77sK8ZokwZh1Gpr8bS4zyvCE9EUk3SPImKhArojzlEbxHBLA+wi9MnZ5Wph3ltwhOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VByD55W4mz4f3m76;
	Sun,  7 Apr 2024 11:20:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 49F791A0199;
	Sun,  7 Apr 2024 11:21:02 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP4 (Coremail) with SMTP id gCh0CgBXqGodERJmm53fJQ--.28680S2;
	Sun, 07 Apr 2024 11:21:02 +0800 (CST)
Subject: Re: [PATCH 4/5] ext4: use correct criteria name instead stale integer
 number in comment
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
 <20240326213823.528302-5-shikemeng@huaweicloud.com>
 <20240404141902.t5ut465q7vxusoa6@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <564b0dd6-5903-0bb6-39b4-a838c8c54e64@huaweicloud.com>
Date: Sun, 7 Apr 2024 11:21:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240404141902.t5ut465q7vxusoa6@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBXqGodERJmm53fJQ--.28680S2
X-Coremail-Antispam: 1UD129KBjvJXoWxWr17CF4UWw18JrWruF1Utrb_yoWrWr1kp3
	95AF18Kw4SqF1Uu397Wa1UG3W2gw409r1UGr1fur1xCF9agr1kKr95KrWFkFy0yr4kC3Wr
	XF97XFW8CF4S93DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUk0b4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVWrJr0_WFyUJwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv
	6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 4/4/2024 10:19 PM, Jan Kara wrote:
> On Wed 27-03-24 05:38:22, Kemeng Shi wrote:
>> Use correct criteria name instead stale integer number in comment
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Looks good. But since the symbolic names already have CR prefix, we
> probably don't have to write e.g.:
> 
> /* Large fragment size list lookup succeeded at least once for cr =
>  * CR_POWER2_ALIGNED */
> 
> But we can write directly:
> 
> /* Large fragment size list lookup succeeded at least once for
>  * CR_POWER2_ALIGNED */
Sure, will do it in next version. Thanks.

Kemeng
> 
> 								Honza
> 
>> ---
>>  fs/ext4/ext4.h    | 15 ++++++++++++---
>>  fs/ext4/mballoc.c | 14 ++++++++------
>>  fs/ext4/mballoc.h |  4 ++--
>>  3 files changed, 22 insertions(+), 11 deletions(-)
>>
>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>> index 023571f8dd1b..9b90013c59a3 100644
>> --- a/fs/ext4/ext4.h
>> +++ b/fs/ext4/ext4.h
>> @@ -213,11 +213,20 @@ enum criteria {
>>  #define EXT4_MB_USE_RESERVED		0x2000
>>  /* Do strict check for free blocks while retrying block allocation */
>>  #define EXT4_MB_STRICT_CHECK		0x4000
>> -/* Large fragment size list lookup succeeded at least once for cr = 0 */
>> +/*
>> + * Large fragment size list lookup succeeded at least once for cr =
>> + * CR_POWER2_ALIGNED
>> + */
>>  #define EXT4_MB_CR_POWER2_ALIGNED_OPTIMIZED		0x8000
>> -/* Avg fragment size rb tree lookup succeeded at least once for cr = 1 */
>> +/*
>> + * Avg fragment size rb tree lookup succeeded at least once for cr =
>> + * CR_GOAL_LEN_FAST
>> + */
>>  #define EXT4_MB_CR_GOAL_LEN_FAST_OPTIMIZED		0x00010000
>> -/* Avg fragment size rb tree lookup succeeded at least once for cr = 1.5 */
>> +/*
>> + * Avg fragment size rb tree lookup succeeded at least once for cr =
>> + * CR_BEST_AVAIL_LEN
>> + */
>>  #define EXT4_MB_CR_BEST_AVAIL_LEN_OPTIMIZED		0x00020000
>>  
>>  struct ext4_allocation_request {
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 62d468379722..0f8a34513bf6 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -1131,8 +1131,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>>  		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
>>  	} else {
>>  		/*
>> -		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
>> -		 * bb_free. But until that happens, we should never come here.
>> +		 * TODO: For CR=CR_GOAL_LEN_SLOW, we can arrange groups in an
>> +		 * rb tree sorted by bb_free. But until that happens, we should
>> +		 * never come here.
>>  		 */
>>  		WARN_ON(1);
>>  	}
>> @@ -3444,10 +3445,11 @@ static int ext4_mb_init_backend(struct super_block *sb)
>>  	}
>>  	if (sbi->s_mb_prefetch > ext4_get_groups_count(sb))
>>  		sbi->s_mb_prefetch = ext4_get_groups_count(sb);
>> -	/* now many real IOs to prefetch within a single allocation at cr=0
>> -	 * given cr=0 is an CPU-related optimization we shouldn't try to
>> -	 * load too many groups, at some point we should start to use what
>> -	 * we've got in memory.
>> +	/*
>> +	 * now many real IOs to prefetch within a single allocation at
>> +	 * cr=CR_POWER2_ALIGNED. Given cr=CR_POWER2_ALIGNED is an CPU-related
>> +	 * optimization we shouldn't try to load too many groups, at some point
>> +	 * we should start to use what we've got in memory.
>>  	 * with an average random access time 5ms, it'd take a second to get
>>  	 * 200 groups (* N with flex_bg), so let's make this limit 4
>>  	 */
>> diff --git a/fs/ext4/mballoc.h b/fs/ext4/mballoc.h
>> index 56938532b4ce..042437d8860f 100644
>> --- a/fs/ext4/mballoc.h
>> +++ b/fs/ext4/mballoc.h
>> @@ -187,8 +187,8 @@ struct ext4_allocation_context {
>>  	struct ext4_free_extent ac_f_ex;
>>  
>>  	/*
>> -	 * goal len can change in CR1.5, so save the original len. This is
>> -	 * used while adjusting the PA window and for accounting.
>> +	 * goal len can change in CR_BEST_AVAIL_LEN, so save the original len.
>> +	 * This is used while adjusting the PA window and for accounting.
>>  	 */
>>  	ext4_grpblk_t	ac_orig_goal_len;
>>  
>> -- 
>> 2.30.0
>>


