Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0539074A249
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Jul 2023 18:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231466AbjGFQgu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 6 Jul 2023 12:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjGFQgt (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 6 Jul 2023 12:36:49 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F2831703
        for <linux-ext4@vger.kernel.org>; Thu,  6 Jul 2023 09:36:48 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-4035441869fso6631871cf.3
        for <linux-ext4@vger.kernel.org>; Thu, 06 Jul 2023 09:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688661407; x=1691253407;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=89CwZx6yCxx/IPOug4xJ3oqiiv0qEE5wgq06/Da2ZjQ=;
        b=Ab/+16MOQwcCsA+L8AiAn3J/FJop3BMgRROWqboM19XAGKG5W7DmG0Yq7TPSlurClS
         L8TZ5Lk2dPeG9hLajcIHlbxJm4J9Pbjqzgk48YaNe1LEAOncSoGPO3FKvP4ZdhFxtDkX
         adyYGP5Vv9jzU+WuE75Co0ipGal/LdYiiXMzTsNTUqxG4b+QtXF2fgsbl4dmNS/+EbJE
         xYMXNIYUYInf3EFhTVmHET0VZGnqnXLuT8RfoFGRFq06Nv6NAvQB0HaunXas9oDq3CQK
         qA+VXUEeU3OKdu1+7RJfJLpFvxUh5Bbz41qDFUj4kSHpg7NTStBB20yxb5+9HwiUSi31
         Fpzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688661407; x=1691253407;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=89CwZx6yCxx/IPOug4xJ3oqiiv0qEE5wgq06/Da2ZjQ=;
        b=i8zHPW9aG0WmpEiLxgDuOz/AZq137KIZy22ETEim3Uf9qZ0L1AGREsVNhVcDW82JkV
         p8P+DUqy9YB4cIg8KLRxHKb1BfvU2GkGpb390D7pEgRDQ3KfBSaFX5UCm9ukNm++uUWT
         xvLjftB7SKZ8rLcPFJGcvE3RJ0cTc49Wb2ULqy5kfew6gfdxcdMmReFKf4nw0xMzz5wE
         1dr+TvcQduUoiq1tLEtqCXYUzkx2lGtqNqGIJVS4ffwZoM/8IUOartSjQyQ4AYBkeMgZ
         DtVowGQhJVr3f4lr0+FUZp4OeHLJgIuxivXnHlqXwVU1yLRZ0SLOCizHeX6s2kiEFcrM
         9VJw==
X-Gm-Message-State: ABy/qLbqrmG2+t5WXLXfUOCVnMVhs75Z95EO6Vjr+VRMwZjIjsGs4NTt
        RZ2tqsh5mO24DrmO3ZHdC7OYRa7ey1A=
X-Google-Smtp-Source: APBJJlHNOVlHX4/gXxZCTE8GIFT2jM8RVZBso6R9R4qOTdWHbwMu2rS2gaCvKJSmUA9S0H0L0j+bQQ==
X-Received: by 2002:ac8:7dd6:0:b0:3dc:fa58:97fd with SMTP id c22-20020ac87dd6000000b003dcfa5897fdmr3214297qte.25.1688661407463;
        Thu, 06 Jul 2023 09:36:47 -0700 (PDT)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id h2-20020ac85482000000b00401eafa8f1fsm777004qtq.24.2023.07.06.09.36.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jul 2023 09:36:47 -0700 (PDT)
Date:   Thu, 6 Jul 2023 12:36:45 -0400
From:   Eric Whitney <enwlinux@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, ojaswin@linux.ibm.com
Subject: generic/269 failure on ext4 dev branch
Message-ID: <ZKbtnaXWgZ6eDK0N@debian-BULLSEYE-live-builder-AMD64>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I've discovered that generic/269 will trigger a BUG_ON on line 5070 in
ext4_mb_new_inode_pa when running kvm-xfstests on the 1k test case
with a kernel built from the current ext4 dev branch. After hitting the
BUG_ON, the kernel then reports persistent soft lockups.  I mentioned this in
today's concall, and Ted confirmed the current dev branch should reflect
what's upstream at this time.

This test reproduces for me 5 to 10% of the time, but reliably enough - I
typically don't need more than 25 trials to see the failure, and 10 often
suffices. (I haven't yet tried the 4k test case, but will do so.)

The failure bisects to:
7e170922f06b ("ext4: Add allocation criteria 1.5 (CR1_5)")

Trace follows.

Eric


generic/269 24s ...  [21:41:11][  284.208474] run fstests generic/269 at 2023-07-03 21:41:11
[  284.511484] EXT4-fs (vdc): mounted filesystem 2b1fbdd6-2724-47bc-b7b5-f4a73c9f19be r/w with ordered data mode. Quota mode: none.
[  284.950657] ------------[ cut here ]------------
[  284.950901] kernel BUG at fs/ext4/mballoc.c:5070!
[  284.951104] invalid opcode: 0000 [#1] PREEMPT SMP
[  284.951296] CPU: 0 PID: 12039 Comm: fsstress Not tainted 6.4.0-rc5+ #6
[  284.951567] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.14.0-2 04/01/2014
[  284.951900] RIP: 0010:ext4_mb_new_inode_pa+0x2a6/0x2c0
[  284.952124] Code: b5 7e 0f 85 b5 fe ff ff 0f 1f 44 00 00 e9 ab fe ff ff e8 9d 56 d3 ff 84 c0 0f 85 b5 fe ff ff 0f 0b e9 ae fe ff ff 0f 0b 0f 0b <0f> 0b 0f 0b 0f 0b 0f 0b 4c 89 c1 31 c0 e9 42 ff ff ff 0f 1f 84 00
[  284.952891] RSP: 0018:ffffc90004053970 EFLAGS: 00010a87
[  284.953124] RAX: 0000000000000002 RBX: ffff8880342d0720 RCX: 0000000000000001
[  284.953420] RDX: 0000000000004000 RSI: 00001e4000000000 RDI: ffff8880342d0720
[  284.953720] RBP: ffffc90004053a00 R08: ffff88800a5fc000 R09: 0000000000000000
[  284.954020] R10: ffff888007964a98 R11: 0000000000000002 R12: 0000000000000003
[  284.954321] R13: ffff8880342d0720 R14: ffff88800a5fc000 R15: ffff88800abfc000
[  284.954610] FS:  00007f3d9db07740(0000) GS:ffff88807dc00000(0000) knlGS:0000000000000000
[  284.954923] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  284.955148] CR2: 000055b54ce0fde8 CR3: 0000000006730006 CR4: 0000000000770ef0
[  284.955443] PKRU: 55555554
[  284.955559] Call Trace:
[  284.955669]  <TASK>
[  284.955760]  ? die+0x33/0x90
[  284.955887]  ? do_trap+0xe0/0x110
[  284.956031]  ? ext4_mb_new_inode_pa+0x2a6/0x2c0
[  284.956223]  ? do_error_trap+0x65/0x80
[  284.956385]  ? ext4_mb_new_inode_pa+0x2a6/0x2c0
[  284.956575]  ? exc_invalid_op+0x4b/0x70
[  284.956738]  ? ext4_mb_new_inode_pa+0x2a6/0x2c0
[  284.956929]  ? asm_exc_invalid_op+0x16/0x20
[  284.957112]  ? ext4_mb_new_inode_pa+0x2a6/0x2c0
[  284.957305]  ext4_mb_complex_scan_group+0x2e0/0x3e0
[  284.957512]  ext4_mb_regular_allocator+0x3be/0xd80
[  284.957716]  ext4_mb_new_blocks+0x9dc/0x1040
[  284.957895]  ? __kmalloc+0xca/0x150
[  284.958038]  ? ext4_find_extent+0x3ec/0x450
[  284.958204]  ? _raw_write_unlock+0x29/0x50
[  284.958369]  ext4_ext_map_blocks+0x9a4/0x19d0
[  284.958543]  ? __kmem_cache_free+0x17d/0x2e0
[  284.958723]  ? find_held_lock+0x2b/0x80
[  284.958889]  ext4_map_blocks+0x230/0x5d0
[  284.959056]  ? lock_release+0x139/0x280
[  284.959222]  ext4_getblk+0x7b/0x2d0
[  284.959369]  ext4_bread+0xc/0x70
[  284.959510]  ext4_append+0x8d/0x190
[  284.959665]  ext4_init_new_dir+0xd5/0x1b0
[  284.959835]  ext4_mkdir+0x192/0x340
[  284.959987]  vfs_mkdir+0x98/0x140
[  284.960133]  do_mkdirat+0x131/0x160
[  284.960285]  __x64_sys_mkdir+0x48/0x70
[  284.960445]  do_syscall_64+0x38/0x90
[  284.960600]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[  284.960814] RIP: 0033:0x7f3d9dbf8b07
[  284.960967] Code: 1f 40 00 48 8b 05 89 f3 0c 00 64 c7 00 5f 00 00 00 b8 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 b8 53 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 59 f3 0c 00 f7 d8 64 89 01 48
[  284.961741] RSP: 002b:00007ffcd5131098 EFLAGS: 00000206 ORIG_RAX: 0000000000000053
[  284.962075] RAX: ffffffffffffffda RBX: 00007ffcd5131200 RCX: 00007f3d9dbf8b07
[  284.962363] RDX: 0000000000000000 RSI: 00000000000001ff RDI: 000055b54cdac240
[  284.962647] RBP: 00000000000001ff R08: 0000000000000001 R09: 0000000000000003
[  284.962928] R10: 00007ffcd5130d16 R11: 0000000000000206 R12: 00000000000000cb
[  284.963209] R13: 8f5c28f5c28f5c29 R14: 000055b54c8ec660 R15: 00000000000000cb
[  284.963492]  </TASK>
[  284.963586] Modules linked in:
[  284.963730] ---[ end trace 0000000000000000 ]---

