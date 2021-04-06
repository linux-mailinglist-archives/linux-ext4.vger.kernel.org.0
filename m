Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4AFE35590B
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Apr 2021 18:18:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbhDFQSO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Apr 2021 12:18:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:44598 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234032AbhDFQSN (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 6 Apr 2021 12:18:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 2E370B21D;
        Tue,  6 Apr 2021 16:18:05 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id EFED81F2C52; Tue,  6 Apr 2021 18:18:04 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Hao Sun <sunhao.th@gmail.com>
Subject: [PATCH 2/2] ext4: Annotate data race in jbd2_journal_dirty_metadata()
Date:   Tue,  6 Apr 2021 18:18:00 +0200
Message-Id: <20210406161804.20150-2-jack@suse.cz>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20210406161605.2504-1-jack@suse.cz>
References: <20210406161605.2504-1-jack@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Assertion checks in jbd2_journal_dirty_metadata() are known to be racy
but we don't want to be grabbing locks just for them.  We thus recheck
them under b_state_lock only if it looks like they would fail. Annotate
the checks with data_race().

Reported-by: Hao Sun <sunhao.th@gmail.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/transaction.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/jbd2/transaction.c b/fs/jbd2/transaction.c
index 398d1d9209e2..e8fc45fd751f 100644
--- a/fs/jbd2/transaction.c
+++ b/fs/jbd2/transaction.c
@@ -1479,8 +1479,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	 * crucial to catch bugs so let's do a reliable check until the
 	 * lockless handling is fully proven.
 	 */
-	if (jh->b_transaction != transaction &&
-	    jh->b_next_transaction != transaction) {
+	if (data_race(jh->b_transaction != transaction &&
+	    jh->b_next_transaction != transaction)) {
 		spin_lock(&jh->b_state_lock);
 		J_ASSERT_JH(jh, jh->b_transaction == transaction ||
 				jh->b_next_transaction == transaction);
@@ -1488,8 +1488,8 @@ int jbd2_journal_dirty_metadata(handle_t *handle, struct buffer_head *bh)
 	}
 	if (jh->b_modified == 1) {
 		/* If it's in our transaction it must be in BJ_Metadata list. */
-		if (jh->b_transaction == transaction &&
-		    jh->b_jlist != BJ_Metadata) {
+		if (data_race(jh->b_transaction == transaction &&
+		    jh->b_jlist != BJ_Metadata)) {
 			spin_lock(&jh->b_state_lock);
 			if (jh->b_transaction == transaction &&
 			    jh->b_jlist != BJ_Metadata)
-- 
2.26.2

