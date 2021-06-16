Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C63A90D6
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 06:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhFPE6v (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 00:58:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:38816 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229559AbhFPE6r (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Jun 2021 00:58:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4A04C613B9
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 04:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623819402;
        bh=cp+/sUprr2jxLTFO95sbImHWfZ6xm97+fgls0B+Tf24=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=lrOPnektRvzrIWj7poz+72rtoQj79A5tpZgpG+KiRBQmyjwouMBsToS9+hlmk0FNp
         GckvwVyt11VZW6Tlz3CF8NDv6DAo2ed0OFPiYgdIuUGcsXoH+utSs6skdQXGvrpWkV
         mjmq79as+ytxc2tJc3dasvLHzJ9S5mNxA596xxUbPM6zubd2W9OFT34XR4VvWiLeNV
         /3I3hL18b2RS2MPxUxH3DwHnBEd1OsWTzjYy/+gp+brx3a7mR30wKCnMbffcQlY7fA
         w14xU458GefzpFxLmtT12mMVTFc3ZNBt7FSOeOdhpoox+OhC2MdJuXLkrtlYmLgJCu
         ID4gSa7URNluA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 2/6] e2fsck: sync fc_do_one_pass() changes from kernel
Date:   Tue, 15 Jun 2021 21:53:30 -0700
Message-Id: <20210616045334.1655288-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616045334.1655288-1-ebiggers@kernel.org>
References: <20210616045334.1655288-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Sync the changes to fc_do_one_pass() from the kernel's recovery.c so
that e2fsck picks up the fixes to the jbd_debug() statements.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 e2fsck/recovery.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/e2fsck/recovery.c b/e2fsck/recovery.c
index dc0694fc..1e07dfac 100644
--- a/e2fsck/recovery.c
+++ b/e2fsck/recovery.c
@@ -245,15 +245,14 @@ static int fc_do_one_pass(journal_t *journal,
 		return 0;
 
 	while (next_fc_block <= journal->j_fc_last) {
-		jbd_debug(3, "Fast commit replay: next block %ld",
+		jbd_debug(3, "Fast commit replay: next block %ld\n",
 			  next_fc_block);
 		err = jread(&bh, journal, next_fc_block);
 		if (err) {
-			jbd_debug(3, "Fast commit replay: read error");
+			jbd_debug(3, "Fast commit replay: read error\n");
 			break;
 		}
 
-		jbd_debug(3, "Processing fast commit blk with seq %d");
 		err = journal->j_fc_replay_callback(journal, bh, pass,
 					next_fc_block - journal->j_fc_first,
 					expected_commit_id);
-- 
2.32.0.272.g935e593368-goog

