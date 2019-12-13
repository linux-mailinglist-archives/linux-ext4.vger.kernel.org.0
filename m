Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73F1611EA16
	for <lists+linux-ext4@lfdr.de>; Fri, 13 Dec 2019 19:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728701AbfLMSVH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 13 Dec 2019 13:21:07 -0500
Received: from mail-il1-f199.google.com ([209.85.166.199]:44772 "EHLO
        mail-il1-f199.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbfLMSVH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 13 Dec 2019 13:21:07 -0500
Received: by mail-il1-f199.google.com with SMTP id h87so230273ild.11
        for <linux-ext4@vger.kernel.org>; Fri, 13 Dec 2019 10:21:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=aQTVfoxwkQIhXdnX2QpUsvCJ5WDGzgU3J1q0OChbD38=;
        b=B+eRkBByDiH6PG2M1bltMLf+Xh71X8whaig+GfgNOlJVCW+oK4GTOwqcjNw7dOII9g
         j0oFusd8UlxrH4HjTL6u5uPGMDWicwIoGHq+dJ+umnoq1F5ZUl7CatktDy1Ce32CA+k8
         cFx5Ev02G02xZsjL1owPsUXNfM1HN/7i4P9//xVwx9kxmczDz88lVDCV2QOPLTGusya3
         HMfkhEfHZLx4E1lfh2OXBwOXbqIkxrqSECXnz/6m0g+WljI6wIbucWQ/lHEddZDxd8vS
         DrpuLNd6XhVaXuAPVw8Vp3rrpDN5MFjQRPnB4ePLjdj/SRZuvusD0/bjG66luYkb7Au9
         z8iQ==
X-Gm-Message-State: APjAAAVpeFujVwa53s+3f8GErEXDxx9hp5OkqoxbnpOgd3A/bi/MesdV
        loOVjn9NxNSb1nXVQkcm9Wfgi8lXTd2YhEUsvWwoQySfteEo
X-Google-Smtp-Source: APXvYqwcooZ2pJuli9b4blpPIIw8Et1D/a/QbMVa68MwHnGqkCH8gMhbOKCMEZ26Uz5hs1cQ0HZxjF9ETacoFdd/55a81vWZX3GP
MIME-Version: 1.0
X-Received: by 2002:a6b:3b54:: with SMTP id i81mr8293539ioa.249.1576261266965;
 Fri, 13 Dec 2019 10:21:06 -0800 (PST)
Date:   Fri, 13 Dec 2019 10:21:06 -0800
In-Reply-To: <000000000000c71dcf0579b0553f@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e40d33059999ec21@google.com>
Subject: Re: KASAN: use-after-free Read in ext4_xattr_set_entry (2)
From:   syzbot <syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

syzbot has found a reproducer for the following crash on:

HEAD commit:    ae4b064e Merge tag 'afs-fixes-20191211' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=137f6499e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=79f79de2a27d3e3d
dashboard link: https://syzkaller.appspot.com/bug?extid=4a39a025912b265cacef
compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15ec1332e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=163455dee00000

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: syzbot+4a39a025912b265cacef@syzkaller.appspotmail.com

EXT4-fs error (device sda1): ext4_xattr_set_entry:1583: inode #2339: comm  
syz-executor117: corrupted xattr entries
==================================================================
BUG: KASAN: use-after-free in ext4_xattr_set_entry+0x35de/0x3770  
fs/ext4/xattr.c:1580
Read of size 4 at addr ffff888093705283 by task syz-executor117/9665

CPU: 0 PID: 9665 Comm: syz-executor117 Not tainted 5.5.0-rc1-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS  
Google 01/01/2011
Call Trace:
  __dump_stack lib/dump_stack.c:77 [inline]
  dump_stack+0x197/0x210 lib/dump_stack.c:118
  print_address_description.constprop.0.cold+0xd4/0x30b mm/kasan/report.c:374
  __kasan_report.cold+0x1b/0x41 mm/kasan/report.c:506
  kasan_report+0x12/0x20 mm/kasan/common.c:639
  __asan_report_load4_noabort+0x14/0x20 mm/kasan/generic_report.c:134
  ext4_xattr_set_entry+0x35de/0x3770 fs/ext4/xattr.c:1580
  ext4_xattr_ibody_set+0x80/0x2d0 fs/ext4/xattr.c:2216
  ext4_xattr_set_handle+0x933/0x1200 fs/ext4/xattr.c:2372
  ext4_initxattrs+0xc0/0x130 fs/ext4/xattr_security.c:43
  security_inode_init_security security/security.c:996 [inline]
  security_inode_init_security+0x2c8/0x3b0 security/security.c:969
  ext4_init_security+0x34/0x40 fs/ext4/xattr_security.c:57
  __ext4_new_inode+0x4288/0x4f30 fs/ext4/ialloc.c:1155
  ext4_mkdir+0x3d5/0xe20 fs/ext4/namei.c:2774
  vfs_mkdir+0x42e/0x670 fs/namei.c:3819
  do_mkdirat+0x234/0x2a0 fs/namei.c:3842
  __do_sys_mkdir fs/namei.c:3858 [inline]
  __se_sys_mkdir fs/namei.c:3856 [inline]
  __x64_sys_mkdir+0x5c/0x80 fs/namei.c:3856
  do_syscall_64+0xfa/0x790 arch/x86/entry/common.c:294
  entry_SYSCALL_64_after_hwframe+0x49/0xbe
RIP: 0033:0x44d177
Code: 1f 40 00 b8 5a 00 00 00 0f 05 48 3d 01 f0 ff ff 0f 83 4d d6 fb ff c3  
66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff  
ff 0f 83 2d d6 fb ff c3 66 2e 0f 1f 84 00 00 00 00
RSP: 002b:00007f5c9599fb18 EFLAGS: 00000246 ORIG_RAX: 0000000000000053
RAX: ffffffffffffffda RBX: 00000000006e69c8 RCX: 000000000044d177
RDX: 0000000000000003 RSI: 00000000000001ff RDI: 0000000020000000
RBP: 00000000006e69c0 R08: 0000000000000000 R09: 000000000000000a
R10: 0000000000000075 R11: 0000000000000246 R12: 00000000006e69cc
R13: 00007ffd790837cf R14: 00007f5c959a09c0 R15: 0000000000000000

The buggy address belongs to the page:
page:ffffea00024dc140 refcount:0 mapcount:0 mapping:0000000000000000  
index:0x1
raw: 00fffe0000000000 ffffea0002183608 ffffea00027ef508 0000000000000000
raw: 0000000000000001 0000000000000000 00000000ffffffff 0000000000000000
page dumped because: kasan: bad access detected

Memory state around the buggy address:
  ffff888093705180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888093705200: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ffff888093705280: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
                    ^
  ffff888093705300: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
  ffff888093705380: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
==================================================================

