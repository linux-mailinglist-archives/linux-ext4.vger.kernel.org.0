Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E370C52DE98
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 22:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244790AbiESUq5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 May 2022 16:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244788AbiESUq4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 May 2022 16:46:56 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B54F4326FB
        for <linux-ext4@vger.kernel.org>; Thu, 19 May 2022 13:46:54 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 56A3D1F45F86
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652993213;
        bh=VFIxEIWt6o/B0gqn09S6ezHtaQkwGSBs7ym4N8kFX2Y=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V507qujK3jk9ERuhRYV1nIdLZIfj+cJlvBGPc/1k7UOQE2X+35SmpNy7bpquSvuuj
         UV3jPLhY2sPy9tR0Yht0h4Aqm4xugXM76iCvAKwByXPAXnj9X0Y8xihJrW5r54VOmA
         DFsemUlADOSLSbD0V6Yr3txRzRf6hWS6ia1lqY3P0xItbmijODoq4hpr2ibJwPViTY
         JD+WiErtsq+tyFk375MiRhVJLf4tDc1TOeJfM9v0mLDyGv/bjGIJtsbrT2k0die8LR
         GZM0zkk+njfcBNFk4jw11uqJbv3wR/6Y9uucfHaz5+KZCT03g2OMUKQIs7DiXYMtnr
         wr+TkLaDPiX8A==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org,
        ebiggers@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com, Eric Biggers <ebiggers@google.com>
Subject: [PATCH v7 1/8] ext4: Simplify the handling of cached insensitive names
Date:   Thu, 19 May 2022 16:46:38 -0400
Message-Id: <20220519204645.16528-2-krisman@collabora.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220519204645.16528-1-krisman@collabora.com>
References: <20220519204645.16528-1-krisman@collabora.com>
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

Keeping it as qstr avoids the unnecessary conversion in ext4_match

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v1:
  - Simplify hunk (eric)
---
 fs/ext4/ext4.h  |  2 +-
 fs/ext4/namei.c | 23 +++++++++++------------
 2 files changed, 12 insertions(+), 13 deletions(-)

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
index 767b4bfe39c3..206fcf8fdc16 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1373,7 +1373,8 @@ static int ext4_ci_compare(const struct inode *parent, const struct qstr *name,
 int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
 				  struct ext4_filename *name)
 {
-	struct fscrypt_str *cf_name = &name->cf_name;
+	struct qstr *cf_name = &name->cf_name;
+	unsigned char *buf;
 	struct dx_hash_info *hinfo = &name->hinfo;
 	int len;
 
@@ -1383,18 +1384,18 @@ int ext4_fname_setup_ci_filename(struct inode *dir, const struct qstr *iname,
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
 
@@ -1432,8 +1433,6 @@ static bool ext4_match(struct inode *parent,
 	if (parent->i_sb->s_encoding && IS_CASEFOLDED(parent) &&
 	    (!IS_ENCRYPTED(parent) || fscrypt_has_encryption_key(parent))) {
 		if (fname->cf_name.name) {
-			struct qstr cf = {.name = fname->cf_name.name,
-					  .len = fname->cf_name.len};
 			if (IS_ENCRYPTED(parent)) {
 				if (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
 					fname->hinfo.minor_hash !=
@@ -1442,8 +1441,8 @@ static bool ext4_match(struct inode *parent,
 					return false;
 				}
 			}
-			return !ext4_ci_compare(parent, &cf, de->name,
-							de->name_len, true);
+			return !ext4_ci_compare(parent, &fname->cf_name,
+						de->name, de->name_len, true);
 		}
 		return !ext4_ci_compare(parent, fname->usr_fname, de->name,
 						de->name_len, false);
-- 
2.36.1

