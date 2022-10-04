Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16A105F45C3
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Oct 2022 16:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJDOkq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 Oct 2022 10:40:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229717AbiJDOkl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 Oct 2022 10:40:41 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 482F217E36
        for <linux-ext4@vger.kernel.org>; Tue,  4 Oct 2022 07:40:40 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id z7-20020a056e02088700b002f9f06320b5so3925212ils.11
        for <linux-ext4@vger.kernel.org>; Tue, 04 Oct 2022 07:40:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date;
        bh=2btMzZD4iomFF2lA9dM7V5O1a3ujc+n0NzEA1ntYrHc=;
        b=WAuCnG32uYI9iUQ/oVDZVkvYV5nA1mTGDL1pzB/mMC/XYifUpbYZpACFVmePlJZQEp
         REnpInTu55hKwnneH78bq+QJ1I5vkmxHmkNWlM9bvOmOUvJX4XvFU9oJ8N7sNATfuGPD
         vmTmcFAXv2hmclOittJ8n6dV8dOIH3VmgV+9nRPJl+FVdiIDGMaNDmKT10eufyNG23a6
         Ai8gGn1QfAMcR+5JiwIa3qr5LGo/1bRD9kaF8WcR/24Y0e37UxT4yRwhIVWl2N5gFrkE
         xzvz2xJ7TG6QzjVqKpMZexoDp77Uh+0nIf5ec8gsT8OrG5rA1CBYvkIR8tXOFhS3dNsG
         TKdQ==
X-Gm-Message-State: ACrzQf2DGbNJtWJl9SBVvXrf69aAnWRlJpVGgZDzhLR4a/Gtjt2/XQ9y
        LSuqeloeipSNenD19Du8RY2lXOjnq3rigcjSea5pClqg5Cif
X-Google-Smtp-Source: AMsMyM6dhpMAIlUw+2o8BMue6nGq9NxubviuhJeeNvMB68iW/y1Q/Wn+89AIRQ3LxqYMV4Sr8xc+eetAHzPfE15xqsqV+V0go2s3
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3423:b0:6a1:5c34:63c5 with SMTP id
 n35-20020a056602342300b006a15c3463c5mr10388746ioz.98.1664894439581; Tue, 04
 Oct 2022 07:40:39 -0700 (PDT)
Date:   Tue, 04 Oct 2022 07:40:39 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a8efba05ea3671c9@google.com>
Subject: [syzbot] possible deadlock in ext4_map_blocks
From:   syzbot <syzbot+6de5025c31d33047d2a4@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=12f30ccc880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aae2d21e7dd80684
dashboard link: https://syzkaller.appspot.com/bug?extid=6de5025c31d33047d2a4
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/11078f50b80b/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/398e5f1e6c84/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6de5025c31d33047d2a4@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0 Not tainted
------------------------------------------------------
syz-executor.4/20458 is trying to acquire lock:
ffff0000f1608288 (&ei->i_data_sem/2){++++}-{3:3}, at: ext4_map_blocks+0x15c/0xaec fs/ext4/inode.c:568

but task is already holding lock:
ffff0000fe53f208 (&s->s_dquot.dqio_sem){++++}-{3:3}, at: v2_write_dquot+0x54/0xb0 fs/quota/quota_v2.c:354

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&s->s_dquot.dqio_sem){++++}-{3:3}:
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
       v2_read_dquot+0x28/0x64 fs/quota/quota_v2.c:332
       dquot_acquire+0x74/0x23c fs/quota/dquot.c:435
       ext4_acquire_dquot+0xd4/0x11c fs/ext4/super.c:6612
       dqget+0x44c/0x5c0 fs/quota/dquot.c:914
       __dquot_initialize+0x1b8/0x588 fs/quota/dquot.c:1492
       dquot_initialize+0x24/0x34 fs/quota/dquot.c:1550
       ext4_create+0x50/0x26c fs/ext4/namei.c:2789
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11c4 fs/namei.c:3688
       do_filp_open+0xdc/0x1b8 fs/namei.c:3718
       do_sys_openat2+0xb8/0x22c fs/open.c:1313
       do_sys_open fs/open.c:1329 [inline]
       __do_sys_openat fs/open.c:1345 [inline]
       __se_sys_openat fs/open.c:1340 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #1 (&dquot->dq_lock){+.+.}-{3:3}:
       __mutex_lock_common+0xd4/0xca8 kernel/locking/mutex.c:603
       __mutex_lock kernel/locking/mutex.c:747 [inline]
       mutex_lock_nested+0x38/0x44 kernel/locking/mutex.c:799
       dquot_commit+0x34/0x1e4 fs/quota/dquot.c:479
       ext4_write_dquot fs/ext4/super.c:6596 [inline]
       ext4_mark_dquot_dirty+0xdc/0x148 fs/ext4/super.c:6644
       mark_dquot_dirty fs/quota/dquot.c:346 [inline]
       mark_all_dquot_dirty fs/quota/dquot.c:384 [inline]
       __dquot_alloc_space+0x2a8/0x644 fs/quota/dquot.c:1722
       dquot_alloc_space_nodirty include/linux/quotaops.h:300 [inline]
       dquot_alloc_space include/linux/quotaops.h:313 [inline]
       dquot_alloc_block include/linux/quotaops.h:337 [inline]
       ext4_mb_new_blocks+0x5fc/0x9e4 fs/ext4/mballoc.c:5574
       ext4_ext_map_blocks+0x7d8/0x10a0 fs/ext4/extents.c:4285
       ext4_map_blocks+0x4a8/0xaec fs/ext4/inode.c:645
       _ext4_get_block+0xb4/0x248 fs/ext4/inode.c:802
       ext4_get_block+0x4c/0x60 fs/ext4/inode.c:819
       __block_write_begin_int+0x240/0x95c fs/buffer.c:2006
       __block_write_begin+0x5c/0xe4 fs/buffer.c:2056
       ext4_convert_inline_data_to_extent+0x2ec/0xa70
       ext4_try_to_write_inline_data+0x80/0x328 fs/ext4/inline.c:734
       ext4_write_begin+0xbc/0xc38 fs/ext4/inode.c:1172
       ext4_da_write_begin+0x1ac/0x4d0 fs/ext4/inode.c:2972
       generic_perform_write+0xf0/0x2cc mm/filemap.c:3738
       ext4_buffered_write_iter+0x15c/0x294 fs/ext4/file.c:270
       ext4_file_write_iter+0x544/0xc6c
       do_iter_write+0x318/0x560 fs/read_write.c:855
       vfs_writev fs/read_write.c:928 [inline]
       do_pwritev+0x130/0x1e8 fs/read_write.c:1025
       __do_sys_pwritev2 fs/read_write.c:1084 [inline]
       __se_sys_pwritev2 fs/read_write.c:1075 [inline]
       __arm64_sys_pwritev2+0x5c/0x90 fs/read_write.c:1075
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

-> #0 (&ei->i_data_sem/2){++++}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3095 [inline]
       check_prevs_add kernel/locking/lockdep.c:3214 [inline]
       validate_chain kernel/locking/lockdep.c:3829 [inline]
       __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
       lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
       down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
       ext4_map_blocks+0x15c/0xaec fs/ext4/inode.c:568
       ext4_getblk+0xc4/0x448 fs/ext4/inode.c:858
       ext4_bread+0x3c/0x164 fs/ext4/inode.c:914
       ext4_quota_write+0x120/0x31c fs/ext4/super.c:6956
       write_blk fs/quota/quota_tree.c:64 [inline]
       get_free_dqblk+0xec/0x1a0 fs/quota/quota_tree.c:93
       do_insert_tree+0xdc/0x838 fs/quota/quota_tree.c:300
       do_insert_tree+0x24c/0x838 fs/quota/quota_tree.c:331
       do_insert_tree+0x24c/0x838 fs/quota/quota_tree.c:331
       do_insert_tree+0x24c/0x838 fs/quota/quota_tree.c:331
       dq_insert_tree fs/quota/quota_tree.c:357 [inline]
       qtree_write_dquot+0x188/0x204 fs/quota/quota_tree.c:376
       v2_write_dquot+0x70/0xb0 fs/quota/quota_v2.c:358
       dquot_acquire+0x158/0x23c fs/quota/dquot.c:444
       ext4_acquire_dquot+0xd4/0x11c fs/ext4/super.c:6612
       dqget+0x44c/0x5c0 fs/quota/dquot.c:914
       __dquot_initialize+0x1b8/0x588 fs/quota/dquot.c:1492
       dquot_initialize+0x24/0x34 fs/quota/dquot.c:1550
       ext4_create+0x50/0x26c fs/ext4/namei.c:2789
       lookup_open fs/namei.c:3413 [inline]
       open_last_lookups fs/namei.c:3481 [inline]
       path_openat+0x804/0x11c4 fs/namei.c:3688
       do_filp_open+0xdc/0x1b8 fs/namei.c:3718
       do_sys_openat2+0xb8/0x22c fs/open.c:1313
       do_sys_open fs/open.c:1329 [inline]
       __do_sys_openat fs/open.c:1345 [inline]
       __se_sys_openat fs/open.c:1340 [inline]
       __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
       __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
       invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
       el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
       do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
       el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
       el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
       el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581

other info that might help us debug this:

Chain exists of:
  &ei->i_data_sem/2 --> &dquot->dq_lock --> &s->s_dquot.dqio_sem

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&s->s_dquot.dqio_sem);
                               lock(&dquot->dq_lock);
                               lock(&s->s_dquot.dqio_sem);
  lock(&ei->i_data_sem/2);

 *** DEADLOCK ***

4 locks held by syz-executor.4/20458:
 #0: ffff0000fe53f460 (sb_writers#3){.+.+}-{0:0}, at: mnt_want_write+0x20/0x64 fs/namespace.c:393
 #1: ffff0000c74dd080 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: inode_lock include/linux/fs.h:756 [inline]
 #1: ffff0000c74dd080 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: open_last_lookups fs/namei.c:3478 [inline]
 #1: ffff0000c74dd080 (&type->i_mutex_dir_key#3){++++}-{3:3}, at: path_openat+0x2f4/0x11c4 fs/namei.c:3688
 #2: ffff0000f1420e28 (&dquot->dq_lock){+.+.}-{3:3}, at: dquot_acquire+0x38/0x23c fs/quota/dquot.c:432
 #3: ffff0000fe53f208 (&s->s_dquot.dqio_sem){++++}-{3:3}, at: v2_write_dquot+0x54/0xb0 fs/quota/quota_v2.c:354

stack backtrace:
CPU: 0 PID: 20458 Comm: syz-executor.4 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
Call trace:
 dump_backtrace+0x1c4/0x1f0 arch/arm64/kernel/stacktrace.c:156
 show_stack+0x2c/0x54 arch/arm64/kernel/stacktrace.c:163
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x104/0x16c lib/dump_stack.c:106
 dump_stack+0x1c/0x58 lib/dump_stack.c:113
 print_circular_bug+0x2c4/0x2c8 kernel/locking/lockdep.c:2053
 check_noncircular+0x14c/0x154 kernel/locking/lockdep.c:2175
 check_prev_add kernel/locking/lockdep.c:3095 [inline]
 check_prevs_add kernel/locking/lockdep.c:3214 [inline]
 validate_chain kernel/locking/lockdep.c:3829 [inline]
 __lock_acquire+0x1530/0x30a4 kernel/locking/lockdep.c:5053
 lock_acquire+0x100/0x1f8 kernel/locking/lockdep.c:5666
 down_read+0x5c/0x78 kernel/locking/rwsem.c:1499
 ext4_map_blocks+0x15c/0xaec fs/ext4/inode.c:568
 ext4_getblk+0xc4/0x448 fs/ext4/inode.c:858
 ext4_bread+0x3c/0x164 fs/ext4/inode.c:914
 ext4_quota_write+0x120/0x31c fs/ext4/super.c:6956
 write_blk fs/quota/quota_tree.c:64 [inline]
 get_free_dqblk+0xec/0x1a0 fs/quota/quota_tree.c:93
 do_insert_tree+0xdc/0x838 fs/quota/quota_tree.c:300
 do_insert_tree+0x24c/0x838 fs/quota/quota_tree.c:331
 do_insert_tree+0x24c/0x838 fs/quota/quota_tree.c:331
 do_insert_tree+0x24c/0x838 fs/quota/quota_tree.c:331
 dq_insert_tree fs/quota/quota_tree.c:357 [inline]
 qtree_write_dquot+0x188/0x204 fs/quota/quota_tree.c:376
 v2_write_dquot+0x70/0xb0 fs/quota/quota_v2.c:358
 dquot_acquire+0x158/0x23c fs/quota/dquot.c:444
 ext4_acquire_dquot+0xd4/0x11c fs/ext4/super.c:6612
 dqget+0x44c/0x5c0 fs/quota/dquot.c:914
 __dquot_initialize+0x1b8/0x588 fs/quota/dquot.c:1492
 dquot_initialize+0x24/0x34 fs/quota/dquot.c:1550
 ext4_create+0x50/0x26c fs/ext4/namei.c:2789
 lookup_open fs/namei.c:3413 [inline]
 open_last_lookups fs/namei.c:3481 [inline]
 path_openat+0x804/0x11c4 fs/namei.c:3688
 do_filp_open+0xdc/0x1b8 fs/namei.c:3718
 do_sys_openat2+0xb8/0x22c fs/open.c:1313
 do_sys_open fs/open.c:1329 [inline]
 __do_sys_openat fs/open.c:1345 [inline]
 __se_sys_openat fs/open.c:1340 [inline]
 __arm64_sys_openat+0xb0/0xe0 fs/open.c:1340
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
