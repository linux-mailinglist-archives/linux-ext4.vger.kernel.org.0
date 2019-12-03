Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E136E10FA6E
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Dec 2019 10:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726115AbfLCJGy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Dec 2019 04:06:54 -0500
Received: from szxga07-in.huawei.com ([45.249.212.35]:32974 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726105AbfLCJGy (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 3 Dec 2019 04:06:54 -0500
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id AC705875D4D5FB044756;
        Tue,  3 Dec 2019 17:06:52 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.439.0; Tue, 3 Dec 2019
 17:06:44 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <liangyun2@huawei.com>,
        <luoshijie1@huawei.com>
Subject: [PATCH v2 1/4] jbd2: switch to use jbd2_journal_abort() when failed to submit the commit record
Date:   Tue, 3 Dec 2019 17:27:53 +0800
Message-ID: <20191203092756.26129-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191203092756.26129-1-yi.zhang@huawei.com>
References: <20191203092756.26129-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We invloke jbd2_journal_abort() to abort the journal and record errno
in the jbd2 superblock when committing journal transaction besides the
failure on submitting the commit record. But there is no need for the
case and we can also invloke jbd2_journal_abort() instead of
__jbd2_journal_abort_hard().

Fixes: 818d276ceb83a ("ext4: Add the journal checksum feature")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
---
 fs/jbd2/commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 132fb92098c7..87b88d910306 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -785,7 +785,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		err = journal_submit_commit_record(journal, commit_transaction,
 						 &cbh, crc32_sum);
 		if (err)
-			__jbd2_journal_abort_hard(journal);
+			jbd2_journal_abort(journal, err);
 	}
 
 	blk_finish_plug(&plug);
@@ -876,7 +876,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 		err = journal_submit_commit_record(journal, commit_transaction,
 						&cbh, crc32_sum);
 		if (err)
-			__jbd2_journal_abort_hard(journal);
+			jbd2_journal_abort(journal, err);
 	}
 	if (cbh)
 		err = journal_wait_on_commit_record(journal, cbh);
-- 
2.17.2

