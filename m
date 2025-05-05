Return-Path: <linux-ext4+bounces-7682-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 554FBAAA006
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 00:30:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8667F5A25C5
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 22:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100E028D84E;
	Mon,  5 May 2025 22:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kcyPNwU0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8F828D843;
	Mon,  5 May 2025 22:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746483396; cv=none; b=mFSknwRyX/sXKnCC3ijY+wjKmcslvqHwVGHJgMa7Ryqesq2ZSy0PLu1HiWBn4HYdlg0XgT+9EclSJ/2HNwDNDUnIkE6uXG7fsSOQklwbmIFpV4Ek8xFXNxEpoFb3hHXmgS5o6DNmXRISsZi5nlw53F+lm9IbTns9k2fs99krieM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746483396; c=relaxed/simple;
	bh=J8t5wHVimioW6jdedFeKGkej2xj8eRQ2qTZAFje5udc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=DMEooDHUTIbLYqyZu12pxI9iPUpO59iiIW1CWLkWBWmUFVvom7NgwWjI07vZO16h0KdCBEFQaCDHl3tUrVi+HQnOISE36QcTJluPcgrqutd1FIvqKRVYzhDhwrQKXmVUk7Yj5GdZ8mR8sE+IN/tTx6v7qNYXW/k/+phfyWyF8MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kcyPNwU0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8E1C4CEE4;
	Mon,  5 May 2025 22:16:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746483396;
	bh=J8t5wHVimioW6jdedFeKGkej2xj8eRQ2qTZAFje5udc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kcyPNwU0H2gnpAlNASP1+BvfOXxwCCngDL8964c1j80Wyy9MzDc9Hb3x2TNCI3ihE
	 I4sK1wg1C9MOGn6+SVwORBqJZZ3YMTk2b2ociGotlclsrwLDlLr/YCxXhLkY0SY3eJ
	 jpOUUuvB78yhDFuzJhPgZtFooYMpVQTXU73Bkg+VnkCJd4CQJd1e0AbCKvMeFrct/y
	 Ze2ChzRfn06enkzI8M08CPmIHtMu2oFy/Xgc8E2ZNKxGsG0ByKus/zZAUoVnQYqjYd
	 D6rz6BpCKoHw5CgFSi5MSd5Ftk2QLqrriJ87ypLH/PLoDm4NnK6p+fooEuZMVWDfEB
	 U5aY1koUKhJaw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolas Bretz <bretznic@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.14 065/642] ext4: on a remount, only log the ro or r/w state when it has changed
Date: Mon,  5 May 2025 18:04:41 -0400
Message-Id: <20250505221419.2672473-65-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505221419.2672473-1-sashal@kernel.org>
References: <20250505221419.2672473-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.5
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
index 528979de0f7c1..b4a02be2eacf6 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6776,6 +6776,7 @@ static int ext4_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	int ret;
+	bool old_ro = sb_rdonly(sb);
 
 	fc->s_fs_info = EXT4_SB(sb);
 
@@ -6787,9 +6788,9 @@ static int ext4_reconfigure(struct fs_context *fc)
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


