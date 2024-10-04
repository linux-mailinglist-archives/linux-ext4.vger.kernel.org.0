Return-Path: <linux-ext4+bounces-4484-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD61F990CE2
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 20:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 50EBCB25F6C
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 18:43:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8D601F2F52;
	Fri,  4 Oct 2024 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEgh5bKg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 756191F2F44;
	Fri,  4 Oct 2024 18:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066148; cv=none; b=N7OGVOoAwEJfloVfkkQZCjn0IJdKNXtJKzDLsoIDd982ukITVHuLBmLnNr26pl48/lhT06bOAU67R8cA1O59PNiPUKqc+GpZrjJyiAwCO0zzFv54OgKakN5q5qrT2QfEme7IATZgaIYr0HSMdEsDmlsDctIHkHS/Rhm90i9Grso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066148; c=relaxed/simple;
	bh=qpYx8OjX7ycSGpl7GFmz/VnJk/uHyp/q0kLf2J/2q2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lQnSNqe0U5sWFAr57V7P1zdyqYchtLR/tg3/a2vccYGoaiX7vvWWz/0L29ix3VEul5blIiJlg5a+Nqqu7Hsw4p/HK8QjNw5yD1giMTp8Hq+gup+3oUCm5Q0d3sWLVaPoZQsoX4l925KVlXAryaPpF9nf8H56q701mV84kZt+6cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEgh5bKg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70EB5C4CEC6;
	Fri,  4 Oct 2024 18:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066148;
	bh=qpYx8OjX7ycSGpl7GFmz/VnJk/uHyp/q0kLf2J/2q2w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TEgh5bKgFFrSSyG6hh+iASICkzxmUAhguT5/wMNA3VPMOzk5NK94Wqlxgg1nhhRJl
	 flCFhD4h7DUvxoOC1cwXhj5h68H5yp9Y/HY/UmGU7Dsx5kHZ56geYDvaEquf1EW/gq
	 1hSqAnQoHKy4Y0Jbn4aUrAZvUq4NV2k/W5F4427bVAkfYQQyojsf2CH39VuAGfyNXs
	 3Meeh7IjQmbvc79nj4xzJM07FuMfbDffwjfpc2ByyAQm3hABn55+6QMK1/B8L2XLBF
	 G/t6YBz1VqHznD3xJzWq1mkqxuFwzyNKgK8R4/4gA6+4ViDzav407B5rrHVzFfiFbe
	 EOXdtGB0UoaVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.10 15/70] ext4: don't set SB_RDONLY after filesystem errors
Date: Fri,  4 Oct 2024 14:20:13 -0400
Message-ID: <20241004182200.3670903-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182200.3670903-1-sashal@kernel.org>
References: <20241004182200.3670903-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.13
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit d3476f3dad4ad68ae5f6b008ea6591d1520da5d8 ]

When the filesystem is mounted with errors=remount-ro, we were setting
SB_RDONLY flag to stop all filesystem modifications. We knew this misses
proper locking (sb->s_umount) and does not go through proper filesystem
remount procedure but it has been the way this worked since early ext2
days and it was good enough for catastrophic situation damage
mitigation. Recently, syzbot has found a way (see link) to trigger
warnings in filesystem freezing because the code got confused by
SB_RDONLY changing under its hands. Since these days we set
EXT4_FLAGS_SHUTDOWN on the superblock which is enough to stop all
filesystem modifications, modifying SB_RDONLY shouldn't be needed. So
stop doing that.

Link: https://lore.kernel.org/all/000000000000b90a8e061e21d12f@google.com
Reported-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner <brauner@kernel.org>
Link: https://patch.msgid.link/20240805201241.27286-1-jack@suse.cz
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index c682fb927b64b..307083e519034 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -735,11 +735,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 
 	ext4_msg(sb, KERN_CRIT, "Remounting filesystem read-only");
 	/*
-	 * Make sure updated value of ->s_mount_flags will be visible before
-	 * ->s_flags update
+	 * EXT4_FLAGS_SHUTDOWN was set which stops all filesystem
+	 * modifications. We don't set SB_RDONLY because that requires
+	 * sb->s_umount semaphore and setting it without proper remount
+	 * procedure is confusing code such as freeze_super() leading to
+	 * deadlocks and other problems.
 	 */
-	smp_wmb();
-	sb->s_flags |= SB_RDONLY;
 }
 
 static void update_super_work(struct work_struct *work)
-- 
2.43.0


