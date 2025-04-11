Return-Path: <linux-ext4+bounces-7211-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 47E35A86547
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Apr 2025 20:15:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404B71B80BEF
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Apr 2025 18:15:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83BD25949A;
	Fri, 11 Apr 2025 18:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ME+p+mhu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1066E21B19F;
	Fri, 11 Apr 2025 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744395322; cv=none; b=enaZJZXaRGZkCI345jwrbDZfP4Cl0nH12W6lWsrhScSyRnpytopYzxs/dj9S2gKTqE/3lIWVb2gCth6apgZvvxM8zcirHGKPcfTM+emNMl48RSpW41jFfjIaJhyBB3pvYPofGgy3U/U5HsVzxlIDykhyxwNeO/EMCki1SA12hkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744395322; c=relaxed/simple;
	bh=2tTLSS7hd2iNGOseEFZ6CV/rFq88VhsNhBgpU1nTch0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uhCdiipxwIYE7avQ0quWmpLiKHifvxmc6q1E8x5lVEB7jF64VcOfiJWRw1ziAkAmdZowKJZ4O324fhDqjTyI29UcjMVnSpOHnCioypPf/oNWMkljleB5QaDx5O6skksM9V7a5nF3dLxAr3cjWgMrxY4iJ2z89SS7qKuH0PiX14A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ME+p+mhu; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b0322b6f974so1699939a12.1;
        Fri, 11 Apr 2025 11:15:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744395320; x=1745000120; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BylA5TuS0yUjTwF/wPt8WD7f3x+BV08iih02ZxtM5NI=;
        b=ME+p+mhuzFyI9BS/o357HcL+YyWVJnNEd0sYbk+TmaKuVFLh+sS50H/onCjKeCDhA/
         ryFo4HGeea/gk3o4S6hG4s9pE2Y61l/jV1V+7F2qDbPIv4V0gzweqWKWUm2GPGvyn46M
         Sf+PvC6X/bYLH0Uf0nK2fDwabxm5Jx7yd+QgZz5UrStvZTV/nNU21IaCLTJ4RQyTC/Eb
         LEmveyNHBgm6AOvvdiF1+fpVx/X5vt+sNoH91bGuxzZYXLfBgakkUZTHeIHy7x6xgSFT
         krg8dl+1OjbLUqwCHwYnzPKiX+KF7lqADPLufhcVQP2grKCJbJMGFVc8HGJJsnF48vqg
         dNqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744395320; x=1745000120;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BylA5TuS0yUjTwF/wPt8WD7f3x+BV08iih02ZxtM5NI=;
        b=tIJOm6GWrVJWqGjuE5MPl+tfqLRvkugmmp7k9xxmnIbT2Fc6GXtIzVx+J+0LiShpnq
         lZRgam6iSiasESc1lSZm9RSEYMrBsn8MhNZnI27WzxPArSeqtS8yQOvnv14BtM0FzLKR
         SvDb750LwGwtvSSmcppXPfWAbQISqE2bgusB5kBwkkKzpF7VpBFgDkD7X5CRtgeshEPO
         KWokDzGW0OBoXzIYMUTuNW+/SAOUKxQTW9gxRnwd2Hj68E9Ohu2NxBf4wgME0Dc86I2d
         G7rah8IDiRGDjMvCKAmPf0aJ+gAUJbyvR2piiH/xK6Zpk75X2O2nq5+X+XZ4PF92mI+D
         l5HQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNLRtUxk5/+ppw8fdolb3pIv86izT6V5FfOXM4wXcdYk7XMNCPEm3k3Vem/l8wwqH04zDDty8r@vger.kernel.org
X-Gm-Message-State: AOJu0Ywr1cphKwMeMFfutyGee9GU3Q9q+NXhbCI2zZtNyNQP93Agm6Gv
	22sFKyIFm2In+LWx+V4Vp/yWNHqOLar1n8O08JzG7OOvwIaNzp5BAM63xw==
X-Gm-Gg: ASbGncvNwoLC+sI02YBiK0aj1+O/uTzow4QMOsLqc359rLtRY3f61uJBF/XqgOvGYvu
	8u7G0BK8XaEYi3DBv5Wk9Voh4guNvbOn/1+kXnVq1DcvpU4zfToxsVHACPrFuvUF1PnzSXIswzF
	8gEDiNMIQrb+kQ0ACUozsCV+lib/ZBagBlfkUA7r7VY9cNxUN7mWavkHGzQyg5hGm7AZ+sON/YQ
	pp+qLz/Gx55Qfqhw2IaPiLLLPTgYmssNp+DgJWJWpGSrPZ/yqTAPcomYcpwPCCNPUSl7s6eLXzT
	YnVUm2IiSYATBMOUr0tOLnrAMujgUwEaCb+mu0yCsaiTEw5af6XlyT49aHgHqPxhf/LLCxff/HP
	aJ0c6x+Ub/Kocm8qCetT2tny/vg==
X-Google-Smtp-Source: AGHT+IHjP7lBCLzYhprsrSNT3veinax7VEshXeiXIgdk/yN7YTt+fdJ14tGy1Or6vkWehYQ4Y4V/Tw==
X-Received: by 2002:a05:6a21:3943:b0:1f5:70af:a32a with SMTP id adf61e73a8af0-2017996f1d9mr7193332637.32.1744395319749;
        Fri, 11 Apr 2025 11:15:19 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([2405:201:e030:380d:7994:78a5:fd96:99de])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b02a322184fsm5179326a12.74.2025.04.11.11.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Apr 2025 11:15:19 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v1] xfs: Fail remount with noattr2 on a v5 xfs with CONFIG_XFS_SUPPORT_V4=y
Date: Fri, 11 Apr 2025 23:44:52 +0530
Message-ID: <7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bug: When we compile the kernel with CONFIG_XFS_SUPPORT_V4=y, remount
with "-o remount,noattr2" on a v5 XFS does not fail explicitly.

Reproduction:
mkfs.xfs -f /dev/loop0
mount /dev/loop0 /mnt/scratch
mount -o remount,noattr2 /dev/loop0 /mnt/scratch # This should fail but it doesn't

However, with CONFIG_XFS_SUPPORT_V4=n, the remount correctly fails explicitly.
This is because the way the following 2 functions are defined:

static inline bool xfs_has_attr2 (struct xfs_mount *mp)
{
	return !IS_ENABLED(CONFIG_XFS_SUPPORT_V4) ||
		(mp->m_features & XFS_FEAT_ATTR2);
}
static inline bool xfs_has_noattr2 (const struct xfs_mount *mp)
{
	return mp->m_features & XFS_FEAT_NOATTR2;
}

xfs_has_attr2() returns true when CONFIG_XFS_SUPPORT_V4=n and hence, the
the following if condition in xfs_fs_validate_params() succeeds and returns -EINVAL:

/*
 * We have not read the superblock at this point, so only the attr2
 * mount option can set the attr2 feature by this stage.
 */

if (xfs_has_attr2(mp) && xfs_has_noattr2(mp)) {
	xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
	return -EINVAL;
}
With CONFIG_XFS_SUPPORT_V4=y, xfs_has_attr2() always return false and hence no error
is returned.

Fix: Check if the existing mount is has crc enabled(i.e, of type v5 and has attr2 enabled)
and the remount has noattr2, if yes, return -EINVAL.

I have tested xfs/{189,539} in fstests with v4 and v5 XFS with both CONFIG_XFS_SUPPORT_V4=y/n
and they both behave as expected.

This patch also fixes remount from noattr2 -> attr2 (on a v4 xfs).

Related discussion in [1]

[1] https://lore.kernel.org/all/Z65o6nWxT00MaUrW@dread.disaster.area/

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 fs/xfs/xfs_super.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..fd72c8fcd3a7 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2114,6 +2114,23 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* attr2 -> noattr2 */
+	if (xfs_has_noattr2(new_mp)) {
+		if (xfs_has_crc(mp)) {
+			xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
+			return -EINVAL;
+		}
+		else {
+			mp->m_features &= ~XFS_FEAT_ATTR2;
+			mp->m_features |= XFS_FEAT_NOATTR2;
+		}
+
+	} else if (xfs_has_attr2(new_mp)) {
+			/* noattr2 -> attr2 */
+			mp->m_features &= ~XFS_FEAT_NOATTR2;
+			mp->m_features |= XFS_FEAT_ATTR2;
+	}
+
 	/* inode32 -> inode64 */
 	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
 		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
-- 
2.43.5


