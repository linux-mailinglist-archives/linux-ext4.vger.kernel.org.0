Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAD761EC43
	for <lists+linux-ext4@lfdr.de>; Wed, 15 May 2019 12:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726520AbfEOKqb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 15 May 2019 06:46:31 -0400
Received: from mx2.suse.de ([195.135.220.15]:60026 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725953AbfEOKqa (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 15 May 2019 06:46:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E7057AE4E;
        Wed, 15 May 2019 10:46:29 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id ACC881E3CA1; Wed, 15 May 2019 12:46:27 +0200 (CEST)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH] ext4: Avoid panic during forced reboot due to aborted journal
Date:   Wed, 15 May 2019 12:46:22 +0200
Message-Id: <20190515104622.6793-1-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Handling of aborted journal is a special code path different from
standard ext4_error() one and it can call panic() as well. Commit
1dc1097ff60e ("ext4: avoid panic during forced reboot") forgot to update
this path so fix that omission.

Fixes: 1dc1097ff60e ("ext4: avoid panic during forced reboot")
Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index f71b5254a990..f48955bbf9d7 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -699,7 +699,7 @@ void __ext4_abort(struct super_block *sb, const char *function,
 			jbd2_journal_abort(EXT4_SB(sb)->s_journal, -EIO);
 		save_error_info(sb, function, line);
 	}
-	if (test_opt(sb, ERRORS_PANIC)) {
+	if (test_opt(sb, ERRORS_PANIC) && !system_going_down()) {
 		if (EXT4_SB(sb)->s_journal &&
 		  !(EXT4_SB(sb)->s_journal->j_flags & JBD2_REC_ERR))
 			return;
-- 
2.16.4

