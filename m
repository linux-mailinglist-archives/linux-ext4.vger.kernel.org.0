Return-Path: <linux-ext4+bounces-7707-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EC75AAB4C9
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 07:15:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 646887B6AEA
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 05:12:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 364212F2C50;
	Tue,  6 May 2025 00:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EN5Nd2Mt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9344A28983B;
	Mon,  5 May 2025 23:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746486867; cv=none; b=YvPUutW6kZAQcb81fotsSPVVw7NfPWYDzdY2gjJDjOCxCVJiZonqThJX23C1gX1vs6MlDG8BzfafPbqOiMP577EDQmrMi6FVLUd2uxq0LsCWc9Y7krOkUXCc2u543ab097Z09lv3jRBiWNSfr5nIr2zhh2Mt0X6pYESpDfzHuj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746486867; c=relaxed/simple;
	bh=BFGZvz3m0NrOmtEShPyDLDmAHNH1RMEpCvqr26JPKEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LugkWSnM9qgNt7TMiNIWPUfeiU72aGc3zjxC68jTuPsVyEaALb5rJiN/zns/0z7ceftogyeNXATAveX2OBcCy935mI1zloWoCUS1cSxbmoPLkmBkKV34PhmF/KsZHqbv170XMX5iE8A61SZ7weKoGiaTUOpV9QArhN3JFJu6jws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EN5Nd2Mt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EC30C4CEEF;
	Mon,  5 May 2025 23:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746486866;
	bh=BFGZvz3m0NrOmtEShPyDLDmAHNH1RMEpCvqr26JPKEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EN5Nd2MtAeJkuJwauvQbnLn/xGSpef9t22WqLmj6aAHTGXtVwzcB/dDYAdpm4WceY
	 NVfdSvrgK4+j9/AV0B6+6ByTFYJPVBFQ37xtsE//fh5fYwswF0JDaFfCKtYJiqX1s/
	 E00uaG6L8295mv289KjsnxGdsYvJBDwe1/ggxJy0Sg46qWmswTjYEw69nPrn89H+iM
	 bWoRuys8MP3FyAOG9vyycvdXWf7oZ1kcV2D2RY48kEeIOoFOnRKqdSZlijj3ZqtyU0
	 vHWItSzSPgqfEL2DdhgZrKRAqh6EodzezmnRSovNereVd4fm18f91HJQ946A6It6ba
	 svyPd8NqzG1EA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
	Serge Hallyn <serge@hallyn.com>,
	Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 033/153] ext4: reorder capability check last
Date: Mon,  5 May 2025 19:11:20 -0400
Message-Id: <20250505231320.2695319-33-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231320.2695319-1-sashal@kernel.org>
References: <20250505231320.2695319-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.181
Content-Transfer-Encoding: 8bit

From: Christian Göttsche <cgzones@googlemail.com>

[ Upstream commit 1b419c889c0767a5b66d0a6c566cae491f1cb0f7 ]

capable() calls refer to enabled LSMs whether to permit or deny the
request.  This is relevant in connection with SELinux, where a
capability check results in a policy decision and by default a denial
message on insufficient permission is issued.
It can lead to three undesired cases:
  1. A denial message is generated, even in case the operation was an
     unprivileged one and thus the syscall succeeded, creating noise.
  2. To avoid the noise from 1. the policy writer adds a rule to ignore
     those denial messages, hiding future syscalls, where the task
     performs an actual privileged operation, leading to hidden limited
     functionality of that task.
  3. To avoid the noise from 1. the policy writer adds a rule to permit
     the task the requested capability, while it does not need it,
     violating the principle of least privilege.

Signed-off-by: Christian Göttsche <cgzones@googlemail.com>
Reviewed-by: Serge Hallyn <serge@hallyn.com>
Reviewed-by: Jan Kara <jack@suse.cz>
Link: https://patch.msgid.link/20250302160657.127253-2-cgoettsche@seltendoof.de
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/balloc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/balloc.c b/fs/ext4/balloc.c
index c23ac149601e5..d6872b71657b6 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -637,8 +637,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
 	/* Hm, nope.  Are (enough) root reserved clusters available? */
 	if (uid_eq(sbi->s_resuid, current_fsuid()) ||
 	    (!gid_eq(sbi->s_resgid, GLOBAL_ROOT_GID) && in_group_p(sbi->s_resgid)) ||
-	    capable(CAP_SYS_RESOURCE) ||
-	    (flags & EXT4_MB_USE_ROOT_BLOCKS)) {
+	    (flags & EXT4_MB_USE_ROOT_BLOCKS) ||
+	    capable(CAP_SYS_RESOURCE)) {
 
 		if (free_clusters >= (nclusters + dirty_clusters +
 				      resv_clusters))
-- 
2.39.5


