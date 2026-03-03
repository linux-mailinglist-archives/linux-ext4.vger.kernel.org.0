Return-Path: <linux-ext4+bounces-14481-lists+linux-ext4=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-ext4@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6JL3AJeUpmnmRQAAu9opvQ
	(envelope-from <linux-ext4+bounces-14481-lists+linux-ext4=lfdr.de@vger.kernel.org>)
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 08:58:15 +0100
X-Original-To: lists+linux-ext4@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 981D41EA745
	for <lists+linux-ext4@lfdr.de>; Tue, 03 Mar 2026 08:58:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0322A306A823
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Mar 2026 07:56:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13AED382388;
	Tue,  3 Mar 2026 07:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="KUyWEqZh"
X-Original-To: linux-ext4@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A964133066D
	for <linux-ext4@vger.kernel.org>; Tue,  3 Mar 2026 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772524563; cv=none; b=WwB73deKthQGwOgx+J0wBZ7uRwpssGp9yHBHnMJIjm8aLrfWHI7h9n4WvQsd95d37TLKy97vyCXs8Lg3KSfej8tFzT9HHggD7U9Fql3vR7YNBJXte1KnHGIUQAAkr1Eacesjh9IcLnUOlvmcI7t0OtXlETXOSUYr+FlQfdZ0XtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772524563; c=relaxed/simple;
	bh=/66T92wN5LNhIyRhfRAzUIgGAeVbWjnsB8U6ecdmGLE=;
	h=Subject:To:References:CC:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=iOC8st0T6YW5zot87NRFy4TigsImGxUD0q3sN3IP5Rvpgb6gf9Uy6ySgXAMRs5ihYiLC1a/lSluTw2YiNeNOl45MA9W+AaaxCPg2rVPT8qeK/PvjBwYgC65mECHnBgvuS05o6dMTRLRpsVRMVS9UZY7GPpb88CPmPwFqy0qWiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=KUyWEqZh; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=yPRdVS3+9jPl++PAuNa/NmFBy5R+KjnJBMFOd29jC+c=;
	b=KUyWEqZh+g1fmmE8uPpHBKdAYcLNwNZI8gV2NgbesWnoKMgfiEU2Slv89/1hnJEhgB0cbYpUk
	GGCyflKqAqKvT6wtwtwvLCbjLLi3meIYUOhBipktAh8YmxbrtDihnZLEvVa/PaY3J8D3lxTc5N8
	Er6ojzFAwfHOv2IWvfVgkgU=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4fQ7Jc3XgWzcZyd;
	Tue,  3 Mar 2026 15:50:40 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
	by mail.maildlp.com (Postfix) with ESMTPS id 256A62025F;
	Tue,  3 Mar 2026 15:55:52 +0800 (CST)
Received: from kwepemq500016.china.huawei.com (7.202.194.202) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 15:55:51 +0800
Received: from [10.174.178.185] (10.174.178.185) by
 kwepemq500016.china.huawei.com (7.202.194.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 3 Mar 2026 15:55:51 +0800
Subject: Re: [PATCH] ext4: avoid allocate block from corrupted group in
 ext4_mb_find_by_goal()
To: Baokun Li <libaokun@linux.alibaba.com>, Ye Bin <yebin@huaweicloud.com>
References: <20260302134619.3145520-1-yebin@huaweicloud.com>
 <80be4b7a-976f-44cc-a50d-66a0e9ed05a0@linux.alibaba.com>
CC: <jack@suse.cz>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
	<linux-ext4@vger.kernel.org>
From: "yebin (H)" <yebin10@huawei.com>
Message-ID: <69A69405.3050109@huawei.com>
Date: Tue, 3 Mar 2026 15:55:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <80be4b7a-976f-44cc-a50d-66a0e9ed05a0@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemq500016.china.huawei.com (7.202.194.202)
X-Rspamd-Queue-Id: 981D41EA745
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-14481-lists,linux-ext4=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:dkim,huawei.com:email,huawei.com:mid];
	RCPT_COUNT_FIVE(0.00)[6];
	FROM_NEQ_ENVFROM(0.00)[yebin10@huawei.com,linux-ext4@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-ext4];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action



On 2026/3/3 10:36, Baokun Li wrote:
>
> On 3/2/26 9:46 PM, Ye Bin wrote:
>> From: Ye Bin <yebin10@huawei.com>
>>
>> There's issue as follows:
>> ...
>> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
>> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>>
>> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
>> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>>
>> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
>> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>>
>> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 206 at logical offset 0 with max blocks 1 with error 117
>> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>>
>> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2243 at logical offset 0 with max blocks 1 with error 117
>> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>>
>> EXT4-fs (mmcblk0p1): Delayed block allocation failed for inode 2239 at logical offset 0 with max blocks 1 with error 117
>> EXT4-fs (mmcblk0p1): This should not happen!! Data will be lost
>>
>> EXT4-fs (mmcblk0p1): error count since last fsck: 1
>> EXT4-fs (mmcblk0p1): initial error at time 1765597433: ext4_mb_generate_buddy:760
>> EXT4-fs (mmcblk0p1): last error at time 1765597433: ext4_mb_generate_buddy:760
>> ...
>>
>> According to the log analysis, blocks are always requested from the
>> corrupted block group. This may happen as follows:
>> ext4_mb_find_by_goal
>>    ext4_mb_load_buddy
>>     ext4_mb_load_buddy_gfp
>>       ext4_mb_init_cache
>>        ext4_read_block_bitmap_nowait
>>        ext4_wait_block_bitmap
>>         ext4_validate_block_bitmap
>>          if (!grp || EXT4_MB_GRP_BBITMAP_CORRUPT(grp))
>>           return -EFSCORRUPTED; // There's no logs.
>>   if (err)
>>    return err;  // Will return error
>> ext4_lock_group(ac->ac_sb, group);
>>    if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info))) // Unreachable
>>     goto out;
>>
>> After commit 9008a58e5dce ("ext4: make the bitmap read routines return
>> real error codes") merged, Commit 163a203ddb36 ("ext4: mark block group
>> as corrupt on block bitmap error") is no real solution for allocating
>> blocks from corrupted block groups. This is because if
>> 'EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)' is true, then
>> 'ext4_mb_load_buddy()' may return an error. This means that the block
>> allocation will fail.
>> Therefore, check block group if corrupted when ext4_mb_load_buddy()
>> returns error.
>
> Good catch!
>
> Agreed, we should try other groups upon failure unless it's a goal-only
> allocation.
>
> But note that e4b->bd_info might be uninitialized if ext4_mb_load_buddy()
> fails.
>
The situation you mentioned probably doesn't exist.
ext4_mb_find_by_goal
   struct ext4_group_info *grp = ext4_get_group_info(ac->ac_sb, group);
   if (!grp)   // The possibility that e4b->bd_info is not initialized 
has been avoided.
     return -EFSCORRUPTED;
   err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
      ext4_mb_load_buddy_gfp(sb, group, e4b, GFP_NOFS);
        grp = ext4_get_group_info(sb, group);
        if (!grp)   // This condition probably will not be met.
          return -EFSCORRUPTED;
        e4b->bd_info = grp;
> I think we can optimize this in ext4_mb_regular_allocator(): we can record
> the error from ext4_mb_find_by_goal() but avoid an early exit.
>
> Specifically, after checking that EXT4_MB_HINT_GOAL_ONLY is not set,
> we can assign the error to ac->ac_first_err. This way, if subsequent
> allocation attempts still fail, we can preserve the original.
>
>
> Cheers,
> Baokun
>
>> Fixes: 163a203ddb36 ("ext4: mark block group as corrupt on block bitmap error")
>> Fixes: 9008a58e5dce ("ext4: make the bitmap read routines return real error codes")
>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>> ---
>>   fs/ext4/mballoc.c | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index e2341489f4d0..ffa6886de8a3 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -2443,8 +2443,12 @@ int ext4_mb_find_by_goal(struct ext4_allocation_context *ac,
>>   		return 0;
>>
>>   	err = ext4_mb_load_buddy(ac->ac_sb, group, e4b);
>> -	if (err)
>> +	if (err) {
>> +		if (EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info) &&
>> +		    !(ac->ac_flags & EXT4_MB_HINT_GOAL_ONLY))
>> +			return 0;
>>   		return err;
>> +	}
>>
>>   	ext4_lock_group(ac->ac_sb, group);
>>   	if (unlikely(EXT4_MB_GRP_BBITMAP_CORRUPT(e4b->bd_info)))
>
>
> .
>

