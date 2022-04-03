Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C46D4F0A1B
	for <lists+linux-ext4@lfdr.de>; Sun,  3 Apr 2022 16:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235356AbiDCOKe (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 3 Apr 2022 10:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358971AbiDCOKd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 3 Apr 2022 10:10:33 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAAFF16;
        Sun,  3 Apr 2022 07:08:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 233E8IbG011468
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 3 Apr 2022 10:08:18 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 2C3F715C003E; Sun,  3 Apr 2022 10:08:18 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ye Bin <yebin10@huawei.com>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        jack@suse.cz, lczerner@redhat.com
Subject: Re: [PATCH -next] ext4: fix bug_on in start_this_handle during umount filesystem
Date:   Sun,  3 Apr 2022 10:08:15 -0400
Message-Id: <164899488734.954394.6632081138167327565.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220322012419.725457-1-yebin10@huawei.com>
References: <20220322012419.725457-1-yebin10@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 22 Mar 2022 09:24:19 +0800, Ye Bin wrote:
> We got issue as follows:
> ------------[ cut here ]------------
> kernel BUG at fs/jbd2/transaction.c:389!
> invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
> CPU: 9 PID: 131 Comm: kworker/9:1 Not tainted 5.17.0-862.14.0.6.x86_64-00001-g23f87daf7d74-dirty #197
> Workqueue: events flush_stashed_error_work
> RIP: 0010:start_this_handle+0x41c/0x1160
> RSP: 0018:ffff888106b47c20 EFLAGS: 00010202
> RAX: ffffed10251b8400 RBX: ffff888128dc204c RCX: ffffffffb52972ac
> RDX: 0000000000000200 RSI: 0000000000000004 RDI: ffff888128dc2050
> RBP: 0000000000000039 R08: 0000000000000001 R09: ffffed10251b840a
> R10: ffff888128dc204f R11: ffffed10251b8409 R12: ffff888116d78000
> R13: 0000000000000000 R14: dffffc0000000000 R15: ffff888128dc2000
> FS:  0000000000000000(0000) GS:ffff88839d680000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000001620068 CR3: 0000000376c0e000 CR4: 00000000000006e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <TASK>
>  jbd2__journal_start+0x38a/0x790
>  jbd2_journal_start+0x19/0x20
>  flush_stashed_error_work+0x110/0x2b3
>  process_one_work+0x688/0x1080
>  worker_thread+0x8b/0xc50
>  kthread+0x26f/0x310
>  ret_from_fork+0x22/0x30
>  </TASK>
> Modules linked in:
> ---[ end trace 0000000000000000 ]---
> 
> [...]

Applied, thanks!

[1/1] ext4: fix bug_on in start_this_handle during umount filesystem
      commit: 20164749617e56d584313ad775d6dd3b7da40dc1

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
