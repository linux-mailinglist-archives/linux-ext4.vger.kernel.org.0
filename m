Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DB936CB1A4
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2019 00:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731257AbfJCWFx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Oct 2019 18:05:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:49614 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731119AbfJCWFx (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 3 Oct 2019 18:05:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 34DC5AD3A;
        Thu,  3 Oct 2019 22:05:52 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0CE821E4813; Fri,  4 Oct 2019 00:06:14 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     <linux-ext4@vger.kernel.org>
Cc:     Ted Tso <tytso@mit.edu>, Jan Kara <jack@suse.cz>
Subject: [PATCH 02/22] jbd2: Fixup stale comment in commit code
Date:   Fri,  4 Oct 2019 00:05:48 +0200
Message-Id: <20191003220613.10791-2-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

jbd2_journal_next_log_block() does not look at
transaction->t_outstanding_credits. Remove the misleading comment.

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

