Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CF4C117B87
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Dec 2019 00:36:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727091AbfLIXg2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Dec 2019 18:36:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:47954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726592AbfLIXg1 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Dec 2019 18:36:27 -0500
Received: from ebiggers-linuxstation.mtv.corp.google.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 991B7206D3
        for <linux-ext4@vger.kernel.org>; Mon,  9 Dec 2019 23:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1575934586;
        bh=7X5izyTa35DtFX/RC5B2vM3OWWRfmj3AGQK8mKHiAEQ=;
        h=From:To:Subject:Date:From;
        b=Ow54M07oXk9HOLvcW59QfUoyCQabGlomKmOYa1N2TAE2vDq/CA87GXYVF1KBmUflF
         d1R3ZaVP0VmnXrgmlsO2vyoudGEszS93fGoroGhc8oC7vbe/S6l47MM+iKZ+tX5gUg
         0cCEY3wYSMwepaPLSyCKWB3EzwEPZrAmZRv+T0CI=
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH] ext4: uninline ext4_inode_journal_mode()
Date:   Mon,  9 Dec 2019 15:36:02 -0800
Message-Id: <20191209233602.117778-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.24.0.393.g34dc348eaf-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Determining an inode's journaling mode has gotten more complicated over
time.  Move ext4_inode_journal_mode() from an inline function into
ext4_jbd2.c to reduce the compiled code size.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ext4/ext4_jbd2.c | 22 ++++++++++++++++++++++
 fs/ext4/ext4_jbd2.h | 22 +---------------------
 2 files changed, 23 insertions(+), 21 deletions(-)

diff --git a/fs/ext4/ext4_jbd2.c b/fs/ext4/ext4_jbd2.c
index d3b8cdea5df75..621c9e19d081f 100644
--- a/fs/ext4/ext4_jbd2.c
+++ b/fs/ext4/ext4_jbd2.c
@@ -7,6 +7,28 @@
 
 #include <trace/events/ext4.h>
 
+int ext4_inode_journal_mode(struct inode *inode)
+{
+	if (EXT4_JOURNAL(inode) == NULL)
+		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
+	/* We do not support data journalling with delayed allocation */
+	if (!S_ISREG(inode->i_mode) ||
+	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
+	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
+	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
+	    !test_opt(inode->i_sb, DELALLOC))) {
+		/* We do not support data journalling for encrypted data */
+		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
+			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
+		return EXT4_INODE_JOURNAL_DATA_MODE;	/* journal data */
+	}
+	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
+		return EXT4_INODE_ORDERED_DATA_MODE;	/* ordered */
+	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_WRITEBACK_DATA)
+		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
+	BUG();
+}
+
 /* Just increment the non-pointer handle value */
 static handle_t *ext4_get_nojournal(void)
 {
diff --git a/fs/ext4/ext4_jbd2.h b/fs/ext4/ext4_jbd2.h
index a6b9b66dbfade..7ea4f6fa173b4 100644
--- a/fs/ext4/ext4_jbd2.h
+++ b/fs/ext4/ext4_jbd2.h
@@ -463,27 +463,7 @@ int ext4_force_commit(struct super_block *sb);
 #define EXT4_INODE_ORDERED_DATA_MODE	0x02 /* ordered data mode */
 #define EXT4_INODE_WRITEBACK_DATA_MODE	0x04 /* writeback data mode */
 
-static inline int ext4_inode_journal_mode(struct inode *inode)
-{
-	if (EXT4_JOURNAL(inode) == NULL)
-		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
-	/* We do not support data journalling with delayed allocation */
-	if (!S_ISREG(inode->i_mode) ||
-	    ext4_test_inode_flag(inode, EXT4_INODE_EA_INODE) ||
-	    test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_JOURNAL_DATA ||
-	    (ext4_test_inode_flag(inode, EXT4_INODE_JOURNAL_DATA) &&
-	    !test_opt(inode->i_sb, DELALLOC))) {
-		/* We do not support data journalling for encrypted data */
-		if (S_ISREG(inode->i_mode) && IS_ENCRYPTED(inode))
-			return EXT4_INODE_ORDERED_DATA_MODE;  /* ordered */
-		return EXT4_INODE_JOURNAL_DATA_MODE;	/* journal data */
-	}
-	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_ORDERED_DATA)
-		return EXT4_INODE_ORDERED_DATA_MODE;	/* ordered */
-	if (test_opt(inode->i_sb, DATA_FLAGS) == EXT4_MOUNT_WRITEBACK_DATA)
-		return EXT4_INODE_WRITEBACK_DATA_MODE;	/* writeback */
-	BUG();
-}
+int ext4_inode_journal_mode(struct inode *inode);
 
 static inline int ext4_should_journal_data(struct inode *inode)
 {
-- 
2.24.0.393.g34dc348eaf-goog

