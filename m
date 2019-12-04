Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DE93B112B72
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2019 13:25:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727850AbfLDMZ2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Dec 2019 07:25:28 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:6749 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727682AbfLDMZ2 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 4 Dec 2019 07:25:28 -0500
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 38917AC9038451EDD238;
        Wed,  4 Dec 2019 20:25:26 +0800 (CST)
Received: from huawei.com (10.175.124.28) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Wed, 4 Dec 2019
 20:25:17 +0800
From:   "zhangyi (F)" <yi.zhang@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <jack@suse.com>, <tytso@mit.edu>, <adilger.kernel@dilger.ca>,
        <yi.zhang@huawei.com>, <liangyun2@huawei.com>,
        <luoshijie1@huawei.com>
Subject: [PATCH v3 1/4] jbd2: switch to use jbd2_journal_abort() when failed to submit the commit record
Date:   Wed, 4 Dec 2019 20:46:11 +0800
Message-ID: <20191204124614.45424-2-yi.zhang@huawei.com>
X-Mailer: git-send-email 2.17.2
In-Reply-To: <20191204124614.45424-1-yi.zhang@huawei.com>
References: <20191204124614.45424-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.28]
X-CFilter-Loop: Reflected
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

We invoke jbd2_journal_abort() to abort the journal and record errno
in the jbd2 superblock when committing journal transaction besides the
failure on submitting the commit record. But there is no need for the
case and we can also invoke jbd2_journal_abort() instead of
__jbd2_journal_abort_hard().

Fixes: 818d276ceb83a ("ext4: Add the journal checksum feature")
Signed-off-by: zhangyi (F) <yi.zhang@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
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

