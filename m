Return-Path: <linux-ext4+bounces-8014-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDD2ABBD2A
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 14:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C8E189D42F
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 12:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED45F274FDA;
	Mon, 19 May 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b="E55L1Do9"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AB2D2AC17;
	Mon, 19 May 2025 12:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747656068; cv=none; b=OJ8/PrZ+dumJxvjq2smsJNL+PPCbwZArdjLo0pW2lpJ/N8vmU7ifMHPw7EKlL3+EEIt+oYVaQ1D1rfzHLmvsMrsp8I6dk2OxxpFCOD6YSCfdRUOkB5UqX4BGa3XYZRFUuPELTgoDiv8HMJt7RBcmMQHa2K0wV9ZziS//4ybWIG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747656068; c=relaxed/simple;
	bh=6FQZCmbqhYBvGYMZKrSz23qP8S75tNvXJkLejE2PXIc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Rm8tFD9ehH+TvjaD5MThAlwOEzkSCdOUcpkSBr3210kWcqzfM8tZkY/dFzp7nEC67Sqgh8qsUcK4HlhiIqVpcswC8bVlyTFDwI1CV+7DIFOPV6/8o2jotNfuMIstI9S4aWim2LCTI6y2CWMtkw8i6xZ2dty0w3dP/6vZuU9cDOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com; spf=pass smtp.mailfrom=ethancedwards.com; dkim=pass (2048-bit key) header.d=ethancedwards.com header.i=@ethancedwards.com header.b=E55L1Do9; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ethancedwards.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ethancedwards.com
Received: from smtp1.mailbox.org (smtp1.mailbox.org [IPv6:2001:67c:2050:b231:465::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4b1GVP64tMz9tVZ;
	Mon, 19 May 2025 14:01:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ethancedwards.com;
	s=MBO0001; t=1747656062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=OmBSswFk2f6Bhh6ty+jXPF6BtXUnOS/D9iXCBGxUOhk=;
	b=E55L1Do9xNxNDkE9rcMwOaGdqVZZNEtZTNgXXSBFn9lbYWevmzxHryrE0pxght18pw5QT4
	/ueZC19Nk0Ktrv+id7H2uFbOjjw9OwkNN/HDhpOm/E05Qqoc8OnkdTr5q3QnizDdm51HCP
	r3rEQq0PrO4uwzEnCco/GNHR/AkxaveVgszkhT7PGOcmk/Dw+F2gHiRd4TOBhvZYa/rBWA
	aEyQK8wcaQrfyGC6Dk/2VY3RR6Rngu1ZkaoiCFwm4MU7wuujUE8OhHmXJSM2fpJFeqYC1O
	9NhCWnVCPhT+TM6/LaP7CqJNrF2J0tu52JuLIzlYPpbSQ3sohY6pE6pqh06xbw==
From: Ethan Carter Edwards <ethan@ethancedwards.com>
Date: Mon, 19 May 2025 08:00:57 -0400
Subject: [PATCH v3] ext4: replace strcpy() with '.' assignment
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250519-ext4-strcpy-v3-1-d6518a5f3d47@ethancedwards.com>
X-B4-Tracking: v=1; b=H4sIAHgdK2gC/33NwQ6DIAyA4VcxnMdCUZDttPdYdnBQJodNA4Rpj
 O++6tns+Lfp14UljAETu1YLi1hCCsOHoj5VzPbd54U8OGomhVRCgeE45YanHO04c1CNstq3l6c
 CRhdjRB+mXbs/qPuQ8hDnHS+wTY+dAhy4tqYz0nvRGn/DTM8tum8XXTrb4c02r8g/hiTDCFeDr
 mnd6CNjXdcf1NGNJfIAAAA=
X-Change-ID: 20250518-ext4-strcpy-1545c6f79b51
To: Theodore Ts'o <tytso@mit.edu>, 
 Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Kees Cook <kees@kernel.org>, 
 "Gustavo A. R. Silva" <gustavoars@kernel.org>, linux-ext4@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org, 
 Ethan Carter Edwards <ethan@ethancedwards.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2922;
 i=ethan@ethancedwards.com; h=from:subject:message-id;
 bh=6FQZCmbqhYBvGYMZKrSz23qP8S75tNvXJkLejE2PXIc=;
 b=LS0tLS1CRUdJTiBQR1AgTUVTU0FHRS0tLS0tCgpvd0o0bkp2QXk4ekFKWGJEOXFoNThlVGp6e
 GhQcXlVeFpHakxWamIxemhXT1lGWmZxdExTc2lqNzhhdkY2VXRxCkVscldXTWszQkhiNFdhOWQ1
 TmxSeXNJZ3hzVWdLNmJJOGo5SE9lMmg1Z3lGblg5ZG1tRG1zREtCREdIZzRoU0EKaVp5NnpNaXd
 hVloxemJJZC96NjlLQW85RWZQa2c1WklsUm1mS05zelo4T1h6anBuOG93bEdmNUs1OHcrTENyTg
 pZUlc3eFR4Z0IwdUNyTXF0YXhXTUU3Y3RQK1hOZThYTi9qOC9BUG56U0E4PQo9QzBxKwotLS0tL
 UVORCBQR1AgTUVTU0FHRS0tLS0tCg==
X-Developer-Key: i=ethan@ethancedwards.com; a=openpgp;
 fpr=2E51F61839D1FA947A7300C234C04305D581DBFE
X-Rspamd-Queue-Id: 4b1GVP64tMz9tVZ

strcpy() is deprecated; assignment can be used instead which
theoretically/potentially increases speed as a function call is removed.

Straight assignment works because the strings are not null-terminated
which means they don't strictly require a str(s)cpy call.

No functional changes intended.

Link: https://github.com/KSPP/linux/issues/88
Suggested-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ethan Carter Edwards <ethan@ethancedwards.com>
---
Changes in v3:
- Fix typo of "." instead of '.'. Sorry!
- Link to v2: https://lore.kernel.org/r/20250518-ext4-strcpy-v2-1-80d316325046@ethancedwards.com

Changes in v2:
- completely remove the call to strcpy and replace it with assignment
  off of Theo's suggestion. Thanks.
- Link to v1: https://lore.kernel.org/r/20250518-ext4-strcpy-v1-1-6c8a82ff078f@ethancedwards.com
---
 fs/ext4/inline.c | 4 ++--
 fs/ext4/namei.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index 2c9b762925c72f2ff5a402b02500370bc1eb0eb1..7ba6220f92ee4e1b817bc9b47ec229050af3dde7 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1314,7 +1314,7 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 		if (pos == 0) {
 			fake.inode = cpu_to_le32(inode->i_ino);
 			fake.name_len = 1;
-			strcpy(fake.name, ".");
+			fake.name[0] = '.';
 			fake.rec_len = ext4_rec_len_to_disk(
 					  ext4_dir_rec_len(fake.name_len, NULL),
 					  inline_size);
@@ -1324,7 +1324,7 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 		} else if (pos == EXT4_INLINE_DOTDOT_OFFSET) {
 			fake.inode = cpu_to_le32(parent_ino);
 			fake.name_len = 2;
-			strcpy(fake.name, "..");
+			fake.name[0] = fake.name[1] = '.';
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


