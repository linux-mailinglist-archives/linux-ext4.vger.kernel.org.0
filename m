Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7668F3A90D4
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 06:56:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230392AbhFPE6s (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 00:58:48 -0400
Received: from mail.kernel.org ([198.145.29.99]:38814 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229543AbhFPE6r (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Jun 2021 00:58:47 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 15594610A0
        for <linux-ext4@vger.kernel.org>; Wed, 16 Jun 2021 04:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623819402;
        bh=2+3t0QiR5KDwqZ62fEe9j0Wzjup9aXsAP04ODNrtub0=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=N4HmOhq4MNySMecrBuygT9Ne2v6vfomtbNpBLsmDEof8HiM1KFqhWzgwaeKg0WB2Y
         erTdBmV5NjjWIapgM1uet1rfY9lExpLtQmIAuaB297UJZL0XzZ6dHBj6Kws2fhADc6
         WvZRWjF8+Xp9M8sB/y8D/5i/KoLVGAqqzMG+IsRVeM3dhFGFbDkhCZ51UqiomqwHMm
         IOkMr6OA3pAiXwAPJhZHvp9OBfved9nLa1gtNRlR245o7hPu/f2Jfxyh/ULDBUortr
         41VjBwnKXnk1cl8ZUyJzUy57iz0Bmr+7p7+euAKNLQqRV0go7N4XIWwkjH8GzSMr18
         CL14qqDRfKYoA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 1/6] libext2fs: improve jbd_debug() implementation
Date:   Tue, 15 Jun 2021 21:53:29 -0700
Message-Id: <20210616045334.1655288-2-ebiggers@kernel.org>
X-Mailer: git-send-email 2.32.0.272.g935e593368-goog
In-Reply-To: <20210616045334.1655288-1-ebiggers@kernel.org>
References: <20210616045334.1655288-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

Make jbd_debug() do format string checking (but still get compiled away
to nothing) when --enable-jbd-debug isn't specified, similar to
commit d556435156b7 ("jbd2: avoid -Wempty-body warnings") on the kernel
side.  This should prevent --enable-jbd-debug from getting broken due to
bad jbd_debug() statements.  It also eliminates a -Wunused-variable
warning where a variable was only used in a jbd_debug() statement.

Also remove an alternative definition of jbd_debug() that was
conditional on CONFIG_JBD_DEBUG && !CONFIG_JBD_DEBUG, so was dead code.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 debugfs/journal.c       |  4 ----
 e2fsck/journal.c        |  4 ----
 lib/ext2fs/kernel-jbd.h | 26 +++++---------------------
 3 files changed, 5 insertions(+), 29 deletions(-)

diff --git a/debugfs/journal.c b/debugfs/journal.c
index e8872f05..686d0eb0 100644
--- a/debugfs/journal.c
+++ b/debugfs/journal.c
@@ -26,9 +26,7 @@
 #include "uuid/uuid.h"
 #include "journal.h"
 
-#ifdef CONFIG_JBD_DEBUG		/* Enabled by configure --enable-jfs-debug */
 static int bh_count = 0;
-#endif
 
 #if EXT2_FLAT_INCLUDES
 #include "blkid.h"
@@ -135,10 +133,8 @@ struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
 	if (retval)
 		return NULL;
 
-#ifdef CONFIG_JBD_DEBUG
 	if (journal_enable_debug >= 3)
 		bh_count++;
-#endif
 	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
 		  blocknr, blocksize, bh_count);
 
diff --git a/e2fsck/journal.c b/e2fsck/journal.c
index a425bbd1..a0a4d968 100644
--- a/e2fsck/journal.c
+++ b/e2fsck/journal.c
@@ -27,9 +27,7 @@
 #include "problem.h"
 #include "uuid/uuid.h"
 
-#ifdef CONFIG_JBD_DEBUG		/* Enabled by configure --enable-jfs-debug */
 static int bh_count = 0;
-#endif
 
 /*
  * Define USE_INODE_IO to use the inode_io.c / fileio.c codepaths.
@@ -129,10 +127,8 @@ struct buffer_head *getblk(kdev_t kdev, unsigned long long blocknr,
 	if (!bh)
 		return NULL;
 
-#ifdef CONFIG_JBD_DEBUG
 	if (journal_enable_debug >= 3)
 		bh_count++;
-#endif
 	jfs_debug(4, "getblk for block %llu (%d bytes)(total %d)\n",
 		  blocknr, blocksize, bh_count);
 
diff --git a/lib/ext2fs/kernel-jbd.h b/lib/ext2fs/kernel-jbd.h
index 2978ccb6..c94de237 100644
--- a/lib/ext2fs/kernel-jbd.h
+++ b/lib/ext2fs/kernel-jbd.h
@@ -26,7 +26,6 @@
 
 #define journal_oom_retry 0
 
-#ifdef __STDC__
 #ifdef CONFIG_JBD_DEBUG
 /*
  * Define JBD_EXPENSIVE_CHECKING to enable more expensive internal
@@ -35,7 +34,11 @@
  */
 #define JBD_EXPENSIVE_CHECKING
 extern int journal_enable_debug;
+#else
+#define journal_enable_debug (-1)
+#endif /* !CONFIG_JBD_DEBUG */
 
+#ifdef __STDC__
 #define jbd_debug(n, f, a...)						\
 	do {								\
 		if ((n) <= journal_enable_debug) {			\
@@ -45,27 +48,8 @@ extern int journal_enable_debug;
 		}							\
 	} while (0)
 #else
-#ifdef __GNUC__
-#if defined(__KERNEL__) || !defined(CONFIG_JBD_DEBUG)
-#define jbd_debug(f, a...)	/**/
-#else
-extern int journal_enable_debug;
-#define jbd_debug(n, f, a...)						\
-	do {								\
-		if ((n) <= journal_enable_debug) {			\
-			printf("(%s, %d): %s: ",			\
-				__FILE__, __LINE__, __func__);		\
-			printf(f, ## a);				\
-		}							\
-	} while (0)
-#endif /*__KERNEL__ */
-#else
-#define jbd_debug(f, ...)	/**/
-#endif
-#endif
-#else
 #define jbd_debug(x)		/* AIX doesn't do STDC */
-#endif
+#endif /* !__STDC__ */
 
 extern void * __jbd_kmalloc (char *where, size_t size, int flags, int retry);
 #define jbd_kmalloc(size, flags) \
-- 
2.32.0.272.g935e593368-goog

