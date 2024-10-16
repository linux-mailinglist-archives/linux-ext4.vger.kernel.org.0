Return-Path: <linux-ext4+bounces-4593-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7AC9A0832
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 13:17:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E447B285B17
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Oct 2024 11:17:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F772071FC;
	Wed, 16 Oct 2024 11:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PuGN/Npf"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1AF15C147;
	Wed, 16 Oct 2024 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729077432; cv=none; b=dYrY6xmS2aGLmbVmFw1EFFpp+dHdcFk+imw3bnAsrNOIhtepvP577qnf080aP1q0rD9jHYL/eytRgcmXrSQfMlhMum17q+8DmDFW5bWgsHg4UGG8nXFqs+hrO5BRHTjqtViWJGCjXo6Itm2DSrcSTLXsmDD2GWCwBkkisHqYdYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729077432; c=relaxed/simple;
	bh=EU3sgtn4DXMz6YcK+VSDmOMxYa+S5yUUdTVOKmy5kWo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nLMKB0KqmCg/PiwQZPLv33BvikRSd9YNe4lwWtBtlMoeKVPwRrnqan4ZBzIJpv+lY0MiQyoO7bkJGRNysLCm3LHXaBNjM+BiMSs0boD5hJtH2QTXuQlG93sFUc+gkIO+ZBzV4ZYOX0Ui2Ir4LZZ+cm9tvpwAhmo++JxT10J5NIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuGN/Npf; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-430ee5c9570so76434315e9.3;
        Wed, 16 Oct 2024 04:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729077429; x=1729682229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IkxMsxXOxgn3VlmEMdu8a32/0K8lNsfFBfaK/Bmgj7o=;
        b=PuGN/Npf2NKnOZ516tE77jPsdC/d8KzKpXbASJ4QXvaCU4obx0++fWifQ6VUkX7ziK
         JizKISis/3/GAXInWmJj3AyvPJPPVXJLb1byJTVKHVjcNwEAw5vkBac9d0po8QAn+TqA
         c5DxR5IiB7Iu7JhejZLrvx0AUN9R6akiue5PtYVewFDOvG8yJqTCE5k6MQN35fEa5VhG
         MOphgJ7zZP9N19CGR563nXwILkvuYbHhzlyhD/VU0VWilfFz7t2BeiKPpbQlQi+wb6a+
         pLu/f6On6jWNxVmqt/AzegWAiCI9AqMZFyNZNbmd0DumwG52AIUzEOsN5u6T6rdanqPb
         Of+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729077429; x=1729682229;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IkxMsxXOxgn3VlmEMdu8a32/0K8lNsfFBfaK/Bmgj7o=;
        b=UsG17ZXBp8gdr17tcTQRsREFZRkg8cZUNq9/JsmNtZ2fa07SNgKiRUPYPfB9OJPff4
         kLji7HyruMkPoJDM4xTlGxnXw3XQ0b/oToReYgENlZ+WqZhQLur3GwagDWabov/0pJg1
         fakEPNoggZ6O1asoO9fDq59wU7/OSpX1NPhAEdrsvkq/fqxYo/+r2OmKCtKJ687fijMf
         68ISje6tEJ+mxmYY2//v3xxqiPlM0FdHhdXFnKG5limzpCy/QXFm4SQ+uDtkloyaDEFu
         f2E6am+gPG+ld/txE33/gIfYnoDw0Y+gkn5p7ZSOxvrbdctTZwv3zFYDpqabcfPPrS1m
         YeeA==
X-Forwarded-Encrypted: i=1; AJvYcCXHsUMSxpenLAWC8yiQ+Cj1PMPrIR+Cq/lIcPSuYZuG9lGAQEF7u4nFId5fi0Jj54L26ZM6kptIiVoxB84=@vger.kernel.org
X-Gm-Message-State: AOJu0Yynv+CbHK8cg84v+9woqZXPQpU6phSKmGh5B/ZZ2Q2cKSA9OqQM
	4dWpmRxRZe1WPu/8Sii4uk72AUG+lbb7IdXKAJggwr0gtI6EW3DT
X-Google-Smtp-Source: AGHT+IElTykgnhe8E0i8WlwpzDwud6Ln632DjXpuzr5XGiDVXlSq/38dAGkSi7tGDayg61wiBQtnpQ==
X-Received: by 2002:adf:fa46:0:b0:37c:cc4b:d1d6 with SMTP id ffacd0b85a97d-37d5ff8e817mr13362222f8f.27.1729077429077;
        Wed, 16 Oct 2024 04:17:09 -0700 (PDT)
Received: from Max.. ([176.12.137.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37d7fa7a13bsm4040153f8f.13.2024.10.16.04.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 04:17:08 -0700 (PDT)
From: Max Brener <linmaxi@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Max Brener <linmaxi@gmail.com>
Subject: [RESEND v2] ext4: Optimization of no-op ext4_truncate triggers
Date: Wed, 16 Oct 2024 14:16:24 +0300
Message-ID: <20241016111624.5229-1-linmaxi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219306
v1: https://lore.kernel.org/lkml/20240926221103.24423-1-linmaxi@gmail.com/T/

Changes from last version: Moved vfs-level changes to be ext4-level,
and improved the description of the patch.

This patch enables skipping no-op 'ext4_truncate' calls. Analyzing the kernel
with ftrace shows ext4_truncate is being sometimes called without making any
impact, and sometimes userspace programs might call ext4_truncate in vein. By 
detecting these calls and skipping them, cpu time is saved.

I'll fix this by skipping ext4_truncate call in 'ext4_setattr' when the file's size
hasn't changed AND it hasn't been truncated since the last disk space preallocation.
It is meant to consider the case when ext4_truncate is being called to truncate
preallocated blocks too. Notice that so far, the condition to triggering 
ext4_truncate by the user was: if (attr->ia_size <= oldsize) which means it is
being triggered when attr->ia_size == oldsize regardless of whether there are
preallocated blocks or not - if there are none, then the call is redundant.

Steps:
1.Add a new inode state flag: EXT4_STATE_TRUNCATED
2.Clear the flag when ext4_fallocate is being called with FALLOC_FL_KEEP_SIZE flag
to enable using ext4_truncate again, to remove preallocated disk space that may
have resulted from this call.
3.Set EXT4_STATE_TRUNCATED when ext4_truncated is called successfully.
4.Don't skip ext4_truncate in ext4_setattr when the size of the file has either been
reduced OR stayed the same, but hasn't been truncated yet. This is in order to allow
truncating of preallocated blocks.

Signed-off-by: Max Brener <linmaxi@gmail.com>
---
 fs/ext4/ext4.h    | 1 +
 fs/ext4/extents.c | 4 ++++
 fs/ext4/inode.c   | 6 +++++-
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..34128a88e88f 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1915,6 +1915,7 @@ enum {
 	EXT4_STATE_VERITY_IN_PROGRESS,	/* building fs-verity Merkle tree */
 	EXT4_STATE_FC_COMMITTING,	/* Fast commit ongoing */
 	EXT4_STATE_ORPHAN_FILE,		/* Inode orphaned in orphan file */
+	EXT4_STATE_TRUNCATED,		/* Inode is truncated */
 };
 
 #define EXT4_INODE_BIT_FNS(name, field, offset)				\
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 34e25eee6521..b480c29dfc65 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4782,6 +4782,10 @@ long ext4_fallocate(struct file *file, int mode, loff_t offset, loff_t len)
 		ret = ext4_zero_range(file, offset, len, mode);
 		goto exit;
 	}
+
+	if (mode & FALLOC_FL_KEEP_SIZE)
+		ext4_clear_inode_state(inode, EXT4_STATE_TRUNCATED);
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
-- 
2.43.0


