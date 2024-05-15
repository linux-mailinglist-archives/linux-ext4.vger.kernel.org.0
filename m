Return-Path: <linux-ext4+bounces-2519-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5148C6000
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 06:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC751B2362A
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 04:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3992739FF4;
	Wed, 15 May 2024 04:59:36 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE3E39FD3;
	Wed, 15 May 2024 04:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715749175; cv=none; b=qL7j51zrSVRwP6efRXGrVTQMuVvXvCi7/BP9z02FbVxdbjeB7pPyLSykJ5wH8p1HsTCGDKmNt/71cr6jbwOYfDypcie7ggbERtFvPxQCtJrqHlvX3+yXSqqLYyxKAyDqPO6YQTNhAoxZzLpqoEsBjRs0CPVZ18jHP9AXLp2XVb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715749175; c=relaxed/simple;
	bh=jcCy/UQIgpma7wPapFBLnXyQAMmvj/t84PSlUV5gQWY=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=DcVUG0mJ6CoTaRyXBMdNotb52aWpKxBA3dIT5hJ3QFuiiVm0fRG8GqncEd8PJWSnVnuBcV2ej5Qrg7Ikvx5dlz9XpjAdIH9c3zm8OGFkHvFljLAXbVibvhdRdhUxmkTfFdfCrdkHRE48H0q3vpT0z8Xc4g+bJKffVgbma6TlpAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VfLc734R2z4f3jXc;
	Wed, 15 May 2024 12:59:19 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id 180241A0B8A;
	Wed, 15 May 2024 12:59:28 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP2 (Coremail) with SMTP id Syh0CgDnCg4uQURm2nsMNA--.49640S3;
	Wed, 15 May 2024 12:59:27 +0800 (CST)
Subject: Re: [PATCH] ext4: fix infinite loop when replaying fast_commit
To: Luis Henriques <luis.henriques@linux.dev>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, Andreas Dilger <adilger@dilger.ca>,
 Harshad Shirwadkar <harshadshirwadkar@gmail.com>
References: <20240510115252.11850-1-luis.henriques@linux.dev>
 <2ee78957-b0a6-f346-5957-c4b2ebcea4ce@huaweicloud.com>
 <87o798a6k5.fsf@brahms.olymp>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Message-ID: <a49a72d2-98aa-1c87-fc3a-58cae0f90257@huaweicloud.com>
Date: Wed, 15 May 2024 12:59:26 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <87o798a6k5.fsf@brahms.olymp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgDnCg4uQURm2nsMNA--.49640S3
X-Coremail-Antispam: 1UD129KBjvJXoWxJw45uFW3CFWkGw1DZr1DJrb_yoWrWrW5pa
	97uF1UKr4kK3ykK3y2yw4rZr1Yka1xCw4xJryfKrn5K3Z8trn7uF18KF4Yka4kWrWxG3Wj
	vF40q39rCFn0kaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxV
	AFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2
	j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7x
	kEbVWUJVW8JwACjcxG0xvEwIxGrwCYjI0SjxkI62AI1cAE67vIY487MxAIw28IcxkI7VAK
	I48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw2
	0EY4v20xvaj40_WFyUJVCq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF
	7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2024/5/14 21:04, Luis Henriques wrote:
> On Sat 11 May 2024 02:24:17 PM +08, Zhang Yi wrote;
> 
>> On 2024/5/10 19:52, Luis Henriques (SUSE) wrote:
>>> When doing fast_commit replay an infinite loop may occur due to an
>>> uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
>>> not detect the replay and calls ext4_es_find_extent_range(), which will
>>> return immediately without initializing the 'es' variable.
>>>
>>> Because 'es' contains garbage, an integer overflow may happen causing an
>>> infinite loop in this function, easily reproducible using fstest generic/039.
>>>
>>> This commit fixes this issue by detecting the replay in function
>>> ext4_ext_determine_insert_hole().  It also adds initialization code to the
>>> error path in function ext4_es_find_extent_range().
>>>
>>> Thanks to Zhang Yi, for figuring out the real problem!
>>>
>>> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>> ---
>>> Hi!
>>>
>>> Two comments:
>>> 1) The change in ext4_ext_map_blocks() could probably use the min_not_zero
>>>    macro instead.  I decided not to do so simply because I wasn't sure if
>>>    that would be safe, but I'm fine changing that if you think it is.
>>>
>>> 2) I thought about returning 'EXT_MAX_BLOCKS' instead of '0' in
>>>    ext4_lblk_t ext4_ext_determine_insert_hole(), which would then avoid
>>>    the extra change to ext4_ext_map_blocks().  '0' sounds like the right
>>>    value to return, but I'm also OK using 'EXT_MAX_BLOCKS' instead.
>>>
>>> And again thanks to Zhang Yi for pointing me the *real* problem!
>>>
>>>  fs/ext4/extents.c        | 6 +++++-
>>>  fs/ext4/extents_status.c | 5 ++++-
>>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>> index e57054bdc5fd..b5bfcb6c18a0 100644
>>> --- a/fs/ext4/extents.c
>>> +++ b/fs/ext4/extents.c
>>> @@ -4052,6 +4052,9 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
>>>  	ext4_lblk_t hole_start, len;
>>>  	struct extent_status es;
>>>  
>>> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>>> +		return 0;
>>> +
>>
>> Sorry, I think it's may not correct. When replaying the jouranl, although
>> we don't use the extent statue tree, we still need to query the accurate
>> hole length, e.g. please see skip_hole(). If you do this, the hole length
>> becomes incorrect, right?
> 
> Thank you for your review (and sorry for my delay replying).
> 
> So, I see three different options to follow your suggestion:
> 
> 1) Initialize 'es' immediately when declaring it in function
>    ext4_ext_determine_insert_hole():
> 
> 	es.es_lblk = es.es_len = es.es_pblk = 0;
> 
> 2) Initialize 'es' only in ext4_es_find_extent_range() when checking if an
>    fc replay is in progress (my patch was already doing something like
>    that):
> 
> 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) {
> 		/* Initialize extent to zero */
> 		es->es_lblk = es->es_len = es->es_pblk = 0;
> 		return;
> 	}
> 
> 3) Remove the check for fc replay in function ext4_es_find_extent_range(),
>    which will then unconditionally call __es_find_extent_range().  This
>    will effectively also initialize the 'es' fields to '0' and, because
>    __es_tree_search() will return NULL (at least in generic/039 test!),
>    nothing else will be done.
> 
> Since all these 3 options seem to have the same result, I believe option
> 1) is probably the best as it initializes the structure shortly after it's
> declaration.  Would you agree?  Or did I misunderstood you?
> 

Both 1 and 2 are looks fine to me, but I would prefer to initialize it
unconditionally in ext4_es_find_extent_range().

@@ -310,6 +310,8 @@ void ext4_es_find_extent_range(struct inode *inode,
				ext4_lblk_t lblk, ext4_lblk_t end,
				struct extent_status *es)
 {
+	es->es_lblk = es->es_len = es->es_pblk = 0;
+
	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
		return;

Thanks,
Yi.


