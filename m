Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 518AF659511
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Dec 2022 06:47:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229507AbiL3Fq6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 30 Dec 2022 00:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230261AbiL3Fq4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 30 Dec 2022 00:46:56 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00CF13D21
        for <linux-ext4@vger.kernel.org>; Thu, 29 Dec 2022 21:46:54 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id s2-20020a056e02216200b0030bc3be69e5so13022683ilv.20
        for <linux-ext4@vger.kernel.org>; Thu, 29 Dec 2022 21:46:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=p+YVz3neef6XilpEvBTHQcYPDTEwX3CUheAw2p53HLk=;
        b=N6ADmzKIEpQv9ZwYwl13bchES+4BqwvqdPf/F3ACJIaCcmi+fxpJ8xxwl090P3uWnn
         eb2avuunhQWGIEX2hlM5M5SO25R3SolkexPJfpVT7xP2mIzNxl6soq04nHXnavPJjzss
         5VfYoY6vEiNJVmJqvg4C+VbUmyZ7jrPXaMqnL8Ug6mfQKi5IMW0YqSjJTpAw1Po7opQT
         uWg8T4QED7k8ICrq+bgmvkcRgsBMCcuNHZfsqnRB+5NDz+frO8iRmCPULGb/rqvoCiEz
         v5/iWwEXnll9ne8jCLKgHHlKfE4k8a6lvtWRA6skZ1yUA63Qg4mwmHJuwNB8+bpL3sXA
         wnBw==
X-Gm-Message-State: AFqh2kqm3cdHAzl4grtgixNvxi+IFCvDqDg/z4xqDpQO4uHLIPGo43Y+
        7dntXQEcbvIkEddiK405h9GRi4u2EJ/COAPD38gmw692GopB
X-Google-Smtp-Source: AMrXdXtZBc/oIzFhBRyEHR1rJ6rgBRI1dw3E6hzk5yeGLLRhdW1+L+y0lg0wEbR7SfOzGjSdernvOlrjD7HsH1w/I17pdpgaPOTy
MIME-Version: 1.0
X-Received: by 2002:a92:cacd:0:b0:303:6b79:14bb with SMTP id
 m13-20020a92cacd000000b003036b7914bbmr2730358ilq.9.1672379214114; Thu, 29 Dec
 2022 21:46:54 -0800 (PST)
Date:   Thu, 29 Dec 2022 21:46:54 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000fcb8c105f1052058@google.com>
Subject: [syzbot] [ext4?] WARNING in ext4_update_inline_data
From:   syzbot <syzbot+d30838395804afc2fa6f@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    1b929c02afd3 Linux 6.2-rc1
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=10fae73c480000
kernel config:  https://syzkaller.appspot.com/x/.config?x=68e0be42c8ee4bb4
dashboard link: https://syzkaller.appspot.com/bug?extid=d30838395804afc2fa6f
compiler:       Debian clang version 13.0.1-++20220126092033+75e33f71c2da-1~exp1~20220126212112.63, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=119737b0480000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=103322c4480000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d8c5072480f/disk-1b929c02.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/46687f1395db/vmlinux-1b929c02.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26f1afa5ec00/bzImage-1b929c02.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/91c003e7bb4a/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d30838395804afc2fa6f@syzkaller.appspotmail.com

EXT4-fs (loop0): mounted filesystem 00000000-0000-0000-0000-000000000000 without journal. Quota mode: none.
fscrypt: AES-256-CTS-CBC using implementation "cts-cbc-aes-aesni"
fscrypt: AES-256-XTS using implementation "xts-aes-aesni"
------------[ cut here ]------------
WARNING: CPU: 0 PID: 5071 at mm/page_alloc.c:5525 __alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
Modules linked in:
CPU: 1 PID: 5071 Comm: syz-executor263 Not tainted 6.2.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
RIP: 0010:__alloc_pages+0x30a/0x560 mm/page_alloc.c:5525
Code: 5c 24 04 0f 85 f3 00 00 00 44 89 e1 81 e1 7f ff ff ff a9 00 00 04 00 41 0f 44 cc 41 89 cc e9 e3 00 00 00 c6 05 d6 68 ad 0c 01 <0f> 0b 83 fb 0a 0f 86 c8 fd ff ff 31 db 48 c7 44 24 20 0e 36 e0 45
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
RIP: 0033:0x7f95d5d925a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdec99f098 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f95d5d925a9
RDX: 000000000000275a RSI: 0000000020000080 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007f95d5e00ec0 R09: 00007f95d5e00ec0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffdec99f0c0
R13: 0000000000000000 R14: 431bde82d7b634db R15: 0000000000000000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
