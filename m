Return-Path: <linux-ext4+bounces-7545-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 200B4AA0F8A
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 16:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1274C16675A
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Apr 2025 14:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488E0215F6C;
	Tue, 29 Apr 2025 14:49:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="as1iJh8I"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69EA717588;
	Tue, 29 Apr 2025 14:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745938142; cv=none; b=G1L5Y9fEM94Z3KutWltg0+0OOAARkWgaOwTkXd+HTuJTqQfd9aOmUjoLgHP/QaPL+wrVA92u3GuDqNjbdpbBMWdT2y77SOWpQGRi0hfkUD4y5BqIjkGNhSW2rSmT1tn9YMl1vpU8FXiduBPqkL7MkZRLDWF6zt5G8AiwN6muKns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745938142; c=relaxed/simple;
	bh=DahOA68JSejicCCqAZP3deFxaASill/6LiuXgIAvY8s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lZ8EmoyAt550RE8Kc0XyH9hSng0AOybYVfxUFW4hJ0PtGu/KEQfV+eqRXgLZcaqQ5AHQKKxQuXbQ3Nv61zSh8+8E4/6VLZRHX3N5pSbyPLCdFC7/j2PpqJFwNCWiW9HTmuVdVhA+lXRZBHwjBua7hcA4+g6zufoBii76aJ5cDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=as1iJh8I; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-b0b2ce7cc81so6056603a12.3;
        Tue, 29 Apr 2025 07:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745938140; x=1746542940; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cGksrS1FSjnCNFb8CEn1RozjMVVoVrZPt3zE6EtXP5c=;
        b=as1iJh8IiXUDtHORr2xSEC975Wybjek+FkAVvLjMT8sJcDt0cpfvTMOyhDL93qHPB1
         wtKcYx2X/DmgKgWm83OO8zlcCOfA8vc55KpAWDI1G24KxW3F+W002VbjLwzcStM5yg12
         cpFQXtyKJqFlTmBbyeCAG7YsTAhJ2cKQS2maDGcf5lCRSAZM3fN4Bot1mCRJtU4epXP4
         Z5KEoULqUOODgkA946bpmoFKnqcg2J7Ae77wY+Zm/6TqtzcNbpD1SiRBmEFzdSIPayod
         JXbu2G+Nk1bzsO99t9wa5rzeY7V0Wow7I/KhlTR1to+bm04vGkOc8FIxfb78+b53+Siz
         PF2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745938140; x=1746542940;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cGksrS1FSjnCNFb8CEn1RozjMVVoVrZPt3zE6EtXP5c=;
        b=N0kXZMvuqCURn1+PFCF6+OQQMaiIkmViRPbrbF80yAlXTjDO9ZLLm9vpZdp3npOPUT
         U4aFpr97dJU7hEo0zxvU8MnchOzJ8bSyiHGhrYg/trXuHcTi9HU0OGHsFcI4S/hhtGaN
         b2ReR1cL1ZEtrxC/QDNfbFvcAIpVKDBL7M+iu309KklssfE6vod3LD0X2sFSokvNSVuU
         fSlwkdd3OTsMTD9nJR4agUGDA+cGSUz2tchfu5i7ut9PscibLhYhmuht0zGxSqHAN4kT
         BCCaBEb3wgDvBN+5uaRr/CDSvEX0U/PgZ6qa61PV0y6f7YB0ywSRX9ObHhqAMFkXC+Jl
         qjkA==
X-Forwarded-Encrypted: i=1; AJvYcCWPyLFKhw/jyByPNdiNxiSGQVyml+mOZWsspoJq8eW4PLVJirQ93M9HkI1kT3Q1ZtdLIJchkjlM@vger.kernel.org
X-Gm-Message-State: AOJu0YyI6t2xuWPIJ0iKpLBLsBttUjioqzn/7I7hNhsqD5jSekgb1xJD
	JgyHzZfhf8xNxs2VqM8ayYNoGIOti5Kn5Pwu0nWUmkf+C/CmlIXAcy5Tmw==
X-Gm-Gg: ASbGncuIzZbgT+GT2bCwQ0ytGdOmPowo1gI2nyk/LIGZi6nfV9rJaliD0Y2Z12xaZxe
	S7IfO3YJC2xdLLl24Jl909qlcKf1fGcgLGFf8KLxlv60OHuKibPYPOPSaAxpkhcYTkT5cvTnnXb
	CwpfS3c4d/C8EjB1/dICBKPVBEqIGT/q6l4rgwQrA4EpsuaR2+wdRINaESpYrOpCuAdfGZ7fpPt
	5RZBcNhVg0l5FMHHeAy8z6broTlTS1krn4CkVQaHRtibaTNIJ5AfA73RK4PAaNx21Wm9WTxWXYI
	DalnNhojdGPeBjSQfddjkvuYLlrU2LMdV4eqxKTvKBi+ouGeekKlX6X1nU9DD26Z/PqkXGK60Lo
	RLyaS71Pdofm61qouuQ==
X-Google-Smtp-Source: AGHT+IEJFgHvBlbj8KPvnUdC/GABYqQS9QtO2vQF2J9Z2eCiJ99GI2Z1DtkvPqQiMEqKTzN9sYNetA==
X-Received: by 2002:a05:6a21:329a:b0:1f5:8eec:e516 with SMTP id adf61e73a8af0-2093e121043mr5696147637.32.1745938140118;
        Tue, 29 Apr 2025 07:49:00 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.ibm.com ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73e25a9fd26sm9954222b3a.151.2025.04.29.07.48.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Apr 2025 07:48:59 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	hch@infradead.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v3 1/1] xfs: Fail remount with noattr2 on a v5 with v4 enabled
Date: Tue, 29 Apr 2025 20:17:59 +0530
Message-ID: <a56bb4685df5f8f45308f6a3195390ad73b75709.1745937794.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1745937794.git.nirjhar.roy.lists@gmail.com>
References: <cover.1745937794.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bug: When we compile the kernel with CONFIG_XFS_SUPPORT_V4=y,
remount with "-o remount,noattr2" on a v5 XFS does not
fail explicitly.

Reproduction:
mkfs.xfs -f /dev/loop0
mount /dev/loop0 /mnt/scratch
mount -o remount,noattr2 /dev/loop0 /mnt/scratch

However, with CONFIG_XFS_SUPPORT_V4=n, the remount
correctly fails explicitly. This is because the way the
following 2 functions are defined:

static inline bool xfs_has_attr2 (struct xfs_mount *mp)
{
	return !IS_ENABLED(CONFIG_XFS_SUPPORT_V4) ||
		(mp->m_features & XFS_FEAT_ATTR2);
}
static inline bool xfs_has_noattr2 (const struct xfs_mount *mp)
{
	return mp->m_features & XFS_FEAT_NOATTR2;
}

xfs_has_attr2() returns true when CONFIG_XFS_SUPPORT_V4=n
and hence, the following if condition in
xfs_fs_validate_params() succeeds and returns -EINVAL:

/*
 * We have not read the superblock at this point, so only the attr2
 * mount option can set the attr2 feature by this stage.
 */

if (xfs_has_attr2(mp) && xfs_has_noattr2(mp)) {
	xfs_warn(mp, "attr2 and noattr2 cannot both be specified.");
	return -EINVAL;
}

With CONFIG_XFS_SUPPORT_V4=y, xfs_has_attr2() always return
false and hence no error is returned.

Fix: Check if the existing mount has crc enabled(i.e, of
type v5 and has attr2 enabled) and the
remount has noattr2, if yes, return -EINVAL.

I have tested xfs/{189,539} in fstests with v4
and v5 XFS with both CONFIG_XFS_SUPPORT_V4=y/n and
they both behave as expected.

This patch also fixes remount from noattr2 -> attr2 (on a v4 xfs).

Related discussion in [1]

[1] https://lore.kernel.org/all/Z65o6nWxT00MaUrW@dread.disaster.area/

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 fs/xfs/xfs_super.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..58a0431ab52d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2114,6 +2114,21 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* attr2 -> noattr2 */
+	if (xfs_has_noattr2(new_mp)) {
+		if (xfs_has_crc(mp)) {
+			xfs_warn(mp,
+			"attr2 and noattr2 cannot both be specified.");
+			return -EINVAL;
+		}
+		mp->m_features &= ~XFS_FEAT_ATTR2;
+		mp->m_features |= XFS_FEAT_NOATTR2;
+	} else if (xfs_has_attr2(new_mp)) {
+		/* noattr2 -> attr2 */
+		mp->m_features &= ~XFS_FEAT_NOATTR2;
+		mp->m_features |= XFS_FEAT_ATTR2;
+	}
+
 	/* inode32 -> inode64 */
 	if (xfs_has_small_inums(mp) && !xfs_has_small_inums(new_mp)) {
 		mp->m_features &= ~XFS_FEAT_SMALL_INUMS;
@@ -2126,6 +2141,17 @@ xfs_fs_reconfigure(
 		mp->m_maxagi = xfs_set_inode_alloc(mp, mp->m_sb.sb_agcount);
 	}
 
+	/*
+	 * Now that mp has been modified according to the remount options,
+	 * we do a final option validation with xfs_finish_flags()
+	 * just like it is done during mount. We cannot use
+	 * xfs_finish_flags()on new_mp as it contains only the user
+	 * given options.
+	 */
+	error = xfs_finish_flags(mp);
+	if (error)
+		return error;
+
 	/* ro -> rw */
 	if (xfs_is_readonly(mp) && !(flags & SB_RDONLY)) {
 		error = xfs_remount_rw(mp);
-- 
2.43.5


