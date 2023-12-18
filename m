Return-Path: <linux-ext4+bounces-483-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53B10816EE1
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 13:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1E06B2153A
	for <lists+linux-ext4@lfdr.de>; Mon, 18 Dec 2023 12:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DAD876080;
	Mon, 18 Dec 2023 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eeRQg0ar"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7B307FBCA;
	Mon, 18 Dec 2023 12:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E0D0C433CA;
	Mon, 18 Dec 2023 12:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702903573;
	bh=5iuF1epyv3mwZoNuBNFGVrhC4joDGIutvo34c+ZkDz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eeRQg0arcHa7PVqFekDhyZPCNKJMz+5qqGKKTZ50amj4njt6kn/LuqCv3Qkg+cg4b
	 52YAcaFmf+ZlKMauS1aoArwFNDIZhGGkpu+Eeq1KIXjXuSgpU8r9f2c7t4c7vCnAqJ
	 w5078ZF1M0gX9vx6Zn3t/xqkSGydEvege19ImG9QgP2IqbhgozktjX9m255JLuNQY9
	 oGlZtfslloP3q9KN4b/tawPjGoih0DOGl6L+s2hAMVvGCfA7E4/1Fa3pKBU42ii2AX
	 Tsi5XUjskRXWMB81XGIAkh39L4GTMTvWti8zwax/vKjZs0rwCZH+++XglGXmpA758c
	 +gOszO8ohS44w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	jack@suse.com,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 07/13] jbd2: fix soft lockup in journal_finish_inode_data_buffers()
Date: Mon, 18 Dec 2023 07:45:40 -0500
Message-ID: <20231218124557.1380724-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231218124557.1380724-1-sashal@kernel.org>
References: <20231218124557.1380724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.143
Content-Transfer-Encoding: 8bit

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 6c02757c936063f0631b4e43fe156f8c8f1f351f ]

There's issue when do io test:
WARN: soft lockup - CPU#45 stuck for 11s! [jbd2/dm-2-8:4170]
CPU: 45 PID: 4170 Comm: jbd2/dm-2-8 Kdump: loaded Tainted: G  OE
Call trace:
 dump_backtrace+0x0/0x1a0
 show_stack+0x24/0x30
 dump_stack+0xb0/0x100
 watchdog_timer_fn+0x254/0x3f8
 __hrtimer_run_queues+0x11c/0x380
 hrtimer_interrupt+0xfc/0x2f8
 arch_timer_handler_phys+0x38/0x58
 handle_percpu_devid_irq+0x90/0x248
 generic_handle_irq+0x3c/0x58
 __handle_domain_irq+0x68/0xc0
 gic_handle_irq+0x90/0x320
 el1_irq+0xcc/0x180
 queued_spin_lock_slowpath+0x1d8/0x320
 jbd2_journal_commit_transaction+0x10f4/0x1c78 [jbd2]
 kjournald2+0xec/0x2f0 [jbd2]
 kthread+0x134/0x138
 ret_from_fork+0x10/0x18

Analyzed informations from vmcore as follows:
(1) There are about 5k+ jbd2_inode in 'commit_transaction->t_inode_list';
(2) Now is processing the 855th jbd2_inode;
(3) JBD2 task has TIF_NEED_RESCHED flag;
(4) There's no pags in address_space around the 855th jbd2_inode;
(5) There are some process is doing drop caches;
(6) Mounted with 'nodioread_nolock' option;
(7) 128 CPUs;

According to informations from vmcore we know 'journal->j_list_lock' spin lock
competition is fierce. So journal_finish_inode_data_buffers() maybe process
slowly. Theoretically, there is scheduling point in the filemap_fdatawait_range_keep_errors().
However, if inode's address_space has no pages which taged with PAGECACHE_TAG_WRITEBACK,
will not call cond_resched(). So may lead to soft lockup.
journal_finish_inode_data_buffers
  filemap_fdatawait_range_keep_errors
    __filemap_fdatawait_range
      while (index <= end)
        nr_pages = pagevec_lookup_range_tag(&pvec, mapping, &index, end, PAGECACHE_TAG_WRITEBACK);
        if (!nr_pages)
           break;    --> If 'nr_pages' is equal zero will break, then will not call cond_resched()
        for (i = 0; i < nr_pages; i++)
          wait_on_page_writeback(page);
        cond_resched();

To solve above issue, add scheduling point in the journal_finish_inode_data_buffers();

Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://lore.kernel.org/r/20231211112544.3879780-1-yebin10@huawei.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/jbd2/commit.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index e058ef1839377..f858d1152368a 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -300,6 +300,7 @@ static int journal_finish_inode_data_buffers(journal_t *journal,
 			if (!ret)
 				ret = err;
 		}
+		cond_resched();
 		spin_lock(&journal->j_list_lock);
 		jinode->i_flags &= ~JI_COMMIT_RUNNING;
 		smp_mb();
-- 
2.43.0


