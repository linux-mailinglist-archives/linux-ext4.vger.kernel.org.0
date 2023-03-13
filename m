Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DECF6B78BF
	for <lists+linux-ext4@lfdr.de>; Mon, 13 Mar 2023 14:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjCMNVW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 13 Mar 2023 09:21:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbjCMNVP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 13 Mar 2023 09:21:15 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41CA04AFEB;
        Mon, 13 Mar 2023 06:21:14 -0700 (PDT)
Received: from kwepemm600013.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4PZxzs6ZtHz17KJ4;
        Mon, 13 Mar 2023 21:18:17 +0800 (CST)
Received: from huawei.com (10.175.127.227) by kwepemm600013.china.huawei.com
 (7.193.23.68) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 13 Mar
 2023 21:21:11 +0800
From:   Zhihao Cheng <chengzhihao1@huawei.com>
To:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.com>,
        <tudor.ambarus@linaro.org>
CC:     <linux-ext4@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>
Subject: [PATCH v2 4/5] jbd2: factor out journal initialization from journal_get_superblock()
Date:   Mon, 13 Mar 2023 21:20:20 +0800
Message-ID: <20230313132021.672134-5-chengzhihao1@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20230313132021.672134-1-chengzhihao1@huawei.com>
References: <20230313132021.672134-1-chengzhihao1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600013.china.huawei.com (7.193.23.68)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Zhang Yi <yi.zhang@huawei.com>

Current journal_get_superblock() couple journal superblock checking and
partial journal initialization, factor out initialization part from it
to make things clear.

Signed-off-by: Zhang Yi <yi.zhang@huawei.com>
Signed-off-by: Zhihao Cheng <chengzhihao1@huawei.com>
---
 fs/jbd2/journal.c | 46 ++++++++++++++++++++++------------------------
 1 file changed, 22 insertions(+), 24 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index b991d5c21d16..f99c46d880b2 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1922,21 +1922,13 @@ static int journal_get_superblock(journal_t *journal)
 		goto out;
 	}
 
-	switch(be32_to_cpu(sb->s_header.h_blocktype)) {
-	case JBD2_SUPERBLOCK_V1:
-		journal->j_format_version = 1;
-		break;
-	case JBD2_SUPERBLOCK_V2:
-		journal->j_format_version = 2;
-		break;
-	default:
+	if (be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V1 &&
+	    be32_to_cpu(sb->s_header.h_blocktype) != JBD2_SUPERBLOCK_V2) {
 		printk(KERN_WARNING "JBD2: unrecognised superblock format ID\n");
 		goto out;
 	}
 
-	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
-		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
-	else if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
+	if (be32_to_cpu(sb->s_maxlen) > journal->j_total_len) {
 		printk(KERN_WARNING "JBD2: journal file too short\n");
 		goto out;
 	}
@@ -1979,25 +1971,14 @@ static int journal_get_superblock(journal_t *journal)
 			journal->j_chksum_driver = NULL;
 			goto out;
 		}
-	}
-
-	if (jbd2_journal_has_csum_v2or3(journal)) {
 		/* Check superblock checksum */
 		if (sb->s_checksum != jbd2_superblock_csum(journal, sb)) {
 			printk(KERN_ERR "JBD2: journal checksum error\n");
 			err = -EFSBADCRC;
 			goto out;
 		}
-
-		/* Precompute checksum seed for all metadata */
-		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
-						   sizeof(sb->s_uuid));
 	}
-
-	journal->j_revoke_records_per_block =
-				journal_revoke_records_per_block(journal);
 	set_buffer_verified(bh);
-
 	return 0;
 
 out:
@@ -2022,12 +2003,30 @@ static int load_superblock(journal_t *journal)
 
 	sb = journal->j_superblock;
 
+	switch (be32_to_cpu(sb->s_header.h_blocktype)) {
+	case JBD2_SUPERBLOCK_V1:
+		journal->j_format_version = 1;
+		break;
+	case JBD2_SUPERBLOCK_V2:
+		journal->j_format_version = 2;
+		break;
+	}
+
 	journal->j_tail_sequence = be32_to_cpu(sb->s_sequence);
 	journal->j_tail = be32_to_cpu(sb->s_start);
 	journal->j_first = be32_to_cpu(sb->s_first);
 	journal->j_errno = be32_to_cpu(sb->s_errno);
 	journal->j_last = be32_to_cpu(sb->s_maxlen);
 
+	if (be32_to_cpu(sb->s_maxlen) < journal->j_total_len)
+		journal->j_total_len = be32_to_cpu(sb->s_maxlen);
+	/* Precompute checksum seed for all metadata */
+	if (jbd2_journal_has_csum_v2or3(journal))
+		journal->j_csum_seed = jbd2_chksum(journal, ~0, sb->s_uuid,
+						   sizeof(sb->s_uuid));
+	journal->j_revoke_records_per_block =
+				journal_revoke_records_per_block(journal);
+
 	if (jbd2_has_feature_fast_commit(journal)) {
 		journal->j_fc_last = be32_to_cpu(sb->s_maxlen);
 		num_fc_blocks = jbd2_journal_get_num_fc_blks(sb);
@@ -2223,8 +2222,7 @@ int jbd2_journal_check_used_features(journal_t *journal, unsigned long compat,
 	if (!compat && !ro && !incompat)
 		return 1;
 	/* Load journal superblock if it is not loaded yet. */
-	if (journal->j_format_version == 0 &&
-	    journal_get_superblock(journal) != 0)
+	if (journal_get_superblock(journal))
 		return 0;
 	if (!jbd2_format_support_feature(journal))
 		return 0;
-- 
2.31.1

