Return-Path: <linux-ext4+bounces-7806-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 454FCAB3442
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 11:58:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D78A3189E5FF
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 09:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3ABA25B1CB;
	Mon, 12 May 2025 09:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeWpSG1Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDF725F7AE;
	Mon, 12 May 2025 09:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747043877; cv=none; b=ahysnisuYtg9KuCBkCFY5WKbPljI1QBb6x3VIeZ2Yt83b83c5SFX+QBrcUNaVKW5J7Dj+uTjQc3FLs1sAM+V5e941LJXiZTfNvzr2D+35DHquBVwi0e+uRhrryCkv7dOBXCfDqdOJg94SN4dbfGblOsYBca4CwRn1aDsjRQUX7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747043877; c=relaxed/simple;
	bh=4ByRIQgWC6UDqroRcLwK+4rAQlasftRhAqw/yjWkYdc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipFFLmfHJt21L+9TP9iCIS2TV+YnpUItE58dX9ziOyihMOA8NK6vnBUV3aIreqfAxbspAW+bHHyZewcRaGzVRuglhbjTXGganYyXmMSXq5PDTQXo0LvIiWM+ZrmJLh73pSJN1BpbSUtt1ob0YZsjakPQ10/9AM7ZId2w1jT59tQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EeWpSG1Q; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-30a8cbddce3so3527468a91.1;
        Mon, 12 May 2025 02:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747043874; x=1747648674; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ErDLUrud9LJFAo9GXjrfYqJDwod1awSQJMIdzhoSsY=;
        b=EeWpSG1QkuBHS/XITKLuYrVkL+i+c3GdgcuhkrTcMNRjAd5mZGdgafeou8KyvNNgAe
         CK7yfsnQC9h82kxzI4gT82cbXNG57tUk0LBmt89+IFpJXiuy1KOcSllJwCpRiJAuRRz2
         bCN1qcFXwG+bCSjzF4bV40O8viXonK7E+K7RmTL4nz5ii9swoaFEZ0njH+mp+EE3K2fC
         jODwM7xG+bk69ql0CByhqUICpM9UdTj7FtUfhN7T3kTYWV0PqlYsuh22lj/X7lltrLm5
         99ojkrV6YGjXSXjsUYsbCBK5hn7eN2YPkqph4oML8Xdyj/8rWT0i3uagaB4wriJT+0tQ
         x5HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747043874; x=1747648674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ErDLUrud9LJFAo9GXjrfYqJDwod1awSQJMIdzhoSsY=;
        b=S6+GtneIZY8NzKn8ajNar/dGfioHnJV94f7B8U9XvuGiER5vck/17g/dEmpUbClS/w
         C89RS051ZTEZWqO5tyaPuNdMUd5UucVjuz6W0VuC/Ht1mtSW/uk5aCqPk3dvAJOLttHZ
         1FDzLO5eFV+Q9j9+uNwN8MWySqS1zJnMMVUfO3fxxG05FmKmbMxOF1v2N6sBjprMSgiH
         48E9J2Xg8VBw54iIvWqUnjjXW77ZAfZCon56awSZJGXaDkivvCkgcm98ENrQTaB7Uu0A
         QGYZqM0M3ySLREupkQBmp2t4VVxGThW1Mz/+SdkSWKJh1OXM3gJi2dr0ZgafUWHrfRTW
         q+eg==
X-Forwarded-Encrypted: i=1; AJvYcCWeER12BjilvXY/IRPUUmq4y3vlHFbmGXB7aHV0eA99aPsHcWROLHdNu+mN4JIGrf0MNb+GCxNb@vger.kernel.org
X-Gm-Message-State: AOJu0YyatNcabnZa9No2ZcGA7mID3fYF8SdYxM7Kho3k+N/ttKilb9Wn
	f7dBl73FJpW6YNWCxxtXHOysritKkPOf1QrIU0fyx+7Apcm2bf/yQHzgIQ==
X-Gm-Gg: ASbGncvxgf7sKJgXmOL+IoMmhiDmZOAHDfshquF9wnaEt67emgmRIyaiMAA65O6t1IS
	cFhC7WWQ/AmRYOr6QYbQo9gX2IvDbukiNKmAN62HI9iOfq7RtEOpEC7H5O6T/0fCOQ66112VhMI
	mzNlc18/YrqDxDm4IddKRLC7eOKiZ2vEdIQszQEzU23SErGZVFb92rb4MwK0sRoc7mUYRp1iHoC
	r5h7vGE4onb2PLhUybkO98VPplMc5r733Kh3kuXgoRWyNORLcmZJPvO7KHzJ2Kf6VhXdrMNpMwr
	bo46UngW98st0fwsnsYYLsepczO/xyr1tghVGqcjepylKGZC9ir4kM1L4yRHFP6ckR36XweXxHV
	tSwyEGXcD2Qy8x0xYKwGnyUiCdKA56A==
X-Google-Smtp-Source: AGHT+IHj9ylQyLL0Ni4//2Uf7OrkziVugmNBeQjYlj2dSP37ANU9uhBuikvVg2bEJY7zodGAop8xJA==
X-Received: by 2002:a17:90b:3907:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-30c3b910265mr24848982a91.0.1747043874132;
        Mon, 12 May 2025 02:57:54 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.in.ibm.com ([129.41.58.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4fe213bsm8366974a91.34.2025.05.12.02.57.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 02:57:53 -0700 (PDT)
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
	nirjhar.roy.lists@gmail.com,
	cem@kernel.org
Subject: [PATCH v5 1/1] xfs: Fail remount with noattr2 on a v5 with v4 enabled
Date: Mon, 12 May 2025 15:27:14 +0530
Message-ID: <e03b24e6194c96deb6f74cd8b5e5d61490d539f6.1747043272.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <cover.1747043272.git.nirjhar.roy.lists@gmail.com>
References: <cover.1747043272.git.nirjhar.roy.lists@gmail.com>
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_super.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index b2dd0c0bf509..606a95ac816f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -2114,6 +2114,21 @@ xfs_fs_reconfigure(
 	if (error)
 		return error;
 
+	/* attr2 -> noattr2 */
+	if (xfs_has_noattr2(new_mp)) {
+		if (xfs_has_crc(mp)) {
+			xfs_warn(mp,
+			"attr2 is always enabled for a V5 filesystem - can't be changed.");
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


