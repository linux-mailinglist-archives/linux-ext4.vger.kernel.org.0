Return-Path: <linux-ext4+bounces-2520-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 129B88C62E0
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 10:28:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 66A00B21B3F
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2024 08:28:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25BC4CB5B;
	Wed, 15 May 2024 08:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LBV2uXET"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E5C57C8A
	for <linux-ext4@vger.kernel.org>; Wed, 15 May 2024 08:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715761717; cv=none; b=keXCf/kx378Vemk7GZ+KnJWSvx6Pnq2hWB9uFp6xUXsjq89tKrNUKkWEp2Erd9ipn/530QfBTdndlL3kWs0PZ0YomphKq9CwidR3Kz617peoFsxkT2n3VfoMajx3+PMsrfkqPo6oGCvqQVw/YA/3SPyPfwJx12xVHV34CQ1ACL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715761717; c=relaxed/simple;
	bh=qZ5PtdWQwnrI+qm84to52NV4hML71OxaLXehqbhio2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A/f/i2KrYla7mdT6fjQrpcPRggICyBqAsWKMD/4IL9I0nvjyRxsWnyF7Xd64GryqntFQuK0Zgxa92OPzJiyfz27p7fS+dqiG2cPqx6d9GYeB9FhjbSv5A5Sy62e2LbxvmqXJK3yKJYuog73rXFd4y8rcbWoUdTrfuw97bnscNM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LBV2uXET; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715761712;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m6z880RTWT/eDmvxKbDohNBeKThIr9MgD7aClITZ0Z0=;
	b=LBV2uXETyClr80szE82gnOvrLvArVrSj4Ql0lbQlyLwFCY+GbGcfiN627fvxwMyDB9FMK4
	stRRTf739PW2YfPgfYoydWPrMUj9NM0HmZm/jVs5H6A+P22X/w+gTeXroaGrnnU+XcUoH8
	ouoaH2OOZt3HZ8/EJWr4FHKj0TfPebg=
From: Luis Henriques <luis.henriques@linux.dev>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: Luis Henriques <luis.henriques@linux.dev>,  linux-ext4@vger.kernel.org,
  linux-kernel@vger.kernel.org,  Theodore Ts'o <tytso@mit.edu>,  Andreas
 Dilger <adilger@dilger.ca>,  Harshad Shirwadkar
 <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH] ext4: fix infinite loop when replaying fast_commit
In-Reply-To: <a49a72d2-98aa-1c87-fc3a-58cae0f90257@huaweicloud.com> (Zhang
	Yi's message of "Wed, 15 May 2024 12:59:26 +0800")
References: <20240510115252.11850-1-luis.henriques@linux.dev>
	<2ee78957-b0a6-f346-5957-c4b2ebcea4ce@huaweicloud.com>
	<87o798a6k5.fsf@brahms.olymp>
	<a49a72d2-98aa-1c87-fc3a-58cae0f90257@huaweicloud.com>
Date: Wed, 15 May 2024 09:28:29 +0100
Message-ID: <87pltniimq.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Wed 15 May 2024 12:59:26 PM +08, Zhang Yi wrote;

> On 2024/5/14 21:04, Luis Henriques wrote:
>> On Sat 11 May 2024 02:24:17 PM +08, Zhang Yi wrote;
>> 
>>> On 2024/5/10 19:52, Luis Henriques (SUSE) wrote:
>>>> When doing fast_commit replay an infinite loop may occur due to an
>>>> uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
>>>> not detect the replay and calls ext4_es_find_extent_range(), which will
>>>> return immediately without initializing the 'es' variable.
>>>>
>>>> Because 'es' contains garbage, an integer overflow may happen causing an
>>>> infinite loop in this function, easily reproducible using fstest generic/039.
>>>>
>>>> This commit fixes this issue by detecting the replay in function
>>>> ext4_ext_determine_insert_hole().  It also adds initialization code to the
>>>> error path in function ext4_es_find_extent_range().
>>>>
>>>> Thanks to Zhang Yi, for figuring out the real problem!
>>>>
>>>> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
>>>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>>>> ---
>>>> Hi!
>>>>
>>>> Two comments:
>>>> 1) The change in ext4_ext_map_blocks() could probably use the min_not_zero
>>>>    macro instead.  I decided not to do so simply because I wasn't sure if
>>>>    that would be safe, but I'm fine changing that if you think it is.
>>>>
>>>> 2) I thought about returning 'EXT_MAX_BLOCKS' instead of '0' in
>>>>    ext4_lblk_t ext4_ext_determine_insert_hole(), which would then avoid
>>>>    the extra change to ext4_ext_map_blocks().  '0' sounds like the right
>>>>    value to return, but I'm also OK using 'EXT_MAX_BLOCKS' instead.
>>>>
>>>> And again thanks to Zhang Yi for pointing me the *real* problem!
>>>>
>>>>  fs/ext4/extents.c        | 6 +++++-
>>>>  fs/ext4/extents_status.c | 5 ++++-
>>>>  2 files changed, 9 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>>>> index e57054bdc5fd..b5bfcb6c18a0 100644
>>>> --- a/fs/ext4/extents.c
>>>> +++ b/fs/ext4/extents.c
>>>> @@ -4052,6 +4052,9 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
>>>>  	ext4_lblk_t hole_start, len;
>>>>  	struct extent_status es;
>>>>  
>>>> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>>>> +		return 0;
>>>> +
>>>
>>> Sorry, I think it's may not correct. When replaying the jouranl, although
>>> we don't use the extent statue tree, we still need to query the accurate
>>> hole length, e.g. please see skip_hole(). If you do this, the hole length
>>> becomes incorrect, right?
>> 
>> Thank you for your review (and sorry for my delay replying).
>> 
>> So, I see three different options to follow your suggestion:
>> 
>> 1) Initialize 'es' immediately when declaring it in function
>>    ext4_ext_determine_insert_hole():
>> 
>> 	es.es_lblk = es.es_len = es.es_pblk = 0;
>> 
>> 2) Initialize 'es' only in ext4_es_find_extent_range() when checking if an
>>    fc replay is in progress (my patch was already doing something like
>>    that):
>> 
>> 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) {
>> 		/* Initialize extent to zero */
>> 		es->es_lblk = es->es_len = es->es_pblk = 0;
>> 		return;
>> 	}
>> 
>> 3) Remove the check for fc replay in function ext4_es_find_extent_range(),
>>    which will then unconditionally call __es_find_extent_range().  This
>>    will effectively also initialize the 'es' fields to '0' and, because
>>    __es_tree_search() will return NULL (at least in generic/039 test!),
>>    nothing else will be done.
>> 
>> Since all these 3 options seem to have the same result, I believe option
>> 1) is probably the best as it initializes the structure shortly after it's
>> declaration.  Would you agree?  Or did I misunderstood you?
>> 
>
> Both 1 and 2 are looks fine to me, but I would prefer to initialize it
> unconditionally in ext4_es_find_extent_range().
>
> @@ -310,6 +310,8 @@ void ext4_es_find_extent_range(struct inode *inode,
> 				ext4_lblk_t lblk, ext4_lblk_t end,
> 				struct extent_status *es)
>  {
> +	es->es_lblk = es->es_len = es->es_pblk = 0;
> +
> 	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
> 		return;

Thank you, Yi.  I'll send out v2 shortly.  Although, to be fair, the real
patch author shouldn't be me. :-)

Cheers,
-- 
Luis

