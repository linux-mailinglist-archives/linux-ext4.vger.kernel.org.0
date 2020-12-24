Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 166792E25C6
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Dec 2020 10:56:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726611AbgLXJ4A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 24 Dec 2020 04:56:00 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41091 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgLXJz7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 24 Dec 2020 04:55:59 -0500
Received: by mail-il1-f200.google.com with SMTP id f19so1415094ilk.8
        for <linux-ext4@vger.kernel.org>; Thu, 24 Dec 2020 01:55:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=YrCEs5zHAzYd+hmTqY9ujgvkfHbVrkKlTwkFJ1ImLnE=;
        b=Df44qLSgByAE9jya4zCZgFx3TzeDg4ZpyS+egmPOje94Ia3KjCUH0pxpV/GDoVlc8j
         B8gBnsmvOMaUtTgwGIZeWze+7IdBJgKzmEQsp/hXtaq6GTTRmi5bZj6H4M+wbxPWFd9N
         2EJX+i4g6kUUBj9bB25Apm40rWBIumqzubYYV2n0R32Ewp0jLoxMQ5j1yYWxw416Zmo5
         lKUX7xJ17Xulo86p5lyb7591FLbxjCiBk5y4uivYG008S3heKMb5tdShxwaN4wMKZgBY
         zrxJ5pFg4SLadf2zUW76/cUjGYI926jSZNQh6rQJy04I1ZMNERiT3KqeKWXkKUCP/dd0
         yTtA==
X-Gm-Message-State: AOAM530SnRDBhFSJj8Vh3RPAxSLrWtK48fee5C3i3DauE/kYm+Hdpihy
        dZr6NKCSnPSkp3sU1YTz8s5Pyk6CMAt0QRyYhzrROKTBFYzl
X-Google-Smtp-Source: ABdhPJxN/exkvoSjQfWS6HLEdCvGIbXh0qdDCOc6BMWl9Zb1wbELwjIquGIXO8AHZDk3qknzlNgx+yxvVMV6Q9Sj6f74yuC+2FXR
MIME-Version: 1.0
X-Received: by 2002:a5d:9713:: with SMTP id h19mr24533909iol.14.1608803718802;
 Thu, 24 Dec 2020 01:55:18 -0800 (PST)
Date:   Thu, 24 Dec 2020 01:55:18 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002c2f5b05b732ce65@google.com>
Subject: memory leak in ext4_multi_mount_protect
From:   syzbot <syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hello,

syzbot found the following issue on:

HEAD commit:    467f8165 Merge tag 'close-range-cloexec-unshare-v5.11' of ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12b7fccb500000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37c889fb8b2761af
dashboard link: https://syzkaller.appspot.com/bug?extid=d9e482e303930fa4f6ff
compiler:       gcc (GCC) 10.1.0-syz 20200507
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1230f8a7500000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d9e482e303930fa4f6ff@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff88812560f120 (size 32):
  comm "syz-executor.3", pid 11391, jiffies 4294966956 (age 10.520s)
  hex dump (first 32 bytes):
    28 2a e4 20 81 88 ff ff 00 f8 32 24 81 88 ff ff  (*. ......2$....
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace:
    [<000000001fd6256c>] kmalloc include/linux/slab.h:552 [inline]
    [<000000001fd6256c>] ext4_multi_mount_protect+0x4a6/0x5d0 fs/ext4/mmp.c:367
    [<00000000ab3084f2>] ext4_fill_super+0x551e/0x5ac0 fs/ext4/super.c:4779
    [<00000000b7304a28>] mount_bdev+0x223/0x260 fs/super.c:1366
    [<00000000b580b323>] legacy_get_tree+0x2b/0x90 fs/fs_context.c:592
    [<000000005310f7d7>] vfs_get_tree+0x28/0x100 fs/super.c:1496
    [<000000006fc429ab>] do_new_mount fs/namespace.c:2875 [inline]
    [<000000006fc429ab>] path_mount+0xc5e/0x1170 fs/namespace.c:3205
    [<000000004f8c23d3>] do_mount fs/namespace.c:3218 [inline]
    [<000000004f8c23d3>] __do_sys_mount fs/namespace.c:3426 [inline]
    [<000000004f8c23d3>] __se_sys_mount fs/namespace.c:3403 [inline]
    [<000000004f8c23d3>] __x64_sys_mount+0x18e/0x1d0 fs/namespace.c:3403
    [<000000002cff8f95>] do_syscall_64+0x2d/0x70 arch/x86/entry/common.c:46
    [<00000000779cd3d5>] entry_SYSCALL_64_after_hwframe+0x44/0xa9



---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
syzbot can test patches for this issue, for details see:
https://goo.gl/tpsmEJ#testing-patches
