Return-Path: <linux-ext4+bounces-9102-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DCC57B0A433
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 14:27:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 268925879CB
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Jul 2025 12:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D11B29CB40;
	Fri, 18 Jul 2025 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cYyFHEWp"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6EDEEBB
	for <linux-ext4@vger.kernel.org>; Fri, 18 Jul 2025 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752841622; cv=none; b=YCr3+WUibGP+gHLyyIb46WLKPP+QURsLpdvYkQ1FLJZ5DVycMd8b11kJB8Jt3rVSa5T96pQCRyv1FgzsCkAaOEz+YWvt0k2jB6Bn8CLEWNvDEXQub2b5+C+R6H21YySSy082niA6Rvzc7I469YWnljBN+d4YUseGkgNmM/IxAdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752841622; c=relaxed/simple;
	bh=1I0eJE09Xe+eDrE7DivGP9da9tGfOALWYLU6lqq8jdY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pKNipEvKArNgcIlM/C0fELwjjIrdr3meJ5W9pfx8Jqb4M1fQYQt/UzHbXb2VWsPu/MSGdtrDO6FOWqWLZxKReuC7nwB2WsLX9MxMIxgZXlTrwqmUzOxT88R+F7nk+rMw/VuJhbLbWEBBrdHK8zSdybbFITWJLqgOH26UgkyTCdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cYyFHEWp; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-742c3d06de3so2324631b3a.0
        for <linux-ext4@vger.kernel.org>; Fri, 18 Jul 2025 05:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752841620; x=1753446420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=euT0kuunlkuST6UdaEifKtCnLV5EhAyYSxRTLnJNhYk=;
        b=cYyFHEWpJZY9EYY05vAu0t/lgUePJZOqipOI15vmTnuKQQwNlpCuvCHPFdo6XuCVwU
         Bv3x5rhDTJ3MvZ4zV94kaCrTqcYG0NsQIzaroPeGScL7J6flpPnGU40F8y8DebBMvf/w
         JuNunh28GzUm8eP0r66IONz275XsMjjyRySKBvu7c+RgLL9sjwD3fsPEtTHrZKasTAhU
         LZTzdGdRhRKoLUhafRQ2oNnZ8ozVvGtmpUgoRXxzngidVo+swULYZUHCdJIMGTZGOhoP
         T0iJVp4RKqZrWoBoOggMuYVBZCPGsHtu5VlrC798U6cG0WWfnBQ0VlNFuUUEnD372uGh
         fWbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752841620; x=1753446420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=euT0kuunlkuST6UdaEifKtCnLV5EhAyYSxRTLnJNhYk=;
        b=nn55ELJoDE+tHbjUxjUfXNhDU1SE01OlANuYpQyxCbqppUHe9+rIgClap+Q64kQ5v7
         +RsudzNYsbSa9XgOVLUW6LBDmT/E0+cUbekfUiyIbKhSc1wJx10/Riyxk8F5d6oXkOy+
         EpfUQeG/RWlR0GxC9NcWZ5mi+yQi597LplfW1DL2rCpTHDsFF10ipHaeJRhrcY4ABrBF
         VoGOiY12zQdeaEccJ9xsJNs14TTmZwKo7inJjNzz/B9cQTUkoTgKOs9R6DDsMXNYPivU
         SYkfRPZfjj+QlAbLsRb3y/nI5iHYcAfiYcnp/J40aKGE9RXl+iH3iGP4U3wGxmxal4pM
         1BsA==
X-Gm-Message-State: AOJu0Yz3k83jp/Hi/gxh7+7WTCfDJuE1QM20NscYKM8V27SmHMKYHs5w
	MLEDttpkIcrZMGfnSK/ggSbmHjoEt0ZmZDctd6Eu+5ydFrSCO40xzDeN0q065kEm7gQ=
X-Gm-Gg: ASbGncs+yafwVQF/wVWjiu/+Ab+aJHCmyofOxwYfkPLWrIjmmpL1NOxDr69KVVEH6bU
	jxPhYkb1PjyM4kafQ+f6unwSjNLJDqXVpnogBdPKn8sNzKOlMS4QHAg8qR9YEByXmLDvM06mB3F
	7sJfETmXdlq7lYr6dqpqFtX3pCHbJdG291zHBY/+xNdetzod/eEl8F6yKmn2gM+mnhMHWhUrWIH
	wVjiq90mwg38URzxqed/rT8A8/vhjO3NS0ih1QiXCZppO2LSj1L40nRZGPH9ybyc6REOZFgoUcr
	p5PL9h51lEiL/nrkuBs5c9YvlfrCJNzbfmzliW74Vy7S8UnGggoG+COCUztYiHUfRqlt9orrBSF
	nJSsJ+kitka9y5xz151AXnhVz9D5zrjBrxA7mPeOxrsOJYmARur8=
X-Google-Smtp-Source: AGHT+IHAQV7Zou4aUSM70trhlED7Ncw2LIAglVDYG142lIgEdLYyTTJ+aKTmRt5DhN4yBwJzKFPafA==
X-Received: by 2002:a05:6a21:3d8f:b0:239:c5f:62b5 with SMTP id adf61e73a8af0-2390c5f65d5mr7750666637.1.1752841619778;
        Fri, 18 Jul 2025 05:26:59 -0700 (PDT)
Received: from DebHP.lan (67-61-129-104.cpe.sparklight.net. [67.61.129.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-759c89cfac8sm1173197b3a.35.2025.07.18.05.26.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Jul 2025 05:26:59 -0700 (PDT)
From: Nicolas Bretz <bretznic@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	Nicolas Bretz <bretznic@gmail.com>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH v2] ext4: clear extent index structure after file delete
Date: Fri, 18 Jul 2025 05:26:54 -0700
Message-ID: <20250718122654.1431747-1-bretznic@gmail.com>
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
Closes: https://lore.kernel.org/oe-kbuild-all/202507181723.sbpIHkU3-lkp@intel.com/
Signed-off-by: Nicolas Bretz <bretznic@gmail.com>
---
Changes in v2:
- corrected function name. Due to my incorrect use of git, attempting to ammend only the message led to code changes being reverted, after building successfully.
---
 fs/ext4/extents.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index b543a46fc809..cec4f9ac9423 100644
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
+			if (ix && ext_inode_hdr(inode)->eh_depth > 0)
+				ext4_idx_store_pblock(ix, 0);
 			ext_inode_hdr(inode)->eh_depth = 0;
 			ext_inode_hdr(inode)->eh_max =
 				cpu_to_le16(ext4_ext_space_root(inode, 0));
-- 
2.47.2


