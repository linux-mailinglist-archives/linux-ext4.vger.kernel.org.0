Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5707F1F0B0C
	for <lists+linux-ext4@lfdr.de>; Sun,  7 Jun 2020 14:03:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725886AbgFGMDT (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 7 Jun 2020 08:03:19 -0400
Received: from mail-il1-f199.google.com ([209.85.166.199]:35480 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbgFGMDT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 7 Jun 2020 08:03:19 -0400
Received: by mail-il1-f199.google.com with SMTP id a4so9982568ilq.2
        for <linux-ext4@vger.kernel.org>; Sun, 07 Jun 2020 05:03:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LwmS02Wlb0NnV55+lsR7tpUbRWv1SSOP95Em+xpAvzA=;
        b=MsPHKME1UUADcaVKnIifqWzs+8wYHbNBUjLpr4EZN8kXwFSVdzLOXlTLLdxC4c7zOk
         NCK0cCUyhbg90J5qeY4S0uaalR6LtbZdwK+UBWEGQnsOo65IT0UEo0CwV/0yGP30LAzP
         v9auTK+C1Eu456GAQp2Y6RcwR8ukqgERHSD34lKv2J2OZoNWOZSad8ifcqGX9jMNRCIo
         xNr8SP1ett7iWGMXjPa9IVCz6unXgbrNXo1gap9UYsXmak3tS2/t2TVh7QZN61mMlzua
         ljGVxxQNGA1lPo/CuKmSwbUWOrDPlT6NbFAVSPRHO6nVSQTosW48DAnGiktu8a5HHAmU
         aCpA==
X-Gm-Message-State: AOAM530wA9n4Wv4+x9Z2/ozXvY5890r9NuuhtV52dDbeAk/6Ien4h5KT
        EIV5226nfiwPf0I+bEoED5mbd8KgHjyzrcWIXh2r3zVrkJ24
X-Google-Smtp-Source: ABdhPJzdfQagu9v+gJh2CU+shree7b3tGfL8R5L38284jwzSuTtx4MFro8jyubjE/vdTypbMfpkE/kdpWWh/JN4VQNRwIdZK2mwN
MIME-Version: 1.0
X-Received: by 2002:a02:952f:: with SMTP id y44mr17257602jah.128.1591531398058;
 Sun, 07 Jun 2020 05:03:18 -0700 (PDT)
Date:   Sun, 07 Jun 2020 05:03:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a1595c05a77d47c4@google.com>
Subject: linux-next test error: BUG: using smp_processor_id() in preemptible
 code in ext4_mb_new_blocks
From:   syzbot <syzbot+f72682b02970a74a7858@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-next@vger.kernel.org,
        sfr@canb.auug.org.au, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    af30725c Add linux-next specific files for 20200605
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=126f99a6100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=579d800cf0c74ef
dashboard link: https://syzkaller.appspot.com/bug?extid=f72682b02970a74a7858
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+f72682b02970a74a7858@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: systemd-rfkill/6769
caller is ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
CPU: 1 PID: 6769 Comm: systemd-rfkill Not tainted 5.7.0-next-20200605-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x18f/0x20d lib/dump_stack.c:118
 check_preemption_disabled+0x20d/0x220 lib/smp_processor_id.c:48
 ext4_mb_new_blocks+0xa4d/0x3b70 fs/ext4/mballoc.c:4711
 ext4_ext_map_blocks+0x201b/0x33e0 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 ext4_getblk+0xad/0x520 fs/ext4/inode.c:833
 ext4_bread+0x7c/0x380 fs/ext4/inode.c:883
 ext4_append+0x153/0x360 fs/ext4/namei.c:67
 ext4_init_new_dir fs/ext4/namei.c:2757 [inline]
 ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2802
 vfs_mkdir+0x419/0x690 fs/namei.c:3632
 do_mkdirat+0x21e/0x280 fs/namei.c:3655
 do_syscall_64+0x60/0xe0 arch/x86/entry/common.c:359
 entry_SYSCALL_64_after_hwframe+0x44/0xa9
RIP: 0033:0x7f6d60012687
Code: Bad RIP value.
RSP: 002b:00007ffd286d9ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 000055f82bd8d985 RCX: 00007f6d60012687
RDX: 00007ffd286d9b70 RSI: 00000000000001ed RDI: 000055f82bd8d985
RBP: 00007f6d60012680 R08: 0000000000000100 R09: 0000000000000000
R10: 000055f82bd8d980 R11: 0000000000000246 R12: 00000000000001ed
R13: 00007ffd286d9e30 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
