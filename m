Return-Path: <linux-ext4+bounces-420-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C53AD8107DE
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 02:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F4CE2824A2
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Dec 2023 01:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5504915A7;
	Wed, 13 Dec 2023 01:52:22 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DD09AD
	for <linux-ext4@vger.kernel.org>; Tue, 12 Dec 2023 17:52:18 -0800 (PST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4SqdK15tHCz1kvB1;
	Wed, 13 Dec 2023 09:32:53 +0800 (CST)
Received: from kwepemm000013.china.huawei.com (unknown [7.193.23.81])
	by mail.maildlp.com (Postfix) with ESMTPS id C0B2B1800DD;
	Wed, 13 Dec 2023 09:34:00 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 13 Dec
 2023 09:33:58 +0800
From: Zhihao Cheng <chengzhihao1@huawei.com>
To: <tytso@mit.edu>, <jack@suse.com>
CC: <linux-ext4@vger.kernel.org>, <yi.zhang@huawei.com>
Subject: [PATCH v2 2/5] jbd2: Replace journal state flag by checking errseq
Date: Wed, 13 Dec 2023 09:32:21 +0800
Message-ID: <20231213013224.2100050-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231213013224.2100050-1-chengzhihao1@huawei.com>
References: <20231213013224.2100050-1-chengzhihao1@huawei.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm000013.china.huawei.com (7.193.23.81)

Now JBD2 detects metadata writeback error of fs dev according to errseq.
Replace journal state flag by checking errseq.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 559938a82379..b6c114c11b97 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1862,7 +1862,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 
 	if (is_journal_aborted(journal))
 		return -EIO;
-	if (test_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags)) {
+	if (jbd2_check_fs_dev_write_error(journal)) {
 		jbd2_journal_abort(journal, -EIO);
 		return -EIO;
 	}
@@ -2160,12 +2160,12 @@ int jbd2_journal_destroy(journal_t *journal)
 
 	/*
 	 * OK, all checkpoint transactions have been checked, now check the
-	 * write out io error flag and abort the journal if some buffer failed
-	 * to write back to the original location, otherwise the filesystem
-	 * may become inconsistent.
+	 * writeback errseq of fs dev and abort the journal if some buffer
+	 * failed to write back to the original location, otherwise the
+	 * filesystem may become inconsistent.
 	 */
 	if (!is_journal_aborted(journal) &&
-	    test_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags))
+	    jbd2_check_fs_dev_write_error(journal))
 		jbd2_journal_abort(journal, -EIO);
 
 	if (journal->j_sb_buffer) {
-- 
2.39.2


