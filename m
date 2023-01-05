Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4970165E70F
	for <lists+linux-ext4@lfdr.de>; Thu,  5 Jan 2023 09:51:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjAEIvB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 5 Jan 2023 03:51:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbjAEIvA (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 5 Jan 2023 03:51:00 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D191C22;
        Thu,  5 Jan 2023 00:50:57 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4NngDC3fYmz4f3trQ;
        Thu,  5 Jan 2023 16:50:51 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP2 (Coremail) with SMTP id Syh0CgA33epsj7Zj0tp6BA--.16364S4;
        Thu, 05 Jan 2023 16:50:54 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+d30838395804afc2fa6f@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix WARNING in ext4_update_inline_data
Date:   Thu,  5 Jan 2023 17:15:26 +0800
Message-Id: <20230105091526.799343-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Syh0CgA33epsj7Zj0tp6BA--.16364S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWxZw4DCryDXw4fGw15urg_yoWruw1rpF
        WfGr1UGr48XFyUCFWxAr17Ary5Ww13CF4UJrZ7Wr4kZFy7tw1xWF95tr13JFyjyrsYkry2
        qF1Dt340gr15GaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IUbmii3UUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        MAY_BE_FORGED,SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Syzbot found the following issue:
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
fscrypt: AES-256-CTS-CBC using implementation "cts-cbc-aes-aesni"
fscrypt: AES-256-XTS using implementation "xts-aes-aesni"
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5071 at mm/page_alloc.c:5525 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
Modules linked in:
CPU: 1 PID: 5071 Comm: syz-executor263 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
RSP: 0018:ffffc90003c2f1c0 EFLAGS: 00010246
RAX: ffffc90003c2f220 RBX: 0000000000000014 RCX: 0000000000000000
RDX: 0000000000000028 RSI: 0000000000000000 RDI: ffffc90003c2f248
RBP: ffffc90003c2f2d8 R08: dffffc0000000000 R09: ffffc90003c2f220
R10: fffff52000785e49 R11: 1ffff92000785e44 R12: 0000000000040d40
R13: 1ffff92000785e40 R14: dffffc0000000000 R15: 1ffff92000785e3c
FS:  0000555556c0d300(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f95d5e04138 CR3: 00000000793aa000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_pages_node include/linux/gfp.h:237 [inline]
 alloc_pages_node include/linux/gfp.h:260 [inline]
 __kmalloc_large_node+0x95/0x1e0 mm/slab_common.c:1113
 __do_kmalloc_node mm/slab_common.c:956 [inline]
 __kmalloc+0xfe/0x190 mm/slab_common.c:981
 kmalloc include/linux/slab.h:584 [inline]
 kzalloc include/linux/slab.h:720 [inline]
 ext4_update_inline_data+0x236/0x6b0 fs/ext4/inline.c:346
 ext4_update_inline_dir fs/ext4/inline.c:1115 [inline]
 ext4_try_add_inline_entry+0x328/0x990 fs/ext4/inline.c:1307
 ext4_add_entry+0x5a4/0xeb0 fs/ext4/namei.c:2385
 ext4_add_nondir+0x96/0x260 fs/ext4/namei.c:2772
 ext4_create+0x36c/0x560 fs/ext4/namei.c:2817
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x12ac/0x2dd0 fs/namei.c:3711
 do_filp_open+0x264/0x4f0 fs/namei.c:3741
 do_sys_openat2+0x124/0x4e0 fs/open.c:1310
 do_sys_open fs/open.c:1326 [inline]
 __do_sys_openat fs/open.c:1342 [inline]
 __se_sys_openat fs/open.c:1337 [inline]
 __x64_sys_openat+0x243/0x290 fs/open.c:1337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

Above issue happens as follows:
ext4_iget
   ext4_find_inline_data_nolock ->i_inline_off=164 i_inline_size=60
ext4_try_add_inline_entry
   __ext4_mark_inode_dirty
      ext4_expand_extra_isize_ea ->i_extra_isize=32 s_want_extra_isize=44
         ext4_xattr_shift_entries
	 ->after shift i_inline_off is incorrect, actually is change to 176
ext4_try_add_inline_entry
  ext4_update_inline_dir
    get_max_inline_xattr_value_size
      if (EXT4_I(inode)->i_inline_off)
	entry = (struct ext4_xattr_entry *)((void *)raw_inode +
			EXT4_I(inode)->i_inline_off);
        free += EXT4_XATTR_SIZE(le32_to_cpu(entry->e_value_size));
	->As entry is incorrect, then 'free' may be negative
   ext4_update_inline_data
      value = kzalloc(len, GFP_NOFS);
      -> len is unsigned int, maybe very large, then trigger warning when
         'kzalloc()'
To resolve above issue there's need to update 'i_inline_off' after
'ext4_xattr_shift_entries()'.

Reported-by: syzbot+d30838395804afc2fa6f@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/xattr.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7decaaf27e82..4cb9fd5bb622 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2778,6 +2778,9 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 			(void *)header, total_ino);
 	EXT4_I(inode)->i_extra_isize = new_extra_isize;
 
+	if (ext4_has_inline_data(inode))
+		error = ext4_find_inline_data_nolock(inode);
+
 cleanup:
 	if (error && (mnt_count != le16_to_cpu(sbi->s_es->s_mnt_count))) {
 		ext4_warning(inode->i_sb, "Unable to expand inode %lu. Delete some EAs or run e2fsck.",
-- 
2.31.1

