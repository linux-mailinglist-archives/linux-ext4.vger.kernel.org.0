Return-Path: <linux-ext4+bounces-4950-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 112F19BC18B
	for <lists+linux-ext4@lfdr.de>; Tue,  5 Nov 2024 00:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F8B7B219DA
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Nov 2024 23:43:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36EEF1F755C;
	Mon,  4 Nov 2024 23:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="a5P5+jZv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C593188703
	for <linux-ext4@vger.kernel.org>; Mon,  4 Nov 2024 23:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730763797; cv=none; b=accXJun6ddY8lymw0nnhq4aBZnPi72kvjqW8R0PeIrs0NeHDpXP8WqNVCJFhfAI5BkWeVRhkW5JNEBZxs2zHs13VZnpItuLjHA5DDOUhvs8AEGMLKoVIkDQ1NoyS2VbcJGtNCGQ+E1GPgsE2hnK1bOzJP4vqThN51SZ/AzSO250=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730763797; c=relaxed/simple;
	bh=NTrgsxER1+7QIxrTxfrD4cJG/eY1xGd/3xVLkEsiYsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dtcVkpqGzqp8C/n03jw7UfSz7EeDH5aFH3U58Q3dJactYhlfgI+WUfEegCEcyxDoZZ3/C6qzvFkFq8vT6uwh6m0SPLlgRUKKI/4QXx6805r9oFUotI9lNz5dud7ceduG0tVF9IJlXwHStZypzg/YbhWNTuKnZp/CiJbzdTh4jJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=a5P5+jZv; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1730763793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=WupKgLk/g34nk7lN15EZ9LyedA501TFFTjkXVizzcRg=;
	b=a5P5+jZvnyU48j6Ljz71yQn+KJB3NZfwIUkHGy2kDvytoxVm8zYJjHOJRoZ9/EXn0JDaSt
	AoK7fEfbpIUaS8tMaSkO2DBpQsVCJ9vpuJ4oYe88XYcp445bRT4TU0gZocWeEqHtYToB/x
	E5ZAostBI7ZH+h6SK3NWRlHIms0dtOA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	Jan Kara <jack@suse.cz>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [RESEND PATCH] ext4: Annotate struct fname with __counted_by()
Date: Tue,  5 Nov 2024 00:42:14 +0100
Message-ID: <20241104234214.8094-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add the __counted_by compiler attribute to the flexible array member
name to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Inline and use struct_size() to calculate the number of bytes to
allocate for new_fn and remove the local variable len.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 fs/ext4/dir.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/dir.c b/fs/ext4/dir.c
index ef6a3c8f3a9a..02d47a64e8d1 100644
--- a/fs/ext4/dir.c
+++ b/fs/ext4/dir.c
@@ -418,7 +418,7 @@ struct fname {
 	__u32		inode;
 	__u8		name_len;
 	__u8		file_type;
-	char		name[];
+	char		name[] __counted_by(name_len);
 };
 
 /*
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


