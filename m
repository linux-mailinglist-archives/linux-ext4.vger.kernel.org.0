Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 525EA24E661
	for <lists+linux-ext4@lfdr.de>; Sat, 22 Aug 2020 10:22:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHVIWs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 22 Aug 2020 04:22:48 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10309 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726169AbgHVIWr (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sat, 22 Aug 2020 04:22:47 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id E456B548F2C0A4008353;
        Sat, 22 Aug 2020 16:22:42 +0800 (CST)
Received: from huawei.com (10.175.127.227) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Sat, 22 Aug 2020
 16:22:32 +0800
From:   Ye Bin <yebin10@huawei.com>
To:     <jack@suse.com>, <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <yebin10@huawei.com>
Subject: [PATCH 2/2] jbd2: Fix race between do_invalidatepage and init_page_buffers
Date:   Sat, 22 Aug 2020 16:22:18 +0800
Message-ID: <20200822082218.2228697-3-yebin10@huawei.com>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20200822082218.2228697-1-yebin10@huawei.com>
References: <20200822082218.2228697-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We got follow exception when test lvreduce:
[ 7986.689400] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[ 7986.697197] PGD 0 P4D 0
[ 7986.699724] Oops: 0002 [#1] SMP PTI
[ 7986.703200] CPU: 4 PID: 203778 Comm: jbd2/dm-3-8 Kdump: loaded Tainted: G           O     --------- -  - 4.18.0-147.5.0.5.h126.eulerosv2r9.x86_64 #1
[ 7986.716438] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 1.57 08/11/2015
[ 7986.723462] RIP: 0010:jbd2_journal_grab_journal_head+0x1b/0x40 [jbd2]
[ 7986.729876] Code: e8 83 75 ac da e9 5e ff ff ff 0f 1f 44 00 00 0f 1f 44 00 00 f0 48 0f ba 2f 18 72 18 48 8b 07 a9 00 00 02 00 74 1c 48 8b 47 40 <83> 40 08 01 f0 80 67 03 fe c3 f3 90 48 8b 07 a9 00 00 00 01 75 f4
[ 7986.748557] RSP: 0018:ffffaa8ca198fcd0 EFLAGS: 00010206
[ 7986.753761] RAX: 0000000000000000 RBX: ffff96f4ebde2960 RCX: dead000000000200
[ 7986.760864] RDX: ffff96f4f3338870 RSI: ffff96f5311c6f00 RDI: ffff96f4f0e6ee38
[ 7986.767967] RBP: ffff96f5311c6f00 R08: ffff97247bb01d68 R09: ffff96f4e92cb210
[ 7986.775069] R10: 0000000000000000 R11: 0000000000000228 R12: ffff96f4f0e6ee38
[ 7986.782171] R13: ffff96f4ebde2960 R14: ffff9724b8cce3a8 R15: ffff96f5311c6f00
[ 7986.789274] FS:  0000000000000000(0000) GS:ffff96f53f700000(0000) knlGS:0000000000000000
[ 7986.797328] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 7986.803049] CR2: 0000000000000008 CR3: 0000001c9260a005 CR4: 00000000001606e0
[ 7986.810150] Call Trace:
[ 7986.812595]  __jbd2_journal_insert_checkpoint+0x23/0x70 [jbd2]
[ 7986.818408]  jbd2_journal_commit_transaction+0x155f/0x1b60 [jbd2]
[ 7986.824480]  ? __switch_to_asm+0x41/0x70
[ 7986.828386]  ? __switch_to_asm+0x35/0x70
[ 7986.832295]  ? kjournald2+0xbd/0x270 [jbd2]
[ 7986.836467]  kjournald2+0xbd/0x270 [jbd2]
[ 7986.840462]  ? finish_wait+0x80/0x80
[ 7986.844027]  ? commit_timeout+0x10/0x10 [jbd2]
[ 7986.848452]  kthread+0x10d/0x130
[ 7986.851671]  ? kthread_flush_work_fn+0x10/0x10
[ 7986.855973] md/raid:mdX: device dm-188 operational as raid disk 0
[ 7986.856100]  ret_from_fork+0x35/0x40
[ 7986.862169] md/raid:mdX: device dm-215 operational as raid disk 1
[ 7986.865732] Modules linked in:
[ 7986.871802] md/raid:mdX: device dm-128 operational as raid disk 2
[ 7986.871804]  dm_snapshot
[ 7986.875270] md/raid:mdX: raid level 5 active with 3 out of 3 devices, algorithm 2

Other exception:
[ 4167.542166] BUG: unable to handle kernel NULL pointer dereference at 0000000000000008
[ 4167.549967] PGD 8000002fa3a7d067 P4D 8000002fa3a7d067 PUD 2fb4a03067 PMD 0
[ 4167.549971] Oops: 0002 [#1] SMP PTI
[ 4167.549973] CPU: 40 PID: 109973 Comm: fsstress Kdump: loaded Tainted: G           O     --------- -  - 4.18.0-147.5.0.5.h126.eulerosv2r9.x86_64 #1
[ 4167.549976] Hardware name: Huawei RH2288H V3/BC11HGSA0, BIOS 1.57 08/11/2015
[ 4167.591371] RIP: 0010:jbd2_journal_add_journal_head+0xbf/0x120 [jbd2]
[ 4167.597784] Code: c2 00 00 00 01 75 f3 e9 6a ff ff ff 48 8b 53 10 48 85 d2 74 0b 48 83 7a 18 00 0f 85 74 ff ff ff 0f 0b 48 8b 4b 40 48 8d 53 03 <83> 41 08 01 f0 80 22 fe 48 85 c0 74 0f 48 8b 3d 7d bd 00 00 48 89
[ 4167.616464] RSP: 0018:ffff9a716674fc60 EFLAGS: 00010206
[ 4167.621666] RAX: 0000000000000000 RBX: ffff8d4f5e2568f0 RCX: 0000000000000000
[ 4167.628768] RDX: ffff8d4f5e2568f3 RSI: ffff8d4f5e2568f0 RDI: ffff8d4f5e2568f0
[ 4167.635869] RBP: ffff8d4f5e2568f0 R08: ffffbd14be3f14b4 R09: ffffbd14be3f1480
[ 4167.642973] R10: 0000000000000000 R11: ffff9a716674fb50 R12: ffff8d20364ec038
[ 4167.650075] R13: 0000000000001733 R14: ffff8d4fb6b48800 R15: ffff9a716674fdc8
[ 4167.657179] FS:  00007f35d68e6540(0000) GS:ffff8d203fb80000(0000) knlGS:0000000000000000
[ 4167.665232] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 4167.670953] CR2: 0000000000000008 CR3: 0000002f6b0ee002 CR4: 00000000001606e0
[ 4167.678057] Call Trace:
[ 4167.680506]  jbd2_journal_get_write_access+0x51/0x80 [jbd2]
[ 4167.686081]  __ext4_journal_get_write_access+0x41/0x80 [ext4]
[ 4167.691818]  ext4_reserve_inode_write+0x8d/0xb0 [ext4]
[ 4167.696948]  ? add_dirent_to_buf+0x10c/0x1c0 [ext4]
[ 4167.701813]  ext4_mark_inode_dirty+0x51/0x1d0 [ext4]
[ 4167.706764]  ? current_time+0x4d/0x90
[ 4167.710420]  add_dirent_to_buf+0x10c/0x1c0 [ext4]
[ 4167.715112]  ext4_add_entry+0x10d/0x330 [ext4]
[ 4167.719546]  ? ext4_mark_iloc_dirty+0x5e/0x80 [ext4]
[ 4167.724498]  ? ext4_orphan_del+0x148/0x270 [ext4]
[ 4167.729190]  ext4_add_nondir+0x2b/0xb0 [ext4]
[ 4167.733537]  ext4_symlink+0x207/0x460 [ext4]
[ 4167.737795]  vfs_symlink+0xe6/0x170
[ 4167.741271]  do_symlinkat+0xdd/0xf0
[ 4167.744753]  do_syscall_64+0x5b/0x1b0
[ 4167.748409]  entry_SYSCALL_64_after_hwframe+0x65/0xca
[ 4167.753443] RIP: 0033:0x7f35d68183a7

We run fsstress when we do lvreduce and lvextend. Lvreduce operation will lead
to do invalidatepage when write-back, bh's BH_Mappped flag will be cleaned. If
we get this bh again will call init_page_buffers clean bh->b_private. If
 this bh is used by jbd2, then when do commit transaction will lead to oops.

write-back                      	  kjournal
		touch file1(1) --->make page dirty
				start jbd2_journal_commit_transaction N
				          ...
				end jbd2_journal_commit_transaction N
		touch file2(2)
				start jbd2_journal_commit_transaction N + 1 (3)
block_write_full_page
  do_invalidatepage
    block_invalidatepage
      discard_buffer --->clear BH_Mapped(4)
      		touch file3 (5)
		   init_page_buffers --->set bh->b_private = NULL
		   		  jbd2_journal_get_write_access
				    jbd2_journal_add_journal_head(6)
				    --->jh is NULL and trigger oops

How to reproduce:
 First we add delay and information in kernel:
int block_write_full_page(struct page *page, get_block_t *get_block,
                        struct writeback_control *wbc)
 {
        struct inode * const inode = page->mapping->host;

+       if (page->index == 196609) {
+               printk("start %s\n", __func__);
+               msleep(10000);
+               printk("end %s\n", __func__);
+       }
 ...
}

int block_write_full_page(struct page *page, get_block_t *get_block,
		 struct writeback_control *wbc)
{
	if (page->index >= end_index+1 || !offset) {
+		printk("do_invalidatepage\n");
                do_invalidatepage(page, 0, PAGE_SIZE);
		....
}

void jbd2_journal_commit_transaction(journal_t *journal)
{
...
+	printk("start %s\n", __func__);
+	msleep(30000);
+	printk("end %s\n", __func__);
 	while (commit_transaction->t_buffers) {
		...
	}
...
}
step 1:
Create a large number of empty files to consume all inodes, and delete some
files which inode number is bigger. Make sure that the inodes are allocated
in the last block group.
step 2:
touch file1
step 3
wait print "end jbd2_journal_commit_transaction" then touch file2
step 4:
wait print "start jbd2_journal_commit_transaction" then
lvreduce -f -L-128M /dev/vgxx/lvxx
step 5:
wait print "do_invalidatepage" then touch file3
step 6:
wait a moment trigger oops

Maybe this kind of operation is not recommended, but the kernel can't crash
either. We add b_discard callback to buffer_head for judging bh could be
discarded when call discard_buffer. If jbd2 is using this buffer_head, we can't
discard buffer_head.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/buffer.c                 | 4 ++++
 fs/jbd2/journal.c           | 7 +++++++
 include/linux/buffer_head.h | 2 ++
 3 files changed, 13 insertions(+)

diff --git a/fs/buffer.c b/fs/buffer.c
index d05b94cc48c0..1395f7db016e 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -928,6 +928,7 @@ init_page_buffers(struct page *page, struct block_device *bdev,
 		if (!buffer_mapped(bh)) {
 			bh->b_end_io = NULL;
 			bh->b_private = NULL;
+			bh->b_discard = NULL;
 			bh->b_bdev = bdev;
 			bh->b_blocknr = block;
 			if (uptodate)
@@ -1511,6 +1512,9 @@ static void discard_buffer(struct buffer_head * bh)
 {
 	unsigned long b_state, b_state_old;
 
+	if (bh->b_discard && !bh->b_discard(bh))
+		return;
+
 	lock_buffer(bh);
 	clear_buffer_dirty(bh);
 	bh->b_bdev = NULL;
diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 17fdc482f554..7e04c8afcac0 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2450,6 +2450,11 @@ static void journal_free_journal_head(struct journal_head *jh)
 	kmem_cache_free(jbd2_journal_head_cache, jh);
 }
 
+static bool journal_discard_buffer(struct buffer_head *bh)
+{
+	return !buffer_jbd(bh);
+}
+
 /*
  * A journal_head is attached to a buffer_head whenever JBD has an
  * interest in the buffer.
@@ -2517,6 +2522,7 @@ struct journal_head *jbd2_journal_add_journal_head(struct buffer_head *bh)
 		new_jh = NULL;		/* We consumed it */
 		set_buffer_jbd(bh);
 		bh->b_private = jh;
+		bh->b_discard = journal_discard_buffer;
 		jh->b_bh = bh;
 		get_bh(bh);
 		BUFFER_TRACE(bh, "added journal_head");
@@ -2559,6 +2565,7 @@ static void __journal_remove_journal_head(struct buffer_head *bh)
 
 	/* Unlink before dropping the lock */
 	bh->b_private = NULL;
+	bh->b_discard = NULL;
 	jh->b_bh = NULL;	/* debug, really */
 	clear_buffer_jbd(bh);
 }
diff --git a/include/linux/buffer_head.h b/include/linux/buffer_head.h
index 6b47f94378c5..a8dfb84f0a42 100644
--- a/include/linux/buffer_head.h
+++ b/include/linux/buffer_head.h
@@ -47,6 +47,7 @@ struct page;
 struct buffer_head;
 struct address_space;
 typedef void (bh_end_io_t)(struct buffer_head *bh, int uptodate);
+typedef bool (bh_discard_t)(struct buffer_head *bh);
 
 /*
  * Historically, a buffer_head was used to map a single block
@@ -76,6 +77,7 @@ struct buffer_head {
 	spinlock_t b_uptodate_lock;	/* Used by the first bh in a page, to
 					 * serialise IO completion of other
 					 * buffers in the page */
+	bh_discard_t *b_discard;          /* judge buffer could be discarded */
 };
 
 /*
-- 
2.25.4

