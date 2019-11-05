Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F00CF033B
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2019 17:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390345AbfKEQoj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 5 Nov 2019 11:44:39 -0500
Received: from mx2.suse.de ([195.135.220.15]:41516 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2390337AbfKEQoj (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 5 Nov 2019 11:44:39 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A4F22B02E;
        Tue,  5 Nov 2019 16:44:37 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 2EF481E4AA4; Tue,  5 Nov 2019 17:44:37 +0100 (CET)
From:   Jan Kara <jack@suse.cz>
To:     Ted Tso <tytso@mit.edu>
Cc:     <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>
Subject: [PATCH 03/25] jbd2: Completely fill journal descriptor blocks
Date:   Tue,  5 Nov 2019 17:44:09 +0100
Message-Id: <20191105164437.32602-3-jack@suse.cz>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191003215523.7313-1-jack@suse.cz>
References: <20191003215523.7313-1-jack@suse.cz>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With 32-bit block numbers, we don't allocate the array for journal
buffer heads large enough for corresponding descriptor tags to fill the
descriptor block. Thus we end up writing out half-full descriptor blocks
to the journal unnecessarily growing the transaction. Fix the logic to
allocate the array large enough.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 fs/jbd2/journal.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index 1c58859aa592..cc11097f1176 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1098,6 +1098,16 @@ static void jbd2_stats_proc_exit(journal_t *journal)
 	remove_proc_entry(journal->j_devname, proc_jbd2_stats);
 }
 
+/* Minimum size of descriptor tag */
+static int jbd2_min_tag_size(void)
+{
+	/*
+	 * Tag with 32-bit block numbers does not use last four bytes of the
+	 * structure
+	 */
+	return sizeof(journal_block_tag_t) - 4;
+}
+
 /*
  * Management for journal control blocks: functions to create and
  * destroy journal_t structures, and to initialise and read existing
@@ -1156,7 +1166,8 @@ static journal_t *journal_init_common(struct block_device *bdev,
 	journal->j_fs_dev = fs_dev;
 	journal->j_blk_offset = start;
 	journal->j_maxlen = len;
-	n = journal->j_blocksize / sizeof(journal_block_tag_t);
+	/* We need enough buffers to write out full descriptor block. */
+	n = journal->j_blocksize / jbd2_min_tag_size();
 	journal->j_wbufsize = n;
 	journal->j_wbuf = kmalloc_array(n, sizeof(struct buffer_head *),
 					GFP_KERNEL);
-- 
2.16.4

