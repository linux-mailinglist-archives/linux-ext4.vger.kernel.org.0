Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24804B0B60
	for <lists+linux-ext4@lfdr.de>; Thu, 10 Feb 2022 11:50:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240212AbiBJKuQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Feb 2022 05:50:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240181AbiBJKuQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Feb 2022 05:50:16 -0500
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082D61006
        for <linux-ext4@vger.kernel.org>; Thu, 10 Feb 2022 02:50:18 -0800 (PST)
Received: by mail-il1-f198.google.com with SMTP id f9-20020a92cb49000000b002be1f9405a3so3669088ilq.16
        for <linux-ext4@vger.kernel.org>; Thu, 10 Feb 2022 02:50:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=sxYpZJUZ2c9zNF0g11fgItZpAgYz7w3rafFkaJxtZEQ=;
        b=gA5ZKVDN82ccL0ecVS/nGL2ew1SYy+F8sA2mZ2zqRPiPqfxxwanAj2XbP8jHDcP7dG
         AQZSui1z5MXfqcDWAYM5RX5ADw0c42bdh4s9SAUjvSj1hRKUafcG4KmMFHuC6zpT3L7U
         RlJiCt6iKIPpQ5Vu6dMhzUCBdcpMOdOIDER6e302TIiAiEJpNWTDLuSQUp1DVjUP7Er7
         zX7iI3Fvj0eMP8DQI/VDPOKgg+Jut63qN95xYI3t2NluhrO7vJFh1S7lVmECwt4U2bZF
         j4XR9ejEbXWs51+8Qm1pR3sQoVK2rFqMDOsyEJ28IFoXMEsbN/8cGVWYMsXbh7jQin5M
         0/Hw==
X-Gm-Message-State: AOAM530v5AcY4Jq/1XGMzvjreI40Yuoqk7Avyo0ZCCipZXgCriSOggMp
        /Lsd7hnM/K5oMjCrqXjNjwFdQTqUHO01Tpeuoz6GspKhgbRB
X-Google-Smtp-Source: ABdhPJzDPwxNgGEw7MSf2dUinV4AhG1lZH2BM4eClEPzLE93HkKhYeXKN5whaoqHy9jESUgvFBAgh+EYiT8naivCOjHaQBhUIyma
MIME-Version: 1.0
X-Received: by 2002:a6b:7219:: with SMTP id n25mr3519606ioc.12.1644490217356;
 Thu, 10 Feb 2022 02:50:17 -0800 (PST)
Date:   Thu, 10 Feb 2022 02:50:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003e009a05d7a7b77f@google.com>
Subject: [syzbot] KCSAN: data-race in copy_page_to_iter / strncpy (4)
From:   syzbot <syzbot+88a9b535e28311efdcd4@syzkaller.appspotmail.com>
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

HEAD commit:    e6251ab4551f Merge tag 'nfs-for-5.17-2' of git://git.linux..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109133b4700000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1dcc3374da7c1f7c
dashboard link: https://syzkaller.appspot.com/bug?extid=88a9b535e28311efdcd4
compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2

Unfortunately, I don't have any reproducer for this issue yet.

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+88a9b535e28311efdcd4@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in copy_page_to_iter / strncpy

write to 0xffff888108b1b488 of 1 bytes by task 16090 on cpu 1:
 strncpy+0xcf/0x150 lib/string.c:114
 ext4_sample_last_mounted fs/ext4/file.c:828 [inline]
 ext4_file_open+0x3a6/0x4e0 fs/ext4/file.c:847
 do_dentry_open+0x52c/0x860 fs/open.c:824
 vfs_open+0x43/0x50 fs/open.c:959
 do_open fs/namei.c:3476 [inline]
 path_openat+0x170c/0x1f30 fs/namei.c:3609
 do_filp_open+0x105/0x220 fs/namei.c:3636
 do_sys_openat2+0xb5/0x2b0 fs/open.c:1214
 do_sys_open fs/open.c:1230 [inline]
 __do_sys_open fs/open.c:1238 [inline]
 __se_sys_open fs/open.c:1234 [inline]
 __x64_sys_open+0xe2/0x110 fs/open.c:1234
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

read to 0xffff888108b1b400 of 1024 bytes by task 10450 on cpu 0:
 instrument_copy_to_user include/linux/instrumented.h:119 [inline]
 copyout lib/iov_iter.c:154 [inline]
 copy_page_to_iter_iovec lib/iov_iter.c:226 [inline]
 __copy_page_to_iter lib/iov_iter.c:850 [inline]
 copy_page_to_iter+0x2cb/0x950 lib/iov_iter.c:878
 copy_folio_to_iter include/linux/uio.h:153 [inline]
 filemap_read+0x1126/0x1430 mm/filemap.c:2727
 blkdev_read_iter+0x2cc/0x380 block/fops.c:614
 call_read_iter include/linux/fs.h:2068 [inline]
 new_sync_read fs/read_write.c:400 [inline]
 vfs_read+0x66c/0x750 fs/read_write.c:481
 ksys_read+0xd9/0x190 fs/read_write.c:619
 __do_sys_read fs/read_write.c:629 [inline]
 __se_sys_read fs/read_write.c:627 [inline]
 __x64_sys_read+0x3e/0x50 fs/read_write.c:627
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x44/0xd0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x44/0xae

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 10450 Comm: udevd Not tainted 5.17.0-rc3-syzkaller-00029-ge6251ab4551f-dirty #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
==================================================================
I/O error, dev loop2, sector 0 op 0x0:(READ) flags 0x80700 phys_seg 1 prio class 0


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
