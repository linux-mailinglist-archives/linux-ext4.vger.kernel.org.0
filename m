Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7AC4040BB
	for <lists+linux-ext4@lfdr.de>; Wed,  8 Sep 2021 23:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbhIHVwn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 8 Sep 2021 17:52:43 -0400
Received: from mail.kernel.org ([198.145.29.99]:38310 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235135AbhIHVwi (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 8 Sep 2021 17:52:38 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AE0216115B;
        Wed,  8 Sep 2021 21:51:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631137889;
        bh=Q7/Auj+gxb7Tq2h7AKECQp7f+V7wXd8uIeRwsSwC2uI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=g6B3xPzWzmSOWbVujz05WcWiMqbJmrvjf663bftxNBe3SpFvKrqnf9HjmQt02WCYM
         SWydEF5fnJe2PDJt02TSsWwnOJNVN0DQIA8QyX31MW4y4bh6/xnq2+ec4fqkHIuubd
         SvzFgbwlnsZrqqazTbtxtlvrW9iAUFJ0MBEqmS/KMjUsF4ZUwPLf58CtQO2n3YuINH
         mUhMtIpAHEDSWvdU8iX5EZZMCqDZHUUQ0lA4wUD7b1eC2QFKcNXTByJg0iLHO3eXl9
         YqTesOY0LwkjQtsa9SStbmzHvBr/PfEGeGubbTW0QRwltraAP+uT2feQHOEReo6aol
         SXsE9sw2hR4Kw==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org
Subject: [PATCH 4/4] ubifs: report correct st_size for encrypted symlinks
Date:   Wed,  8 Sep 2021 14:50:33 -0700
Message-Id: <20210908215033.1122580-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.33.0.153.gba50c8fa24-goog
In-Reply-To: <20210908215033.1122580-1-ebiggers@kernel.org>
References: <20210908215033.1122580-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 064c734986011390b4d111f1a99372b7f26c3850 upstream.

The stat() family of syscalls report the wrong size for encrypted
symlinks, which has caused breakage in several userspace programs.

Fix this by calling fscrypt_symlink_getattr() after ubifs_getattr() for
encrypted symlinks.  This function computes the correct size by reading
and decrypting the symlink target (if it's not already cached).

For more details, see the commit which added fscrypt_symlink_getattr().

Fixes: ca7f85be8d6c ("ubifs: Add support for encrypted symlinks")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20210702065350.209646-5-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ubifs/file.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/ubifs/file.c b/fs/ubifs/file.c
index d7d2fdda4bbd..3dbb5ac630e4 100644
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@ -1642,6 +1642,16 @@ static const char *ubifs_get_link(struct dentry *dentry,
 	return fscrypt_get_symlink(inode, ui->data, ui->data_len, done);
 }
 
+static int ubifs_symlink_getattr(const struct path *path, struct kstat *stat,
+				 u32 request_mask, unsigned int query_flags)
+{
+	ubifs_getattr(path, stat, request_mask, query_flags);
+
+	if (IS_ENCRYPTED(d_inode(path->dentry)))
+		return fscrypt_symlink_getattr(path, stat);
+	return 0;
+}
+
 const struct address_space_operations ubifs_file_address_operations = {
 	.readpage       = ubifs_readpage,
 	.writepage      = ubifs_writepage,
@@ -1669,7 +1679,7 @@ const struct inode_operations ubifs_file_inode_operations = {
 const struct inode_operations ubifs_symlink_inode_operations = {
 	.get_link    = ubifs_get_link,
 	.setattr     = ubifs_setattr,
-	.getattr     = ubifs_getattr,
+	.getattr     = ubifs_symlink_getattr,
 #ifdef CONFIG_UBIFS_FS_XATTR
 	.listxattr   = ubifs_listxattr,
 #endif
-- 
2.33.0.153.gba50c8fa24-goog

