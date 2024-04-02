Return-Path: <linux-ext4+bounces-1815-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAAB9894989
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 04:48:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB7201C23E6D
	for <lists+linux-ext4@lfdr.de>; Tue,  2 Apr 2024 02:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51790134BF;
	Tue,  2 Apr 2024 02:48:16 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail.nfschina.com (unknown [42.101.60.195])
	by smtp.subspace.kernel.org (Postfix) with SMTP id B67CE111A3;
	Tue,  2 Apr 2024 02:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=42.101.60.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712026096; cv=none; b=QKZzXcGdhG29Dttj4R5wu2WkV1yEoj57DYqcEWrkM4fvD/rNa9qKxxAumk/yqdxwXgdVGbaWaetXWnXK841ki9b+nx/jYK1HBfc4L2pkrk9yuDU3o0D1mVGwqywDFAGLHO9nk2Halq1zvkNpGGyW6eyYaEUcQ7vFh1ePt0DPn6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712026096; c=relaxed/simple;
	bh=BDkfVkHHxWVJzVoMUvSky86KdCjI582r8cJyMa1bl8U=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=M7+D71ElMK31HT4ArCK5BRA4zDKZob33EZgNhjG1ra2yh9zoyTe+J21TD4iLQXLDGgTLOiPmLgXsTEItYsSCRxVrzYZ+ok3v4ntJTASSxqaZ/K91vELLalG6dd3m2iL4IEtDZ0056qAkYCtQ7gASrxYAHPLNVSOcA/AlxG5zHFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com; spf=pass smtp.mailfrom=nfschina.com; arc=none smtp.client-ip=42.101.60.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nfschina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nfschina.com
Received: from localhost.localdomain (unknown [219.141.250.2])
	by mail.nfschina.com (Maildata Gateway V2.8.8) with ESMTPA id 7E6EC605E181C;
	Tue,  2 Apr 2024 10:48:10 +0800 (CST)
X-MD-Sfrom: zeming@nfschina.com
X-MD-SrcIP: 219.141.250.2
From: Li zeming <zeming@nfschina.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Li zeming <zeming@nfschina.com>
Subject: [PATCH] =?UTF-8?q?ext4:=20extents:=20Remove=20unnecessary=20?= =?UTF-8?q?=E2=80=98NULL=E2=80=99=20values=20from=20ablocks?=
Date: Tue,  2 Apr 2024 10:48:04 +0800
Message-Id: <20240402024804.29411-1-zeming@nfschina.com>
X-Mailer: git-send-email 2.18.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ablocks is assigned first, so it does not need to initialize the
assignment.

Signed-off-by: Li zeming <zeming@nfschina.com>
---
 fs/ext4/extents.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index 4ab96f01a6f31..caace8c3fd3c1 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -1061,7 +1061,7 @@ static int ext4_ext_split(handle_t *handle, struct inode *inode,
 	int i = at, k, m, a;
 	ext4_fsblk_t newblock, oldblock;
 	__le32 border;
-	ext4_fsblk_t *ablocks = NULL; /* array of allocated blocks */
+	ext4_fsblk_t *ablocks; /* array of allocated blocks */
 	gfp_t gfp_flags = GFP_NOFS;
 	int err = 0;
 	size_t ext_size = 0;
-- 
2.18.2


