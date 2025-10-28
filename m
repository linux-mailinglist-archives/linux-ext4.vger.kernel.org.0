Return-Path: <linux-ext4+bounces-11111-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9617EC14C6D
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 14:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC08B1B2538B
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Oct 2025 13:11:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 676E73314B9;
	Tue, 28 Oct 2025 13:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="e+ok+RGN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00781E834B;
	Tue, 28 Oct 2025 13:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761657031; cv=none; b=O8VBH/uJIvZdtZHF2Td1rquk1ldE25P+tNfc7w/uryXnlqTz4NEMnmbZzP2SaTnhuxVlXU4DATx/kijsUaokAUkw4a764roT4R1k7J91tTy2LB3dsH6POIqDJ4SmCt/GCdK2KYL5o0L6AAoyjavFx4aVSvySNnU42gRVpOL94rc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761657031; c=relaxed/simple;
	bh=ouhV2HDV8Ni9J87rpuxzeZNp/ogsqBij7QucXH4rKTU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z7hs6jAYRfevgfUUnuPUfHEiPO+/ZejuheX40HmBPBg/z0xU5iNgg78A4CeNvHDVP3lHxZnOBQn3ljEkf+dYfH4XfC6COJPADuX867hRs8LL/GBq4utM3W+otjOZXUXdSFwRqc1PHlXSEx7UAH8cBNH6qMXDZMct23FUIipC1HA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=e+ok+RGN; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from debian.intra.ispras.ru (unknown [10.10.165.13])
	by mail.ispras.ru (Postfix) with ESMTPSA id 20B17407618C;
	Tue, 28 Oct 2025 13:10:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru 20B17407618C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1761657018;
	bh=+A37THDd2QvH4j4+lDg0mcsg8AKgH1f26eTMcOLh8RA=;
	h=From:To:Cc:Subject:Date:From;
	b=e+ok+RGNA49IYelbni2UUJqMd9MinTd2BnIE4kxQwdlZoNLruPwbkY/p/zvtlnq9Y
	 +zq+RBW2WH7Ge4uqtq+rPYNm9Ah+IdsNPPsip3YxBRoyyBeVaVmlC/oxaPq4UdIAZ5
	 WXcc7it2vvUtu6jPFsN6P1CVYWgS2AC8dqissFvM=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jan Kara <jack@suse.cz>,
	"Darrick J. Wong" <djwong@kernel.org>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Kees Cook <kees@kernel.org>,
	lvc-project@linuxtesting.org
Subject: [PATCH 1/2] ext4: fix up copying of mount_opts in superblock tuning ioctls
Date: Tue, 28 Oct 2025 16:09:47 +0300
Message-ID: <20251028130949.599847-1-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Judging by commit 8ecb790ea8c3 ("ext4: avoid potential buffer over-read in
parse_apply_sb_mount_options()"), the contents of s_mount_opts should be
treated as __nonstring, i.e. there might be no NUL-terminator in the
provided buffer.

Then the same holds for the corresponding mount_opts field of the struct
ext4_tune_sb_params exchanged with userspace via a recently implemented
superblock tuning ioctl.

The problem is that strscpy_pad() can't work properly with non-NUL-term
strings.  String fortifying infrastructure would complain if that happens.
Commit 0efc5990bca5 ("string.h: Introduce memtostr() and memtostr_pad()")
gives additional information in that regard.

Both buffers are just raw arrays of the similar fixed size, essentially
they should represent the same contents.  As they don't necessarily have
NUL-terminators, in both directions use plain memcpy() to copy their
contents.

Found by Linux Verification Center (linuxtesting.org).

Fixes: 04a91570ac67 ("ext4: implemet new ioctls to set and get superblock parameters")
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
---

The 1/2 patch of the current series fixes an issue existing only in 6.18-rc
while 2/2 fixes the commit which was in turn backported to stable kernels.
That's the reasoning for separation.

 fs/ext4/ioctl.c           | 4 ++--
 include/uapi/linux/ext4.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
index a93a7baae990..c39b87d52cb0 100644
--- a/fs/ext4/ioctl.c
+++ b/fs/ext4/ioctl.c
@@ -1292,7 +1292,7 @@ static int ext4_ioctl_get_tune_sb(struct ext4_sb_info *sbi,
 	ret.raid_stripe_width = le32_to_cpu(es->s_raid_stripe_width);
 	ret.encoding = le16_to_cpu(es->s_encoding);
 	ret.encoding_flags = le16_to_cpu(es->s_encoding_flags);
-	strscpy_pad(ret.mount_opts, es->s_mount_opts);
+	memcpy(ret.mount_opts, es->s_mount_opts, sizeof(ret.mount_opts));
 	ret.feature_compat = le32_to_cpu(es->s_feature_compat);
 	ret.feature_incompat = le32_to_cpu(es->s_feature_incompat);
 	ret.feature_ro_compat = le32_to_cpu(es->s_feature_ro_compat);
@@ -1353,7 +1353,7 @@ static void ext4_sb_setparams(struct ext4_sb_info *sbi,
 		es->s_encoding = cpu_to_le16(params->encoding);
 	if (params->set_flags & EXT4_TUNE_FL_ENCODING_FLAGS)
 		es->s_encoding_flags = cpu_to_le16(params->encoding_flags);
-	strscpy_pad(es->s_mount_opts, params->mount_opts);
+	memcpy(es->s_mount_opts, params->mount_opts, sizeof(es->s_mount_opts));
 	if (params->set_flags & EXT4_TUNE_FL_EDIT_FEATURES) {
 		es->s_feature_compat |=
 			cpu_to_le32(params->set_feature_compat_mask);
diff --git a/include/uapi/linux/ext4.h b/include/uapi/linux/ext4.h
index 411dcc1e4a35..8ed9acbd0e03 100644
--- a/include/uapi/linux/ext4.h
+++ b/include/uapi/linux/ext4.h
@@ -138,7 +138,7 @@ struct ext4_tune_sb_params {
 	__u32 clear_feature_compat_mask;
 	__u32 clear_feature_incompat_mask;
 	__u32 clear_feature_ro_compat_mask;
-	__u8  mount_opts[64];
+	__u8  mount_opts[64] __nonstring;
 	__u8  pad[64];
 };
 
-- 
2.51.0


