Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3A84D9E68
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Mar 2022 16:14:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349313AbiCOPPg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Mar 2022 11:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239158AbiCOPPf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 15 Mar 2022 11:15:35 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79DE227CDF
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 08:14:21 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id z10-20020a056602080a00b00645b9fdc630so14744308iow.5
        for <linux-ext4@vger.kernel.org>; Tue, 15 Mar 2022 08:14:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fzzxtMFFTEHBKO10X/j+nayURnj7o4HNsDU04+QEw4M=;
        b=70oyVhPKu+tj8jB19kT6Ys9ZNNiBpesOFbfR01JIaVtwN1L6KY5OqfS/owYx+gr59N
         W6zUC8W1axPkbL3hsaymXrpdqjB7HukKg8K/fqyuDoAvcUMDvYIBCIsS/ysTG6LcVh+1
         auzvXrI+CtRqf3pOuF9j2cKglmhxKeiMD4xPT0+rK+O+EUFZhSjPGe3gDRJ0JFFzl2Wj
         BF693VvIsGk2QPiGJ97RsgO3hxVmqlaiQ13lKsttoKUd/dz63kafs+mPZMi/jxh9GVoZ
         /TBC6VKivxqPauqhFXjIeONuAvtxxY1cUb1YjAIGOXGWQkTzoJ2xZU059H7iUvYg3+fk
         sUZQ==
X-Gm-Message-State: AOAM532/dRfw95WfhjReEkjEETTsFE52KZVpREzRck32L87JlkRxVTIC
        xHZJ4Dnzj0RPNC1BGz4dNpvPM7e/MZ+vLYPGpQN8CQdStkZ4
X-Google-Smtp-Source: ABdhPJxox0C2PaY29+M9+IrDL4j7x3FcuzHBnxkxYfgMfeGLxSo5WaaBnQnVVwRXAhLxBL3tg34w9fYkcf2NBZxSjfue4Fq28l8s
MIME-Version: 1.0
X-Received: by 2002:a05:6638:344a:b0:319:fca7:7361 with SMTP id
 q10-20020a056638344a00b00319fca77361mr9592119jav.225.1647357259337; Tue, 15
 Mar 2022 08:14:19 -0700 (PDT)
Date:   Tue, 15 Mar 2022 08:14:19 -0700
In-Reply-To: <000000000000183d9e05d7f0c0ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000042d70e05da43401f@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_ind_remove_space
From:   syzbot <syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com>
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

syzbot has found a reproducer for the following issue on:

HEAD commit:    09688c0166e7 Linux 5.17-rc8
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11a8bd61700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d35f9bc6884af6c9
dashboard link: https://syzkaller.appspot.com/bug?extid=fcc629d1a1ae8d3fe8a5
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1205b189700000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15dda4fe700000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+fcc629d1a1ae8d3fe8a5@syzkaller.appspotmail.com

EXT4-fs warning (device sda1): ext4_block_to_path:105: block 1074791436 > max in inode 1137
------------[ cut here ]------------
kernel BUG at fs/ext4/indirect.c:1244!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 0 PID: 3590 Comm: syz-executor391 Not tainted 5.17.0-rc8-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_ind_remove_space+0xfde/0x1400 fs/ext4/indirect.c:1244
Code: 00 0f 85 36 03 00 00 48 8b 0b 4c 89 fe 44 8b 4c 24 20 48 8b 7c 24 10 48 83 c1 04 e8 3c bb ff ff e9 02 f6 ff ff e8 c2 26 66 ff <0f> 0b 4c 8b 7c 24 50 e9 8e f9 ff ff e8 b1 26 66 ff 48 8b 7c 24 10
RSP: 0018:ffffc90001adfab8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888021523a00 RSI: ffffffff8212996e RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff82128bea R11: 0000000000000000 R12: 0000000000001000
R13: ffffc90001adfb68 R14: ffffc90001adfb88 R15: ffff8880751fa088
FS:  00007f69922ff700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000021605000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 ext4_punch_hole+0xfe8/0x11d0 fs/ext4/inode.c:4044
 ext4_fallocate+0x1194/0x3ed0 fs/ext4/extents.c:4694
 vfs_fallocate+0x48d/0xe10 fs/open.c:308
 ksys_fallocate fs/open.c:331 [inline]
 __do_sys_fallocate fs/open.c:339 [inline]
 __se_sys_fallocate fs/open.c:337 [inline]
 __x64_sys_fallocate+0xcf/0x140 fs/open.c:337
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x7f699234cdf9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 81 14 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f69922ff308 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 0000000000000040 RCX: 00007f699234cdf9
RDX: 0000000000000000 RSI: 0000000000000003 RDI: 0000000000000005
RBP: 00007f69923d5408 R08: 0000000000000000 R09: 0000000000000000
R10: 00000ffeffeff000 R11: 0000000000000246 R12: 00000ffeffeff000
R13: 00007f69923d5400 R14: 00007f69923a3004 R15: 0000000000022000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_ind_remove_space+0xfde/0x1400 fs/ext4/indirect.c:1244
Code: 00 0f 85 36 03 00 00 48 8b 0b 4c 89 fe 44 8b 4c 24 20 48 8b 7c 24 10 48 83 c1 04 e8 3c bb ff ff e9 02 f6 ff ff e8 c2 26 66 ff <0f> 0b 4c 8b 7c 24 50 e9 8e f9 ff ff e8 b1 26 66 ff 48 8b 7c 24 10
RSP: 0018:ffffc90001adfab8 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff888021523a00 RSI: ffffffff8212996e RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: ffffffff82128bea R11: 0000000000000000 R12: 0000000000001000
R13: ffffc90001adfb68 R14: ffffc90001adfb88 R15: ffff8880751fa088
FS:  00007f69922ff700(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000080 CR3: 0000000021605000 CR4: 0000000000350ef0

