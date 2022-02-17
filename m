Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACA14BAA07
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Feb 2022 20:43:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239204AbiBQTmh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Feb 2022 14:42:37 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233736AbiBQTmg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Feb 2022 14:42:36 -0500
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D35C41FB4
        for <linux-ext4@vger.kernel.org>; Thu, 17 Feb 2022 11:42:20 -0800 (PST)
Received: by mail-il1-f200.google.com with SMTP id g15-20020a92520f000000b002bec6a02012so2588992ilb.18
        for <linux-ext4@vger.kernel.org>; Thu, 17 Feb 2022 11:42:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=oHZ6M7Lv0xuBWWdM74RtqU4sI7szp5blC1rto5K947I=;
        b=S2t4TyNYj8cynH5bgAG810XlawMX0KzA/AnkkMo9sPM+Ot47ZTWwqecKZ1h9rMhqSG
         VMW4RzDUFoDfHUnYu3P10zc7FIegUIvlN71b0/C/G1mY+rrHm07NOXzFNTaNHjUc3lHW
         rro3tXw97dfrztvOwMU+5rrcsYNR4XV4UUPLaDo9W9Oh/yUyNgjAILfIXPcejDuYF3EV
         GZJi6SExQioKxoymbDop72JlKtozIm7iK54xJSfaTmJgucovSHyMZbz0Y8TYhqlNk/Rb
         Y99vWMGjF+Q0sV6VZN/fxdEdw1im82oI/nZfWTNjcyiCC8ZO/QErf2CqShDu7X4QZ41P
         6tiw==
X-Gm-Message-State: AOAM531/iGMVDLm05ZTHEFtlpkHPbih2VCEXU3RUUFDg4jN33Ai38aTK
        oMqMfKmham/qld/uWJu8ZwoVBCXCW70VMWQdkxKNUbymeMqf
X-Google-Smtp-Source: ABdhPJz80SQnywFdQpEy2KPPfyvmcjGVpbH06ipurJKOMxu+9rhn0L8anGUqkCCss4kOZoABcZfafMgtuGZ9h3hRhpmWPTg4bSZD
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:54e:b0:2be:8108:c0dc with SMTP id
 i14-20020a056e02054e00b002be8108c0dcmr3083780ils.65.1645126939755; Thu, 17
 Feb 2022 11:42:19 -0800 (PST)
Date:   Thu, 17 Feb 2022 11:42:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000daca5605d83bf62b@google.com>
Subject: [syzbot] WARNING in ext4_evict_inode (3)
From:   syzbot <syzbot+8c7921ce857a731af281@syzkaller.appspotmail.com>
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

HEAD commit:    42964a18f81c Merge tag 'objtool_urgent_for_v5.17_rc4' of g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1008ed74700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5707221760c00a20
dashboard link: https://syzkaller.appspot.com/bug?extid=8c7921ce857a731af281
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8c7921ce857a731af281@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 3682 at fs/ext4/inode.c:231 ext4_evict_inode+0xf9a/0x1950 fs/ext4/inode.c:231
Modules linked in:
CPU: 2 PID: 3682 Comm: syz-executor.2 Not tainted 5.17.0-rc3-syzkaller-00329-g42964a18f81c #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
RIP: 0010:ext4_evict_inode+0xf9a/0x1950 fs/ext4/inode.c:231
Code: 28 41 bc 01 00 00 00 48 89 04 24 e9 62 f6 ff ff c7 44 24 24 06 00 00 00 c7 44 24 20 06 00 00 00 e9 e1 f6 ff ff e8 36 25 63 ff <0f> 0b e9 c8 f5 ff ff e8 fa 23 aa ff e9 60 f1 ff ff 48 89 cf e8 ed
RSP: 0018:ffffc9000276fc98 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 1ffff920004edf99 RCX: 0000000000000000
RDX: ffff88805e45e2c0 RSI: ffffffff8214ddea RDI: 0000000000000003
RBP: ffff8880235bf6a0 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffff8214d3b0 R11: 0000000000000000 R12: 0000000000000000
R13: 0000000000000001 R14: ffff88801acac830 R15: ffff888026d92728
FS:  00005555566dc400(0000) GS:ffff88802cb00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555565fb708 CR3: 000000005e443000 CR4: 0000000000150ee0
Call Trace:
 <TASK>
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 do_unlinkat+0x418/0x650 fs/namei.c:4225
 __do_sys_unlink fs/namei.c:4266 [inline]
 __se_sys_unlink fs/namei.c:4264 [inline]
 __x64_sys_unlink+0xc6/0x110 fs/namei.c:4264
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f1762356997
Code: 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 b8 57 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffca9eba208 EFLAGS: 00000206 ORIG_RAX: 0000000000000057
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f1762356997
RDX: 00007ffca9eba240 RSI: 00007ffca9eba240 RDI: 00007ffca9eba2d0
RBP: 00007ffca9eba2d0 R08: 0000000000000001 R09: 00007ffca9eba0a0
R10: 00005555566dd903 R11: 0000000000000206 R12: 00007f17623b01ea
R13: 00007ffca9ebb390 R14: 00005555566dd810 R15: 00007ffca9ebb3d0
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
