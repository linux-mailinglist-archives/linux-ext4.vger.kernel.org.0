Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26E02316311
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Feb 2021 11:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbhBJKA4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 10 Feb 2021 05:00:56 -0500
Received: from mx1.hrz.uni-dortmund.de ([129.217.128.51]:37286 "EHLO
        unimail.uni-dortmund.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbhBJJ6p (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 10 Feb 2021 04:58:45 -0500
Received: from ios.cs.uni-dortmund.de (ios.cs.uni-dortmund.de [129.217.43.100])
        (authenticated bits=0)
        by unimail.uni-dortmund.de (8.16.1/8.16.1) with ESMTPSA id 11A9vewj028502
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
        Wed, 10 Feb 2021 10:57:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
        s=unimail; t=1612951063;
        bh=qDYD80i6VVMjqchVzfARLfIkNCGcqAw2S45ciOFpyXA=;
        h=From:To:Cc:Subject:Date;
        b=XWh3fNWfg362unstw3nQqR5Wpmglb9NItw60VLqKW7h2R07r4zOyglEyV1Y3gXOhe
         KV3RmLAtxZEaeiaDmWwxq5VIGsq4ifa0FblvDIGVWEnfGZSzo8ll5szQtjhNA9/ueO
         fuU5ViQhcO3qMTJ9BXRs5NRIq6SpHDy9/u7R3GaU=
From:   Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Cc:     Alexander Lochmann <alexander.lochmann@tu-dortmund.de>,
        Horst Schirmeier <horst.schirmeier@tu-dortmund.de>,
        "Theodore Ts'o" <tytso@mit.edu>, Jan Kara <jack@suse.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] Updated locking documentation for journal_t
Date:   Wed, 10 Feb 2021 10:57:38 +0100
Message-Id: <20210210095740.54881-1-alexander.lochmann@tu-dortmund.de>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Some members of transaction_t are allowed to be read without
any lock being held if consistency doesn't matter.
Based on LockDoc's findings, we extended the locking
documentation of those members.
Each one of them is marked with a short comment:
"no lock for quick racy checks".

Signed-off-by: Alexander Lochmann <alexander.lochmann@tu-dortmund.de>
Signed-off-by: Horst Schirmeier <horst.schirmeier@tu-dortmund.de>
---
 include/linux/jbd2.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 18f77d9b1745..4dca33a063dd 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -768,7 +768,7 @@ enum passtype {PASS_SCAN, PASS_REVOKE, PASS_REPLAY};
 struct journal_s
 {
 	/**
-	 * @j_flags: General journaling state flags [j_state_lock]
+	 * @j_flags: General journaling state flags [j_state_lock, no lock for quick racy checks]
 	 */
 	unsigned long		j_flags;
 
@@ -808,7 +808,7 @@ struct journal_s
 	/**
 	 * @j_barrier_count:
 	 *
-	 * Number of processes waiting to create a barrier lock [j_state_lock]
+	 * Number of processes waiting to create a barrier lock [j_state_lock, no lock for quick racy checks]
 	 */
 	int			j_barrier_count;
 
@@ -821,7 +821,7 @@ struct journal_s
 	 * @j_running_transaction:
 	 *
 	 * Transactions: The current running transaction...
-	 * [j_state_lock] [caller holding open handle]
+	 * [j_state_lock, no lock for quick racy checks] [caller holding open handle]
 	 */
 	transaction_t		*j_running_transaction;
 
@@ -1033,7 +1033,7 @@ struct journal_s
 	 * @j_commit_sequence:
 	 *
 	 * Sequence number of the most recently committed transaction
-	 * [j_state_lock].
+	 * [j_state_lock, no lock for quick racy checks].
 	 */
 	tid_t			j_commit_sequence;
 
@@ -1041,7 +1041,7 @@ struct journal_s
 	 * @j_commit_request:
 	 *
 	 * Sequence number of the most recent transaction wanting commit
-	 * [j_state_lock]
+	 * [j_state_lock, no lock for quick racy checks]
 	 */
 	tid_t			j_commit_request;
 
-- 
2.20.1

