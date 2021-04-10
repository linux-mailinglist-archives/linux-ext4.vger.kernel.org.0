Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B29C635B028
	for <lists+linux-ext4@lfdr.de>; Sat, 10 Apr 2021 21:45:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbhDJTpW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 10 Apr 2021 15:45:22 -0400
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:58213 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234536AbhDJTpV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 10 Apr 2021 15:45:21 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UV59u0x_1618083901;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UV59u0x_1618083901)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 11 Apr 2021 03:45:03 +0800
Subject: Re: [PATCH] ext4: add a configurable parameter to prevent endless
 loop in ext4_mb_discard_group_p
To:     riteshh <riteshh@linux.ibm.com>
Cc:     adilger@dilger.ca, tytso@mit.edu, linux-ext4@vger.kernel.org,
        jack@suse.cz, linux-kernel@vger.kernel.org,
        baoyou.xie@alibaba-inc.com
References: <f16d7afa-3799-f523-3c19-9ceb9427ff6e@linux.alibaba.com>
 <20210409054733.avv3ofqpka4m6xe5@riteshh-domain>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <0e0c2283-5eb9-e121-35b2-61dbccc8203b@linux.alibaba.com>
Date:   Sun, 11 Apr 2021 03:45:01 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <20210409054733.avv3ofqpka4m6xe5@riteshh-domain>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



ÔÚ 2021/4/9 ÏÂÎç1:47, riteshh Ð´µÀ:
> On 21/04/09 02:50AM, Wen Yang wrote:
>>> On Apr 7, 2021, at 5:16 AM, riteshh <riteshh@linux.ibm.com> wrote:
>>>>
>>>> On 21/04/07 03:01PM, Wen Yang wrote:
>>>>> From: Wen Yang <simon.wy@alibaba-inc.com>
>>>>>
>>>>> The kworker has occupied 100% of the CPU for several days:
>>>>> PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
>>>>> 68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11
>>>>>
>>>>> And the stack obtained through sysrq is as follows:
>>>>> [20613144.850426] task: ffff8800b5e08000 task.stack: ffffc9001342c000
>>>>> [20613144.850438] Call Trace:
>>>>> [20613144.850439] [<ffffffffa0244209>]ext4_mb_new_blocks+0x429/0x550
>> [ext4]
>>>>> [20613144.850439]  [<ffffffffa02389ae>] ext4_ext_map_blocks+0xb5e/0xf30
>> [ext4]
>>>>> [20613144.850441]  [<ffffffffa0204b52>] ext4_map_blocks+0x172/0x620
>> [ext4]
>>>>> [20613144.850442]  [<ffffffffa0208675>] ext4_writepages+0x7e5/0xf00
>> [ext4]
>>>>> [20613144.850443]  [<ffffffff811c487e>] do_writepages+0x1e/0x30
>>>>> [20613144.850444]  [<ffffffff81280265>]
>> __writeback_single_inode+0x45/0x320
>>>>> [20613144.850444]  [<ffffffff81280ab2>] writeback_sb_inodes+0x272/0x600
>>>>> [20613144.850445]  [<ffffffff81280ed2>] __writeback_inodes_wb+0x92/0xc0
>>>>> [20613144.850445]  [<ffffffff81281238>] wb_writeback+0x268/0x300
>>>>> [20613144.850446]  [<ffffffff812819f4>] wb_workfn+0xb4/0x380
>>>>> [20613144.850447]  [<ffffffff810a5dc9>] process_one_work+0x189/0x420
>>>>> [20613144.850447]  [<ffffffff810a60ae>] worker_thread+0x4e/0x4b0
>>>>>
>>>>> The cpu resources of the cloud server are precious, and the server
>>>>> cannot be restarted after running for a long time, so a configuration
>>>>> parameter is added to prevent this endless loop.
>>>>
>>>> Strange, if there is a endless loop here. Then I would definitely see
>>>> if there is any accounting problem in pa->pa_count. Otherwise busy=1
>>>> should not be set everytime. ext4_mb_show_pa() function may help debug
>> this.
>>>>
>>>> If yes, then that means there always exists either a file preallocation
>>>> or a group preallocation. Maybe it is possible, in some use case.
>>>> Others may know of such use case, if any.
>>
>>> If this code is broken, then it doesn't make sense to me that we would
>>> leave it in the "run forever" state after the patch, and require a sysfs
>>> tunable to be set to have a properly working system?
>>
>>> Is there anything particularly strange about the workload/system that
>>> might cause this?  Filesystem is very full, memory is very low, etc?
>>
>> Hi Ritesh and Andreas,
>>
>> Thank you for your reply. Since there is still a faulty machine, we have
>> analyzed it again and found it is indeed a very special case:
>>
>>
>> crash> struct ext4_group_info ffff8813bb5f72d0
>> struct ext4_group_info {
>>    bb_state = 0,
>>    bb_free_root = {
>>      rb_node = 0x0
>>    },
>>    bb_first_free = 1681,
>>    bb_free = 0,
> 
> Not related to this issue, but above two variables values doesn't looks
> consistent.
> 
>>    bb_fragments = 0,
>>    bb_largest_free_order = -1,
>>    bb_prealloc_list = {
>>      next = 0xffff880268291d78,
>>      prev = 0xffff880268291d78     ---> *** The list is empty
>>    },
> 
> Ok. So when you collected the dump this list was empty.
> 
>>    alloc_sem = {
>>      count = {
>>        counter = 0
>>      },
>>      wait_list = {
>>        next = 0xffff8813bb5f7308,
>>        prev = 0xffff8813bb5f7308
>>      },
>>      wait_lock = {
>>        raw_lock = {
>>          {
>>            val = {
>>              counter = 0
>>            },
>>            {
>>              locked = 0 '\000',
>>              pending = 0 '\000'
>>            },
>>            {
>>              locked_pending = 0,
>>              tail = 0
>>            }
>>          }
>>        }
>>      },
>>      osq = {
>>        tail = {
>>          counter = 0
>>        }
>>      },
>>      owner = 0x0
>>    },
>>    bb_counters = 0xffff8813bb5f7328
>> }
>> crash>
>>
>>
>> crash> list 0xffff880268291d78  -l ext4_prealloc_space.pa_group_list -s
> 
> No point of doing this I guess, since the list anyway is empty.
> What you may be seeing below is some garbage data.
> 
>> ext4_prealloc_space.pa_count
>> ffff880268291d78
>>    pa_count = {
>>      counter = 1      ---> ****pa->pa_count
>>    }
>> ffff8813bb5f72f0
>>    pa_count = {
>>      counter = -30701
>>    }
> 
> I guess, since list is empty and you are seeing garbage hence counter value
> of above node looks weird.
> 
>>
>>
>> crash> struct -xo  ext4_prealloc_space
>> struct ext4_prealloc_space {
>>     [0x0] struct list_head pa_inode_list;
>>    [0x10] struct list_head pa_group_list;
>>           union {
>>               struct list_head pa_tmp_list;
>>               struct callback_head pa_rcu;
>>    [0x20] } u;
>>    [0x30] spinlock_t pa_lock;
>>    [0x34] atomic_t pa_count;
>>    [0x38] unsigned int pa_deleted;
>>    [0x40] ext4_fsblk_t pa_pstart;
>>    [0x48] ext4_lblk_t pa_lstart;
>>    [0x4c] ext4_grpblk_t pa_len;
>>    [0x50] ext4_grpblk_t pa_free;
>>    [0x54] unsigned short pa_type;
>>    [0x58] spinlock_t *pa_obj_lock;
>>    [0x60] struct inode *pa_inode;
>> }
>> SIZE: 0x68
>>
>>
>> crash> rd 0xffff880268291d68 20
>> ffff880268291d68:  ffff881822f8a4c8 ffff881822f8a4c8   ..."......."....
>> ffff880268291d78:  ffff8813bb5f72f0 ffff8813bb5f72f0   .r_......r_.....
>> ffff880268291d88:  0000000000001000 ffff880db2371000   ..........7.....
>> ffff880268291d98:  0000000100000001 0000000000000000   ................
>> ffff880268291da8:  0000000000029c39 0000001700000c41   9.......A.......
>> ffff880268291db8:  ffff000000000016 ffff881822f8a4d8   ..........."....
>> ffff880268291dc8:  ffff881822f8a268 ffff880268291af8   h.."......)h....
>> ffff880268291dd8:  ffff880268291dd0 ffffea00069a07c0   ..)h............
>> ffff880268291de8:  00000000004d5bb7 0000000000001000   .[M.............
>> ffff880268291df8:  ffff8801a681f000 0000000000000000   ................
> 
> I am not sure what was intention behind above data.
> 

The above is the original data of ext4_prealloc_space(0xffff880268291d78 
- 0x10). After formatting, it is as follows:

crash> struct ext4_prealloc_space  0xffff880268291d68
struct ext4_prealloc_space {
   pa_inode_list = {
     next = 0xffff881822f8a4c8,
     prev = 0xffff881822f8a4c8
   },
   pa_group_list = {
     next = 0xffff8813bb5f72f0,
     prev = 0xffff8813bb5f72f0
   },
   u = {
     pa_tmp_list = {
       next = 0x1000,
       prev = 0xffff880db2371000
     },
     pa_rcu = {
       next = 0x1000,
       func = 0xffff880db2371000
     }
   },
   pa_lock = {
     {
       rlock = {
         raw_lock = {
           {
             val = {
               counter = 0
             },
             {
               locked = 0 '\000',
               pending = 0 '\000'
             },
             {
               locked_pending = 0,
               tail = 0
             }
           }
         }
       }
     }
   },
   pa_count = {
     counter = 1
   },
   pa_deleted = 0,
   pa_pstart = 171065,
   pa_lstart = 3137,
   pa_len = 23,
   pa_free = 22,
   pa_type = 0,
   pa_obj_lock = 0xffff881822f8a4d8,
   pa_inode = 0xffff881822f8a268
}


It is a legal data, which can be verified by pa_inode£º
crash>  kmem 0xffff881822f8a268
CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
ffff881fa6fd4a00     1064      95450    196620   6554    32k 
ext4_inode_cache
   SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
   ffffea00608be200  ffff881822f88000     0     30         27     3
   FREE / [ALLOCATED]
   [ffff881822f8a180]

We further analyze the pa (0xffff880268291d68) and find that another 
kworker is indeed using it:


ffff881822f8a4c8: ffff880268291d68

crash> kmem ffff881822f8a4c8
CACHE             OBJSIZE  ALLOCATED     TOTAL  SLABS  SSIZE  NAME
ffff881fa6fd4a00     1064      95450    196620   6554    32k 
ext4_inode_cache
   SLAB              MEMORY            NODE  TOTAL  ALLOCATED  FREE
   ffffea00608be200  ffff881822f88000     0     30         27     3
   FREE / [ALLOCATED]
   [ffff881822f8a180]

crash> struct ext4_inode_info.i_prealloc_list ffff881822f8a180
   i_prealloc_list = {
     next = 0xffff880268291d68,
     prev = 0xffff880268291d68
   }


PID: 15140  TASK: ffff88004d6dc300  CPU: 16  COMMAND: "kworker/u64:1"
  #0 [ffffc900273e7518] __schedule at ffffffff8173ca3b
  #1 [ffffc900273e75a0] schedule at ffffffff8173cfb6
  #2 [ffffc900273e75b8] io_schedule at ffffffff810bb75a
  #3 [ffffc900273e75e0] bit_wait_io at ffffffff8173d8d1
  #4 [ffffc900273e75f8] __wait_on_bit_lock at ffffffff8173d4e9
  #5 [ffffc900273e7638] out_of_line_wait_on_bit_lock at ffffffff8173d742
  #6 [ffffc900273e76b0] __lock_buffer at ffffffff81288c32
  #7 [ffffc900273e76c8] do_get_write_access at ffffffffa00dd177 [jbd2]
  #8 [ffffc900273e7728] jbd2_journal_get_write_access at 
ffffffffa00dd3a3 [jbd2]
  #9 [ffffc900273e7750] __ext4_journal_get_write_access at 
ffffffffa023b37b [ext4]
#10 [ffffc900273e7788] ext4_mb_mark_diskspace_used at ffffffffa0242a0b 
[ext4]
     ffffc900273e7790: ffff880f80618000 ffff881822f8a4c8 ----> here
     ffffc900273e77a0: ffffc900273e77e8 00000000a023e517
     ffffc900273e77b0: ffff8800436a6140 16abbde9a386f6c8
     ffffc900273e77c0: ffff880f8061c800 0000000000000000
     ffffc900273e77d0: ffffc900273e78bc ffff880f80618000
     ffffc900273e77e0: ffffc900273e78e0 ffffc900273e7858
     ffffc900273e77f0: ffffffffa0244100

#11 [ffffc900273e77f0] ext4_mb_new_blocks at ffffffffa0244100 [ext4]
#12 [ffffc900273e7860] ext4_ext_map_blocks at ffffffffa02389ae [ext4]
#13 [ffffc900273e7950] ext4_map_blocks at ffffffffa0204b52 [ext4]
#14 [ffffc900273e79d0] ext4_writepages at ffffffffa0208675 [ext4]
#15 [ffffc900273e7b30] do_writepages at ffffffff811c487e
#16 [ffffc900273e7b40] __writeback_single_inode at ffffffff81280265
#17 [ffffc900273e7b90] writeback_sb_inodes at ffffffff81280ab2
#18 [ffffc900273e7c90] __writeback_inodes_wb at ffffffff81280ed2
#19 [ffffc900273e7cd8] wb_writeback at ffffffff81281238
#20 [ffffc900273e7d80] wb_workfn at ffffffff812819f4
#21 [ffffc900273e7e18] process_one_work at ffffffff810a5dc9
#22 [ffffc900273e7e60] worker_thread at ffffffff810a60ae
#23 [ffffc900273e7ec0] kthread at ffffffff810ac696
#24 [ffffc900273e7f50] ret_from_fork at ffffffff81741dd9


At this time, some logs are lost. It is suspected that the hard disk 
itself is faulty.

There are many hard disks on our server. Maybe we should not occupy 100% 
CPU for a long time just because one hard disk fails.

Please check the patch below again, thanks

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 99bf091..de423234 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -351,6 +351,8 @@ static void ext4_mb_generate_from_freelist(struct 
super_block *sb, void *bitmap,
  						ext4_group_t group);
  static void ext4_mb_new_preallocation(struct ext4_allocation_context *ac);

+static inline void ext4_mb_show_pa(struct super_block *sb);
+
  /*
   * The algorithm using this percpu seq counter goes below:
   * 1. We sample the percpu discard_pa_seq counter before trying for block
@@ -4211,7 +4213,7 @@ static void ext4_mb_new_preallocation(struct 
ext4_allocation_context *ac)
  	struct list_head list;
  	struct ext4_buddy e4b;
  	int err;
-	int busy = 0;
+	int busy;
  	int free, free_total = 0;

  	mb_debug(sb, "discard preallocation for group %u\n", group);
@@ -4240,6 +4242,7 @@ static void ext4_mb_new_preallocation(struct 
ext4_allocation_context *ac)

  	INIT_LIST_HEAD(&list);
  repeat:
+	busy = 0;
  	free = 0;
  	ext4_lock_group(sb, group);
  	list_for_each_entry_safe(pa, tmp,
@@ -4248,6 +4251,8 @@ static void ext4_mb_new_preallocation(struct 
ext4_allocation_context *ac)
  		if (atomic_read(&pa->pa_count)) {
  			spin_unlock(&pa->pa_lock);
  			busy = 1;
+			mb_debug(sb, "used pa while discarding for group %u\n", group);
+			ext4_mb_show_pa(sb);
  			continue;
  		}
  		if (pa->pa_deleted) {
@@ -4292,8 +4297,7 @@ static void ext4_mb_new_preallocation(struct 
ext4_allocation_context *ac)
  	/* if we still need more blocks and some PAs were used, try again */
  	if (free_total < needed && busy) {
  		ext4_unlock_group(sb, group);
-		cond_resched();
-		busy = 0;
+		schedule_timeout_uninterruptible(HZ/10);
  		goto repeat;
  	}
  	ext4_unlock_group(sb, group);


--

>>
>>
>>
>> Before "goto repeat", it is necessary to check whether grp->bb_prealloc_list
>> is empty.
>> This patch may fix it.
>> Please kindly give us your comments and suggestions.
>> Thanks.
>>
>>
>> diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
>> index 99bf091..8082e2d 100644
>> --- a/fs/ext4/mballoc.c
>> +++ b/fs/ext4/mballoc.c
>> @@ -4290,7 +4290,7 @@ static void ext4_mb_new_preallocation(struct
>> ext4_allocation_context *ac)
>>          free_total += free;
>>
>>          /* if we still need more blocks and some PAs were used, try again */
>> -       if (free_total < needed && busy) {
>> +       if (free_total < needed && busy &&
>> !list_empty(&grp->bb_prealloc_list)) {
>>                  ext4_unlock_group(sb, group);
>>                  cond_resched();
>>                  busy = 0;
>>
>>
> 
> Not really. Since we anyway check busy variable too. Which is only set when the
> bb_prealloc_list is actually not empty and have some busy pa's in it.
> 
> What may explain this scenario is.
> 1. That this writeback thread which is trying to write the dirty data, tries to
>     free up some blocks but since the free_total < needed and busy == 1,
>     -> so it released the group lock (ext4_unlock_group()) and make busy = 0.
>     -> at this point there could be something running in parallel which may take
>     the group lock and allocate those PAs which were released by this process.
> 
> 2. writeback thread again comes and tries to check if the bb_prealloc_list is
>     empty and it is not since some other thread again allocated something which
>     this guys freed for itself.
> 
> 
> Tell me -
> 1. How low was free space when you hit this issue.
> 2. How big was your FS? How many groups?
> 3. Is there some backgroud worker constantly running who is doing some
>     allocations. Do you have a single cpu system?
>     On this as soon writeback thread release the group lock, the other process
>     gets schedule in, takes the lock and does some group preallocations from the
>     same group from which wb thread freed some blocks.
>     And so wb thread keeps looping.
> 4. Is this a real workload or is it some sort of simulated tests?
> 

This is a real workload.
More detailed information is still being collected. At present, we only 
analyze it based on the vmcore.


--
Best wishes,
Wen


> Maybe if you explain your above setup/environment better, that will help in
> debugging on why this writeback thread was constantly running/enlessly-looping
> for days
> 
> -ritesh
> 
