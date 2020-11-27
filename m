Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 018082C6A5D
	for <lists+linux-ext4@lfdr.de>; Fri, 27 Nov 2020 18:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732139AbgK0RBl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 27 Nov 2020 12:01:41 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:57124 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731725AbgK0RBk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 27 Nov 2020 12:01:40 -0500
Received: from xps.home (unknown [IPv6:2a01:e35:2fb5:1510:5a64:74b8:f3be:d972])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: aferraris)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 3D8F31F4448A;
        Fri, 27 Nov 2020 17:01:38 +0000 (GMT)
From:   Arnaud Ferraris <arnaud.ferraris@collabora.com>
To:     linux-ext4@vger.kernel.org
Cc:     Daniel Rosenberg <drosen@google.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>
Subject: [PATCH v2 10/12] e2fsck: Add option to force encoded filename verification
Date:   Fri, 27 Nov 2020 18:01:14 +0100
Message-Id: <20201127170116.197901-11-arnaud.ferraris@collabora.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
References: <20201127170116.197901-1-arnaud.ferraris@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Gabriel Krisman Bertazi <krisman@collabora.com>

This is interesting for !strict filesystems as part of the encoding
update procedure. Once the filesystem is known to not have badly encoded
filenames, the update is trivial, thanks to the stability of assigned
code points in the unicode specification.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
---
 e2fsck/e2fsck.h | 1 +
 e2fsck/pass2.c  | 5 +++--
 e2fsck/unix.c   | 4 ++++
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/e2fsck/e2fsck.h b/e2fsck/e2fsck.h
index dcaab0a1..f324e92c 100644
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
index b6514de8..f93e2b53 100644
--- a/e2fsck/pass2.c
+++ b/e2fsck/pass2.c
@@ -1049,9 +1049,10 @@ static int check_dir_block(ext2_filsys fs,
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
index 1cb51672..0a9012e5 100644
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
2.28.0

