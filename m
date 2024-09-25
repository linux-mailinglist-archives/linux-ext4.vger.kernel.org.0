Return-Path: <linux-ext4+bounces-4302-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5046985BE5
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 14:34:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3B921C23DFF
	for <lists+linux-ext4@lfdr.de>; Wed, 25 Sep 2024 12:34:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA181C9858;
	Wed, 25 Sep 2024 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oHqTd0Xv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B4FC1C8FDE;
	Wed, 25 Sep 2024 11:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727265197; cv=none; b=PTLzEfvaBdf1+sE3w4EpHpUv03LX1Df5W76Uk+8POOyrzQy6EdnricunxqHj3n2OOQUihDiINXwJajuqPWucOxhOerOHScCcscKUlDK13moHp2juCdpI6jouRSNNUZmuOv6vzBmRa5zD3DESbw43Whvi7xVx5NwzzKFUip/T5oc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727265197; c=relaxed/simple;
	bh=Ojw17ZKKk24T123yUv+cpDUl/xs1NIQdfQQaxYTjnmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eGFqD21nahqDzRZ30a8pdCHDi3aZsBdOj8/tDo+RIZbLU8DkL4JgWKWL4OhTSTeQ4Qw9QFKtqARMnK9j+KkgUFYTT0KGpI5pYtFPWjIlkNEWwedfJORU/0ww4MgDsxOiBa8gHM4I8aTfD4nKP9i5HFlWk8sHqUPQO/h9gnceL60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oHqTd0Xv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA32BC4CEC3;
	Wed, 25 Sep 2024 11:53:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727265196;
	bh=Ojw17ZKKk24T123yUv+cpDUl/xs1NIQdfQQaxYTjnmw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oHqTd0XvP3jvrOOZ4fZSivf+r1cppMRMENTftwgXaoxCZmv1L3pNDxPLuuXIp1p8A
	 KBGfLzzZaX4zzmVwSxbdGUSzi26geFSpGOKkZwLLLPkG+z3AS/Djd0gB5Qmvdzxr0C
	 g01Z3etDUicj7jXjAp/PdUrE32d2w7iqqRtLJ2ZE4NmQw/lHBdlVSGmNyvjiujyoeH
	 S4fyLEE3hEYrUG1InreAjkbnA42ktWUJS+K1LMRBTbnepc5pNGFadMpS6fvTTsHrOC
	 XP8u5/8T/ql0mKhlZRgw+Yp9W9MWzzEO6RjOLkKRql8SJgAAejBV/T6hjoCdoiPyOq
	 HNdAeuHa3pArg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lizhi Xu <lizhi.xu@windriver.com>,
	syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 234/244] ext4: filesystems without casefold feature cannot be mounted with siphash
Date: Wed, 25 Sep 2024 07:27:35 -0400
Message-ID: <20240925113641.1297102-234-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925113641.1297102-1-sashal@kernel.org>
References: <20240925113641.1297102-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11
Content-Transfer-Encoding: 8bit

From: Lizhi Xu <lizhi.xu@windriver.com>

[ Upstream commit 985b67cd86392310d9e9326de941c22fc9340eec ]

When mounting the ext4 filesystem, if the default hash version is set to
DX_HASH_SIPHASH but the casefold feature is not set, exit the mounting.

Reported-by: syzbot+340581ba9dceb7e06fb3@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
Link: https://patch.msgid.link/20240605012335.44086-1-lizhi.xu@windriver.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/super.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index e72145c4ae5a0..25cd0d662e31b 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -3582,6 +3582,13 @@ int ext4_feature_set_ok(struct super_block *sb, int readonly)
 			 "mounted without CONFIG_UNICODE");
 		return 0;
 	}
+	if (EXT4_SB(sb)->s_es->s_def_hash_version == DX_HASH_SIPHASH &&
+	    !ext4_has_feature_casefold(sb)) {
+		ext4_msg(sb, KERN_ERR,
+			 "Filesystem without casefold feature cannot be "
+			 "mounted with siphash");
+		return 0;
+	}
 
 	if (readonly)
 		return 1;
-- 
2.43.0


