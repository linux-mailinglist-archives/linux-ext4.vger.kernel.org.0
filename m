Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A000E39F867
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Jun 2021 16:03:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbhFHOFc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Jun 2021 10:05:32 -0400
Received: from szxga03-in.huawei.com ([45.249.212.189]:5339 "EHLO
        szxga03-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232341AbhFHOFX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Jun 2021 10:05:23 -0400
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.55])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4FzsLJ5f9Pz6tmq;
        Tue,  8 Jun 2021 21:59:36 +0800 (CST)
Received: from dggema766-chm.china.huawei.com (10.1.198.208) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Tue, 8 Jun 2021 22:03:27 +0800
Received: from localhost.localdomain (10.175.127.227) by
 dggema766-chm.china.huawei.com (10.1.198.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2176.2; Tue, 8 Jun 2021 22:03:27 +0800
From:   yangerkun <yangerkun@huawei.com>
To:     <tytso@mit.edu>, <jack@suse.com>, <harshadshirwadkar@gmail.com>
CC:     <linux-ext4@vger.kernel.org>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>
Subject: [PATCH] jbd2: clean up misleading comments for jbd2_fc_release_bufs
Date:   Tue, 8 Jun 2021 22:12:36 +0800
Message-ID: <20210608141236.459441-1-yangerkun@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggema766-chm.china.huawei.com (10.1.198.208)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This comments was for jbd2_fc_wait_bufs, not for jbd2_fc_release_bufs.
Remove this misleading comments.

Signed-off-by: yangerkun <yangerkun@huawei.com>
---
 fs/jbd2/journal.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 2dc944442802..ea46e5ad6b59 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -934,10 +934,6 @@ int jbd2_fc_wait_bufs(journal_t *journal, int num_blks)
 }
 EXPORT_SYMBOL(jbd2_fc_wait_bufs);
 
-/*
- * Wait on fast commit buffers that were allocated by jbd2_fc_get_buf
- * for completion.
- */
 int jbd2_fc_release_bufs(journal_t *journal)
 {
 	struct buffer_head *bh;
@@ -945,10 +941,6 @@ int jbd2_fc_release_bufs(journal_t *journal)
 
 	j_fc_off = journal->j_fc_off;
 
-	/*
-	 * Wait in reverse order to minimize chances of us being woken up before
-	 * all IOs have completed
-	 */
 	for (i = j_fc_off - 1; i >= 0; i--) {
 		bh = journal->j_fc_wbuf[i];
 		if (!bh)
-- 
2.31.1

