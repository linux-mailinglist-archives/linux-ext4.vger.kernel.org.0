Return-Path: <linux-ext4+bounces-2506-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CC548C567E
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 15:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1C34283DC9
	for <lists+linux-ext4@lfdr.de>; Tue, 14 May 2024 13:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121F0140E37;
	Tue, 14 May 2024 13:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="TwCUzJGd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2807812E75
	for <linux-ext4@vger.kernel.org>; Tue, 14 May 2024 13:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715691858; cv=none; b=IX1IiMGPAQM3MR0YWXhwimZKCExRjcw8pnUQ9+ohn2JuerlSqZnOXeL6iVoeneqLEW93LxzCsL2Ad6S85pxDn37Lii01A9XbU6+nQmKJL+epvNBrU3X0FPWCIJhm/rOGwky3UCEncJH66VJt6DlsroP0YMVlj3xH1oOSblQKbQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715691858; c=relaxed/simple;
	bh=Jh4TmIztiLTImNeNRSwiBdIdG7exX8qTtyZUt3I6qaM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Vag9EpsTemNKBuDjdhfvvqDWk5G096QSKveMY30WKUAET7iuW4AwR3ih2YXIpPro0nNNa7Cf3xjOyV9+WptrDsRGvDiYsTss7gckuGWqqRmm6CjmUY5OQtDEU9Jn5Hm5c5ZIcsHeO9+1FEErJIHMUpqjGKekPIzptEmsSt2km+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=TwCUzJGd; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1715691853;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qpW/K7dbaciLqMw4mvk0l4DtoGG1mRuhcYtj0BOA+LY=;
	b=TwCUzJGdlR8Ey5IIrfMkMiszMxv5QoIBg8/wLf3lTioq1Q4dh7STGUMG9tPwNLBxaBfacI
	6/GinhWQ5j6wuYf+c2wYoOrLOhdTE1vbI0YEj/09O7TL0uP0H0kXkdGkg8gd02pfXlbdcF
	IVFXKrbN177Nz7JEAd+a/XO216sI+a4=
From: Luis Henriques <luis.henriques@linux.dev>
To: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>,
  linux-ext4@vger.kernel.org,  linux-kernel@vger.kernel.org,  Theodore Ts'o
 <tytso@mit.edu>,  Andreas Dilger <adilger@dilger.ca>,  Harshad Shirwadkar
 <harshadshirwadkar@gmail.com>
Subject: Re: [PATCH] ext4: fix infinite loop when replaying fast_commit
In-Reply-To: <2ee78957-b0a6-f346-5957-c4b2ebcea4ce@huaweicloud.com> (Zhang
	Yi's message of "Sat, 11 May 2024 14:24:17 +0800")
References: <20240510115252.11850-1-luis.henriques@linux.dev>
	<2ee78957-b0a6-f346-5957-c4b2ebcea4ce@huaweicloud.com>
Date: Tue, 14 May 2024 14:04:10 +0100
Message-ID: <87o798a6k5.fsf@brahms.olymp>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

On Sat 11 May 2024 02:24:17 PM +08, Zhang Yi wrote;

> On 2024/5/10 19:52, Luis Henriques (SUSE) wrote:
>> When doing fast_commit replay an infinite loop may occur due to an
>> uninitialized extent_status struct.  ext4_ext_determine_insert_hole() does
>> not detect the replay and calls ext4_es_find_extent_range(), which will
>> return immediately without initializing the 'es' variable.
>> 
>> Because 'es' contains garbage, an integer overflow may happen causing an
>> infinite loop in this function, easily reproducible using fstest generic/039.
>> 
>> This commit fixes this issue by detecting the replay in function
>> ext4_ext_determine_insert_hole().  It also adds initialization code to the
>> error path in function ext4_es_find_extent_range().
>> 
>> Thanks to Zhang Yi, for figuring out the real problem!
>> 
>> Fixes: 8016e29f4362 ("ext4: fast commit recovery path")
>> Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
>> ---
>> Hi!
>> 
>> Two comments:
>> 1) The change in ext4_ext_map_blocks() could probably use the min_not_zero
>>    macro instead.  I decided not to do so simply because I wasn't sure if
>>    that would be safe, but I'm fine changing that if you think it is.
>> 
>> 2) I thought about returning 'EXT_MAX_BLOCKS' instead of '0' in
>>    ext4_lblk_t ext4_ext_determine_insert_hole(), which would then avoid
>>    the extra change to ext4_ext_map_blocks().  '0' sounds like the right
>>    value to return, but I'm also OK using 'EXT_MAX_BLOCKS' instead.
>> 
>> And again thanks to Zhang Yi for pointing me the *real* problem!
>> 
>>  fs/ext4/extents.c        | 6 +++++-
>>  fs/ext4/extents_status.c | 5 ++++-
>>  2 files changed, 9 insertions(+), 2 deletions(-)
>> 
>> diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
>> index e57054bdc5fd..b5bfcb6c18a0 100644
>> --- a/fs/ext4/extents.c
>> +++ b/fs/ext4/extents.c
>> @@ -4052,6 +4052,9 @@ static ext4_lblk_t ext4_ext_determine_insert_hole(struct inode *inode,
>>  	ext4_lblk_t hole_start, len;
>>  	struct extent_status es;
>>  
>> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>> +		return 0;
>> +
>
> Sorry, I think it's may not correct. When replaying the jouranl, although
> we don't use the extent statue tree, we still need to query the accurate
> hole length, e.g. please see skip_hole(). If you do this, the hole length
> becomes incorrect, right?

Thank you for your review (and sorry for my delay replying).

So, I see three different options to follow your suggestion:

1) Initialize 'es' immediately when declaring it in function
   ext4_ext_determine_insert_hole():

	es.es_lblk = es.es_len = es.es_pblk = 0;

2) Initialize 'es' only in ext4_es_find_extent_range() when checking if an
   fc replay is in progress (my patch was already doing something like
   that):

	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) {
		/* Initialize extent to zero */
		es->es_lblk = es->es_len = es->es_pblk = 0;
		return;
	}

3) Remove the check for fc replay in function ext4_es_find_extent_range(),
   which will then unconditionally call __es_find_extent_range().  This
   will effectively also initialize the 'es' fields to '0' and, because
   __es_tree_search() will return NULL (at least in generic/039 test!),
   nothing else will be done.

Since all these 3 options seem to have the same result, I believe option
1) is probably the best as it initializes the structure shortly after it's
declaration.  Would you agree?  Or did I misunderstood you?

Cheers,
-- 
Luis

>
> Thanks,
> Yi.
>
>>  	hole_start = lblk;
>>  	len = ext4_ext_find_hole(inode, path, &hole_start);
>>  again:
>> @@ -4226,7 +4229,8 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
>>  		len = ext4_ext_determine_insert_hole(inode, path, map->m_lblk);
>>  
>>  		map->m_pblk = 0;
>> -		map->m_len = min_t(unsigned int, map->m_len, len);
>> +		if (len > 0)
>> +			map->m_len = min_t(unsigned int, map->m_len, len);
>>  		goto out;
>>  	}
>>  
>> diff --git a/fs/ext4/extents_status.c b/fs/ext4/extents_status.c
>> index 4a00e2f019d9..acb9616ca119 100644
>> --- a/fs/ext4/extents_status.c
>> +++ b/fs/ext4/extents_status.c
>> @@ -310,8 +310,11 @@ void ext4_es_find_extent_range(struct inode *inode,
>>  			       ext4_lblk_t lblk, ext4_lblk_t end,
>>  			       struct extent_status *es)
>>  {
>> -	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY)
>> +	if (EXT4_SB(inode->i_sb)->s_mount_state & EXT4_FC_REPLAY) {
>> +		/* Initialize extent to zero */
>> +		es->es_lblk = es->es_len = es->es_pblk = 0;
>>  		return;
>> +	}
>>  
>>  	trace_ext4_es_find_extent_range_enter(inode, lblk);
>>  
>> 

