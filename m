Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4FADA60CA
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Sep 2019 07:43:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726062AbfICFna (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Sep 2019 01:43:30 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:46532 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725878AbfICFna (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Sep 2019 01:43:30 -0400
Received: from callcc.thunk.org ([66.31.38.53])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x835hQs5008813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 3 Sep 2019 01:43:27 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 284B442049E; Tue,  3 Sep 2019 01:43:26 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: fix kernel oops caused by spurious casefold flag
Date:   Tue,  3 Sep 2019 01:43:23 -0400
Message-Id: <20190903054324.20072-1-tytso@mit.edu>
X-Mailer: git-send-email 2.23.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

If an directory has the a casefold flag set without the casefold
feature set, s_encoding will not be initialized, and this will cause
the kernel to dereference a NULL pointer.  In addition to adding
checks to avoid these kernel oops, attempts to load inodes with the
casefold flag when the casefold feature is not enable will cause the
file system to be declared corrupted.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/dir.c   | 7 ++++---
 fs/ext4/hash.c  | 2 +-
 fs/ext4/inode.c | 3 +++
 fs/ext4/namei.c | 4 ++--
 4 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 86054f31fe4d..9fdd2b269d61 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -668,14 +668,15 @@ static int ext4_d_compare(const struct dentry *dentry, unsigned int len,
 			  const char *str, const struct qstr *name)
 {
 	struct qstr qstr = {.name = str, .len = len };
+	struct inode *inode = dentry->d_parent->d_inode;
 
-	if (!IS_CASEFOLDED(dentry->d_parent->d_inode)) {
+	if (!IS_CASEFOLDED(inode) || !EXT4_SB(inode->i_sb)->s_encoding) {
 		if (len != name->len)
 			return -1;
 		return memcmp(str, name->name, len);
 	}
 
-	return ext4_ci_compare(dentry->d_parent->d_inode, name, &qstr, false);
+	return ext4_ci_compare(inode, name, &qstr, false);
 }
 
 static int ext4_d_hash(const struct dentry *dentry, struct qstr *str)
@@ -685,7 +686,7 @@ static int ext4_d_hash(const struct dentry *dentry, struct qstr *str)
 	unsigned char *norm;
 	int len, ret = 0;
 
-	if (!IS_CASEFOLDED(dentry->d_inode))
+	if (!IS_CASEFOLDED(dentry->d_inode) || !um)
 		return 0;
 
 	norm = kmalloc(PATH_MAX, GFP_ATOMIC);
diff --git a/fs/ext4/hash.c b/fs/ext4/hash.c
index d358bfcb6b3f..3e133793a5a3 100644
--- a/fs/ext4/hash.c
+++ b/fs/ext4/hash.c
@@ -280,7 +280,7 @@ int ext4fs_dirhash(const struct inode *dir, const char *name, int len,
 	unsigned char *buff;
 	struct qstr qstr = {.name = name, .len = len };
 
-	if (len && IS_CASEFOLDED(dir)) {
+	if (len && IS_CASEFOLDED(dir) && um) {
 		buff = kzalloc(sizeof(char) * PATH_MAX, GFP_KERNEL);
 		if (!buff)
 			return -ENOMEM;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index e567f0229d4e..4e271b509af1 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5067,6 +5067,9 @@ struct inode *__ext4_iget(struct super_block *sb, unsigned long ino,
 				 "iget: bogus i_mode (%o)", inode->i_mode);
 		goto bad_inode;
 	}
+	if (IS_CASEFOLDED(inode) && !ext4_has_feature_casefold(inode->i_sb))
+		ext4_error_inode(inode, function, line, 0,
+				 "casefold flag without casefold feature");
 	brelse(iloc.bh);
 
 	unlock_new_inode(inode);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 129029534075..a427d2031a8d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1312,7 +1312,7 @@ void ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 {
 	int len;
 
-	if (!IS_CASEFOLDED(dir)) {
+	if (!IS_CASEFOLDED(dir) || !EXT4_SB(dir->i_sb)->s_encoding) {
 		cf_name->name = NULL;
 		return;
 	}
@@ -2183,7 +2183,7 @@ static int ext4_add_entry(handle_t *handle, struct dentry *dentry,
 
 #ifdef CONFIG_UNICODE
 	if (ext4_has_strict_mode(sbi) && IS_CASEFOLDED(dir) &&
-	    utf8_validate(sbi->s_encoding, &dentry->d_name))
+	    sbi->s_encoding && utf8_validate(sbi->s_encoding, &dentry->d_name))
 		return -EINVAL;
 #endif
 
-- 
2.23.0

