Return-Path: <linux-ext4+bounces-6718-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA638A577BD
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 03:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F04E1189A3E1
	for <lists+linux-ext4@lfdr.de>; Sat,  8 Mar 2025 02:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 920ED14B965;
	Sat,  8 Mar 2025 02:57:27 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33F7C8EB;
	Sat,  8 Mar 2025 02:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741402647; cv=none; b=oBlhSVaZmoO3tyEUymeB2ujdfpGOp4FEO/ulOhg+ScOYzL36Qn9Ley//TiOudxfBQHwWdx88HqvhdjNR3jfcsjVUFpR5I0q4zA8g9Rhbj5x76tAjNlZlGt6M5WvsrZSo9mN6Hu3PWKzILVrOohvgz5zOu3v33q85LqT3WkpWdTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741402647; c=relaxed/simple;
	bh=eeevZJqPB8EWuZQE0O4ld6ZOPtrsGxgb1rwzbMuBnQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jgKjdQVbwA+7ywFWPy8O22ijDaesXWe/obYno36skhdD4rSXEFKglr4ic0PZoR0MHa2xLppCha57HVDisqULwlgsKjZRqE0tQwhlQbEB5VJuli26VqiNSj4yOmDkmBrjUYeISTt7ktF24UBGfbIM7k9rH4yoomxlpW8z2EU7NKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Z8nqq0YWnz4f3m6r;
	Sat,  8 Mar 2025 10:56:55 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id BC3CF1A06DC;
	Sat,  8 Mar 2025 10:57:18 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBHrGANsstnjkRzFw--.41517S3;
	Sat, 08 Mar 2025 10:57:18 +0800 (CST)
Message-ID: <4f61a0fb-dd9f-4c0e-b872-31e5474ac799@huaweicloud.com>
Date: Sat, 8 Mar 2025 10:57:16 +0800
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] ext4: avoid journaling sb update on error if
 journal is destroying
To: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Cc: Jan Kara <jack@suse.cz>, Baokun Li <libaokun1@huawei.com>,
 linux-kernel@vger.kernel.org, Mahesh Kumar <maheshkumar657g@gmail.com>,
 linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
References: <cover.1741270780.git.ojaswin@linux.ibm.com>
 <1bf59095d87e5dfae8f019385ba3ce58973baaff.1741270780.git.ojaswin@linux.ibm.com>
 <5b3864c3-bcfd-4f45-b427-224d32aca478@huaweicloud.com>
 <Z8qTciy49b7LSHqr@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <Z8qqna0BEDT5ZD82@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e9e92601-53bc-42a2-b428-e61bff6153c5@huaweicloud.com>
 <Z8rKAsmIuBlOo4T1@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
 <e3172770-9b39-4105-966f-faf64a6b6515@huaweicloud.com>
 <Z8ssR7BtBVP1zif2@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Language: en-US
From: Zhang Yi <yi.zhang@huaweicloud.com>
In-Reply-To: <Z8ssR7BtBVP1zif2@li-dc0c254c-257c-11b2-a85c-98b6c1322444.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:gCh0CgBHrGANsstnjkRzFw--.41517S3
X-Coremail-Antispam: 1UD129KBjvJXoW3CrykGFWkGr43Kw48CryrtFb_yoWkXF4xpr
	W5Aa4jyrWUZr1jyr10qr45XrWqgF10yry2gr1UGr18tws8twn7KFy7tFyYkFyUJr45GF18
	ZF4UA397Gw1jyrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUymb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vI
	r41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8Gjc
	xK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0
	cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8V
	AvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E
	14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07UK2NtUUUUU=
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

On 2025/3/8 1:26, Ojaswin Mujoo wrote:
> On Fri, Mar 07, 2025 at 08:36:08PM +0800, Zhang Yi wrote:
>> On 2025/3/7 18:27, Ojaswin Mujoo wrote:
>>> On Fri, Mar 07, 2025 at 04:43:24PM +0800, Zhang Yi wrote:
>>>> On 2025/3/7 16:13, Ojaswin Mujoo wrote:
>>>>> On Fri, Mar 07, 2025 at 12:04:26PM +0530, Ojaswin Mujoo wrote:
>>>>>> On Fri, Mar 07, 2025 at 10:49:28AM +0800, Zhang Yi wrote:
>>>>>>> On 2025/3/6 22:28, Ojaswin Mujoo wrote:
>>>>>>>> Presently we always BUG_ON if trying to start a transaction on a journal marked
>>>>>>>> with JBD2_UNMOUNT, since this should never happen. However, while ltp running
>>>>>>>> stress tests, it was observed that in case of some error handling paths, it is
>>>>>>>> possible for update_super_work to start a transaction after the journal is
>>>>>>>> destroyed eg:
>>>>>>>>
>>>>>>>> (umount)
>>>>>>>> ext4_kill_sb
>>>>>>>>   kill_block_super
>>>>>>>>     generic_shutdown_super
>>>>>>>>       sync_filesystem /* commits all txns */
>>>>>>>>       evict_inodes
>>>>>>>>         /* might start a new txn */
>>>>>>>>       ext4_put_super
>>>>>>>> 	flush_work(&sbi->s_sb_upd_work) /* flush the workqueue */
>>>>>>>>         jbd2_journal_destroy
>>>>>>>>           journal_kill_thread
>>>>>>>>             journal->j_flags |= JBD2_UNMOUNT;
>>>>>>>>           jbd2_journal_commit_transaction
>>>>>>>>             jbd2_journal_get_descriptor_buffer
>>>>>>>>               jbd2_journal_bmap
>>>>>>>>                 ext4_journal_bmap
>>>>>>>>                   ext4_map_blocks
>>>>>>>>                     ...
>>>>>>>>                     ext4_inode_error
>>>>>>>>                       ext4_handle_error
>>>>>>>>                         schedule_work(&sbi->s_sb_upd_work)
>>>>>>>>
>>>>>>>>                                                /* work queue kicks in */
>>>>>>>>                                                update_super_work
>>>>>>>>                                                  jbd2_journal_start
>>>>>>>>                                                    start_this_handle
>>>>>>>>                                                      BUG_ON(journal->j_flags &
>>>>>>>>                                                             JBD2_UNMOUNT)
>>>>>>>>
>>>>>>>> Hence, introduce a new sbi flag s_journal_destroying to indicate journal is
>>>>>>>> destroying only do a journaled (and deferred) update of sb if this flag is not
>>>>>>>> set. Otherwise, just fallback to an un-journaled commit.
>>>>>>>>
>>>>>>>> We set sbi->s_journal_destroying = true only after all the FS updates are done
>>>>>>>> during ext4_put_super() (except a running transaction that will get commited
>>>>>>>> during jbd2_journal_destroy()). After this point, it is safe to commit the sb
>>>>>>>> outside the journal as it won't race with a journaled update (refer
>>>>>>>> 2d01ddc86606).
>>>>>>>>
>>>>>>>> Also, we don't need a similar check in ext4_grp_locked_error since it is only
>>>>>>>> called from mballoc and AFAICT it would be always valid to schedule work here.
>>>>>>>>
>>>>>>>> Fixes: 2d01ddc86606 ("ext4: save error info to sb through journal if available")
>>>>>>>> Reported-by: Mahesh Kumar <maheshkumar657g@gmail.com>
>>>>>>>> Suggested-by: Jan Kara <jack@suse.cz>
>>>>>>>> Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
>>>>>>>> ---
>>>>>>>>  fs/ext4/ext4.h      | 2 ++
>>>>>>>>  fs/ext4/ext4_jbd2.h | 8 ++++++++
>>>>>>>>  fs/ext4/super.c     | 4 +++-
>>>>>>>>  3 files changed, 13 insertions(+), 1 deletion(-)
>>>>>>>>
>>>>>>>> diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
>>>>>>>> index 2b7d781bfcad..d48e93bd5690 100644
>>>>>>>> --- a/fs/ext4/ext4.h
>>>>>>>> +++ b/fs/ext4/ext4.h
>>>>>>>> @@ -1728,6 +1728,8 @@ struct ext4_sb_info {
>>>>>>>>  	 */
>>>>>>>>  	struct work_struct s_sb_upd_work;
>>>>>>>>  
>>>>>>>> +	bool s_journal_destorying;
>>>>>>>> +
>>>>>>>>  	/* Atomic write unit values in bytes */
>>>>>>>>  	unsigned int s_awu_min;
>>>>>>>>  	unsigned int s_awu_max;
>>>>>>>> diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
>>>>>>>> index 9b3c9df02a39..6bd3ca84410d 100644
>>>>>>>> --- a/fs/ext4/ext4_jbd2.h
>>>>>>>> +++ b/fs/ext4/ext4_jbd2.h
>>>>>>>> @@ -437,6 +437,14 @@ static inline int ext4_journal_destroy(struct ext4_sb_info *sbi, journal_t *jour
>>>>>>>>  {
>>>>>>>>  	int err = 0;
>>>>>>>>  
>>>>>>>> +	/*
>>>>>>>> +	 * At this point all pending FS updates should be done except a possible
>>>>>>>> +	 * running transaction (which will commit in jbd2_journal_destroy). It
>>>>>>>> +	 * is now safe for any new errors to directly commit superblock rather
>>>>>>>> +	 * than going via journal.
>>>>>>>> +	 */
>>>>>>>> +	sbi->s_journal_destorying = true;
>>>>>>>> +
>>>>>>>
>>>>>>> Hi, Ojaswin!
>>>>>>>
>>>>>>> I'm afraid you still need to flush the superblock update work here,
>>>>>>> otherwise I guess the race condition you mentioned in v1 could still
>>>>>>> occur.
>>>>>>>
>>>>>>>  ext4_put_super()
>>>>>>>   flush_work(&sbi->s_sb_upd_work)
>>>>>>>
>>>>>>>                     **kjournald2**
>>>>>>>                     jbd2_journal_commit_transaction()
>>>>>>>                     ...
>>>>>>>                     ext4_inode_error()
>>>>>>>                       /* JBD2_UNMOUNT not set */
>>>>>>>                       schedule_work(s_sb_upd_work)
>>>>>>>
>>>>>>>                                   **workqueue**
>>>>>>>                                    update_super_work
>>>>>>>                                    /* s_journal_destorying is not set */
>>>>>>>                             	   if (journal && !s_journal_destorying)
>>>>>>>
>>>>>>>   ext4_journal_destroy()
>>>>>>>    /* set s_journal_destorying */
>>>>>>>    sbi->s_journal_destorying = true;
>>>>>>>    jbd2_journal_destroy()
>>>>>>>     journal->j_flags |= JBD2_UNMOUNT;
>>>>>>>
>>>>>>>                                        jbd2_journal_start()
>>>>>>>                                         start_this_handle()
>>>>>>>                                           BUG_ON(JBD2_UNMOUNT)
>>>>>>>
>>>>>>> Thanks,
>>>>>>> Yi.
>>>>>> Hi Yi,
>>>>>>
>>>>>> Yes you are right, somehow missed this edge case :(
>>>>>>
>>>>>> Alright then, we have to move out sbi->s_journal_destroying outside the
>>>>>> helper. Just wondering if I should still let it be in
>>>>>> ext4_journal_destroy and just add an extra s_journal_destroying = false
>>>>>> before schedule_work(s_sb_upd_work), because it makes sense.
>>>>>>
>>>>>> Okay let me give it some thought but thanks for pointing this out!
>>>>>>
>>>>>> Regards,
>>>>>> ojaswin
>>>>>
>>>>> Okay so thinking about it a bit more, I see you also suggested to flush
>>>>> the work after marking sbi->s_journal_destroying. But will that solve
>>>>> it?
>>>>>
>>>>>   ext4_put_super()
>>>>>    flush_work(&sbi->s_sb_upd_work)
>>>>>  
>>>>>                      **kjournald2**
>>>>>                      jbd2_journal_commit_transaction()
>>>>>                      ...
>>>>>                      ext4_inode_error()
>>>>>                        /* JBD2_UNMOUNT not set */
>>>>>                        schedule_work(s_sb_upd_work)
>>>>>  
>>>>>                                     **workqueue**
>>>>>                                     update_super_work
>>>>>                                     /* s_journal_destorying is not set */
>>>>>                              	      if (journal && !s_journal_destorying)
>>>>>  
>>>>>    ext4_journal_destroy()
>>>>>     /* set s_journal_destorying */
>>>>>     sbi->s_journal_destorying = true;
>>>>>     flush_work(&sbi->s_sb_upd_work)
>>>>>                                       schedule_work()
>>>>                                         ^^^^^^^^^^^^^^^
>>>>                                         where does this come from?
>>>>
>>>> After this flush_work, we can guarantee that the running s_sb_upd_work
>>>> finishes before we set JBD2_UNMOUNT. Additionally, the journal will
>>>> not commit transaction or call schedule_work() again because it has
>>>> been aborted due to the previous error. Am I missing something?
>>>>
>>>> Thanks,
>>>> Yi.
>>>
>>> Hmm, so I am thinking of a corner case in ext4_handle_error() where 
>>>
>>>  if(journal && !is_journal_destroying) 
>>>
>>> is computed but schedule_work() not called yet, which is possible cause
>>> the cmp followed by jump is not atomic in nature. If the schedule_work
>>> is only called after we have done the flush then we end up with this:
>>>
>>>                               	      if (journal && !s_journal_destorying)
>>>     ext4_journal_destroy()
>>>      /* set s_journal_destorying */
>>>      sbi->s_journal_destorying = true;
>>>      flush_work(&sbi->s_sb_upd_work)
>>>                                        schedule_work()
>>>
>>> Which is possible IMO, although the window is tiny.
>>
>> Yeah, right!
>> Sorry for misread the location where you add the "!s_journal_destorying"
>> check, the graph I provided was in update_super_work(), which was wrong.
> 
> Oh right, I also misread your trace but yes as discussed, even 
> 
>     sbi->s_journal_destorying = true;
> 		flush_work()
>     jbd2_journal_destroy()
> 
> doesn't work.
> 
>> The right one should be:
>>
>>  ext4_put_super()
>>   flush_work(&sbi->s_sb_upd_work)
>>
>>                     **kjournald2**
>>                     jbd2_journal_commit_transaction()
>>                     ...
>>                     ext4_inode_error()
>>                       /* s_journal_destorying is not set */
>>                       if (journal && !s_journal_destorying)
>>                         (schedule_work(s_sb_upd_work))  //can be here
>>
>>   ext4_journal_destroy()
>>    /* set s_journal_destorying */
>>    sbi->s_journal_destorying = true;
>>    jbd2_journal_destroy()
>>     journal->j_flags |= JBD2_UNMOUNT;
>>
>>                         (schedule_work(s_sb_upd_work))  //also can be here
>>
>>                                   **workqueue**
>>                                    update_super_work()
>>                                    journal = sbi->s_journal //get journal
>>     kfree(journal)
>>                                      jbd2_journal_start(journal) //journal UAF
>>                                        start_this_handle()
>>                                          BUG_ON(JBD2_UNMOUNT) //bugon here
>>
>>
>> So there are two problems here, the first one is the 'journal' UAF,
>> the second one is triggering JBD2_UNMOUNT flag BUGON.
> 
> Indeed, there's a possible UAF here as well.
> 
>>
>>>>>
>>>>> As for the fix, how about we do something like this:
>>>>>
>>>>>   ext4_put_super()
>>>>>
>>>>>    flush_work(&sbi->s_sb_upd_work)
>>>>>    destroy_workqueue(sbi->rsv_conversion_wq);
>>>>>
>>>>>    ext4_journal_destroy()
>>>>>     /* set s_journal_destorying */
>>>>>     sbi->s_journal_destorying = true;
>>>>>
>>>>>    /* trigger a commit and wait for it to complete */
>>>>>
>>>>>     flush_work(&sbi->s_sb_upd_work)
>>>>>
>>>>>     jbd2_journal_destroy()
>>>>>      journal->j_flags |= JBD2_UNMOUNT;
>>>>>  
>>>>>                                         jbd2_journal_start()
>>>>>                                          start_this_handle()
>>>>>                                            BUG_ON(JBD2_UNMOUNT)
>>>>>
>>>>> Still giving this codepath some thought but seems like this might just
>>>>> be enough to fix the race. Thoughts on this?
>>>>>
>>
>> I think this solution should work, the forced commit and flush_work()
>> should ensure that the last transaction is committed and that the
>> potential work is done.
>>
>> Besides, the s_journal_destorying flag is set and check concurrently
>> now, so we need WRITE_ONCE() and READ_ONCE() for it. Besides, what
>> about adding a new flag into sbi->s_mount_state instead of adding
>> new s_journal_destorying?
> 
> Right, that makes sence. I will incorporate these changes in the next 
> revision.
> 

Think about this again, it seems that we no longer need the destroying
flag. Because we force to commit and wait for the **last** transaction to
complete, and the flush work should also ensure that the last sb_update
work to complete. Regardless of whether it starts a new handle in the
last update_super_work(), it will not commit since the journal should
have aborted. What are your thoughts?

 ext4_put_super()
  flush_work(&sbi->s_sb_upd_work)
  destroy_workqueue(sbi->rsv_conversion_wq)

  ext4_journal_destroy()
   /* trigger a commit (it will commit the last trnasaction) */

                    **kjournald2**
                    jbd2_journal_commit_transaction()
                    ...
                     ext4_inode_error()
                      schedule_work(s_sb_upd_work))

                                     **workqueue**
                                      update_super_work()
                                        jbd2_journal_start(journal)
                                          start_this_handle()
                                          //This new trans will
                                          //not be committed.

                     jbd2_journal_abort()

   /* wait for it to complete */

   flush_work(&sbi->s_sb_upd_work)
   jbd2_journal_destroy()
    journal->j_flags |= JBD2_UNMOUNT;
   jbd2_journal_commit_transaction() //it will commit nothing

Thanks,
Yi.


