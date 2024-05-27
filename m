Return-Path: <linux-ext4+bounces-2654-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35668D0879
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 18:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55BFB330F0
	for <lists+linux-ext4@lfdr.de>; Mon, 27 May 2024 16:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E3815A85D;
	Mon, 27 May 2024 16:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pWSJrdzm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF42615A841
	for <linux-ext4@vger.kernel.org>; Mon, 27 May 2024 16:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716826500; cv=none; b=WZAGSfyjidWu8K7xJopWp3JNqJrBl4JJo1LAbHnaJUxDofWnS+4YieSpL1soVLU6Ji6Z2J1afRb7a3d1ZdlOJrG9WQd7FG3sP5EbTByXjPUfZ7f44UA+B0MA/Noe/fScqutCwjZcGnhMPbmKs6GZHV1ap/tfBDKTPdEg5WqC/Ds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716826500; c=relaxed/simple;
	bh=mDqPw03z1INldEN1n/0pBYaeYCz5BWHtTiuNavY06ms=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eohkDbGm7Rsz9O8ikCMZSCIUEqvrZdZZpjBThFfpTsRFOAmixX9GHoZzt92EPNRapGbNW939WteJR+Q1IUMQ1HlHVKiI2pwSJBjzEccxEMYByXFakXmPPqVSWm+2y427oIGBBn+Y+YoCFY3PiDiKFU/G9LSlGToA5K7HpR/O7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pWSJrdzm; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Envelope-To: tytso@mit.edu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1716826496;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=iolobSHI8WMmsdMwomRdpBAacDRAgxWFZ/JZJ8XKCOs=;
	b=pWSJrdzmTsL+rcs0OUzCeWZ9lDoZxaF7xvuPYH5vBSih5bVVfElbMocVISYIk9PY36sjy/
	0YsTfYx7HxkUL5GavaZ61Vz7zXsPgXK5vq/YSZNddF7oAGCN+ror3P+WflOIgm7XykqR6S
	2n1rE8PmZjnwaJRVXUy1MA9D1HqKoIs=
X-Envelope-To: linux-ext4@vger.kernel.org
X-Envelope-To: adilger@dilger.ca
X-Envelope-To: linux-kernel@vger.kernel.org
X-Envelope-To: luis.henriques@linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Luis Henriques (SUSE)" <luis.henriques@linux.dev>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"Luis Henriques (SUSE)" <luis.henriques@linux.dev>
Subject: [PATCH] ext4: use ext4_update_inode_fsync_trans() helper in inode creation
Date: Mon, 27 May 2024 17:14:47 +0100
Message-ID: <20240527161447.21434-1-luis.henriques@linux.dev>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Call helper function ext4_update_inode_fsync_trans() instead of open
coding it in __ext4_new_inode().  This helper checks both that the handle
is valid *and* that it hasn't been aborted due to some fatal error in the
journalling layer, using is_handle_aborted().

Signed-off-by: Luis Henriques (SUSE) <luis.henriques@linux.dev>
---
 fs/ext4/ialloc.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index e9bbb1da2d0a..9dfd768ed9f8 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -1336,10 +1336,7 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		}
 	}
 
-	if (ext4_handle_valid(handle)) {
-		ei->i_sync_tid = handle->h_transaction->t_tid;
-		ei->i_datasync_tid = handle->h_transaction->t_tid;
-	}
+	ext4_update_inode_fsync_trans(handle, inode, 1);
 
 	err = ext4_mark_inode_dirty(handle, inode);
 	if (err) {

