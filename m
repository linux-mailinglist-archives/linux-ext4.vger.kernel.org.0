Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A479A19327E
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Mar 2020 22:18:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgCYVSx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 25 Mar 2020 17:18:53 -0400
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39590 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727351AbgCYVSx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 25 Mar 2020 17:18:53 -0400
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 6898028666B
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: [PATCH e2fsprogs 09/11] e2fsck: Add option to force encoded filename verification
Date:   Wed, 25 Mar 2020 17:18:09 -0400
Message-Id: <20200325211812.2971787-10-krisman@collabora.com>
X-Mailer: git-send-email 2.25.0
In-Reply-To: <20200325211812.2971787-1-krisman@collabora.com>
References: <20200325211812.2971787-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is interesting for !strict filesystems as part of the encoding
update procedure. Once the filesystem is known to not have badly encoded
filenames, the update is trivial, thanks to the stability of assigned
code points in the unicode specification.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 e2fsck/e2fsck.h | 1 +
 e2fsck/pass2.c  | 5 +++--
 e2fsck/unix.c   | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index 335a5e4c6dca..f0d206a4cba0 100644
--- a/e2fsck/e2fsck.h
+++ b/e2fsck/e2fsck.h
@@ -177,6 +177,7 @@ struct resource_track {
 #define E2F_OPT_ICOUNT_FULLMAP	0x20000 /* use an array for inode counts */
 #define E2F_OPT_UNSHARE_BLOCKS  0x40000
 #define E2F_OPT_CLEAR_UNINIT	0x80000 /* Hack to clear the uninit bit */
+#define E2F_OPT_CHECK_ENCODING  0x100000 /* Force verification of encoded filenames */
 
 /*
  * E2fsck flags
diff --git a/e2fsck/pass2.c b/e2fsck/pass2.c
index 3b9a2ac78b00..17e35d08c2b2 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -1048,9 +1048,10 @@ static int check_dir_block(ext2_filsys fs,
 	ctx = cd->ctx;
 
 	/* We only want filename encoding verification on strict
-	 * mode. */
+	 * mode or if explicitly requested by user. */
 	if (ext2fs_test_inode_bitmap2(ctx->inode_casefold_map, ino) &&
-	    (ctx->fs->super->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL))
+	    ((ctx->fs->super->s_encoding_flags & EXT4_ENC_STRICT_MODE_FL) ||
+	     (ctx->options & E2F_OPT_CHECK_ENCODING)))
 		cf_dir = 1;
 
 	if (ctx->flags & E2F_FLAG_RUN_RETURN)
diff --git a/e2fsck/unix.c b/e2fsck/unix.c
index b3ef0f22b866..168b4784d65e 100644
--- a/e2fsck/unix.c
+++ b/e2fsck/unix.c
@@ -753,6 +753,9 @@ static void parse_extended_opts(e2fsck_t ctx, const char *opts)
 			ctx->options |= E2F_OPT_UNSHARE_BLOCKS;
 			ctx->options |= E2F_OPT_FORCE;
 			continue;
+		} else if (strcmp(token, "check_encoding") == 0) {
+			ctx->options |= E2F_OPT_CHECK_ENCODING;
+			continue;
 #ifdef CONFIG_DEVELOPER_FEATURES
 		} else if (strcmp(token, "clear_all_uninit_bits") == 0) {
 			ctx->options |= E2F_OPT_CLEAR_UNINIT;
@@ -784,6 +787,7 @@ static void parse_extended_opts(e2fsck_t ctx, const char *opts)
 		fputs("\tbmap2extent\n", stderr);
 		fputs("\tunshare_blocks\n", stderr);
 		fputs("\tfixes_only\n", stderr);
+		fputs("\tcheck_encoding\n", stderr);
 		fputc('\n', stderr);
 		exit(1);
 	}
-- 
2.25.0

