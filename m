Return-Path: <linux-ext4+bounces-8961-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DF38B02C51
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 20:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B089B1AA3373
	for <lists+linux-ext4@lfdr.de>; Sat, 12 Jul 2025 18:13:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9F5B288C88;
	Sat, 12 Jul 2025 18:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="EG7b/HZr"
X-Original-To: linux-ext4@vger.kernel.org
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A491C07C3
	for <linux-ext4@vger.kernel.org>; Sat, 12 Jul 2025 18:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752343997; cv=none; b=Yc1fR4HFHj6A8DMOxFVTjMY/P5VVSjaebCqzuOSdbDjm0ZcfVffborQb1q62hNhj0sYARJwDPBNyFJQ4wyEIH0vL0lvqasNKaEGSe4Ud1BOvesF+ccBnH8rDCzHF1RCzzRuhWQpaabeYqg9ngp8opoZzgqwrZnVMeaymHWQdwu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752343997; c=relaxed/simple;
	bh=xtf4qnXMuYlzwYGY5OInHmPO+0iJNT+QmwSGk8+unvQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E/b7iagGdbVEwJ4X06yZK99AI8GiOcQHnhKrFG2aW9O38dvivK7hTkON2s/PbdrXilsTkFf8TFN7oQ3/YSk1b1TckROu94tvqWiFfV/53NhcpbIrjueeIPMD1m82uU1U/uDsJIZjZGkbXVPYxto5lM8m/yO6VpOe8CzGfxRQlFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=EG7b/HZr; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Received: from trampoline.thunk.org (pool-173-48-112-142.bstnma.fios.verizon.net [173.48.112.142])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 56CICwfj029951
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 12 Jul 2025 14:12:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1752343980; bh=7a58VYtGe9ml4sPVVgGPLeyo7zgHmLW7OSfi87Z6ds4=;
	h=From:Subject:Date:Message-ID:MIME-Version;
	b=EG7b/HZrfLnq+ByGm38r9LgC4wdrFlV1GD36gCM07ZHUC6XWangT2Px4gnrKLDCxl
	 mJXCKt5QvSUm7GAkVDA/rcGbtBlbbhldK1H0FofoEBDDXFJR7H7+4Mjl06LO8wl9xa
	 gZgFYAkJzR0x6kjQsl/4Zs0bs/yOrRlnlIXghbxaCJeQkYX1shcv/IkzxdqFl71r4X
	 laVtalB1BEegE/dOTf6lZFNWL6X4UQ+xTcXKWphunqsZrjs30b+8V0TYibqYiKyG02
	 myzG4hLJrT84LQUTTG1ajr6qE3BHRNTRgsAv68MMP1mYLXH1IFa9iHORDeIomN/I+1
	 0+YahtZUwZlsw==
Received: by trampoline.thunk.org (Postfix, from userid 15806)
	id C46FA2E00D4; Sat, 12 Jul 2025 14:12:58 -0400 (EDT)
From: "Theodore Ts'o" <tytso@mit.edu>
To: Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc: linux-hardening@vger.kernel.org, ethan@ethancedwards.com,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 2/3] ext4: use memcpy() instead of strcpy()
Date: Sat, 12 Jul 2025 14:12:48 -0400
Message-ID: <20250712181249.434530-2-tytso@mit.edu>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250712181249.434530-1-tytso@mit.edu>
References: <20250712181249.434530-1-tytso@mit.edu>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The strcpy() function is considered dangerous and eeeevil by people
who are using sophisticated code analysis tools such as "grep".  This
is true even when a quick inspection would show that the source is a
constant string ("." or "..") and the destination is a fixed array
which is guaranteed to have enough space.  Make the "grep" code
analysis tool happy by using memcpy() isstead of strcpy().  :-)

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/inline.c | 4 ++--
 fs/ext4/namei.c  | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index a1bbcdf40824..eeee007251e0 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1315,7 +1315,7 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 		if (pos == 0) {
 			fake.inode = cpu_to_le32(inode->i_ino);
 			fake.name_len = 1;
-			strcpy(fake.name, ".");
+			memcpy(fake.name, ".", 2);
 			fake.rec_len = ext4_rec_len_to_disk(
 					  ext4_dir_rec_len(fake.name_len, NULL),
 					  inline_size);
@@ -1325,7 +1325,7 @@ int ext4_inlinedir_to_tree(struct file *dir_file,
 		} else if (pos == EXT4_INLINE_DOTDOT_OFFSET) {
 			fake.inode = cpu_to_le32(parent_ino);
 			fake.name_len = 2;
-			strcpy(fake.name, "..");
+			memcpy(fake.name, "..", 3);
 			fake.rec_len = ext4_rec_len_to_disk(
 					  ext4_dir_rec_len(fake.name_len, NULL),
 					  inline_size);
diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index b82f5841c65a..9913a94b6a6d 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2924,7 +2924,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 	de->name_len = 1;
 	de->rec_len = ext4_rec_len_to_disk(ext4_dir_rec_len(de->name_len, NULL),
 					   blocksize);
-	strcpy(de->name, ".");
+	memcpy(de->name, ".", 2);
 	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
 
 	de = ext4_next_entry(de, blocksize);
@@ -2938,7 +2938,7 @@ struct ext4_dir_entry_2 *ext4_init_dot_dotdot(struct inode *inode,
 		de->rec_len = ext4_rec_len_to_disk(
 					ext4_dir_rec_len(de->name_len, NULL),
 					blocksize);
-	strcpy(de->name, "..");
+	memcpy(de->name, "..", 3);
 	ext4_set_de_type(inode->i_sb, de, S_IFDIR);
 
 	return ext4_next_entry(de, blocksize);
-- 
2.47.2


