Return-Path: <linux-ext4+bounces-4489-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C63990D02
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 21:01:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6ED3281C63
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Oct 2024 19:01:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57D1B221E3B;
	Fri,  4 Oct 2024 18:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dxGcgkGq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B882022F8;
	Fri,  4 Oct 2024 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728066327; cv=none; b=DVafpq/zrnRXFy5V3oph9uTNG+zmlWDmcWfBx9Ct3PncieZux0INhP1q6LCEHPPpQhDhl8rm/Yozuwyhe+ZXcCF16MT0+OVo0V5z/a/5zIxeddRR5fTtBn53BGS2YEY7r6MXteRafheQn5p9w0ZdUjoEWiYfllQzEucPYofu4L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728066327; c=relaxed/simple;
	bh=4jToFmSIR5aDlyoRs9BnwTV29M77Ck1lRKUTkVyMIHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fd+X6cR8SmrwbL3exnPwydY34ZOBxf3fQDvYe8fU4VUDnS2tYIR7wJPESe0dDHJTOEtwH8+fKfOr2CFbFoRA/F2/VmlXOThyqBcK9hmMSvZZqzAxOwDh97Pnq/HBLvsdppG7+m2FHaRMVAJw2KOuNOHPzzXhRc4OrtynweRcos8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dxGcgkGq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D51B4C4CECC;
	Fri,  4 Oct 2024 18:25:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728066326;
	bh=4jToFmSIR5aDlyoRs9BnwTV29M77Ck1lRKUTkVyMIHI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dxGcgkGqaSQzi0lZAPaSuKZVB87ETksKegZWf27GGEI5k3KC9RZrfPQioipmf5Z6A
	 vxLL5GA3+m3DbRu1ILdB0t6ERAn5Ghz+tybIcJlnyf/1xRsW1rQKOleynynv0PCkl+
	 xEj6oTDe0w0tSxmKg3xL4XRe1aMYrgbCPunQeD+VEbWhOiQ+LwAu0kzlE4xxn6u1nB
	 OgZ3OO18PV5KOC6Z3z2goW+15NDji/9zYsNjWk/IpumN2b5Tl8i9y+Pvh5YzVtR7im
	 sqZEfXTHdrxBRSCxCRc8iaSlQaypDP29CGrDTL25ddcxFKx3pnUl1IV/5adNLMipZG
	 hnZWX7BZkOxug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Christian Brauner <brauner@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 13/58] ext4: don't set SB_RDONLY after filesystem errors
Date: Fri,  4 Oct 2024 14:23:46 -0400
Message-ID: <20241004182503.3672477-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241004182503.3672477-1-sashal@kernel.org>
References: <20241004182503.3672477-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.54
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
index 5baacb3058abd..b7d8abef2beba 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -744,11 +744,12 @@ static void ext4_handle_error(struct super_block *sb, bool force_ro, int error,
 
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


