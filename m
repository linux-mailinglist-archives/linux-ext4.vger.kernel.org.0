Return-Path: <linux-ext4+bounces-6368-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58CD6A2B989
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 04:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DCD13A5955
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Feb 2025 03:14:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51C24169AE6;
	Fri,  7 Feb 2025 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PbwpYLXk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1C81624FF
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 03:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738898081; cv=none; b=eE/ZjzK8mrckVmJpVP0/EmetR/SafnlTCiygPsEQvszJm7eOh2cojPbvyV8xkh2kg7MAD+s9a1FHHvBkI7zg8y89flifnub8/zoG/CJWllkcfarb7lcyXNRIK49XpjZKBZaAsJBo7GOVZvAveibZYhAhdohe+SXR4kaagm12FeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738898081; c=relaxed/simple;
	bh=uMzapWY/BxwvMLMCVvMDleh75+QpXnSqSm9gT6Ii0vU=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=RPf7kHUmuBGF1zY9ZlDO8sTsH551V4L69SBi53GYq1sV4wdLBEkSBbyetV0d1E8lp26tD3h15A8SH6w65cyzImP5fOFEqYPAVTf17xHoImFPTH9mtArhqm2ZjfXPBoDjHnc+SunGsezXRzDfWFAqvkNEJ0P3Ybod0nBsiDq0SHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PbwpYLXk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36935C4CED1
	for <linux-ext4@vger.kernel.org>; Fri,  7 Feb 2025 03:14:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738898081;
	bh=uMzapWY/BxwvMLMCVvMDleh75+QpXnSqSm9gT6Ii0vU=;
	h=From:To:Subject:Date:From;
	b=PbwpYLXk0SehEbsTTqGb25ux7zuLrzedWwTA5y9GihTTqFhXvGtndUPzcJNjxygsO
	 gMwf0aWWVguoRhan1+Zk8lXaBTN2Ns/rZoBeyjT6sSih/8Gned8KQdlAjm8+yDZhl7
	 o0rc393iyLyJ1IjcEFWagLvW2h3steFINSWGB8SxsPsAiFJepGXtRt8XDc5vqeZH9+
	 YcWhzX9c2fAyMsfuOuJd90JygUrpy6brTpwpjfKp4MFN8huSBpG2+2+HQL5qJDIYDT
	 L3er/Y1VIObOHkF4ORfyxPHG34uGvOAbt/FwjoEERCbQlKnzYYXqz1PasJq4OiMYcl
	 b+VFR5c+UDfww==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-ext4@vger.kernel.org
Subject: [PATCH] jbd2: remove redundant function jbd2_journal_has_csum_v2or3_feature
Date: Thu,  6 Feb 2025 19:14:24 -0800
Message-ID: <20250207031424.42755-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Eric Biggers <ebiggers@google.com>

Since commit dd348f054b24 ("jbd2: switch to using the crc32c library"),
jbd2_journal_has_csum_v2or3() and jbd2_journal_has_csum_v2or3_feature()
are the same.  Remove jbd2_journal_has_csum_v2or3_feature() and just
keep jbd2_journal_has_csum_v2or3().

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 fs/jbd2/journal.c    | 4 ++--
 include/linux/jbd2.h | 8 ++------
 2 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/fs/jbd2/journal.c b/fs/jbd2/journal.c
index d8084b31b3610..4de74056a3c36 100644
--- a/fs/jbd2/journal.c
+++ b/fs/jbd2/journal.c
@@ -1359,19 +1359,19 @@ static int journal_check_superblock(journal_t *journal)
 		printk(KERN_ERR "JBD2: Can't enable checksumming v2 and v3 "
 		       "at the same time!\n");
 		return err;
 	}
 
-	if (jbd2_journal_has_csum_v2or3_feature(journal) &&
+	if (jbd2_journal_has_csum_v2or3(journal) &&
 	    jbd2_has_feature_checksum(journal)) {
 		/* Can't have checksum v1 and v2 on at the same time! */
 		printk(KERN_ERR "JBD2: Can't enable checksumming v1 and v2/3 "
 		       "at the same time!\n");
 		return err;
 	}
 
-	if (jbd2_journal_has_csum_v2or3_feature(journal)) {
+	if (jbd2_journal_has_csum_v2or3(journal)) {
 		if (sb->s_checksum_type != JBD2_CRC32C_CHKSUM) {
 			printk(KERN_ERR "JBD2: Unknown checksum type\n");
 			return err;
 		}
 
diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 561025b4f3d91..a7e8163637b44 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1734,18 +1734,14 @@ static inline int tid_geq(tid_t x, tid_t y)
 }
 
 extern int jbd2_journal_blocks_per_page(struct inode *inode);
 extern size_t journal_tag_bytes(journal_t *journal);
 
-static inline bool jbd2_journal_has_csum_v2or3_feature(journal_t *j)
-{
-	return jbd2_has_feature_csum2(j) || jbd2_has_feature_csum3(j);
-}
-
 static inline int jbd2_journal_has_csum_v2or3(journal_t *journal)
 {
-	return jbd2_journal_has_csum_v2or3_feature(journal);
+	return jbd2_has_feature_csum2(journal) ||
+	       jbd2_has_feature_csum3(journal);
 }
 
 static inline int jbd2_journal_get_num_fc_blks(journal_superblock_t *jsb)
 {
 	int num_fc_blocks = be32_to_cpu(jsb->s_num_fc_blks);

base-commit: 2014c95afecee3e76ca4a56956a936e23283f05b
-- 
2.48.1


