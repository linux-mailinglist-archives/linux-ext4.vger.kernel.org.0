Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDCE666B546
	for <lists+linux-ext4@lfdr.de>; Mon, 16 Jan 2023 02:36:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbjAPBgF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 15 Jan 2023 20:36:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231672AbjAPBgE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 15 Jan 2023 20:36:04 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 812E435A2;
        Sun, 15 Jan 2023 17:36:02 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.143])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NwF3J3p0mz4f3nq9;
        Mon, 16 Jan 2023 09:35:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP3 (Coremail) with SMTP id _Ch0CgBH9CH9qcRjJsKTBg--.6034S4;
        Mon, 16 Jan 2023 09:35:59 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+68223fe9f6c95ad43bed@syzkaller.appspotmail.com
Subject: [PATCH v2] ext4: fix WARNING in mb_find_extent
Date:   Mon, 16 Jan 2023 10:00:15 +0800
Message-Id: <20230116020015.1506120-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _Ch0CgBH9CH9qcRjJsKTBg--.6034S4
X-Coremail-Antispam: 1UD129KBjvJXoW3GFW8Wr17Xry8WF4xZFyrWFg_yoW7Cw1rp3
        W3Ar1UGr4rWr1UuF4fJr1FvF1rGw1xu3W8JrWfur1UXFy7Jw17GFyvyFy8XayqqFWUArnx
        XFn8Gw4xKr15WaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBI
        daVFxhVjvjDU0xZFpf9x07UWE__UUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Syzbot found the following issue:

EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!
EXT4-fs (loop0): orphan cleanup on readonly fs
------------[ cut here ]------------
WARNING: CPU: 1 PID: 5067 at fs/ext4/mballoc.c:1869 mb_find_extent+0x8a1/0xe30
Modules linked in:
CPU: 1 PID: 5067 Comm: syz-executor307 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:mb_find_extent+0x8a1/0xe30 fs/ext4/mballoc.c:1869
RSP: 0018:ffffc90003c9e098 EFLAGS: 00010293
RAX: ffffffff82405731 RBX: 0000000000000041 RCX: ffff8880783457c0
RDX: 0000000000000000 RSI: 0000000000000041 RDI: 0000000000000040
RBP: 0000000000000040 R08: ffffffff82405723 R09: ffffed10053c9402
R10: ffffed10053c9402 R11: 1ffff110053c9401 R12: 0000000000000000
R13: ffffc90003c9e538 R14: dffffc0000000000 R15: ffffc90003c9e2cc
FS:  0000555556665300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000056312f6796f8 CR3: 0000000022437000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ext4_mb_complex_scan_group+0x353/0x1100 fs/ext4/mballoc.c:2307
 ext4_mb_regular_allocator+0x1533/0x3860 fs/ext4/mballoc.c:2735
 ext4_mb_new_blocks+0xddf/0x3db0 fs/ext4/mballoc.c:5605
 ext4_ext_map_blocks+0x1868/0x6880 fs/ext4/extents.c:4286
 ext4_map_blocks+0xa49/0x1cc0 fs/ext4/inode.c:651
 ext4_getblk+0x1b9/0x770 fs/ext4/inode.c:864
 ext4_bread+0x2a/0x170 fs/ext4/inode.c:920
 ext4_quota_write+0x225/0x570 fs/ext4/super.c:7105
 write_blk fs/quota/quota_tree.c:64 [inline]
 get_free_dqblk+0x34a/0x6d0 fs/quota/quota_tree.c:130
 do_insert_tree+0x26b/0x1aa0 fs/quota/quota_tree.c:340
 do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
 do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
 do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
 dq_insert_tree fs/quota/quota_tree.c:401 [inline]
 qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:420
 v2_write_dquot+0x11b/0x190 fs/quota/quota_v2.c:358
 dquot_acquire+0x348/0x670 fs/quota/dquot.c:444
 ext4_acquire_dquot+0x2dc/0x400 fs/ext4/super.c:6740
 dqget+0x999/0xdc0 fs/quota/dquot.c:914
 __dquot_initialize+0x3d0/0xcf0 fs/quota/dquot.c:1492
 ext4_process_orphan+0x57/0x2d0 fs/ext4/orphan.c:329
 ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5516 [inline]
 ext4_fill_super+0x81cd/0x8700 fs/ext4/super.c:5644
 get_tree_bdev+0x400/0x620 fs/super.c:1282
 vfs_get_tree+0x88/0x270 fs/super.c:1489
 do_new_mount+0x289/0xad0 fs/namespace.c:3145
 do_mount fs/namespace.c:3488 [inline]
 __do_sys_mount fs/namespace.c:3697 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Add some debug information:
mb_find_extent: mb_find_extent block=41, order=0 needed=64 next=0 ex=0/41/1@3735929054 64 64 7
block_bitmap: ff 3f 0c 00 fc 01 00 00 d2 3d 00 00 00 00 00 00 ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff

Acctually, blocks per group is 64, but block bitmap indicate at least has
128 blocks. Now, ext4_validate_block_bitmap() didn't check invalid block's
bitmap if set.
To resolve above issue, add check like fsck "Padding at end of block bitmap is
not set".

Reported-by: syzbot+68223fe9f6c95ad43bed@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/balloc.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index 8ff4b9192a9f..f2c415f31b75 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -303,6 +303,22 @@ struct ext4_group_desc * ext4_get_group_desc(struct super_block *sb,
 	return desc;
 }
 
+static ext4_fsblk_t ext4_valid_block_bitmap_padding(struct super_block *sb,
+						    ext4_group_t block_group,
+						    struct buffer_head *bh)
+{
+	ext4_grpblk_t next_zero_bit;
+	unsigned long bitmap_size = sb->s_blocksize * 8;
+	unsigned int offset = num_clusters_in_group(sb, block_group);
+
+	if (bitmap_size <= offset)
+		return 0;
+
+	next_zero_bit = ext4_find_next_zero_bit(bh->b_data, bitmap_size, offset);
+
+	return (next_zero_bit < bitmap_size ? next_zero_bit : 0);
+}
+
 /*
  * Return the block number which was discovered to be invalid, or 0 if
  * the block bitmap is valid.
@@ -401,6 +417,15 @@ static int ext4_validate_block_bitmap(struct super_block *sb,
 					EXT4_GROUP_INFO_BBITMAP_CORRUPT);
 		return -EFSCORRUPTED;
 	}
+	blk = ext4_valid_block_bitmap_padding(sb, block_group, bh);
+	if (unlikely(blk != 0)) {
+		ext4_unlock_group(sb, block_group);
+		ext4_error(sb, "bg %u: block %llu: padding at end of block bitmap is not set",
+			   block_group, blk);
+		ext4_mark_group_bitmap_corrupted(sb, block_group,
+						 EXT4_GROUP_INFO_BBITMAP_CORRUPT);
+		return -EFSCORRUPTED;
+	}
 	set_buffer_verified(bh);
 verified:
 	ext4_unlock_group(sb, block_group);
-- 
2.31.1

