Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC7A393632
	for <lists+linux-ext4@lfdr.de>; Thu, 27 May 2021 21:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232943AbhE0TZ5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 May 2021 15:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhE0TZ4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 May 2021 15:25:56 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E681FC061574
        for <linux-ext4@vger.kernel.org>; Thu, 27 May 2021 12:24:22 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id 82so1801714qki.8
        for <linux-ext4@vger.kernel.org>; Thu, 27 May 2021 12:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=fXirvRF06P7Wgl0SBQNh+LUwZLlKfYncDMKoCadyeek=;
        b=Jo+5pafVTWUI0ZBhb1hRuAtLwwpe0n3CsQWfT1VD7beRlvtVlVuLfqt07IiozMXhJs
         m3avrEY9HpadlRS+LaVRb2eMSGabfDJhSgF3bOaMN/z8MAz6XUUhJG7F9nuSvc6PxM4x
         Xe9xsdBwXzMejkzwZGo3Mc7F3krH+l/Mt1ivkMMEClthCTsntWCRJbE8lOIfXAZ8mQvf
         mIFtqOmrJI8musFV6Ljm98p3TavxEckzMlI9QXfVdcht+k9tN8LSBsZt2rS30zE21/Vk
         2GmebaUCa62q/LtozFvnr8/tYyWdcV+FGxfCgoq9GxCRiz6Lon9U5bGQtvNqzRLBPJIq
         2Uew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=fXirvRF06P7Wgl0SBQNh+LUwZLlKfYncDMKoCadyeek=;
        b=ZOZe/USbGzCUMSBuACj6uAVWyr8flYhOy5UKRCPor2MKNsOVJdb1ZiKaE0f13X5pyA
         8qldtN/K2eihPzMeHhwMZlig+NFkLLSkFSDGma7cMYrKu95/N+UAUOjC3ow8Sg/tVzFL
         QidMRaFy/5hNVpLk/wVyzngSJ07QKsMHRGh0ZSZM6IhUoMcQcDfKx7H6G3UOrLwy3HOe
         eXO/zsWeQM9rVDoeq/rg9smwS9aR2GC7GEwacrekxxC796GLcdJvuRK4TbqfVVHFPm6L
         GHe57E8J8CG5WsOAqChgVtbSoPGpPBJl7j+v8iemyy9SUzKWmxmAmkvY04jX5BuvW5Oh
         o4EA==
X-Gm-Message-State: AOAM532vR2cWdqXeJJ2uXxrN68KGuiT07faCVI2QcpEBBx91c168q/an
        qh5jdL73G2GjfZk9CKYRdJ5gbVdZ0Yo=
X-Google-Smtp-Source: ABdhPJwLYnPfqu31SN3fSiS2bSEl7D9Wc6VB1LOXUm5Yt6BoBHKTRHnmvFTXFWO7dmcIRBHeDpo8eQ==
X-Received: by 2002:a05:620a:2296:: with SMTP id o22mr56580qkh.408.1622143460870;
        Thu, 27 May 2021 12:24:20 -0700 (PDT)
Received: from localhost.localdomain (c-73-60-226-25.hsd1.nh.comcast.net. [73.60.226.25])
        by smtp.gmail.com with ESMTPSA id c20sm1966574qtm.52.2021.05.27.12.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 May 2021 12:24:20 -0700 (PDT)
Date:   Thu, 27 May 2021 15:24:18 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu
Subject: generic/475 failure/BUG on 5.13-rc3 running adv test case
Message-ID: <20210527192418.GA2633@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

As mentioned in today's concall I've seen generic/475 fail when a BUG was
triggered in ext4_write_inline_data() while running the adv test case on
a 5.13-rc3 kernel using kvm-xfstests.  This is not a regression in 5.13.
I had a similar failure in 5.11-rc2, but did not recognize it as a panic
at the time.

More commonly, generic/475 can also fail with a report of an inconsistent file
system and without a panic when run in the adv test case.  The failure
frequency in that case is around 10%, while the frequency for the panic is
5% or less.

I've included the tail end of the log output for a test failure including
the panic below.

Eric


[ 1278.314136] EXT4-fs (dm-0): I/O error while writing superblock
[ 1278.317088] Buffer I/O error on device dm-0, logical block 1282347
[ 1278.317103] Buffer I/O error on device dm-0, logical block 1282348
[ 1278.317112] Buffer I/O error on device dm-0, logical block 1282349
[ 1278.347706] EXT4-fs error (device dm-0): ext4_journal_check_start:83: comm kworker/u4:3: Detected aborted journal
[ 1278.360776] EXT4-fs error (device dm-0): ext4_journal_check_start:83: comm fsstress: Detected aborted journal
[ 1278.370282] EXT4-fs error (device dm-0) in ext4_cross_rename:4241: Journal has aborted
[ 1278.378709] EXT4-fs error (device dm-0): ext4_journal_check_start:83: comm fsstress: Detected aborted journal
[ 1278.396981] EXT4-fs (dm-0): I/O error while writing superblock
[ 1278.397037] EXT4-fs (dm-0): previous I/O error to superblock detected
[ 1278.400830] EXT4-fs (dm-0): I/O error while writing superblock
[ 1278.408834] EXT4-fs (dm-0): Remounting filesystem read-only
[ 1278.413307] EXT4-fs (dm-0): I/O error while writing superblock
[ 1278.413631] EXT4-fs (dm-0): I/O error while writing superblock
[ 1278.418293] EXT4-fs error (device dm-0): ext4_check_bdev_write_error:216: comm fsstress: Error while async write back metadata
[ 1278.422415] EXT4-fs (dm-0): ext4_writepages: jbd2_start: 2048 pages, ino 6750; err -30
[ 1278.432080] ------------[ cut here ]------------
[ 1278.441356] kernel BUG at fs/ext4/inline.c:221!
[ 1278.444944] invalid opcode: 0000 [#1] SMP
[ 1278.448312] CPU: 1 PID: 29573 Comm: fsstress Not tainted 5.13.0-rc3 #1
[ 1278.453230] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
[ 1278.458065] RIP: 0010:ext4_write_inline_data+0xe4/0xf0
[ 1278.462708] Code: 02 48 44 89 e2 48 01 df 5b 5d 4c 01 ef 41 5c 41 5d 41 5e 41 5f e9 fc 71 62 00 41 be 3c 00 00 00 45 8d 64 18 c4 41 29 de eb 93 <0f> 0b 0f 0b c3 0f 1f 80 00 00 00 00 0f 0b 66 66 2e 0f 1f 84 00 00
[ 1278.487953] RSP: 0018:ffffc90006097c80 EFLAGS: 00010246
[ 1278.492630] RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
[ 1278.498757] RDX: ffff88800477a980 RSI: ffffc90006097d30 RDI: ffff8880053673b8
[ 1278.502877] RBP: ffff8880053673b8 R08: 0000000000000080 R09: 0000000000000001
[ 1278.507664] R10: 0000000000000001 R11: 0000000000009923 R12: 0000000000000080
[ 1278.512372] R13: 0000000000000080 R14: ffff8880053673b8 R15: 00000000ffffffe2
[ 1278.516188] FS:  00007f67de588740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[ 1278.521909] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1278.531919] CR2: 00007fc369d9d000 CR3: 0000000009452006 CR4: 0000000000370ee0
[ 1278.542735] Call Trace:
[ 1278.545379]  ext4_convert_inline_data_nolock+0x14d/0x470
[ 1278.549916]  ext4_try_add_inline_entry+0x18a/0x280
[ 1278.553248]  ext4_add_entry+0xd6/0x4c0
[ 1278.555691]  ext4_add_nondir+0x2b/0xc0
[ 1278.558644]  ext4_symlink+0x363/0x3d0
[ 1278.561931]  vfs_symlink+0x113/0x1b0
[ 1278.564528]  do_symlinkat+0xe9/0x100
[ 1278.566882]  do_syscall_64+0x3c/0x80
[ 1278.569255]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 1278.572835] RIP: 0033:0x7f67de676f07
[ 1278.575582] Code: f0 ff ff 73 01 c3 48 8b 0d 86 ef 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 58 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 ef 0c 00 f7 d8 64 89 01 48
[ 1278.587693] RSP: 002b:00007ffe259c92a8 EFLAGS: 00000206 ORIG_RAX: 0000000000000058
[ 1278.593152] RAX: ffffffffffffffda RBX: 0000000000000bbc RCX: 00007f67de676f07
[ 1278.597826] RDX: 0000000000000064 RSI: 0000558fe5501530 RDI: 0000558fe5581380
[ 1278.601987] RBP: 0000558fe5581380 R08: 0000000000000000 R09: 0000558fe5581f40
[ 1278.606045] R10: 0000558fe5500010 R11: 0000000000000206 R12: 0000558fe5501530
[ 1278.610155] R13: 00007ffe259c9410 R14: 0000558fe5581380 R15: 0000558fe4102430
[ 1278.614037] Modules linked in:
[ 1278.615599] ---[ end trace 800a8a9ba6a92f53 ]---
[ 1278.618318] RIP: 0010:ext4_write_inline_data+0xe4/0xf0
[ 1278.622018] Code: 02 48 44 89 e2 48 01 df 5b 5d 4c 01 ef 41 5c 41 5d 41 5e 41 5f e9 fc 71 62 00 41 be 3c 00 00 00 45 8d 64 18 c4 41 29 de eb 93 <0f> 0b 0f 0b c3 0f 1f 80 00 00 00 00 0f 0b 66 66 2e 0f 1f 84 00 00
[ 1278.635759] RSP: 0018:ffffc90006097c80 EFLAGS: 00010246
[ 1278.640398] RAX: 0000000000000000 RBX: 0000000000000080 RCX: 0000000000000000
[ 1278.652894] RDX: ffff88800477a980 RSI: ffffc90006097d30 RDI: ffff8880053673b8
[ 1278.663327] RBP: ffff8880053673b8 R08: 0000000000000080 R09: 0000000000000001
[ 1278.670265] R10: 0000000000000001 R11: 0000000000009923 R12: 0000000000000080
[ 1278.676285] R13: 0000000000000080 R14: ffff8880053673b8 R15: 00000000ffffffe2
[ 1278.681777] FS:  00007f67de588740(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[ 1278.687522] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1278.690965] CR2: 00007fc369d9d000 CR3: 0000000009452006 CR4: 0000000000370ee0
[ 1278.695776] EXT4-fs (dm-0): I/O error while writing superblock
[failed, exit status 1] [16:55:27]- output mismatch (see /results/ext4/results-adv/generic/475.out.bad)
    --- tests/generic/475.out	2021-04-13 03:49:18.000000000 +0000
    +++ /results/ext4/results-adv/generic/475.out.bad	2021-05-27 16:55:27.152702989 +0000
    @@ -1,2 +1,6 @@
     QA output created by 475
     Silence is golden.
    +umount: /vdc: target is busy.
    +unmount failed
    +(see /results/ext4/results-adv/generic/475.full for details)
    +umount: /vdc: target is busy.

