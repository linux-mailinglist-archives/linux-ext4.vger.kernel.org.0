Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA73137B1F
	for <lists+linux-ext4@lfdr.de>; Sat, 11 Jan 2020 03:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgAKC1J (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 10 Jan 2020 21:27:09 -0500
Received: from smtp.h3c.com ([60.191.123.50]:30106 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728062AbgAKC1I (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 10 Jan 2020 21:27:08 -0500
Received: from DAG2EX10-IDC.srv.huawei-3com.com ([10.8.0.73])
        by h3cspam02-ex.h3c.com with ESMTPS id 00B2Qhl7005200
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 11 Jan 2020 10:26:43 +0800 (GMT-8)
        (envelope-from li.kai4@h3c.com)
Received: from DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 11 Jan 2020 10:26:44 +0800
Received: from BJHUB01-EX.srv.huawei-3com.com (10.63.20.169) by
 DAG2EX10-IDC.srv.huawei-3com.com (10.8.0.73) with Microsoft SMTP Server
 (version=TLS1_0, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.1.1713.5
 via Frontend Transport; Sat, 11 Jan 2020 10:26:44 +0800
Received: from RDVDI-L14391V.h3c.huawei-3com.com (10.125.108.72) by
 rndsmtp.h3c.com (10.63.20.174) with Microsoft SMTP Server id 14.3.408.0; Sat,
 11 Jan 2020 10:26:33 +0800
From:   Kai Li <li.kai4@h3c.com>
To:     <jack@suse.cz>
CC:     <tytso@mit.edu>, <linux-ext4@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <joseph.qi@linux.alibaba.com>,
        <gechangwei@live.cn>, <wang.yongd@h3c.com>, <wang.xibo@h3c.com>,
        Kai Li <li.kai4@h3c.com>
Subject: [PATCH] jbd2: clear JBD2_ABORT flag before journal_reset to update log tail info when load journal
Date:   Sat, 11 Jan 2020 10:25:42 +0800
Message-ID: <20200111022542.5008-1-li.kai4@h3c.com>
X-Mailer: git-send-email 2.24.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.125.108.72]
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 00B2Qhl7005200
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fixes: 85e0c4e89c1b "jbd2: if the journal is aborted then don't allow update of the log tail"

If journal is dirty when mount, it will be replayed but jbd2 sb
log tail cannot be updated to mark a new start because
journal->j_flags has already been set with JBD2_ABORT first
in journal_init_common.
When a new transaction is committed, it will be recorded in block 1
first(journal->j_tail is set to 1 in journal_reset). If emergency
restart again before journal super block is updated unfortunately,
the new recorded trans will not be replayed in the next mount.
It is danerous which may lead to metadata corruption for file system.

Signed-off-by: Kai Li <li.kai4@h3c.com>
---
 fs/jbd2/journal.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 5e408ee24a1a..069b22eba795 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1710,6 +1710,11 @@ int jbd2_journal_load(journal_t *journal)
 		       journal->j_devname);
 		return -EFSCORRUPTED;
 	}
+	/*
+	 * clear JBD2_ABORT flag initialized in journal_init_common
+	 * here to update log tail information with the newest seq.
+	 */
+	journal->j_flags &= ~JBD2_ABORT;
 
 	/* OK, we've finished with the dynamic journal bits:
 	 * reinitialise the dynamic contents of the superblock in memory
@@ -1717,7 +1722,6 @@ int jbd2_journal_load(journal_t *journal)
 	if (journal_reset(journal))
 		goto recovery_error;
 
-	journal->j_flags &= ~JBD2_ABORT;
 	journal->j_flags |= JBD2_LOADED;
 	return 0;
 
-- 
2.24.0.windows.2

