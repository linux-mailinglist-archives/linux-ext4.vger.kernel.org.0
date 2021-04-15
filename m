Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA63B3603B6
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Apr 2021 09:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhDOHyF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Apr 2021 03:54:05 -0400
Received: from out30-45.freemail.mail.aliyun.com ([115.124.30.45]:54503 "EHLO
        out30-45.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230511AbhDOHyD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 15 Apr 2021 03:54:03 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=wenyang@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0UVcdvdo_1618473217;
Received: from IT-C02W23QPG8WN.local(mailfrom:wenyang@linux.alibaba.com fp:SMTPD_---0UVcdvdo_1618473217)
          by smtp.aliyun-inc.com(127.0.0.1);
          Thu, 15 Apr 2021 15:53:39 +0800
Subject: Re: [PATCH] ext4: add a configurable parameter to prevent endless
 loop in ext4_mb_discard_group_p
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     riteshh <riteshh@linux.ibm.com>, adilger@dilger.ca,
        linux-ext4@vger.kernel.org, jack@suse.cz,
        linux-kernel@vger.kernel.org, baoyou.xie@alibaba-inc.com
References: <f16d7afa-3799-f523-3c19-9ceb9427ff6e@linux.alibaba.com>
 <20210409054733.avv3ofqpka4m6xe5@riteshh-domain>
 <0e0c2283-5eb9-e121-35b2-61dbccc8203b@linux.alibaba.com>
 <YHJ6H8hClqlrAouQ@mit.edu>
From:   Wen Yang <wenyang@linux.alibaba.com>
Message-ID: <9e8f39ab-58a9-fc83-1fa9-8dd3f148f658@linux.alibaba.com>
Date:   Thu, 15 Apr 2021 15:53:37 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:68.0)
 Gecko/20100101 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <YHJ6H8hClqlrAouQ@mit.edu>
Content-Type: text/plain; charset=gbk; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



ÔÚ 2021/4/11 ÏÂÎç12:25, Theodore Ts'o Ð´µÀ:
> On Sun, Apr 11, 2021 at 03:45:01AM +0800, Wen Yang wrote:
>> At this time, some logs are lost. It is suspected that the hard disk itself
>> is faulty.
> 
> If you have a kernel crash dump, that means you can extract out the
> dmesg buffer, correct?  Is there any I/O error messages in the kernel
> log?
> 
> What is the basis of the suspicion that the hard drive is faulty?
> Kernel dmesg output?  Error reporting from smartctl?
> 

Hello, we are using a Bare-metal Cloud server 
(https://www.semanticscholar.org/paper/High-density-Multi-tenant-Bare-metal-Cloud-Zhang-Zheng/ab1b5f0743816c8cb7188019d844ff3f7d565d9f/figure/3), 
so there is no error log in dmesg or smartctl, and we have to check it 
in Bm-hypervisor. We finally found that the io processing process on 
Bm-hypervisor is indeed abnormal.


>> There are many hard disks on our server. Maybe we should not occupy 100% CPU
>> for a long time just because one hard disk fails.
> 
> It depends on the nature of the hard drive failure.  How is it
> failing?
> 
> One thing which we do need to be careful about is when focusing on how
> to prevent a failure caused by some particular (potentially extreme)
> scenarios, that we don't cause problems on more common scenarios (for
> example a heavily loaded server, and/or a case where the file system
> is almost full where we have multiple files "fighting" over a small
> number of free blocks).
> 
> In general, my attitude is that the best way to protect against hard
> drive failures is to have processes which are monitoring the health of
> the system, and if there is evidence of a failed drive, that we
> immediately kill all jobs which are relying on that drive (which we
> call "draining" a particular drive), and/or if a sufficiently large
> percentage of the drives have failed, or the machine can no longer do
> its job, to automatically move all of those jobs to other servers
> (e.g., "drain" the server), and then send the machine to some kind of
> data center repair service, where the failed hard drives can be
> replaced.
> 
> I'm skeptical of attempts to try to make the file system to somehow
> continue to be able to "work" in the face of hard drive failures,
> since failures can be highly atypical, and what might work well in one
> failure scenario might be catastrophic in another.  It's especially
> problematic if the HDD is not explcitly signalling an error condition,
> but rather being slow (because it's doing a huge number of retries),
> or the HDD is returning data which is simply different from what was
> previously written.  The best we can do in that case is to detect that
> something is wrong (this is where metadata checksums would be very
> helpful), and then either remount the file system r/o, or panic the
> machine, and/or signal to userspace that some particular file system
> should be drained.
> 

Thanks you.
We generally separate the physical disks. One system disk and several 
business disks. The linux kernel runs on this system disk, and various 
services run on several business disks. In this way, even if a business 
disk has a problem , it will not affect the entire system.


But the current implementation of mblloc may cause 100% of the cpu to be 
occupied for a long time, could we optimize it slightly, as follows:

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index a02fadf..c73f212 100644
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
@@ -4217,9 +4219,9 @@ static void ext4_mb_new_preallocation(struct 
ext4_allocation_context *ac)
  	struct ext4_prealloc_space *pa, *tmp;
  	struct list_head list;
  	struct ext4_buddy e4b;
+	int free_total = 0;
+	int busy, free;
  	int err;
-	int busy = 0;
-	int free, free_total = 0;

  	mb_debug(sb, "discard preallocation for group %u\n", group);
  	if (list_empty(&grp->bb_prealloc_list))
@@ -4247,6 +4249,7 @@ static void ext4_mb_new_preallocation(struct 
ext4_allocation_context *ac)

  	INIT_LIST_HEAD(&list);
  repeat:
+	busy = 0;
  	free = 0;
  	ext4_lock_group(sb, group);
  	list_for_each_entry_safe(pa, tmp,
@@ -4255,6 +4258,8 @@ static void ext4_mb_new_preallocation(struct 
ext4_allocation_context *ac)
  		if (atomic_read(&pa->pa_count)) {
  			spin_unlock(&pa->pa_lock);
  			busy = 1;
+			mb_debug(sb, "used pa while discarding for group %u\n", group);
+			ext4_mb_show_pa(sb);
  			continue;
  		}
  		if (pa->pa_deleted) {
@@ -4299,8 +4304,7 @@ static void ext4_mb_new_preallocation(struct 
ext4_allocation_context *ac)
  	/* if we still need more blocks and some PAs were used, try again */
  	if (free_total < needed && busy) {
  		ext4_unlock_group(sb, group);
-		cond_resched();
-		busy = 0;
+		schedule_timeout_uninterruptible(HZ/100);
  		goto repeat;
  	}
  	ext4_unlock_group(sb, group);



--
Best wishes£¬
Wen


