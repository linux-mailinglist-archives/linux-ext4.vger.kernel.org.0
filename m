Return-Path: <linux-ext4+bounces-2921-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C5F913A68
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 14:11:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 056A71F21AC4
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jun 2024 12:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01278181318;
	Sun, 23 Jun 2024 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="T9dL4TNi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776C4180A92;
	Sun, 23 Jun 2024 12:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719144675; cv=none; b=MfZnsmuHp2qGro84GCP1lTpXEhTHtLcP1yl4S0RTD3WkdnwDvz+tMzlDX+lqt7Y4Lbc7mSyKsHtD0QYjzabuOYsuJ4F3LrL/b9FIAUCeGf1MgZ8OEJ0lAPtJLYj42Kk+TJ2A68Y6g4qHQvU5vx2GA7oCkEZT7AcVfozODBe6b7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719144675; c=relaxed/simple;
	bh=7psZbdqsWhzgMz04vbyc7M59mMwvsgez862gH1muRlk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ElnK+VX7xzzcNGzgZVhkop542VhijucOfcWelcsv+E6glNQHfXkhOgMyko8yxsWvCl2YU+//deUTlX4tyF94iOALIMtny7gNi6QhHrhrKuHMTuOVK4nsf8mHm9eg8nET4TU1/ihJwJCdyFD0DSjK43F30H2H1pD0w4GQk/BjPPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=T9dL4TNi; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-Type:Content-ID:Content-Description;
	bh=FB7af54C8EMzaA18dQJ/JIRT3WCuuf6nwdcZoFCM0qg=; b=T9dL4TNiucRfVvapidH5yy6x9x
	Z1vx0CKoaiZkGQsB8DON9NUpKL3yEXkOlke6ky0IJeP3IqOq1ER58HpvVOuIfVxPYlndejgizvxa2
	MRxy0TjCH4sCS+bsyFcueZvR9omYDSYBxL9twI+H7vKNmZXu0TvVtkcXHZF4E+lkjru89/0IDpFIc
	yQtIlkG3myS9POeBfR1jHu3p3UlLL/Ng3Opn1C562I2OtbrvaY13z38Tsl22vE7MOBipbacjZ5Swg
	CspQdwROdkfZlnOXEErkdptEegQb/H9ZbsTwb16IMbqrbUS/fW6ZYUrxkljrD6BM6u7MDQ7+TO/LT
	TQmvw3vg==;
Received: from 2a02-8389-2341-5b80-9456-578d-194f-dacd.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:9456:578d:194f:dacd] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sLM3s-0000000DwxT-2csc;
	Sun, 23 Jun 2024 12:11:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Zorro Lang <zlang@kernel.org>
Cc: fstests@vger.kernel.org,
	"Theodore Ts'o" <tytso@mit.edu>,
	linux-ext4@vger.kernel.org
Subject: [PATCH 2/8] generic/740: clean up handling of mkfs options
Date: Sun, 23 Jun 2024 14:10:31 +0200
Message-ID: <20240623121103.974270-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240623121103.974270-1-hch@lst.de>
References: <20240623121103.974270-1-hch@lst.de>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

Use a single case statement instead of lots of conditionals.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 tests/generic/740 | 50 ++++++++++++++++++++++++++++++-----------------
 1 file changed, 32 insertions(+), 18 deletions(-)

diff --git a/tests/generic/740 b/tests/generic/740
index 3deba86b3..fc2ec627f 100755
--- a/tests/generic/740
+++ b/tests/generic/740
@@ -29,27 +29,41 @@ fi
 echo "Silence is golden."
 for fs in `echo ${MKFS_PROG}.* | sed -e "s:${MKFS_PROG}.::g"`
 do
-	preop=""	# for special input needs
+	preop=""	# for special input needs (usually a prompt)
 	preargs=""	# for any special pre-device options
 	postargs=""	# for any special post-device options
 
-	# minix, msdos and vfat mkfs fails for large devices, restrict to 2000 blocks
-	[ $fs = minix ] && postargs=2000
-	[ $fs = msdos ] && postargs=2000
-	[ $fs = vfat ] && postargs=2000
-	# these folks prompt before writing
-	[ $fs = jfs ] && preop="echo Y |"
-	[ $fs = gfs ] && preop="echo y |" && preargs="-p lock_nolock -j 1"
-	[ $fs = gfs2 ] && preop="echo y |" && preargs="-p lock_nolock -j 1"
-	[ $fs = reiserfs ] && preop="echo y |" && preargs="-f"
-	[ $fs = reiser4 ] && preop="echo y |" && preargs="-f"
-	# cramfs mkfs requires a directory argument
-	[ $fs = cramfs ] && preargs=/proc/fs
-	[ $fs = ext2 ] && preargs="-F"
-	[ $fs = ext3 ] && preargs="-F"
-	[ $fs = ext4 ] && preargs="-F"
-	# jffs2 mkfs requires '-r $directory' and '-o $image'
-	[ $fs = jffs2 ] && preargs="-r /proc/fs -o"
+	case "$fs"  in
+	ext2|ext3|ext4)
+		preargs="-F"
+		;;
+	cramfs)
+		# cramfs mkfs requires a directory argument
+		preargs=/proc/fs
+		;;
+	gfs|gfs2)
+		preop="echo y |"
+		preargs="-p lock_nolock -j 1"
+		;;
+	jffs2)
+		# jffs2 mkfs requires '-r $directory' and '-o $image'
+		preargs="-r /proc/fs -o"
+		;;
+	jfs)
+		preop="echo Y |"
+		;;
+	minix|msdos|vfat)
+		# minix, msdos and vfat mkfs fails for large devices,
+		# restrict to 2000 blocks
+		postargs=2000
+		;;
+	reiserfs|reiser4)
+		preop="echo y |"
+		preargs="-f"
+		;;
+	*)
+		;;
+	esac
 
 	# overwite the first few Kb - should blow away superblocks
 	$here/src/devzero -n 20 $SCRATCH_DEV >/dev/null
-- 
2.43.0


