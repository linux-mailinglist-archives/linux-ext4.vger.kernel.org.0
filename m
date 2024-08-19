Return-Path: <linux-ext4+bounces-3777-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7126956B28
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 14:49:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 580BD1F22C8B
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 12:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEE816B3AC;
	Mon, 19 Aug 2024 12:49:43 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A360171AA;
	Mon, 19 Aug 2024 12:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724071783; cv=none; b=EiHXAMy0mMvhkmAlFAe1koOFWlrawz+Lap1gfSxujdKx00e/56Ko6Sizwy0tmRKWFgPiPJPDH3J8ZqawlOkPGhJMeJKaGiVd8VKw0Mw2ogJpFZbmXRMSAQVIGmf4PTm+SKASpBHPcAMY1srhGRvEXHWe5OzRC2U8M2EXZ5QCW+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724071783; c=relaxed/simple;
	bh=UqJLdllXFrBGlpPpdZXoX0kwdgaG367zaEEUM0O4KAs=;
	h=Subject:To:References:From:Cc:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=UeYVmYZHOL9vw9yb1fRjr8q4aRH1EWF3St9LQnnx3ySZyYzwXDA9LoV0uyWdDoDRr3XA2J7N9pmDLq4HRPIpJjdKszOqQQibcsGRlFLjz2cY11w2r/Ed6nxoHF9BeQUAQv8Uk5SVguOfoR75/jow2x7BC4Uc1o1cnY5Sw2FRkFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4WnXV80Tw8z4f3jdg;
	Mon, 19 Aug 2024 20:49:20 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2272F1A0359;
	Mon, 19 Aug 2024 20:49:34 +0800 (CST)
Received: from [10.174.179.80] (unknown [10.174.179.80])
	by APP4 (Coremail) with SMTP id gCh0CgBnj4VbP8NmPRSFCA--.253S3;
	Mon, 19 Aug 2024 20:49:32 +0800 (CST)
Subject: Re: jbd2: io throttle for metadata buffers
To: Haifeng Xu <haifeng.xu@shopee.com>
References: <9914a4b4-eb4d-44de-a48c-8ae08eedebe8@shopee.com>
From: Zhang Yi <yi.zhang@huaweicloud.com>
Cc: tytso@mit.edu, jack@suse.com, linux-ext4@vger.kernel.org,
 linux-kernel@vger.kernel.org, hanjinke.666@bytedance.com, yukuai3@huawei.com
Message-ID: <b85e49c6-588e-63c7-b153-a273183f810e@huaweicloud.com>
Date: Mon, 19 Aug 2024 20:49:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9914a4b4-eb4d-44de-a48c-8ae08eedebe8@shopee.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgBnj4VbP8NmPRSFCA--.253S3
X-Coremail-Antispam: 1UD129KBjvJXoW3AFWfKw1UKw1fJFWDZw1kXwb_yoWxGF1rpr
	WxJFW7Xr4qyF1UZryfurW5Z3y8Ar4UZasxJw1UGr13Ja47Ww1YvryDCrykWr9Fvrs8Ga12
	q3s5trZ8KF47CrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Cr0_Gr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I
	0E14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40E
	x7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x
	0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzVAYIcxG8wCY1x0262kKe7AK
	xVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F4
	0E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1l
	IxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxV
	AFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j
	6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IU1veHD
	UUUUU==
X-CM-SenderInfo: d1lo6xhdqjqx5xdzvxpfor3voofrz/

Hello, Haifeng.

On 2024/8/19 18:19, Haifeng Xu wrote:
> Hi, matsers!
> 
> 
> We encountered high load issuses in our production environment recently. And the kernel version is stable-5.15.39
> the filesystem is ext4(ordered).
> 
> 
> After digging into it, we found the problem is due to io.max
> 
> 
> thread 1:                                             
> 
> PID: 189529  TASK: ffff92ab51e5c080  CPU: 34  COMMAND: "mc"
>  #0 [ffffa638db807800] __schedule at ffffffff83b19898
>  #1 [ffffa638db807888] schedule at ffffffff83b19e9e
>  #2 [ffffa638db8078a8] io_schedule at ffffffff83b1a316
>  #3 [ffffa638db8078c0] bit_wait_io at ffffffff83b1a751
>  #4 [ffffa638db8078d8] __wait_on_bit at ffffffff83b1a373
>  #5 [ffffa638db807918] out_of_line_wait_on_bit at ffffffff83b1a46d
>  #6 [ffffa638db807970] __wait_on_buffer at ffffffff831b9c64
>  #7 [ffffa638db807988] jbd2_log_do_checkpoint at ffffffff832b556e
>  #8 [ffffa638db8079e8] __jbd2_log_wait_for_space at ffffffff832b55dc
>  #9 [ffffa638db807a30] add_transaction_credits at ffffffff832af369
> #10 [ffffa638db807a98] start_this_handle at ffffffff832af50f
> #11 [ffffa638db807b20] jbd2__journal_start at ffffffff832afe1f
> #12 [ffffa638db807b60] __ext4_journal_start_sb at ffffffff83241af3
> #13 [ffffa638db807ba8] __ext4_new_inode at ffffffff83253be6
> #14 [ffffa638db807c80] ext4_mkdir at ffffffff8327ec9e
> #15 [ffffa638db807d10] vfs_mkdir at ffffffff83182a92
> #16 [ffffa638db807d50] ovl_mkdir_real at ffffffffc0965c9f [overlay]
> #17 [ffffa638db807d80] ovl_create_real at ffffffffc0965e8b [overlay]
> #18 [ffffa638db807db8] ovl_create_or_link at ffffffffc09677cc [overlay]
> #19 [ffffa638db807e10] ovl_create_object at ffffffffc0967a48 [overlay]
> #20 [ffffa638db807e60] ovl_mkdir at ffffffffc0967ad3 [overlay]
> #21 [ffffa638db807e70] vfs_mkdir at ffffffff83182a92
> #22 [ffffa638db807eb0] do_mkdirat at ffffffff83184305
> #23 [ffffa638db807f08] __x64_sys_mkdirat at ffffffff831843df
> #24 [ffffa638db807f28] do_syscall_64 at ffffffff83b0bf1c
> #25 [ffffa638db807f50] entry_SYSCALL_64_after_hwframe at ffffffff83c0007c
> 
> other threads:
> 
> 
> PID: 21125  TASK: ffff929f5b9a0000  CPU: 44  COMMAND: "task_server"
>  #0 [ffffa638aff9b900] __schedule at ffffffff83b19898
>  #1 [ffffa638aff9b988] schedule at ffffffff83b19e9e
>  #2 [ffffa638aff9b9a8] schedule_preempt_disabled at ffffffff83b1a24e
>  #3 [ffffa638aff9b9b8] __mutex_lock at ffffffff83b1af28
>  #4 [ffffa638aff9ba38] __mutex_lock_slowpath at ffffffff83b1b1a3
>  #5 [ffffa638aff9ba48] mutex_lock at ffffffff83b1b1e2
>  #6 [ffffa638aff9ba60] mutex_lock_io at ffffffff83b1b210
>  #7 [ffffa638aff9ba80] __jbd2_log_wait_for_space at ffffffff832b563b
>  #8 [ffffa638aff9bac8] add_transaction_credits at ffffffff832af369
>  #9 [ffffa638aff9bb30] start_this_handle at ffffffff832af50f
> #10 [ffffa638aff9bbb8] jbd2__journal_start at ffffffff832afe1f
> #11 [ffffa638aff9bbf8] __ext4_journal_start_sb at ffffffff83241af3
> #12 [ffffa638aff9bc40] ext4_dirty_inode at ffffffff83266d0a
> #13 [ffffa638aff9bc60] __mark_inode_dirty at ffffffff831ab423
> #14 [ffffa638aff9bca0] generic_update_time at ffffffff8319169d
> #15 [ffffa638aff9bcb0] inode_update_time at ffffffff831916e5
> #16 [ffffa638aff9bcc0] file_update_time at ffffffff83191b01
> #17 [ffffa638aff9bd08] file_modified at ffffffff83191d47
> #18 [ffffa638aff9bd20] ext4_write_checks at ffffffff8324e6e4
> #19 [ffffa638aff9bd40] ext4_buffered_write_iter at ffffffff8324edfb
> #20 [ffffa638aff9bd78] ext4_file_write_iter at ffffffff8324f553
> #21 [ffffa638aff9bdf8] ext4_file_write_iter at ffffffff8324f505
> #22 [ffffa638aff9be00] new_sync_write at ffffffff8316dfca
> #23 [ffffa638aff9be90] vfs_write at ffffffff8316e975
> #24 [ffffa638aff9bec8] ksys_write at ffffffff83170a97
> #25 [ffffa638aff9bf08] __x64_sys_write at ffffffff83170b2a
> #26 [ffffa638aff9bf18] do_syscall_64 at ffffffff83b0bf1c
> #27 [ffffa638aff9bf38] asm_common_interrupt at ffffffff83c00cc8
> #28 [ffffa638aff9bf50] entry_SYSCALL_64_after_hwframe at ffffffff83c0007c
> 
> 
> The cgroup of thread1 has set io.max, so the j_checkpoint_mutex can't be released and many threads must wait for it.
> I have some questions about the throttle for the metadata buffers.
> 
> 1) writeback 
> 
> jbd2 converts the buffer head from jbddirty to buffer_dirty and trigger the write back in __jbd2_journal_temp_unlink_buffer().
> By default, the blkcg in bdi_writeback attached to block device inode is blkcg_root which has no io throttle rules. But there may be other
> threads which invoke sync_filesystem, such as umount overlayfs. This operation will write out all dirty data associated with the block
> device. In this case, the bdi_writeback attached to block device inode may changed due to Boyer-Moore majority vote algorithm.
> And the blkcg in bdi_writeback attached to block device inode is the group where the thread allocate the buffer head and dev page.
> 
> So the writeback process of metadata buffers can also be throttled, right?
> 
> 
> 2) checkpoint
> 
> If the free log space is not suffcient, we will do checkpoint to update log tail. During the process, if the buffer head hasn't been 
> written out by wirteback. we will lock the buffer head and submit bio in current context.
> 
> So the throttle rules may be different from writeback?
> 
> 
> 3）j_checkpoint_mutex
> If we can't make any progress in checkpoint due to io throttle, the j_checkpoint_mutex can'be release and block many others threads.
> 
> So can we cancel the throttle rules for metadata buffers and keep it in blkcg_root?
> 

It seems that iocost have already act as blkcg_root if bios have
REQ_META set(ext4's metadata bh should've set this flag), but
blk-thottle doesn't, Jinke had submitted a patch to improve this
case, maybe it could help, please take a look at this patch. Or
maybe we could add some similar logic in blk-throttle like iocost
does for REQ_META.

https://lore.kernel.org/linux-block/20230228085935.71465-1-hanjinke.666@bytedance.com/

Thanks,
Yi.


