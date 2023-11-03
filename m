Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9FB7E0128
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Nov 2023 11:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjKCG6H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Nov 2023 02:58:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjKCG6G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Nov 2023 02:58:06 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C10D1191
        for <linux-ext4@vger.kernel.org>; Thu,  2 Nov 2023 23:58:03 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMBM45lrfzrTyf;
        Fri,  3 Nov 2023 14:54:56 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:58:00 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 2/5] jbd2: Replace journal state flag by checking errseq
Date:   Fri, 3 Nov 2023 22:52:47 +0800
Message-ID: <20231103145250.2995746-3-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231103145250.2995746-1-chengzhihao1@huawei.com>
References: <20231103145250.2995746-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.67]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemm000013.china.huawei.com (7.193.23.81)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now JBD2 detects metadata writeback error of fs dev according to errseq.
Replace journal state flag by checking errseq.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Suggested-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index a655d9a88f79..b60d19505f8a 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1850,7 +1850,7 @@ int jbd2_journal_update_sb_log_tail(journal_t *journal, tid_t tail_tid,
 
 	if (is_journal_aborted(journal))
 		return -EIO;
-	if (test_bit(JBD2_CHECKPOINT_IO_ERROR, &journal->j_atomic_flags)) {
+	if (jbd2_check_fs_dev_write_error(journal)) {
 		jbd2_journal_abort(journal, -EIO);
 		return -EIO;
 	}
@@ -2148,12 +2148,12 @@ int jbd2_journal_destroy(journal_t *journal)
 
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

