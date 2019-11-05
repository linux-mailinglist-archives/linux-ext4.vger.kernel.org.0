Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2595CF033A
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390342AbfKEQoj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 11:44:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:41520 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390060AbfKEQoj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 11:44:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 9740FAE6F;
        Tue,  5 Nov 2019 16:44:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2A3381E4AA0; Tue,  5 Nov 2019 17:44:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 02/25] jbd2: Fixup stale comment in commit code
Date:   Tue,  5 Nov 2019 17:44:08 +0100
Message-Id: <20191105164437.32602-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_journal_next_log_block() does not look at
transaction->t_outstanding_credits. Remove the misleading comment.

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/commit.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 132fb92098c7..c6d39f2ad828 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -642,8 +642,7 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 
 		/*
 		 * start_this_handle() uses t_outstanding_credits to determine
-		 * the free space in the log, but this counter is changed
-		 * by jbd2_journal_next_log_block() also.
+		 * the free space in the log.
 		 */
 		atomic_dec(&commit_transaction->t_outstanding_credits);
 
-- 
2.16.4

