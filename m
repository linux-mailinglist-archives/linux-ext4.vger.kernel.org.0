Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87FD5687F5F
	for <lists+linux-ext4@lfdr.de>; Thu,  2 Feb 2023 14:57:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjBBN5H (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 2 Feb 2023 08:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBBN5G (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 2 Feb 2023 08:57:06 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B234CE7F
        for <linux-ext4@vger.kernel.org>; Thu,  2 Feb 2023 05:57:03 -0800 (PST)
Received: from dggpeml500021.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4P70hL0c0gzfYq9;
        Thu,  2 Feb 2023 21:56:50 +0800 (CST)
Received: from huawei.com (10.175.127.227) by dggpeml500021.china.huawei.com
 (7.185.36.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 2 Feb
 2023 21:57:00 +0800
From:   Baokun Li <libaokun1@huawei.com>
To:     <linux-ext4@vger.kernel.org>
CC:     <tytso@mit.edu>, <adilger.kernel@dilger.ca>, <jack@suse.cz>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>,
        <yukuai3@huawei.com>, <libaokun1@huawei.com>
Subject: [PATCH] debugfs: check first journal block type when a tail-to-head reversal occurs in logdump
Date:   Thu, 2 Feb 2023 22:20:55 +0800
Message-ID: <20230202142055.2482087-1-libaokun1@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.127.227]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500021.china.huawei.com (7.185.36.21)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

When logs are dumped, if the last description block in the journal area
contains the first journal block as the data block, logs may be repeatedly
printed or not completely printed. After the journal replay, we always
restart logging from the first journal block. In this case, there are the
following two cases:

1) If start == first, the first block is always skipped due to reversal.
Therefore, the condition (blocknr == first_transaction_blocknr) for
determining repeated printing does not take effect. As a result, logs are
repeatedly printed.

2) If start != first, we will traverse backwards from the first non-data
block after the last journal data block in the last description block, and
the logs from the first journal block to this block will not be printed.
That is, the dump log is incomplete.

To solve this problem, we only need to check the type of the first log
block when reversal occurs. If it is a non-log data block, we should
continue to dump directly from the first block.

Signed-off-by: Baokun Li <libaokun1@huawei.com>
---
 debugfs/logdump.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/debugfs/logdump.c b/debugfs/logdump.c
index b103cf1e..0019b6cf 100644
--- a/debugfs/logdump.c
+++ b/debugfs/logdump.c
@@ -740,6 +740,18 @@ static void dump_descriptor_block(FILE *out_file,
 
 	} while (!(tag_flags & JBD2_FLAG_LAST_TAG));
 
+	/* When a tail-to-head reversal occurs, we need to check whether
+	 * there is a log that starts from the beginning again.
+	 */
+	if (*blockp > blocknr) {
+		journal_header_t first_header = {0};
+
+		read_journal_block("logdump", source, blocksize,
+				   (char *)&first_header, sizeof(journal_header_t));
+		if ((be32_to_cpu(first_header.h_magic) == JBD2_MAGIC_NUMBER) &&
+		    (be32_to_cpu(first_header.h_blocktype) == JBD2_DESCRIPTOR_BLOCK))
+			blocknr = 1;
+	}
 	*blockp = blocknr;
 }
 
-- 
2.31.1

