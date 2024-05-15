Return-Path: <linux-ext4+bounces-2524-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A0128C6653
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 14:24:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97DE4B220F1
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 12:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A23E757EA;
	Wed, 15 May 2024 12:24:46 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E40B7441E;
	Wed, 15 May 2024 12:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715775886; cv=none; b=BRbXIU44S7m5sQj69YaJz6vavjyGsDKkXOtTN4lIKgX+Xuvm/IDNhNfeBhLB9HrZdWio+g9aY3w9+3QT+WxYL6PWsFZEpKfq2vubWVR94VWhosMWua0QOkS6QLdi7NezYIrhgKybyA6s2SeEu4AhIwO8KnJ/VEERmyzvaV2C1hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715775886; c=relaxed/simple;
	bh=Vi3DMStynANqDvcSyP4wkj3O7cFzEbgWMU8747o3rgs=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=VS/jNcApcz4p2p3QccVLUCuqIHlzAGCbE8VW/qbCU2cU6nnBTq8Oi2QHFP8Xuomic6h3j9Nfi2K7vzPsD/hEm0Mnic4iQhmWF43NkVsKy1JBM7055ZSkVZJd6D/9lA5gfF0i3ekBHVq/Z+5ht3hpRyYGgFhTQsH6ba3fvd9jeTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4VfXTn1Fvbz4f3mHN;
	Wed, 15 May 2024 20:24:29 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 596541A09F4;
	Wed, 15 May 2024 20:24:39 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgAnmAuFqURmvD0qNA--.725S3;
	Wed, 15 May 2024 20:24:39 +0800 (CST)
Subject: Re: [PATCH] ext4: fix infinite loop when replaying fast_commit
To: Luis Henriques <luis.henriques@linux.dev>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
 Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20240510115252.11850-1-luis.henriques@linux.dev>
 <2ee78957-b0a6-f346-5957-c4b2ebcea4ce@huaweicloud.com>
 <87o798a6k5.fsf@brahms.olymp>
 <a49a72d2-98aa-1c87-fc3a-58cae0f90257@huaweicloud.com>
 <87pltniimq.fsf@brahms.olymp>
 <326db1c7-1064-d19c-0028-d2149c61f6f5@huaweicloud.com>
 <87bk57phel.fsf@brahms.olymp>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <1e74a7e2-dffb-8468-92a1-ad06a90de7ab@huaweicloud.com>
Date: Wed, 15 May 2024 20:24:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87bk57phel.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAnmAuFqURmvD0qNA--.725S3
X-Coremail-Antispam: 1UD129KBjvJXoW3Ww45Jw4fGrW5Cw1rKrWUtwb_yoW7WF1xpF
	yxZF1Utr4UJ34UGr47tw48Xr1Yyr4xJw4UXry5trn5JFn8trn7XF18tF4YkFykGrWxGF1j
	vF4Utay7CFn8AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCF04k20xvY0x0E
	wIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E74
	80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0
	I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04
	k26cxKx2IYs7xG6rW3Jr0E3s1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1zuWJUUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/15 17:13, Luis Henriques wrote:
> On Wed 15 May 2024 04:52:54 PM +08, Zhang Yi wrote;
> 
>> On 2024/5/15 16:28, Luis Henriques wrote:
>>> On Wed 15 May 2024 12:59:26 PM +08, Zhang Yi wrote;
>>>
>>>> On 2024/5/14 21:04, Luis Henriques wrote:
>>>>> On Sat 11 May 2024 02:24:17 PM +08, Zhang Yi wrote;
>>>>>
>>>>>> On 2024/5/10 19:52, Luis Henriques (SUSE) wrote:
>>>>>>> When doing fast_commit replay an infinite loop may occur due to an
>>>>>>> uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
>>>>>>> not detect the replay and calls ext4_es_find_extent_range(), which will
>>>>>>> return immediately without initializing the 'es' variable.
>>>>>>>
>>>>>>> Because 'es' contains garbage, an integer overflow may happen causing an
>>>>>>> infinite loop in this function, easily reproducible using fstest generic/039.
>>>>>>>
>>>>>>> This commit fixes this issue by detecting the replay in function
>>>>>>> ext4_ext_determine_insert_hole().  It also adds initialization code to the
>>>>>>> error path in function ext4_es_find_extent_range().
>>>>>>>
>>>>>>> Thanks to Zhang Yi, for figuring out the real problem!
>>>>>>>
>>>>>>> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
>>>>>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>>>>>> ---
>>>>>>> Hi!
>>>>>>>
>>>>>>> Two comments:
>>>>>>> 1) The change in ext4_ext_map_blocks() could probably use the min_not_zero
>>>>>>>    macro instead.  I decided not to do so simply because I wasn't sure if
>>>>>>>    that would be safe, but I'm fine changing that if you think it is.
>>>>>>>
>>>>>>> 2) I thought about returning 'EXT_MAX_BLOCKS' instead of '0' in
>>>>>>>    ext4_lblk_t ext4_ext_determine_insert_hole(), which would then avoid
>>>>>>>    the extra change to ext4_ext_map_blocks().  '0' sounds like the right
>>>>>>>    value to return, but I'm also OK using 'EXT_MAX_BLOCKS' instead.
>>>>>>>
>>>>>>> And again thanks to Zhang Yi for pointing me the *real* problem!
>>>>>>>
>>>>>>>  fs/ext4/extents.c        | 6 +++++-
>>>>>>>  fs/ext4/extents_status.c | 5 ++++-
>>>>>>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>>>>>>
>>>>>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>>>>>> index e57054bdc5fd..b5bfcb6c18a0 100644
>>>>>>> --- a/fs/ext4/extents.c
>>>>>>> +++ b/fs/ext4/extents.c
>>>>>>> @@ -4052,6 +4052,9 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
>>>>>>>  	ext4_lblk_t hole_start, len;
>>>>>>>  	struct extent_status es;
>>>>>>>  
>>>>>>> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>>>>>>> +		return 0;
>>>>>>> +
>>>>>>
>>>>>> Sorry, I think it's may not correct. When replaying the jouranl, although
>>>>>> we don't use the extent statue tree, we still need to query the accurate
>>>>>> hole length, e.g. please see skip_hole(). If you do this, the hole length
>>>>>> becomes incorrect, right?
>>>>>
>>>>> Thank you for your review (and sorry for my delay replying).
>>>>>
>>>>> So, I see three different options to follow your suggestion:
>>>>>
>>>>> 1) Initialize 'es' immediately when declaring it in function
>>>>>    ext4_ext_determine_insert_hole():
>>>>>
>>>>> 	es.es_lblk = es.es_len = es.es_pblk = 0;
>>>>>
>>>>> 2) Initialize 'es' only in ext4_es_find_extent_range() when checking if an
>>>>>    fc replay is in progress (my patch was already doing something like
>>>>>    that):
>>>>>
>>>>> 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) {
>>>>> 		/* Initialize extent to zero */
>>>>> 		es->es_lblk = es->es_len = es->es_pblk = 0;
>>>>> 		return;
>>>>> 	}
>>>>>
>>>>> 3) Remove the check for fc replay in function ext4_es_find_extent_range(),
>>>>>    which will then unconditionally call __es_find_extent_range().  This
>>>>>    will effectively also initialize the 'es' fields to '0' and, because
>>>>>    __es_tree_search() will return NULL (at least in generic/039 test!),
>>>>>    nothing else will be done.
>>>>>
>>>>> Since all these 3 options seem to have the same result, I believe option
>>>>> 1) is probably the best as it initializes the structure shortly after it's
>>>>> declaration.  Would you agree?  Or did I misunderstood you?
>>>>>
>>>>
>>>> Both 1 and 2 are looks fine to me, but I would prefer to initialize it
>>>> unconditionally in ext4_es_find_extent_range().
>>>>
>>>> @@ -310,6 +310,8 @@ void ext4_es_find_extent_range(struct inode *inode,
>>>> 				ext4_lblk_t lblk, ext4_lblk_t end,
>>>> 				struct extent_status *es)
>>>>  {
>>>> +	es->es_lblk = es->es_len = es->es_pblk = 0;
>>>> +
>>>> 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>>>> 		return;
>>>
>>> Thank you, Yi.  I'll send out v2 shortly.  Although, to be fair, the real
>>> patch author shouldn't be me. :-)
>>>
>>
>> Never mind, I just give a suggestion and also I didn't do a full test on
>> this change.
> 
> Oh, talking about testing, I forgot to mention that I see the same
> behaviour with generic/311.  I.e. this test also enters an infinite loop,
> but fixed with this patch.
> 

Yeah, generic/311 also does a lot of mount && journal recovery operations,
and there maybe some other fault injection tests could have the same
results, it's all right now. :)

Thanks,
Yi.


