Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71C6A6B3FBC
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Mar 2023 13:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230423AbjCJMxQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Mar 2023 07:53:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230337AbjCJMxM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 10 Mar 2023 07:53:12 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7B42130;
        Fri, 10 Mar 2023 04:52:54 -0800 (PST)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PY5Vd5HDhznWZn;
        Fri, 10 Mar 2023 20:50:01 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 10 Mar
 2023 20:52:52 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH 5/5] jbd2: remove j_format_version
Date:   Fri, 10 Mar 2023 20:52:06 +0800
Message-ID: <20230310125206.2867822-6-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230310125206.2867822-1-chengzhihao1@huawei.com>
References: <20230310125206.2867822-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

journal->j_format_version is no longer used, remove it.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/jbd2/journal.c    | 9 ---------
 include/linux/jbd2.h | 5 -----
 2 files changed, 14 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index cd94d068b4e6..fbada835b6b7 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1997,15 +1997,6 @@ static int load_superblock(journal_t *journal)
 
 	sb = journal->j_superblock;
 
-	switch (be32_to_cpu(sb->s_header.h_blocktype)) {
-	case JBD2_SUPERBLOCK_V1:
-		journal->j_format_version = 1;
-		break;
-	case JBD2_SUPERBLOCK_V2:
-		journal->j_format_version = 2;
-		break;
-	}
-
 	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
 	journal->j_tail = be32_to_cpu(sb->s_start);
 	journal->j_first = be32_to_cpu(sb->s_first);
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 7095c0f17ad0..b7c79f68f7ca 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -792,11 +792,6 @@ struct journal_s
 	 */
 	journal_superblock_t	*j_superblock;
 
-	/**
-	 * @j_format_version: Version of the superblock format.
-	 */
-	int			j_format_version;
-
 	/**
 	 * @j_state_lock: Protect the various scalars in the journal.
 	 */
-- 
2.31.1

