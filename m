Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 739D865CD5C
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 07:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229655AbjADGvi (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 01:51:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233583AbjADGva (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 01:51:30 -0500
Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E84B2DDC;
        Tue,  3 Jan 2023 22:51:27 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.153])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4Nn0cp1Tcbz4f3pPP;
        Wed,  4 Jan 2023 14:51:22 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP4 (Coremail) with SMTP id gCh0CgCH77LrIbVjk6tLBA--.65158S4;
        Wed, 04 Jan 2023 14:51:24 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix use-after-free Read in ext4_find_extent for bigalloc + inline
Date:   Wed,  4 Jan 2023 15:15:59 +0800
Message-Id: <20230104071559.2051847-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: gCh0CgCH77LrIbVjk6tLBA--.65158S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrW3XryxKr17GF1rAw4xZwb_yoWrWrW7p3
        s8Jr97Gr40v34qkFZ7Jr1UXF1UJw47Ca1UGryfGr18XFyUGw10gF1ktF1UJa4vgrW8ZFyU
        tF1Dt34UKw15AaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
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
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,HEXHASH_WORD,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Syzbot found the following issue:
loop0: detected capacity change from 0 to 2048
EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
==================================================================
BUG: KASAN: use-after-free in ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
BUG: KASAN: use-after-free in ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
Read of size 4 at addr ffff888073644750 by task syz-executor420/5067

CPU: 0 PID: 5067 Comm: syz-executor420 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
 print_address_description+0x74/0x340 mm/kasan/report.c:306
 print_report+0x107/0x1f0 mm/kasan/report.c:417
 kasan_report+0xcd/0x100 mm/kasan/report.c:517
 ext4_ext_binsearch_idx fs/ext4/extents.c:768 [inline]
 ext4_find_extent+0x76e/0xd90 fs/ext4/extents.c:931
 ext4_clu_mapped+0x117/0x970 fs/ext4/extents.c:5809
 ext4_insert_delayed_block fs/ext4/inode.c:1696 [inline]
 ext4_da_map_blocks fs/ext4/inode.c:1806 [inline]
 ext4_da_get_block_prep+0x9e8/0x13c0 fs/ext4/inode.c:1870
 ext4_block_write_begin+0x6a8/0x2290 fs/ext4/inode.c:1098
 ext4_da_write_begin+0x539/0x760 fs/ext4/inode.c:3082
 generic_perform_write+0x2e4/0x5e0 mm/filemap.c:3772
 ext4_buffered_write_iter+0x122/0x3a0 fs/ext4/file.c:285
 ext4_file_write_iter+0x1d0/0x18f0
 call_write_iter include/linux/fs.h:2186 [inline]
 new_sync_write fs/read_write.c:491 [inline]
 vfs_write+0x7dc/0xc50 fs/read_write.c:584
 ksys_write+0x177/0x2a0 fs/read_write.c:637
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f4b7a9737b9
RSP: 002b:00007ffc5cac3668 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f4b7a9737b9
RDX: 00000000175d9003 RSI: 0000000020000200 RDI: 0000000000000004
RBP: 00007f4b7a933050 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000079f R11: 0000000000000246 R12: 00007f4b7a9330e0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>

Above issue is happens when enable bigalloc and inline data feature. As
commit 131294c35ed6 fixed delayed allocation bug in ext4_clu_mapped for
bigalloc + inline. But it only resolved issue when has inline data, if
inline data has been converted to extent(ext4_da_convert_inline_data_to_extent)
before writepages, there is no EXT4_STATE_MAY_INLINE_DATA flag. However
i_data is still store inline data in this scene. Then will trigger UAF
when find extent.
To resolve above issue, there is need to add judge "ext4_has_inline_data(inode)"
in ext4_clu_mapped().

Reported-by: syzbot+bf4bb7731ef73b83a3b4@syzkaller.appspotmail.com
Fixes: 131294c35ed6 ("ext4: fix delayed allocation bug in ext4_clu_mapped for bigalloc + inline")
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/extents.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 9de1c9d1a13d..ee5acf2bd5e6 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -5802,7 +5802,8 @@ int ext4_clu_mapped(struct inode *inode, ext4_lblk_t lclu)
 	 * mapped - no physical clusters have been allocated, and the
 	 * file has no extents
 	 */
-	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
+	if (ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) ||
+	    ext4_has_inline_data(inode))
 		return 0;
 
 	/* search for the extent closest to the first block in the cluster */
-- 
2.31.1

