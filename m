Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1AA65CEFF
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Jan 2023 10:04:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233832AbjADJDm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Jan 2023 04:03:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233616AbjADJDM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Jan 2023 04:03:12 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D92CC1;
        Wed,  4 Jan 2023 01:03:11 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g1so33437380edj.8;
        Wed, 04 Jan 2023 01:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=v14YvbLcvOvEEBLM4yEOrYyC0ZeYfeUq6338/1b7iTU=;
        b=BSoNnQgHQLxRFG+gbiQo/TGHclyNKaui+czns0YMlPb92Dk9YKJcdj3TUIz03DT3h0
         IgTEKTa59lyp345x+wGtQqGrKi71zvQ9IglCec3lJCpC1PJxvSaHtipAQfXd1H1IHied
         p7FGmSceo3U1Li/GgHQwaEujwz4iLLP9tZp3pL4GUtA8FZjIGzJJkCXMLBAatKcURvhp
         M+JFSRJJhes9+9v0HGEitWlighW2Wy7TeQ0VRsSu2FDBWGFyMOYkXkfsHv7VNlWUcvui
         1wpNCc72xHdt57239zJpyDyv4ZlBTbNLltC9mAUduASFZJZBMaD2y9wQrphnNPRFvgs8
         5dcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v14YvbLcvOvEEBLM4yEOrYyC0ZeYfeUq6338/1b7iTU=;
        b=3fYl7Oy9RJM29UhsGqXjcAbWYnzji3ivqf4WHK/0ryzir0dKtR3YQCsDVqRbV3ZzU7
         vcPk9LjZZ80GRWLMLC0nsEo5gN1gXAvNCx6r/GRo7XU4JMXCteUlHfm7h6vdVlC811dW
         DUL0a7fYxfxsSYlP0PCpdWFrvBglz9zHLgfF/yMEeCGuNetP9XtKvi+lVlZ49A/QsPV+
         NqSowiLJNByXSKmK+KPJ/pg01uPmAGuAQQfIjU/t+LCL4z2ukltGuR3kyfVsNLGYVBls
         Iq4bPKOtsItVeTdPPQlJIoDK+DKcDYlsP5cVcjMKLagW8Yfux1sCrFmdMw25Y8/86k5w
         8SzA==
X-Gm-Message-State: AFqh2kpYE1ZsKo2eeLfofvU/aompIQFUHxX/HOGXZqNbHot7fLnnY7cD
        +DH4L1VWAoYcOuNRv5ZXaQBE8Gd1XGrh55XMlCI/0YY4W2yniw==
X-Google-Smtp-Source: AMrXdXvNh6m6TnHYN5XuyeXe7H0PtAz883yuvOE+9MqHXhy7M46vdbImBa03sPvDjyk9iZxE19AloEUqoT0Dq8Xybcw=
X-Received: by 2002:a05:6402:1b10:b0:485:59b5:d8c9 with SMTP id
 by16-20020a0564021b1000b0048559b5d8c9mr3777154edb.285.1672822989432; Wed, 04
 Jan 2023 01:03:09 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Wed, 4 Jan 2023 17:02:33 +0800
Message-ID: <CAO4mrfcFp4YDvuCEMhe_0qizVf1XL3MjEk2PX10LW5f_4LKmbQ@mail.gmail.com>
Subject: BUG: corrupted list in mb_update_avg_fragment_size
To:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        tytso@mit.edu, adilger.kernel@dilger.ca,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzkaller@googlegroups.com>, tudor.ambarus@linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Dear Linux Developers,

Recently, when using our tool to fuzz kernel, the following crash was triggered.

HEAD commit: e45fb347b630 Linux 6.1.0-next-20221220
git tree: linux-next
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1gh6F0I93Cdy8zQ1tv-L5kCaBGkd2tXhp/view?usp=share_link
kernel config: https://drive.google.com/file/d/1mMD6aopttKDGK4aYUlgiwAk6bOQHivd-/view?usp=share_link

Unfortunately, I didn't find a reproducer for this crash yet.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

list_add corruption. prev is NULL.
------------[ cut here ]------------
kernel BUG at lib/list_debug.c:24!
invalid opcode: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 19499 Comm: syz-executor.0 Not tainted 6.1.0-next-20221220 #6
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:__list_add_valid+0x73/0xc0 lib/list_debug.c:23
Code: 41 5f c3 48 c7 c7 70 3d 65 85 4c 89 fe 48 89 da 4c 89 f1 31 c0
e8 0d 2f 02 03 0f 0b 48 c7 c7 6f 3c 65 85 31 c0 e8 fd 2e 02 03 <0f> 0b
48 c7 c7 a6 3c 65 85 31 c0 e8 ed 2e 02 03 0f 0b 48 c7 c7 cc
RSP: 0018:ffffc90005b97730 EFLAGS: 00010246
RAX: 0000000000000022 RBX: ffff88800a6257e8 RCX: 113c3aae3e481700
RDX: ffffc90000b35000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 0000000000000000 R08: ffffffff81179fd9 R09: 0000000000000000
R10: 0001ffffffffffff R11: 000188807dc1b588 R12: ffff88800945a6d8
R13: ffff88800a6257e0 R14: ffff88800945a678 R15: 00000000000001e0
FS:  00007fc40c27d700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31522000 CR3: 000000005ccbd000 CR4: 00000000003506f0
DR0: 0000000020000140 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 __list_add include/linux/list.h:69 [inline]
 list_add_tail include/linux/list.h:102 [inline]
 mb_update_avg_fragment_size+0x26c/0x2e0 fs/ext4/mballoc.c:849
 mb_mark_used+0xb5c/0xcc0 fs/ext4/mballoc.c:1958
 ext4_mb_use_best_found+0x105/0x440 fs/ext4/mballoc.c:1979
 ext4_mb_find_by_goal+0x58b/0x660
 ext4_mb_regular_allocator+0x126/0x1e00 fs/ext4/mballoc.c:2614
 ext4_mb_new_blocks+0x828/0x1240 fs/ext4/mballoc.c:5605
 ext4_ext_map_blocks+0x1545/0x1f20 fs/ext4/extents.c:4286
 ext4_map_blocks+0x748/0x1060 fs/ext4/inode.c:651
 ext4_alloc_file_blocks+0x285/0x720 fs/ext4/extents.c:4470
 ext4_fallocate+0x2c5/0x570 fs/ext4/extents.c:4757
 vfs_fallocate+0x486/0x710 fs/open.c:323
 ksys_fallocate fs/open.c:346 [inline]
 __do_sys_fallocate fs/open.c:354 [inline]
 __se_sys_fallocate fs/open.c:352 [inline]
 __x64_sys_fallocate+0x75/0xc0 fs/open.c:352
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4697f9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc40c27cc48 EFLAGS: 00000246 ORIG_RAX: 000000000000011d
RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004697f9
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000006
RBP: 00000000004d29e9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000080000941 R11: 0000000000000246 R12: 000000000077bf80
R13: 0000000000000000 R14: 000000000077bf80 R15: 00007ffd6cd30fb0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_add_valid+0x73/0xc0 lib/list_debug.c:23
Code: 41 5f c3 48 c7 c7 70 3d 65 85 4c 89 fe 48 89 da 4c 89 f1 31 c0
e8 0d 2f 02 03 0f 0b 48 c7 c7 6f 3c 65 85 31 c0 e8 fd 2e 02 03 <0f> 0b
48 c7 c7 a6 3c 65 85 31 c0 e8 ed 2e 02 03 0f 0b 48 c7 c7 cc
RSP: 0018:ffffc90005b97730 EFLAGS: 00010246
RAX: 0000000000000022 RBX: ffff88800a6257e8 RCX: 113c3aae3e481700
RDX: ffffc90000b35000 RSI: 000000000003ffff RDI: 0000000000040000
RBP: 0000000000000000 R08: ffffffff81179fd9 R09: 0000000000000000
R10: 0001ffffffffffff R11: 000188807dc1b588 R12: ffff88800945a6d8
R13: ffff88800a6257e0 R14: ffff88800945a678 R15: 00000000000001e0
FS:  00007fc40c27d700(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31522000 CR3: 000000005ccbd000 CR4: 00000000003506f0
DR0: 0000000020000140 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600

Best,
Wei
