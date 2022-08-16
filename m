Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE8E59589C
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Aug 2022 12:39:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234926AbiHPKjO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Aug 2022 06:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbiHPKi4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Aug 2022 06:38:56 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA37DA463
        for <linux-ext4@vger.kernel.org>; Tue, 16 Aug 2022 01:42:25 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id f4-20020a5d8784000000b00684f917b026so5560362ion.12
        for <linux-ext4@vger.kernel.org>; Tue, 16 Aug 2022 01:42:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc;
        bh=dwmvJf4EgEnwBidyybsf7yv6kRRFLPIA27vvnskiIhE=;
        b=i+EQ7HkDjDqfqHgCm9bIIH8dG8Bo60EPXlsKzatW5WcBAySYUhyHbvPmVjyU+xcSFA
         mLOFSW36vV6EuwjSmUhno4oGHpHCujlCLGEBTvElUAtHwRMg6ENlsQB/UvB3af8o3lUW
         OhaBBPeeI2n9QvTKxYvLzZ4AqZh9eLn5JxKixHWjAvnRpbpwGEDFE100lYudMcFPucvS
         aRyviiD+aZ2D7m11N7Ygw+5FlNqtcQzg5fjWxAoieydiE820mt/SGfKYZthMPzySh1k/
         htnVeNvIDQ7+9PC0Jrt2QE3xTgiaVeJ74JPu4AvGzBWIdWAXveda3ZQ44u+aBzeqO5OV
         7+Fg==
X-Gm-Message-State: ACgBeo3p1Bi4i4DmCIW4Q9XmOYrCLRR5qzzlE8cBXJoJayLpSK+nawYG
        TpJ2CzMsQUSkd9UvMfEcV4zYKUHJRFeWdgxILV8IeeCq1dOs
X-Google-Smtp-Source: AA6agR7jjDPJUdk8sEqPjPKRJSOyW1xg7jn+o/f7DD5m8Uygk+/FhA9SCsaoa1U29c8HQCuwChnNG5hcmwnyle411BwKHzZ3dmgL
MIME-Version: 1.0
X-Received: by 2002:a92:c984:0:b0:2dd:eacf:da3c with SMTP id
 y4-20020a92c984000000b002ddeacfda3cmr8907868iln.245.1660639345372; Tue, 16
 Aug 2022 01:42:25 -0700 (PDT)
Date:   Tue, 16 Aug 2022 01:42:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000047f3c405e657bae5@google.com>
Subject: [syzbot] upstream boot error: BUG: unable to handle kernel paging
 request in ext4_get_group_desc
From:   syzbot <syzbot+5a9aafd202006e109827@syzkaller.appspotmail.com>
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

HEAD commit:    6c833c0581f1 Merge tag 'devicetree-fixes-for-6.0-1' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=114179dd080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ffbab52ef9fab60
dashboard link: https://syzkaller.appspot.com/bug?extid=5a9aafd202006e109827
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5a9aafd202006e109827@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffffdc0000000005
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 11826067 P4D 11826067 PUD 0 
Oops: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3268 Comm: S50sshd Not tainted 5.19.0-syzkaller-14135-g6c833c0581f1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:ext4_get_group_desc+0x231/0x500 fs/ext4/balloc.c:299
Code: 8b e8 e3 12 4d ff 4d 85 e4 0f 84 3d 02 00 00 e8 35 ab 69 ff 49 8d 7c 24 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 86 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89
RSP: 0018:ffffc900033ff4d8 EFLAGS: 00010a06
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 1fffe00000000005 RSI: ffffffff82118a8b RDI: ffff000000000028
RBP: ffff88801dd4c000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff000000000000
R13: 0000000000000000 R14: ffff88801dd4c678 R15: 0000000000000001
FS:  00007f116a35e800(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000005 CR3: 0000000020f64000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __ext4_get_inode_loc+0x1c9/0x11a0 fs/ext4/inode.c:4459
 ext4_get_inode_loc+0xba/0x160 fs/ext4/inode.c:4600
 ext4_xattr_ibody_get+0xe4/0x4a0 fs/ext4/xattr.c:602
 ext4_xattr_get+0x166/0x740 fs/ext4/xattr.c:666
 vfs_getxattr_alloc+0x1bc/0x350 fs/xattr.c:384
 ima_read_xattr+0x31/0x70 security/integrity/ima/ima_appraise.c:228
 process_measurement+0xca2/0x18b0 security/integrity/ima/ima_main.c:319
 ima_bprm_check+0xd0/0x220 security/integrity/ima/ima_main.c:492
 security_bprm_check+0x7d/0xa0 security/security.c:870
 search_binary_handler fs/exec.c:1719 [inline]
 exec_binprm fs/exec.c:1772 [inline]
 bprm_execve fs/exec.c:1841 [inline]
 bprm_execve+0x732/0x1960 fs/exec.c:1803
 do_execveat_common+0x727/0x890 fs/exec.c:1946
 do_execve fs/exec.c:2020 [inline]
 __do_sys_execve fs/exec.c:2096 [inline]
 __se_sys_execve fs/exec.c:2091 [inline]
 __x64_sys_execve+0x8f/0xc0 fs/exec.c:2091
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7f116a4c8337
Code: ff ff 76 e7 f7 d8 64 41 89 00 eb df 0f 1f 80 00 00 00 00 f7 d8 64 41 89 00 eb dc 0f 1f 84 00 00 00 00 00 b8 3b 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 11 1b 0f 00 f7 d8 64 89 01 48
RSP: 002b:00007ffe54ebe008 EFLAGS: 00000206 ORIG_RAX: 000000000000003b
RAX: ffffffffffffffda RBX: 0000564f4f1c5e70 RCX: 00007f116a4c8337
RDX: 0000564f4f1c5e88 RSI: 0000564f4f1c5e70 RDI: 0000564f4f1c5e28
RBP: 0000564f4f1c5e28 R08: 0000564f4f1c5e88 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000206 R12: 0000564f4f1c5e88
R13: 00007f116a66dff4 R14: 0000564f4f1c5e88 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffffdc0000000005
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_get_group_desc+0x231/0x500 fs/ext4/balloc.c:299
Code: 8b e8 e3 12 4d ff 4d 85 e4 0f 84 3d 02 00 00 e8 35 ab 69 ff 49 8d 7c 24 28 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 86 02 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89
RSP: 0018:ffffc900033ff4d8 EFLAGS: 00010a06

RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 1fffe00000000005 RSI: ffffffff82118a8b RDI: ffff000000000028
RBP: ffff88801dd4c000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff000000000000
R13: 0000000000000000 R14: ffff88801dd4c678 R15: 0000000000000001
FS:  00007f116a35e800(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffdc0000000005 CR3: 0000000020f64000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b e8                	mov    %eax,%ebp
   2:	e3 12                	jrcxz  0x16
   4:	4d ff 4d 85          	rex.WRB decq -0x7b(%r13)
   8:	e4 0f                	in     $0xf,%al
   a:	84 3d 02 00 00 e8    	test   %bh,-0x17fffffe(%rip)        # 0xe8000012
  10:	35 ab 69 ff 49       	xor    $0x49ff69ab,%eax
  15:	8d 7c 24 28          	lea    0x28(%rsp),%edi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 86 02 00 00    	jne    0x2ba
  34:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  3b:	fc ff df
  3e:	4c                   	rex.WR
  3f:	89                   	.byte 0x89


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
