Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37D22643AD0
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 02:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233074AbiLFBhQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Dec 2022 20:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232553AbiLFBhP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Dec 2022 20:37:15 -0500
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB17201BD;
        Mon,  5 Dec 2022 17:37:14 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4NR31d2Lxzz4f3lHK;
        Tue,  6 Dec 2022 09:37:09 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgDH69jFnI5jZpTsBg--.65169S5;
        Tue, 06 Dec 2022 09:37:11 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+4d99a966fd74bdeeec36@syzkaller.appspotmail.com
Subject: [PATCH -next 1/6] ext4: fix WARNING in ext4_expand_extra_isize_ea
Date:   Tue,  6 Dec 2022 09:58:01 +0800
Message-Id: <20221206015806.3420321-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221206015806.3420321-1-yebin@huaweicloud.com>
References: <20221206015806.3420321-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgDH69jFnI5jZpTsBg--.65169S5
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW3JFy5KrWkJr4rZr4kXrb_yoWrtr4xpw
        4fA347Cr48XFyDCF4xAr1Utw1DWwn5CF4UJry7Wrn7ZFy7Xw1xKas8Kr4fXFy8trW8J342
        qF1DJ34rKw15GaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvGb4IE77IF4wAFF20E14v26ryj6rWUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUGw
        A2048vs2IY020Ec7CjxVAFwI0_JFI_Gr1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
        w2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
        W8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v2
        6rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMc
        Ij6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_
        Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
        0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
        17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
        C0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
        6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
        73UjIFyTuYvjxUzl1vUUUUU
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
 fs/ext4/xattr.h | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index 824faf0b15a8..444ee46838c3 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -71,15 +71,10 @@ struct ext4_xattr_entry {
 #define IFIRST(hdr) ((struct ext4_xattr_entry *)((hdr)+1))
 
 /*
- * XATTR_SIZE_MAX is currently 64k, but for the purposes of checking
- * for file system consistency errors, we use a somewhat bigger value.
- * This allows XATTR_SIZE_MAX to grow in the future, but by using this
- * instead of INT_MAX for certain consistency checks, we don't need to
- * worry about arithmetic overflows.  (Actually XATTR_SIZE_MAX is
- * defined in include/uapi/linux/limits.h, so changing it is going
- * not going to be trivial....)
+ * Use XATTR_SIZE_MAX to checking for file system consistency errors. Extended
+ * attribute length exceed XATTR_SIZE_MAX is ilegal.
  */
-#define EXT4_XATTR_SIZE_MAX (1 << 24)
+#define EXT4_XATTR_SIZE_MAX XATTR_SIZE_MAX
 
 /*
  * The minimum size of EA value when you start storing it in an external inode
-- 
2.31.1

