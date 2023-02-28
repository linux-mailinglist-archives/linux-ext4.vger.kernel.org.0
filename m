Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EDA16A528E
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Feb 2023 06:13:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbjB1FNc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Feb 2023 00:13:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229585AbjB1FNb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 28 Feb 2023 00:13:31 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D152DBB87
        for <linux-ext4@vger.kernel.org>; Mon, 27 Feb 2023 21:13:29 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31S5DOcA002505
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 00:13:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1677561205; bh=XGugbIBpeJsxpQEi7sWrYpoOrNzi8/Pt3mRjHBgE560=;
        h=From:To:Cc:Subject:Date;
        b=k6bVPR5SGw1TE5XZ+rEfENMoMcRF+QB+8Pn6D2bT2r7I/q+OYoMy0sijdCHvky0No
         qJCG1qXct98nrSFMPIoJlf8REnFOcJZ2DaeaTn+Bsu58BJvCpPEaLcEGwhp4KKYhCt
         5wWTZEJ/ttdC5KgxjIYG+P4LTqAYa3A/M1KFRvI1FNSb9q0uRaRakr5lojt/3tU0M9
         M2Fwaxgt6vnKFw0F4neiAD8OVxOhV+OLOckEmTwaB7EV86C3A2vwymUShd6h2E7hLz
         dZ9ACGQYM8D1inYIeDMMsr4MvyChK21pS5xMvQe4roDLwfcgoLp0FpTYEJ7Vla5DM5
         uAJLstaWUu0uQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2AB5715C5823; Tue, 28 Feb 2023 00:13:24 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH REBASED 0/7] ext4: Cleanup data=journal writeback path
Date:   Tue, 28 Feb 2023 00:13:12 -0500
Message-Id: <20230228051319.4085470-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is Jan's data=journal cleanup patch series, previously submitted
here[1] rebased on top of Linus's patches to address merge conflicts
with mm-stable, per this discussion[2].

[1] https://lore.kernel.org/r/20230111152736.9608-1-jack@suse.cz
[2] https://lore.kernel.org/r/Y/k4Jvph15ugcY54@mit.edu

While retesting this patch series, I've noticed a potential regression
which doesn't trigger before applying the last patch in this series
(Convert data=journal writeback to use ext4_writepages), but which
triggers a WARNING in generic/390 about half the time.  I've gone back
and retested, and this was happening before the rebase.

Jan, could you take a look and (1) let me know what you think about my
patch conflict resolutions and (2) what you think about this warning
which is occasionally triggered by generic/390?  Many thanks!

      	 	      		   - Ted

generic/390 2s ...  [00:08:04][    2.708542] run fstests generic/390 at 2023-02-28 00:08:04
[    2.871030] EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!
[    3.814748] ------------[ cut here ]------------
[    3.816039] WARNING: CPU: 1 PID: 151 at fs/ext4/ext4_jbd2.c:75 ext4_journal_check_start+0x67/0xa0
[    3.817902] CPU: 1 PID: 151 Comm: kworker/u4:3 Not tainted 6.2.0-xfstests-11603-g17b3ec378915 #953
[    3.818285] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.0-debian-1.16.0-5 04/01/2014
[    3.818674] Workqueue: writeback wb_workfn (flush-254:32)
[    3.818903] RIP: 0010:ext4_journal_check_start+0x67/0xa0
[    3.819277] Code: 00 04 74 26 48 8b 90 28 02 00 00 31 c0 48 85 d2 74 07 8b 02 83 e0 02 75 15 5b c3 cc cc cc cc b8 fb ff ff ff 5b c3 cc cc cc cc <0f> 0b eb d6 44 8b 42 10 45 31 c9 68 60 57 59 82 48 89 df b9 01 00
[    3.820069] RSP: 0018:ffffc900009f7930 EFLAGS: 00010246
[    3.820301] RAX: ffff888009c65000 RBX: ffff888006ec1800 RCX: ffff88800665f000
[    3.820605] RDX: 0000000000000000 RSI: 0000000000000044 RDI: ffffffff8259574c
[    3.820908] RBP: 0000000000000001 R08: 0000000000000001 R09: 0000000000000000
[    3.821213] R10: 0000000000000228 R11: 0000000000000000 R12: 0000000000000000
[    3.821512] R13: 0000000000000002 R14: 000000000000097f R15: 0000000000000008
[    3.821830] FS:  0000000000000000(0000) GS:ffff88807dd00000(0000) knlGS:0000000000000000
[    3.822179] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[    3.822432] CR2: 00007f4ab2dce670 CR3: 0000000006764006 CR4: 0000000000770ee0
[    3.822739] PKRU: 55555554
[    3.822861] Call Trace:
[    3.822972]  <TASK>
[    3.823070]  __ext4_journal_start_sb+0x3f/0x190
[    3.823267]  mpage_prepare_extent_to_map+0x470/0x500
[    3.823483]  ext4_do_writepages+0x250/0x760
[    3.823661]  ext4_writepages+0x99/0x130
[    3.823828]  do_writepages+0xcf/0x1e0
[    3.823988]  ? fprop_fraction_percpu+0x2f/0x80
[    3.824186]  __writeback_single_inode+0x3d/0x280
[    3.824389]  writeback_sb_inodes+0x1ed/0x4b0
[    3.824571]  wb_writeback+0xdb/0x2f0
[    3.824724]  wb_do_writeback+0x87/0x2b0
[    3.824890]  ? set_worker_desc+0xc7/0xd0
[    3.825060]  wb_workfn+0x5f/0x260
[    3.825205]  ? ttwu_do_activate+0x83/0x1e0
[    3.825382]  ? _raw_spin_unlock_irqrestore+0xe/0x30
[    3.825592]  ? try_to_wake_up+0x275/0x480
[    3.825774]  process_one_work+0x1c3/0x3d0
[    3.825949]  worker_thread+0x51/0x3b0
[    3.826108]  ? __pfx_worker_thread+0x10/0x10
[    3.826291]  kthread+0xe7/0x110
[    3.826430]  ? __pfx_kthread+0x10/0x10
[    3.826593]  ret_from_fork+0x29/0x50
[    3.826747]  </TASK>
[    3.826846] ---[ end trace 0000000000000000 ]---
[    3.827056] ------------[ cut here ]------------


				   

Jan Kara (7):
  ext4: Update stale comment about write constraints
  ext4: Use nr_to_write directly in mpage_prepare_extent_to_map()
  ext4: Mark page for delayed dirtying only if it is pinned
  ext4: Don't unlock page in ext4_bio_write_page()
  ext4: Move page unlocking out of mpage_submit_page()
  ext4: Move mpage_page_done() calls after error handling
  ext4: Convert data=journal writeback to use ext4_writepages()

 fs/ext4/inode.c             | 410 +++++++++++-------------------------
 fs/ext4/page-io.c           |  10 +-
 include/trace/events/ext4.h |   7 -
 3 files changed, 126 insertions(+), 301 deletions(-)

-- 
2.31.0

