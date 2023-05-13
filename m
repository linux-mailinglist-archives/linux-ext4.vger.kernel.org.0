Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EE5F701473
	for <lists+linux-ext4@lfdr.de>; Sat, 13 May 2023 07:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231713AbjEMFAM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 01:00:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231556AbjEMFAJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 01:00:09 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C17104688
        for <linux-ext4@vger.kernel.org>; Fri, 12 May 2023 22:00:07 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34D4xZBQ020108
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 00:59:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1683953977; bh=J0BI15LWmJguBj209XLOr4oJY3Q2JqWyE1IH+vKfv1g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Y6jhKZRSVBhKMNhFbWy3YpI6Xb/yV3gJMniVhFLJ47GuZDMrT/ATq0Y7jtrtC2L2E
         NBXNIz6y+6edp6qcl6Y7gugQVLRQhO9Wu4gY+x6LLNMqigQUaaqTgd2SoouarQRgcm
         NgMnAT+/f9v5PZlkOyKjEzdbvNOQASNxmosgV1ad9ypxmFbyO3/DehLn5rETpMtZVx
         BBI0ff3eXf9pep07cItifY1qmE1tEJTyK2ty1Nu/aUKu7qnPqFwmRXuWrhG4o0l9J1
         c/8s+y76keD1HtJa9jbHehm+EcHbNnQod56PNMHtUPoN/b5bO4vWxgC4ycUgDkch4b
         Rgvhs0Y+dVyBA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 7B7EF15C02EC; Sat, 13 May 2023 00:59:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        Ye Bin <yebin@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz, Ye Bin <yebin10@huawei.com>,
        syzbot+68223fe9f6c95ad43bed@syzkaller.appspotmail.com
Subject: Re: [PATCH v2] ext4: fix WARNING in mb_find_extent
Date:   Sat, 13 May 2023 00:59:32 -0400
Message-Id: <168395396128.1443054.5349687848062640716.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230116020015.1506120-1-yebin@huaweicloud.com>
References: <20230116020015.1506120-1-yebin@huaweicloud.com>
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


On Mon, 16 Jan 2023 10:00:15 +0800, Ye Bin wrote:
> Syzbot found the following issue:
> 
> EXT4-fs: Warning: mounting with data=journal disables delayed allocation, dioread_nolock, O_DIRECT and fast_commit support!
> EXT4-fs (loop0): orphan cleanup on readonly fs
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 5067 at fs/ext4/mballoc.c:1869 mb_find_extent+0x8a1/0xe30
> Modules linked in:
> CPU: 1 PID: 5067 Comm: syz-executor307 Not tainted 6.2.0-rc1-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/26/2022
> RIP: 0010:mb_find_extent+0x8a1/0xe30 fs/ext4/mballoc.c:1869
> RSP: 0018:ffffc90003c9e098 EFLAGS: 00010293
> RAX: ffffffff82405731 RBX: 0000000000000041 RCX: ffff8880783457c0
> RDX: 0000000000000000 RSI: 0000000000000041 RDI: 0000000000000040
> RBP: 0000000000000040 R08: ffffffff82405723 R09: ffffed10053c9402
> R10: ffffed10053c9402 R11: 1ffff110053c9401 R12: 0000000000000000
> R13: ffffc90003c9e538 R14: dffffc0000000000 R15: ffffc90003c9e2cc
> FS:  0000555556665300(0000) GS:ffff8880b9900000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000056312f6796f8 CR3: 0000000022437000 CR4: 00000000003506e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ext4_mb_complex_scan_group+0x353/0x1100 fs/ext4/mballoc.c:2307
>  ext4_mb_regular_allocator+0x1533/0x3860 fs/ext4/mballoc.c:2735
>  ext4_mb_new_blocks+0xddf/0x3db0 fs/ext4/mballoc.c:5605
>  ext4_ext_map_blocks+0x1868/0x6880 fs/ext4/extents.c:4286
>  ext4_map_blocks+0xa49/0x1cc0 fs/ext4/inode.c:651
>  ext4_getblk+0x1b9/0x770 fs/ext4/inode.c:864
>  ext4_bread+0x2a/0x170 fs/ext4/inode.c:920
>  ext4_quota_write+0x225/0x570 fs/ext4/super.c:7105
>  write_blk fs/quota/quota_tree.c:64 [inline]
>  get_free_dqblk+0x34a/0x6d0 fs/quota/quota_tree.c:130
>  do_insert_tree+0x26b/0x1aa0 fs/quota/quota_tree.c:340
>  do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
>  do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
>  do_insert_tree+0x722/0x1aa0 fs/quota/quota_tree.c:375
>  dq_insert_tree fs/quota/quota_tree.c:401 [inline]
>  qtree_write_dquot+0x3b6/0x530 fs/quota/quota_tree.c:420
>  v2_write_dquot+0x11b/0x190 fs/quota/quota_v2.c:358
>  dquot_acquire+0x348/0x670 fs/quota/dquot.c:444
>  ext4_acquire_dquot+0x2dc/0x400 fs/ext4/super.c:6740
>  dqget+0x999/0xdc0 fs/quota/dquot.c:914
>  __dquot_initialize+0x3d0/0xcf0 fs/quota/dquot.c:1492
>  ext4_process_orphan+0x57/0x2d0 fs/ext4/orphan.c:329
>  ext4_orphan_cleanup+0xb60/0x1340 fs/ext4/orphan.c:474
>  __ext4_fill_super fs/ext4/super.c:5516 [inline]
>  ext4_fill_super+0x81cd/0x8700 fs/ext4/super.c:5644
>  get_tree_bdev+0x400/0x620 fs/super.c:1282
>  vfs_get_tree+0x88/0x270 fs/super.c:1489
>  do_new_mount+0x289/0xad0 fs/namespace.c:3145
>  do_mount fs/namespace.c:3488 [inline]
>  __do_sys_mount fs/namespace.c:3697 [inline]
>  __se_sys_mount+0x2d3/0x3c0 fs/namespace.c:3674
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x3d/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> 
> [...]

Applied, thanks!

[1/1] ext4: fix WARNING in mb_find_extent
      commit: fa08a7b61dff8a4df11ff1e84abfc214b487caf7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
