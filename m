Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51BD16E0AD7
	for <lists+linux-ext4@lfdr.de>; Thu, 13 Apr 2023 11:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjDMJ6j (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 13 Apr 2023 05:58:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDMJ6h (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 13 Apr 2023 05:58:37 -0400
Received: from hust.edu.cn (mail.hust.edu.cn [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 322997692;
        Thu, 13 Apr 2023 02:58:35 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=u202112087@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33D9vs1T014113-33D9vs1U014113
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Thu, 13 Apr 2023 17:58:15 +0800
From:   Guoqing Cai <u202112087@hust.edu.cn>
To:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc:     HUST OS Kernel Contribution 
        <hust-os-kernel-patches@googlegroups.com>,
        Guoqing Cai <u202112087@hust.edu.cn>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] fs: jbd2: fix an incorrect warn log
Date:   Thu, 13 Apr 2023 17:57:39 +0800
Message-Id: <20230413095740.2222066-1-u202112087@hust.edu.cn>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: u202112087@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In jbd2_journal_load(), when journal_reset fails, it prints an incorrect
warn log.

Fix this by changing the goto statement to return statement.

Also, return actual error code from jbd2_journal_recover() and journal_reset().

Signed-off-by: Guoqing Cai <u202112087@hust.edu.cn>
---
changelog:
- Add a warning log when journal_reset failed.
- Return the actual error code.
---
 fs/jbd2/journal.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e80c781731f8..147733dd5cc3 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2082,8 +2082,11 @@ int jbd2_journal_load(journal_t *journal)
 
 	/* Let the recovery code check whether it needs to recover any
 	 * data from the journal. */
-	if (jbd2_journal_recover(journal))
-		goto recovery_error;
+	err = jbd2_journal_recover(journal);
+	if (err) {
+		pr_warn("JBD2: journal recovery failed\n");
+		return err;
+	}
 
 	if (journal->j_failed_commit) {
 		printk(KERN_ERR "JBD2: journal transaction %u on %s "
@@ -2100,15 +2103,14 @@ int jbd2_journal_load(journal_t *journal)
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
 	 * and reset them on disk. */
-	if (journal_reset(journal))
-		goto recovery_error;
+	err = journal_reset(journal);
+	if (err) {
+		pr_warn("JBD2: journal reset failed\n");
+		return err;
+	}
 
 	journal->j_flags |= JBD2_LOADED;
 	return 0;
-
-recovery_error:
-	printk(KERN_WARNING "JBD2: recovery failed\n");
-	return -EIO;
 }
 
 /**
-- 
2.40.0

