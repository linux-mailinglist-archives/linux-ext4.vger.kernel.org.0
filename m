Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E221C52C95A
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 03:41:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232537AbiESBlk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 21:41:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232529AbiESBl2 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 21:41:28 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B548950B36
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 18:41:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 54CEC1F4544B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652924485;
        bh=2MSgumgq3Tv3MUMLO2SUKN4bTk+0tq6fHlRTGKiGr/I=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VdGHmg+gyQOzaQUK2J16azvHoaYjPmLIqt3ExVQbWjSAuR+Jn4Gan3yRqazVEJAJ+
         RboWsZNzrrwtgphkzewjiisfCCnePRzamZAnSkka+8D7cgKzmsRoVAPYHEdl2DvFpB
         dnj/hzUy1dyGykkyEzy/yAkGN6USEWN0dg9CzbtFN2bIhiKlCLKf4POf27CIE8MCud
         cyUvoKtbzfAy5Eg80/XpWkvFlkMFl0Pl5J2bf0/6toXMlPTHZWG4ArX7Sa8wN0bp5P
         7muHH+ZVKYjso/uGg+S5Jw46XzuwP93QoiEUVqpz0xyM/sWRATC8p4xh69sPvrOPmK
         Tr/KYXtoyDRdQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v6 7/8] ext4: Move CONFIG_UNICODE defguards into the code flow
Date:   Wed, 18 May 2022 21:40:43 -0400
Message-Id: <20220519014044.508099-8-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519014044.508099-1-krisman@collabora.com>
References: <20220519014044.508099-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Instead of a bunch of ifdefs, make the unicode built checks part of the
code flow where possible, as requested by Torvalds.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v5:
  - Drop err variable (eric)
Changes since v4:
  - Create stub for !CONFIG_UNICODE case (eric)
---
 fs/ext4/ext4.h  | 47 +++++++++++++++++++++++------------------------
 fs/ext4/namei.c | 15 ++++++---------
 fs/ext4/super.c |  4 +---
 3 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 93a28fcb2e22..4bc3649e3385 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2727,8 +2727,24 @@ ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
 #if IS_ENABLED(CONFIG_UNICODE)
 extern int ext4_fname_setup_ci_filename(struct inode *dir,
-					 const struct qstr *iname,
-					 struct ext4_filename *fname);
+					const struct qstr *iname,
+					struct ext4_filename *fname);
+
+static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
+{
+	kfree(fname->cf_name.name);
+	fname->cf_name.name = NULL;
+}
+#else
+static inline int ext4_fname_setup_ci_filename(struct inode *dir,
+					       const struct qstr *iname,
+					       struct ext4_filename *fname)
+{
+	return 0;
+}
+static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
+{
+}
 #endif
 
 #ifdef CONFIG_FS_ENCRYPTION
@@ -2758,10 +2774,7 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 
 	ext4_fname_from_fscrypt_name(fname, &name);
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	err = ext4_fname_setup_ci_filename(dir, iname, fname);
-#endif
-	return err;
+	return ext4_fname_setup_ci_filename(dir, iname, fname);
 }
 
 static inline int ext4_fname_prepare_lookup(struct inode *dir,
@@ -2777,10 +2790,7 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 
 	ext4_fname_from_fscrypt_name(fname, &name);
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
-#endif
-	return err;
+	return ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
 }
 
 static inline void ext4_fname_free_filename(struct ext4_filename *fname)
@@ -2794,10 +2804,7 @@ static inline void ext4_fname_free_filename(struct ext4_filename *fname)
 	fname->usr_fname = NULL;
 	fname->disk_name.name = NULL;
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	kfree(fname->cf_name.name);
-	fname->cf_name.name = NULL;
-#endif
+	ext4_fname_free_ci_filename(fname);
 }
 #else /* !CONFIG_FS_ENCRYPTION */
 static inline int ext4_fname_setup_filename(struct inode *dir,
@@ -2805,16 +2812,11 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 					    int lookup,
 					    struct ext4_filename *fname)
 {
-	int err = 0;
 	fname->usr_fname = iname;
 	fname->disk_name.name = (unsigned char *) iname->name;
 	fname->disk_name.len = iname->len;
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	err = ext4_fname_setup_ci_filename(dir, iname, fname);
-#endif
-
-	return err;
+	return ext4_fname_setup_ci_filename(dir, iname, fname);
 }
 
 static inline int ext4_fname_prepare_lookup(struct inode *dir,
@@ -2826,10 +2828,7 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 
 static inline void ext4_fname_free_filename(struct ext4_filename *fname)
 {
-#if IS_ENABLED(CONFIG_UNICODE)
-	kfree(fname->cf_name.name);
-	fname->cf_name.name = NULL;
-#endif
+	ext4_fname_free_ci_filename(fname);
 }
 #endif /* !CONFIG_FS_ENCRYPTION */
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 8fbb35187f72..f142c8fef750 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1755,8 +1755,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		}
 	}
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
+	if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
 		 * well.  For now, prevent the negative dentry
@@ -1764,7 +1763,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		 */
 		return NULL;
 	}
-#endif
+
 	return d_splice_alias(inode, dentry);
 }
 
@@ -3081,16 +3080,14 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	ext4_fc_track_unlink(handle, dentry);
 	retval = ext4_mark_inode_dirty(handle, dir);
 
-#if IS_ENABLED(CONFIG_UNICODE)
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at ext4_lookup(), when it is better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
-#endif
 
 end_rmdir:
 	brelse(bh);
@@ -3186,16 +3183,16 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
 	retval = __ext4_unlink(handle, dir, &dentry->d_name, d_inode(dentry));
 	if (!retval)
 		ext4_fc_track_unlink(handle, dentry);
-#if IS_ENABLED(CONFIG_UNICODE)
+
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at ext4_lookup(), when it is  better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
-#endif
+
 	if (handle)
 		ext4_journal_stop(handle);
 
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 1847b46af808..fa0004459dd6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3645,14 +3645,12 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 		return 0;
 	}
 
-#if !IS_ENABLED(CONFIG_UNICODE)
-	if (ext4_has_feature_casefold(sb)) {
+	if (!IS_ENABLED(CONFIG_UNICODE) && ext4_has_feature_casefold(sb)) {
 		ext4_msg(sb, KERN_ERR,
 			 "Filesystem with casefold feature cannot be "
 			 "mounted without CONFIG_UNICODE");
 		return 0;
 	}
-#endif
 
 	if (readonly)
 		return 1;
-- 
2.36.1

