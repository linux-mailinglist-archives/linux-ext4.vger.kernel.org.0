Return-Path: <linux-ext4+bounces-6419-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B5FEA32C2C
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 17:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA8EA18818A3
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Feb 2025 16:45:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB6131DEFDD;
	Wed, 12 Feb 2025 16:45:04 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A02524F5A4
	for <linux-ext4@vger.kernel.org>; Wed, 12 Feb 2025 16:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739378704; cv=none; b=rx2ekZcsPca238ahsdWaRhHyYpsWdBPNdoPU+bsBnMiSovi23fajot07N3ZhS1t6/Fy08N9YpdO9zS89nqjuzP3dLmb7uw9iAIHxyXrCjor7WCo3XoY/7llhoHkinOTOb0tCCl/XfFvhj409UmlrYYc8iF6dsxgWXF5vRIYiNtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739378704; c=relaxed/simple;
	bh=mGXwpgJ/SNU2PeSr5y+YNrH8JvAcQ7w050We0s8eiUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=oS3tNp6pkaNU/3zVybm6zHk3xQL8ly6QIRPyNSW2vzQ5vz4fwnAHL2smM9MeAO1ZjJi+QkC2qCLmtYDJmqj2SO8RxQGPZj5OOL0h8V1H9HZWXedEGUa04XAUFhB12D2P9RKZZqkoNUFGg2JuTRvKQuF2Icwt0PajmYEgY1LaEXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from cwcc.thunk.org (pool-173-48-82-224.bstnma.fios.verizon.net [173.48.82.224])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 51CGisg7027585
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Feb 2025 11:44:55 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
	id 8E98F15C018E; Wed, 12 Feb 2025 11:44:54 -0500 (EST)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: drosen@google.com, krisman@suse.de, "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH] ext4: introduce linear search for dentries
Date: Wed, 12 Feb 2025 11:44:48 -0500
Message-ID: <20250212164448.111211-1-tytso@mit.edu>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch addresses an issue where some files in case-insensitive
directories become inaccessible due to changes in how the kernel
function, utf8_casefold(), generates case-folded strings from the
commit 5c26d2f1d3f5 ("unicode: Don't special case ignorable code
points").

There are good reasons why this change should be made; it's actually
quite stupid that Unicode seems to think that the characters ❤ and ❤️
should be casefolded.  Unfortimately because of the backwards
compatibility issue, this commit was reverted in 231825b2e1ff.

This problem is addressed by instituting a brute-force linear fallback
if a lookup fails on case-folded directory, which does result in a
performance hit when looking up files affected by the changing how
thekernel treats ignorable Uniode characters, or when attempting to
look up non-existent file names.  So this fallback can be disabled by
setting an encoding flag if in the future, the system administrator or
the manufacturer of a mobile handset or tablet can be sure that there
was no opportunity for a kernel to insert file names with incompatible
encodings.

Fixes: 5c26d2f1d3f5 ("unicode: Don't special case ignorable code points")
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/namei.c    | 14 ++++++++++----
 include/linux/fs.h |  6 +++++-
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 536d56d15072..820e7ab7f3a3 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1462,7 +1462,8 @@ static bool ext4_match(struct inode *parent,
 		 * sure cf_name was properly initialized before
 		 * considering the calculated hash.
 		 */
-		if (IS_ENCRYPTED(parent) && fname->cf_name.name &&
+		if (sb_no_casefold_compat_fallback(parent->i_sb) &&
+		    IS_ENCRYPTED(parent) && fname->cf_name.name &&
 		    (fname->hinfo.hash != EXT4_DIRENT_HASH(de) ||
 		     fname->hinfo.minor_hash != EXT4_DIRENT_MINOR_HASH(de)))
 			return false;
@@ -1595,10 +1596,15 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 		 * return.  Otherwise, fall back to doing a search the
 		 * old fashioned way.
 		 */
-		if (!IS_ERR(ret) || PTR_ERR(ret) != ERR_BAD_DX_DIR)
+		if (IS_ERR(ret) && PTR_ERR(ret) == ERR_BAD_DX_DIR)
+			dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
+				       "falling back\n"));
+		else if (!sb_no_casefold_compat_fallback(dir->i_sb) &&
+			 *res_dir == NULL && IS_CASEFOLDED(dir))
+			dxtrace(printk(KERN_DEBUG "ext4_find_entry: casefold "
+				       "failed, falling back\n"));
+		else
 			goto cleanup_and_exit;
-		dxtrace(printk(KERN_DEBUG "ext4_find_entry: dx failed, "
-			       "falling back\n"));
 		ret = NULL;
 	}
 	nblocks = dir->i_size >> EXT4_BLOCK_SIZE_BITS(sb);
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 2c3b2f8a621f..a10edf804140 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -1258,11 +1258,15 @@ extern int send_sigurg(struct file *file);
 #define SB_NOUSER       BIT(31)
 
 /* These flags relate to encoding and casefolding */
-#define SB_ENC_STRICT_MODE_FL	(1 << 0)
+#define SB_ENC_STRICT_MODE_FL		(1 << 0)
+#define SB_ENC_NO_COMPAT_FALLBACK_FL	(1 << 1)
 
 #define sb_has_strict_encoding(sb) \
 	(sb->s_encoding_flags & SB_ENC_STRICT_MODE_FL)
 
+#define sb_no_casefold_compat_fallback(sb) \
+	(sb->s_encoding_flags & SB_ENC_NO_COMPAT_FALLBACK_FL)
+
 /*
  *	Umount options
  */
-- 
2.45.2


