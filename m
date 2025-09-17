Return-Path: <linux-ext4+bounces-10221-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 132F0B7EBD9
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 14:58:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BDE5522965
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Sep 2025 03:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D6962F745C;
	Wed, 17 Sep 2025 03:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IuGltoEE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA06A224B04;
	Wed, 17 Sep 2025 03:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758079397; cv=none; b=AaatTJrjrNh8b+0LSlyh1wym/m4+nCnZc3oF1PBtRj8kTITJ+sOdruXEVr5n5WO0xo3ep6RWhMFwQV5oVQCiDqA4YiukTOIIByCYXiq1d1s9BJ/RDTWymH8DM9CmyfnoBlj/HuMQQWZNcmnDdQBewy8RJ5OZtS7CVzdWsqM0fG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758079397; c=relaxed/simple;
	bh=7/K64RgPZX31vBYzcHhhXgQvEVR35qW0pMA4yNu6lqU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eQL858LnuuiVy15xtjIjaIsBRVT1S1lffwysSP2irrqrXUHzRceVrTN63QoQm0hDHfXeP4dYewXHQzOPIiGT860kRajcaPkruAHpJ8BbDUr1aief0zUc/w0r8nwKvslUK7Ut2BhAMoJ+foSl40dmm639O4U+3yDEVbNbOtkQDeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IuGltoEE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 648F5C4CEF9;
	Wed, 17 Sep 2025 03:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758079397;
	bh=7/K64RgPZX31vBYzcHhhXgQvEVR35qW0pMA4yNu6lqU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=IuGltoEEGGFPSzlOxtg6irv/f3+qmhYMhCq1hlQZXPOaSeIWX7a247wZ6avi13YkP
	 DQvTCnyh2SQGTV44iWZI6POd+1eIzcaeiaHnQB5V9Mn7ec2pfeUoVOYBeUamvdDVtf
	 ajqn35OqZ9m89RH6v9ljQxgc0E5O4JvI1wo/v1nxyR1OmPzn5CfOeZ08nNnLPQlQ9B
	 zW1Bu7OEBwqfGLsqsq/POj4ncNTpCcaBfQ/ao1Cp9b6hxb8Rn7lcYj0zf6aVqshumb
	 E7Q2KiBFb2jL2/sMk0iCBbqErFJSasU+Og2cls9XSS4LvRu/B32HOxNNH95psSg3bS
	 mqTPFayLd1lFg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5664CCAC59F;
	Wed, 17 Sep 2025 03:23:17 +0000 (UTC)
From: Theodore Ts'o via B4 Relay <devnull+tytso.mit.edu@kernel.org>
Date: Tue, 16 Sep 2025 23:22:48 -0400
Subject: [PATCH v2 2/3] ext4: add support for 32-bit default reserved uid
 and gid values
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250916-tune2fs-v2-2-d594dc7486f0@mit.edu>
References: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
In-Reply-To: <20250916-tune2fs-v2-0-d594dc7486f0@mit.edu>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-api@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3279; i=tytso@mit.edu;
 h=from:subject:message-id;
 bh=RgbVLDQ1SgNDZyk7YrOPD3panle4KdyrPTxmbmUXY9M=;
 b=owEBbQGS/pANAwAIAfL5WVaVDYGjAcsmYgBoyimkTvFqVyQTwHQR43hpXjOnM9+jcYiLVC9jh
 aODE0IZPpSJATMEAAEIAB0WIQQrablU2/4IeSiBN8ny+VlWlQ2BowUCaMoppAAKCRDy+VlWlQ2B
 o+bKB/9T9TwAmTqrX4URGnx9SuNjJ/3hTBSutYKhwfFDctI5WQ0w26nUZN0X1Mp8vxqttKsB4LJ
 OHZQ7HZGVXrmvsBs5/x19m7aE+svXAD3BtO7bZxhPld1ifDx8DRBfHM/X9xpzV6ZDJq/Q41QH3d
 imDsyv9oqIAF5b4HYs58wwm/JhkVKrDW2PawE5RMYhbVWWRUYulILHqbZA0wsdrLWqHgL4/ReTX
 Ct7N+K5K6kos1L+PuMyUgp8sRBmHGZt2W845PiNZjLcWxn86dWWn/adEM6juY5UyNz8Mq31wmlJ
 /FiEtINhJO/Z5z8hTgRnGK0AFAhGebaa2litDGJ2jPZJGR7N
X-Developer-Key: i=tytso@mit.edu; a=openpgp;
 fpr=3AB057B7E78D945C8C5591FBD36F769BC11804F0
X-Endpoint-Received: by B4 Relay for tytso@mit.edu/default with auth_id=517
X-Original-From: Theodore Ts'o <tytso@mit.edu>
Reply-To: tytso@mit.edu

From: Theodore Ts'o <tytso@mit.edu>

Support for specifying the default user id and group id that is
allowed to use the reserved block space was added way back when Linux
only supported 16-bit uid's and gid's.  (Yeah, that long ago.)  It's
not a commonly used feature, but let's add support for 32-bit user and
group id's.

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/ext4.h  | 16 +++++++++++++++-
 fs/ext4/super.c |  8 ++++----
 2 files changed, 19 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 01a6e2de7fc3ef0e20b039d3200b9c9bd656f59f..4bfcd5f0c74fda30db4009ee28fbee00a2f6b76f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1442,7 +1442,9 @@ struct ext4_super_block {
 	__le16  s_encoding;		/* Filename charset encoding */
 	__le16  s_encoding_flags;	/* Filename charset encoding flags */
 	__le32  s_orphan_file_inum;	/* Inode for tracking orphan inodes */
-	__le32	s_reserved[94];		/* Padding to the end of the block */
+	__le16	s_def_resuid_hi;
+	__le16	s_def_resgid_hi;
+	__le32	s_reserved[93];		/* Padding to the end of the block */
 	__le32	s_checksum;		/* crc32c(superblock) */
 };
 
@@ -1812,6 +1814,18 @@ static inline int ext4_valid_inum(struct super_block *sb, unsigned long ino)
 		 ino <= le32_to_cpu(EXT4_SB(sb)->s_es->s_inodes_count));
 }
 
+static inline int ext4_get_resuid(struct ext4_super_block *es)
+{
+	return(le16_to_cpu(es->s_def_resuid) |
+	       (le16_to_cpu(es->s_def_resuid_hi) << 16));
+}
+
+static inline int ext4_get_resgid(struct ext4_super_block *es)
+{
+	return(le16_to_cpu(es->s_def_resgid) |
+	       (le16_to_cpu(es->s_def_resgid_hi) << 16));
+}
+
 /*
  * Returns: sbi->field[index]
  * Used to access an array element from the following sbi fields which require
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 94c98446c84f9a4614971d246ca7f001de610a8a..0256c8f7c6cee2b8d9295f2fa9a7acd904382e83 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2951,11 +2951,11 @@ static int _ext4_show_options(struct seq_file *seq, struct super_block *sb,
 	}
 
 	if (nodefs || !uid_eq(sbi->s_resuid, make_kuid(&init_user_ns, EXT4_DEF_RESUID)) ||
-	    le16_to_cpu(es->s_def_resuid) != EXT4_DEF_RESUID)
+	    ext4_get_resuid(es) != EXT4_DEF_RESUID)
 		SEQ_OPTS_PRINT("resuid=%u",
 				from_kuid_munged(&init_user_ns, sbi->s_resuid));
 	if (nodefs || !gid_eq(sbi->s_resgid, make_kgid(&init_user_ns, EXT4_DEF_RESGID)) ||
-	    le16_to_cpu(es->s_def_resgid) != EXT4_DEF_RESGID)
+	    ext4_get_resgid(es) != EXT4_DEF_RESGID)
 		SEQ_OPTS_PRINT("resgid=%u",
 				from_kgid_munged(&init_user_ns, sbi->s_resgid));
 	def_errors = nodefs ? -1 : le16_to_cpu(es->s_errors);
@@ -5270,8 +5270,8 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	ext4_set_def_opts(sb, es);
 
-	sbi->s_resuid = make_kuid(&init_user_ns, le16_to_cpu(es->s_def_resuid));
-	sbi->s_resgid = make_kgid(&init_user_ns, le16_to_cpu(es->s_def_resgid));
+	sbi->s_resuid = make_kuid(&init_user_ns, ext4_get_resuid(es));
+	sbi->s_resgid = make_kgid(&init_user_ns, ext4_get_resuid(es));
 	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
 	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
 	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;

-- 
2.51.0



