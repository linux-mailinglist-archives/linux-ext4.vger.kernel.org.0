Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B7661E849
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Nov 2022 02:32:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiKGBcH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Nov 2022 20:32:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiKGBcG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Nov 2022 20:32:06 -0500
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E202AF9;
        Sun,  6 Nov 2022 17:32:03 -0800 (PST)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4N5DH12R80z4f3vbk;
        Mon,  7 Nov 2022 09:31:57 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.127.227])
        by APP1 (Coremail) with SMTP id cCh0CgDHcK8OYGhj0cFlAA--.408S4;
        Mon, 07 Nov 2022 09:32:00 +0800 (CST)
From:   Ye Bin <yebin@huaweicloud.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, jack@suse.cz,
        Ye Bin <yebin10@huawei.com>,
        syzbot+98346927678ac3059c77@syzkaller.appspotmail.com
Subject: [PATCH] ext4: init quota for 'old.inode' in 'ext4_rename'
Date:   Mon,  7 Nov 2022 09:53:35 +0800
Message-Id: <20221107015335.2524319-1-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgDHcK8OYGhj0cFlAA--.408S4
X-Coremail-Antispam: 1UD129KBjvJXoWxGrWxWr4Dur1xKw48XrW7CFg_yoW5Aw13pF
        13Ar4UCr40qry5Cr48Jryjqr1UG3sruF4UJFy7ur10y3WUuw1kXF18Kw4kGFy5JrW8Xr1S
        qa1DJw1YqrnxG3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUgKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r1S6rWUM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
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
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Ye Bin <yebin10@huawei.com>

Syzbot found the following issue:
ext4_parse_param: s_want_extra_isize=128
ext4_inode_info_init: s_want_extra_isize=32
ext4_rename: old.inode=ffff88823869a2c8 old.dir=ffff888238699828 new.inode=ffff88823869d7e8 new.dir=ffff888238699828
__ext4_mark_inode_dirty: inode=ffff888238699828 ea_isize=32 want_ea_size=128
__ext4_mark_inode_dirty: inode=ffff88823869a2c8 ea_isize=32 want_ea_size=128
ext4_xattr_block_set: inode=ffff88823869a2c8
------------[ cut here ]------------
WARNING: CPU: 13 PID: 2234 at fs/ext4/xattr.c:2070 ext4_xattr_block_set.cold+0x22/0x980
Modules linked in:
RIP: 0010:ext4_xattr_block_set.cold+0x22/0x980
RSP: 0018:ffff888227d3f3b0 EFLAGS: 00010202
RAX: 0000000000000001 RBX: ffff88823007a000 RCX: 0000000000000000
RDX: 0000000000000a03 RSI: 0000000000000040 RDI: ffff888230078178
RBP: 0000000000000000 R08: 000000000000002c R09: ffffed1075c7df8e
R10: ffff8883ae3efc6b R11: ffffed1075c7df8d R12: 0000000000000000
R13: ffff88823869a2c8 R14: ffff8881012e0460 R15: dffffc0000000000
FS:  00007f350ac1f740(0000) GS:ffff8883ae200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f350a6ed6a0 CR3: 0000000237456000 CR4: 00000000000006e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ? ext4_xattr_set_entry+0x3b7/0x2320
 ? ext4_xattr_block_set+0x0/0x2020
 ? ext4_xattr_set_entry+0x0/0x2320
 ? ext4_xattr_check_entries+0x77/0x310
 ? ext4_xattr_ibody_set+0x23b/0x340
 ext4_xattr_move_to_block+0x594/0x720
 ext4_expand_extra_isize_ea+0x59a/0x10f0
 __ext4_expand_extra_isize+0x278/0x3f0
 __ext4_mark_inode_dirty.cold+0x347/0x410
 ext4_rename+0xed3/0x174f
 vfs_rename+0x13a7/0x2510
 do_renameat2+0x55d/0x920
 __x64_sys_rename+0x7d/0xb0
 do_syscall_64+0x3b/0xa0
 entry_SYSCALL_64_after_hwframe+0x72/0xdc

As 'ext4_rename' will modify 'old.inode' ctime and mark inode dirty, which may
trigger expand 'extra_isize' and allocate block. If inode didn't init quota
will lead to warning.
To solve above issue, init 'old.inode' firstly in 'ext4_rename'.

Reported-by: syzbot+98346927678ac3059c77@syzkaller.appspotmail.com
Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index b8a91d74fdd1..6e40dfc8bd30 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3784,6 +3784,9 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
 		return -EXDEV;
 
 	retval = dquot_initialize(old.dir);
+	if (retval)
+		return retval;
+	retval = dquot_initialize(old.inode);
 	if (retval)
 		return retval;
 	retval = dquot_initialize(new.dir);
-- 
2.31.1

