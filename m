Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23EC54599AD
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Nov 2021 02:26:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbhKWB3e (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Nov 2021 20:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbhKWB3d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Nov 2021 20:29:33 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 943FBC061574;
        Mon, 22 Nov 2021 17:26:26 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id n15-20020a17090a160f00b001a75089daa3so743099pja.1;
        Mon, 22 Nov 2021 17:26:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ogZcX9DyHGwTuGU2oZ3wvnMYWm3iqT2k7b9HUDBtOag=;
        b=IruyqwJXagJNpBY3L2mKXfhOTI6Fvw3/KM2dGIVCGCuaZOgUb9P2VRfHfwFx2fncVB
         UgVdKY0+eSSWi28fHt0mb5G4+HgsZqfqggnCMYBuC2wOWX1lTOsguGAOnxV8zLvE5N66
         5TArCKTIXy3k9EkGVh8scTzX4OGpTqGIVmrl9vOPT0T0OCipAITcuqzKDdHr4iiQR07r
         42yIt2or5YhGcWt+yxgM1gW5y7+ehF0tmj5ti+ahHCZAZCNAdfQSD/ljUs+Hdwv/W4gA
         BtUI3blwxedn6J5P7mM5EDm7FUT5Fbx+di95dQqhOG/sunlRTuZxmag9ATOeRCQ9D/vD
         JKMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ogZcX9DyHGwTuGU2oZ3wvnMYWm3iqT2k7b9HUDBtOag=;
        b=S+izNNaG3EW4pIUwNztcwC8asPIqcd1qjwzFkg0hoOiESTEOB7qB/lGLlEuYAuTat3
         nlftyioQ8dCOVB3X9xehuq6qkurBi8+zMnu+n8ccEdyvdgJgAE7wiXMIx35Z/H0euI9A
         f2qBk5AEqicNuhVf+5XTblktHIAbu7CfPJYdqawkUaLt22VCieHp8pNQO0/YmYXXXIXp
         WIMXNzIT/+D9auPZ6bDf0OTilKOOzusQmUy15jzUossk2Qc8iCLFdIZmPQcyNjycmiRV
         s9h41LrDf3TSl3fjvoMoArx9BgFpmjMH2+TqhUH1h5Bl4GOigdUGu4HqdV+ZpV/q3UGq
         8yQw==
X-Gm-Message-State: AOAM530pnJ3ptt4KR22sLlCyl4roXEzdFeZz/R4xjXw2vOrX7JBKA1xy
        z425OdWNJ3Rn0mSOsoEOfZU=
X-Google-Smtp-Source: ABdhPJzJ2SY9oZ/udDxPho1eL0AIAEdo7G1ZL7CRmuFft0+gs24A5ZldF3gr2QgUDhln3cSyfcwpug==
X-Received: by 2002:a17:90b:1648:: with SMTP id il8mr37082677pjb.246.1637630786106;
        Mon, 22 Nov 2021 17:26:26 -0800 (PST)
Received: from [192.168.255.10] ([203.205.141.117])
        by smtp.gmail.com with ESMTPSA id m15sm19594461pjc.35.2021.11.22.17.26.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Nov 2021 17:26:25 -0800 (PST)
Message-ID: <39879e76-085e-1556-12b2-322eb44ace09@gmail.com>
Date:   Tue, 23 Nov 2021 09:26:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2] ext4: fix a possible ABBA deadlock dued to busy PA
Content-Language: en-US
To:     Jan Kara <jack@suse.cz>
Cc:     tytso@mit.edu, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>
References: <1632877945-18526-1-git-send-email-brookxu.cn@gmail.com>
 <20211122175017.GB32119@quack2.suse.cz>
From:   brookxu <brookxu.cn@gmail.com>
In-Reply-To: <20211122175017.GB32119@quack2.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Jan & riteshh:

Thanks for your time to review this patch. But kernel test robot has
reported an warning for the v2 version. I have fixed it and submitted
the v3 version, maybe we should goto v3 version, thanks all.

Jan Kara wrote on 2021/11/23 1:50:
> Hello,
> 
> it seems this patch has fallen through the cracks.
> 
> On Wed 29-09-21 09:12:25, brookxu wrote:
>> From: Chunguang Xu <brookxu@tencent.com>
>>
>> We found on older kernel (3.10) that in the scenario of insufficient
>> disk space, system may trigger an ABBA deadlock problem, it seems that
>> this problem still exists in latest kernel, try to fix it here. The
>> main process triggered by this problem is that task A occupies the PA
>> and waits for the jbd2 transaction finish, the jbd2 transaction waits
>> for the completion of task B's IO (plug_list), but task B waits for
>> the release of PA by task A to finish discard, which indirectly forms
>> an ABBA deadlock. The related calltrace is as follows:
>>
>>     Task A
>>     vfs_write
>>     ext4_mb_new_blocks()
>>     ext4_mb_mark_diskspace_used()       JBD2
>>     jbd2_journal_get_write_access()  -> jbd2_journal_commit_transaction()
>>   ->schedule()                          filemap_fdatawait()
>>  |                                              |
>>  | Task B                                       |
>>  | do_unlinkat()                                |
>>  | ext4_evict_inode()                           |
>>  | jbd2_journal_begin_ordered_truncate()        |
>>  | filemap_fdatawrite_range()                   |
>>  | ext4_mb_new_blocks()                         |
>>   -ext4_mb_discard_group_preallocations() <-----
>>
>> Here, try to cancel ext4_mb_discard_group_preallocations() internal
>> retry due to PA busy, and do a limited number of retries inside
>> ext4_mb_discard_preallocations(), which can circumvent the above
>> problems, but also has some advantages:
>>
>> 1. Since the PA is in a busy state, if other groups have free PAs,
>>    keeping the current PA may help to reduce fragmentation.
>> 2. Continue to traverse forward instead of waiting for the current
>>    group PA to be released. In most scenarios, the PA discard time
>>    can be reduced.
>>
>> However, in the case of smaller free space, if only a few groups have
>> space, then due to multiple traversals of the group, it may increase
>> CPU overhead. But in contrast, I feel that the overall benefit is
>> better than the cost.
>>
>> Signed-off-by: Chunguang Xu <brookxu@tencent.com>
> 
> Thanks for the patch! I guess this is a reasonable middle-ground so feel
> free to add:
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> 
> I think Ritesh was last touching this logic so let's check he doesn't see
> anything wrong with this change. Ritesh?
> 
> 								Honza
> 
> 
>> ---
>> v2: reset busy to zero before goto repeat.
>>
>>  fs/ext4/mballoc.c | 35 ++++++++++++++++-------------------
>>  1 file changed, 16 insertions(+), 19 deletions(-)
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 72bfac2..72de6c1 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -4814,7 +4814,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>>   */
>>  static noinline_for_stack int
>>  ext4_mb_discard_group_preallocations(struct super_block *sb,
>> -					ext4_group_t group, int needed)
>> +				     ext4_group_t group, int needed, int *busy)
>>  {
>>  	struct ext4_group_info *grp = ext4_get_group_info(sb, group);
>>  	struct buffer_head *bitmap_bh = NULL;
>> @@ -4822,8 +4822,7 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>>  	struct list_head list;
>>  	struct ext4_buddy e4b;
>>  	int err;
>> -	int busy = 0;
>> -	int free, free_total = 0;
>> +	int free = 0;
>>  
>>  	mb_debug(sb, "discard preallocation for group %u\n", group);
>>  	if (list_empty(&grp->bb_prealloc_list))
>> @@ -4850,15 +4849,13 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>>  		needed = EXT4_CLUSTERS_PER_GROUP(sb) + 1;
>>  
>>  	INIT_LIST_HEAD(&list);
>> -repeat:
>> -	free = 0;
>>  	ext4_lock_group(sb, group);
>>  	list_for_each_entry_safe(pa, tmp,
>>  				&grp->bb_prealloc_list, pa_group_list) {
>>  		spin_lock(&pa->pa_lock);
>>  		if (atomic_read(&pa->pa_count)) {
>>  			spin_unlock(&pa->pa_lock);
>> -			busy = 1;
>> +			*busy = 1;
>>  			continue;
>>  		}
>>  		if (pa->pa_deleted) {
>> @@ -4898,22 +4895,13 @@ static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac)
>>  		call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
>>  	}
>>  
>> -	free_total += free;
>> -
>> -	/* if we still need more blocks and some PAs were used, try again */
>> -	if (free_total < needed && busy) {
>> -		ext4_unlock_group(sb, group);
>> -		cond_resched();
>> -		busy = 0;
>> -		goto repeat;
>> -	}
>>  	ext4_unlock_group(sb, group);
>>  	ext4_mb_unload_buddy(&e4b);
>>  	put_bh(bitmap_bh);
>>  out_dbg:
>>  	mb_debug(sb, "discarded (%d) blocks preallocated for group %u bb_free (%d)\n",
>> -		 free_total, group, grp->bb_free);
>> -	return free_total;
>> +		 free, group, grp->bb_free);
>> +	return free;
>>  }
>>  
>>  /*
>> @@ -5455,13 +5443,22 @@ static int ext4_mb_discard_preallocations(struct super_block *sb, int needed)
>>  {
>>  	ext4_group_t i, ngroups = ext4_get_groups_count(sb);
>>  	int ret;
>> -	int freed = 0;
>> +	int freed = 0, busy = 0;
>> +	int retry = 0;
>>  
>>  	trace_ext4_mb_discard_preallocations(sb, needed);
>> + repeat:
>> +	retry++;
>>  	for (i = 0; i < ngroups && needed > 0; i++) {
>> -		ret = ext4_mb_discard_group_preallocations(sb, i, needed);
>> +		ret = ext4_mb_discard_group_preallocations(sb, i, needed, &busy);
>>  		freed += ret;
>>  		needed -= ret;
>> +		cond_resched();
>> +	}
>> +
>> +	if (needed > 0 && busy && retry < 3) {
>> +		busy = 0;
>> +		goto repeat;
>>  	}
>>  
>>  	return freed;
>> -- 
>> 1.8.3.1
>>
