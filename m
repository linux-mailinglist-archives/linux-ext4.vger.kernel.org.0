Return-Path: <linux-ext4+bounces-12152-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 56DF7CA3374
	for <lists+linux-ext4@lfdr.de>; Thu, 04 Dec 2025 11:28:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B660630A411F
	for <lists+linux-ext4@lfdr.de>; Thu,  4 Dec 2025 10:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCA133ADAA;
	Thu,  4 Dec 2025 10:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c3a0i+7o"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF7E71531C1;
	Thu,  4 Dec 2025 10:19:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764843558; cv=none; b=Lp8n3cSSjwDmdkydRQs6JX82X0lM0X4vlRijK/x+eYskM8sv3jYT01Z/usrghyH7y9I10e5UaUMT5/KhdhFh3rUwuaAlCJFlq+CcjFFJt4GOFwdG2cX0PkylctWGkkx9ezwo5iF5Tpnczn+utnOFo5mYAbiufLnQ7YV+1Ka6XUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764843558; c=relaxed/simple;
	bh=wsWw+r/1qUkux7JSfIceQzCDWBMLtc3xGnsUYXL/mw4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MRZ0SpB0xdspW3aYQmMtnTqrvZAxArqdfpn6RZpj+HqshlQXIUnWduFOO7gS9WmKqwDgWSiVOdye/jVJHO+lEmAoqDfQBp6ClMe3srYamRQUQ6iwx753edRmFDFj+robqgBPbbnV/dYyMVrBY2NzS1PG875q2e7IVHYPpybZeUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c3a0i+7o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22B0C4CEFB;
	Thu,  4 Dec 2025 10:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764843558;
	bh=wsWw+r/1qUkux7JSfIceQzCDWBMLtc3xGnsUYXL/mw4=;
	h=From:To:Cc:Subject:Date:From;
	b=c3a0i+7oB0Sayaz5RPnEfnayuxe4yb+c3znuzNByPICcHPQUCBwdKPwws16Oaveyu
	 Y8vdg93TP5Vras3Oeq4RiYD0pHgqWc+r0AkiQ1oDFkPTYMF46Igxa4OMYDhCD/hjcS
	 4RidFWLd0WNOTYTE6/I9vJovNDKFTXtIwUIlFmaC68G+C/+fNsP0pYZYjVO3Tcpm1w
	 RD9VlXRa4f6JRDZCAbCHASfgy3yMPFlT9BYAy1bxs17acLNjHc12MaOPgppmjfa9pz
	 7P3DqhkVvO1VDNJCJl9RpIUFesxrdVJsV2hnlNxmGeBZ0GemwqtzrdyQpqxcc4drOr
	 zspmva5BTMD3g==
From: Arnd Bergmann <arnd@kernel.org>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] ext4: fix ext4_tune_sb_params padding
Date: Thu,  4 Dec 2025 11:19:10 +0100
Message-Id: <20251204101914.1037148-1-arnd@kernel.org>
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
difference here is the amount of padding at the end. Make the padding
explicit, to have a consistent sizeof(struct ext4_tune_sb_params) of
232 on all architectures and avoid adding compat ioctl handling for
EXT4_IOC_GET_TUNE_SB_PARAM/EXT4_IOC_SET_TUNE_SB_PARAM.

This is an ABI break on x86-32 but hopefully this can go into 6.18.y early
enough as a fixup so no actual users will be affected.  Alternatively, the
kernel could handle the ioctl commands for both sizes (232 and 228 bytes)
on all architectures.

Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 include/uapi/linux/ext4.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
index 411dcc1e4a35..9c683991c32f 100644
--- a/include/uapi/linux/ext4.h
+++ b/include/uapi/linux/ext4.h
@@ -139,7 +139,7 @@ struct ext4_tune_sb_params {
 	__u32 clear_feature_incompat_mask;
 	__u32 clear_feature_ro_compat_mask;
 	__u8  mount_opts[64];
-	__u8  pad[64];
+	__u8  pad[68];
 };
 
 #define EXT4_TUNE_FL_ERRORS_BEHAVIOR	0x00000001
-- 
2.39.5


