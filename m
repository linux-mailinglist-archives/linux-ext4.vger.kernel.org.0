Return-Path: <linux-ext4+bounces-7701-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A92C5AAB2CE
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 06:30:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C509016D80B
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 04:28:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B27F736BB16;
	Tue,  6 May 2025 00:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hv/VyZr2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDA636EF2E;
	Mon,  5 May 2025 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746485863; cv=none; b=biZB9GhJ16FOGhXj7rlyY6J0O+Mu9vU1vb9D8Krqu47VDLJYp6ClMnZ3Cvzqh/72PDwirgv/6jwKt8KNsvtLGLfK417w0jblei1H9fIR/udr57HFudNQm2HobvwV/avJ4wvoiFTuFy4ZJW8ADc2yHwnxxVtWE0glNli1+0PTxw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746485863; c=relaxed/simple;
	bh=u9jwbzTddMvDD1UzyjrxvTqlENFVGks2J67kdf+mvbQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=n7kjupDdZVBRH9aFeJ7cMv+9vEN/54JzNIjWJ9OPvWY1ei9spWu4keEtWSg5osMmEnyo6p+x2T2E94MuquHgNsV7DXX6J+3NFYEukn2NBEEL7qXcODu/aZB/oYFodOfj8riXeLlDGEOvju8Zt5WLmyjezALDdqKXV2JVp9Z5BkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hv/VyZr2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53376C4CEED;
	Mon,  5 May 2025 22:57:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746485862;
	bh=u9jwbzTddMvDD1UzyjrxvTqlENFVGks2J67kdf+mvbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Hv/VyZr2ivHM84oUKwo0P4IKJZCDlSFdKHoZPoYkzgzV0llkCFqBynmvLXtPKPD9A
	 g7QsPWWvPjAsYGVLdkxzIpcaOa6JHT0AfYB9HeZ5Fxk6AO1quDoHJfI6K289ORvFDC
	 CeoLjgMSi/8p2+kVMiG0ppKWkkaLeBwhKNK4CCnUyN4rIqttpKoQvFgP7hXqzCe1pz
	 qVwDdcxA0Y96S5pzcHRodfxvo8MgF7Q6ORZV5N3sQ12wXY6SsvUwque+6g/IIhbxAB
	 DCUzfbRu93eRsUemD3+m0bNVwpLgp93s2Vkzmtk+aGiJkNN0TkIEGKs6I8rY55kkXM
	 44U5FR5u7YYcQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Nicolas Bretz <bretznic@gmail.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 035/294] ext4: on a remount, only log the ro or r/w state when it has changed
Date: Mon,  5 May 2025 18:52:15 -0400
Message-Id: <20250505225634.2688578-35-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505225634.2688578-1-sashal@kernel.org>
References: <20250505225634.2688578-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.89
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
index 751c879271e05..3dcaf06ada364 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -6771,6 +6771,7 @@ static int ext4_reconfigure(struct fs_context *fc)
 {
 	struct super_block *sb = fc->root->d_sb;
 	int ret;
+	bool old_ro = sb_rdonly(sb);
 
 	fc->s_fs_info = EXT4_SB(sb);
 
@@ -6782,9 +6783,9 @@ static int ext4_reconfigure(struct fs_context *fc)
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


