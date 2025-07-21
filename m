Return-Path: <linux-ext4+bounces-9130-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1453B0B9E8
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 04:10:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9FB1770C8
	for <lists+linux-ext4@lfdr.de>; Mon, 21 Jul 2025 02:10:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5590319309C;
	Mon, 21 Jul 2025 02:10:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXRS3McG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BF4317996
	for <linux-ext4@vger.kernel.org>; Mon, 21 Jul 2025 02:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753063850; cv=none; b=qzlcVvosKoFXmdPdf3qgwR/zogS0txAkwFUZjmxNr7CtwZL/TAHhUo5Ub5yxDdcpBZdCU0R8Z3dlOGV25w5hO83TUP6W554skioxyy3yjsP4vBAa7IHm/0qG3xQuTsEGJknWxZjsmXgylpbde7D3YfHuNy+hxoqTIUzpqpz1Cv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753063850; c=relaxed/simple;
	bh=B/cFIOEA84pH8P+zWXj0czwJYRCHIsbDVkAXMg8pmnk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qvCczGoVsTfZQjVGmytYhhXzPMAF5+Ttza4xWX4Bmvm/preUa/cLy3kIqICwkuRt6bXXUhNvHie6SzG41/7mNws5Ny3O2SBI10do8LxDUhCiBeAHDbK+gxQCn7zEVz6jue2eqV96AcyKjKgX0ABrS+qYxAUiMWiOHrm3P0sXm7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXRS3McG; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-74264d1832eso4913680b3a.0
        for <linux-ext4@vger.kernel.org>; Sun, 20 Jul 2025 19:10:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753063848; x=1753668648; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2yutFf3IespzGrSu0kd63HlJYzzZKIkt8NwKkpdeSqI=;
        b=kXRS3McGosunfLLv8Me8Js3Ob1ZOgO0NsVqVffcVK/Qpvcl0N9kc9CaCcv6n3I62/5
         4tzfjm6VqC9pJhj/1HmgjwOzXyigkMHBUuQx0JFwajPB1sjExN9Bf4vykdPA4YmuST16
         8FNOySRVnda9H7EFdO1Tbj6G8Ar66x+muauVO2Fdf6rQ0NjBRpxfYqsuoBvLKBQEJxTw
         c+nZM2V6c4uB0FmL4plsiy9IuAWWoqnEdkl52+ss4JWli6RhXCMgn55ObvqE/IKklRTP
         hZkbvhzj5ehg8Tk/lxpENLudVtgCFeqS3PdAEB6AuBcCQLPDkhv49cEtpl3YbMDpDgmd
         /BZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753063848; x=1753668648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2yutFf3IespzGrSu0kd63HlJYzzZKIkt8NwKkpdeSqI=;
        b=Rut73lZUXaoSV2gKAUckMRnL19ftlHbtXYgzaIPmiw5n5uhYLS8tyijfAPa8jia08x
         2X17lv2gqYxJ/f6FbAQxmvtwxPdNguHSCJvKESQzqMS4WzJBQ2xcI6fm4PVUgSzSIfaC
         Fsho9RefUgVH067gEetkXlL+i7CtqWdIiUgmxZIPeBi3PXZAEV3PFjSv3C2Pv5nPQSnL
         VnpJ/fb3uH1OrLXksHUmDagRmFw9OpelrOxcOzrgzgnqzIU8T5spce94NYBvwZg9TM/N
         5aji3T9C4yf936kBX2dkxct5D5qqxhcR9Wa9EGFAriKAz1XFxgW6S2wajYzZ9odd6zYP
         0A8A==
X-Gm-Message-State: AOJu0YxOubrNs02oTc3W+Dp2v3AUerGfehDtzTwP1ldK5+l9PFrzczYP
	LchRHCzce8hczygwaxz4s4swlmh9vTXFENcvyp0Fn8QyfTOpS+YdDMkK
X-Gm-Gg: ASbGncuD5Jx/6Q+bqc6vl1lcQZuUli90X1JIPFRcdMpLpT+lwGW0jNRP4Fd4UkmA/TU
	WpHImfI3RNjM+by/2xF3SO20goF5nWwatS+R4xX33SPGThYj8iaUEKiTdpI9Z8Pf91hmEMyOhuE
	ra3FAJJblMG60lp9cba+Ol3g2N7WXAIDbl2LgsnX7KMizHwrFc4pwxxWwQpx6I6qG+lwikSqm+V
	QQ90jDHXG1+ZV3kdAC/D2Oo8OVpGJt9V7KkI3PakcUnvbLpWSj1GKaxKq0vWHX28jZIuCDmsDrB
	QuV3ek5uCgE8UUkZFCuLuuIFuYgC2ypqx52f6Q9EFZ+7i0wvANLDPeBB+90N+woq8AK8OYYMlti
	2SvD2O+uMAZ1eXoKi75fOsb7xxCFakxHjqC03kMihD3iN9t0M5d4=
X-Google-Smtp-Source: AGHT+IHpJhGt21PxLxW1ju+ycAxrfpYVXajI0fwLbDXOcUPDN+l3tEkcN6XM7cCz307XMGIrRvCA2w==
X-Received: by 2002:a05:6a00:a15:b0:748:f750:14c6 with SMTP id d2e1a72fcca58-7572508174cmr25810553b3a.14.1753063847795;
        Sun, 20 Jul 2025 19:10:47 -0700 (PDT)
Received: from DebHP.lan (67-61-129-104.cpe.sparklight.net. [67.61.129.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759cb76d53fsm4742535b3a.105.2025.07.20.19.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Jul 2025 19:10:47 -0700 (PDT)
From: Nicolas Bretz <bretznic@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	Nicolas Bretz <bretznic@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v3] ext4: clear extent index structure after file delete
Date: Sun, 20 Jul 2025 19:10:44 -0700
Message-ID: <20250721021044.2402436-1-bretznic@gmail.com>
X-Mailer: git-send-email 2.47.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The extent index structure in the top inode is not being cleared after a file
is deleted, which leaves the path to the data blocks intact. This patch clears
this extent index structure.

Extent structures are already being cleared, so this also makes the
behavior consistent between extent and extent _index_ structures.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=220342

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202507210558.sazSHcm1-lkp@intel.com/
Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
---
Changes in v2:
- corrected function name. Due to my incorrect use of git, attempting to ammend only the message led to code changes being reverted, after building successfully.
Changes in v3:
- corrected sparse: restricted __le16 degrades to integer
---
 fs/ext4/extents.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b543a46fc809..17591a99dafd 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -2822,6 +2822,7 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 	struct ext4_sb_info *sbi = EXT4_SB(inode->i_sb);
 	int depth = ext_depth(inode);
 	struct ext4_ext_path *path = NULL;
+	struct ext4_extent_idx *ix = NULL;
 	struct partial_cluster partial;
 	handle_t *handle;
 	int i = 0, err = 0;
@@ -3060,6 +3061,9 @@ int ext4_ext_remove_space(struct inode *inode, ext4_lblk_t start,
 		 */
 		err = ext4_ext_get_access(handle, inode, path);
 		if (err == 0) {
+			ix = EXT_FIRST_INDEX(path->p_hdr);
+			if (ix && le16_to_cpu(ext_inode_hdr(inode)->eh_depth) > 0)
+				ext4_idx_store_pblock(ix, 0);
 			ext_inode_hdr(inode)->eh_depth = 0;
 			ext_inode_hdr(inode)->eh_max =
 				cpu_to_le16(ext4_ext_space_root(inode, 0));
-- 
2.47.2


