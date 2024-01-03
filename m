Return-Path: <linux-ext4+bounces-630-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5DF67822689
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 02:27:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 711281C22BEB
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 01:27:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1DCF10F1;
	Wed,  3 Jan 2024 01:27:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01345136B;
	Wed,  3 Jan 2024 01:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4T4XC13vzDz4f3p0h;
	Wed,  3 Jan 2024 09:27:25 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 34D5A1A0980;
	Wed,  3 Jan 2024 09:27:31 +0800 (CST)
Received: from [10.174.178.129] (unknown [10.174.178.129])
	by APP2 (Coremail) with SMTP id Syh0CgDHaEcCuJRlaO8AFg--.64435S2;
	Wed, 03 Jan 2024 09:27:31 +0800 (CST)
Subject: Re: [PATCH 8/8] ext4: remove unnecessary parameter "needed" in
 ext4_discard_preallocations
To: Jan Kara <jack@suse.cz>
Cc: tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231125161143.3945726-1-shikemeng@huaweicloud.com>
 <20231125161143.3945726-9-shikemeng@huaweicloud.com>
 <20240102131058.3ue6phafczjezlic@quack3>
From: Kemeng Shi <shikemeng@huaweicloud.com>
Message-ID: <48611a18-004f-7721-cc1f-104a5980b6cf@huaweicloud.com>
Date: Wed, 3 Jan 2024 09:27:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20240102131058.3ue6phafczjezlic@quack3>
Content-Type: text/plain; charset=gbk
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDHaEcCuJRlaO8AFg--.64435S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4fWFWUJF4kCrWrAw48Xrb_yoW8XF1rp3
	yUAa1UWw13Xr1fCFnxXw4DGFW3Cay0ya1UJ39aqw4UZFsxGFn3Krnrta1YqFy8ZryrZayY
	vFy0v3srXr1xZ37anT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
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
	c7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1CPfJUUUUU==
X-CM-SenderInfo: 5vklyvpphqwq5kxd4v5lfo033gof0z/



on 1/2/2024 9:10 PM, Jan Kara wrote:
> On Sun 26-11-23 00:11:43, Kemeng Shi wrote:
>> The "needed" controls the number of ext4_prealloc_space to discard in
>> ext4_discard_preallocations. Function ext4_discard_preallocations is
>> supposed to discard all non-used preallocated blocks when "needed"
>> is 0 and now ext4_discard_preallocations is always called with "needed"
>> = 0. Remove unnecessary parameter "needed" and remove all non-used
>> preallocated spaces in ext4_discard_preallocations to simplify the
>> code.
>>
>> Note: If count of non-used preallocated spaces could be more than
>> UINT_MAX, there was a memory leak as some non-used preallocated
>> spaces are left unused and this commit will fix it. Otherwise,
>> there is no behavior change.
>>
>> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> 
> Looks good, just one nit:
> 
>> @@ -5491,15 +5491,12 @@ void ext4_discard_preallocations(struct inode *inode, unsigned int needed)
>>  	mb_debug(sb, "discard preallocation for inode %lu\n",
>>  		 inode->i_ino);
>>  	trace_ext4_discard_preallocations(inode,
>> -			atomic_read(&ei->i_prealloc_active), needed);
>> -
>> -	if (needed == 0)
>> -		needed = UINT_MAX;
>> +			atomic_read(&ei->i_prealloc_active), 0);
> 
> There's no point in always returning 0 in the tracepoint so I'd just update
> it to not print the 'needed' value as well.
Thanks for review! Sure, 'needed' looks meaningless to the tracepoint. I
will remove it in next version.
> 
> 								Honza
> 


