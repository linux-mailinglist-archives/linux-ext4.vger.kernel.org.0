Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126D76BA4B7
	for <lists+linux-ext4@lfdr.de>; Wed, 15 Mar 2023 02:33:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbjCOBdB (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 14 Mar 2023 21:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbjCOBcx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 14 Mar 2023 21:32:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C74C26CD6;
        Tue, 14 Mar 2023 18:32:23 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4PbtCJ728YzrSmT;
        Wed, 15 Mar 2023 09:31:24 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 15 Mar
 2023 09:32:17 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v3 4/6] jbd2: switch to check format version in superblock directly
Date:   Wed, 15 Mar 2023 09:31:26 +0800
Message-ID: <20230315013128.3911115-5-chengzhihao1@huawei.com>
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

We should only check and set extented features if journal format version
is 2, and now we check the in memory copy of the superblock
'journal->j_format_version', which relys on the parameter initialization
sequence, switch to use the h_blocktype in superblock cloud be more
clear.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c    | 16 +++++++---------
 include/linux/jbd2.h | 17 ++++++++++++++---
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 8ae419152ff6..8d5fe6738cc4 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2062,10 +2062,12 @@ int jbd2_journal_load(journal_t *journal)
 		return err;
 
 	sb = journal->j_superblock;
-	/* If this is a V2 superblock, then we have to check the
-	 * features flags on it. */
 
-	if (journal->j_format_version >= 2) {
+	/*
+	 * If this is a V2 superblock, then we have to check the
+	 * features flags on it.
+	 */
+	if (jbd2_format_support_feature(journal)) {
 		if ((sb->s_feature_ro_compat &
 		     ~cpu_to_be32(JBD2_KNOWN_ROCOMPAT_FEATURES)) ||
 		    (sb->s_feature_incompat &
@@ -2227,7 +2229,7 @@ int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
 	if (journal->j_format_version == 0 &&
 	    journal_get_superblock(journal) != 0)
 		return 0;
-	if (journal->j_format_version == 1)
+	if (!jbd2_format_support_feature(journal))
 		return 0;
 
 	sb = journal->j_superblock;
@@ -2257,11 +2259,7 @@ int jbd2_journal_check_available_features(journal_t *journal, unsigned long comp
 	if (!compat && !ro && !incompat)
 		return 1;
 
-	/* We can support any known requested features iff the
-	 * superblock is in version 2.  Otherwise we fail to support any
-	 * extended sb features. */
-
-	if (journal->j_format_version != 2)
+	if (!jbd2_format_support_feature(journal))
 		return 0;
 
 	if ((compat   & JBD2_KNOWN_COMPAT_FEATURES) == compat &&
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index a91cf9c7a94b..1ffcea5c024e 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1313,11 +1313,22 @@ struct journal_s
 		rwsem_release(&j->j_trans_commit_map, _THIS_IP_); \
 	} while (0)
 
+/*
+ * We can support any known requested features iff the
+ * superblock is not in version 1.  Otherwise we fail to support any
+ * extended sb features.
+ */
+static inline bool jbd2_format_support_feature(journal_t *j)
+{
+	return j->j_superblock->s_header.h_blocktype !=
+					cpu_to_be32(JBD2_SUPERBLOCK_V1);
+}
+
 /* journal feature predicate functions */
 #define JBD2_FEATURE_COMPAT_FUNCS(name, flagname) \
 static inline bool jbd2_has_feature_##name(journal_t *j) \
 { \
-	return ((j)->j_format_version >= 2 && \
+	return (jbd2_format_support_feature(j) && \
 		((j)->j_superblock->s_feature_compat & \
 		 cpu_to_be32(JBD2_FEATURE_COMPAT_##flagname)) != 0); \
 } \
@@ -1335,7 +1346,7 @@ static inline void jbd2_clear_feature_##name(journal_t *j) \
 #define JBD2_FEATURE_RO_COMPAT_FUNCS(name, flagname) \
 static inline bool jbd2_has_feature_##name(journal_t *j) \
 { \
-	return ((j)->j_format_version >= 2 && \
+	return (jbd2_format_support_feature(j) && \
 		((j)->j_superblock->s_feature_ro_compat & \
 		 cpu_to_be32(JBD2_FEATURE_RO_COMPAT_##flagname)) != 0); \
 } \
@@ -1353,7 +1364,7 @@ static inline void jbd2_clear_feature_##name(journal_t *j) \
 #define JBD2_FEATURE_INCOMPAT_FUNCS(name, flagname) \
 static inline bool jbd2_has_feature_##name(journal_t *j) \
 { \
-	return ((j)->j_format_version >= 2 && \
+	return (jbd2_format_support_feature(j) && \
 		((j)->j_superblock->s_feature_incompat & \
 		 cpu_to_be32(JBD2_FEATURE_INCOMPAT_##flagname)) != 0); \
 } \
-- 
2.31.1

