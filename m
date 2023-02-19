Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C47A69BEA6
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 06:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjBSFlj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 00:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229770AbjBSFl3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 00:41:29 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8336713DDC
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 21:41:27 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J5evMf024884
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 00:40:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676785260; bh=ZzRA0hmQMcS6crBq/PmHuyK/79Sdm4JNNsfHzdcLDok=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=pselJx+2ij/49hbVfWDGLAZSVr50hZf/jjKq94yDW2y2OW/UabWLJdIiyCEmeVFVf
         xHXVb4weWyi1KKXq+qwBSKrMSYdA2IfpJyahJ8sEuudD4Ei1cAaILS9ohaTI0m0S+5
         tE8ujhjU2DPGkI4mjSjKpxQPX3Q3zK3/ylQ1Jt3Q2c6NlFLUfaH4yZsog75sF4pRlr
         ubQ0O0gFwsCGhWhZofBS7b/21mlqXl9ywtJs+4Y2emWj+R5hSRpFe2K20twiPfuFmp
         neQ8aUgxwic3SVurC7WmR1Y1hsWuhQzT1vb03FaELEGA9BahF5sjZ9wm/GgYQoDkfb
         FNmmVZmu3E6gQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CD0D715C35A9; Sun, 19 Feb 2023 00:40:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yukuai3@huawei.com, jack@suse.cz,
        syzbot+77d6fcc37bbb92f26048@syzkaller.appspotmail.com,
        ritesh.list@gmail.com, adilger.kernel@dilger.ca,
        yi.zhang@huawei.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: fix task hung in ext4_xattr_delete_inode
Date:   Sun, 19 Feb 2023 00:40:49 -0500
Message-Id: <167678522173.2723470.11858190476110112490.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230110133436.996350-1-libaokun1@huawei.com>
References: <20230110133436.996350-1-libaokun1@huawei.com>
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

On Tue, 10 Jan 2023 21:34:36 +0800, Baokun Li wrote:
> Syzbot reported a hung task problem:
> ==================================================================
> INFO: task syz-executor232:5073 blocked for more than 143 seconds.
>       Not tainted 6.2.0-rc2-syzkaller-00024-g512dee0c00ad #0
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> task:syz-exec232 state:D stack:21024 pid:5073 ppid:5072 flags:0x00004004
> Call Trace:
>  <TASK>
>  context_switch kernel/sched/core.c:5244 [inline]
>  __schedule+0x995/0xe20 kernel/sched/core.c:6555
>  schedule+0xcb/0x190 kernel/sched/core.c:6631
>  __wait_on_freeing_inode fs/inode.c:2196 [inline]
>  find_inode_fast+0x35a/0x4c0 fs/inode.c:950
>  iget_locked+0xb1/0x830 fs/inode.c:1273
>  __ext4_iget+0x22e/0x3ed0 fs/ext4/inode.c:4861
>  ext4_xattr_inode_iget+0x68/0x4e0 fs/ext4/xattr.c:389
>  ext4_xattr_inode_dec_ref_all+0x1a7/0xe50 fs/ext4/xattr.c:1148
>  ext4_xattr_delete_inode+0xb04/0xcd0 fs/ext4/xattr.c:2880
>  ext4_evict_inode+0xd7c/0x10b0 fs/ext4/inode.c:296
>  evict+0x2a4/0x620 fs/inode.c:664
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
> RIP: 0033:0x7fa5406fd5ea
> RSP: 002b:00007ffc7232f968 EFLAGS: 00000202 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fa5406fd5ea
> RDX: 0000000020000440 RSI: 0000000020000000 RDI: 00007ffc7232f970
> RBP: 00007ffc7232f970 R08: 00007ffc7232f9b0 R09: 0000000000000432
> R10: 0000000000804a03 R11: 0000000000000202 R12: 0000000000000004
> R13: 0000555556a7a2c0 R14: 00007ffc7232f9b0 R15: 0000000000000000
>  </TASK>
> ==================================================================
> 
> [...]

Applied, thanks!

[1/1] ext4: fix task hung in ext4_xattr_delete_inode
      commit: 0f7bfd6f8164be32dbbdf36aa1e5d00485c53cd7

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
