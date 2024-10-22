Return-Path: <linux-ext4+bounces-4714-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5554D9A9B89
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 09:54:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1431F231E8
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Oct 2024 07:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE1F51547E3;
	Tue, 22 Oct 2024 07:54:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sQMtidzE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC51547C0
	for <linux-ext4@vger.kernel.org>; Tue, 22 Oct 2024 07:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583642; cv=none; b=nHH0WF/t/QX1IKMb7I5DyK3tCYge7b3vGs/QnT5XHC3SWnpTe50ayRFwD3dJqnT2wN7+ghSgUTAsrVi58uIp/YvriYK7GIk9MKIE7lWGvOLHyEaYBr3Gp4WimeMas2QbNcpECwJlnUaW6HFebKRVJ2aALdsgUDNC+LgmYdDMKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583642; c=relaxed/simple;
	bh=iIIvTHgFWcs4L02/4PWh5iLiyHx6s9FXGG4F2p+omkw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=VC5Xj3H2BbrmcZj6h18Dsdrcrs38kMQZ02nwnJM5TZsk+M4N0UcLG3uQeUowAleIuDF6fthooR+9TgnAjtrB/jHJkeFZYuTOygARyCOkTjvfp9BWHAQJRSCuTW0N0nwgef3tokFiD/p+UWALcYqq+BRb1BXn7+1nn3jKPTv49HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sQMtidzE; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1729583638;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=eN7/9lTFH3drC1NWRnwey0aE0NlX+JngFZv69nq9QD4=;
	b=sQMtidzEIgmJgfB4MOqXPEDgbF8UHLgWB4G8GKBRRafgQsNnE9DFDOoR/EmH5sgV4MHSxC
	mUpY9pJMvcXI1PxVTF6j3qnl3cT5T7SGgJH4ec8W+VrxdHvvJUiPQiECVntIGD0AUfa+Eg
	W84vVGkgTwPWsyd5qyHI6GFiKQJ9oF4=
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
Date: Tue, 22 Oct 2024 09:52:53 +0200
Message-ID: <20241022075252.34308-2-thorsten.blum@linux.dev>
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

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Jan Kara <jack@suse.cz>
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


