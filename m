Return-Path: <linux-ext4+bounces-7442-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D911FA995A6
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 18:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9D143B9A54
	for <lists+linux-ext4@lfdr.de>; Wed, 23 Apr 2025 16:43:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDBC283C82;
	Wed, 23 Apr 2025 16:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z0NkUkM1"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C72E27FD71;
	Wed, 23 Apr 2025 16:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745426640; cv=none; b=o6BdYyoch/Q7yKVacyCe+2kXoD+g3PxdxSQgjLP3/S3ZQxTgG0AZBiDM/6kANzuMFc7c2CSvr6FLP5hE3kq9wbBdYVDdo3GH1XDuU395t2K9HsNMRa46s9o/xAbmNZNJN4Gkm7KPHJ3vcJvki03sA3lJfCYhc9kBCjbalPEmVxM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745426640; c=relaxed/simple;
	bh=TmsFT/k12epNq9WbCUQlZuVOv21gEQBz/+cdNiERNiI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vm2MprSue0OtOfNpMMgzr9NJFwI2hxctYy9wI6j8BI/WSgj9ZSdpisRp+VBHsiny9Kpu1ZxJNkimQ1xMf1iqFVl/RS6BXalEZY2Fov+8LdUwKpC4ruYPxXIC0R5xZPGzq9MnrnweBMQpUI3ZGX5reGvhjcNKmGtFf5YEo5E4iZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z0NkUkM1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C83C4CEE2;
	Wed, 23 Apr 2025 16:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745426639;
	bh=TmsFT/k12epNq9WbCUQlZuVOv21gEQBz/+cdNiERNiI=;
	h=From:To:Cc:Subject:Date:From;
	b=Z0NkUkM1gS05G7ZhhzLOynJtCcpxr1SUirwv5yFZ7WT3+MXuhtT9zBzxL2n/DgF/A
	 h70A1xojccbukVxLejEoR1ovHnh5A9nWRYSPQGt2Rv0tPBKFeGrxmk2cU/9uu/US5X
	 ydx25KmOJdURwmv726dCeInBVLuX9ml2RRwT7KvICwMowis+/fXZz3b/K5uEAt1bHH
	 qsL7FfEIR3KcEFNKZDlmMOHEKK4gkCuEo5mnsL+6jyUcCK8xKzQ9nEFjnnnws0iBHD
	 Cjwjav15sZu4fLYeIvKZQiHT/rgZf14D8rR1LTHp7DJb0AAFdMBAJVQtxjVZSAlvFj
	 e9gUeFfeGtDlg==
From: Arnd Bergmann <arnd@kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Jan Kara <jack@suse.cz>,
	Zhang Yi <yi.zhang@huawei.com>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Matthew Wilcox (Oracle)" <willy@infradead.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Shida Zhang <zhangshida@kylinos.cn>,
	Baokun Li <libaokun1@huawei.com>,
	Jann Horn <jannh@google.com>,
	Brian Foster <bfoster@redhat.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: avoid -Wformat-security warning
Date: Wed, 23 Apr 2025 18:43:49 +0200
Message-Id: <20250423164354.2780635-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

check_igot_inode() prints a variable string, which causes a harmless
warning with 'make W=1':

fs/ext4/inode.c:4763:45: error: format string is not a string literal (potentially insecure) [-Werror,-Wformat-security]
 4763 |         ext4_error_inode(inode, function, line, 0, err_str);

Use a trivial "%s" format string instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 94c7d2d828a6..3cfb1b670ea4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -4760,7 +4760,7 @@ static int check_igot_inode(struct inode *inode, ext4_iget_flags flags,
 	return 0;
 
 error:
-	ext4_error_inode(inode, function, line, 0, err_str);
+	ext4_error_inode(inode, function, line, 0, "%s", err_str);
 	return -EFSCORRUPTED;
 }
 
-- 
2.39.5


