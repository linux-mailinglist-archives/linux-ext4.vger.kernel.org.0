Return-Path: <linux-ext4+bounces-3533-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 499BB941EDD
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 19:34:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD05C1F21C57
	for <lists+linux-ext4@lfdr.de>; Tue, 30 Jul 2024 17:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83D2A189915;
	Tue, 30 Jul 2024 17:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="Zrin0xiK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B441A76BC
	for <linux-ext4@vger.kernel.org>; Tue, 30 Jul 2024 17:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722360876; cv=none; b=Zc0J0Hh9JihH0uM95kjF3ob/3CHRcKOB/NWjtg7RkhQsC00BGyCogcyNJpuSV6PQGZhiKGRI3OEkVFkUNUM0ac5sFLF0pFzPSO3WJtUWCr/Kf0ZGkn8248OxWZ2jrOMxtee7NUGgIQ5MNuqIMm7v8G9diRFp1v0nmIsRs11hAoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722360876; c=relaxed/simple;
	bh=p4cubfFpB4SwjUmGePnpy0zwIKgF0IzXbZRFMcEdeaU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bumUaIyO8NcV5YTXnQ04ExC7ye9xTD+yr5M2nApDaxKo5n3a/WgyHOoYYZOcJaf0Lq0gfm9Vrc79jrY8s11Vx8dkKWddvmvB/6RvnGCxsC7u0du8MqPmBR0gFkMjs0zcNK1QdQ/0pWJXmSJFwf3zTmNbgf8f5lbns5hiA2Z5H7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=Zrin0xiK; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5a3b866ebc9so6761052a12.3
        for <linux-ext4@vger.kernel.org>; Tue, 30 Jul 2024 10:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1722360873; x=1722965673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oI4YVy1BXwYbNcruHIdCKsyVSQdrOcNz4/HMxfsnW/Q=;
        b=Zrin0xiK9gSZCT2kuhoZ1VhIZwOoW/x1jUBLvhfHYYgcsQ/bFYRtn+vDBL+cP+ovAq
         b6/kb/x0fa+JauIobVXN9FjJpiX66tUZq+Wl5gNn6QQzVmzQVBy1DafEf3u8qqi5FZzQ
         j+qCu7TvcDdDq82q/Ug8mX+ZCmqM9uBBsQUTyxIk5rV0wBwPZ4+kGr9v4RNRaR3Kd8XF
         qEfFk+/XrFeHyCHv7N3/ULu3H3oRWA8UQltptBRXdecWlyssH0tefof/+DIFf3Efe1AS
         bdKZcJXNx6mBdEciIPyBQ2HOjSgZzNH5AT6naUaL02dn/EY6mV60x4sX3joktZH910kd
         XEMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722360873; x=1722965673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oI4YVy1BXwYbNcruHIdCKsyVSQdrOcNz4/HMxfsnW/Q=;
        b=kTyCIl8R/eielmlQViqa/LSC1Oi68Hj3BlDxb5swHSfCVgT0Ft+Sc8raO3d0lM3vw5
         UO0dMn7C0TdXTD1nexhp35OXC0l4v4ucEoipvhjSCvj49K0zD3zrWktK0fwAFg4m8muZ
         iy8tmhp8IL/Z/PbM65UUIv4cNskHok7Gp+e7aXMC4m3cOX81u+C4ez8y8GiWn1gRCfQR
         BEw7Z1YAYp0DwJSmfuTMY3JxPaGpN0FmOaNZjwFRuxIWtpiWUH6kRRcccSW4thGAL0p1
         CZIdpE7T639yctKp4gBmFg72y5WHMJh2qp3O2hoK5xbsSBxC8mlZC1CJc/38vW48s3vb
         7TPg==
X-Gm-Message-State: AOJu0Yy/SQ7hUZEXn/6Tpg1XD/52XC/+0RuTvYrA7P9fYpgOJ0A15H4G
	U1BZXyJ541xw+y4QCZ4tEXUTMxp9N/EqafC797zDoMAorulvfXmo7P143bHheOA=
X-Google-Smtp-Source: AGHT+IHZR4OPtXkjQVGXyuC91BDI4+TPmGIfln1ZTQtGyV3RvpF1pKaboUyR1fA81F7p4NVEO9MKkw==
X-Received: by 2002:a50:cdd0:0:b0:5aa:2a06:d325 with SMTP id 4fb4d7f45d1cf-5b02000c114mr7252627a12.7.1722360872841;
        Tue, 30 Jul 2024 10:34:32 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-26.dynamic.mnet-online.de. [82.135.80.26])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac655996fasm7404532a12.84.2024.07.30.10.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jul 2024 10:34:32 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	kees@kernel.org,
	gustavoars@kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH v2] ext4: Annotate struct ext4_xattr_inode_array with __counted_by()
Date: Tue, 30 Jul 2024 19:23:04 +0200
Message-ID: <20240730172301.231867-4-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the __counted_by compiler attribute to the flexible array member
inodes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Remove the now obsolete comment on the count field.

Refactor ext4_expand_inode_array() by assigning count before copying any
data using memcpy(). Copy only the inodes array instead of the whole
struct because count has been set explicitly.

Use struct_size() and struct_size_t() instead of offsetof().

Change the data type of the local variable count to unsigned int to
match the struct's count data type.

Compile-tested only.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Adjust ext4_expand_inode_array() as suggested by Gustavo A. R. Silva
- Use struct_size() and struct_size_t() instead of offsetof()
- Link to v1: https://lore.kernel.org/linux-kernel/20240729110454.346918-3-thorsten.blum@toblux.com/
---
 fs/ext4/xattr.c | 20 +++++++++-----------
 fs/ext4/xattr.h |  4 ++--
 2 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 46ce2f21fef9..b27543587103 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2879,11 +2879,10 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
 	if (*ea_inode_array == NULL) {
 		/*
 		 * Start with 15 inodes, so it fits into a power-of-two size.
-		 * If *ea_inode_array is NULL, this is essentially offsetof()
 		 */
 		(*ea_inode_array) =
-			kmalloc(offsetof(struct ext4_xattr_inode_array,
-					 inodes[EIA_MASK]),
+			kmalloc(struct_size_t(struct ext4_xattr_inode_array,
+					      inodes, EIA_MASK),
 				GFP_NOFS);
 		if (*ea_inode_array == NULL)
 			return -ENOMEM;
@@ -2891,17 +2890,16 @@ ext4_expand_inode_array(struct ext4_xattr_inode_array **ea_inode_array,
 	} else if (((*ea_inode_array)->count & EIA_MASK) == EIA_MASK) {
 		/* expand the array once all 15 + n * 16 slots are full */
 		struct ext4_xattr_inode_array *new_array = NULL;
-		int count = (*ea_inode_array)->count;
+		unsigned int count = (*ea_inode_array)->count;
 
-		/* if new_array is NULL, this is essentially offsetof() */
-		new_array = kmalloc(
-				offsetof(struct ext4_xattr_inode_array,
-					 inodes[count + EIA_INCR]),
-				GFP_NOFS);
+		new_array = kmalloc(struct_size(*ea_inode_array, inodes,
+						count + EIA_INCR),
+				    GFP_NOFS);
 		if (new_array == NULL)
 			return -ENOMEM;
-		memcpy(new_array, *ea_inode_array,
-		       offsetof(struct ext4_xattr_inode_array, inodes[count]));
+		new_array->count = count;
+		memcpy(new_array->inodes, (*ea_inode_array)->inodes,
+		       count * sizeof(struct inode *));
 		kfree(*ea_inode_array);
 		*ea_inode_array = new_array;
 	}
diff --git a/fs/ext4/xattr.h b/fs/ext4/xattr.h
index bd97c4aa8177..e14fb19dc912 100644
--- a/fs/ext4/xattr.h
+++ b/fs/ext4/xattr.h
@@ -130,8 +130,8 @@ struct ext4_xattr_ibody_find {
 };
 
 struct ext4_xattr_inode_array {
-	unsigned int count;		/* # of used items in the array */
-	struct inode *inodes[];
+	unsigned int count;
+	struct inode *inodes[] __counted_by(count);
 };
 
 extern const struct xattr_handler ext4_xattr_user_handler;
-- 
2.45.2


