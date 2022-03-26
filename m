Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0DE54E81C8
	for <lists+linux-ext4@lfdr.de>; Sat, 26 Mar 2022 16:32:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233581AbiCZPZ5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 26 Mar 2022 11:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233568AbiCZPZ4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 26 Mar 2022 11:25:56 -0400
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84C281788E1
        for <linux-ext4@vger.kernel.org>; Sat, 26 Mar 2022 08:24:19 -0700 (PDT)
Received: by mail-il1-f199.google.com with SMTP id z14-20020a92d6ce000000b002c993540ee1so811905ilp.0
        for <linux-ext4@vger.kernel.org>; Sat, 26 Mar 2022 08:24:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ehHlyDD1Ax9d6dBcDvspX/anqL9VjAX13Tn0MVg1m4o=;
        b=oSwF5sq2hTA5/2bITzw1tki6JKKP+B6o/xzoNJEwdBIw6Bjddnmg4SA+x0/SgymunP
         GRMVidQjnNUUdgL4XMw+GbNbydP68LGw0d2pZnAsD5ysDGfJxquoY5Hf99iQ8qgCDJk0
         P5boJdZqSgcJW9P61bVGKp42eVeDBx4FuIk9b19zO6rn0KxJ3Td3vC5n/Tbn9ecq1Ypq
         aFvg1HO48XwKYE5aS0gs1266d7zfGZ3i8TvjFwimacZtqypB0xnRZZur8fikKE3MPSji
         Bw28eKgQVmvb3UZERGawGCfser3MraFz1xXce8pb71EPLh2fjmSxTcvAf3g2q4W3zuUM
         Nsmw==
X-Gm-Message-State: AOAM533T6K+yTma72Aur2zipvFFm5C3w39nQVnhsNpZr55qgxEMfpoSv
        HRWpIVfm16XYHrjEcBax/GoUaE3n3MfhKPPh5peKaH2fwvMc
X-Google-Smtp-Source: ABdhPJyckeL0JxPJvjKNb41SRwKUGr3V1jKKpzrPvf6W/hHjgV2c5cTRf8b7t0O13CRLSepXS5luiCAiTNgZc17RHAB95xwO5Z9d
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2401:b0:31a:1f1a:3523 with SMTP id
 z1-20020a056638240100b0031a1f1a3523mr8762165jat.249.1648308258843; Sat, 26
 Mar 2022 08:24:18 -0700 (PDT)
Date:   Sat, 26 Mar 2022 08:24:18 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003fb2e905db20ac96@google.com>
Subject: [syzbot] WARNING in ext4_dirty_folio
From:   syzbot <syzbot+ecab51a4a5b9f26eeaa1@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    34af78c4e616 Merge tag 'iommu-updates-v5.18' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=176c1bb3700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6190c85675271e4a
dashboard link: https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ecab51a4a5b9f26eeaa1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 7386 at fs/ext4/inode.c:3600 ext4_dirty_folio+0xf4/0x120 fs/ext4/inode.c:3600
Modules linked in:
CPU: 1 PID: 7386 Comm: syz-executor.1 Tainted: G        W         5.17.0-syzkaller-09727-g34af78c4e616 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_dirty_folio+0xf4/0x120 fs/ext4/inode.c:3600
Code: 1b 31 ff 48 c1 eb 03 83 e3 01 89 de e8 25 c5 5d ff 84 db 0f 85 72 ff ff ff e8 38 c1 5d ff 0f 0b e9 66 ff ff ff e8 2c c1 5d ff <0f> 0b eb 88 48 89 df e8 a0 62 a9 ff e9 3d ff ff ff e8 96 62 a9 ff
RSP: 0018:ffffc90004dc7a48 EFLAGS: 00010246
RAX: 0000000000040000 RBX: 0000000000000001 RCX: ffffc9000c2b5000
RDX: 0000000000040000 RSI: ffffffff821b50c4 RDI: ffffea00018ac0a8
RBP: ffffea00018ac080 R08: 0000000000000000 R09: 0000000000000001
R10: ffffffff821b5021 R11: 0000000000000000 R12: ffff888044c34b10
R13: dffffc0000000000 R14: ffffea00018ac000 R15: ffffea00018ac080
FS:  00007f35859cb700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000200001c0 CR3: 000000001ceb7000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 folio_mark_dirty+0xc1/0x140 mm/page-writeback.c:2632
 unpin_user_pages_dirty_lock mm/gup.c:299 [inline]
 unpin_user_pages_dirty_lock+0x404/0x4c0 mm/gup.c:263
 process_vm_rw_single_vec mm/process_vm_access.c:126 [inline]
 process_vm_rw_core.constprop.0+0x7bb/0x990 mm/process_vm_access.c:215
 process_vm_rw+0x29c/0x300 mm/process_vm_access.c:283
 __do_sys_process_vm_writev mm/process_vm_access.c:303 [inline]
 __se_sys_process_vm_writev mm/process_vm_access.c:298 [inline]
 __x64_sys_process_vm_writev+0xdf/0x1b0 mm/process_vm_access.c:298
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f3584889049
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35859cb168 EFLAGS: 00000246 ORIG_RAX: 0000000000000137
RAX: ffffffffffffffda RBX: 00007f358499c030 RCX: 00007f3584889049
RDX: 0000000000000001 RSI: 0000000020c22000 RDI: 000000000000012e
RBP: 00007f35848e308d R08: 0000000000000001 R09: 0000000000000000
R10: 0000000020c22fa0 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffeca831cef R14: 00007f35859cb300 R15: 0000000000022000
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
