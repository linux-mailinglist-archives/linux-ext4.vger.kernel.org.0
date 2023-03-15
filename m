Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBA36BA4BD
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 02:33:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjCOBdS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 21:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbjCOBdD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 21:33:03 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7805C32513;
        Tue, 14 Mar 2023 18:32:34 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Pbt8y1ks7znX4T;
        Wed, 15 Mar 2023 09:29:22 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 15 Mar
 2023 09:32:19 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 6/6] jbd2: remove j_format_version
Date:   Wed, 15 Mar 2023 09:31:28 +0800
Message-ID: <20230315013128.3911115-7-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230315013128.3911115-1-chengzhihao1@huawei.com>
References: <20230315013128.3911115-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c    | 9 ---------
 include/linux/jbd2.h | 5 -----
 2 files changed, 14 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index ee678f9e40c4..837a9a85e585 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2006,15 +2006,6 @@ static int load_superblock(journal_t *journal)
 
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
index 1ffcea5c024e..6990fc891612 100644
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

