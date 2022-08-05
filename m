Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A13758AA4E
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Aug 2022 13:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237631AbiHELqf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Aug 2022 07:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235249AbiHELqe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Aug 2022 07:46:34 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E60931238
        for <linux-ext4@vger.kernel.org>; Fri,  5 Aug 2022 04:46:33 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id z11-20020a05660217cb00b0067c63cf0236so1256776iox.13
        for <linux-ext4@vger.kernel.org>; Fri, 05 Aug 2022 04:46:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc;
        bh=0VzqJygc5Za6Af8Uvt2WofNNb8ZfUsjKpLmF8pLSvZk=;
        b=QJPGLfq66i6gkYHxzlkjq8kRcU2QhMyP99PBUWWCjF/rl3cxufIvXFU8D92uXdmFEa
         f0ZL27kN18SM8zeK7ky5gEyQsDe8XFDgsgKcqqVkMVKYpL6AbBUk9j50w/nqmxjziGYe
         UZ4cAmX+/Rrsm50I4V+K4F065b8z9YeG/Ro1H04E46EsMjEdxaLJYBfr3huAO0gicRVs
         vwAdlAHaW9lCzh8gG8nTWq82wLE31x/CanZO4GzMdR2sIf23WSkdi1KpCJd2jrkEj4UH
         yB5KkJj7D+CqageALN44tvTlwGd63Hb22B+VrBQgZd1AWrn/jK4c9jNVqTcPaokyZtz2
         iIHw==
X-Gm-Message-State: ACgBeo1KeFfjRAGOZpAa9Ztvrci1C9mxA3ftfyzh3VXL2HaR30YQRjdD
        SCiyQ+ovVupI1Gmv/csVp1aoOVz32wlemQI9xa2e5F80vVub
X-Google-Smtp-Source: AA6agR7Cipv2HUy00gO8pSrxtUAcvbMrVKwx77m//+jLEVApWjB/QxRWVj/of4qt3UGst/LEqj9r4gC9iaNUN/3II7mQs+huBpr1
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0e:b0:2df:622c:37cd with SMTP id
 l14-20020a056e021c0e00b002df622c37cdmr2989419ilh.234.1659699992516; Fri, 05
 Aug 2022 04:46:32 -0700 (PDT)
Date:   Fri, 05 Aug 2022 04:46:32 -0700
In-Reply-To: <0000000000008f6d2005c9e53c59@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007ce13a05e57d0418@google.com>
Subject: Re: [syzbot] kernel BUG in ext4_get_group_info
From:   syzbot <syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com>
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

HEAD commit:    200e340f2196 Merge tag 'pull-work.dcache' of git://git.ker..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15a655b6080000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a3f4d6985d3164cd
dashboard link: https://syzkaller.appspot.com/bug?extid=e2efa3efc15a1c9e95c3
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b248e1080000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11ba3e3e080000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e2efa3efc15a1c9e95c3@syzkaller.appspotmail.com

EXT4-fs (loop0): ext4_check_descriptors: Checksum for group 0 failed (14603!=0)
EXT4-fs (loop0): orphan cleanup on readonly fs
EXT4-fs error (device loop0): ext4_mb_clear_bb:5962: comm syz-executor137: Freeing blocks in system zone - Block = 16, count = 16
EXT4-fs (loop0): Remounting filesystem read-only
------------[ cut here ]------------
kernel BUG at fs/ext4/ext4.h:3319!
invalid opcode: 0000 [#1] PREEMPT SMP KASAN
CPU: 1 PID: 3607 Comm: syz-executor137 Not tainted 5.19.0-syzkaller-02972-g200e340f2196 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
RIP: 0010:ext4_get_group_info+0x36e/0x3d0 fs/ext4/ext4.h:3319
Code: ff 48 c7 c2 a0 b5 e2 89 be c3 02 00 00 48 c7 c7 00 b6 e2 89 c6 05 39 e3 89 0b 01 e8 fc 1d 16 07 e9 d9 fd ff ff e8 22 af 5d ff <0f> 0b e8 9b 76 aa ff e9 ea fc ff ff e8 91 76 aa ff e9 24 fd ff ff
RSP: 0018:ffffc90002fcf210 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: ffff888024b99d80 RSI: ffffffff821d2a9e RDI: 0000000000000004
RBP: ffff888021e86000 R08: 0000000000000004 R09: 0000000000000001
R10: 00000000ffffffff R11: 0000000000000001 R12: ffff888021ee2000
R13: ffff888021ee2678 R14: 0000000000000001 R15: dffffc0000000000
FS:  00005555570a1300(0000) GS:ffff8880b9b00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000005ded08 CR3: 0000000025559000 CR4: 0000000000350ee0
Call Trace:
 <TASK>
 ext4_mb_clear_bb fs/ext4/mballoc.c:5935 [inline]
 ext4_free_blocks+0x4a2/0x2060 fs/ext4/mballoc.c:6185
 ext4_clear_blocks+0x329/0x430 fs/ext4/indirect.c:880
 ext4_free_data+0x1a3/0x3e0 fs/ext4/indirect.c:954
 ext4_ind_truncate+0x6a2/0x950 fs/ext4/indirect.c:1146
 ext4_truncate+0x696/0x1440 fs/ext4/inode.c:4244
 ext4_evict_inode+0xa5f/0x1970 fs/ext4/inode.c:284
 evict+0x2ed/0x6b0 fs/inode.c:664
 iput_final fs/inode.c:1744 [inline]
 iput.part.0+0x562/0x820 fs/inode.c:1770
 iput+0x58/0x70 fs/inode.c:1760
 ext4_quota_enable fs/ext4/super.c:6781 [inline]
 ext4_enable_quotas+0x5c4/0xb70 fs/ext4/super.c:6804
 ext4_orphan_cleanup+0xde1/0x10f0 fs/ext4/orphan.c:432
 __ext4_fill_super fs/ext4/super.c:5368 [inline]
 ext4_fill_super+0xac9a/0xe830 fs/ext4/super.c:5507
 get_tree_bdev+0x440/0x760 fs/super.c:1292
 vfs_get_tree+0x89/0x2f0 fs/super.c:1497
 do_new_mount fs/namespace.c:3040 [inline]
 path_mount+0x1320/0x1fa0 fs/namespace.c:3370
 do_mount fs/namespace.c:3383 [inline]
 __do_sys_mount fs/namespace.c:3591 [inline]
 __se_sys_mount fs/namespace.c:3568 [inline]
 __x64_sys_mount+0x27f/0x300 fs/namespace.c:3568
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x7fa6cfe974da
Code: 83 c4 08 5b 5d c3 66 2e 0f 1f 84 00 00 00 00 00 c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 c0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc803cf6f8 EFLAGS: 00000206 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffc803cf750 RCX: 00007fa6cfe974da
RDX: 0000000020000000 RSI: 0000000020000040 RDI: 00007ffc803cf710
RBP: 00007ffc803cf710 R08: 00007ffc803cf750 R09: 0000000800000015
R10: 0000000000000081 R11: 0000000000000206 R12: 0000000000000004
R13: 0000000000000003 R14: 0000000000000003 R15: 0000000000000010
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ext4_get_group_info+0x36e/0x3d0 fs/ext4/ext4.h:3319
Code: ff 48 c7 c2 a0 b5 e2 89 be c3 02 00 00 48 c7 c7 00 b6 e2 89 c6 05 39 e3 89 0b 01 e8 fc 1d 16 07 e9 d9 fd ff ff e8 22 af 5d ff <0f> 0b e8 9b 76 aa ff e9 ea fc ff ff e8 91 76 aa ff e9 24 fd ff ff
RSP: 0018:ffffc90002fcf210 EFLAGS: 00010293
RAX: 0000000000000000 RBX: 00000000ffffffff RCX: 0000000000000000
RDX: ffff888024b99d80 RSI: ffffffff821d2a9e RDI: 0000000000000004
RBP: ffff888021e86000 R08: 0000000000000004 R09: 0000000000000001
R10: 00000000ffffffff R11: 0000000000000001 R12: ffff888021ee2000
R13: ffff888021ee2678 R14: 0000000000000001 R15: dffffc0000000000
FS:  00005555570a1300(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc803d0000 CR3: 0000000025559000 CR4: 0000000000350ef0

