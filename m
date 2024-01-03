Return-Path: <linux-ext4+bounces-654-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF5AC822ACF
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 11:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0AF0E1F24035
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Jan 2024 10:00:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00F318653;
	Wed,  3 Jan 2024 10:00:19 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2A81864B
	for <linux-ext4@vger.kernel.org>; Wed,  3 Jan 2024 10:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav119.sakura.ne.jp (fsav119.sakura.ne.jp [27.133.134.246])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 4039xoqo003148;
	Wed, 3 Jan 2024 18:59:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav119.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp);
 Wed, 03 Jan 2024 18:59:50 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav119.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 4039xnG5003145
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Wed, 3 Jan 2024 18:59:50 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <7e6554dc-29e1-44b5-9fd0-3b3537f5b63c@I-love.SAKURA.ne.jp>
Date: Wed, 3 Jan 2024 18:59:49 +0900
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [virtualization?] KMSAN: uninit-value in virtqueue_add
 (4)
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
To: syzbot <syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com>,
        syzkaller-bugs@googlegroups.com, linux-mm <linux-mm@kvack.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
References: <000000000000fd588e060de27ef4@google.com>
 <2c1dad81-9b22-47fb-b0e9-6e4a2a2c67be@I-love.SAKURA.ne.jp>
In-Reply-To: <2c1dad81-9b22-47fb-b0e9-6e4a2a2c67be@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Well, no suggestions from MM people? This is currently second top crasher
for syzbot and the reproducer is doing nothing special.

syzbot is reporting uninit-value at kmsan_handle_dma() in vring_map_one_sg().

----------
	if (!vq->use_dma_api) {
		/*
		 * If DMA is not used, KMSAN doesn't know that the scatterlist
		 * is initialized by the hardware. Explicitly check/unpoison it
		 * depending on the direction.
		 */
		kmsan_handle_dma(sg_page(sg), sg->offset, sg->length, direction);
		*addr = (dma_addr_t)sg_phys(sg);
		return 0;
	}
----------

syzbot is reporting the page was allocated in ext4_da_write_begin().

----------
	folio = __filemap_get_folio(mapping, index, FGP_WRITEBEGIN,
			mapping_gfp_mask(mapping));
	if (IS_ERR(folio))
		return PTR_ERR(folio);

	/* In case writeback began while the folio was unlocked */
	folio_wait_stable(folio);

#ifdef CONFIG_FS_ENCRYPTION
	ret = ext4_block_write_begin(folio, pos, len, ext4_da_get_block_prep);
#else
	ret = __block_write_begin(&folio->page, pos, len, ext4_da_get_block_prep);
#endif
----------

Since folio_wait_stable() calls folio_wait_writeback(), I'm guessing that
blk_mq_run_work_fn() is triggered by folio_wait_stable().

----------
void folio_wait_stable(struct folio *folio)
{
	if (mapping_stable_writes(folio_mapping(folio)))
		folio_wait_writeback(folio);
}
----------

If my guess is correct, I wonder how AS_STABLE_WRITES could be already set on a
folio struct returned by __filemap_get_folio() ? When AS_STABLE_WRITES is set?

Are there anything we can do for debugging this? Is adding a kernel config option that
does s/union/struct/g for helping debugger/printk() to inspect values in "struct folio"
possible?

Not directly related to this report, but I worry that
mapping_stable_writes(folio_mapping(folio)) might hit NULL pointer
dereference bug because folio_mapping() might return NULL and
mapping_stable_writes() assumes that the argument is not NULL.

On 2024/01/02 16:38, Tetsuo Handa wrote:
> #syz set subsystems: mm
> 
> On 2024/01/01 22:38, syzbot wrote:
>> Hello,
>>
>> syzbot found the following issue on:
>>
>> HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
>> git tree:       upstream
>> console+strace: https://syzkaller.appspot.com/x/log.txt?x=173df3e9e80000
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=e0c7078a6b901aa3
>> dashboard link: https://syzkaller.appspot.com/bug?extid=d7521c1e3841ed075a42
>> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1300b4a1e80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130b0379e80000
>>
>> Downloadable assets:
>> disk image: https://storage.googleapis.com/syzbot-assets/1520f7b6daa4/disk-fbafc3e6.raw.xz
>> vmlinux: https://storage.googleapis.com/syzbot-assets/8b490af009d5/vmlinux-fbafc3e6.xz
>> kernel image: https://storage.googleapis.com/syzbot-assets/202ca200f4a4/bzImage-fbafc3e6.xz
>>
>> IMPORTANT: if you fix the issue, please add the following tag to the commit:
>> Reported-by: syzbot+d7521c1e3841ed075a42@syzkaller.appspotmail.com
>>
>> =====================================================
>> BUG: KMSAN: uninit-value in vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
>> BUG: KMSAN: uninit-value in virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
>> BUG: KMSAN: uninit-value in virtqueue_add+0x21c6/0x6530 drivers/virtio/virtio_ring.c:2210
>>  vring_map_one_sg drivers/virtio/virtio_ring.c:380 [inline]
>>  virtqueue_add_split drivers/virtio/virtio_ring.c:614 [inline]
>>  virtqueue_add+0x21c6/0x6530 drivers/virtio/virtio_ring.c:2210
>>  virtqueue_add_sgs+0x186/0x1a0 drivers/virtio/virtio_ring.c:2244
>>  __virtscsi_add_cmd drivers/scsi/virtio_scsi.c:467 [inline]
>>  virtscsi_add_cmd+0x838/0xad0 drivers/scsi/virtio_scsi.c:501
>>  virtscsi_queuecommand+0x896/0xa60 drivers/scsi/virtio_scsi.c:598
>>  scsi_dispatch_cmd drivers/scsi/scsi_lib.c:1516 [inline]
>>  scsi_queue_rq+0x4874/0x5790 drivers/scsi/scsi_lib.c:1758
>>  blk_mq_dispatch_rq_list+0x13f8/0x3600 block/blk-mq.c:2049
>>  __blk_mq_do_dispatch_sched block/blk-mq-sched.c:170 [inline]
>>  blk_mq_do_dispatch_sched block/blk-mq-sched.c:184 [inline]
>>  __blk_mq_sched_dispatch_requests+0x10af/0x2500 block/blk-mq-sched.c:309
>>  blk_mq_sched_dispatch_requests+0x160/0x2d0 block/blk-mq-sched.c:333
>>  blk_mq_run_work_fn+0xd0/0x280 block/blk-mq.c:2434
>>  process_one_work kernel/workqueue.c:2627 [inline]
>>  process_scheduled_works+0x104e/0x1e70 kernel/workqueue.c:2700
>>  worker_thread+0xf45/0x1490 kernel/workqueue.c:2781
>>  kthread+0x3ed/0x540 kernel/kthread.c:388
>>  ret_from_fork+0x66/0x80 arch/x86/kernel/process.c:147
>>  ret_from_fork_asm+0x11/0x20 arch/x86/entry/entry_64.S:242
>>
>> Uninit was created at:
>>  __alloc_pages+0x9a4/0xe00 mm/page_alloc.c:4591
>>  alloc_pages_mpol+0x62b/0x9d0 mm/mempolicy.c:2133
>>  alloc_pages mm/mempolicy.c:2204 [inline]
>>  folio_alloc+0x1da/0x380 mm/mempolicy.c:2211
>>  filemap_alloc_folio+0xa5/0x430 mm/filemap.c:974
>>  __filemap_get_folio+0xa5a/0x1760 mm/filemap.c:1918
>>  ext4_da_write_begin+0x7f8/0xec0 fs/ext4/inode.c:2891
>>  generic_perform_write+0x3f5/0xc40 mm/filemap.c:3918
>>  ext4_buffered_write_iter+0x564/0xaa0 fs/ext4/file.c:299
>>  ext4_file_write_iter+0x20f/0x3460
>>  __kernel_write_iter+0x329/0x930 fs/read_write.c:517
>>  dump_emit_page fs/coredump.c:888 [inline]
>>  dump_user_range+0x593/0xcd0 fs/coredump.c:915
>>  elf_core_dump+0x528d/0x5a40 fs/binfmt_elf.c:2077
>>  do_coredump+0x32c9/0x4920 fs/coredump.c:764
>>  get_signal+0x2185/0x2d10 kernel/signal.c:2890
>>  arch_do_signal_or_restart+0x53/0xca0 arch/x86/kernel/signal.c:309
>>  exit_to_user_mode_loop+0xe8/0x320 kernel/entry/common.c:168
>>  exit_to_user_mode_prepare+0x163/0x220 kernel/entry/common.c:204
>>  irqentry_exit_to_user_mode+0xd/0x30 kernel/entry/common.c:309
>>  irqentry_exit+0x16/0x40 kernel/entry/common.c:412
>>  exc_page_fault+0x246/0x6f0 arch/x86/mm/fault.c:1564
>>  asm_exc_page_fault+0x2b/0x30 arch/x86/include/asm/idtentry.h:570
>>
>> Bytes 0-4095 of 4096 are uninitialized
>> Memory access of size 4096 starts at ffff88812c79c000
>>
>> CPU: 0 PID: 997 Comm: kworker/0:1H Not tainted 6.7.0-rc7-syzkaller-00003-gfbafc3e621c3 #0
>> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
>> Workqueue: kblockd blk_mq_run_work_fn
>> =====================================================
> 


