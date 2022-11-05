Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C6261DBE3
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Nov 2022 17:07:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229899AbiKEQHz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Nov 2022 12:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbiKEQHy (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Nov 2022 12:07:54 -0400
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82C9410073
        for <linux-ext4@vger.kernel.org>; Sat,  5 Nov 2022 09:07:53 -0700 (PDT)
Received: by mail-il1-f197.google.com with SMTP id j7-20020a056e02154700b003007885e7beso5848699ilu.20
        for <linux-ext4@vger.kernel.org>; Sat, 05 Nov 2022 09:07:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P26Tufb5libRVNtGMj36dstv5Fz34ZnElPMtb6a0Uhg=;
        b=eXX1w1XRMRJVOoqOjnv3Lf41U+pKtns5+rLunPsPoWlvBBeD9Mrf+Pd6GQkmEEDYQz
         hoeBkkkBAh/GS3WIS+bYT25HWssYgOA1qhh+nt/L6hqMtJYyeRvY7L1aara2GLUToNOl
         IFJb7kVW+RBxKzVWhR0Z7nsz1liUbdt/NuJ0JSYBC0DJ8RosHw7VB0tupjyJ8EX1onc6
         ndbTZv19l73UdgEIB9PrPM4f33AD92U/YwgXVqdIc8cIZD5+PP23bEmgJUWY5ccIbSmi
         MXTqZ8VeaSen0QDGch1EP/MYk2QSSAlyBfm7HQSzRbAkgH13/3PHu9dZ6qa4mPSEouJH
         GWgQ==
X-Gm-Message-State: ACrzQf0WBiWTybX2wWXdrzbgNz+4xFJuVBIqSWo24EiJme2yagUcinbg
        w9vmC7cd5j5XKqVRtTd7fqa13vSOBBK/W3T8bPHeiqC3z6ul
X-Google-Smtp-Source: AMsMyM7lzq/wnhZ5p4mooUUvzr2G8b1Tq6lQpd394TA+Q9lfRqzxbCflqbEUFzamGIu7GMPo/cN1i+qiUBA0Md2c2SYELM6iIYft
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1210:b0:375:4aa6:ff85 with SMTP id
 n16-20020a056638121000b003754aa6ff85mr21924002jas.227.1667664472862; Sat, 05
 Nov 2022 09:07:52 -0700 (PDT)
Date:   Sat, 05 Nov 2022 09:07:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000082754e05ecbb641e@google.com>
Subject: [syzbot] WARNING in ext4_enable_quotas
From:   syzbot <syzbot+77524f55898ea618bfad@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        nathan@kernel.org, ndesaulniers@google.com,
        syzkaller-bugs@googlegroups.com, trix@redhat.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    bbed346d5a96 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14db1719880000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a4a45d2d827c1e
dashboard link: https://syzkaller.appspot.com/bug?extid=77524f55898ea618bfad
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e8e91bc79312/disk-bbed346d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c1cb3fb3b77e/vmlinux-bbed346d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+77524f55898ea618bfad@syzkaller.appspotmail.com

EXT4-fs (loop1): orphan cleanup on readonly fs
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(!key)
WARNING: CPU: 1 PID: 14778 at kernel/locking/lockdep.c:4831 lockdep_init_map_type+0x284/0x2fc kernel/locking/lockdep.c:4831
Modules linked in:
CPU: 1 PID: 14778 Comm: syz-executor.1 Not tainted 6.0.0-rc7-syzkaller-18095-gbbed346d5a96 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/30/2022
pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : lockdep_init_map_type+0x284/0x2fc kernel/locking/lockdep.c:4831
lr : lockdep_init_map_type+0x284/0x2fc kernel/locking/lockdep.c:4831
sp : ffff800013533980
x29: ffff800013533990 x28: ffff80000cb99126 x27: ffff8000135339c4
x26: ffff0001156798e0 x25: ffff000115679908 x24: 0000000000000001
x23: ffff8000135339d0 x22: ffff80000ee2b000 x21: 0000000000000000
x20: 0000000000000002 x19: ffff0001156798e0 x18: 000000000000034b
x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000012 x12: 0000000000040000
x11: 000000000001b6e9 x10: ffff80001b6ed000 x9 : 3b94ef2414331b00
x8 : 3b94ef2414331b00 x7 : 4e5241575f534b43 x6 : ffff80000819545c
x5 : 0000000000000000 x4 : 0000000000000001 x3 : 0000000000000000
x2 : 0000000000000000 x1 : 0000000100000000 x0 : 0000000000000019
Call trace:
 lockdep_init_map_type+0x284/0x2fc kernel/locking/lockdep.c:4831
 lockdep_set_quota_inode fs/ext4/super.c:6677 [inline]
 ext4_quota_enable fs/ext4/super.c:6787 [inline]
 ext4_enable_quotas+0x1ac/0x378 fs/ext4/super.c:6814
 ext4_orphan_cleanup+0x23c/0x8ec fs/ext4/orphan.c:432
 __ext4_fill_super+0x34a4/0x36d4 fs/ext4/super.c:5378
 ext4_fill_super+0x100/0x2d8 fs/ext4/super.c:5517
 get_tree_bdev+0x1e8/0x2a0 fs/super.c:1323
 ext4_get_tree+0x28/0x38 fs/ext4/super.c:5547
 vfs_get_tree+0x40/0x140 fs/super.c:1530
 do_new_mount+0x1dc/0x4e4 fs/namespace.c:3040
 path_mount+0x358/0x914 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __arm64_sys_mount+0x2c4/0x3c4 fs/namespace.c:3568
 __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
 invoke_syscall arch/arm64/kernel/syscall.c:52 [inline]
 el0_svc_common+0x138/0x220 arch/arm64/kernel/syscall.c:142
 do_el0_svc+0x48/0x164 arch/arm64/kernel/syscall.c:206
 el0_svc+0x58/0x150 arch/arm64/kernel/entry-common.c:636
 el0t_64_sync_handler+0x84/0xf0 arch/arm64/kernel/entry-common.c:654
 el0t_64_sync+0x18c/0x190 arch/arm64/kernel/entry.S:581
irq event stamp: 977
hardirqs last  enabled at (977): [<ffff800008161dac>] raw_spin_rq_unlock_irq kernel/sched/sched.h:1367 [inline]
hardirqs last  enabled at (977): [<ffff800008161dac>] finish_lock_switch+0x94/0xe8 kernel/sched/core.c:4942
hardirqs last disabled at (976): [<ffff80000bfc0a34>] __schedule+0x84/0x5a0 kernel/sched/core.c:6393
softirqs last  enabled at (200): [<ffff80000801c33c>] local_bh_enable+0x10/0x34 include/linux/bottom_half.h:32
softirqs last disabled at (198): [<ffff80000801c308>] local_bh_disable+0x10/0x34 include/linux/bottom_half.h:19
---[ end trace 0000000000000000 ]---
EXT4-fs warning (device loop1): ext4_enable_quotas:6821: Failed to enable quota tracking (type=0, err=-13). Please run e2fsck to fix.
EXT4-fs (loop1): Cannot turn on quotas: error -13
EXT4-fs error (device loop1): ext4_orphan_get:1419: comm syz-executor.1: bad orphan inode 11
EXT4-fs (loop1): Remounting filesystem read-only
ext4_test_bit(bit=10, block=3) = 0
EXT4-fs (loop1): mounted filesystem without journal. Quota mode: writeback.


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
