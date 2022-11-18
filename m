Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8821F62EBF1
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Nov 2022 03:30:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbiKRCaF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Nov 2022 21:30:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240719AbiKRCaE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Nov 2022 21:30:04 -0500
Received: from dggsgout12.his.huawei.com (unknown [45.249.212.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8099656ECB;
        Thu, 17 Nov 2022 18:30:02 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4ND12r35Vbz4f3jMT;
        Fri, 18 Nov 2022 10:29:56 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgC329gl7nZj473bAg--.52978S4;
        Fri, 18 Nov 2022 10:29:59 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com,
        Jun Nie <jun.nie@linaro.org>
Subject: [PATCH] ext4: fix kernel BUG in 'ext4_write_inline_data_end()'
Date:   Fri, 18 Nov 2022 10:50:36 +0800
Message-Id: <20221118025036.3380705-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgC329gl7nZj473bAg--.52978S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXF48ZF4xurWUWw48uF18AFb_yoWrtry5pr
        Z8Gr1UGr40va4DCFWkAF1UXr1UCwn8CF47WryxWr1kXa43Cw1UKF1FgF18JF1jyrZ2vrWY
        qF4kC348Kw15G3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUkYb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
        vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
        xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
        0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
        6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
        Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
        7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
        Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
        6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
        AIw20EY4v20xvaj40_Wr1j6rW3Jr1lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280
        aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU17KsUUUUUU==
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Syzbot report follow issue:
------------[ cut here ]------------
kernel BUG at fs/ext4/inline.c:227!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3629 Comm: syz-executor212 Not tainted 6.1.0-rc5-syzkaller-00018-g59d0d52c30d4 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:ext4_write_inline_data+0x344/0x3e0 fs/ext4/inline.c:227
RSP: 0018:ffffc90003b3f368 EFLAGS: 00010293
RAX: 0000000000000000 RBX: ffff8880704e16c0 RCX: 0000000000000000
RDX: ffff888021763a80 RSI: ffffffff821e31a4 RDI: 0000000000000006
RBP: 000000000006818e R08: 0000000000000006 R09: 0000000000068199
R10: 0000000000000079 R11: 0000000000000000 R12: 000000000000000b
R13: 0000000000068199 R14: ffffc90003b3f408 R15: ffff8880704e1c82
FS:  000055555723e3c0(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffe8ac9080 CR3: 0000000079f81000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ext4_write_inline_data_end+0x2a3/0x12f0 fs/ext4/inline.c:768
 ext4_write_end+0x242/0xdd0 fs/ext4/inode.c:1313
 ext4_da_write_end+0x3ed/0xa30 fs/ext4/inode.c:3063
 generic_perform_write+0x316/0x570 mm/filemap.c:3764
 ext4_buffered_write_iter+0x15b/0x460 fs/ext4/file.c:285
 ext4_file_write_iter+0x8bc/0x16e0 fs/ext4/file.c:700
 call_write_iter include/linux/fs.h:2191 [inline]
 do_iter_readv_writev+0x20b/0x3b0 fs/read_write.c:735
 do_iter_write+0x182/0x700 fs/read_write.c:861
 vfs_iter_write+0x74/0xa0 fs/read_write.c:902
 iter_file_splice_write+0x745/0xc90 fs/splice.c:686
 do_splice_from fs/splice.c:764 [inline]
 direct_splice_actor+0x114/0x180 fs/splice.c:931
 splice_direct_to_actor+0x335/0x8a0 fs/splice.c:886
 do_splice_direct+0x1ab/0x280 fs/splice.c:974
 do_sendfile+0xb19/0x1270 fs/read_write.c:1255
 __do_sys_sendfile64 fs/read_write.c:1323 [inline]
 __se_sys_sendfile64 fs/read_write.c:1309 [inline]
 __x64_sys_sendfile64+0x1d0/0x210 fs/read_write.c:1309
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x39/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
---[ end trace 0000000000000000 ]---

Above issue may happens as follows:
ext4_da_write_begin
  ext4_da_write_inline_data_begin
    ext4_da_convert_inline_data_to_extent
      ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
ext4_da_write_end

ext4_run_li_request
  ext4_mb_prefetch
    ext4_read_block_bitmap_nowait
      ext4_validate_block_bitmap
        ext4_mark_group_bitmap_corrupted(sb, block_group, EXT4_GROUP_INFO_BBITMAP_CORRUPT)
	 percpu_counter_sub(&sbi->s_freeclusters_counter,grp->bb_free);
	  -> sbi->s_freeclusters_counter become zero
ext4_da_write_begin
  if (ext4_nonda_switch(inode->i_sb)) -> As freeclusters_counter is zero will return true
    *fsdata = (void *)FALL_BACK_TO_NONDELALLOC;
    ext4_write_begin
ext4_da_write_end
  if (write_mode == FALL_BACK_TO_NONDELALLOC)
    ext4_write_end
      if (inline_data)
        ext4_write_inline_data_end
	  ext4_write_inline_data
	    BUG_ON(pos + len > EXT4_I(inode)->i_inline_size);
           -> As inode is already convert to extent, so 'pos + len' > inline_size
	   -> then trigger BUG.

To solve above issue, there's need to judge inode if has EXT4_STATE_MAY_INLINE_DATA
flag in 'ext4_write_end()'. 'ext4_has_inline_data()' flag only cleared after do
write back, EXT4_STATE_MAY_INLINE_DATA flag indicate that inode has inline data,
so use this flag in 'ext4_write_end()' is suitable.

Fixes:f19d5870cbf7("ext4: add normal write support for inline data")
Reported-by: syzbot+4faa160fa96bfba639f8@syzkaller.appspotmail.com
Reported-by: Jun Nie <jun.nie@linaro.org>
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index fca47470c85a..89404d1aa1d5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1309,7 +1309,7 @@ static int ext4_write_end(struct file *file,
 
 	trace_ext4_write_end(inode, pos, len, copied);
 
-	if (ext4_has_inline_data(inode))
+	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
 		return ext4_write_inline_data_end(inode, pos, len, copied, page);
 
 	copied = block_write_end(file, mapping, pos, len, copied, page, fsdata);
-- 
2.31.1

