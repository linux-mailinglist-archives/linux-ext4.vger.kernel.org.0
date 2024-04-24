Return-Path: <linux-ext4+bounces-2164-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27A658AFDBD
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 03:20:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6D7C282465
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Apr 2024 01:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E98613D;
	Wed, 24 Apr 2024 01:20:29 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62641538A;
	Wed, 24 Apr 2024 01:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713921628; cv=none; b=hpLyb5CN7pY95h+/W+KQO3fjH5s3QqJ/uS4SXyWrndn6zlqahSYzeOl7/9C3uGsHVSD9nsFrqhD0lfeS0wy79Qf8UHw1vRT9lu9U5k+Isv7e0RAY8so3FhyBoXXdwURUgJGH9XFrKSjaMULmN3ArZDrMqRHwY77OKh1E7VN9/bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713921628; c=relaxed/simple;
	bh=A5LSkyD+X3SdJhODnPm+5H/DBwTMgZT+5Sk7hOxxF2Y=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=OH5Jk4XeyEWrelxVyQCZhHpHbMYlrtnggD+nQG5kr3bZ4CHHqR5h7dWzDI7rBp9/eQa4FL/4Jvs+nfwxbh3nyWV6IZjUWYALCBcOj4zdnSBzsAxokaTpazS6Fz1ah+4nNZRIvw0K6cr3kHQeInkXhFm5ZiH2rsY47veY5cqw4lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VPLkz2mmMz4f3kk3;
	Wed, 24 Apr 2024 09:20:11 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 3A7021A0572;
	Wed, 24 Apr 2024 09:20:16 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP1 (Coremail) with SMTP id cCh0CgBXcgtPXihmEE4vKw--.39462S2;
	Wed, 24 Apr 2024 09:20:16 +0800 (CST)
Subject: Re: [PATCH v2 4/5] ext4: use correct criteria name instead stale
 integer number in comment
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com, ritesh.list@gmail.com
References: <20240423124046.974134-1-shikemeng@huaweicloud.com>
 <20240423124046.974134-5-shikemeng@huaweicloud.com>
 <20240423214352.t7yelmtvfbu7oggi@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <383b74d7-3d9c-9140-29d7-b62023098c27@huaweicloud.com>
Date: Wed, 24 Apr 2024 09:20:15 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240423214352.t7yelmtvfbu7oggi@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:cCh0CgBXcgtPXihmEE4vKw--.39462S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tr13Kr4xWF4kuryfCw45KFg_yoW8uw17pr
	Z7JF40kr4fWF1Uur4UG3WUu3W8Kw4vgryUGry3Wr17WrZIqryfAF1DKFyY9rykCrs5G3WF
	qFZ29F97AF1F9FDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUOyCJDUUUU
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 4/24/2024 5:43 AM, Jan Kara wrote:
> On Tue 23-04-24 20:40:45, Kemeng Shi wrote:
>> Use correct criteria name instead stale integer number in comment
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
> 
> You have cleaned up the superfluous "CR=" bits in several places but still
> left them is couple more :). See below:
Sorry, It seems that I mis-understand what you mean in last reply. I will
clean up all unnecessary stuff like "CR=" in next version. Thanks for the
feedback.

Kemeng
> 
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 5acf413808a2..71b2f9a18875 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -1131,8 +1131,9 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>>  		ext4_mb_choose_next_group_best_avail(ac, new_cr, group);
>>  	} else {
>>  		/*
>> -		 * TODO: For CR=2, we can arrange groups in an rb tree sorted by
>> -		 * bb_free. But until that happens, we should never come here.
>> +		 * TODO: For CR=CR_GOAL_LEN_SLOW, we can arrange groups in an
> 			     ^^^ Still you have left these superfluous
> "CR=" bits here.
>  
>> +		 * rb tree sorted by bb_free. But until that happens, we should
>> +		 * never come here.
>>  		 */
>>  		WARN_ON(1);
>>  	}
>> @@ -3445,10 +3446,11 @@ static int ext4_mb_init_backend(struct super_block *sb)
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
>            ^^^  and here               ^^^
> 
>> +	 * optimization we shouldn't try to load too many groups, at some point
>> +	 * we should start to use what we've got in memory.
>>  	 * with an average random access time 5ms, it'd take a second to get
>>  	 * 200 groups (* N with flex_bg), so let's make this limit 4
>>  	 */
> 
> 								Honza
> 


