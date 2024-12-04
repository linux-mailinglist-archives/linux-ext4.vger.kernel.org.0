Return-Path: <linux-ext4+bounces-5475-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE1D59E362C
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2024 10:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8F55CB2C4CC
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Dec 2024 09:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF111917C7;
	Wed,  4 Dec 2024 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oxjk/ujv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1556819068E;
	Wed,  4 Dec 2024 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733302955; cv=none; b=CBKYslOcI/SFuT5XxIjxdpb61IBJxIuZzoG8hgTwEaZJRACOIS3WsWIwsdCwBKpXhDrb2Mw3E1HUWC/GE64JByVeEPlnzHiB6SGXQEjuGI4NGxMUMX1Yf7LmnXEM2YHBVbETiE53W1kMMP8L2ZgVNl2rvAYHGIoouZ4uO4sWU94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733302955; c=relaxed/simple;
	bh=8RmifYdzdZy0clOcnFMeiV2uzq1tXJOgoEnRmiFptXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UQs5uYEKyfe3RMZqKnA9k89CP9awItzSNBjS+fmc2WjxaKjaJWL5RwbUCp9HqBjz00FEQ4fFzZ9StkLDRUBfccemI9+bbJYcaQv1E2wx7AJLI9AYPAw5u1yks2GnAgohg1uEJ7AVBlDH8u7/tqDScZZC8ZFVmvwLmIefghsBads=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oxjk/ujv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-434a7ee3d60so3412345e9.1;
        Wed, 04 Dec 2024 01:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733302951; x=1733907751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j/DGtO9+27cwfmhQKMhcolvJLEg37XkgAaNptn6u3uc=;
        b=Oxjk/ujvnQ89stkBg05sQgGcX3Fc3lfaWl7+8rZha1U1bUHpUlcBs9f6z972v9SBrV
         sfNWgXJnbeQ4iwBLNzNgJ6Hp9VxCWX6NP2H6hJT1sWfj7+tQAv8ZX3agysAY1mIHBpY0
         n+Ud6YIWMN5Df4b1b9804YcVad2KmBNR4h5R0JWhSaBFNrfNaWhGwUziz+Nnh6Ef0etT
         0Xm7aJvXMdQVxcduvf7w4N+mwju0pAZZ+F3NVGUhP7k65jpqhdLgiECW97OB9/paEHXc
         6AI/vHELiXcx+YX3Fxww4CYyeqiidHiNW36m5RiSn+XcF9FlyuPgZBR5Xg4MNPZH/EI+
         8QTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733302951; x=1733907751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j/DGtO9+27cwfmhQKMhcolvJLEg37XkgAaNptn6u3uc=;
        b=eujdBn1pdX6zXZGnWt0a02mwY6i69bHQ4QOqk4b1MKeSqJB/MO9Z5FO6m+EnVuNWIa
         0i0m3NT9syRb4NlWrwIsw8NNfk1f814Brb7hzi5Mo+0JKIQo6LvOA566SI7zNFi5Z3LJ
         IJqv/8dsiwvC4mQDEnhjru7A3AWThz33AZ2xP7akXIsnd2NLLzJLRhs1Cnx7Umq3O9fd
         ZgS7Kl+fePWJ+WXAm/p3DQMMpf/Kg3/yk22QZzjeIzEdRE6YY3UxmhG8GbiqP23fUdkr
         OJHa5zAWnV8YEcqcyEOleM/obMtTBHrYNYRkLPYgJQ6C8PRgTABbCKJQzeinM/PjpB2J
         4WOA==
X-Forwarded-Encrypted: i=1; AJvYcCVqoY7/u8KHgErWCed4qatUC/+NyeAHMLewMaKCAOV/Z2tc+haFD/rXJ3wkc9fnWXkKutFqRGIAMFPKIjME@vger.kernel.org, AJvYcCWzDI4L68EDf8nduXijqVggf+420VVps6VcH+o31O8NgwxKQenWt+G+wji0C4gB/1/SEyhqLy9Ejryp@vger.kernel.org
X-Gm-Message-State: AOJu0YweidrvixLTRc5K7CB5nBDevJRT13aN4ug/4tM7D8GEKd0lW1T2
	rJbnNl1RbrT6On7MUuNGgzCenTeEKUWWWeeUf/dKM5tMsWrLhiCk
X-Gm-Gg: ASbGnct52LKgQw8MQMwJkxLI33BiFJZneGlLYLvg2EaFOV4IAD2aEdVi82Hs1AGxQhl
	lQmW7p2xGdtb90ORNfG/ZXcSoempdlc0Vqq1lWhK6GGmNh8qFlIoM3CVQJ+cX7st//59AhuNSSp
	hM2WWmeKAdy/1xeKaAxNuyTAE6jjr1U9oixIddjHT4ebQweosgr9pyEEq9nLrhrNMjQJJs91hsl
	TJ+9aGIGw/xKbroBQ5XyB3fMm+wmsVbOiCpDlW0gC94n944
X-Google-Smtp-Source: AGHT+IHOZyan41T29GhI3L/+7yODIM3OobyZIQ9f0WdfdWkg06i4pMAX6Beavn05s3mVIrNze+wU2A==
X-Received: by 2002:a05:600c:3589:b0:431:15f1:421d with SMTP id 5b1f17b1804b1-434afc44774mr215133165e9.16.1733302951069;
        Wed, 04 Dec 2024 01:02:31 -0800 (PST)
Received: from Max.. ([176.13.144.22])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-385ccd80435sm17436742f8f.100.2024.12.04.01.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Dec 2024 01:02:30 -0800 (PST)
From: Max Brener <linmaxi@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Brener <linmaxi@gmail.com>
Subject: [PATCH v3] ext4: Optimization of no-op ext4_truncate triggers
Date: Wed,  4 Dec 2024 11:02:25 +0200
Message-ID: <20241204090225.721618-1-linmaxi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219306
v2: https://lore.kernel.org/lkml/20241001082459.14580-1-linmaxi@gmail.com/T/
OR
	https://patchwork.ozlabs.org/project/linux-ext4/patch/20241016111624.5229-1-linmaxi@gmail.com/

Fix from last version:
Clear the EXT4_STATE_TRUNCATED flag at ext4_mb_new_blocks() in order to
make sure that every attempt to allocate new blocks, will result in resetting
the 'truncated' state of the inode.
Why is this needed? We want the ability to truncate preallocated blocks of an inode
by using ext4_truncate(). However, when ftruncate is called from the vfs, the call
is blocked (at ext4_setattr()) when used on already-truncated inodes. We want that
call to be blocked only if the truncate call is redundant (meanning there is
nothing there to truncate).


---
 fs/ext4/ext4.h    | 1 +
 fs/ext4/extents.c | 5 +++++
 fs/ext4/inode.c   | 6 +++++-
 fs/ext4/mballoc.c | 5 +++++
 4 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..032e51f2a92b 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1915,6 +1915,7 @@ enum {
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
 	EXT4_STATE_ORPHAN_FILE,		/* Inode orphaned in orphan file */
+	EXT4_STATE_TRUNCATED, 		/* Inode is truncated */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 34e25eee6521..531fa0f2ccd3 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4782,6 +4782,11 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		ret = ext4_zero_range(file, offset, len, mode);
 		goto exit;
 	}
+
+	if (mode & FALLOC_FL_KEEP_SIZE) {
+		ext4_clear_inode_state(inode, EXT4_STATE_TRUNCATED);
+	}
+
 	trace_ext4_fallocate_enter(inode, offset, len, mode);
 	lblk = offset >> blkbits;
 
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..cbdad3253920 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4193,6 +4193,8 @@ int ext4_truncate(struct inode *inode)
 	if (IS_SYNC(inode))
 		ext4_handle_sync(handle);
 
+	ext4_set_inode_state(inode, EXT4_STATE_TRUNCATED);
+
 out_stop:
 	/*
 	 * If this was a simple ftruncate() and the file will remain alive,
@@ -5492,7 +5494,9 @@ int ext4_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		 * Call ext4_truncate() even if i_size didn't change to
 		 * truncate possible preallocated blocks.
 		 */
-		if (attr->ia_size <= oldsize) {
+		if (attr->ia_size < oldsize ||
+			(attr->ia_size == oldsize &&
+			!ext4_test_inode_state(inode, EXT4_STATE_TRUNCATED))) {
 			rc = ext4_truncate(inode);
 			if (rc)
 				error = rc;
diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d73e38323879..4f0dbd53b3df 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6149,6 +6149,11 @@ ext4_fsblk_t ext4_mb_new_blocks(handle_t *handle,
 	sb = ar->inode->i_sb;
 	sbi = EXT4_SB(sb);
 
+	/* Once there is an attempt to allocate new blocks,
+	 * the inode is no longer considered truncated.
+	 */
+	ext4_clear_inode_state(ar->inode, EXT4_STATE_TRUNCATED);
+
 	trace_ext4_request_blocks(ar);
 	if (sbi->s_mount_state & EXT4_FC_REPLAY)
 		return ext4_mb_new_blocks_simple(ar, errp);
-- 
2.43.0


