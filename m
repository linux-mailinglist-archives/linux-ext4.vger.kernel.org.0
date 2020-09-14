Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 48B7B268311
	for <lists+linux-ext4@lfdr.de>; Mon, 14 Sep 2020 05:21:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725982AbgINDVw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 13 Sep 2020 23:21:52 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11824 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbgINDVv (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 13 Sep 2020 23:21:51 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 18639A43D1BD9D69EB85;
        Mon, 14 Sep 2020 11:21:48 +0800 (CST)
Received: from [10.174.179.86] (10.174.179.86) by
 DGGEMS409-HUB.china.huawei.com (10.3.19.209) with Microsoft SMTP Server id
 14.3.487.0; Mon, 14 Sep 2020 11:21:46 +0800
Subject: Re: [PATCH v3] ext4: Fix dead loop in ext4_mb_new_blocks
To:     Ritesh Harjani <riteshh@linux.ibm.com>, Jan Kara <jack@suse.cz>
References: <20200910091252.525346-1-yebin10@huawei.com>
 <20200910161753.GB17362@quack2.suse.cz>
 <0e48b9bb-f839-4b3b-dbce-45755618df97@linux.ibm.com>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <linux-ext4@vger.kernel.org>
From:   yebin <yebin10@huawei.com>
Message-ID: <5F5EE1CA.9090306@huawei.com>
Date:   Mon, 14 Sep 2020 11:21:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.1.0
MIME-Version: 1.0
In-Reply-To: <0e48b9bb-f839-4b3b-dbce-45755618df97@linux.ibm.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.86]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In fact, we didn't free the available space, and other processes 
couldn't get it
even if they tried again.

According to your opinions, I made two different revisions. Which one do 
you think is better?
（1）Free PAs before repeat
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 132c118d12e1..4ab76882350d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4189,7 +4189,6 @@ ext4_mb_discard_group_preallocations(struct 
super_block *sb,
         INIT_LIST_HEAD(&list);
  repeat:
         ext4_lock_group(sb, group);
-       this_cpu_inc(discard_pa_seq);
         list_for_each_entry_safe(pa, tmp,
                                 &grp->bb_prealloc_list, pa_group_list) {
                 spin_lock(&pa->pa_lock);
@@ -4215,22 +4214,6 @@ ext4_mb_discard_group_preallocations(struct 
super_block *sb,
                 list_add(&pa->u.pa_tmp_list, &list);
         }

-       /* if we still need more blocks and some PAs were used, try again */
-       if (free < needed && busy) {
-               busy = 0;
-               ext4_unlock_group(sb, group);
-               cond_resched();
-               goto repeat;
-       }
-
-       /* found anything to free? */
-       if (list_empty(&list)) {
-               BUG_ON(free != 0);
-               mb_debug(sb, "Someone else may have freed PA for this 
group %u\n",
-                        group);
-               goto out;
-       }
-
         /* now free all selected PAs */
         list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {

@@ -4248,6 +4231,14 @@ ext4_mb_discard_group_preallocations(struct 
super_block *sb,
                 call_rcu(&(pa)->u.pa_rcu, ext4_mb_pa_callback);
         }

+       /* if we still need more blocks and some PAs were used, try again */
+       if (free < needed && busy) {
+               busy = 0;
+               ext4_unlock_group(sb, group);
+               cond_resched();
+               goto repeat;
+       }
+
  out:
         ext4_unlock_group(sb, group);
         ext4_mb_unload_buddy(&e4b);
--

(2)
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 132c118d12e1..188772bbf679 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4189,7 +4189,6 @@ ext4_mb_discard_group_preallocations(struct 
super_block *sb,
         INIT_LIST_HEAD(&list);
  repeat:
         ext4_lock_group(sb, group);
-       this_cpu_inc(discard_pa_seq);
         list_for_each_entry_safe(pa, tmp,
                                 &grp->bb_prealloc_list, pa_group_list) {
                 spin_lock(&pa->pa_lock);
@@ -4217,6 +4216,8 @@ ext4_mb_discard_group_preallocations(struct 
super_block *sb,

         /* if we still need more blocks and some PAs were used, try 
again */
         if (free < needed && busy) {
+               if (free)
+                       this_cpu_inc(discard_pa_seq);
                 busy = 0;
                 ext4_unlock_group(sb, group);
                 cond_resched();



On 2020/9/11 21:20, Ritesh Harjani wrote:
> Hello Ye,
>
> Please excuse if there is something horribly wrong with my email
> formatting. Have yesterday received this laptop and still setting up
> few things.
>
> On 9/10/20 9:47 PM, Jan Kara wrote:
>> On Thu 10-09-20 17:12:52, Ye Bin wrote:
>>> As we test disk offline/online with running fsstress, we find fsstress
>>> process is keeping running state.
>>> kworker/u32:3-262   [004] ...1   140.787471: 
>>> ext4_mb_discard_preallocations: dev 8,32 needed 114
>>> ....
>>> kworker/u32:3-262   [004] ...1   140.787471: 
>>> ext4_mb_discard_preallocations: dev 8,32 needed 114
>>>
>>> ext4_mb_new_blocks
>>> repeat:
>>>     ext4_mb_discard_preallocations_should_retry(sb, ac, &seq)
>>>         freed = ext4_mb_discard_preallocations
>>>             ext4_mb_discard_group_preallocations
>>>                 this_cpu_inc(discard_pa_seq);
>>>         ---> freed == 0
>>>         seq_retry = ext4_get_discard_pa_seq_sum
>>>             for_each_possible_cpu(__cpu)
>>>                 __seq += per_cpu(discard_pa_seq, __cpu);
>>>         if (seq_retry != *seq) {
>>>             *seq = seq_retry;
>>>             ret = true;
>>>         }
>>>
>>> As we see seq_retry is sum of discard_pa_seq every cpu, if
>>> ext4_mb_discard_group_preallocations return zero discard_pa_seq in this
>>> cpu maybe increase one, so condition "seq_retry != *seq" have always
>>> been met.
>>> To Fix this problem, in ext4_mb_discard_group_preallocations 
>>> function increase
>>> discard_pa_seq only when it found preallocation to discard.
>>>
>>> Fixes: 07b5b8e1ac40 ("ext4: mballoc: introduce pcpu seqcnt for 
>>> freeing PA to improve ENOSPC handling")
>>> Signed-off-by: Ye Bin <yebin10@huawei.com>
>>
>> Thanks for the patch. One comment below.
>>
>>> ---
>>>   fs/ext4/mballoc.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>>> index f386fe62727d..fd55264dc3fe 100644
>>> --- a/fs/ext4/mballoc.c
>>> +++ b/fs/ext4/mballoc.c
>>> @@ -4191,7 +4191,6 @@ ext4_mb_discard_group_preallocations(struct 
>>> super_block *sb,
>>>       INIT_LIST_HEAD(&list);
>>>   repeat:
>>>       ext4_lock_group(sb, group);
>>> -    this_cpu_inc(discard_pa_seq);
>>>       list_for_each_entry_safe(pa, tmp,
>>>                   &grp->bb_prealloc_list, pa_group_list) {
>>>           spin_lock(&pa->pa_lock);
>>> @@ -4233,6 +4232,9 @@ ext4_mb_discard_group_preallocations(struct 
>>> super_block *sb,
>>>           goto out;
>>>       }
>>>   +    /* only increase when find reallocation to discard */
>>> +    this_cpu_inc(discard_pa_seq);
>>> +
>>
>> This is a good place to increment the counter but I think you also 
>> need to
>> handle the case:
>>
>>          if (free < needed && busy) {
>>                  busy = 0;
>>                  ext4_unlock_group(sb, group);
>>                  cond_resched();
>>                  goto repeat;
>>          }
>>
>> We can unlock the group here after removing some preallocations and thus
>> other processes checking discard_pa_seq could miss we did this. In 
>> fact I
>> think the code is somewhat buggy here and we should also discard extents
>> accumulated on "list" so far before unlocking the group. Ritesh?
>>
>
> mmm, so even though this code is not discarding those buffers b4
> unlocking, but it has still removed those from the grp->bb_prealloc_list
> and added it to the local list. And since it will at some point get
> scheduled and start operating from repeat: label so functionally wise
> this should be ok. Am I missing anything?
>
> Although I agree, that if we remove at least the current pa's before
> unlocking the group may be a good idea, but we should also check
> why was this done like this at the first place.
>
>
> I agree with Jan, that we should increment discard_pa_seq once we 
> actually have something
> to discard. I should have written a comment here to explain why we did 
> this here.
> But I think commit msg should have all the history (since I have a 
> habit of writing long commit msgs ;)
>
> But IIRC, it was done since in case if there is a parallel thread 
> which is discarding
> all the preallocations so the current thread may return 0 since it 
> checks the
> list_empty(&grp->bb_prealloc_list) check in 
> ext4_mb_discard_group_preallocations() and returns 0 directly.
>
> And why the discard_pa_seq counter at other places may not help since 
> we remove the pa nodes from
> grp->bb_prealloc_list into a local list and then start operating on
> that. So meanwhile some thread may comes and just checks that the list
> is empty and return 0 while some other thread may start discarding from
> it's local list.
> So I guess the main problem was that in the current code we remove
> the pa from grp->bb_prealloc_list and add it to local list. So if 
> someone else comes
> and checks that grp->bb_prealloc_list is empty then it will directly 
> return 0.
>
> So, maybe we could do something like this then?
>
> repeat:
>     ext4_lock_group(sb, group);
> -    this_cpu_inc(discard_pa_seq);
> list_for_each_entry_safe(pa, tmp,
>                 &grp->bb_prealloc_list, pa_group_list) {<...>
>
> +        if (!free)
> +            this_cpu_inc(discard_pa_seq);   // we should do this here 
> before calling list_del(&pa->pa_group_list);
>
>         /* we can trust pa_free ... */
>         free += pa->pa_free;
>         spin_unlock(&pa->pa_lock);
>
>         list_del(&pa->pa_group_list);
>         list_add(&pa->u.pa_tmp_list, &list);
>     }
>
> I have some test cases around this to test for cases which were
> failing. Since in world of parallelism you can't be 100% certain of some
> corner case (like this one you just reported).
> But, I don't have my other box rite now where I kept all of those -
> due to some technical issues. I think I should be able to get those by
> next week, if not, I anyways will setup my current machine for testing
> this.
>
> -ritesh
> .
>

