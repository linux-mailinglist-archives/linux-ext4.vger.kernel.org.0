Return-Path: <linux-ext4+bounces-7959-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F94ABB3B9
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 05:54:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C1E51735F4
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 03:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD1B61DE4C8;
	Mon, 19 May 2025 03:54:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="hrBdJGZ3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04401FAA;
	Mon, 19 May 2025 03:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747626883; cv=none; b=emDil6nI+8/WfrpRzZnAy03etLwPtZx8k35e2Q7m7aEsA4seda1wL9f7fPKtxV8GLqFZhVASWYYaOcJ2ZlutKX4JbUKTjglvKEksDR4fSNcm5PSK2nKa3vtF93Elqerz5hCqF2F3lAP3aXbsSDNAf/VesrIBFiSVAg5+1F6SMoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747626883; c=relaxed/simple;
	bh=7Ra3K2OwzVwWKet+svJjlzEF0rBmYKmRsd0XFB87m84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=G38nRRD/pOTFaXLkwUAxQD15sHtNgG72RNY0jfiOwbsvFo1ePq/w9yfw54tq8tAGqc5x8PPL+EyaN8U7INkivg/7W2f64M/3l6CbqspVDLmpyezQ4kTIEHd+EUG31MajJkBTFF2uHw2JhWAXfYMiHcg62UK4YCiEFTr8eW3gdkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=hrBdJGZ3; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4b13j25GPsz9sv1;
	Mon, 19 May 2025 05:54:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1747626871;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=UeDu8PHSWuuIHAbS2PGJQ9cJz+KEZFn/PW/D40Wbw0k=;
	b=hrBdJGZ3dy7w3pB4OAEc6WggTg+nsmMyToqVjzr7rMnHz3NdEJsZ9b6RROXL3O0gsidOby
	OoJSx7/kYD9YCUUZoRUcFUt1j4XZWGOyHP7O85Q79XWucPT8YDBjyJUhwts9HCYKLNDKbV
	gzBc5sHwzARIAkAm/gSl96wM5IXLsuAe7Pojhigk09mcdBbKrGolq3VKqLgb+5Q+EmZBdS
	6PrHVnHjh18hOVEkzXZKNfbeqDPOp08IchNUPDXaQ1ZapUa7EPwo89RWgmSD8J9/cS19//
	oZ7TeaCrO/Y0ce6g6mZJdIGNIjlmrUm5qtMmfgoYot/asIxmaskil4JvV/e2TA==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Sun, 18 May 2025 23:54:21 -0400
Subject: [PATCH v2] ext4: replace strcpy() with '.' assignment
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAGyrKmgC/22NwQ6DIBAFf8XsuTRARGlP/kfjgS5L5VA1QKjG8
 O+lnnucSd68AyIFTxHuzQGBso9+mSvISwM4mflFzNvKILlUXAnNaEstiyngujOhWoWd629PJaA
 u1kDOb2ftMVaefExL2M94Fj/7v5MFE6xDbbR0jvfaDZTqOZL9mGDjFZc3jKWUL/OmnWCuAAAA
X-Change-ID: 20250518-ext4-strcpy-1545c6f79b51
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2895;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=7Ra3K2OwzVwWKet+svJjlzEF0rBmYKmRsd0XFB87m84=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpHaXRMbDU3OXVQT0pydXk5Vnd2Q3BXOGI4aEVuYnFuCktCYngrcnRTZFRNdnB6N3oz
 QmNkcFN3TVlsd01zbUtLTFA5emxOTWVhczVRMlBuWHBRbG1EaXNUeUJBR0xrNEIKbUVpbkdpUER
 yS01XMVp2dTVaYitFNWhiTWFYbTlqeEZ2ZzJyR2VXaUtpVHE0MjJjajF3NHcvQlB4Mzl4NjFueg
 oyWnRqbkQwRGs5NjlNVGt2dVY3V21rT0NNLy92emV1NVRSTzVBTHd0U2swPQo9bk9IOQotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE

strcpy() is deprecated; assignment can be used instead which
theoretically/potentially increases speed as a function call is removed.

Straight assignment works because the strings are not null-terminated
which means they don't strictly require a str(s)cpy call.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
There's an ongoing effort to remove calls to strcpy throughout the
kernel.

Link: https://github.com/KSPP/linux/issues/88
---
Changes in v2:
- completely remove the call to strcpy and replace it with assignment
  off of Theo's suggestion. Thanks.
- Link to v1: https://lore.kernel.org/r/20250518-ext4-strcpy-v1-1-6c8a82ff078f@ethancedwards.com
---
 fs/ext4/inline.c | 4 ++--
 fs/ext4/namei.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2c9b762925c72f2ff5a402b02500370bc1eb0eb1..f3bc8b3904a8a9b55162f002b5bd63a527b290a5 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1314,7 +1314,7 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 		if (pos == 0) {
 			fake.inode = cpu_to_le32(inode->i_ino);
 			fake.name_len = 1;
-			strcpy(fake.name, ".");
+			fake.name[0] = ".";
 			fake.rec_len = ext4_rec_len_to_disk(
 					  ext4_dir_rec_len(fake.name_len, NULL),
 					  inline_size);
@@ -1324,7 +1324,7 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 		} else if (pos == EXT4_INLINE_DOTDOT_OFFSET) {
 			fake.inode = cpu_to_le32(parent_ino);
 			fake.name_len = 2;
-			strcpy(fake.name, "..");
+			fake.name[0] = fake.name[1] = ".";
 			fake.rec_len = ext4_rec_len_to_disk(
 					  ext4_dir_rec_len(fake.name_len, NULL),
 					  inline_size);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index e9712e64ec8f04586f5ebcd332431e6af92e4f36..c7d7c46a0b18ae109d30358c157812ac2ded200e 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2926,7 +2926,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 	de->name_len = 1;
 	de->rec_len = ext4_rec_len_to_disk(ext4_dir_rec_len(de->name_len, NULL),
 					   blocksize);
-	strcpy(de->name, ".");
+	de->name[0] = '.';
 	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
 
 	de = ext4_next_entry(de, blocksize);
@@ -2940,7 +2940,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 		de->rec_len = ext4_rec_len_to_disk(
 					ext4_dir_rec_len(de->name_len, NULL),
 					blocksize);
-	strcpy(de->name, "..");
+	de->name[0] = de->name[1] = '.';
 	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
 
 	return ext4_next_entry(de, blocksize);

---
base-commit: 5723cc3450bccf7f98f227b9723b5c9f6b3af1c5
change-id: 20250518-ext4-strcpy-1545c6f79b51

Best regards,
-- 
Ethan Carter Edwards <ethan@ethancedwards.com>


