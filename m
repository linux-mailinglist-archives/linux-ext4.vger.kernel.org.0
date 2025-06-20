Return-Path: <linux-ext4+bounces-8568-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D99DAE195D
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 12:58:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E5987A27B9
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 10:57:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6934228B4EB;
	Fri, 20 Jun 2025 10:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PsXgRs8O"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBFE28A726;
	Fri, 20 Jun 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417050; cv=none; b=OJd5Zsi2qUEeCD7N+R4nU0sYRMkge2yYdNDNXaAG5UAqL8DNXhlmhvjz43cyhL6Q/F5bAtjJvHch0Hdjjn3AT7/0KpFgRqLa/HmMfLvSkL0bDfN3f7AGpDUhdKYPXPe1yQd1FVppopBHQbiaugrAIfjzsNMqJraP55gROvG75+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417050; c=relaxed/simple;
	bh=+T4MKSWdsIjPwq7v/X3d5MxVaQFBiaCAUlHggc0nYyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WLKt4f41xt8cygKh2sKLnayxZtuZLwJGFWXQu+8tD0DSQPSk+E0B4Nm1EBFaQm/QVjbOp1PsW/ERvwMPgVSxhrZHOoZHBNMGwRYTiPzNIK2SQG3g4kbebPElh7KDt83Zshzapg2f546MCnFKiOe8RfYLg5eE+egDSTCi75hUI0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PsXgRs8O; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2352400344aso16750975ad.2;
        Fri, 20 Jun 2025 03:57:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750417048; x=1751021848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E/SSTeD5INnDMSlbYCrgdkKOcD8aKffVGoAdYJgE0hM=;
        b=PsXgRs8OH/nWnrhGuEnhkEyh1t7XOTmKsaxrJuomSXjE93MqWBzYhsNAOxLtI2SYvF
         0eGxMJ8nFkhKYpJKFX5Q4ug78fvGeQ4Vg4kejz77RFN7ybUxeTpeEQ9ejHR0b2QyOH4c
         4YycDGuSLWNdOa/f6uDOL9r6y73VnEL/l1eCrPkSOjgnrUtS7AzwfIpUAKvJjeUcKPu4
         V6iEORF/SykiZU1mZFT4uE0ovz3AB/IzvZTglvBtU5Y+mC6xhCBXdFCVnh7yRzbo1nNc
         93y42snCr21KbvxLD3sG9or8IfRwOM9hupzxRvsBcs+6db6G6CgFAblb9J1j7Ax2C776
         x4aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750417048; x=1751021848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E/SSTeD5INnDMSlbYCrgdkKOcD8aKffVGoAdYJgE0hM=;
        b=MMvwkt1CmCnIHq2iOBQGZwD9r7xcI70vmjeBuitDvCbSD1VEA9MGlHGfmOS9sZQ8+s
         jzrOkr3qqAzxIVJgOL6n9rW2ypUR1wGVzxbctX/a+LuvU0F2vDFPGeProJJDp0sHS06M
         biAyNqDyKukQH80vHpVdHZM4etlS8aYkOhYvVLc7AX8th0NTjS9xzwfnSf30C50rNdQ3
         SoJDZrMja/u+cnQFKWsf9tMJJcjzDRI2WXlfDFTq3h76QcItCdOCe09GaLeLTu1e5s2f
         p+evkYTIco8iveggjKFOl+grhJw6tAoQ5Z2DNWdrVFc5PvWgdIyMgh6gg8Ce/A9OKq4D
         xVSw==
X-Forwarded-Encrypted: i=1; AJvYcCURY3HCkUULL8Va4NXQtFVg3LmaFtA11D8UugJBfyooEELtlb/Gf1EtCTqYIc5f6uyVOOm84TV/hBo=@vger.kernel.org, AJvYcCX51H62zuitKwZF54jVoTfS6+1XRMvtID8VzOTqZZv2rq166FlvzarqFB2nfVYAy04gAwCy2BeqcNorlg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2VQcdGI172W1siN6NjM9ip6xlTiepJyf3LTWZ88rUdDKIg1if
	80rYaESp2qC78dJYfJI38hP2q7NXwlpnIus0eVLklHSBCSxVg6lGln63
X-Gm-Gg: ASbGncvuxV8tX+wlZ+JaSZUyeIrd1gTetU/nOYPPiWTlskTVXKiwfxaJS5WlPJ0ntpZ
	/BpSdy0N43WHFVYbP+OPNy4IP3oLnM8oaz6qs3GttWXInhH2ND/bkT1qdVpPUpu10Nm0C40Mtxd
	bVN259wNfWJsACV+NOVyjVIOZwhLa/wUgDWR7BmG6j+hUIixCJmPS0FPawlNRaKcaWSt98wh+BA
	6zr/Ih+mISLNpLfD2CIw/Yng4JhCT0HszcnRMyFdkGE1PqZsj2vD17RzRrBJGZzwKqjfxHTfxp/
	aHne/JshC6e03vxw6U3zbq2/oB8B5xZjLqP0DAUS+F12pv4M1D0xtCkSazAjVg==
X-Google-Smtp-Source: AGHT+IFjIS/UxczrAh5+l+DmG908FynEuQ5swZHGAIC6iYmHhIM2uJPssMw5jdXnzg1z8IgfH34JZA==
X-Received: by 2002:a17:903:196b:b0:234:1163:ff99 with SMTP id d9443c01a7336-237d9af3066mr36120745ad.43.1750417047818;
        Fri, 20 Jun 2025 03:57:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d86f8261sm15269165ad.221.2025.06.20.03.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:57:27 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id B9BDE40AD72B; Fri, 20 Jun 2025 17:57:16 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 5/5] Documentation: ext4: Move inode table short docs into its own file
Date: Fri, 20 Jun 2025 17:56:44 +0700
Message-ID: <20250620105643.25141-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620105643.25141-2-bagasdotme@gmail.com>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2511; i=bagasdotme@gmail.com; h=from:subject; bh=+T4MKSWdsIjPwq7v/X3d5MxVaQFBiaCAUlHggc0nYyU=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmhtvc282jEmvgXfItR2COryLd4bvPahwEFeze9/bl+k TrDLbXQjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEwk3Y6RYffye48u3f4vv/tu wDSNWYs2l8nUud0MOShyzyPYyuHY/j+MDFMVf3Kl8FQFiv6beOXxc2NxP5bA17MmR2ZkZT6+Fxk YxgIA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

The short description of inode table is in bitmaps.rst alongside the
proper bitmpas documentation. The docs file is short enough that it fits
whole browser screen on desktop, which implies that when readers click
"Inode Table", they will essentially see bitmaps docs.

Move inode table short description.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/ext4/bitmaps.rst     | 7 -------
 Documentation/filesystems/ext4/globals.rst     | 1 +
 Documentation/filesystems/ext4/inode_table.rst | 9 +++++++++
 3 files changed, 10 insertions(+), 7 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/inode_table.rst

diff --git a/Documentation/filesystems/ext4/bitmaps.rst b/Documentation/filesystems/ext4/bitmaps.rst
index 91c45d86e9bb56..9d7d7b083a258c 100644
--- a/Documentation/filesystems/ext4/bitmaps.rst
+++ b/Documentation/filesystems/ext4/bitmaps.rst
@@ -19,10 +19,3 @@ necessarily the case that no blocks are in use -- if ``meta_bg`` is set,
 the bitmaps and group descriptor live inside the group. Unfortunately,
 ext2fs_test_block_bitmap2() will return '0' for those locations,
 which produces confusing debugfs output.
-
-Inode Table
------------
-Inode tables are statically allocated at mkfs time.  Each block group
-descriptor points to the start of the table, and the superblock records
-the number of inodes per group.  See the section on inodes for more
-information.
diff --git a/Documentation/filesystems/ext4/globals.rst b/Documentation/filesystems/ext4/globals.rst
index 2264b76e873cc9..c6a6abce818a17 100644
--- a/Documentation/filesystems/ext4/globals.rst
+++ b/Documentation/filesystems/ext4/globals.rst
@@ -11,6 +11,7 @@ have static metadata at fixed locations.
    super
    group_descr
    bitmaps
+   inode_table
    mmp
    journal
    orphan
diff --git a/Documentation/filesystems/ext4/inode_table.rst b/Documentation/filesystems/ext4/inode_table.rst
new file mode 100644
index 00000000000000..f7900a52c0d5da
--- /dev/null
+++ b/Documentation/filesystems/ext4/inode_table.rst
@@ -0,0 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+Inode Table
+-----------
+
+Inode tables are statically allocated at mkfs time.  Each block group
+descriptor points to the start of the table, and the superblock records
+the number of inodes per group.  See :doc:`inode documentation <inodes>`
+for more information on inode table layout.
-- 
An old man doll... just what I always wanted! - Clara


