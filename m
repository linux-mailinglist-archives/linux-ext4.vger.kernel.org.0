Return-Path: <linux-ext4+bounces-7694-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A682FAAADDB
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 04:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A7F7B852A
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 02:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 841F736AD13;
	Mon,  5 May 2025 22:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="txlV3Jd4"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFCC3299512;
	Mon,  5 May 2025 22:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746484957; cv=none; b=rtnOmTf4QYAC0vqC4Qt2pZTxWkxdZ9AdECHZvwibdU2ZI9DtSV7yBCJQoxz5V5YfHHuuENbly9iQ43JMdlGp6+OMt9qPZvpWUqjEo0aP2xIWm+CluP+jATPN3gKu+Y2vw2CO9ptptDu8DSf1vA4xFKv9e2CGVKrvd2kN0ynbB4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746484957; c=relaxed/simple;
	bh=IFxjyUy9p939cgdSn8JtjShI/xj2DKazY5LneB9PH38=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GdKiWHeiNXAwL2KHyp48rGKF2Y4eweoSFpk26QrSkfdjZx+IwhjbK7qqXUcGohIS/7YEAavPeTOxsvu8iyB59a25i08BdDLRSEGreHFWBl+lNBqflm1crf3gkHFESIterbmoFm2qDMm8SQCbuN2PwPS3Q92b4YEnVmoC1cxlrB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=txlV3Jd4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE14C4CEF1;
	Mon,  5 May 2025 22:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746484955;
	bh=IFxjyUy9p939cgdSn8JtjShI/xj2DKazY5LneB9PH38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=txlV3Jd4iSQqHQrncond5Z6YvFtiBAKjyYalXB1PDBLJbARVFALVUnSYKncqpXjPZ
	 KfyUpnSpSZkjTKGXUR8ns/XEUBGOH7pNujay4R2yphANFXQ8gLw72Bh/uRQZhdJ8/X
	 xW/z37V91eiktZ8U3h1Szet1MiiQ6ffGJKLITIKbjCy1qqV1AUzIMLapBTELHSU15Z
	 1OSt+GfSHw7jF0TpNfql5pBWTQjtUvVcFDPgKU2RT6SEoY8GydRprLX9bn6VdesMKw
	 eQNnmy+lCXeSbxxJyuiQrcnCKqGPrMQug+k+x42A8pnClOxyh//PWe4hNCR29QMi5L
	 yzamakSwdPdLw==
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
Subject: [PATCH AUTOSEL 6.12 094/486] ext4: reorder capability check last
Date: Mon,  5 May 2025 18:32:50 -0400
Message-Id: <20250505223922.2682012-94-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505223922.2682012-1-sashal@kernel.org>
References: <20250505223922.2682012-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.26
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
index 8042ad8738089..c48fd36b2d74c 100644
--- a/fs/ext4/balloc.c
+++ b/fs/ext4/balloc.c
@@ -649,8 +649,8 @@ static int ext4_has_free_clusters(struct ext4_sb_info *sbi,
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


