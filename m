Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154D641E64E
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Oct 2021 05:53:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbhJADzO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Sep 2021 23:55:14 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:42846 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230374AbhJADzN (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Sep 2021 23:55:13 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1913rIg2020127
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Sep 2021 23:53:19 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E00BB15C34A8; Thu, 30 Sep 2021 23:53:17 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jack@suse.cz, yangerkun <yangerkun@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yukuai3@huawei.com,
        linux-ext4@vger.kernel.org
Subject: Re: [PATCH v3] ext4: flush s_error_work before journal destroy in ext4_fill_super
Date:   Thu, 30 Sep 2021 23:53:16 -0400
Message-Id: <163306038712.260230.15600354044963943938.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20210924093917.1953239-1-yangerkun@huawei.com>
References: <20210924093917.1953239-1-yangerkun@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, 24 Sep 2021 17:39:17 +0800, yangerkun wrote:
> The error path in ext4_fill_super forget to flush s_error_work before
> journal destroy, and it may trigger the follow bug since
> flush_stashed_error_work can run concurrently with journal destroy
> without any protection for sbi->s_journal.
> 
> [32031.740193] EXT4-fs (loop66): get root inode failed
> [32031.740484] EXT4-fs (loop66): mount failed
> [32031.759805] ------------[ cut here ]------------
> [32031.759807] kernel BUG at fs/jbd2/transaction.c:373!
> [32031.760075] invalid opcode: 0000 [#1] SMP PTI
> [32031.760336] CPU: 5 PID: 1029268 Comm: kworker/5:1 Kdump: loaded
> 4.18.0
> [32031.765112] Call Trace:
> [32031.765375]  ? __switch_to_asm+0x35/0x70
> [32031.765635]  ? __switch_to_asm+0x41/0x70
> [32031.765893]  ? __switch_to_asm+0x35/0x70
> [32031.766148]  ? __switch_to_asm+0x41/0x70
> [32031.766405]  ? _cond_resched+0x15/0x40
> [32031.766665]  jbd2__journal_start+0xf1/0x1f0 [jbd2]
> [32031.766934]  jbd2_journal_start+0x19/0x20 [jbd2]
> [32031.767218]  flush_stashed_error_work+0x30/0x90 [ext4]
> [32031.767487]  process_one_work+0x195/0x390
> [32031.767747]  worker_thread+0x30/0x390
> [32031.768007]  ? process_one_work+0x390/0x390
> [32031.768265]  kthread+0x10d/0x130
> [32031.768521]  ? kthread_flush_work_fn+0x10/0x10
> [32031.768778]  ret_from_fork+0x35/0x40
> 
> [...]

Applied, thanks!

[1/1] ext4: flush s_error_work before journal destroy in ext4_fill_super
      commit: 5ded76080628728881a5e6e7d2e06425cfe4ea1a

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
