Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AADAA523D7F
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 21:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343611AbiEKTcH (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 15:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346890AbiEKTcD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 15:32:03 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E45656FB3
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 12:32:02 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 0E8FE1F42934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652297521;
        bh=C3L+p6EH4hujqYdx/16YEZ4+aJcVzY1o6iSj/4Lilj4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gUsF6LXVIf8FKQoVylJPyqvOgQyO9tjvrlWPNxm1ZUtFGbY8VnJu5BMPK+pirBpOu
         LvwgXyUCw4KhxmW71+jxOim1kdy9pNq65+lIMXrzytJTwdef1qeoDEcQ7B1UCE9Qyv
         A2kWZ6fWhj3ZNxnAB3y29dJsiFOdDlRE4M7SZHp/0k1+KwatTNj4YQuUCRvVZ5r0uo
         JWK7st8E4Xswr94U/di4BOxEAahPZOJr00UAfR9DXGpnaqagY1wkh2059QXcorvyKE
         TOyX546tEJrxIcN1jvEXptkU/9hIRH7jIf5IhVLmxUjL0+UXgbHDe37LWLUrCUVKx7
         5YNcj2AzKFjig==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 02/10] ext4: Simplify the handling of cached insensitive names
Date:   Wed, 11 May 2022 15:31:38 -0400
Message-Id: <20220511193146.27526-3-krisman@collabora.com>
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

Keeping it as qstr avoids the unnecessary conversion in ext4_match

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

--
Changes since v1:
  - Simplify hunk (eric)
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/namei.c | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index a743b1e3b89e..93a28fcb2e22 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -2490,7 +2490,7 @@ struct ext4_filename {
 	struct fscrypt_str crypto_buf;
 #endif
 #if IS_ENABLED(CONFIG_UNICODE)
-	struct fscrypt_str cf_name;
+	struct qstr cf_name;
 #endif
 };
 
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 59eb3ecfdea7..84fdb23f09b8 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1382,7 +1382,8 @@ static int ext4_match_ci(const struct inode *parent, const struct qstr *name,
 int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 				  struct ext4_filename *name)
 {
-	struct fscrypt_str *cf_name = &name->cf_name;
+	struct qstr *cf_name = &name->cf_name;
+	unsigned char *buf;
 	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
@@ -1392,18 +1393,18 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 		return 0;
 	}
 
-	cf_name->name = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
-	if (!cf_name->name)
+	buf = kmalloc(EXT4_NAME_LEN, GFP_NOFS);
+	if (!buf)
 		return -ENOMEM;
 
-	len = utf8_casefold(dir->i_sb->s_encoding,
-			    iname, cf_name->name,
-			    EXT4_NAME_LEN);
+	len = utf8_casefold(dir->i_sb->s_encoding, iname, buf, EXT4_NAME_LEN);
 	if (len <= 0) {
-		kfree(cf_name->name);
-		cf_name->name = NULL;
+		kfree(buf);
+		buf = NULL;
 	}
+	cf_name->name = buf;
 	cf_name->len = (unsigned) len;
+
 	if (!IS_ENCRYPTED(dir))
 		return 0;
 
@@ -1443,8 +1444,6 @@ static bool ext4_match(struct inode *parent,
 		int ret;
 
 		if (fname->cf_name.name) {
-			struct qstr cf = {.name = fname->cf_name.name,
-					  .len = fname->cf_name.len};
 			if (IS_ENCRYPTED(parent)) {
 				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
 					fname->hinfo.minor_hash !=
@@ -1453,7 +1452,8 @@ static bool ext4_match(struct inode *parent,
 					return false;
 				}
 			}
-			ret = ext4_match_ci(parent, &cf, de->name,
+
+			ret = ext4_match_ci(parent, &fname->cf_name, de->name,
 					    de->name_len, true);
 		} else {
 			ret = ext4_match_ci(parent, fname->usr_fname,
-- 
2.36.1

