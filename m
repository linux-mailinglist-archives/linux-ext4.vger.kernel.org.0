Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70E4561E082
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Nov 2022 07:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbiKFGRZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Nov 2022 01:17:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiKFGRX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Nov 2022 01:17:23 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20971DEA8;
        Sat,  5 Nov 2022 23:17:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A66H01T032709
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Nov 2022 01:17:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667715421; bh=QdQ7jgAPs3Fub2MtTS9nyM+pXxBGvy+wYzkhhV6yWZ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YUJIvcSR+gTG+lQVHvHh1YHv0pz49WlAC8FhjdjkHpVu3yMGYcxyQifqAuqFOIvke
         ik9C73qTCxTcEr/+WXqQkpiGNF+qHVaZIihjM7FJfnNsosH/dx009mzu5EXLK699Ks
         w1U3nyI3FX/50LaBaotDQ+E1maflJCI08reCi4SDFKTYov0T9lyG2toKxb5jzprt3M
         fMW6+h5eo5dweWt0gOe/Vt/yvkaFED4uDaL4x3nuJUKUwkLOs0IeWlVKRidrHHa3D/
         6tLoN5AoFOc500NbU8/QLfL1eNVi2Ih6NnF0X4gIsMj0gV9LXDCCpFnHsKR5lLkbS5
         CeKNgrhaUzVBQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E25E715C45BB; Sun,  6 Nov 2022 01:16:59 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>, linux-ext4@vger.kernel.org,
        adilger.kernel@dilger.ca
Cc:     "Theodore Ts'o" <tytso@mit.edu>, jack@suse.cz,
        syzbot+c740bb18df70ad00952e@syzkaller.appspotmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v2] ext4: fix warning in 'ext4_da_release_space'
Date:   Sun,  6 Nov 2022 01:16:53 -0500
Message-Id: <166771539910.127460.7496410803932369792.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221018022701.683489-1-yebin10@huawei.com>
References: <20221018022701.683489-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 18 Oct 2022 10:27:01 +0800, Ye Bin wrote:
> Syzkaller report issue as follows:
> EXT4-fs (loop0): Free/Dirty block details
> EXT4-fs (loop0): free_blocks=0
> EXT4-fs (loop0): dirty_blocks=0
> EXT4-fs (loop0): Block reservation details
> EXT4-fs (loop0): i_reserved_data_blocks=0
> EXT4-fs warning (device loop0): ext4_da_release_space:1527: ext4_da_release_space: ino 18, to_free 1 with only 0 reserved data blocks
> ------------[ cut here ]------------
> WARNING: CPU: 0 PID: 92 at fs/ext4/inode.c:1528 ext4_da_release_space+0x25e/0x370 fs/ext4/inode.c:1524
> Modules linked in:
> CPU: 0 PID: 92 Comm: kworker/u4:4 Not tainted 6.0.0-syzkaller-09423-g493ffd6605b2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/22/2022
> Workqueue: writeback wb_workfn (flush-7:0)
> RIP: 0010:ext4_da_release_space+0x25e/0x370 fs/ext4/inode.c:1528
> RSP: 0018:ffffc900015f6c90 EFLAGS: 00010296
> RAX: 42215896cd52ea00 RBX: 0000000000000000 RCX: 42215896cd52ea00
> RDX: 0000000000000000 RSI: 0000000080000001 RDI: 0000000000000000
> RBP: 1ffff1100e907d96 R08: ffffffff816aa79d R09: fffff520002bece5
> R10: fffff520002bece5 R11: 1ffff920002bece4 R12: ffff888021fd2000
> R13: ffff88807483ecb0 R14: 0000000000000001 R15: ffff88807483e740
> FS:  0000000000000000(0000) GS:ffff8880b9a00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00005555569ba628 CR3: 000000000c88e000 CR4: 00000000003506f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  ext4_es_remove_extent+0x1ab/0x260 fs/ext4/extents_status.c:1461
>  mpage_release_unused_pages+0x24d/0xef0 fs/ext4/inode.c:1589
>  ext4_writepages+0x12eb/0x3be0 fs/ext4/inode.c:2852
>  do_writepages+0x3c3/0x680 mm/page-writeback.c:2469
>  __writeback_single_inode+0xd1/0x670 fs/fs-writeback.c:1587
>  writeback_sb_inodes+0xb3b/0x18f0 fs/fs-writeback.c:1870
>  wb_writeback+0x41f/0x7b0 fs/fs-writeback.c:2044
>  wb_do_writeback fs/fs-writeback.c:2187 [inline]
>  wb_workfn+0x3cb/0xef0 fs/fs-writeback.c:2227
>  process_one_work+0x877/0xdb0 kernel/workqueue.c:2289
>  worker_thread+0xb14/0x1330 kernel/workqueue.c:2436
>  kthread+0x266/0x300 kernel/kthread.c:376
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:306
>  </TASK>
> 
> [...]

Applied, thanks!

[1/1] ext4: fix warning in 'ext4_da_release_space'
      commit: 1b8f787ef547230a3249bcf897221ef0cc78481b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
