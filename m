Return-Path: <linux-ext4+bounces-12208-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2789ACA7598
	for <lists+linux-ext4@lfdr.de>; Fri, 05 Dec 2025 12:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 037CE30D10AF
	for <lists+linux-ext4@lfdr.de>; Fri,  5 Dec 2025 11:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A599C2FB978;
	Fri,  5 Dec 2025 11:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ldhjJmJz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D24A2C2368;
	Fri,  5 Dec 2025 11:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764933554; cv=none; b=IFBHxa8XA6qTf6KIq/KojsmjFYh5lwGUyhjdiSvFoAxAaXT8ix7ltC/ecEGsxOhiaX6VS/15L/7uoruM52mrwKfUkOA5P42XmyBjKT3fQSKiuFR6jMV2lqN62KvPM7RIu2/9qSIKQeuvx0BQNjGsN9swjdAwcR2yYx1Bg4djT7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764933554; c=relaxed/simple;
	bh=960NH/2dZazI3KrFVYftHxT87GmwClLTcUn+OCXPgVE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pdm5khDEUL/fi5ZYWyqc1QSzoJ4FrIuVe+Yv0w8gagbVZAOW+yafoBhtnl93JeyLnKfVAAYBXY4RR27jWyYDg88Z6hiD3iiRhoRnr8BuKcNJXbXntlKc9dHNS4hUpbQQ+8U5hOWZyx2+AUGdRqureibvABcd1Twd5Nv8JwfaZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ldhjJmJz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC939C4CEF1;
	Fri,  5 Dec 2025 11:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764933551;
	bh=960NH/2dZazI3KrFVYftHxT87GmwClLTcUn+OCXPgVE=;
	h=From:To:Cc:Subject:Date:From;
	b=ldhjJmJzcpVFJQjsJzkOZndfJL/7lMT08x63bCKti2gDWy4YZv+iGG1ZUquSph+88
	 X/OzC8Jk0tFopgi8BR9hr84u3rqTQaSA1AquiXBJWh3pIg9NDwQzSSzk4X/KIQVqZJ
	 QMRobq6tEgOF8EIXqnhDB92zAP/6qJuk52Ncf0aIfeh6fM+2M2iLtDo01UAEHS9Kt7
	 1SodjmhieuEr7/UBvoSCnIrg84oaKqNddzjaaJf9Bye0V0dCsXDwZ2Cs7hFnvCycZ3
	 pm51cPiA/v4u6r8xcSAMEVLaKfF9GYc7Na2ZhIaULvhOz6WGAQFGcRGSO5ZdOT9nIC
	 EkQBDVQpdskRg==
From: Arnd Bergmann <arnd@kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] ext4: fix ext4_tune_sb_params padding
Date: Fri,  5 Dec 2025 12:19:00 +0100
Message-Id: <20251205111906.1247452-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The padding at the end of struct ext4_tune_sb_params is architecture
specific and in particular is different between x86-32 and x86-64,
since the __u64 member only enforces struct alignment on the latter.

This shows up as a new warning when test-building the headers with
-Wpadded:

include/linux/ext4.h:144:1: error: padding struct size to alignment boundary with 4 bytes [-Werror=padded]

All members inside the structure are naturally aligned, so the only
difference here is the amount of padding at the end.

Add explicit padding to mount_opts[] to keep the struct members compatible
with the original version and also keep the pad[64] member 8-byte
aligned for future extensions.  This gives a consistent sizeof(struct
ext4_tune_sb_params) of 232 on all architectures and avoids adding compat
ioctl handling for EXT4_IOC_GET_TUNE_SB_PARAM/EXT4_IOC_SET_TUNE_SB_PARAM.

This is an ABI break on x86-32 but hopefully this can go into 6.18.y
early enough as a fixup so no actual users will be affected.

Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
v2: extend mount_opts[] instead of pad[], as suggested by Andreas Dilger
---
 include/uapi/linux/ext4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
index 6829d6f1497d..1c7cdcdb7dca 100644
--- a/include/uapi/linux/ext4.h
+++ b/include/uapi/linux/ext4.h
@@ -139,7 +139,7 @@ struct ext4_tune_sb_params {
 	__u32 clear_feature_compat_mask;
 	__u32 clear_feature_incompat_mask;
 	__u32 clear_feature_ro_compat_mask;
-	__u8  mount_opts[64];
+	__u8  mount_opts[68];
 	__u8  pad[64];
 };
 
-- 
2.39.5


