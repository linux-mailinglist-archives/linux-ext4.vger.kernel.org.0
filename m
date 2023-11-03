Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932347E0181
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Nov 2023 11:31:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232819AbjKCG6K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 3 Nov 2023 02:58:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbjKCG6I (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 3 Nov 2023 02:58:08 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1378EDC
        for <linux-ext4@vger.kernel.org>; Thu,  2 Nov 2023 23:58:06 -0700 (PDT)
Received: from kwepemm000013.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4SMBM563cqzrTwL;
        Fri,  3 Nov 2023 14:54:57 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm000013.china.huawei.com
 (7.193.23.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 3 Nov
 2023 14:58:01 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yi.zhang@huawei.com>
Subject: [PATCH 4/5] jbd2: Abort journal when detecting metadata writeback error of fs dev
Date:   Fri, 3 Nov 2023 22:52:49 +0800
Message-ID: <20231103145250.2995746-5-chengzhihao1@huawei.com>
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

This is a replacement solution of commit bc71726c725767 ("ext4: abort
the filesystem if failed to async write metadata buffer"), JBD2 can
detects metadata writeback error of fs dev by 'j_fs_dev_wb_err'.

Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/jbd2/transaction.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 5f08b5fd105a..cb0b8d6fc0c6 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1231,11 +1231,25 @@ static bool jbd2_write_access_granted(handle_t *handle, struct buffer_head *bh,
 int jbd2_journal_get_write_access(handle_t *handle, struct buffer_head *bh)
 {
 	struct journal_head *jh;
+	journal_t *journal;
 	int rc;
 
 	if (is_handle_aborted(handle))
 		return -EROFS;
 
+	journal = handle->h_transaction->t_journal;
+	if (jbd2_check_fs_dev_write_error(journal)) {
+		/*
+		 * If the fs dev has writeback errors, it may have failed
+		 * to async write out metadata buffers in the background.
+		 * In this case, we could read old data from disk and write
+		 * it out again, which may lead to on-disk filesystem
+		 * inconsistency. Aborting journal can avoid it happen.
+		 */
+		jbd2_journal_abort(journal, -EIO);
+		return -EIO;
+	}
+
 	if (jbd2_write_access_granted(handle, bh, false))
 		return 0;
 
-- 
2.39.2

