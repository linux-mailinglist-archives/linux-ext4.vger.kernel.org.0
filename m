Return-Path: <linux-ext4+bounces-3779-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EBA0956C48
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 15:38:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6B78B20D5D
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 13:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF4C216C6A0;
	Mon, 19 Aug 2024 13:38:21 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE4816C42C;
	Mon, 19 Aug 2024 13:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724074701; cv=none; b=pRP+BUfp0IWZ61hJ2quYU6gg18USTN/+u6Kd1CWfkutDaCLIy41yBW51TmmJ6qhtoBkZCViMrJ24295pjDFor4IIT0mKyVfTuU+/Eo65QUkkQ/4bhUWysFrOeo8kenv9QA0VDW6U+TCkYCGPUj3VFDz1dZfE2UCXz6IJTg9Gh8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724074701; c=relaxed/simple;
	bh=qIYbP9/x6N4LqlgHF2vHBae6xR7FPZiqGPgPnZCjA10=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=JiWzvyvgBUPJBZO+aKbe7b4PEjL9SAqTtB5/Y8bgjrC4LD02zxRXy/4d3HWZNJ6Zb4KgQW2AKEt6Yn33ssh7pKz25V6EP+HbaqIT8pNTaEd/im3kI6qewZy49wMjBpzCwT3b1qzG8cUAyJ0DC/w+n7o2Vi6Zydcqb/aUv/CnkRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WnYZF5MZCz4f3nbh;
	Mon, 19 Aug 2024 21:37:57 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id B4EDB1A058E;
	Mon, 19 Aug 2024 21:38:12 +0800 (CST)
Received: from [10.174.176.73] (unknown [10.174.176.73])
	by APP4 (Coremail) with SMTP id gCh0CgCXv4W+SsNmuz+ICA--.4058S3;
	Mon, 19 Aug 2024 21:38:08 +0800 (CST)
Subject: Re: jbd2: io throttle for metadata buffers
To: Zhang Yi <yi.zhang@huaweicloud.com>, Haifeng Xu <haifeng.xu@shopee.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, hanjinke.666@bytedance.com,
 Tejun Heo <tj@kernel.org>, linux-block <linux-block@vger.kernel.org>,
 "yukuai (C)" <yukuai3@huawei.com>
References: <9914a4b4-eb4d-44de-a48c-8ae08eedebe8@shopee.com>
 <b85e49c6-588e-63c7-b153-a273183f810e@huaweicloud.com>
From: Yu Kuai <yukuai1@huaweicloud.com>
Message-ID: <97fc38e6-a226-5e22-efc2-4405beb6d75b@huaweicloud.com>
Date: Mon, 19 Aug 2024 21:38:06 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <b85e49c6-588e-63c7-b153-a273183f810e@huaweicloud.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCXv4W+SsNmuz+ICA--.4058S3
X-Coremail-Antispam: 1UD129KBjvJXoWxtFW7AF4kZr4ktFy7WF4xtFb_yoWDJFW8pr
	WxJFW7Wr4DAF1UWryfurW5Za40yw48Zas8Jw1rGr13J342gw1Yvr1DAry8Wr9FvFsxGF47
	tr98trZ8KF1UArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9Ib4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4IIrI8v6xkF7I0E8cxan2IY04v7Mxk0xIA0c2IE
	e2xFo4CEbIxvr21lc7CjxVAaw2AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l4I8I3I0E4I
	kC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWU
	WwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr
	0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWU
	JVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJb
	IYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: 51xn3trlr6x35dzhxuhorxvhhfrp/

+CC Tejun
+CC block

在 2024/08/19 20:49, Zhang Yi 写道:
> Hello, Haifeng.
> 
> On 2024/8/19 18:19, Haifeng Xu wrote:
>> Hi, matsers!
>>
>>
>> We encountered high load issuses in our production environment recently. And the kernel version is stable-5.15.39
>> the filesystem is ext4(ordered).
>>
>>
>> After digging into it, we found the problem is due to io.max
>>
>>
>> thread 1:
>>
>> PID: 189529  TASK: ffff92ab51e5c080  CPU: 34  COMMAND: "mc"
>>   #0 [ffffa638db807800] __schedule at ffffffff83b19898
>>   #1 [ffffa638db807888] schedule at ffffffff83b19e9e
>>   #2 [ffffa638db8078a8] io_schedule at ffffffff83b1a316
>>   #3 [ffffa638db8078c0] bit_wait_io at ffffffff83b1a751
>>   #4 [ffffa638db8078d8] __wait_on_bit at ffffffff83b1a373
>>   #5 [ffffa638db807918] out_of_line_wait_on_bit at ffffffff83b1a46d
>>   #6 [ffffa638db807970] __wait_on_buffer at ffffffff831b9c64
>>   #7 [ffffa638db807988] jbd2_log_do_checkpoint at ffffffff832b556e
>>   #8 [ffffa638db8079e8] __jbd2_log_wait_for_space at ffffffff832b55dc
>>   #9 [ffffa638db807a30] add_transaction_credits at ffffffff832af369
>> #10 [ffffa638db807a98] start_this_handle at ffffffff832af50f
>> #11 [ffffa638db807b20] jbd2__journal_start at ffffffff832afe1f
>> #12 [ffffa638db807b60] __ext4_journal_start_sb at ffffffff83241af3
>> #13 [ffffa638db807ba8] __ext4_new_inode at ffffffff83253be6
>> #14 [ffffa638db807c80] ext4_mkdir at ffffffff8327ec9e
>> #15 [ffffa638db807d10] vfs_mkdir at ffffffff83182a92
>> #16 [ffffa638db807d50] ovl_mkdir_real at ffffffffc0965c9f [overlay]
>> #17 [ffffa638db807d80] ovl_create_real at ffffffffc0965e8b [overlay]
>> #18 [ffffa638db807db8] ovl_create_or_link at ffffffffc09677cc [overlay]
>> #19 [ffffa638db807e10] ovl_create_object at ffffffffc0967a48 [overlay]
>> #20 [ffffa638db807e60] ovl_mkdir at ffffffffc0967ad3 [overlay]
>> #21 [ffffa638db807e70] vfs_mkdir at ffffffff83182a92
>> #22 [ffffa638db807eb0] do_mkdirat at ffffffff83184305
>> #23 [ffffa638db807f08] __x64_sys_mkdirat at ffffffff831843df
>> #24 [ffffa638db807f28] do_syscall_64 at ffffffff83b0bf1c
>> #25 [ffffa638db807f50] entry_SYSCALL_64_after_hwframe at ffffffff83c0007c
>>
>> other threads:
>>
>>
>> PID: 21125  TASK: ffff929f5b9a0000  CPU: 44  COMMAND: "task_server"
>>   #0 [ffffa638aff9b900] __schedule at ffffffff83b19898
>>   #1 [ffffa638aff9b988] schedule at ffffffff83b19e9e
>>   #2 [ffffa638aff9b9a8] schedule_preempt_disabled at ffffffff83b1a24e
>>   #3 [ffffa638aff9b9b8] __mutex_lock at ffffffff83b1af28
>>   #4 [ffffa638aff9ba38] __mutex_lock_slowpath at ffffffff83b1b1a3
>>   #5 [ffffa638aff9ba48] mutex_lock at ffffffff83b1b1e2
>>   #6 [ffffa638aff9ba60] mutex_lock_io at ffffffff83b1b210
>>   #7 [ffffa638aff9ba80] __jbd2_log_wait_for_space at ffffffff832b563b
>>   #8 [ffffa638aff9bac8] add_transaction_credits at ffffffff832af369
>>   #9 [ffffa638aff9bb30] start_this_handle at ffffffff832af50f
>> #10 [ffffa638aff9bbb8] jbd2__journal_start at ffffffff832afe1f
>> #11 [ffffa638aff9bbf8] __ext4_journal_start_sb at ffffffff83241af3
>> #12 [ffffa638aff9bc40] ext4_dirty_inode at ffffffff83266d0a
>> #13 [ffffa638aff9bc60] __mark_inode_dirty at ffffffff831ab423
>> #14 [ffffa638aff9bca0] generic_update_time at ffffffff8319169d
>> #15 [ffffa638aff9bcb0] inode_update_time at ffffffff831916e5
>> #16 [ffffa638aff9bcc0] file_update_time at ffffffff83191b01
>> #17 [ffffa638aff9bd08] file_modified at ffffffff83191d47
>> #18 [ffffa638aff9bd20] ext4_write_checks at ffffffff8324e6e4
>> #19 [ffffa638aff9bd40] ext4_buffered_write_iter at ffffffff8324edfb
>> #20 [ffffa638aff9bd78] ext4_file_write_iter at ffffffff8324f553
>> #21 [ffffa638aff9bdf8] ext4_file_write_iter at ffffffff8324f505
>> #22 [ffffa638aff9be00] new_sync_write at ffffffff8316dfca
>> #23 [ffffa638aff9be90] vfs_write at ffffffff8316e975
>> #24 [ffffa638aff9bec8] ksys_write at ffffffff83170a97
>> #25 [ffffa638aff9bf08] __x64_sys_write at ffffffff83170b2a
>> #26 [ffffa638aff9bf18] do_syscall_64 at ffffffff83b0bf1c
>> #27 [ffffa638aff9bf38] asm_common_interrupt at ffffffff83c00cc8
>> #28 [ffffa638aff9bf50] entry_SYSCALL_64_after_hwframe at ffffffff83c0007c
>>
>>
>> The cgroup of thread1 has set io.max, so the j_checkpoint_mutex can't be released and many threads must wait for it.
>> I have some questions about the throttle for the metadata buffers.
>>
>> 1) writeback
>>
>> jbd2 converts the buffer head from jbddirty to buffer_dirty and trigger the write back in __jbd2_journal_temp_unlink_buffer().
>> By default, the blkcg in bdi_writeback attached to block device inode is blkcg_root which has no io throttle rules. But there may be other
>> threads which invoke sync_filesystem, such as umount overlayfs. This operation will write out all dirty data associated with the block
>> device. In this case, the bdi_writeback attached to block device inode may changed due to Boyer-Moore majority vote algorithm.
>> And the blkcg in bdi_writeback attached to block device inode is the group where the thread allocate the buffer head and dev page.
>>
>> So the writeback process of metadata buffers can also be throttled, right?
>>
>>
>> 2) checkpoint
>>
>> If the free log space is not suffcient, we will do checkpoint to update log tail. During the process, if the buffer head hasn't been
>> written out by wirteback. we will lock the buffer head and submit bio in current context.
>>
>> So the throttle rules may be different from writeback?
>>
>>
>> 3）j_checkpoint_mutex
>> If we can't make any progress in checkpoint due to io throttle, the j_checkpoint_mutex can'be release and block many others threads.
>>
>> So can we cancel the throttle rules for metadata buffers and keep it in blkcg_root?
>>
> 
> It seems that iocost have already act as blkcg_root if bios have
> REQ_META set(ext4's metadata bh should've set this flag), but
> blk-thottle doesn't, Jinke had submitted a patch to improve this
> case, maybe it could help, please take a look at this patch. Or
> maybe we could add some similar logic in blk-throttle like iocost
> does for REQ_META.
> 
> https://lore.kernel.org/linux-block/20230228085935.71465-1-hanjinke.666@bytedance.com/

Hi, Tejun

This patch can solve the priority inversion problem, however, I just
come up with a new idea:

For meta IO, just issue the IO directly like iocost, and then try to
pay debt. Fortunately, we already have 'carryover_bytes/ios' that
already do this for the case that limit changes, and it'll be easy
to do this for meta IO, just update 'carryover_bytes/ios' and dispatch
directly.

BTW, this is another reason that we should add a new module in iocost to
replace blk-throtl.

Thanks,
Kuai

diff --git a/block/blk-throttle.c b/block/blk-throttle.c
index dc6140fa3de0..38ffe0f95682 100644
--- a/block/blk-throttle.c
+++ b/block/blk-throttle.c
@@ -1595,6 +1595,32 @@ void blk_throtl_cancel_bios(struct gendisk *disk)
         spin_unlock_irq(&q->queue_lock);
  }

+static bool tg_within_limit(struct throtl_grp *tg, struct bio *bio, 
bool rw)
+{
+       struct throtl_service_queue *sq = &tg->service_queue;
+
+       /* throtl is FIFO - if bios are already queued, should queue */
+       if (sq->nr_queued[rw])
+               return false;
+
+       /* within limits, let's charge and dispatch directly */
+       if (!tg_may_dispatch(tg, bio, NULL))
+               return false;
+
+       return true;
+}
+
+static void throtl_dispatch_bio_in_debt(struct throtl_grp *tg, struct 
bio *bio,
+                                       bool rw)
+{
+       unsigned int bio_size = throtl_bio_data_size(bio);
+
+       if (!bio_flagged(bio, BIO_BPS_THROTTLED))
+               tg->carryover_bytes[rw] -= bio_size;
+
+       tg->carryover_ios[rw]--;
+}
+
  bool __blk_throtl_bio(struct bio *bio)
  {
         struct request_queue *q = bdev_get_queue(bio->bi_bdev);
@@ -1611,34 +1637,28 @@ bool __blk_throtl_bio(struct bio *bio)
         sq = &tg->service_queue;

         while (true) {
-               if (tg->last_low_overflow_time[rw] == 0)
-                       tg->last_low_overflow_time[rw] = jiffies;
-               /* throtl is FIFO - if bios are already queued, should 
queue */
-               if (sq->nr_queued[rw])
-                       break;
-
-               /* if above limits, break to queue */
-               if (!tg_may_dispatch(tg, bio, NULL)) {
-                       tg->last_low_overflow_time[rw] = jiffies;
+               if (tg_within_limit(tg, bio, rw)) {
+                       /* within limits, let's charge and dispatch 
directly */
+                       throtl_charge_bio(tg, bio);
+
+                       /*
+                        * We need to trim slice even when bios are not 
being queued
+                        * otherwise it might happen that a bio is not 
queued for
+                        * a long time and slice keeps on extending and 
trim is not
+                        * called for a long time. Now if limits are 
reduced suddenly
+                        * we take into account all the IO dispatched so 
far at new
+                        * low rate and * newly queued IO gets a really 
long dispatch
+                        * time.
+                        *
+                        * So keep on trimming slice even if bio is not 
queued.
+                        */
+                       throtl_trim_slice(tg, rw);
+               } else if (bio_issue_as_root_blkg(bio)) {
+                       throtl_dispatch_bio_in_debt(tg, bio, rw);
+               } else {
                         break;
                 }

-               /* within limits, let's charge and dispatch directly */
-               throtl_charge_bio(tg, bio);
-
-               /*
-                * We need to trim slice even when bios are not being queued
-                * otherwise it might happen that a bio is not queued for
-                * a long time and slice keeps on extending and trim is not
-                * called for a long time. Now if limits are reduced 
suddenly
-                * we take into account all the IO dispatched so far at new
-                * low rate and * newly queued IO gets a really long 
dispatch
-                * time.
-                *
-                * So keep on trimming slice even if bio is not queued.
-                */
-               throtl_trim_slice(tg, rw);
-
                 /*
                  * @bio passed through this layer without being throttled.
                  * Climb up the ladder.  If we're already at the top, it

> 
> Thanks,
> Yi.
> 
> .
> 


