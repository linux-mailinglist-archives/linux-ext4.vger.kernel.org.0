Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8A184358CF1
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Apr 2021 20:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232933AbhDHSu6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Apr 2021 14:50:58 -0400
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131]:55631 "EHLO
        out30-131.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232851AbhDHSu5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Apr 2021 14:50:57 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01424;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UUv8UWY_1617907842;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UUv8UWY_1617907842)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 09 Apr 2021 02:50:43 +0800
From:   Wen Yang <wenyang@linux.alibaba.com>
To:     adilger@dilger.ca, riteshh@linux.ibm.com
Cc:     tytso@mit.edu, linux-ext4@vger.kernel.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, baoyou.xie@alibaba-inc.com
Subject: Re: [PATCH] ext4: add a configurable parameter to prevent endless
 loop in ext4_mb_discard_group_p
Message-ID: <f16d7afa-3799-f523-3c19-9ceb9427ff6e@linux.alibaba.com>
Date:   Fri, 9 Apr 2021 02:50:42 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

 > On Apr 7, 2021, at 5:16 AM, riteshh <riteshh@linux.ibm.com> wrote:
 >>
 >> On 21/04/07 03:01PM, Wen Yang wrote:
 >>> From: Wen Yang <simon.wy@alibaba-inc.com>
 >>>
 >>> The kworker has occupied 100% of the CPU for several days:
 >>> PID USER  PR  NI VIRT RES SHR S  %CPU  %MEM TIME+  COMMAND
 >>> 68086 root 20 0  0    0   0   R  100.0 0.0  9718:18 kworker/u64:11
 >>>
 >>> And the stack obtained through sysrq is as follows:
 >>> [20613144.850426] task: ffff8800b5e08000 task.stack: ffffc9001342c000
 >>> [20613144.850438] Call Trace:
 >>> [20613144.850439] 
[<ffffffffa0244209>]ext4_mb_new_blocks+0x429/0x550 [ext4]
 >>> [20613144.850439]  [<ffffffffa02389ae>] 
ext4_ext_map_blocks+0xb5e/0xf30 [ext4]
 >>> [20613144.850441]  [<ffffffffa0204b52>] ext4_map_blocks+0x172/0x620 
[ext4]
 >>> [20613144.850442]  [<ffffffffa0208675>] ext4_writepages+0x7e5/0xf00 
[ext4]
 >>> [20613144.850443]  [<ffffffff811c487e>] do_writepages+0x1e/0x30
 >>> [20613144.850444]  [<ffffffff81280265>] 
__writeback_single_inode+0x45/0x320
 >>> [20613144.850444]  [<ffffffff81280ab2>] writeback_sb_inodes+0x272/0x600
 >>> [20613144.850445]  [<ffffffff81280ed2>] __writeback_inodes_wb+0x92/0xc0
 >>> [20613144.850445]  [<ffffffff81281238>] wb_writeback+0x268/0x300
 >>> [20613144.850446]  [<ffffffff812819f4>] wb_workfn+0xb4/0x380
 >>> [20613144.850447]  [<ffffffff810a5dc9>] process_one_work+0x189/0x420
 >>> [20613144.850447]  [<ffffffff810a60ae>] worker_thread+0x4e/0x4b0
 >>>
 >>> The cpu resources of the cloud server are precious, and the server
 >>> cannot be restarted after running for a long time, so a configuration
 >>> parameter is added to prevent this endless loop.
 >>
 >> Strange, if there is a endless loop here. Then I would definitely see
 >> if there is any accounting problem in pa->pa_count. Otherwise busy=1
 >> should not be set everytime. ext4_mb_show_pa() function may help 
debug this.
 >>
 >> If yes, then that means there always exists either a file preallocation
 >> or a group preallocation. Maybe it is possible, in some use case.
 >> Others may know of such use case, if any.

 > If this code is broken, then it doesn't make sense to me that we would
 > leave it in the "run forever" state after the patch, and require a sysfs
 > tunable to be set to have a properly working system?

 > Is there anything particularly strange about the workload/system that
 > might cause this?  Filesystem is very full, memory is very low, etc?

Hi Ritesh and Andreas,

Thank you for your reply. Since there is still a faulty machine, we have 
analyzed it again and found it is indeed a very special case:


crash> struct ext4_group_info ffff8813bb5f72d0
struct ext4_group_info {
   bb_state = 0,
   bb_free_root = {
     rb_node = 0x0
   },
   bb_first_free = 1681,
   bb_free = 0,
   bb_fragments = 0,
   bb_largest_free_order = -1,
   bb_prealloc_list = {
     next = 0xffff880268291d78,
     prev = 0xffff880268291d78     ---> *** The list is empty
   },
   alloc_sem = {
     count = {
       counter = 0
     },
     wait_list = {
       next = 0xffff8813bb5f7308,
       prev = 0xffff8813bb5f7308
     },
     wait_lock = {
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
     },
     osq = {
       tail = {
         counter = 0
       }
     },
     owner = 0x0
   },
   bb_counters = 0xffff8813bb5f7328
}
crash>


crash> list 0xffff880268291d78  -l ext4_prealloc_space.pa_group_list -s 
ext4_prealloc_space.pa_count
ffff880268291d78
   pa_count = {
     counter = 1      ---> ****pa->pa_count
   }
ffff8813bb5f72f0
   pa_count = {
     counter = -30701
   }


crash> struct -xo  ext4_prealloc_space
struct ext4_prealloc_space {
    [0x0] struct list_head pa_inode_list;
   [0x10] struct list_head pa_group_list;
          union {
              struct list_head pa_tmp_list;
              struct callback_head pa_rcu;
   [0x20] } u;
   [0x30] spinlock_t pa_lock;
   [0x34] atomic_t pa_count;
   [0x38] unsigned int pa_deleted;
   [0x40] ext4_fsblk_t pa_pstart;
   [0x48] ext4_lblk_t pa_lstart;
   [0x4c] ext4_grpblk_t pa_len;
   [0x50] ext4_grpblk_t pa_free;
   [0x54] unsigned short pa_type;
   [0x58] spinlock_t *pa_obj_lock;
   [0x60] struct inode *pa_inode;
}
SIZE: 0x68
	

crash> rd 0xffff880268291d68 20
ffff880268291d68:  ffff881822f8a4c8 ffff881822f8a4c8   ..."......."....
ffff880268291d78:  ffff8813bb5f72f0 ffff8813bb5f72f0   .r_......r_.....
ffff880268291d88:  0000000000001000 ffff880db2371000   ..........7.....
ffff880268291d98:  0000000100000001 0000000000000000   ................
ffff880268291da8:  0000000000029c39 0000001700000c41   9.......A.......
ffff880268291db8:  ffff000000000016 ffff881822f8a4d8   ..........."....
ffff880268291dc8:  ffff881822f8a268 ffff880268291af8   h.."......)h....
ffff880268291dd8:  ffff880268291dd0 ffffea00069a07c0   ..)h............
ffff880268291de8:  00000000004d5bb7 0000000000001000   .[M.............
ffff880268291df8:  ffff8801a681f000 0000000000000000   ................



Before "goto repeat", it is necessary to check whether 
grp->bb_prealloc_list is empty.
This patch may fix it.
Please kindly give us your comments and suggestions.
Thanks.


diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 99bf091..8082e2d 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -4290,7 +4290,7 @@ static void ext4_mb_new_preallocation(struct 
ext4_allocation_context *ac)
         free_total += free;

         /* if we still need more blocks and some PAs were used, try 
again */
-       if (free_total < needed && busy) {
+       if (free_total < needed && busy && 
!list_empty(&grp->bb_prealloc_list)) {
                 ext4_unlock_group(sb, group);
                 cond_resched();
                 busy = 0;



--
Best wishes,
Wen




