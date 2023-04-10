Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC56DC9E7
	for <lists+linux-ext4@lfdr.de>; Mon, 10 Apr 2023 19:22:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230027AbjDJRWN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 10 Apr 2023 13:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229789AbjDJRWM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 10 Apr 2023 13:22:12 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83C252114;
        Mon, 10 Apr 2023 10:22:11 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=u202112087@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 33AHLcbu007619-33AHLcbv007619
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 11 Apr 2023 01:21:53 +0800
From:   Guoqing Cai <u202112087@hust.edu.cn>
To:     "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>
Cc:     HUST OS Kernel Contribution 
        <hust-os-kernel-patches@googlegroups.com>,
        Guoqing Cai <u202112087@hust.edu.cn>,
        Dongliang Mu <dzm91@hust.edu.cn>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] fs: jbd2: fix an incorrect warn log
Date:   Tue, 11 Apr 2023 01:20:38 +0800
Message-Id: <20230410172039.1752440-1-u202112087@hust.edu.cn>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: u202112087@hust.edu.cn
X-Spam-Status: No, score=-0.0 required=5.0 tests=SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

In jbd2_journal_load(), when journal_reset fails, it prints an incorrect
warn log.

Fix this by changing the goto statement to return statement.

Signed-off-by: Guoqing Cai <u202112087@hust.edu.cn>
Reviewed-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 fs/jbd2/journal.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index e80c781731f8..555f09ca1d99 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -2082,8 +2082,10 @@ int jbd2_journal_load(journal_t *journal)
 
 	/* Let the recovery code check whether it needs to recover any
 	 * data from the journal. */
-	if (jbd2_journal_recover(journal))
-		goto recovery_error;
+	if (jbd2_journal_recover(journal)) {
+		printk(KERN_WARNING "JBD2: recovery failed\n");
+		return -EIO;
+	}
 
 	if (journal->j_failed_commit) {
 		printk(KERN_ERR "JBD2: journal transaction %u on %s "
@@ -2101,14 +2103,10 @@ int jbd2_journal_load(journal_t *journal)
 	 * reinitialise the dynamic contents of the superblock in memory
 	 * and reset them on disk. */
 	if (journal_reset(journal))
-		goto recovery_error;
+		return -EIO;
 
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

