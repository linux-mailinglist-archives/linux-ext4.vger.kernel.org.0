Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 553D3F6BE2
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Nov 2019 00:44:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726730AbfKJXoL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Nov 2019 18:44:11 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:37727 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726715AbfKJXoL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Nov 2019 18:44:11 -0500
Received: by mail-il1-f199.google.com with SMTP id q1so1342562ile.4
        for <linux-ext4@vger.kernel.org>; Sun, 10 Nov 2019 15:44:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=mQkvXa5UwiKwX7Ee0D6VQirlDEkappHc40K5MNYp5sw=;
        b=PSGGEBOs+q2Ft7dWmUhO5d5eFHIaWXdpfa3Bp7JvQdb4n0A7faOaPdNwtdMlF5gQHd
         gJlL5bRN3cJatbPn83FaUR8ZZ8ovjNcy56x3VNTU6M2F5HiVSX1Gohm//HDqOuvYOtaA
         zn6RkQsllEutF1ZwmyGt7hl4QznacgToKakGVgouRVo7oaigbREq52YAq5GG3hmwSXH+
         IMTdaIsjIeB1kdcodThkd3FkL7ZJgvTjkG1ALUAenFay8/VyBobaJDEySmKQTputAfS6
         ilZonoRcQXj+pFHQZOPMKQyOTzqCouQgbLZsNHOOO8rRZddK89Qzsu3dH5iBoz/XwcUU
         S3mQ==
X-Gm-Message-State: APjAAAUn1axN2sf4Weu5D63XXHfgWESQyB+/QqIo6Doxq6CruPdDKqN7
        Aw4GRVp9yQKj7YOCWbdQTqpJV+boDRBaikRhV0GgM0HctC+B
X-Google-Smtp-Source: APXvYqx+BIbdaoKD4C5K1UbHnHG7i9QU2I0+3Tx0qR+dwRWdkXXNrj26PIqIbQtxxe2lNzBe3N3ROx6uptaSdt0deXIMz/je2yJe
MIME-Version: 1.0
X-Received: by 2002:a92:1dc6:: with SMTP id g67mr25717512ile.182.1573429450098;
 Sun, 10 Nov 2019 15:44:10 -0800 (PST)
Date:   Sun, 10 Nov 2019 15:44:10 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000073d3a70597069799@google.com>
Subject: general protection fault in ext4_writepages
From:   syzbot <syzbot+9567fda428fba259deba@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, riteshh@linux.ibm.com,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    dcd34bd2 Add linux-next specific files for 20191106
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11a0a4fce00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=742545dcdea21726
dashboard link: https://syzkaller.appspot.com/bug?extid=9567fda428fba259deba
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1645c42ce00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1108a23ae00000

The bug was bisected to:

commit c8cc88163f40df39e50cda63ac361631864b453e
Author: Ritesh Harjani <riteshh@linux.ibm.com>
Date:   Wed Oct 16 07:37:10 2019 +0000

     ext4: Add support for blocksize < pagesize in dioread_nolock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1044c6b4e00000
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1244c6b4e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1444c6b4e00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+9567fda428fba259deba@syzkaller.appspotmail.com
Fixes: c8cc88163f40 ("ext4: Add support for blocksize < pagesize in  
dioread_nolock")

RDX: 0000000000000000 RSI: 0000000100000003 RDI: 0000000000000003
RBP: 0000000000000004 R08: 0000000000000001 R09: 00007fffd7a50033
R10: 0000000028120001 R11: 0000000000000246 R12: 0000000000401ef0
R13: 0000000000401f80 R14: 0000000000000000 R15: 0000000000000000
kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 8639 Comm: syz-executor031 Not tainted 5.4.0-rc6-next-20191106  
#0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
RIP: 0010:mpage_map_and_submit_extent fs/ext4/inode.c:2557 [inline]
RIP: 0010:ext4_writepages+0x17b4/0x2e80 fs/ext4/inode.c:2911
Code: ff ff e8 1f cf b0 ff 48 8b 85 30 fe ff ff 48 8b 8d 00 fe ff ff 48 8d  
78 10 48 89 fa 48 c1 ea 03 0f b6 89 c2 00 00 00 48 d3 e3 <42> 80 3c 2a 00  
0f 85 03 16 00 00 48 89 58 10 48 c7 c0 08 ad c4 89
RSP: 0018:ffff88808bf77890 EFLAGS: 00010206
RAX: fffffffffffffff4 RBX: 00000000007ff000 RCX: 000000000000000c
RDX: 0000000000000000 RSI: ffffffff820534cd RDI: 0000000000000004
RBP: ffff88808bf77ac0 R08: 0000000000000000 R09: ffffed1015d06b7d
R10: ffffed1015d06b7c R11: ffff8880ae835be3 R12: 0000000000000000
R13: dffffc0000000000 R14: 00000000000007ff R15: ffff888086499488
FS:  0000000001162880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000009366b000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  ? 0xffffffff81000000
  do_writepages+0xfa/0x2a0 mm/page-writeback.c:2344
  __filemap_fdatawrite_range+0x2bc/0x3b0 mm/filemap.c:421
  filemap_write_and_wait_range mm/filemap.c:681 [inline]
  filemap_write_and_wait_range+0xfc/0x1d0 mm/filemap.c:675
  ext4_punch_hole+0x27d/0x1320 fs/ext4/inode.c:4314
  ext4_fallocate+0x419/0x2470 fs/ext4/extents.c:4889
  vfs_fallocate+0x4aa/0xa50 fs/open.c:309
  ksys_fallocate+0x58/0xa0 fs/open.c:332
  __do_sys_fallocate fs/open.c:340 [inline]
  __se_sys_fallocate fs/open.c:338 [inline]
  __x64_sys_fallocate+0x97/0xf0 fs/open.c:338
  do_syscall_64+0xfa/0x760 arch/x86/entry/common.c:290
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x440609
Code: 18 89 d0 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 89 f8 48 89 f7  
48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 5b 14 fc ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007fffd7a50c58 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 00007fffd7a50c60 RCX: 0000000000440609
RDX: 0000000000000000 RSI: 0000000100000003 RDI: 0000000000000003
RBP: 0000000000000004 R08: 0000000000000001 R09: 00007fffd7a50033
R10: 0000000028120001 R11: 0000000000000246 R12: 0000000000401ef0
R13: 0000000000401f80 R14: 0000000000000000 R15: 0000000000000000
Modules linked in:
---[ end trace 0ee46d2ea32148f5 ]---
RIP: 0010:mpage_map_and_submit_extent fs/ext4/inode.c:2557 [inline]
RIP: 0010:ext4_writepages+0x17b4/0x2e80 fs/ext4/inode.c:2911
Code: ff ff e8 1f cf b0 ff 48 8b 85 30 fe ff ff 48 8b 8d 00 fe ff ff 48 8d  
78 10 48 89 fa 48 c1 ea 03 0f b6 89 c2 00 00 00 48 d3 e3 <42> 80 3c 2a 00  
0f 85 03 16 00 00 48 89 58 10 48 c7 c0 08 ad c4 89
RSP: 0018:ffff88808bf77890 EFLAGS: 00010206
RAX: fffffffffffffff4 RBX: 00000000007ff000 RCX: 000000000000000c
RDX: 0000000000000000 RSI: ffffffff820534cd RDI: 0000000000000004
RBP: ffff88808bf77ac0 R08: 0000000000000000 R09: ffffed1015d06b7d
R10: ffffed1015d06b7c R11: ffff8880ae835be3 R12: 0000000000000000
R13: dffffc0000000000 R14: 00000000000007ff R15: ffff888086499488
FS:  0000000001162880(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000009366b000 CR4: 00000000001406f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection
syzbot can test patches for this bug, for details see:
https://goo.gl/tpsmEJ#testing-patches
