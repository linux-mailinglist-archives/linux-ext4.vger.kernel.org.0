Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1B3D220390
	for <lists+linux-ext4@lfdr.de>; Thu, 16 May 2019 12:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfEPKgG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 May 2019 06:36:06 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200]:58929 "EHLO
        mail-it1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbfEPKgG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 May 2019 06:36:06 -0400
Received: by mail-it1-f200.google.com with SMTP id l193so2782637ita.8
        for <linux-ext4@vger.kernel.org>; Thu, 16 May 2019 03:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=LhHN0tU3zu6mk7XLekNQ7/scnTfIHU53ESCR4APT9Tc=;
        b=NqcWf1Lvh/eyz+jqbmPSPyiBquJaytTAJ9XcJvJEu1y4uAlcQGvGchDSgTfVAl61nt
         69VWRm3dlhJzXXRTPjy2+zwbccEK37vyYa+HG1JbsdG6CniWWtwcRXkUWPXqdzwxiRDK
         YmKkVs/R/ldIypOQorMraEctrnOsBz/XaS47/+SD1KMupVHT+0zxTQWHyu3XZARlhBKM
         sbL61nol/qaQ/jAvY6GqRwNsJdvWw55Hqy0eC3hN2m9jr9JLL04K5zjOfUny0/puEL/C
         Ya5ypQQF7ZGg8JQqkBYMSxmef7dJaNw2CvM5M5GJ7Ex0ux6i60d5wJGGqEvvObLNs/fK
         9ePA==
X-Gm-Message-State: APjAAAU4ccT14oFXKw2zIRzDRoXWLD8Ut25DpWMFdgGzSg2k9SGBGlcS
        89ipH5dEncUGr+Ppch5LL5sisRjnOSA+qavYldyJS92k/CiX
X-Google-Smtp-Source: APXvYqx3DvWTZV2v7GJqFMItdXJAUV8cfNX06DA2vdw7io8PcJ2XGvpgY4ZPjptBtISwge9fkB+MAHbi1T8oJaOHpzHL8FK7xViS
MIME-Version: 1.0
X-Received: by 2002:a24:320c:: with SMTP id j12mr11144698ita.131.1558002965245;
 Thu, 16 May 2019 03:36:05 -0700 (PDT)
Date:   Thu, 16 May 2019 03:36:05 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004d7a870588fed573@google.com>
Subject: general protection fault in ext4_mb_initialize_context
From:   syzbot <syzbot+629b913164cba57e45ae@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    8834f560 Linux 5.0-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c8021f400000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f00801d7b7c4fe6
dashboard link: https://syzkaller.appspot.com/bug?extid=629b913164cba57e45ae
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

Unfortunately, I don't have any reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+629b913164cba57e45ae@syzkaller.appspotmail.com

kasan: CONFIG_KASAN_INLINE enabled
kasan: GPF could be caused by NULL-ptr deref or user memory access
general protection fault: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 7 Comm: kworker/u4:0 Not tainted 5.0.0-rc5 #59
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Workqueue: writeback wb_workfn (flush-8:0)
RIP: 0010:mutex_can_spin_on_owner kernel/locking/mutex.c:578 [inline]
RIP: 0010:mutex_optimistic_spin kernel/locking/mutex.c:622 [inline]
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:928 [inline]
RIP: 0010:__mutex_lock+0x207/0x1310 kernel/locking/mutex.c:1072
Code: 00 0f 85 bf 0f 00 00 49 8b 45 00 48 83 e0 f8 0f 84 88 09 00 00 48 8d  
78 38 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <0f> b6 14 11 84  
d2 74 09 80 fa 03 0f 8e 8b 10 00 00 8b 58 38 85 db
kobject: 'loop1' (00000000ab6ceb2c): kobject_uevent_env
RSP: 0018:ffff8880a986eec0 EFLAGS: 00010206
kobject: 'loop1' (00000000ab6ceb2c): fill_kobj_path: path  
= '/devices/virtual/block/loop1'
RAX: 0000000000000fc0 RBX: ffff8880a98601c0 RCX: 00000000000001ff
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 0000000000000ff8
RBP: ffff8880a986f030 R08: 1ffffd1ffff85995 R09: fffff91ffff85996
R10: fffff91ffff85995 R11: ffffe8ffffc2ccaf R12: fffffbfff14aad54
R13: ffffe8ffffc2cca8 R14: ffff8880a98601c0 R15: 0000000000000fc0
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd7fe09cdb8 CR3: 00000000a57b2000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000037568535 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  mutex_lock_nested+0x16/0x20 kernel/locking/mutex.c:1087
  ext4_mb_group_or_file fs/ext4/mballoc.c:4210 [inline]
  ext4_mb_initialize_context+0x7e6/0xbc0 fs/ext4/mballoc.c:4253
  ext4_mb_new_blocks+0x5c4/0x3c70 fs/ext4/mballoc.c:4526
  ext4_ext_map_blocks+0x3094/0x4e50 fs/ext4/extents.c:4404
  ext4_map_blocks+0x8ec/0x1a20 fs/ext4/inode.c:636
  mpage_map_one_extent fs/ext4/inode.c:2480 [inline]
  mpage_map_and_submit_extent fs/ext4/inode.c:2533 [inline]
  ext4_writepages+0x1e00/0x3540 fs/ext4/inode.c:2885
  do_writepages+0xfc/0x2a0 mm/page-writeback.c:2335
  __writeback_single_inode+0x11d/0x12f0 fs/fs-writeback.c:1349
  writeback_sb_inodes+0x596/0xed0 fs/fs-writeback.c:1613
  __writeback_inodes_wb+0xc3/0x260 fs/fs-writeback.c:1682
  wb_writeback+0x87f/0xd00 fs/fs-writeback.c:1791
  wb_check_start_all fs/fs-writeback.c:1915 [inline]
  wb_do_writeback fs/fs-writeback.c:1941 [inline]
  wb_workfn+0xae5/0x1190 fs/fs-writeback.c:1975
  process_one_work+0x98e/0x1790 kernel/workqueue.c:2173
  worker_thread+0x98/0xe40 kernel/workqueue.c:2319
  kthread+0x357/0x430 kernel/kthread.c:246
  ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:352
Modules linked in:
---[ end trace 88f5eb75df3cc65e ]---
RIP: 0010:mutex_can_spin_on_owner kernel/locking/mutex.c:578 [inline]
RIP: 0010:mutex_optimistic_spin kernel/locking/mutex.c:622 [inline]
RIP: 0010:__mutex_lock_common kernel/locking/mutex.c:928 [inline]
RIP: 0010:__mutex_lock+0x207/0x1310 kernel/locking/mutex.c:1072
Code: 00 0f 85 bf 0f 00 00 49 8b 45 00 48 83 e0 f8 0f 84 88 09 00 00 48 8d  
78 38 48 ba 00 00 00 00 00 fc ff df 48 89 f9 48 c1 e9 03 <0f> b6 14 11 84  
d2 74 09 80 fa 03 0f 8e 8b 10 00 00 8b 58 38 85 db
RSP: 0018:ffff8880a986eec0 EFLAGS: 00010206
RAX: 0000000000000fc0 RBX: ffff8880a98601c0 RCX: 00000000000001ff
RDX: dffffc0000000000 RSI: 0000000000000008 RDI: 0000000000000ff8
RBP: ffff8880a986f030 R08: 1ffffd1ffff85995 R09: fffff91ffff85996
R10: fffff91ffff85995 R11: ffffe8ffffc2ccaf R12: fffffbfff14aad54
R13: ffffe8ffffc2cca8 R14: ffff8880a98601c0 R15: 0000000000000fc0
FS:  0000000000000000(0000) GS:ffff8880ae800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fd7fe09cdb8 CR3: 0000000008871000 CR4: 00000000001426f0
DR0: 0000000000000000 DR1: 0000000037568535 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
