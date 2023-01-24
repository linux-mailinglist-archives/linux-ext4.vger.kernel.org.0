Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A454679A59
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Jan 2023 14:46:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234684AbjAXNqO (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 24 Jan 2023 08:46:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbjAXNpm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 24 Jan 2023 08:45:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FB3D47EC5;
        Tue, 24 Jan 2023 05:44:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8C349611FB;
        Tue, 24 Jan 2023 13:43:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3A29C433D2;
        Tue, 24 Jan 2023 13:43:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674567808;
        bh=wWB6h8n/1HQu4xNT4HQyvb4Po8NFXiKMkU1FvMBZWSc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=EBAx5jeVO3o19Hcg/T3IljSiWXOnbcngLLGr7Dg8IdQIpTKJATrs8sPpcVrd41BY8
         MEuDOAXrc7ZVpvQa9XEYjGGlpeldJQ7YMJgeGtpp0UGfJghDaSPS/B062F5AzLy+NO
         8KWQZwv+XhzyOlW2EfsdRwvOEUh3AoXgAdeMPFC+TG588S6KzKIylMBiOqXrb7/dzD
         D1UGhc6U8Yi8RAEUvI7GlKwUF7E7a1oBvWGxwbtrjI3gd6popljqmWG6sg/L3RsYVe
         AvZjkYWNiPSEZYeb7TJbIp4caPWPfVgPXxHLR6DlFwf8JgIXbV/uKOh6K+8w4Em0zy
         tGjKnGHcNrDfw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        kernel test robot <oliver.sang@intel.com>,
        Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Theodore Ts'o <tytso@mit.edu>,
        Jason Donenfeld <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Sasha Levin <sashal@kernel.org>, adilger.kernel@dilger.ca,
        linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 14/14] ext4: deal with legacy signed xattr name hash values
Date:   Tue, 24 Jan 2023 08:42:57 -0500
Message-Id: <20230124134257.637523-14-sashal@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230124134257.637523-1-sashal@kernel.org>
References: <20230124134257.637523-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

From: Linus Torvalds <torvalds@linux-foundation.org>

[ Upstream commit f3bbac32475b27f49be201f896d98d4009de1562 ]

We potentially have old hashes of the xattr names generated on systems
with signed 'char' types.  Now that everybody uses '-funsigned-char',
those hashes will no longer match.

This only happens if you use xattrs names that have the high bit set,
which probably doesn't happen in practice, but the xfstest generic/454
shows it.

Instead of adding a new "signed xattr hash filesystem" bit and having to
deal with all the possible combinations, just calculate the hash both
ways if the first one fails, and always generate new hashes with the
proper unsigned char version.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/oe-lkp/202212291509.704a11c9-oliver.sang@intel.com
Link: https://lore.kernel.org/all/CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com/
Exposed-by: 3bc753c06dd0 ("kbuild: treat char as always unsigned")
Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Andreas Dilger <adilger@dilger.ca>
Cc: Theodore Ts'o <tytso@mit.edu>,
Cc: Jason Donenfeld <Jason@zx2c4.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/xattr.c | 41 +++++++++++++++++++++++++++++++++++++++--
 1 file changed, 39 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index b92da41e9640..6b5c5dfe6e31 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -81,6 +81,8 @@ ext4_xattr_block_cache_find(struct inode *, struct ext4_xattr_header *,
 			    struct mb_cache_entry **);
 static __le32 ext4_xattr_hash_entry(char *name, size_t name_len, __le32 *value,
 				    size_t value_count);
+static __le32 ext4_xattr_hash_entry_signed(char *name, size_t name_len, __le32 *value,
+				    size_t value_count);
 static void ext4_xattr_rehash(struct ext4_xattr_header *);
 
 static const struct xattr_handler * const ext4_xattr_handler_map[] = {
@@ -470,8 +472,21 @@ ext4_xattr_inode_verify_hashes(struct inode *ea_inode,
 		tmp_data = cpu_to_le32(hash);
 		e_hash = ext4_xattr_hash_entry(entry->e_name, entry->e_name_len,
 					       &tmp_data, 1);
-		if (e_hash != entry->e_hash)
-			return -EFSCORRUPTED;
+		/* All good? */
+		if (e_hash == entry->e_hash)
+			return 0;
+
+		/*
+		 * Not good. Maybe the entry hash was calculated
+		 * using the buggy signed char version?
+		 */
+		e_hash = ext4_xattr_hash_entry_signed(entry->e_name, entry->e_name_len,
+							&tmp_data, 1);
+		if (e_hash == entry->e_hash)
+			return 0;
+
+		/* Still no match - bad */
+		return -EFSCORRUPTED;
 	}
 	return 0;
 }
@@ -3089,6 +3104,28 @@ static __le32 ext4_xattr_hash_entry(char *name, size_t name_len, __le32 *value,
 	return cpu_to_le32(hash);
 }
 
+/*
+ * ext4_xattr_hash_entry_signed()
+ *
+ * Compute the hash of an extended attribute incorrectly.
+ */
+static __le32 ext4_xattr_hash_entry_signed(char *name, size_t name_len, __le32 *value, size_t value_count)
+{
+	__u32 hash = 0;
+
+	while (name_len--) {
+		hash = (hash << NAME_HASH_SHIFT) ^
+		       (hash >> (8*sizeof(hash) - NAME_HASH_SHIFT)) ^
+		       (signed char)*name++;
+	}
+	while (value_count--) {
+		hash = (hash << VALUE_HASH_SHIFT) ^
+		       (hash >> (8*sizeof(hash) - VALUE_HASH_SHIFT)) ^
+		       le32_to_cpu(*value++);
+	}
+	return cpu_to_le32(hash);
+}
+
 #undef NAME_HASH_SHIFT
 #undef VALUE_HASH_SHIFT
 
-- 
2.39.0

