Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A881F7CEE
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jun 2020 20:34:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726314AbgFLSeV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jun 2020 14:34:21 -0400
Received: from mail-io1-f72.google.com ([209.85.166.72]:50346 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726263AbgFLSeU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Jun 2020 14:34:20 -0400
Received: by mail-io1-f72.google.com with SMTP id n123so6655917iod.17
        for <linux-ext4@vger.kernel.org>; Fri, 12 Jun 2020 11:34:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=GP5kyNnAoMO+Y+j8GajalB1W8y9R1MA095I7NPSnTDs=;
        b=EVpTsW0wo+eEMQsX5KqzTbgmyMylJsWHBq+8iYlZp3kMOpQWkp0sb4iKUBSuhZwJaV
         ogKv71WB14je1hLCZusIQ8lHj+o0hiLX+HoLMsi2iWeEcRVSKiNUu61wFiXrxuqy3dml
         G3hiUPuNFe3sfFtql7nlyzPVAeHb3CHaqhVN/fuLKIB4bIVYQZ/844IPh+GVUlvhx/ap
         MTVTgxIt+5wBoib7DWHouQ7uGpoDj8PKzmb2fpXMSsMi6bVVGmLd/5ci04KyVxYKABhR
         5s+XGH7uN5KyUbCF6jmXWOtt/ePScDgIGzsijhJr/ph4rSY7fZn5CP1uj0mzr32Pp8ED
         Ph9Q==
X-Gm-Message-State: AOAM531kQtrU7JkyPyhaxGqoc8r7SLaxBp9kzF9aNdSF7Frv/kOiS9FS
        HjZGe6DZg+nVjAH5Qi7DMiBpb53ED+M+wqWGaGsJRLDJN8Ux
X-Google-Smtp-Source: ABdhPJxkzP1X/Sc4h5xBvzyleoSa7OQigmndmQWmhwM/LOvU0piOR/suDQx5LmuSsPprWS5mCsm1uSWYK6gTZMac3FGouptucEre
MIME-Version: 1.0
X-Received: by 2002:a05:6638:ce:: with SMTP id w14mr9773000jao.27.1591986857779;
 Fri, 12 Jun 2020 11:34:17 -0700 (PDT)
Date:   Fri, 12 Jun 2020 11:34:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000025269c05a7e753d0@google.com>
Subject: net test error: BUG: using smp_processor_id() in preemptible code in ext4_mb_new_blocks
From:   syzbot <syzbot+38af52cdcc116cee7742@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, davem@davemloft.net, kuba@kernel.org,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following crash on:

HEAD commit:    18dbd4cd Merge branch 'net-ipa-endpoint-configuration-fixes'
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=13f762ea100000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b366fd92adf6f8b4
dashboard link: https://syzkaller.appspot.com/bug?extid=38af52cdcc116cee7742
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+38af52cdcc116cee7742@syzkaller.appspotmail.com

BUG: using smp_processor_id() in preemptible [00000000] code: systemd-rfkill/6838
caller is ext4_mb_new_blocks+0xa77/0x3b30 fs/ext4/mballoc.c:4711
CPU: 1 PID: 6838 Comm: systemd-rfkill Not tainted 5.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x188/0x20d lib/dump_stack.c:118
 check_preemption_disabled lib/smp_processor_id.c:47 [inline]
 debug_smp_processor_id.cold+0x88/0x9b lib/smp_processor_id.c:57
 ext4_mb_new_blocks+0xa77/0x3b30 fs/ext4/mballoc.c:4711
 ext4_ext_map_blocks+0x2044/0x3410 fs/ext4/extents.c:4244
 ext4_map_blocks+0x4cb/0x1640 fs/ext4/inode.c:626
 ext4_getblk+0xad/0x520 fs/ext4/inode.c:833
 ext4_bread+0x7c/0x380 fs/ext4/inode.c:883
 ext4_append+0x153/0x360 fs/ext4/namei.c:67
 ext4_init_new_dir fs/ext4/namei.c:2757 [inline]
 ext4_mkdir+0x5e0/0xdf0 fs/ext4/namei.c:2802
 vfs_mkdir+0x419/0x690 fs/namei.c:3627
 do_mkdirat+0x21e/0x280 fs/namei.c:3650
 do_syscall_64+0xf6/0x7d0 arch/x86/entry/common.c:295
 entry_SYSCALL_64_after_hwframe+0x49/0xb3
RIP: 0033:0x7fa2f1d24687
Code: 00 b8 ff ff ff ff c3 0f 1f 40 00 48 8b 05 09 d8 2b 00 64 c7 00 5f 00 00 00 b8 ff ff ff ff c3 0f 1f 40 00 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d e1 d7 2b 00 f7 d8 64 89 01 48
RSP: 002b:00007fffeaa243a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00005638ed5e0985 RCX: 00007fa2f1d24687
RDX: 00007fffeaa24270 RSI: 00000000000001ed RDI: 00005638ed5e0985
RBP: 00007fa2f1d24680 R08: 0000000000000100 R09: 0000000000000000
R10: 00005638ed5e0980 R11: 0000000000000246 R12: 00000000000001ed
R13: 00007fffeaa24530 R14: 0000000000000000 R15: 0000000000000000


---
This bug is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this bug report. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
