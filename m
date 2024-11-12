Return-Path: <linux-ext4+bounces-5109-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFE269C638C
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 22:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77063B802FA
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 18:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C47B621A6FF;
	Tue, 12 Nov 2024 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="f332KYpY"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE9321A6E3
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 17:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434219; cv=none; b=SM/9yQ0Rs+XC4Nq6nObm+4CKv899DT45jZZ/QB8+TQZ5i74jovkWg+Ewoy9u3ainqULfpql8hwkyjKkIQwc50akwV9D3NjnCkJhjkalSzNJ5lqfeizz/zJhpxkGasOvIk2tKve1jeccbLImpqEbr8qyvOX7gDpeZKgdlscENqOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434219; c=relaxed/simple;
	bh=nFXm/L4ae8YekLwpIFurgFERbAtgq26xVgDJzO6g1yM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UUnbf+kxst1LhlYbKHTkKeTjcpclEQuhXU7rR0qP0b+jfGCCpAILWnUQYnj/mKKKieHNWioTr4Ur1J6EcHd4WlkT2uq2q+IozwfAkvbx3YP/tsayq2y0A6yXorpc13ha2FGBongtp7gr+EIFI800TlL7feI5vi2sPHk2sBWZW4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=f332KYpY; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e292926104bso5390426276.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 09:56:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434217; x=1732039017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gek1GO8SPggpZ3MPgZMTTjA2lPqNZurY73wIWpdWbQQ=;
        b=f332KYpYpBj1sNEzbQQiUwIsoXIXb740XNNn6oYti/tlb0A5yFHmlUM+Xz2fVgC3qb
         G2cOovDqa0D+gIg+M1jcuXvddsZM8+q+9+7YiIEa5bfwu9SOlpcsK/SR8Mb1CPdbeqiv
         oJvXFVWvnoxMLM+hbLDaDQoEOz/pKwJ0oLGAuAewzusuFzb7i5wvX1Bth1C7NzNjn2Ju
         RvC0tKgwPSglViSeJe1lkf+Gnxz1a/+vM5yNW74bpV0OEhxcFom4VA6pbkQOig5ExYMI
         IqRa0BafjNl5x7ificOp7pj/f5X8YnhKLAl+wMZ9X1M0LVFC9VSswIBCFh5/r31jqrwS
         RwKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434217; x=1732039017;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Gek1GO8SPggpZ3MPgZMTTjA2lPqNZurY73wIWpdWbQQ=;
        b=sq402yqeI62je833NAQsowMa7H7lW+PlzZaV1yjwt5bwNGfrmi/dxtvz7tRYeBY8OC
         if0FyrSDx3W0HYoPQRFspHRnudCDqncUnezjtpofEptZP9ee1U/GVDrHUCFQaeVGvPco
         8W2X+fJYHdIUWK6IFJAsg1PRLpMGhZD927yTiOo7k/FSEJf9TVDGyaV8SUf+ban6+1fb
         fwAaMKXoCsh5Mp8AMsrx5mBvcdC59iic9Cn+0Nw7gHbM7Pcg2hQOCUT8q35ieaKDJ7Dh
         oPdj+b6A7EHbMWh+W6EJtspd2XQXQN9x3ImXcgLljIzQ7VWRbOBwVzSLgD/RKwNayRFk
         jLSA==
X-Forwarded-Encrypted: i=1; AJvYcCXFyG+wTgsNQgp1gSAc2fDXg9rxlAFwAHX9r+A1ySNWe0yW7zJDVbBAJaQhNuJ52kzaAS7J+LCOxRXk@vger.kernel.org
X-Gm-Message-State: AOJu0YxuV2A5IHVFbbB8Bu8GhO61k4AZ5JsArRS8ZFsUe21s3Ip8Ldvn
	/3D8K+y5poOpIfUqqNadp9ZHyezT0zkJxCXATD0Gdj6+lHcsY711HtdkBTo6xXw=
X-Google-Smtp-Source: AGHT+IEseNU1fU18+Eb5Xypvfn1vm8TMH1JcpZ3Hifh4Ob7CJlLkVA7fH8jLCYaFBtppEHVnywJ7Bw==
X-Received: by 2002:a05:6902:1ac1:b0:e30:e59b:4a40 with SMTP id 3f1490d57ef6-e337f8822d4mr14895613276.28.1731434217050;
        Tue, 12 Nov 2024 09:56:57 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336f1ba498sm2747524276.46.2024.11.12.09.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:56 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v7 18/18] fs: enable pre-content events on supported file systems
Date: Tue, 12 Nov 2024 12:55:33 -0500
Message-ID: <476c173aa514c889cfb3d9a1dcf3bb333a223ef7.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that all the code has been added for pre-content events, and the
various file systems that need the page fault hooks for fsnotify have
been updated, add SB_I_ALLOW_HSM to the supported file systems.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/btrfs/super.c   | 2 +-
 fs/ext4/super.c    | 3 +++
 fs/xfs/xfs_super.c | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/super.c b/fs/btrfs/super.c
index 97a85d180b61..fe6ecc3f1cab 100644
--- a/fs/btrfs/super.c
+++ b/fs/btrfs/super.c
@@ -961,7 +961,7 @@ static int btrfs_fill_super(struct super_block *sb,
 #endif
 	sb->s_xattr = btrfs_xattr_handlers;
 	sb->s_time_gran = 1;
-	sb->s_iflags |= SB_I_CGROUPWB;
+	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM;
 
 	err = super_setup_bdi(sb);
 	if (err) {
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index b3512d78b55c..13b9d67a4eec 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5306,6 +5306,9 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	/* i_version is always enabled now */
 	sb->s_flags |= SB_I_VERSION;
 
+	/* HSM events are allowed by default. */
+	sb->s_iflags |= SB_I_ALLOW_HSM;
+
 	err = ext4_check_feature_compatibility(sb, es, silent);
 	if (err)
 		goto failed_mount;
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index fda75db739b1..2d1e9db8548d 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -1713,7 +1713,7 @@ xfs_fs_fill_super(
 		sb->s_time_max = XFS_LEGACY_TIME_MAX;
 	}
 	trace_xfs_inode_timestamp_range(mp, sb->s_time_min, sb->s_time_max);
-	sb->s_iflags |= SB_I_CGROUPWB;
+	sb->s_iflags |= SB_I_CGROUPWB | SB_I_ALLOW_HSM;
 
 	set_posix_acl_flag(sb);
 
-- 
2.43.0


