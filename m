Return-Path: <linux-ext4+bounces-4884-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A5F9B8B6D
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 07:52:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB5251F22F9F
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Nov 2024 06:52:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE542156641;
	Fri,  1 Nov 2024 06:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkxNDBZw"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36B9D1537C3;
	Fri,  1 Nov 2024 06:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730443882; cv=none; b=h/a1J1Hw8xGdDMd8tTVOgIeTuCJu1kyLftv4zJMz6MSeqNwMF5VTJU1iZEAVeIxA8sh7xm8mwkXCbwcM1omudn7RCSFfmPYICKDr9TA0tLwzS6/OAqEq1GP+Js9IhgoBHXoG+1SFUtKGtcp2bzAvB6455sCWc1jpX3/DobMmFOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730443882; c=relaxed/simple;
	bh=XzIQSlbT8rZmBw3jJxXtpbWGqfQwKAZXOe5cMvAo3qI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WtPoxAPd5bVssPWoQjmqRyCQ19Ry/tggCRFfBemAa7SfSGMv+kaPr6QAHh17yjxWBzR95KDezhLq++FwhyweQpVXVpe5KPgbMIvOUdFWjfqMhGsjeYs5/8a+fwgtsVEGh9isChuIFzotNO/E+maUBxbv1hFttatUBPH5F0AYTQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkxNDBZw; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-71e4e481692so1483305b3a.1;
        Thu, 31 Oct 2024 23:51:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730443878; x=1731048678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PNXaDbmxIS4sXKRquKzQnAi7UjzkGcD7RoMFUnjDnvo=;
        b=KkxNDBZwM3AX8lcYhuKdnVOGqHGUL5Z1UUQ2Mok60FwlB9FCC+vu6DYI+U6/2bxU71
         x/ER0yitVhhGEIOlnwLc+K/v29rC8+3zQTV0+Rtg3bANk+Gv/31Zrp1Tc3X+ltYz4vwy
         +2xamQy/6aobj4SlwWYbyCLeAa8xUm5ZNh2XxOVACfHYBrRmM00chcHc4MYjMN68eF+4
         ALhFTN8zRI8hn+DalC8oVIbCG7JO6T6DvOWN417RnQFmadaMRkRf6vWkBasYwtI4pLd6
         0TjQJvpT1AyNO5uc/HOVi/nIHPQk/XPKXrvym3iTufa4NaWxuG4CCBciqpgoo4OREfQY
         69JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730443878; x=1731048678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PNXaDbmxIS4sXKRquKzQnAi7UjzkGcD7RoMFUnjDnvo=;
        b=k8+UyU1x8h6XopAASSgF3YoxYkAZzDUxbttOVS1C1cxo6+81qy2I3+Da0Xbs1s/J+I
         GnMzS2WJuVFTM9vTxknxhYy/RAE+Ow8V9ayFd41//XC/hH9k6ECoN+eLDAZKg92fKBE+
         GTKs1T+apEhdDWN06n0aa9LoB8Qbl6f0DP9Q48XoYsICURjhO3DYuC72bXMEd7PWN9lh
         spM1rSqxqDNkIOww+nT72REwJBt7f/C56NdLLfqNlFDLPRaqncD9Tpy+SBKfvU2k1xrN
         G48BBvMJgg8IWsTG1o5SXcOoNIRpPNodLSYrP9j1RfMvG75g67SWzbEizhyvyK9f60WX
         tJvg==
X-Forwarded-Encrypted: i=1; AJvYcCVGhcng7ltrXOkVvMbsL6WcQY7qgkT5uT5x6E/ECVSzJEHH0paOwfurxo31b8+EAAVTH1ivIcWJ2eB3UK6h@vger.kernel.org, AJvYcCXPpoUh6HtNSckEuYIOq5y4PyPmwuoR6paMEvJ3ia7K1/NVxGwOK0y0HVJIDLode0DgFgCxA4ofa4s/@vger.kernel.org, AJvYcCXWzOKWuRHUuI53CKakwmm/Fch5KbWq0HNKHqhthxqY70gPSP/swZMMhkaqiKynej5xKueL+9ElZ9dSMlAu@vger.kernel.org
X-Gm-Message-State: AOJu0YydVKkEepWdKVFNYiHanrLnjQbvE5yP5xB4EwNCcx8IVqIqw1OZ
	J55yrYLy3o4MskkgehgT/gScuES64M60ScDVY2IQd7XdDiweXrtkdgwKcA==
X-Google-Smtp-Source: AGHT+IHpeWg1bGGPI18ov4OULTnEjFNA06hTJbNl6qrrOrsjsc4z2X/5qMaK+Q2uB8S6AAZYjiog+A==
X-Received: by 2002:a05:6a00:3d51:b0:71e:cd0:cc99 with SMTP id d2e1a72fcca58-720c98a1bfamr4162715b3a.4.1730443878422;
        Thu, 31 Oct 2024 23:51:18 -0700 (PDT)
Received: from dw-tp.ibmuc.com ([203.81.243.23])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-720bc1b8971sm2196209b3a.12.2024.10.31.23.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 23:51:17 -0700 (PDT)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.cz>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@infradead.org>,
	John Garry <john.g.garry@oracle.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Dave Chinner <david@fromorbit.com>,
	linux-kernel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH v4 1/4] ext4: Add statx support for atomic writes
Date: Fri,  1 Nov 2024 12:20:51 +0530
Message-ID: <0517cef1682fc1f344343c494ac769b963f94199.1730437365.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.1730437365.git.ritesh.list@gmail.com>
References: <cover.1730437365.git.ritesh.list@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds base support for atomic writes via statx getattr.
On bs < ps systems, we can create FS with say bs of 16k. That means
both atomic write min and max unit can be set to 16k for supporting
atomic writes.

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/ext4.h  | 10 ++++++++++
 fs/ext4/inode.c | 12 ++++++++++++
 fs/ext4/super.c | 31 +++++++++++++++++++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/fs/ext4/ext4.h b/fs/ext4/ext4.h
index 44b0d418143c..494d443e9fc9 100644
--- a/fs/ext4/ext4.h
+++ b/fs/ext4/ext4.h
@@ -1729,6 +1729,10 @@ struct ext4_sb_info {
 	 */
 	struct work_struct s_sb_upd_work;
 
+	/* Atomic write unit values in bytes */
+	unsigned int s_awu_min;
+	unsigned int s_awu_max;
+
 	/* Ext4 fast commit sub transaction ID */
 	atomic_t s_fc_subtid;
 
@@ -3855,6 +3859,12 @@ static inline int ext4_buffer_uptodate(struct buffer_head *bh)
 	return buffer_uptodate(bh);
 }
 
+static inline bool ext4_inode_can_atomic_write(struct inode *inode)
+{
+
+	return S_ISREG(inode->i_mode) && EXT4_SB(inode->i_sb)->s_awu_min > 0;
+}
+
 extern int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 				  loff_t pos, unsigned len,
 				  get_block_t *get_block);
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 54bdd4884fe6..3e827cfa762e 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -5578,6 +5578,18 @@ int ext4_getattr(struct mnt_idmap *idmap, const struct path *path,
 		}
 	}
 
+	if ((request_mask & STATX_WRITE_ATOMIC) && S_ISREG(inode->i_mode)) {
+		struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
+		unsigned int awu_min = 0, awu_max = 0;
+
+		if (ext4_inode_can_atomic_write(inode)) {
+			awu_min = sbi->s_awu_min;
+			awu_max = sbi->s_awu_max;
+		}
+
+		generic_fill_statx_atomic_writes(stat, awu_min, awu_max);
+	}
+
 	flags = ei->i_flags & EXT4_FL_USER_VISIBLE;
 	if (flags & EXT4_APPEND_FL)
 		stat->attributes |= STATX_ATTR_APPEND;
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 16a4ce704460..ebe1660bd840 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4425,6 +4425,36 @@ static int ext4_handle_clustersize(struct super_block *sb)
 	return 0;
 }
 
+/*
+ * ext4_atomic_write_init: Initializes filesystem min & max atomic write units.
+ * @sb: super block
+ * TODO: Later add support for bigalloc
+ */
+static void ext4_atomic_write_init(struct super_block *sb)
+{
+	struct ext4_sb_info *sbi = EXT4_SB(sb);
+	struct block_device *bdev = sb->s_bdev;
+
+	if (!bdev_can_atomic_write(bdev))
+		return;
+
+	if (!ext4_has_feature_extents(sb))
+		return;
+
+	sbi->s_awu_min = max(sb->s_blocksize,
+			      bdev_atomic_write_unit_min_bytes(bdev));
+	sbi->s_awu_max = min(sb->s_blocksize,
+			      bdev_atomic_write_unit_max_bytes(bdev));
+	if (sbi->s_awu_min && sbi->s_awu_max &&
+	    sbi->s_awu_min <= sbi->s_awu_max) {
+		ext4_msg(sb, KERN_NOTICE, "Supports (experimental) DIO atomic writes awu_min: %u, awu_max: %u",
+			 sbi->s_awu_min, sbi->s_awu_max);
+	} else {
+		sbi->s_awu_min = 0;
+		sbi->s_awu_max = 0;
+	}
+}
+
 static void ext4_fast_commit_init(struct super_block *sb)
 {
 	struct ext4_sb_info *sbi = EXT4_SB(sb);
@@ -5336,6 +5366,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 
 	spin_lock_init(&sbi->s_bdev_wb_lock);
 
+	ext4_atomic_write_init(sb);
 	ext4_fast_commit_init(sb);
 
 	sb->s_root = NULL;
-- 
2.46.0


