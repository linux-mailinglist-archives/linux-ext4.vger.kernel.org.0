Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445A41BEF5D
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Apr 2020 06:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgD3ElY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Apr 2020 00:41:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:52118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD3ElX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 30 Apr 2020 00:41:23 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03U4VhlO187289;
        Thu, 30 Apr 2020 00:41:16 -0400
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30q80qdr9b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 00:41:16 -0400
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.27/8.16.0.27) with SMTP id 03U4bKXw001291;
        Thu, 30 Apr 2020 04:41:14 GMT
Received: from b06cxnps4075.portsmouth.uk.ibm.com (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
        by ppma03fra.de.ibm.com with ESMTP id 30mcu5abwc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Apr 2020 04:41:14 +0000
Received: from d06av24.portsmouth.uk.ibm.com (d06av24.portsmouth.uk.ibm.com [9.149.105.60])
        by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 03U4fCFF63111332
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 Apr 2020 04:41:12 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5FA5F42047;
        Thu, 30 Apr 2020 04:41:12 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id DF25E42045;
        Thu, 30 Apr 2020 04:41:10 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.199.35.53])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Thu, 30 Apr 2020 04:41:10 +0000 (GMT)
To:     "Paul E. McKenney" <paulmck@kernel.org>, rcu@vger.kernel.org
From:   Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Discussion about rcu_barrier() in ext4
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>
Date:   Thu, 30 Apr 2020 10:11:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <20200430044110.DF25E42045@d06av24.portsmouth.uk.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-04-30_01:2020-04-30,2020-04-30 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 priorityscore=1501 mlxscore=0 clxscore=1011 impostorscore=0 phishscore=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=999
 suspectscore=2 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004300030
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello Paul,

I added a rcu_barrier() in one of the ext4 path, to ensure
that once rcu_barrier is completed, all the call_rcu() should have
been completed too. I think I am seeing a below deadlock while running
one of the ext4 fstest.

Could you please help me understand what exactly is causing the deadlock
here? I was thinking is it because of khungtaskd inside rcu_read_lock()
which would have disabled the preemption and that's why the 
rcu_barrier() path is stuck? But why can't khungtaskd proceed?

Also about when is it safe or not safe to call rcu_barrier()?

Appreciate your inputs on this one!!

-ritesh

<Call Stack>
=============

[ 1476.770791]       Not tainted 5.6.0-rc4+ #47
[ 1476.771723] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" 
disables this message.
[ 1476.773814] kworker/u32:3   D12136  9612      2 0x80004000
[ 1476.775299] Workqueue: ext4-rsv-conversion ext4_end_io_rsv_work
[ 1476.776904] Call Trace:
[ 1476.777640]  ? __schedule+0x35b/0x8b0
[ 1476.778687]  ? rwsem_down_write_slowpath+0x405/0x650
[ 1476.780010]  schedule+0x55/0xd0
[ 1476.780763]  rwsem_down_write_slowpath+0x40a/0x650
[ 1476.781867]  ? down_write+0x10c/0x110
[ 1476.782687]  down_write+0x10c/0x110
[ 1476.783471]  ext4_map_blocks+0xd4/0x640
[ 1476.784367]  ext4_convert_unwritten_extents+0x10f/0x210
[ 1476.785493]  ext4_convert_unwritten_io_end_vec+0x5f/0xd0
[ 1476.786710]  ext4_end_io_rsv_work+0xe6/0x190
[ 1476.787659]  process_one_work+0x24e/0x5a0
[ 1476.788568]  worker_thread+0x3c/0x390
[ 1476.789396]  ? process_one_work+0x5a0/0x5a0
[ 1476.790312]  kthread+0x120/0x140
[ 1476.790958]  ? kthread_park+0x80/0x80
[ 1476.791750]  ret_from_fork+0x3a/0x50
[ 1476.792578]
[ 1476.792578] Showing all locks held in the system:
[ 1476.793885] 1 lock held by khungtaskd/92:
[ 1476.794744]  #0: ffffffff82a7af20 (rcu_read_lock){....}, at: 
debug_show_all_locks+0x15/0x17e
[ 1476.796485] 6 locks held by kworker/u32:2/194:
[ 1476.797424]  #0: ffff888a0521d548 ((wq_completion)writeback){+.+.}, 
at: process_one_work+0x1ce/0x5a0
[ 1476.799293]  #1: ffffc9000185be68 
((work_completion)(&(&wb->dwork)->work)){+.+.}, at: 
process_one_work+0x1ce/0x5a0
[ 1476.801386]  #2: ffff8889c6f31af0 (&sbi->s_writepages_rwsem){++++}, 
at: do_writepages+0x41/0xe0
[ 1476.803178]  #3: ffff8889c46cd838 (jbd2_handle){++++}, at: 
start_this_handle+0x1ac/0x680
[ 1476.804853]  #4: ffff8889f2101198 (&ei->i_data_sem){++++}, at: 
ext4_map_blocks+0xd4/0x640
[ 1476.806535]  #5: ffffffff82a7ea78 (rcu_state.barrier_mutex){+.+.}, 
at: rcu_barrier+0x59/0x760
[ 1476.808296] 1 lock held by in:imklog/650:
[ 1476.809162] 4 locks held by kworker/u32:3/9612:
[ 1476.810159]  #0: ffff88899e7f6548 
((wq_completion)ext4-rsv-conversion#2){+.+.}, at: 
process_one_work+0x1ce/0x5a0
[ 1476.812227]  #1: ffffc9000dd4be68 
((work_completion)(&ei->i_rsv_conversion_work)){+.+.}, at: 
process_one_work+0x1ce/0x5a0
[ 1476.814432]  #2: ffff8889c46cd838 (jbd2_handle){++++}, at: 
start_this_handle+0x1ac/0x680
[ 1476.816085]  #3: ffff8889f2101198 (&ei->i_data_sem){++++}, at: 
ext4_map_blocks+0xd4/0x640
[ 1476.817799] 3 locks held by dd/17439:
[ 1476.818590]  #0: ffff8889be355490 (sb_writers#3){.+.+}, at: 
vfs_write+0x177/0x1d0
[ 1476.820132]  #1: ffff8889f21013d0 
(&sb->s_type->i_mutex_key#10){+.+.}, at: ext4_buffered_write_iter+0x33/0x120
[ 1476.822183]  #2: ffff8889be3550e8 (&type->s_umount_key#35){++++}, at: 
try_to_writeback_inodes_sb+0x1b/0x50
[ 1476.824142] 2 locks held by debugfs/17530:
[ 1476.824962]  #0: ffff8889e3f108a0 (&tty->ldisc_sem){++++}, at: 
tty_ldisc_ref_wait+0x24/0x50
[ 1476.826676]  #1: ffffc900004672f0 (&ldata->atomic_read_lock){+.+.}, 
at: n_tty_read+0xda/0x9d0
[ 1476.828455]
[ 1476.828773] =============================================
[ 1476.828773]


Below is the patch which I added which started causing this.
===========================================================

---
Subject: [PATCH 1/1] ext4: Introduce percpu seq counter for freeing 
blocks(PA) to avoid ENOSPC err

There could be a race in function ext4_mb_discard_group_preallocations()
where the 1st thread may iterate through group's bb_prealloc_list and
remove all the PAs and add to function's local list head.
Now if the 2nd thread comes in to discard the group preallocations,
it will see that the group->bb_prealloc_list is empty and will return 0.

Consider for a case where we have less number of groups (for e.g. just 
group 0),
this may even return an -ENOSPC error from ext4_mb_new_blocks()
(where we call for ext4_mb_discard_group_preallocations()).
But that is wrong, since 2nd thread should have waited for 1st thread to 
release
all the PAs and should have retried for allocation. Since 1st thread
was anyway going to discard the PAs.

The algorithm using this percpu seq counter goes below:
1. We sample the percpu discard_pa_seq counter before trying for block
    allocation in ext4_mb_new_blocks().
2. We increment this percpu discard_pa_seq counter when we succeed in
    allocating blocks and hence while adding the remaining blocks in group's
    bb_prealloc_list (ext4_mb_new_inode_pa/ext4_mb_new_group_pa).
3. We also increment this percpu seq counter when we successfully identify
    that the bb_prealloc_list is not empty and hence proceed for discarding
    of those PAs inside ext4_mb_discard_group_preallocations().

Now to make sure that the regular fast path of block allocation is not
affected, as a small optimization we only sample the percpu seq counter
on that cpu. Only when the block allocation fails and when freed blocks
found were 0, that is when we sample percpu seq counter for all cpus using
below function ext4_get_discard_pa_seq_sum(). This happens after making
sure that all the PAs on grp->bb_prealloc_list got freed.

Note: The other method was also to check for grp->bb_free next time
if we couldn't discard anything. But one suspicion with that was that if
grp->bb_free is non-zero for some reason (not sure), then we may result
in that loop indefinitely but still won't be able to satisfy any
request. Second, to check for grp->bb_free all threads were to wait on
grp's spin_lock which might result in increased cpu usage.
So it seems this could be a better & faster approach compared to that.

Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
---
  fs/ext4/mballoc.c | 56 ++++++++++++++++++++++++++++++++++++++++++++---
  1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index fe6528716f14..47ff3704d2fc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -357,6 +357,34 @@ static void ext4_mb_generate_from_pa(struct 
super_block *sb, void *bitmap,
  static void ext4_mb_generate_from_freelist(struct super_block *sb, 
void *bitmap,
  						ext4_group_t group);

+/*
+ * The algorithm using this percpu seq counter goes below:
+ * 1. We sample the percpu discard_pa_seq counter before trying for block
+ *    allocation in ext4_mb_new_blocks().
+ * 2. We increment this percpu discard_pa_seq counter when we succeed in
+ *    allocating blocks and hence while adding the remaining blocks in 
group's
+ *    bb_prealloc_list (ext4_mb_new_inode_pa/ext4_mb_new_group_pa).
+ * 3. We also increment this percpu seq counter when we successfully 
identify
+ *    that the bb_prealloc_list is not empty and hence proceed for 
discarding
+ *    of those PAs inside ext4_mb_discard_group_preallocations().
+ *
+ * Now to make sure that the regular fast path of block allocation is not
+ * affected, as a small optimization we only sample the percpu seq counter
+ * on that cpu. Only when the block allocation fails and when freed blocks
+ * found were 0, that is when we sample percpu seq counter for all cpus 
using
+ * below function ext4_get_discard_pa_seq_sum(). This happens after making
+ * sure that all the PAs on grp->bb_prealloc_list got freed.
+ */
+DEFINE_PER_CPU(u64, discard_pa_seq);
+static inline u64 ext4_get_discard_pa_seq_sum(void)
+{
+	int __cpu;
+	u64 __seq = 0;
+	for_each_possible_cpu(__cpu)
+		__seq += per_cpu(discard_pa_seq, __cpu);
+	return __seq;
+}
+
  static inline void *mb_correct_addr_and_bit(int *bit, void *addr)
  {
  #if BITS_PER_LONG == 64
@@ -3721,6 +3749,7 @@ ext4_mb_new_inode_pa(struct 
ext4_allocation_context *ac)
  	pa->pa_inode = ac->ac_inode;

  	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
+	this_cpu_inc(discard_pa_seq);
  	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
  	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);

@@ -3782,6 +3811,7 @@ ext4_mb_new_group_pa(struct 
ext4_allocation_context *ac)
  	pa->pa_inode = NULL;

  	ext4_lock_group(sb, ac->ac_b_ex.fe_group);
+	this_cpu_inc(discard_pa_seq);
  	list_add(&pa->pa_group_list, &grp->bb_prealloc_list);
  	ext4_unlock_group(sb, ac->ac_b_ex.fe_group);

@@ -3934,6 +3964,7 @@ ext4_mb_discard_group_preallocations(struct 
super_block *sb,
  	INIT_LIST_HEAD(&list);
  repeat:
  	ext4_lock_group(sb, group);
+	this_cpu_inc(discard_pa_seq);
  	list_for_each_entry_safe(pa, tmp,
  				&grp->bb_prealloc_list, pa_group_list) {
  		spin_lock(&pa->pa_lock);
@@ -4481,13 +4512,30 @@ static int ext4_mb_discard_preallocations(struct 
super_block *sb, int needed)
  }

  static bool ext4_mb_discard_preallocations_should_retry(struct 
super_block *sb,
-			struct ext4_allocation_context *ac)
+			struct ext4_allocation_context *ac, u64 seq)
  {
  	int freed;
+	u64 seq_retry;
+
  	freed = ext4_mb_discard_preallocations(sb, ac->ac_o_ex.fe_len);
  	if (freed)
-		return true;
+		goto out_retry;
+	/*
+	 * Unless it is ensured that PAs are actually freed, we may hit
+	 * a ENOSPC error since the next time seq may match while the PA blocks
+	 * are still getting freed in ext4_mb_release_inode/group_pa().
+	 * So, rcu_barrier() here is to make sure that any call_rcu queued in
+	 * ext4_mb_discard_group_preallocations() is completed before we
+	 * proceed further to retry for block allocation.
+	 */
+	rcu_barrier();
+	seq_retry = ext4_get_discard_pa_seq_sum();
+	if (seq_retry != seq)
+		goto out_retry;
+
  	return false;
+out_retry:
+	return true;
  }

  /*
@@ -4504,6 +4552,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
  	ext4_fsblk_t block = 0;
  	unsigned int inquota = 0;
  	unsigned int reserv_clstrs = 0;
+	u64 seq;

  	might_sleep();
  	sb = ar->inode->i_sb;
@@ -4565,6 +4614,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
  	}

  	ac->ac_op = EXT4_MB_HISTORY_PREALLOC;
+	seq = *this_cpu_ptr(&discard_pa_seq);
  	if (!ext4_mb_use_preallocated(ac)) {
  		ac->ac_op = EXT4_MB_HISTORY_ALLOC;
  		ext4_mb_normalize_request(ac, ar);
@@ -4596,7 +4646,7 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
  			ar->len = ac->ac_b_ex.fe_len;
  		}
  	} else {
-		if (ext4_mb_discard_preallocations_should_retry(sb, ac))
+		if (ext4_mb_discard_preallocations_should_retry(sb, ac, seq))
  			goto repeat;
  		*errp = -ENOSPC;
  	}
-- 
2.21.0

