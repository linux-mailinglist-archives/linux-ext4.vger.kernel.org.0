Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBE1E542F4B
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Jun 2022 13:36:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiFHLgW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Jun 2022 07:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234287AbiFHLgW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 8 Jun 2022 07:36:22 -0400
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBE0515A400
        for <linux-ext4@vger.kernel.org>; Wed,  8 Jun 2022 04:36:20 -0700 (PDT)
Received: by mail-il1-f200.google.com with SMTP id i16-20020a056e021d1000b002d3bbe39232so15549374ila.20
        for <linux-ext4@vger.kernel.org>; Wed, 08 Jun 2022 04:36:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=3oh0j0r/IvU5Q15Oq1z/arbGf3o7scCG5pylpXc2HMs=;
        b=MqeBo77z32huEe+XJ2Q4iUQV8JkQ/uMZm4zNqpNg3iRIrpYMPfx2J4CIZj25kGpjsA
         BZj6CO7TM6qXO6GDSO62r9QIeNUSTk8Cv+3z9ZAQp9LYkRagiSF5Ke8siiUlxw33JScz
         yVCwFYlIw2FTWHOJzfMoKZd5bxm8w/uVrASQD8DI8YDvB8rtwmByH/ihrPFimBIxpTuC
         TD/93Qpx4s6O4tNZr1OhcaYnXKdD2MJyo6tDPk1KM/jnrfjcbSf7Rw5NgMj/4wUZYISq
         WyBInAeCcOj6kNePWEPJ4u9gkN7mt1R8vslzuB9uK/vdPzrxkb/XsgMWtqk/R9M+5Dp3
         x6Mw==
X-Gm-Message-State: AOAM531Sa57aYXgAa51Y0eyIPigNAHCV/HITJU30ChLfiPWXtliFaAYz
        vXgBWLEvt0+la9fEcvSTo0FXE8pnkkNJLG/yPHakjx/IbPea
X-Google-Smtp-Source: ABdhPJzySLdxT3hV87AdUk+8VZW4dLmut3dsz1tAJysyLzzaE7t8ot8FY+D6yRCCtxLaMwIXbJ8LKk1ZllCkLoG6hgiHTzozmh0g
MIME-Version: 1.0
X-Received: by 2002:a02:cd36:0:b0:331:56a4:7a32 with SMTP id
 h22-20020a02cd36000000b0033156a47a32mr17967171jaq.209.1654688180167; Wed, 08
 Jun 2022 04:36:20 -0700 (PDT)
Date:   Wed, 08 Jun 2022 04:36:20 -0700
In-Reply-To: <0000000000003fb2e905db20ac96@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000031695705e0ee1d58@google.com>
Subject: Re: [syzbot] WARNING in ext4_dirty_folio
From:   syzbot <syzbot+ecab51a4a5b9f26eeaa1@syzkaller.appspotmail.com>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, tytso@mit.edu
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

HEAD commit:    cf67838c4422 selftests net: fix bpf build error
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=123c2173f00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fc5a30a131480a80
dashboard link: https://syzkaller.appspot.com/bug?extid=ecab51a4a5b9f26eeaa1
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1342d5abf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ecafebf00000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ecab51a4a5b9f26eeaa1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 4160 at fs/ext4/inode.c:3611 ext4_dirty_folio+0xf4/0x120 fs/ext4/inode.c:3611
Modules linked in:
CPU: 1 PID: 4160 Comm: syz-executor368 Not tainted 5.18.0-syzkaller-12117-gcf67838c4422 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
RIP: 0010:ext4_dirty_folio+0xf4/0x120 fs/ext4/inode.c:3611
Code: 1b 31 ff 48 c1 eb 03 83 e3 01 89 de e8 55 bf 5b ff 84 db 0f 85 72 ff ff ff e8 48 c3 5b ff 0f 0b e9 66 ff ff ff e8 3c c3 5b ff <0f> 0b eb 88 48 89 df e8 60 83 a8 ff e9 3d ff ff ff e8 56 83 a8 ff
RSP: 0018:ffffc90003dc7bd0 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: ffff88801e3d3b00 RSI: ffffffff821ec114 RDI: ffffea0001c4f3a8
RBP: ffffea0001c4f380 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: ffff88806f147330
R13: dffffc0000000000 R14: ffffea0001c4f300 R15: ffffea0001c4f380
FS:  00007f6e25759700(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000002000008c CR3: 0000000026be0000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 folio_mark_dirty+0xc1/0x140 mm/page-writeback.c:2723
 unpin_user_pages_dirty_lock mm/gup.c:334 [inline]
 unpin_user_pages_dirty_lock+0x411/0x4c0 mm/gup.c:297
 xdp_umem_unpin_pages net/xdp/xdp_umem.c:28 [inline]
 xdp_umem_pin_pages net/xdp/xdp_umem.c:123 [inline]
 xdp_umem_reg net/xdp/xdp_umem.c:219 [inline]
 xdp_umem_create+0xced/0x1180 net/xdp/xdp_umem.c:252
 xsk_setsockopt+0x73e/0x9e0 net/xdp/xsk.c:1094
 __sys_setsockopt+0x2db/0x6a0 net/socket.c:2259
 __do_sys_setsockopt net/socket.c:2270 [inline]
 __se_sys_setsockopt net/socket.c:2267 [inline]
 __x64_sys_setsockopt+0xba/0x150 net/socket.c:2267
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0
RIP: 0033:0x7f6e257c9a79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 15 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6e25759308 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007f6e258534f8 RCX: 00007f6e257c9a79
RDX: 0000000000000004 RSI: 000000000000011b RDI: 0000000000000006
RBP: 00007f6e258534f0 R08: 0000000000200d6f R09: 0000000000000000
R10: 0000000020000040 R11: 0000000000000246 R12: 00007f6e258534fc
R13: 00007f6e2582029c R14: 652e79726f6d656d R15: 0000000000022000
 </TASK>

