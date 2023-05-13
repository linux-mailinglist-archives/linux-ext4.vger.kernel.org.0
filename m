Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119D370146E
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 07:00:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbjEMFAA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 01:00:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231258AbjEME77 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 00:59:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27EE6449C
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 21:59:58 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34D4xXMN020069
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 00:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683953978; bh=3UF/1DnInyocxZM2Vh6D5JHHfv4cfZnxi/yjCxfn/Bc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ldfp2qko/NV70VU6vG9GoKjyaykEJI/nVquoqhAbalOZ+N1TdOyREX4p7vIKXDkNX
         Dyy+YrV39w4yxufDOgLU5E4ZWx0ig6VonBXqbGpaTpb0yoAcEXPR14yRIUbxFIV2dN
         eyAniXx6bmglWK/o0QDX08EcyvxqCXMmILanzAnthm2C2CM32dSjEu6KdJjoKgFIaJ
         2eS0b0P72T/e7S2MBG3A/0KV+OaZUT5+dJmZXx+NPer6L3I0XrBUoFej8nn1lsWw78
         Oz4V4inlLUP8qcj1VOY57G9EBd+bmMoYJE1Lj9Vzs19bzPdY6KWxF5Eg22LEWuWOYE
         AYYqyEQ5ejHZg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 79C3E15C02EB; Sat, 13 May 2023 00:59:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jack@suze.cz, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        cmm@us.ibm.com, aneesh.kumar@linux.vnet.ibm.com, mathur@us.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        joneslee@google.com,
        syzbot+fc51227e7100c9294894@syzkaller.appspotmail.com,
        stable@vger.kernel.org
Subject: Re: [PATCH] ext4: Avoid a potential slab-out-of-bounds in ext4_group_desc_csum
Date:   Sat, 13 May 2023 00:59:31 -0400
Message-Id: <168395396131.1443054.15103750805283144831.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230504121525.3275886-1-tudor.ambarus@linaro.org>
References: <20230504121525.3275886-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Thu, 04 May 2023 12:15:25 +0000, Tudor Ambarus wrote:
> When modifying the block device while it is mounted by the filesystem,
> syzbot reported the following:
> 
> BUG: KASAN: slab-out-of-bounds in crc16+0x206/0x280 lib/crc16.c:58
> Read of size 1 at addr ffff888075f5c0a8 by task syz-executor.2/15586
> 
> CPU: 1 PID: 15586 Comm: syz-executor.2 Not tainted 6.2.0-rc5-syzkaller-00205-gc96618275234 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/12/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0x1b1/0x290 lib/dump_stack.c:106
>  print_address_description+0x74/0x340 mm/kasan/report.c:306
>  print_report+0x107/0x1f0 mm/kasan/report.c:417
>  kasan_report+0xcd/0x100 mm/kasan/report.c:517
>  crc16+0x206/0x280 lib/crc16.c:58
>  ext4_group_desc_csum+0x81b/0xb20 fs/ext4/super.c:3187
>  ext4_group_desc_csum_set+0x195/0x230 fs/ext4/super.c:3210
>  ext4_mb_clear_bb fs/ext4/mballoc.c:6027 [inline]
>  ext4_free_blocks+0x191a/0x2810 fs/ext4/mballoc.c:6173
>  ext4_remove_blocks fs/ext4/extents.c:2527 [inline]
>  ext4_ext_rm_leaf fs/ext4/extents.c:2710 [inline]
>  ext4_ext_remove_space+0x24ef/0x46a0 fs/ext4/extents.c:2958
>  ext4_ext_truncate+0x177/0x220 fs/ext4/extents.c:4416
>  ext4_truncate+0xa6a/0xea0 fs/ext4/inode.c:4342
>  ext4_setattr+0x10c8/0x1930 fs/ext4/inode.c:5622
>  notify_change+0xe50/0x1100 fs/attr.c:482
>  do_truncate+0x200/0x2f0 fs/open.c:65
>  handle_truncate fs/namei.c:3216 [inline]
>  do_open fs/namei.c:3561 [inline]
>  path_openat+0x272b/0x2dd0 fs/namei.c:3714
>  do_filp_open+0x264/0x4f0 fs/namei.c:3741
>  do_sys_openat2+0x124/0x4e0 fs/open.c:1310
>  do_sys_open fs/open.c:1326 [inline]
>  __do_sys_creat fs/open.c:1402 [inline]
>  __se_sys_creat fs/open.c:1396 [inline]
>  __x64_sys_creat+0x11f/0x160 fs/open.c:1396
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> RIP: 0033:0x7f72f8a8c0c9
> Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 f1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007f72f97e3168 EFLAGS: 00000246 ORIG_RAX: 0000000000000055
> RAX: ffffffffffffffda RBX: 00007f72f8bac050 RCX: 00007f72f8a8c0c9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000280
> RBP: 00007f72f8ae7ae9 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007ffd165348bf R14: 00007f72f97e3300 R15: 0000000000022000
> 
> [...]

Applied, thanks!

[1/1] ext4: Avoid a potential slab-out-of-bounds in ext4_group_desc_csum
      commit: 707548336a9a5b1745074265c4d4d2cf2b4b0f43

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
