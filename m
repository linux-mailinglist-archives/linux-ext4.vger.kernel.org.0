Return-Path: <linux-ext4+bounces-1844-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D35E89652E
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 09:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5293B223FD
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Apr 2024 06:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3F6C5CDE1;
	Wed,  3 Apr 2024 06:57:58 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5397B5C8ED;
	Wed,  3 Apr 2024 06:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712127478; cv=none; b=fmS2yZdWT3k4FZeTcnwLbp87irQbAxSiEtsGZWtbh4XxkMPlz/2QuE6Bs6A1cOeyym64le2mGhp1+DYmzqSwtxgaJuTFa4jrvNkH9afseHD44gIawYYfyo24iZPbDFal3m5BHZLIkvrAolqf+NOaG6o0gTh82AXvWP+Ux7TXsy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712127478; c=relaxed/simple;
	bh=oviP/wQRuYdF7r0IFB/Nl/AStCyZNPngIcFJmBU4VRg=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=J9w+I2RjC3IQPRAVKe2sX+n0e4NKW45uXFPulMsgvb2gHSrDyeSNcya1ZgBD8wTUVYUXz6vDKpgtfOoYu43zRXHEINqUziJaeuof5S5TFfkHfqX9hX1zQ96HrgbMVLqXDBhpiM5k539BmBsiFe+s8vu9npDt0B1jkqMC41dkktg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4V8bDD4P6Bz4f3k6Z;
	Wed,  3 Apr 2024 14:57:48 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id D23B71A0DBE;
	Wed,  3 Apr 2024 14:57:52 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP3 (Coremail) with SMTP id _Ch0CgA39p3w_QxmnsAcIw--.36513S2;
	Wed, 03 Apr 2024 14:57:52 +0800 (CST)
Subject: Re: [PATCH 5/5] ext4: expand next_linear_group to remove repeat check
 for linear scan.
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, jack@suse.cz, ritesh.list@gmail.com
References: <20240326213823.528302-1-shikemeng@huaweicloud.com>
 <20240326213823.528302-6-shikemeng@huaweicloud.com>
 <ZgZqPJbEBG09dzSh@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <dd5fd548-bd92-197a-a4e3-7bac173bbd19@huaweicloud.com>
Date: Wed, 3 Apr 2024 14:57:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ZgZqPJbEBG09dzSh@li-bb2b2a4c-3307-11b2-a85c-8fa5c3a69313.ibm.com>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:_Ch0CgA39p3w_QxmnsAcIw--.36513S2
X-Coremail-Antispam: 1UD129KBjvJXoWxCr47Cr4kGFy7CrWxZFW5Wrg_yoWrJr48pr
	s7JFy7ur17XryDGFZrXa9YqF1Sqw18GF4UJryfK3s3tFnxCrn8JFW2yr109Fy7CFsrCr1x
	Xr45AF1UC3ZxCFJanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxk0xIA0c2IEe2xFo4CEbIxvr21l42xK82IYc2Ij
	64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x
	8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE
	2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42
	xK8VAvwI8IcIk0rVW3JVWrJr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbPEf5UUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 3/29/2024 3:14 PM, Ojaswin Mujoo wrote:
> On Wed, Mar 27, 2024 at 05:38:23AM +0800, Kemeng Shi wrote:
>> Expand next_linear_group to remove repat check for linear scan.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
>> ---
>>  fs/ext4/mballoc.c | 37 ++++++-------------------------------
>>  1 file changed, 6 insertions(+), 31 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 0f8a34513bf6..561780a274cd 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -1075,31 +1075,6 @@ static inline int should_optimize_scan(struct ext4_allocation_context *ac)
>>   return 1;
>>  }
>>  
>> -/*
>> - * Return next linear group for allocation. If linear traversal should not be
>> - * performed, this function just returns the same group
>> - */
>> -static ext4_group_t
>> -next_linear_group(struct ext4_allocation_context *ac, ext4_group_t group,
>> -     ext4_group_t ngroups)
>> -{
>> - if (!should_optimize_scan(ac))
>> -   goto inc_and_return;
>> -
>> - if (ac->ac_groups_linear_remaining) {
>> -   ac->ac_groups_linear_remaining--;
>> -   goto inc_and_return;
>> - }
>> -
>> - return group;
>> -inc_and_return:
>> - /*
>> -  * Artificially restricted ngroups for non-extent
>> -  * files makes group > ngroups possible on first loop.
>> -  */
>> - return group + 1 >= ngroups ? 0 : group + 1;
>> -}
>> -
>>  /*
>>   * ext4_mb_choose_next_group: choose next group for allocation.
>>   *
>> @@ -1118,12 +1093,12 @@ static void ext4_mb_choose_next_group(struct ext4_allocation_context *ac,
>>  {
>>   *new_cr = ac->ac_criteria;
>>  
>> - if (!should_optimize_scan(ac) || ac->ac_groups_linear_remaining) {
>> -   *group = next_linear_group(ac, *group, ngroups);
>> -   return;
>> - }
>> -
>> - if (*new_cr == CR_POWER2_ALIGNED) {
>> + if (!should_optimize_scan(ac))
>> +   *group = *group + 1 >= ngroups ? 0 : *group + 1;
>> + else if (ac->ac_groups_linear_remaining) {
>> +   ac->ac_groups_linear_remaining--;
>> +   *group = *group + 1 >= ngroups ? 0 : *group + 1;
>> + } else if (*new_cr == CR_POWER2_ALIGNED) {
> 
> 
> Hi Kemeng, thanks for the cleanups
> 
> I feel that open coding this logic and having a single if for linear scan and
> non linear scan cases is making the code a bit more harder to follow and we are
> losing some comments as well.
> 
> Since our main aim is to avoid the double checking, maybe we can keep
> next_linear_group() strictly for getting the next linear group correctly and
> rest of the checks outside. So something like:
> 
> static ext4_group_t
> next_linear_group(ext4_group_t group, ext4_group_t ngroups)
> {
> 
>   /*
>    * Artificially restricted ngroups for non-extent
>    * files makes group > ngroups possible on first loop.
>    */
>   return group + 1 >= ngroups ? 0 : group + 1;
> }
> 
> static void ext4_mb_choose_next_group(...)
> {
>   ...
> 
>   /*
>    * Fallback to linear scan when optimized scanning is disabled
>    */
>   if (!should_optimize_scan(ac)) {
>     *group = next_linear_group(*group, ngroups);
>     return;
>   }
> 
>   /*
>    * Optimized scanning can return non adjacent groups which can cause
>    * seek overhead for rotational disks. So try few linear groups before 
>    * trying optimized scan.
>    */
>   if (ac->ac_groups_linear_remaining) {
>     *group = next_linear_group(*group, ngroups);
>     ac->ac_groups_linear_remaining--;
>     return;
>   }
>   
>   ...
> }
> 
> Let me know your thought. 
This make senses to me. I will do in next version. Thanks for the advise.

Kemeng
> 
> Regards,
> ojaswin
> 
>>     ext4_mb_choose_next_group_p2_aligned(ac, new_cr, group);
>>   } else if (*new_cr == CR_GOAL_LEN_FAST) {
>>     ext4_mb_choose_next_group_goal_fast(ac, new_cr, group);
>> -- 
>> 2.30.0
>>
> 
> 
> 


