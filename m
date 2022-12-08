Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FD0646F9E
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Dec 2022 13:28:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbiLHM2C (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Dec 2022 07:28:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbiLHM2B (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Dec 2022 07:28:01 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F8DA1FCC0;
        Thu,  8 Dec 2022 04:27:59 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id vv4so3485875ejc.2;
        Thu, 08 Dec 2022 04:27:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=PukXWO5SmT2z9VgFFF86WSApelvOrN04uHodxuaqNzQ=;
        b=RUrsS1eSXdzkcS5OdrG26WOFGQ/H4oCfgPOjYUjLX/MksZcRQS3jUDpC8fTLpaDTtG
         bfAz9JqkLj0QqKh+U6huajL3oTQjMt8hCcIFAMd+l9dasIwbUOpZQ7X0yaj4j3ckEpPJ
         rKu9SBMPEGx3zL9s4myPkjQ1W2ibseB3kSyrr4yUUqw2pEGS9ylF47qKS4EQYameCsdc
         oi4yT8GeS0cKY0++86xfY37motW4GkAoScKyafv5Lc0HP/sxFKHmSWw4ouCVhIF4Pw3H
         A5rN1ib31xuXvXx2s5HuUfILIadJZRVriTF+kGbLPSDTiC1Ur9M9bRW6aWPUbi3lBOhm
         LkCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PukXWO5SmT2z9VgFFF86WSApelvOrN04uHodxuaqNzQ=;
        b=lwGnjgkmuYF3TGlp77yC44elEExokp9kSqCEvZsPW5hrvlZ67CUD2Ram0D2x6zolxI
         eupDybBYLdZ6lqNjOgSPzkZ2Jqfwa3ESBKx/AVTvRLtak+kiTcaMN3QJ1o4VTcW7ZCHy
         ukZOe/PkNZYKlWcC8Ebvpx5gID2jHKyo4cV487hXEBZO/e9Z35XKGMgWo3OI7fZJNGeO
         f84hV9yTzqD9TYcfkx2SfrjFAVQZ/InTetZhl61oadY60TSkjTTNFOFyNRjVJQEaS64Z
         y07aq1oYptpN58SogNMdhENzCiXcpCUl6aDN2HTQJToD8x7VAIQ4mYdNcucT5fdrLwyH
         fttA==
X-Gm-Message-State: ANoB5pkD90RyLqaL0Yzsb9dnv1qtu43yvS0fq+lG4TahCW85RR3Z9RM9
        wS1p/dd5nDvS3B2XOevIPc8/yD0XrMLrCqs1/U4=
X-Google-Smtp-Source: AA0mqf7W+cX92/lAL3v4QcegbEvEVadjdBSKKpyZ5ZvvELwTSlGUGPcWXf1FXoOypKYxcW2oQXxbmuT1Q5zSrQGRD+w=
X-Received: by 2002:a17:906:ce44:b0:7c0:e81a:5564 with SMTP id
 se4-20020a170906ce4400b007c0e81a5564mr15868079ejb.421.1670502477858; Thu, 08
 Dec 2022 04:27:57 -0800 (PST)
MIME-Version: 1.0
From:   Wei Chen <harperchen1110@gmail.com>
Date:   Thu, 8 Dec 2022 20:27:24 +0800
Message-ID: <CAO4mrferzqBUnCag8R3m2zf897ts9UEuhjFQGPtODT92rYyR2Q@mail.gmail.com>
Subject: divide error in mb_update_avg_fragment_size
To:     tytso@mit.edu, adilger.kernel@dilger.ca,
        syzbot <syzkaller@googlegroups.com>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
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

HEAD commit: 147307c69ba
git tree: linux-next
compiler: clang 12.0.0
console output:
https://drive.google.com/file/d/1tComytzKYQKzKfiS1PwrKBLQJwZn4usl/view?usp=share_link
kernel config: https://drive.google.com/file/d/1NAf4S43d9VOKD52xbrqw-PUP1Mbj8z-S/view?usp=share_link

Unfortunately, I didn't have a reproducer for this crash. When calling
ioctl with command FITRIM, the variable grp->bb_fragments is zero,
thus leading to divide error when executing grp->bb_free /
grp->bb_fragments. I'm wondering if a sanity check is missing when
handling malicious disk image.

IMPORTANT: if you fix the bug, please add the following tag to the commit:
Reported-by: Wei Chen <harperchen1110@gmail.com>

divide error: 0000 [#1] PREEMPT SMP
CPU: 0 PID: 8874 Comm: syz-executor.0 Not tainted 6.1.0-rc5-next-20221118 #2
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS
rel-1.13.0-48-gd9c812dda519-prebuilt.qemu.org 04/01/2014
RIP: 0010:mb_update_avg_fragment_size+0x84/0x2e0 fs/ext4/mballoc.c:835
Code: 41 5f 5d c3 49 8d 7e 14 e8 a9 38 ca ff 41 8b 5e 14 31 ff 89 de
e8 ac d3 b6 ff 85 db 74 61 49 8d 7e 18 e8 8f 38 ca ff 89 d8 99 <41> f7
7e 18 89 44 24 14 bb ff ff ff ff 0f bd 5c 24 14 8d 73 ff 45
RSP: 0018:ffffc90001bf3a60 EFLAGS: 00010246
RAX: 0000000000000456 RBX: 0000000000000456 RCX: ffffffff8170e251
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88810204e018
RBP: ffff8881030de800 R08: 000188810204e01b R09: 0000000000000000
R10: 0001ffffffffffff R11: 000188810204e020 R12: 0000000000008000
R13: ffff88810315b000 R14: ffff88810204e000 R15: ffffc90001bf3cc0
FS:  00007f4a1db97700(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ebcf207bd0 CR3: 0000000131681000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 mb_mark_used+0xb5c/0xcc0 fs/ext4/mballoc.c:1958
 ext4_trim_extent+0xd4/0x340 fs/ext4/mballoc.c:6352
 ext4_try_to_trim_range+0x194/0x460 fs/ext4/mballoc.c:6382
 ext4_trim_all_free+0x26e/0x3d0 fs/ext4/mballoc.c:6444
 ext4_trim_fs+0x56b/0x6d0 fs/ext4/mballoc.c:6540
 __ext4_ioctl+0x13b6/0x2990 fs/ext4/ioctl.c:1483
 ext4_ioctl+0x1e/0x30 fs/ext4/ioctl.c:1606
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:870 [inline]
 __se_sys_ioctl+0xcb/0x140 fs/ioctl.c:856
 __x64_sys_ioctl+0x3f/0x50 fs/ioctl.c:856
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x2b/0x70 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x63/0xcd
RIP: 0033:0x4697f9
Code: f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 48 89 f8 48
89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d
01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f4a1db96c48 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000077bf80 RCX: 00000000004697f9
RDX: 0000000020000040 RSI: 00000000c0185879 RDI: 0000000000000004
RBP: 00000000004d29e9 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 000000000077bf80
R13: 0000000000000000 R14: 000000000077bf80 R15: 00007fffbabb2d30
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mb_update_avg_fragment_size+0x84/0x2e0 fs/ext4/mballoc.c:835
Code: 41 5f 5d c3 49 8d 7e 14 e8 a9 38 ca ff 41 8b 5e 14 31 ff 89 de
e8 ac d3 b6 ff 85 db 74 61 49 8d 7e 18 e8 8f 38 ca ff 89 d8 99 <41> f7
7e 18 89 44 24 14 bb ff ff ff ff 0f bd 5c 24 14 8d 73 ff 45
RSP: 0018:ffffc90001bf3a60 EFLAGS: 00010246
RAX: 0000000000000456 RBX: 0000000000000456 RCX: ffffffff8170e251
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88810204e018
RBP: ffff8881030de800 R08: 000188810204e01b R09: 0000000000000000
R10: 0001ffffffffffff R11: 000188810204e020 R12: 0000000000008000
R13: ffff88810315b000 R14: ffff88810204e000 R15: ffffc90001bf3cc0
FS:  00007f4a1db97700(0000) GS:ffff88813bc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055ebcf207bd0 CR3: 0000000131681000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
----------------
Code disassembly (best guess):
   0: 41 5f                 pop    %r15
   2: 5d                   pop    %rbp
   3: c3                   retq
   4: 49 8d 7e 14           lea    0x14(%r14),%rdi
   8: e8 a9 38 ca ff       callq  0xffca38b6
   d: 41 8b 5e 14           mov    0x14(%r14),%ebx
  11: 31 ff                 xor    %edi,%edi
  13: 89 de                 mov    %ebx,%esi
  15: e8 ac d3 b6 ff       callq  0xffb6d3c6
  1a: 85 db                 test   %ebx,%ebx
  1c: 74 61                 je     0x7f
  1e: 49 8d 7e 18           lea    0x18(%r14),%rdi
  22: e8 8f 38 ca ff       callq  0xffca38b6
  27: 89 d8                 mov    %ebx,%eax
  29: 99                   cltd
* 2a: 41 f7 7e 18           idivl  0x18(%r14) <-- trapping instruction
  2e: 89 44 24 14           mov    %eax,0x14(%rsp)
  32: bb ff ff ff ff       mov    $0xffffffff,%ebx
  37: 0f bd 5c 24 14       bsr    0x14(%rsp),%ebx
  3c: 8d 73 ff             lea    -0x1(%rbx),%esi
  3f: 45                   rex.RB

Best,
Wei
