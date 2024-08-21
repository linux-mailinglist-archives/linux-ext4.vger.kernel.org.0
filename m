Return-Path: <linux-ext4+bounces-3829-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3358B95A145
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 17:24:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4C7028471F
	for <lists+linux-ext4@lfdr.de>; Wed, 21 Aug 2024 15:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D79EB14E2F1;
	Wed, 21 Aug 2024 15:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b="KATOPcYA"
X-Original-To: linux-ext4@vger.kernel.org
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B75F14A616;
	Wed, 21 Aug 2024 15:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.60.130.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724253831; cv=none; b=ceK4GD1+2CSJjPu9P0/7jAZJdMkS5eaIxvHP8I8DMkPLU15lztEXdMFbxPgQdwpDOmL6t9IiEC92OSKkAioHZUOtDtU0b56UYOWOrEOQXhrz9Cs4zNU3+qLsyTt3NXZlzCeCuvXxNWkhiEgdxUQOzXioW1JY3yAN6GM4MhYi0+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724253831; c=relaxed/simple;
	bh=PV3LTyk/h1H/t/vq5CFcNW6yFGdHWroQo8CUz8eyEQo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Enw71yJGI8tpmbOw5HkNjzxUJQ7oHaLzJl4riXFTZ+CaDNwVn/SA3DMYLLSk1/XSIhGdg/YDIItCAoQhqnOAyb+k9RNnc4goCEjWQRoR3yk8ZIW8Odl+MiG2ANxM/C2oXzpoloM1lxI3vUXm3WweraRC/zx77tJ+r5ucT1dxjWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com; spf=pass smtp.mailfrom=igalia.com; dkim=pass (2048-bit key) header.d=igalia.com header.i=@igalia.com header.b=KATOPcYA; arc=none smtp.client-ip=178.60.130.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=igalia.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=igalia.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
	s=20170329; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=D9fChryXthG3wcw0LMI3xnsVZzO17Nv2/ZJYCPg57RU=; b=KATOPcYA5kffn8GNz2cAKcn+ew
	GnK5PngGp/ttrFwhYoM9/HwaOJTJn0PqgkYCD54yw4giop8jlwJjub8xbdaAYUv7TiLG7/O/5fro9
	cZ6uEdQvS7DLD2kk64vPHFe7TE3DuWCbR2Yfgpo+qivmL/0WjEQ9LNhNb1wA9LU+FyErxSY8kVmB+
	W53qCdlK1sbmcQ9vD2Ntojdl4eUba/lW4GoghPAUuyWvXtVnxDjGLg+mz9LgqLlHJ/4nyjddIM/Qc
	j6Kyigvz28fGhAk/bzdtaKdKcvGnk5MlOrBjXgc9vzkwNV6+73dYZfuxjRk9OYdLYmUfCYFehDUWO
	gW2QGHqQ==;
Received: from 179-125-75-209-dinamico.pombonet.net.br ([179.125.75.209] helo=quatroqueijos.lan)
	by fanzine2.igalia.com with esmtpsa 
	(Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
	id 1sgnBZ-0034iV-PM; Wed, 21 Aug 2024 17:23:45 +0200
From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
To: linux-ext4@vger.kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>,
	linux-kernel@vger.kernel.org,
	Tao Ma <boyu.mt@taobao.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	kernel-dev@igalia.com,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Subject: [PATCH 1/4] ext4: ext4_search_dir should return a proper error
Date: Wed, 21 Aug 2024 12:23:21 -0300
Message-Id: <20240821152324.3621860-2-cascardo@igalia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240821152324.3621860-1-cascardo@igalia.com>
References: <20240821152324.3621860-1-cascardo@igalia.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext4_search_dir currently returns -1 in case of a failure, while it returns
0 when the name is not found. In such failure cases, it should return an
error code instead.

This becomes even more important when ext4_find_inline_entry returns an
error code as well in the next commit.

-EFSCORRUPTED seems appropriate as such error code as these failures would
be caused by unexpected record lengths and is in line with other instances
of ext4_check_dir_entry failures.

In the case of ext4_dx_find_entry, the current use of ERR_BAD_DX_DIR was
left as is to reduce the risk of regressions.

Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
---
 fs/ext4/namei.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6a95713f9193..8af437ac3051 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1482,7 +1482,7 @@ static bool ext4_match(struct inode *parent,
 }
 
 /*
- * Returns 0 if not found, -1 on failure, and 1 on success
+ * Returns 0 if not found, -EFSCORRUPTED on failure, and 1 on success
  */
 int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		    struct inode *dir, struct ext4_filename *fname,
@@ -1503,7 +1503,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 			 * a full check */
 			if (ext4_check_dir_entry(dir, NULL, de, bh, search_buf,
 						 buf_size, offset))
-				return -1;
+				return -EFSCORRUPTED;
 			*res_dir = de;
 			return 1;
 		}
@@ -1511,7 +1511,7 @@ int ext4_search_dir(struct buffer_head *bh, char *search_buf, int buf_size,
 		de_len = ext4_rec_len_from_disk(de->rec_len,
 						dir->i_sb->s_blocksize);
 		if (de_len <= 0)
-			return -1;
+			return -EFSCORRUPTED;
 		offset += de_len;
 		de = (struct ext4_dir_entry_2 *) ((char *) de + de_len);
 	}
@@ -1663,8 +1663,10 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
 			goto cleanup_and_exit;
 		} else {
 			brelse(bh);
-			if (i < 0)
+			if (i < 0) {
+				ret = ERR_PTR(i);
 				goto cleanup_and_exit;
+			}
 		}
 	next:
 		if (++block >= nblocks)
@@ -1758,7 +1760,7 @@ static struct buffer_head * ext4_dx_find_entry(struct inode *dir,
 		if (retval == 1)
 			goto success;
 		brelse(bh);
-		if (retval == -1) {
+		if (retval < 0) {
 			bh = ERR_PTR(ERR_BAD_DX_DIR);
 			goto errout;
 		}
-- 
2.34.1


