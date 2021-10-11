Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 980454284D0
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Oct 2021 03:42:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbhJKBo4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Oct 2021 21:44:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhJKBo4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Oct 2021 21:44:56 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB57DC061570;
        Sun, 10 Oct 2021 18:42:56 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id x8so10167453plv.8;
        Sun, 10 Oct 2021 18:42:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=dtaG8Omsj0ij2wLR6b71mv5HBPFmB9Dm+L34q0UuFQE=;
        b=GcmkqYsjATvEbY3kx1aB7z1J9NrGl72JMDWzUiXJ4AhZ4fsUBoagWjVTDK+BSHMerF
         GU/b6AD/UTmDU/II6jazyCF4Nj1ZXz5ySpCuIp86aDCT8Hw+ZHXhK5wlEirJOg+MeMaY
         9zSylVLV/RsTHxHxkxAz+ICgR74nPCqpbPtdSj5wRsjzvDVlfaTh75cRcRztFvnLkSBP
         ibOlActcxlXZStw1wX1fFL++qIowtZ72hu4btT19Kk/2RVfT/GOiB1fcB0CHLQS7M52x
         5RWhAPcOXclnxKajGGQGE1JGgyXHTnqE46Vv6g2GrGOx7pRhDAa68kmkttUN2wVbeAVU
         XMDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=dtaG8Omsj0ij2wLR6b71mv5HBPFmB9Dm+L34q0UuFQE=;
        b=GDo0MiWjuQ3XyBiN3i7OMRnPWi/gDp/4Dfyp72RMPRZTueqJhAEBXUtYDXO+1VXmRQ
         EjPkOIuCRrZbVEdatIEwTOY9pyZVU/uvivEO0ZODVI+h/IVn1U4tOwvQImNqi6sFOzUW
         5ADrui+zFS3AD0r4ojcONxmUpJdEwsBirPx5ErMwcqkxmjLWbaCxaNV+GCrLOQtLM+9R
         9fPzW7xt4KAiQckfUJPcDHT4spDqnoxPbBXSagtgZHanMw+h+VBWKPnwZG52yZs+LhOP
         EzUnDINkSzkGLOm0v/qUJS2FMqGCSPlKkFCrxmIRMcwjfykkSX4lDVPPrG8HbLk99Jo5
         gtEA==
X-Gm-Message-State: AOAM533+NT452cwV7Pdl9zLjGcLwp6hzBcdQICeFMNUi6INH8p/UUDnv
        J2NaPP5mJKu4Wl6OCHnHP0XAV+cfdF7mYykUL3XqhHljCU5h
X-Google-Smtp-Source: ABdhPJzmHQhK7XSNf+Ghe/JFZyGjHpgQ9S5VCoIqtV2oPop1AMLVNLV23aXT6ZaY8jcEflGNi2sc4lnIl74gj2d56+0=
X-Received: by 2002:a17:903:2341:b0:13e:ae30:412 with SMTP id
 c1-20020a170903234100b0013eae300412mr21846192plh.15.1633916576311; Sun, 10
 Oct 2021 18:42:56 -0700 (PDT)
MIME-Version: 1.0
From:   Hao Sun <sunhao.th@gmail.com>
Date:   Mon, 11 Oct 2021 09:42:45 +0800
Message-ID: <CACkBjsb1dE7A_v_=yYfMOO0HSGT9a0Zc7=cC6cmYREWepHhxpw@mail.gmail.com>
Subject: kernel BUG in ext4_da_get_block_prep
To:     tytso@mit.edu, adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

When using Healer to fuzz the latest Linux kernel, the following crash
was triggered.

HEAD commit: 60a9483534ed Merge tag 'warning-fixes-20211005'
git tree: upstream
console output:
https://drive.google.com/file/d/1zMa_o4PaMiO_nYcQ4giUjNhFszYjFae-/view?usp=sharing
kernel config: https://drive.google.com/file/d/1u-ncYGLkq3xqdlNQYJz8-G6Fhf3H-moP/view?usp=sharing
Syzlang reproducer:
https://drive.google.com/file/d/1LWQjzVVjjI8q6sO1f4AYlq5NlcN-shBP/view?usp=sharing

Sorry, I don't have a C reproducer for this crash, hope the symbolized
report and Syzlang reproducer can help.
If you fix this issue, please add the following tag to the commit:
Reported-by: Hao Sun <sunhao.th@gmail.com>

------------[ cut here ]------------
kernel BUG at fs/ext4/inode.c:1721!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 1 PID: 19701 Comm: syz-executor Not tainted 5.15.0-rc4+ #22
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.12.0-59-gc9ba5276e321-prebuilt.qemu.org 04/01/2014
RIP: 0010:ext4_da_map_blocks fs/ext4/inode.c:1721 [inline]
RIP: 0010:ext4_da_get_block_prep+0x52a/0x5a0 fs/ext4/inode.c:1830
Code: 0f 0b ba 01 00 00 00 e9 d0 fd ff ff e8 7f 42 c0 ff f0 80 4b 01
01 4c 89 ef 31 ed e8 a0 c7 b3 ff e9 f2 fb ff ff e8 66 42 c0 ff <0f> 0b
e8 5f 42 c0 ff 0f 0b e8 58 42 c0 ff 0f 0b e8 51 42 c0 ff 49
RSP: 0018:ffffc9000f8978d0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff888121a493f0 RCX: ffffc900011f9000
RDX: 0000000000040000 RSI: ffffffff81774f6a RDI: ffffffff853cd076
RBP: 27ffffffffffffff R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000f897740 R11: 0000000000000002 R12: ffff88811560b220
R13: 00000000000008f3 R14: 0000000000000004 R15: ffffffffffff0000
FS:  00007f773e1d6700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f773e1abdb8 CR3: 000000000a5d7000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
Call Trace:
 ext4_block_write_begin+0x208/0x980 fs/ext4/inode.c:1078
 ext4_da_write_begin+0x1d4/0x490 fs/ext4/inode.c:2969
 generic_perform_write+0xce/0x220 mm/filemap.c:3770
 ext4_buffered_write_iter+0xd6/0x190 fs/ext4/file.c:269
 ext4_file_write_iter+0x80/0x940 fs/ext4/file.c:680
 call_write_iter include/linux/fs.h:2163 [inline]
 do_iter_readv_writev+0x1e8/0x2b0 fs/read_write.c:729
 do_iter_write+0xaf/0x250 fs/read_write.c:855
 vfs_iter_write+0x38/0x60 fs/read_write.c:896
 iter_file_splice_write+0x2d8/0x450 fs/splice.c:689
 do_splice_from fs/splice.c:767 [inline]
 direct_splice_actor+0x4a/0x80 fs/splice.c:936
 splice_direct_to_actor+0x123/0x2d0 fs/splice.c:891
 do_splice_direct+0xc3/0x110 fs/splice.c:979
 do_sendfile+0x338/0x740 fs/read_write.c:1249
 __do_sys_sendfile64 fs/read_write.c:1314 [inline]
 __se_sys_sendfile64 fs/read_write.c:1300 [inline]
 __x64_sys_sendfile64+0xc7/0xe0 fs/read_write.c:1300
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x34/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae
RIP: 0033:0x46ae99
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f773e1d5c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000028
RAX: ffffffffffffffda RBX: 000000000078c0a0 RCX: 000000000046ae99
RDX: 0000000000000000 RSI: 0000000000000006 RDI: 0000000000000003
RBP: 00000000004e4809 R08: 0000000000000000 R09: 0000000000000000
R10: 00008400fffffffb R11: 0000000000000246 R12: 000000000078c0a0
R13: 0000000000000000 R14: 000000000078c0a0 R15: 00007fffca657850
Modules linked in:
Dumping ftrace buffer:
   (ftrace buffer empty)
---[ end trace 46bee01b7f620b60 ]---
RIP: 0010:ext4_da_map_blocks fs/ext4/inode.c:1721 [inline]
RIP: 0010:ext4_da_get_block_prep+0x52a/0x5a0 fs/ext4/inode.c:1830
Code: 0f 0b ba 01 00 00 00 e9 d0 fd ff ff e8 7f 42 c0 ff f0 80 4b 01
01 4c 89 ef 31 ed e8 a0 c7 b3 ff e9 f2 fb ff ff e8 66 42 c0 ff <0f> 0b
e8 5f 42 c0 ff 0f 0b e8 58 42 c0 ff 0f 0b e8 51 42 c0 ff 49
RSP: 0018:ffffc9000f8978d0 EFLAGS: 00010246
RAX: 0000000000040000 RBX: ffff888121a493f0 RCX: ffffc900011f9000
RDX: 0000000000040000 RSI: ffffffff81774f6a RDI: ffffffff853cd076
RBP: 27ffffffffffffff R08: 0000000000000001 R09: 0000000000000000
R10: ffffc9000f897740 R11: 0000000000000002 R12: ffff88811560b220
R13: 00000000000008f3 R14: 0000000000000004 R15: ffffffffffff0000
FS:  00007f773e1d6700(0000) GS:ffff88813dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f773e1abdb8 CR3: 000000000a5d7000 CR4: 0000000000750ee0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
PKRU: 55555554
