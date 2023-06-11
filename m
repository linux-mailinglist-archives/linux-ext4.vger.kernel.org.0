Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C01072B051
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Jun 2023 07:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231566AbjFKFF4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 01:05:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjFKFF4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 01:05:56 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B184B30E3
        for <linux-ext4@vger.kernel.org>; Sat, 10 Jun 2023 22:05:54 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35B55WcK020420
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 11 Jun 2023 01:05:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686459938; bh=Gcz8Ol8VHmMI1sjusnAtmgMOD7vVcKjcZv4cK0jFPtw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=bMJIukPmgW747dSbA6Q3FSgX0VlOlFN8NR9j5k2hPh7fAmqt57FAdOIhKlTjVcoq4
         N0OAQPIBCtPXqiu1na9+RqklFc0H0AtF5Vtymtrwe38TBivWolxrUFUKubi9aq4n7l
         iyTdGRGRKgj6CmgJjwHORuv0sWiXMMx5EIWkDbsPeVbxn21FGQhh8g81cyVQMVqlZx
         EXC8QfMGzXJ15QkCv60a8+wgK9TkGrx73mMv2p/suJILOedH0eqQEOkJEMGEgmmbPr
         aqanfyuoEmo6xzpwn9+0MCln2ne549hJGNllEtAj3m6LewGRksYpD4hUWIkxUDRijR
         5Jx9isK9RfAxQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9711515C00B0; Sun, 11 Jun 2023 01:05:32 -0400 (EDT)
Date:   Sun, 11 Jun 2023 01:05:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 13/19] ext4: call ext4_mb_mark_group_bb in
 ext4_free_blocks_simple
Message-ID: <20230611050532.GE1436857@mit.edu>
References: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
 <20230603150327.3596033-14-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230603150327.3596033-14-shikemeng@huaweicloud.com>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, Jun 03, 2023 at 11:03:21PM +0800, Kemeng Shi wrote:
> call ext4_mb_mark_group_bb in ext4_free_blocks_simple to:
> 1. remove repeat code
> 2. pair update of free_clusters in ext4_mb_new_blocks_simple.
> 3. add missing ext4_lock_group/ext4_unlock_group protection.
> 
> Signed-off-by: Kemeng Shi <shikemeng@huaweicloud.com>
> Reviewed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>

Note: after bisecting, I've found that this commit is causing a OOPS
when running "kvm-xfstests -c ext4/adv generic/468".  It appears to be
an issue with the fast commit feature not playing nice with this
patch.  The stack trace looks like this:

[    7.409663] ------------[ cut here ]------------
[    7.409969] WARNING: CPU: 0 PID: 3069 at fs/ext4/mballoc.c:3801 ext4_mb_mark_group_bb+0x48e/0x4a0
[    7.410480] CPU: 0 PID: 3069 Comm: mount Not tainted 6.4.0-rc5-xfstests-lockdep-00021-g60ba685c5998 #146
[    7.411067] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
[    7.411639] RIP: 0010:ext4_mb_mark_group_bb+0x48e/0x4a0
[    7.411968] Code: 48 c7 c7 35 b0 88 82 c6 05 16 f4 9b 01 01 e8 f9 16 c9 ff e9 7f fe ff ff 8b 45 08 c7 44 24 10 00 00 00 00 31 c9 e9 ef fc ff ff <0f> 0b e9 76 fc ff ff e8 96 64 b6 00 66 0f 1f 44 00 00 90 90 90 90
[    7.413128] RSP: 0018:ffffc90003b0f9f8 EFLAGS: 00010246
[    7.413458] RAX: 0000000000000003 RBX: 0000000000006002 RCX: 0000000000000001
[    7.413902] RDX: ffff88800965b000 RSI: 0000000000000000 RDI: ffff88800d690100
[    7.414346] RBP: ffffc90003b0fa68 R08: 000000000aebbd6e R09: 0000000000000246
[    7.414791] R10: 00000000d148c994 R11: 00000000941da2bb R12: ffff88800d7fd000
[    7.415234] R13: 0000000000000000 R14: ffff88800f3e4080 R15: ffff88800b5ca160
[    7.415724] FS:  00007f3d04516840(0000) GS:ffff88807da00000(0000) knlGS:0000000000000000
[    7.416227] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    7.416588] CR2: 00007ffcb3979ac8 CR3: 000000000f290003 CR4: 0000000000770ef0
[    7.417032] PKRU: 55555554
[    7.417205] Call Trace:
[    7.417363]  <TASK>
[    7.417502]  ? ext4_mb_mark_group_bb+0x48e/0x4a0
[    7.417807]  ? __warn+0x80/0x170
[    7.418051]  ? ext4_mb_mark_group_bb+0x48e/0x4a0
[    7.418337]  ? report_bug+0x173/0x1d0
[    7.418567]  ? handle_bug+0x3c/0x70
[    7.418797]  ? exc_invalid_op+0x17/0x70
[    7.419037]  ? asm_exc_invalid_op+0x1a/0x20
[    7.419226]  ? ext4_mb_mark_group_bb+0x48e/0x4a0
[    7.419437]  ? ext4_mb_mark_group_bb+0xae/0x4a0
[    7.419708]  ext4_mb_mark_bb+0xc0/0x120
[    7.419946]  ext4_ext_clear_bb+0x210/0x280
[    7.420198]  ext4_fc_replay_inode+0xa1/0x380
[    7.420466]  ext4_fc_replay+0x435/0x880
[    7.420703]  ? __getblk_gfp+0x37/0x110
[    7.420938]  ? jread+0x7a/0x180
[    7.421138]  do_one_pass+0x7df/0x1040
[    7.421365]  jbd2_journal_recover+0x150/0x250
[    7.421637]  jbd2_journal_load+0xbe/0x190
[    7.421886]  ext4_load_journal+0x214/0x610
[    7.422152]  ext4_load_and_init_journal+0x29/0x380
[    7.422490]  __ext4_fill_super+0x15ca/0x15e0
[    7.422756]  ? __pfx_ext4_fill_super+0x10/0x10
[    7.423032]  ext4_fill_super+0xcf/0x280
[    7.423270]  get_tree_bdev+0x188/0x290
[    7.423505]  vfs_get_tree+0x29/0xe0
[    7.423723]  ? capable+0x37/0x70
[    7.423927]  do_new_mount+0x174/0x300
[    7.424157]  __x64_sys_mount+0x11a/0x150
[    7.424401]  do_syscall_64+0x3b/0x90
[    7.424624]  entry_SYSCALL_64_after_hwframe+0x72/0xdc
[    7.424935] RIP: 0033:0x7f3d0475562a
[    7.425160] Code: 48 8b 0d 69 18 0d 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 36 18 0d 00 f7 d8 64 89 01 48
[    7.426298] RSP: 002b:00007ffcb397aaf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000a5
[    7.426761] RAX: ffffffffffffffda RBX: 00007f3d04889264 RCX: 00007f3d0475562a
[    7.427197] RDX: 0000558ea381db90 RSI: 0000558ea381dbb0 RDI: 0000558ea381dbd0
[    7.427631] RBP: 0000558ea381d960 R08: 0000558ea381dbf0 R09: 00007f3d04827be0
[    7.428063] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
[    7.428499] R13: 0000558ea381dbd0 R14: 0000558ea381db90 R15: 0000558ea381d960
[    7.428941]  </TASK>
[    7.429083] irq event stamp: 10951
[    7.429296] hardirqs last  enabled at (10959): [<ffffffff811643c2>] __up_console_sem+0x52/0x60
[    7.429824] hardirqs last disabled at (10966): [<ffffffff811643a7>] __up_console_sem+0x37/0x60
[    7.430325] softirqs last  enabled at (10574): [<ffffffff8204a529>] __do_softirq+0x2d9/0x39e
[    7.430839] softirqs last disabled at (10407): [<ffffffff810dcc57>] __irq_exit_rcu+0x87/0xb0
[    7.431354] ---[ end trace 0000000000000000 ]---

