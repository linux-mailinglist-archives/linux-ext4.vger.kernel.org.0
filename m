Return-Path: <linux-ext4+bounces-7698-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A4582AAAD15
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 04:29:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 84043169928
	for <lists+linux-ext4@lfdr.de>; Tue,  6 May 2025 02:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1FE627AC2B;
	Mon,  5 May 2025 23:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EPxL7RU3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B6963AC5BB;
	Mon,  5 May 2025 23:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746487147; cv=none; b=VFocgKyjd/dil+ZVb5z8dqlamvzOR4YUfheYDcBhr6H9ts/59AGrYDIxcE5EEBsw7NIM2k/Qb+9HgqGwBoMhN6iylv1WFyN5VSNCdRnARlpYK+vaC4h3Im3F4IXO+cwHqSvmFlPg+QEifwqegY0eAIRZLBVpCzxnuVyvFugDAKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746487147; c=relaxed/simple;
	bh=BTt9wdCdkMMxv2z5W4YZDt3b0Jb03I2bFhWiEi/7tfw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uONO5Hkcw1pQAvW2geP7DVsMT1deDK+UjAWRdGsMP2OvISWosg+PO2xN8Kk/Eh7lkwC1s0z7s5yscguIRzQ3cT4TOkTXyNmNshIx9plCsVvhsZhecCAQ2lEo6oSaRtPdcxHTeouNtbXGfkEyxyca6aTPBnSp5gneGDqsXpY6vB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EPxL7RU3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 492B8C4CEE4;
	Mon,  5 May 2025 23:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746487147;
	bh=BTt9wdCdkMMxv2z5W4YZDt3b0Jb03I2bFhWiEi/7tfw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EPxL7RU3NqoCtVt36CsCXf1cpshlTzH2az69GCsyPldH4SOSucTQLnSHqEvs716Ds
	 HggeZ3jJxn0a9t1hpP8H72q5QqiqeycPADLiwJdm2oboiV9KKBYJp4nE9/falYtutj
	 DtAoKueIVpalYDcIHlef3wVsb6+SNpN6X/th/npmFsPuzwzCMhSYEiP1O4jDLy+siB
	 5UVUmE5lmXmuK/peyI/cmh4fNogD9cyRtD5F9shr0PJxyMu8gQ0k2efOIzQC+9XWXO
	 /Nc6pgjCVWJ+E6/LbBc1m2QinX23A1XQLQg9kLVMBItnasMKwhL7Q6yoes7yqqI8cd
	 Sa/g5w6eTeTgA==
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
Subject: [PATCH AUTOSEL 5.10 024/114] ext4: reorder capability check last
Date: Mon,  5 May 2025 19:16:47 -0400
Message-Id: <20250505231817.2697367-24-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250505231817.2697367-1-sashal@kernel.org>
References: <20250505231817.2697367-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.237
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
index bdbf130416c73..be267cd9dea75 100644
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


