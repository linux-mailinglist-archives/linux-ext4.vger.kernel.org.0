Return-Path: <linux-ext4+bounces-255-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CC8E7FFFD2
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 01:01:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEA951C20E86
	for <lists+linux-ext4@lfdr.de>; Fri,  1 Dec 2023 00:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB7323B4;
	Fri,  1 Dec 2023 00:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="J9Wt3+rb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0262F10E2
	for <linux-ext4@vger.kernel.org>; Thu, 30 Nov 2023 16:01:32 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cfc3f50504so14209005ad.3
        for <linux-ext4@vger.kernel.org>; Thu, 30 Nov 2023 16:01:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1701388891; x=1701993691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=arIMxU37dbDVcw6BpH7gjsXqk1oe1757Hrz6w+RV4XM=;
        b=J9Wt3+rbkGFEurRWWyaF0cjgUORT6nPAFZaNOU/Qt9jtIwBmjV9RjO1tDN4JZ/yvuE
         yLs+RgXcKILjTSBySzKYYiGvbi19mYIOYNyLnzRDjJv8+Tq4cTZ3aHLmOW+yTGm5dq7N
         Low6sbpgk7AZzqTOsUVT+7TPAry2gG8DUJnEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701388891; x=1701993691;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=arIMxU37dbDVcw6BpH7gjsXqk1oe1757Hrz6w+RV4XM=;
        b=fAfl6aAxaQ8K3GLwTVzJj0P6OsFRxxnOgSKUD8UMBdVlZsDEHO/QyR9HN2PDqA8BJB
         Vj2DpOtjhgublEADDD82qPiHxBZ+XkTsXozarYOq1WpQtWMA26IeOQMxzYcmKXdK7njT
         poJbVwLlW/NaYfed5xSb0GJr+ux6eGtWXLSHpdw0RrCv41fBwLL/7dA5mShoaK+gBtHu
         DUqHwbpzGhGIR/pnkSezUEhzlDexbfPVViHpNsKGVY0IhTDv6/ilexP1dAVGPFfL9r2s
         2uwD7u+2Sr3A4BfKFbzer5Zs3HpBXvCvr2uDUaTAJd3UUGWzpGKQjjkw0Z+t2+OFE4XN
         qvAg==
X-Gm-Message-State: AOJu0YzatJm6sIJTpUiffD/5SKxIQF+Sx7DOJ09JAjygpeZIzYzREHw3
	CKxi1LzPyufc7q7daZ6EybsrroP1rQJZR5VPSGg=
X-Google-Smtp-Source: AGHT+IGMtbvfHQ2SxzbNTXtdqmFB1PqNqS9BvSK9rJyfrdoaoIuow9AIaNvYJ+bD2zBLqC93XkqXVw==
X-Received: by 2002:a17:903:244e:b0:1cf:de3e:e4df with SMTP id l14-20020a170903244e00b001cfde3ee4dfmr15404710pls.58.1701388891470;
        Thu, 30 Nov 2023 16:01:31 -0800 (PST)
Received: from localhost ([2620:15c:9d:2:9c5:c4c7:575c:87d6])
        by smtp.gmail.com with UTF8SMTPSA id u9-20020a17090341c900b001cfce2bf4aesm1998399ple.6.2023.11.30.16.01.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Nov 2023 16:01:31 -0800 (PST)
From: Brian Norris <briannorris@chromium.org>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org,
	Brian Norris <briannorris@chromium.org>
Subject: [PATCH] lib/ext2fs: Validity checks for ext2fs_inode_scan_goto_blockgroup()
Date: Thu, 30 Nov 2023 16:01:18 -0800
Message-ID: <20231201000126.335263-1-briannorris@chromium.org>
X-Mailer: git-send-email 2.43.0.rc2.451.g8631bc7472-goog
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We don't validate the 'group' argument, so it's easy to get underflows
or crashes here.

This resolves issues seen in ureadahead, when it uses an old packfile
(with mismatching group indices) with a new filesystem.

Signed-off-by: Brian Norris <briannorris@chromium.org>
---

 lib/ext2fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/lib/ext2fs/inode.c b/lib/ext2fs/inode.c
index 957d5aa9f9d6..96d854b5fb69 100644
--- a/lib/ext2fs/inode.c
+++ b/lib/ext2fs/inode.c
@@ -313,6 +313,9 @@ static errcode_t get_next_blockgroup(ext2_inode_scan scan)
 errcode_t ext2fs_inode_scan_goto_blockgroup(ext2_inode_scan scan,
 					    int	group)
 {
+	if (group <= 0 || group >= scan->fs->group_desc_count)
+		return EXT2_ET_INVALID_ARGUMENT;
+
 	scan->current_group = group - 1;
 	scan->groups_left = scan->fs->group_desc_count - group;
 	scan->bad_block_ptr = 0;
-- 
2.43.0.rc2.451.g8631bc7472-goog


