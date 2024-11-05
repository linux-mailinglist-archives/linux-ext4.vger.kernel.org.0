Return-Path: <linux-ext4+bounces-4960-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A9439BCA88
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 11:34:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82071F226CE
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 10:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F98F1D2B34;
	Tue,  5 Nov 2024 10:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jQnA1uty"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6BEB1CC881
	for <linux-ext4@vger.kernel.org>; Tue,  5 Nov 2024 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730802887; cv=none; b=EwdU/FTfLnMRcLm1TleiYBzWKU7GCKjQjo6qURntyc6aOvxOz4sCpNlj+pEvdQQJU6GtVUUwbNMhUzi2t6xYj4Ka6X63VmcWOtxm7u3H+dIWyCqHruAlmrv5jpeCTzPSaqESkY02kI+nLYoVzCSaA0M+zKoV1PU9VvkiDgkFG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730802887; c=relaxed/simple;
	bh=o19pOLVRuV8QLxfVNynlAUR3xvLHuQpqYZTC4QqMP9o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JAPPFnMizyaSrnv/OvCO4V8JL9y6t+yGqXOyfOeFtLS/vSS4BnC5YznblaeNPSuC+Ki39m73mlEXihVzFnVBd0MapRnEsFIH0ncoMT02dODn0DQRa7aKafmOoXF1+/t8msb83+aQNaBYG9Z1Pt+b6+T7kfF7hHbixDAot7cSJj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jQnA1uty; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730802882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6IhfWc24TP3aBHz+VeNS6qFTszlyYP3fBuPWQXFnk1I=;
	b=jQnA1uty0Hub5qO8V1aykRd1R518d12EIIDmgXMjRZFja35zFIXJ8j5dqZmZg6llfQ38tv
	uYPRNtz1K4s3zgh1YcbUHD+jFVlBGDjmgOWldEVgE0lgih80Z355hY684xYU3v5t0FKl28
	7FAsUrIntRRTDVifktoLBxoTgtR9PgA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Greg KH <gregkh@linuxfoundation.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: Use struct_size() to improve ext4_htree_store_dirent()
Date: Tue,  5 Nov 2024 11:33:54 +0100
Message-ID: <20241105103353.11590-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Inline and use struct_size() to calculate the number of bytes to
allocate for new_fn and remove the local variable len.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
This change was originally part of another patch that was split into two
separate patches after feedback from Greg KH
- Link: https://lore.kernel.org/r/20241104234214.8094-2-thorsten.blum@linux.dev/
---
 fs/ext4/dir.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index 233479647f1b..02d47a64e8d1 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -471,14 +471,13 @@ int ext4_htree_store_dirent(struct file *dir_file, __u32 hash,
 	struct rb_node **p, *parent = NULL;
 	struct fname *fname, *new_fn;
 	struct dir_private_info *info;
-	int len;
 
 	info = dir_file->private_data;
 	p = &info->root.rb_node;
 
 	/* Create and allocate the fname structure */
-	len = sizeof(struct fname) + ent_name->len + 1;
-	new_fn = kzalloc(len, GFP_KERNEL);
+	new_fn = kzalloc(struct_size(new_fn, name, ent_name->len + 1),
+			 GFP_KERNEL);
 	if (!new_fn)
 		return -ENOMEM;
 	new_fn->hash = hash;
-- 
2.47.0


