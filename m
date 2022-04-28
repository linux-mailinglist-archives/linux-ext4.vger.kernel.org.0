Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95F67513E61
	for <lists+linux-ext4@lfdr.de>; Fri, 29 Apr 2022 00:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352821AbiD1WOY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 28 Apr 2022 18:14:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352829AbiD1WOW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 28 Apr 2022 18:14:22 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B30C6606FD
        for <linux-ext4@vger.kernel.org>; Thu, 28 Apr 2022 15:11:05 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 2BB801F45D1A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1651183864;
        bh=e2mIC2NlA+jrtGJdGyDt40xQfgyktaRVyuhlRHDssdg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F1h/0crsTfyaJzgahez6OLwjQxjaTKI3kwM3H3V5lHvWiMge1TInY2jn5O8oySU0Q
         Km/SXp2GneySKQbSdaj2Ig18t2s8YNdM45DRvaaE9LrKe7m5MoVaUIJLbaxdyjRlaz
         83etAlhMkS3dB9y45jkLAOYmNNBLaMU50KNAgOMmdC2VrauQ5Tj2pYslBgwfz5ywvw
         FcZBE2t+Tpz77ywJhjh+AVr4N9hdEQH4x5nBzcScodQEfXyzSTFjE7dxNZIniUnPNO
         5bEZWGWlgkzAKkNdWpa/IwDyFhKggot18TeVbdK/U15uRPRNgxLtBL2mkohANr6Brc
         SYCPm8i9/1DSQ==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu, adilger.kernel@dilger.ca, jaegeuk@kernel.org
Cc:     linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        ebiggers@kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH v2 7/7] f2fs: Reuse generic_ci_match for ci comparisons
Date:   Thu, 28 Apr 2022 18:10:27 -0400
Message-Id: <20220428221027.269084-8-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220428221027.269084-1-krisman@collabora.com>
References: <20220428221027.269084-1-krisman@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY,URIBL_BLACK autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Now that ci_match is part of libfs, make f2fs reuse it instead of having
a different implementation.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
---
 fs/f2fs/dir.c | 58 ++++-----------------------------------------------
 1 file changed, 4 insertions(+), 54 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 166f08623362..c39b3abbf99e 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -208,69 +208,19 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
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
 {
 	struct fscrypt_name f;
+	struct unicode_name u;
 
 #if IS_ENABLED(CONFIG_UNICODE)
 	if (fname->cf_name.name) {
 		struct qstr cf = FSTR_TO_QSTR(&fname->cf_name);
-
-		return f2fs_match_ci_name(dir, &cf, de_name, de_name_len);
+		u.folded_name = &cf;
+		u.usr_name = fname->usr_fname;
+		return generic_ci_match(dir, &u, (u8*) de_name, de_name_len);
 	}
 #endif
 	f.usr_fname = fname->usr_fname;
-- 
2.35.1

