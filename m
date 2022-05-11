Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34DDE523D92
	for <lists+linux-ext4@lfdr.de>; Wed, 11 May 2022 21:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347022AbiEKTcf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 11 May 2022 15:32:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346970AbiEKTcZ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 11 May 2022 15:32:25 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0DA106341
        for <linux-ext4@vger.kernel.org>; Wed, 11 May 2022 12:32:23 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 638721F42934
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1652297542;
        bh=Ibj+mD0sWdma1wSkTSj2x/k9RAgkfpzVSMfs+oUu1GM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H4gutnfyqtpsJStQwXepP2RtaWqmr9w+DPSPSLpTP06AcUx6Npz2XbxhggErnNgyb
         gDsSEXIFbtdAEgO/J1yFhfJn8h+R+FlsMFOTYneedPdMAVPlHGfPIcPHKXz3nE66FC
         OACD2BSK+yJ3Dq6cMSvu2Bce/0xKenLObEY58XQSd9jvjD+/KpC/b+ub2IPvtw+q0Q
         85jczAv/qBWKYIzg4SUivy8p6a3arLmgVGpqKHSLNMFFufg07f4dWrZIQX3NThT8HI
         BHHe8/mYNgdbRAXgQ7hgEH34EyZLk1s9rRNKunN3l3bN2gD3CaH823+TH6rY9b8GUD
         XK61vhB8V+/Dg==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v4 08/10] f2fs: Reuse generic_ci_match for ci comparisons
Date:   Wed, 11 May 2022 15:31:44 -0400
Message-Id: <20220511193146.27526-9-krisman@collabora.com>
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

Now that ci_match is part of libfs, make f2fs reuse it instead of having
a different implementation.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>

---
Changes since v3:
  - fix unused variable iff !CONFIG_UNICODE (lkp)
---
 fs/f2fs/dir.c | 63 +++++++--------------------------------------------
 1 file changed, 8 insertions(+), 55 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index c2a02003c5b9..e284d6f5d0bf 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -222,58 +222,6 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 	return f2fs_find_target_dentry(&d, fname, max_slots);
 }
 
-#if IS_ENABLED(CONFIG_UNICODE)
-/*
- * Test whether a case-insensitive directory entry matches the filename
- * being searched for.
- *
- * Returns 1 for a match, 0 for no match, and -errno on an error.
- */
-static int f2fs_match_ci_name(const struct inode *dir, const struct qstr *name,
-			       const u8 *de_name, u32 de_name_len)
-{
-	const struct super_block *sb = dir->i_sb;
-	const struct unicode_map *um = sb->s_encoding;
-	struct fscrypt_str decrypted_name = FSTR_INIT(NULL, de_name_len);
-	struct qstr entry = QSTR_INIT(de_name, de_name_len);
-	int res;
-
-	if (IS_ENCRYPTED(dir)) {
-		const struct fscrypt_str encrypted_name =
-			FSTR_INIT((u8 *)de_name, de_name_len);
-
-		if (WARN_ON_ONCE(!fscrypt_has_encryption_key(dir)))
-			return -EINVAL;
-
-		decrypted_name.name = kmalloc(de_name_len, GFP_KERNEL);
-		if (!decrypted_name.name)
-			return -ENOMEM;
-		res = fscrypt_fname_disk_to_usr(dir, 0, 0, &encrypted_name,
-						&decrypted_name);
-		if (res < 0)
-			goto out;
-		entry.name = decrypted_name.name;
-		entry.len = decrypted_name.len;
-	}
-
-	res = utf8_strncasecmp_folded(um, name, &entry);
-	/*
-	 * In strict mode, ignore invalid names.  In non-strict mode,
-	 * fall back to treating them as opaque byte sequences.
-	 */
-	if (res < 0 && !sb_has_strict_encoding(sb)) {
-		res = name->len == entry.len &&
-				memcmp(name->name, entry.name, name->len) == 0;
-	} else {
-		/* utf8_strncasecmp_folded returns 0 on match */
-		res = (res == 0);
-	}
-out:
-	kfree(decrypted_name.name);
-	return res;
-}
-#endif /* CONFIG_UNICODE */
-
 static inline int f2fs_match_name(const struct inode *dir,
 				   const struct f2fs_filename *fname,
 				   const u8 *de_name, u32 de_name_len)
@@ -281,9 +229,14 @@ static inline int f2fs_match_name(const struct inode *dir,
 	struct fscrypt_name f;
 
 #if IS_ENABLED(CONFIG_UNICODE)
-	if (fname->cf_name.name)
-		return f2fs_match_ci_name(dir, &fname->cf_name,
-					  de_name, de_name_len);
+	if (fname->cf_name.name) {
+		struct unicode_name u = {
+			.folded_name = &fname->cf_name,
+			.usr_name = fname->usr_fname,
+		};
+
+		return generic_ci_match(dir, &u, (u8 *) de_name, de_name_len);
+	}
 #endif
 	f.usr_fname = fname->usr_fname;
 	f.disk_name = fname->disk_name;
-- 
2.36.1

