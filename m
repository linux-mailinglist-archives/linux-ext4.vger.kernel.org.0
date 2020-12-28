Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABE8B2E6A2C
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Dec 2020 19:56:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728879AbgL1S4K (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 28 Dec 2020 13:56:10 -0500
Received: from mail.kernel.org ([198.145.29.99]:39510 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728871AbgL1S4K (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 28 Dec 2020 13:56:10 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7FF7822B2A;
        Mon, 28 Dec 2020 18:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1609181729;
        bh=AM4SZDPH0pYqGNnbfRm/8TPtkieKxQQnEo9JrY1d/L0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ay/InPrZKA8998PTQNbH6QB1A6ChsCgP3BrVvi2UdjpLhi1uwG1Yk3Dr1W57szGyR
         jk6FYEWb/RG/VdnXR5ubDKN3dbKhZTtSoD70mUuTzUGqv3d1SKQUg2JtfVryzXXmSD
         mBa7FrvEu8ZQHfDlgzoW8p5Kf3eJv7ACV4cuudo95nLhJXkGaUFEkFkS4QrYOZIfhK
         8yl3w2Ho/lHg9DhBzCmed+LaYHdRhGvKyLzvsSJzR0Qq64NDtwLqZCP1z+N8IqXx2J
         2JWoxKk9gztQRvpRZ6nPrMcW5o6QYQMIoT+bGOjHLZineJdFZuBkXTeEzccv4uM/zO
         tiOiQsbYk1lew==
From:   Eric Biggers <ebiggers@kernel.org>
To:     stable@vger.kernel.org
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org
Subject: [PATCH 5.4 4/4] ubifs: prevent creating duplicate encrypted filenames
Date:   Mon, 28 Dec 2020 10:54:33 -0800
Message-Id: <20201228185433.61129-5-ebiggers@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201228185433.61129-1-ebiggers@kernel.org>
References: <20201228185433.61129-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Eric Biggers <ebiggers@google.com>

commit 76786a0f083473de31678bdb259a3d4167cf756d upstream.

As described in "fscrypt: add fscrypt_is_nokey_name()", it's possible to
create a duplicate filename in an encrypted directory by creating a file
concurrently with adding the directory's encryption key.

Fix this bug on ubifs by rejecting no-key dentries in ubifs_create(),
ubifs_mkdir(), ubifs_mknod(), and ubifs_symlink().

Note that ubifs doesn't actually report the duplicate filenames from
readdir, but rather it seems to replace the original dentry with a new
one (which is still wrong, just a different effect from ext4).

On ubifs, this fixes xfstest generic/595 as well as the new xfstest I
wrote specifically for this bug.

Fixes: f4f61d2cc6d8 ("ubifs: Implement encrypted filenames")
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20201118075609.120337-5-ebiggers@kernel.org
Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/ubifs/dir.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/ubifs/dir.c b/fs/ubifs/dir.c
index 6c0e19f7a21f4..a5e5e9b9d4e31 100644
--- a/fs/ubifs/dir.c
+++ b/fs/ubifs/dir.c
@@ -278,6 +278,15 @@ static struct dentry *ubifs_lookup(struct inode *dir, struct dentry *dentry,
 	return d_splice_alias(inode, dentry);
 }
 
+static int ubifs_prepare_create(struct inode *dir, struct dentry *dentry,
+				struct fscrypt_name *nm)
+{
+	if (fscrypt_is_nokey_name(dentry))
+		return -ENOKEY;
+
+	return fscrypt_setup_filename(dir, &dentry->d_name, 0, nm);
+}
+
 static int ubifs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 			bool excl)
 {
@@ -301,7 +310,7 @@ static int ubifs_create(struct inode *dir, struct dentry *dentry, umode_t mode,
 	if (err)
 		return err;
 
-	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
+	err = ubifs_prepare_create(dir, dentry, &nm);
 	if (err)
 		goto out_budg;
 
@@ -961,7 +970,7 @@ static int ubifs_mkdir(struct inode *dir, struct dentry *dentry, umode_t mode)
 	if (err)
 		return err;
 
-	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
+	err = ubifs_prepare_create(dir, dentry, &nm);
 	if (err)
 		goto out_budg;
 
@@ -1046,7 +1055,7 @@ static int ubifs_mknod(struct inode *dir, struct dentry *dentry,
 		return err;
 	}
 
-	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
+	err = ubifs_prepare_create(dir, dentry, &nm);
 	if (err) {
 		kfree(dev);
 		goto out_budg;
@@ -1130,7 +1139,7 @@ static int ubifs_symlink(struct inode *dir, struct dentry *dentry,
 	if (err)
 		return err;
 
-	err = fscrypt_setup_filename(dir, &dentry->d_name, 0, &nm);
+	err = ubifs_prepare_create(dir, dentry, &nm);
 	if (err)
 		goto out_budg;
 
-- 
2.29.2

