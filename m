Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77FB63F301
	for <lists+linux-ext4@lfdr.de>; Thu,  1 Dec 2022 15:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiLAOi3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 1 Dec 2022 09:38:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230471AbiLAOi1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 1 Dec 2022 09:38:27 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 755BFA6040;
        Thu,  1 Dec 2022 06:38:25 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NNJbH3JyGz4f3m7k;
        Thu,  1 Dec 2022 22:38:19 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgAnmdZcvIhjVMXmBQ--.22010S4;
        Thu, 01 Dec 2022 22:38:22 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
Subject: [PATCH v2] ext4: fix WARNING in ext4_expand_extra_isize_ea
Date:   Thu,  1 Dec 2022 22:59:23 +0800
Message-Id: <20221201145923.73028-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgAnmdZcvIhjVMXmBQ--.22010S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW3JFy5KrWkJr4rZr4kXrb_yoWrZF1Up3
        yayry8Cr48WryUCF48Cr1UJ34DWwn3CF4UJrW7Wr4xZFy7Xw1xKFyDKF43ZFy8tFW8Jr9F
        qF4Dtw10gr15G3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgEb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCj
        c4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4
        CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1x
        MIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_WFyUJV
        Cq3wCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIY
        CTnIWIevJa73UjIFyTuYvjxUrR6zUUUUU
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Syzbot found the following issue:
------------[ cut here ]------------
WARNING: CPU: 1 PID: 3631 at mm/page_alloc.c:5534 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5534
Modules linked in:
CPU: 1 PID: 3631 Comm: syz-executor261 Not tainted 6.1.0-rc6-syzkaller-00308-g644e9524388a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5534
RSP: 0018:ffffc90003ccf080 EFLAGS: 00010246
RAX: ffffc90003ccf0e0 RBX: 000000000000000c RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90003ccf108
RBP: ffffc90003ccf198 R08: dffffc0000000000 R09: ffffc90003ccf0e0
R10: fffff52000799e21 R11: 1ffff92000799e1c R12: 0000000000040c40
R13: 1ffff92000799e18 R14: dffffc0000000000 R15: 1ffff92000799e14
FS:  0000555555c10300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc36f70000 CR3: 00000000744ad000 CR4: 00000000003506e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node include/linux/gfp.h:223 [inline]
 alloc_pages_node include/linux/gfp.h:246 [inline]
 __kmalloc_large_node+0x8a/0x1a0 mm/slab_common.c:1096
 __do_kmalloc_node mm/slab_common.c:943 [inline]
 __kmalloc+0xfe/0x1a0 mm/slab_common.c:968
 kmalloc include/linux/slab.h:558 [inline]
 ext4_xattr_move_to_block fs/ext4/xattr.c:2558 [inline]
 ext4_xattr_make_inode_space fs/ext4/xattr.c:2673 [inline]
 ext4_expand_extra_isize_ea+0xe3f/0x1cd0 fs/ext4/xattr.c:2765
 __ext4_expand_extra_isize+0x2b8/0x3f0 fs/ext4/inode.c:5857
 ext4_try_to_expand_extra_isize fs/ext4/inode.c:5900 [inline]
 __ext4_mark_inode_dirty+0x51a/0x670 fs/ext4/inode.c:5978
 ext4_inline_data_truncate+0x548/0xd00 fs/ext4/inline.c:2021
 ext4_truncate+0x341/0xeb0 fs/ext4/inode.c:4221
 ext4_process_orphan+0x1aa/0x2d0 fs/ext4/orphan.c:339
 ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
 __ext4_fill_super fs/ext4/super.c:5515 [inline]
 ext4_fill_super+0x80ed/0x8610 fs/ext4/super.c:5643
 get_tree_bdev+0x400/0x620 fs/super.c:1324
 vfs_get_tree+0x88/0x270 fs/super.c:1531
 do_new_mount+0x289/0xad0 fs/namespace.c:3040
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
 </TASK>

Reason is allocate 16M memory by kmalloc, but MAX_ORDER is 11, kmalloc
can allocate maxium size memory is 4M.
XATTR_SIZE_MAX is currently 64k, but EXT4_XATTR_SIZE_MAX is '(1 << 24)',
so 'ext4_xattr_check_entries()' regards this length as legal. Then trigger
warning in 'ext4_xattr_move_to_block()'.
To solve above issue, according to Jan Kara's suggestion use kvmalloc()
to allocate memory in ext4_xattr_move_to_block().

Reported-by: syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
Fixes: 54dd0e0a1b25 ("ext4: add extra checks to ext4_xattr_block_get()")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/xattr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 718ef3987f94..23cfefc6d262 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2556,7 +2556,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 
 	is = kzalloc(sizeof(struct ext4_xattr_ibody_find), GFP_NOFS);
 	bs = kzalloc(sizeof(struct ext4_xattr_block_find), GFP_NOFS);
-	buffer = kmalloc(value_size, GFP_NOFS);
+	buffer = kvmalloc(value_size, GFP_NOFS);
 	b_entry_name = kmalloc(entry->e_name_len + 1, GFP_NOFS);
 	if (!is || !bs || !buffer || !b_entry_name) {
 		error = -ENOMEM;
@@ -2608,7 +2608,7 @@ static int ext4_xattr_move_to_block(handle_t *handle, struct inode *inode,
 	error = 0;
 out:
 	kfree(b_entry_name);
-	kfree(buffer);
+	kvfree(buffer);
 	if (is)
 		brelse(is->iloc.bh);
 	if (bs)
-- 
2.31.1

