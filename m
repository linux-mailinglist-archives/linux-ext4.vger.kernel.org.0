Return-Path: <linux-ext4+bounces-6725-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B93C0A579B5
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E1747A705A
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23C51AF0BA;
	Sat,  8 Mar 2025 10:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ira12NUj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58B81758B;
	Sat,  8 Mar 2025 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741428615; cv=none; b=qGSf32BJfJaM/T7k0jDlacApbkyznyr/TWrz36qbx4wTvSW4bwhX7jybpwaLS1KT0PaP1TFnfbS1sPb1prxrKL28ygyAuk8ROze/JcD0e3G3sc/TQMqJj5CqdPW68DzOUhZybGMkwmLTVNV4cM2QxQLLSDs+SvuuR9q3SpFLvQg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741428615; c=relaxed/simple;
	bh=7Y+a4YkMtGpR4oyrLJEDUkCymNAOiU8iom3Hsd4QAOA=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=sjL9lvwDIcE9Wijn3g0unrYQ9zqCJ4RcjsEE1eENWL3eddmy0Y5CDe0pdRbcWQldFMak87ZUd4q78e0gO5zBrU1WKD4Ntzq/cYK07T/CNHmS42sdKiD4FF/emAQgmr30FwCoIwSE7srelFCBJ82KG/pKKheehD0LwV4/pejaj0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ira12NUj; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223959039f4so55205365ad.3;
        Sat, 08 Mar 2025 02:10:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741428613; x=1742033413; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iUf2dQ+IPC8Cr0d7ZwbJfJXFQTTQcNCoLNT934+iYy4=;
        b=Ira12NUjnVVY4jtO3kClp01RFAHhHkHoP3JEX+wSLU1nC9R6dl9lgfeeh4cX+1drm/
         2yaNY2oipf27+gEiQVfFGQZ0bfvkGijdNh6Uy0yqXBPIIX6U3xLTJKZn0neSu4eHHmNM
         Wkb/vNlx3K/yj8GCXnq0TQp+p2aEhwRV5Mtf8ZLqfmBmK69xdrSS+fNtV6NODtVW0R1+
         FDn8ekRJHBmdMRNX2JlBO1icI6yza7bnYQ3A7Durs+/DEoWKdO0YIRPA7TcNfEYECgtI
         St9rRVGZTOBKvnQCx9NF7Mmp5kGGNHohx+aXrigoPOUROmlD7xUtVl5g6MN9qSUVwrhN
         4Xyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741428613; x=1742033413;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iUf2dQ+IPC8Cr0d7ZwbJfJXFQTTQcNCoLNT934+iYy4=;
        b=OUQioKceuixFrPRgeQR41rmTAVtTm5Kv0ILoU1qcByo4HlW/mVDXC3EJG2m9voArJN
         NIP+cnHKffstkGX75+hNdOx3RZrzoY5vM5YM3dgZSSUhuXMxp9INj/UIJiUyZz4TUAjb
         Yw0vcwPmai4XlDpuVzJ2rbCGmXm9DAgq293wd49h6sU4pdxuVaMlRmKkM8j8sHueV6nv
         KI495Z7Mf3qgKrDtd7+jUhcR3DLrkiC+sLsDDNMEEbiKGrk1N2qjXsd9Q0i+mBiA6G8e
         DFOTRt3T+TP2ysdDcJNU4B8aLv683kLSDnqRAoH40SbCnn+OcqhK9ACSBjibkO/2PPej
         L5Zg==
X-Forwarded-Encrypted: i=1; AJvYcCVbMow7V9iS2Qox0Ni+P9zKUQCzQrg/qDrmipVy+/AJWNJxuZPY1NYAg42RLIUh/UaZb/C0EE48sIlW@vger.kernel.org, AJvYcCWI5d7YEo9YAiNMZETWGuBo+6SHq7o3qnTSO5m2EBXtKQnnjtL46dMUmdbfncPUHoZrWsDPqA5PEB0dnt+h@vger.kernel.org
X-Gm-Message-State: AOJu0Yxwh5EzHpdZLHi8fozd/MjChnmDSBRveOIH3qV6UCXBCKTT7PT/
	VvZG8c8o/oMz0pQCNUEPDuZvzcb7iq8OppBNbBcpawnNWu4iHXLh
X-Gm-Gg: ASbGncshxf2Equ0g8z9yTzXJUC3tqncZbnl5PxF0qMDRGjoP0WwPe30f4agTXoTN7uM
	cSGHSYXt5wSsKmM/06dJwO/DkDYftK1r+50iEBucSuD92/CbACaIp/Sfoafrsr2LKYPtBpnZedG
	zUsvwjPRuA1rgG6rGkKkvMURO1ynMK0+dNBuJ0c1HJx+WRloRv7YL85MCKTvIiyJi/eLlFjB1o3
	GXlbIvLT1UrW7KoFQYSGlzmM7axQPK12s1FdG8uRnzkcuBY9wpSejHAsd2MOmRKGIou7MvDMjpW
	KzBhlua4L18xqsq1/7hwTmMtCIabpdDOCo8=
X-Google-Smtp-Source: AGHT+IEWLbalJc3HRRTzG4v9taQobHSSmxOTwZFI9DwtDaH9YTEeYSpHWpWUJRrtAZ2CtN97Vmk6XA==
X-Received: by 2002:a05:6a21:3947:b0:1f5:5b2a:f641 with SMTP id adf61e73a8af0-1f55b2b024cmr2486948637.28.1741428612967;
        Sat, 08 Mar 2025 02:10:12 -0800 (PST)
Received: from dw-tp ([171.76.82.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af283576bc2sm4180552a12.38.2025.03.08.02.10.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Mar 2025 02:10:12 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Zhang Yi <yi.zhang@huaweicloud.com>, Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>, linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>, linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if journal is destroying
In-Reply-To: <4f61a0fb-dd9f-4c0e-b872-31e5474ac799@huaweicloud.com>
Date: Sat, 08 Mar 2025 15:31:52 +0530
Message-ID: <87jz8zhmcv.fsf@gmail.com>
References: <cover.1741270780.git.ojaswin@linux.ibm.com> <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com> <5b3864c3-bcfd-4f45-b427-224d32aca478@huaweicloud.com> <Z8qTciy49b7LSHqr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <Z8qqna0BEDT5ZD82@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <e9e92601-53bc-42a2-b428-e61bff6153c5@huaweicloud.com> <Z8rKAsmIuBlOo4T1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <e3172770-9b39-4105-966f-faf64a6b6515@huaweicloud.com> <Z8ssR7BtBVP1zif2@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com> <4f61a0fb-dd9f-4c0e-b872-31e5474ac799@huaweicloud.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Zhang Yi <yi.zhang@huaweicloud.com> writes:

> On 2025/3/8 1:26, Ojaswin Mujoo wrote:
>> On Fri, Mar 07, 2025 at 08:36:08PM +0800, Zhang Yi wrote:
>>> On 2025/3/7 18:27, Ojaswin Mujoo wrote:
>>>> On Fri, Mar 07, 2025 at 04:43:24PM +0800, Zhang Yi wrote:
>>>>> On 2025/3/7 16:13, Ojaswin Mujoo wrote:
>>>>>> On Fri, Mar 07, 2025 at 12:04:26PM +0530, Ojaswin Mujoo wrote:
>>>>>>> On Fri, Mar 07, 2025 at 10:49:28AM +0800, Zhang Yi wrote:
>>>>>>>> On 2025/3/6 22:28, Ojaswin Mujoo wrote:
>>>>>>>>> Presently we always BUG_ON if trying to start a transaction on a journal marked
>>>>>>>>> with JBD2_UNMOUNT, since this should never happen. However, while ltp running
>>>>>>>>> stress tests, it was observed that in case of some error handling paths, it is
>>>>>>>>> possible for update_super_work to start a transaction after the journal is
>>>>>>>>> destroyed eg:
>>>>>>>>>
>>>>>>>>> (umount)
>>>>>>>>> ext4_kill_sb
>>>>>>>>>   kill_block_super
>>>>>>>>>     generic_shutdown_super
>>>>>>>>>       sync_filesystem /* commits all txns */
>>>>>>>>>       evict_inodes
>>>>>>>>>         /* might start a new txn */
>>>>>>>>>       ext4_put_super
>>>>>>>>> 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>>>>>>>>>         jbd2_journal_destroy
>>>>>>>>>           journal_kill_thread
>>>>>>>>>             journal->j_flags |= JBD2_UNMOUNT;
>>>>>>>>>           jbd2_journal_commit_transaction
>>>>>>>>>             jbd2_journal_get_descriptor_buffer
>>>>>>>>>               jbd2_journal_bmap
>>>>>>>>>                 ext4_journal_bmap
>>>>>>>>>                   ext4_map_blocks
>>>>>>>>>                     ...
>>>>>>>>>                     ext4_inode_error
>>>>>>>>>                       ext4_handle_error
>>>>>>>>>                         schedule_work(&sbi->s_sb_upd_work)
>>>>>>>>>
>>>>>>>>>                                                /* work queue kicks in */
>>>>>>>>>                                                update_super_work
>>>>>>>>>                                                  jbd2_journal_start
>>>>>>>>>                                                    start_this_handle
>>>>>>>>>                                                      BUG_ON(journal->j_flags &
>>>>>>>>>                                                             JBD2_UNMOUNT)
>>>>>>>>>
>>>>>>>>> Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
>>>>>>>>> destroying only do a journaled (and deferred) update of sb if this flag is not
>>>>>>>>> set. Otherwise, just fallback to an un-journaled commit.
>>>>>>>>>
>>>>>>>>> We set sbi->s_journal_destroying = true only after all the FS updates are done
>>>>>>>>> during ext4_put_super() (except a running transaction that will get commited
>>>>>>>>> during jbd2_journal_destroy()). After this point, it is safe to commit the sb
>>>>>>>>> outside the journal as it won't race with a journaled update (refer
>>>>>>>>> 2d01ddc86606).
>>>>>>>>>
>>>>>>>>> Also, we don't need a similar check in ext4_grp_locked_error since it is only
>>>>>>>>> called from mballoc and AFAICT it would be always valid to schedule work here.
>>>>>>>>>
>>>>>>>>> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
>>>>>>>>> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
>>>>>>>>> Suggested-by: Jan Kara <jack@suse.cz>
>>>>>>>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>>>>>>>> ---
>>>>>>>>>  fs/ext4/ext4.h      | 2 ++
>>>>>>>>>  fs/ext4/ext4_jbd2.h | 8 ++++++++
>>>>>>>>>  fs/ext4/super.c     | 4 +++-
>>>>>>>>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>>>>>>>>
>>>>>>>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>>>>>>>> index 2b7d781bfcad..d48e93bd5690 100644
>>>>>>>>> --- a/fs/ext4/ext4.h
>>>>>>>>> +++ b/fs/ext4/ext4.h
>>>>>>>>> @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
>>>>>>>>>  	 */
>>>>>>>>>  	struct work_struct s_sb_upd_work;
>>>>>>>>>  
>>>>>>>>> +	bool s_journal_destorying;
>>>>>>>>> +
>>>>>>>>>  	/* Atomic write unit values in bytes */
>>>>>>>>>  	unsigned int s_awu_min;
>>>>>>>>>  	unsigned int s_awu_max;
>>>>>>>>> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
>>>>>>>>> index 9b3c9df02a39..6bd3ca84410d 100644
>>>>>>>>> --- a/fs/ext4/ext4_jbd2.h
>>>>>>>>> +++ b/fs/ext4/ext4_jbd2.h
>>>>>>>>> @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
>>>>>>>>>  {
>>>>>>>>>  	int err = 0;
>>>>>>>>>  
>>>>>>>>> +	/*
>>>>>>>>> +	 * At this point all pending FS updates should be done except a possible
>>>>>>>>> +	 * running transaction (which will commit in jbd2_journal_destroy). It
>>>>>>>>> +	 * is now safe for any new errors to directly commit superblock rather
>>>>>>>>> +	 * than going via journal.
>>>>>>>>> +	 */
>>>>>>>>> +	sbi->s_journal_destorying = true;
>>>>>>>>> +
>>>>>>>>
>>>>>>>> Hi, Ojaswin!
>>>>>>>>
>>>>>>>> I'm afraid you still need to flush the superblock update work here,
>>>>>>>> otherwise I guess the race condition you mentioned in v1 could still
>>>>>>>> occur.
>>>>>>>>
>>>>>>>>  ext4_put_super()
>>>>>>>>   flush_work(&sbi->s_sb_upd_work)
>>>>>>>>
>>>>>>>>                     **kjournald2**
>>>>>>>>                     jbd2_journal_commit_transaction()
>>>>>>>>                     ...
>>>>>>>>                     ext4_inode_error()
>>>>>>>>                       /* JBD2_UNMOUNT not set */
>>>>>>>>                       schedule_work(s_sb_upd_work)
>>>>>>>>
>>>>>>>>                                   **workqueue**
>>>>>>>>                                    update_super_work
>>>>>>>>                                    /* s_journal_destorying is not set */
>>>>>>>>                             	   if (journal && !s_journal_destorying)
>>>>>>>>
>>>>>>>>   ext4_journal_destroy()
>>>>>>>>    /* set s_journal_destorying */
>>>>>>>>    sbi->s_journal_destorying = true;
>>>>>>>>    jbd2_journal_destroy()
>>>>>>>>     journal->j_flags |= JBD2_UNMOUNT;
>>>>>>>>
>>>>>>>>                                        jbd2_journal_start()
>>>>>>>>                                         start_this_handle()
>>>>>>>>                                           BUG_ON(JBD2_UNMOUNT)
>>>>>>>>
>>>>>>>> Thanks,
>>>>>>>> Yi.
>>>>>>> Hi Yi,
>>>>>>>
>>>>>>> Yes you are right, somehow missed this edge case :(
>>>>>>>
>>>>>>> Alright then, we have to move out sbi->s_journal_destroying outside the
>>>>>>> helper. Just wondering if I should still let it be in
>>>>>>> ext4_journal_destroy and just add an extra s_journal_destroying = false
>>>>>>> before schedule_work(s_sb_upd_work), because it makes sense.
>>>>>>>
>>>>>>> Okay let me give it some thought but thanks for pointing this out!
>>>>>>>
>>>>>>> Regards,
>>>>>>> ojaswin
>>>>>>
>>>>>> Okay so thinking about it a bit more, I see you also suggested to flush
>>>>>> the work after marking sbi->s_journal_destroying. But will that solve
>>>>>> it?
>>>>>>
>>>>>>   ext4_put_super()
>>>>>>    flush_work(&sbi->s_sb_upd_work)
>>>>>>  
>>>>>>                      **kjournald2**
>>>>>>                      jbd2_journal_commit_transaction()
>>>>>>                      ...
>>>>>>                      ext4_inode_error()
>>>>>>                        /* JBD2_UNMOUNT not set */
>>>>>>                        schedule_work(s_sb_upd_work)
>>>>>>  
>>>>>>                                     **workqueue**
>>>>>>                                     update_super_work
>>>>>>                                     /* s_journal_destorying is not set */
>>>>>>                              	      if (journal && !s_journal_destorying)
>>>>>>  
>>>>>>    ext4_journal_destroy()
>>>>>>     /* set s_journal_destorying */
>>>>>>     sbi->s_journal_destorying = true;
>>>>>>     flush_work(&sbi->s_sb_upd_work)
>>>>>>                                       schedule_work()
>>>>>                                         ^^^^^^^^^^^^^^^
>>>>>                                         where does this come from?
>>>>>
>>>>> After this flush_work, we can guarantee that the running s_sb_upd_work
>>>>> finishes before we set JBD2_UNMOUNT. Additionally, the journal will
>>>>> not commit transaction or call schedule_work() again because it has
>>>>> been aborted due to the previous error. Am I missing something?
>>>>>
>>>>> Thanks,
>>>>> Yi.
>>>>
>>>> Hmm, so I am thinking of a corner case in ext4_handle_error() where 
>>>>
>>>>  if(journal && !is_journal_destroying) 
>>>>
>>>> is computed but schedule_work() not called yet, which is possible cause
>>>> the cmp followed by jump is not atomic in nature. If the schedule_work
>>>> is only called after we have done the flush then we end up with this:
>>>>
>>>>                               	      if (journal && !s_journal_destorying)
>>>>     ext4_journal_destroy()
>>>>      /* set s_journal_destorying */
>>>>      sbi->s_journal_destorying = true;
>>>>      flush_work(&sbi->s_sb_upd_work)
>>>>                                        schedule_work()
>>>>
>>>> Which is possible IMO, although the window is tiny.
>>>
>>> Yeah, right!
>>> Sorry for misread the location where you add the "!s_journal_destorying"
>>> check, the graph I provided was in update_super_work(), which was wrong.
>> 
>> Oh right, I also misread your trace but yes as discussed, even 
>> 
>>     sbi->s_journal_destorying = true;
>> 		flush_work()
>>     jbd2_journal_destroy()
>> 
>> doesn't work.
>> 
>>> The right one should be:
>>>
>>>  ext4_put_super()
>>>   flush_work(&sbi->s_sb_upd_work)
>>>
>>>                     **kjournald2**
>>>                     jbd2_journal_commit_transaction()
>>>                     ...
>>>                     ext4_inode_error()
>>>                       /* s_journal_destorying is not set */
>>>                       if (journal && !s_journal_destorying)
>>>                         (schedule_work(s_sb_upd_work))  //can be here
>>>
>>>   ext4_journal_destroy()
>>>    /* set s_journal_destorying */
>>>    sbi->s_journal_destorying = true;
>>>    jbd2_journal_destroy()
>>>     journal->j_flags |= JBD2_UNMOUNT;
>>>
>>>                         (schedule_work(s_sb_upd_work))  //also can be here
>>>
>>>                                   **workqueue**
>>>                                    update_super_work()
>>>                                    journal = sbi->s_journal //get journal
>>>     kfree(journal)
>>>                                      jbd2_journal_start(journal) //journal UAF
>>>                                        start_this_handle()
>>>                                          BUG_ON(JBD2_UNMOUNT) //bugon here
>>>
>>>
>>> So there are two problems here, the first one is the 'journal' UAF,
>>> the second one is triggering JBD2_UNMOUNT flag BUGON.
>> 
>> Indeed, there's a possible UAF here as well.
>> 
>>>
>>>>>>
>>>>>> As for the fix, how about we do something like this:
>>>>>>
>>>>>>   ext4_put_super()
>>>>>>
>>>>>>    flush_work(&sbi->s_sb_upd_work)
>>>>>>    destroy_workqueue(sbi->rsv_conversion_wq);
>>>>>>
>>>>>>    ext4_journal_destroy()
>>>>>>     /* set s_journal_destorying */
>>>>>>     sbi->s_journal_destorying = true;
>>>>>>
>>>>>>    /* trigger a commit and wait for it to complete */
>>>>>>
>>>>>>     flush_work(&sbi->s_sb_upd_work)
>>>>>>
>>>>>>     jbd2_journal_destroy()
>>>>>>      journal->j_flags |= JBD2_UNMOUNT;
>>>>>>  
>>>>>>                                         jbd2_journal_start()
>>>>>>                                          start_this_handle()
>>>>>>                                            BUG_ON(JBD2_UNMOUNT)
>>>>>>
>>>>>> Still giving this codepath some thought but seems like this might just
>>>>>> be enough to fix the race. Thoughts on this?
>>>>>>
>>>
>>> I think this solution should work, the forced commit and flush_work()
>>> should ensure that the last transaction is committed and that the
>>> potential work is done.
>>>
>>> Besides, the s_journal_destorying flag is set and check concurrently
>>> now, so we need WRITE_ONCE() and READ_ONCE() for it. Besides, what
>>> about adding a new flag into sbi->s_mount_state instead of adding
>>> new s_journal_destorying?
>> 
>> Right, that makes sence. I will incorporate these changes in the next 
>> revision.
>> 
>
> Think about this again, it seems that we no longer need the destroying
> flag. Because we force to commit and wait for the **last** transaction to
> complete, and the flush work should also ensure that the last sb_update
> work to complete. Regardless of whether it starts a new handle in the
> last update_super_work(), it will not commit since the journal should
> have aborted. What are your thoughts?
>

I think the confusion maybe coming because v2 patch isn't where we
discussed to put the s_journal_destroying to true, in this thread [1]

[1]: https://lore.kernel.org/linux-ext4/jnxpphuradrsf73cxfmohfu7wwwckihtulw6ovsitddgt5pqkg@2uoejkr66qnl/


>  ext4_put_super()

   + sbi->s_journal_destroying = true;

We should add s_journal_destroying to true before calling for
flush_work. 

>   flush_work(&sbi->s_sb_upd_work)

After the above flush work is complete, we will always check if
s_journal_destroying is set. If yes, then we should never schedule the
sb update work

>   destroy_workqueue(sbi->rsv_conversion_wq)
>
>   ext4_journal_destroy()
>    /* trigger a commit (it will commit the last trnasaction) */
>
>                     **kjournald2**
>                     jbd2_journal_commit_transaction()
>                     ...
>                      ext4_inode_error()
>                       schedule_work(s_sb_upd_work))

Then this schedule work will never happen, since it will check if
s_journal_destroying flag is set. 

>
>                                      **workqueue**
>                                       update_super_work()
>                                         jbd2_journal_start(journal)
>                                           start_this_handle()
>                                           //This new trans will
>                                           //not be committed.
>
>                      jbd2_journal_abort()
>
>    /* wait for it to complete */
>
>    flush_work(&sbi->s_sb_upd_work)

No need to again call the flush work here, since there is no new work
which will be scheduled right.

Am I missing something?

-ritesh


>    jbd2_journal_destroy()
>     journal->j_flags |= JBD2_UNMOUNT;
>    jbd2_journal_commit_transaction() //it will commit nothing
>
> Thanks,
> Yi.

