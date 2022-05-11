Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4953F523D93
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 21:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346968AbiEKTci (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 15:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346984AbiEKTce (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 15:32:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFF5118010
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 12:32:26 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 500411F42971
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652297545;
        bh=I+NTXd5q40UlKaGrc5vhldVVShFaNrxghoaW9oyhz2o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=W3vuzqnciBUXQAAjjldyha/9KoplRdfGtrygVkV+9yF+2HgZ1RQVPwcjT5LVfWVlX
         l09WQx0hbmm/qQvOx+/EnZoPJsJqPP3v5wUQuNIcNFtg/RrKflcVblF2GxKsSqS9uL
         G1vmxv3uFcW4PUPBiQFeH1NIyYbm/3KW2AqxzAynd54teE2dsVStUK9F8RfLIEAH0D
         U3afw/i30GH8dRSlPCtoci4AgXfQf7D4zvghbO33hIqIiKvCNELuS7JSf4i5XRO3/M
         ZTW2vtMh+Z4ptWAhevYRGGDnNVwfpBOyaPuKG+G+IrbCjms8ZPhn8AIiwidsXKlAVL
         7/yUOcNBi+0Ew==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 09/10] ext4: Move CONFIG_UNICODE defguards into the code flow
Date:   Wed, 11 May 2022 15:31:45 -0400
Message-Id: <20220511193146.27526-10-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220511193146.27526-1-krisman@collabora.com>
References: <20220511193146.27526-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
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
 fs/ext4/ext4.h  | 39 +++++++++++++++++++--------------------
 fs/ext4/namei.c | 15 ++++++---------
 fs/ext4/super.c |  4 +---
 3 files changed, 26 insertions(+), 32 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 93a28fcb2e22..e3c55a8e23bd 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2725,11 +2725,17 @@ extern unsigned ext4_free_clusters_after_init(struct super_block *sb,
 					      struct ext4_group_desc *gdp);
 ext4_fsblk_t ext4_inode_to_goal_block(struct inode *);
 
-#if IS_ENABLED(CONFIG_UNICODE)
 extern int ext4_fname_setup_ci_filename(struct inode *dir,
-					 const struct qstr *iname,
-					 struct ext4_filename *fname);
+					const struct qstr *iname,
+					struct ext4_filename *fname);
+
+static inline void ext4_fname_free_ci_filename(struct ext4_filename *fname)
+{
+#if IS_ENABLED(CONFIG_UNICODE)
+	kfree(fname->cf_name.name);
+	fname->cf_name.name = NULL;
 #endif
+}
 
 #ifdef CONFIG_FS_ENCRYPTION
 static inline void ext4_fname_from_fscrypt_name(struct ext4_filename *dst,
@@ -2758,9 +2764,9 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 
 	ext4_fname_from_fscrypt_name(fname, &name);
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	err = ext4_fname_setup_ci_filename(dir, iname, fname);
-#endif
+	if (IS_ENABLED(CONFIG_UNICODE))
+		err = ext4_fname_setup_ci_filename(dir, iname, fname);
+
 	return err;
 }
 
@@ -2777,9 +2783,9 @@ static inline int ext4_fname_prepare_lookup(struct inode *dir,
 
 	ext4_fname_from_fscrypt_name(fname, &name);
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
-#endif
+	if (IS_ENABLED(CONFIG_UNICODE))
+		err = ext4_fname_setup_ci_filename(dir, &dentry->d_name, fname);
+
 	return err;
 }
 
@@ -2794,10 +2800,7 @@ static inline void ext4_fname_free_filename(struct ext4_filename *fname)
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
@@ -2810,9 +2813,8 @@ static inline int ext4_fname_setup_filename(struct inode *dir,
 	fname->disk_name.name = (unsigned char *) iname->name;
 	fname->disk_name.len = iname->len;
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	err = ext4_fname_setup_ci_filename(dir, iname, fname);
-#endif
+	if (IS_ENABLED(CONFIG_UNICODE))
+		err = ext4_fname_setup_ci_filename(dir, iname, fname);
 
 	return err;
 }
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
index 16fd0df5f8a8..0892f9ee15cf 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1757,8 +1757,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		}
 	}
 
-#if IS_ENABLED(CONFIG_UNICODE)
-	if (!inode && IS_CASEFOLDED(dir)) {
+	if (IS_ENABLED(CONFIG_UNICODE) && !inode && IS_CASEFOLDED(dir)) {
 		/* Eventually we want to call d_add_ci(dentry, NULL)
 		 * for negative dentries in the encoding case as
 		 * well.  For now, prevent the negative dentry
@@ -1766,7 +1765,7 @@ static struct dentry *ext4_lookup(struct inode *dir, struct dentry *dentry, unsi
 		 */
 		return NULL;
 	}
-#endif
+
 	return d_splice_alias(inode, dentry);
 }
 
@@ -3083,16 +3082,14 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
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
@@ -3188,16 +3185,16 @@ static int ext4_unlink(struct inode *dir, struct dentry *dentry)
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

