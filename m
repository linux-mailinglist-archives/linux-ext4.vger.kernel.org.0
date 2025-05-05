Return-Path: <linux-ext4+bounces-7690-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4455FAAA8C4
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 03:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30C5F460BF3
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 01:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC905353F02;
	Mon,  5 May 2025 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oBHIN++N"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7A6353EF3;
	Mon,  5 May 2025 22:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484862; cv=none; b=ioRQ/K3zpta1twYlMcB0FTWsOBigLtsLY3QsCum4FSqOt152xb5wlgsENyJU025weNiXznlIDAKOTGj9fkg6yKJo6jOwH4f5GbGq29qZwyNI34PQv8FuIgNp8O+aZvWJusna3vEy6CXkahFppl7L2wgUzyNhqxR+2KRzWKV9Ilo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484862; c=relaxed/simple;
	bh=aeeRXgWCasVVyC48wq3JvzqBE/tzCK00JI53QCn9HrM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DGSbgzlfqxL+1kux3StRERwhZ8t46SAd288n2OZuJX9i5Cyrb9li2xIz8tDoIl0EeGLeg255qH1W5j/NFt8G2gFPzoaDxr//vtMQC9XY7/tuvNRzYIMTtDXkCk22xDeI0iSlFHD7/oPz+rb+8+LOyXOvY7mxY7HVi461qgE0uaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oBHIN++N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60553C4CEE4;
	Mon,  5 May 2025 22:41:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484862;
	bh=aeeRXgWCasVVyC48wq3JvzqBE/tzCK00JI53QCn9HrM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oBHIN++NUfPu66917h5qjEboB8LiRI8IeufJrKI+sJh9iMZ09F2lEzXDfFU5fGeyq
	 RINZ4EYLqDbvpcCGhEFYZq/Zz4+ol5H7QTU5LM3UOxBaCGYGD5J/Ww+E2GwGS6nV92
	 hPniu1twd8Iz1omKDgVLiz2qRIsu/CcLNn50hdCXhb87TeAc9lllhIzH9I24M5szNg
	 vQzuoE68TIUBeQYtt7RUU7ZZCW4ohJig7ITpmfwmkJuJ2MB23W+2h8SBKxQWWePOyQ
	 7rqkOgzdMrhBmdxRjynwKXaD3vTFprFwPplUK5N4p+2x7hj03dghY0gGI3JrhFCcPw
	 b6Id2KUG4tBSg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolas Bretz <bretznic@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.12 053/486] ext4: on a remount, only log the ro or r/w state when it has changed
Date: Mon,  5 May 2025 18:32:09 -0400
Message-Id: <20250505223922.2682012-53-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
Content-Transfer-Encoding: 8bit

From: Nicolas Bretz <bretznic@gmail.com>

[ Upstream commit d7b0befd09320e3356a75cb96541c030515e7f5f ]

A user complained that a message such as:

EXT4-fs (nvme0n1p3): re-mounted UUID ro. Quota mode: none.

implied that the file system was previously mounted read/write and was
now remounted read-only, when it could have been some other mount
state that had changed by the "mount -o remount" operation.  Fix this
by only logging "ro"or "r/w" when it has changed.

https://bugzilla.kernel.org/show_bug.cgi?id=219132

Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
Link: https://patch.msgid.link/20250319171011.8372-1-bretznic@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 4291ab3c20be6..473909c4a3784 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6744,6 +6744,7 @@ static int ext4_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	int ret;
+	bool old_ro = sb_rdonly(sb);
 
 	fc->s_fs_info = EXT4_SB(sb);
 
@@ -6755,9 +6756,9 @@ static int ext4_reconfigure(struct fs_context *fc)
 	if (ret < 0)
 		return ret;
 
-	ext4_msg(sb, KERN_INFO, "re-mounted %pU %s. Quota mode: %s.",
-		 &sb->s_uuid, sb_rdonly(sb) ? "ro" : "r/w",
-		 ext4_quota_mode(sb));
+	ext4_msg(sb, KERN_INFO, "re-mounted %pU%s.",
+		 &sb->s_uuid,
+		 (old_ro != sb_rdonly(sb)) ? (sb_rdonly(sb) ? " ro" : " r/w") : "");
 
 	return 0;
 }
-- 
2.39.5


