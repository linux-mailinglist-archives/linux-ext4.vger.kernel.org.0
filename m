Return-Path: <linux-ext4+bounces-9804-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFB8B41D1E
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Sep 2025 13:31:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0CF9D7B27AE
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Sep 2025 11:29:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B20392DCF65;
	Wed,  3 Sep 2025 11:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ABX3j5Xq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E328D2C11EC
	for <linux-ext4@vger.kernel.org>; Wed,  3 Sep 2025 11:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756899034; cv=none; b=GqQfK9x1oIqcuC4h2fdTfKhOzeppAXJZDzdZ23Ydd0rhBRkUDrjq3GfrvePqh0gKOVEXyWZLPXORb12n+gxMQfgGaZZoFGfpSkXwB7WLoqPJbChgH3PeoeF/zpuwPO/UGGafnZJo/7qMNAfn6z0+9TtCTPxHQlNikFIlcN66Zyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756899034; c=relaxed/simple;
	bh=B/cFIOEA84pH8P+zWXj0czwJYRCHIsbDVkAXMg8pmnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NV5jDVL4uQDt1cIHBVKqwS8A8lSjnyqrp9u/9qoG5Eiwc8/D64NGUxakizNHknEeRDCKQ0QM7yLbZsWuTA5kQgw5AF/7d0Xewl8irNvRUaCLXvIxmMfnRohVrT46etjOap24/YFqkdOSfPuS8K/r3KEkQ+PCjqRBQX7RJhp2RJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ABX3j5Xq; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso4189456a12.0
        for <linux-ext4@vger.kernel.org>; Wed, 03 Sep 2025 04:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756899032; x=1757503832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yutFf3IespzGrSu0kd63HlJYzzZKIkt8NwKkpdeSqI=;
        b=ABX3j5XqwYhjlEyNjnAB9g2rlE/QwIUMzclKI3c3SN3XJVV+hTDFrYJBvw8UMY8SS6
         cem6aANn1QQzUNR0g9u6KkKPIoybirr4ZbX/sCuIWnjeRjffeMex91+EExkcHtV7lPzf
         sHaKCEQ+4VigfVknV0N0NAmPYIE4OHxDh2mnPp+vP2neIep3NLZ8wJrcSCKCV3e1vYmb
         TQhW1XMns1CPqqJfevGGoO/A7XtKku+oNP3+zXBQU0g7g7JdMlIas6eDrbO2CE0fYYg4
         lbsflvjOH3AWrAEAGSFnFqL8HOdzeR7BnuqJX8xcIdFghij1RJvgw9eMERDCRvVLNyuq
         LW3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756899032; x=1757503832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yutFf3IespzGrSu0kd63HlJYzzZKIkt8NwKkpdeSqI=;
        b=jjwwtARX5iYm0siEAzaeZIEFP9UFZqikQ8ZxQE4xLPPJmvGPczogEigAGxqF/xww/z
         PiHuJjGrbolfrm2kTWmbVKnAwVEPs3M2BZd0kSdoo0aAqyBjgG9VxmOpUToJZBq7iTKl
         N+8DYK98a75j5J4GClRV7krMUUnf9yzka+cudAz5XnwYwJ3AymkcjXoNdfE0gOXXo1WP
         pbs1HS/4B2TRVq6GZ6Z4THgt4LMr/KqTksjsdJe6toaC+sa3RK4dCdVq3/VuIz6RoG7K
         x+bEhaP3m205SPqMyxDLgCgBQK7H0W6qdorZ+8jZXHY616mg5WSd9xP6AskUyUNAXaHx
         SBmQ==
X-Gm-Message-State: AOJu0YyXcj19K0RSnBHIYpStCZ2ix5GSrbDjcS+NMJ6XzRBPUnG5FfQE
	uFEh5rMIo2dIxFVo6jomhOmgDowGA+SoZerGRZKZURtH97nTkKd8v1YTT4c0lQ==
X-Gm-Gg: ASbGnctK790fufy9NQ/mlk/RQE3qeC4Om8/A0bGm/vM6b5HtNyPMyHyNBW15n4DwzBv
	B42SUMFc1nTQ4mGMfa6b2QhCttf4qNf0qkwDXWUndSnb6IY2+7nbLlZRfbF1E8+ivXu0dXncakM
	DxLlsGbEvlkrYFMQxtK7Ro0IWCF73dlq5OIV+RxLdrgpXtzuuDOXXdebucxkiRbNkUdionYbvEv
	HG5ZVQ7FX8R66STfuHnqZ/fO7pax9kZGtmp9IKjEHNisAk8jaVha48Fhp4QJWiVTguEE+wnYWju
	DDGYUsTPj/0+396JSw1FMDzojF+mPUjNglkx2lPDyS1Fkd4Nkgh/Ka373apGPZR59XXFs6iW8+q
	Cex2/J+5tUMams6wX3O5bRFcbxfMk/suUMubAKNpbHcTsSgK7tkQ=
X-Google-Smtp-Source: AGHT+IGrAAlXt7SVct+ogRrFLJsOZskrZOxrcxKAEBRqensYPgplvXn1qiDrs9AnyW5oLSxTM09Z9A==
X-Received: by 2002:a17:902:d4cb:b0:249:2318:7a2d with SMTP id d9443c01a7336-249448f6e79mr178199995ad.19.1756899031941;
        Wed, 03 Sep 2025 04:30:31 -0700 (PDT)
Received: from DebHP.lan (67-61-129-104.cpe.sparklight.net. [67.61.129.104])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3278f881f21sm10610318a91.2.2025.09.03.04.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 04:30:31 -0700 (PDT)
From: Nicolas Bretz <bretznic@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	Nicolas Bretz <bretznic@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3 RESEND] ext4: clear extent index structure after file delete
Date: Wed,  3 Sep 2025 04:30:27 -0700
Message-ID: <20250903113027.261912-1-bretznic@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extent index structure in the top inode is not being cleared after a file
is deleted, which leaves the path to the data blocks intact. This patch clears
this extent index structure.

Extent structures are already being cleared, so this also makes the
behavior consistent between extent and extent _index_ structures.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220342

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507210558.sazSHcm1-lkp@intel.com/
Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
---
Changes in v2:
- corrected function name. Due to my incorrect use of git, attempting to ammend only the message led to code changes being reverted, after building successfully.
Changes in v3:
- corrected sparse: restricted __le16 degrades to integer
---
 fs/ext4/extents.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b543a46fc809..17591a99dafd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2822,6 +2822,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int depth = ext_depth(inode);
 	struct ext4_ext_path *path = NULL;
+	struct ext4_extent_idx *ix = NULL;
 	struct partial_cluster partial;
 	handle_t *handle;
 	int i = 0, err = 0;
@@ -3060,6 +3061,9 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		 */
 		err = ext4_ext_get_access(handle, inode, path);
 		if (err == 0) {
+			ix = EXT_FIRST_INDEX(path->p_hdr);
+			if (ix && le16_to_cpu(ext_inode_hdr(inode)->eh_depth) > 0)
+				ext4_idx_store_pblock(ix, 0);
 			ext_inode_hdr(inode)->eh_depth = 0;
 			ext_inode_hdr(inode)->eh_max =
 				cpu_to_le16(ext4_ext_space_root(inode, 0));
-- 
2.47.2


