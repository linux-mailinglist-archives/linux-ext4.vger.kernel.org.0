Return-Path: <linux-ext4+bounces-1422-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D444986C091
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 07:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E842289BCC
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Feb 2024 06:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5293BBFD;
	Thu, 29 Feb 2024 06:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gLpM2LI2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0363BBF4
	for <linux-ext4@vger.kernel.org>; Thu, 29 Feb 2024 06:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709187024; cv=none; b=DtpaTp109s8bX2qVZkrkb2MCnqa29TojEurx+5qx8ENGz9rS/zRNY/6s5E0tpcylPkvhy8fyL1/dckrcOPkmGyYW1GNn3P6jFVYwWgk3EwJ6LCWokb8WF2S8xPTdwNYykm8bIVlOqh+9Ucgg/k6hLzxKorFne6Q76Uat6w0/Fkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709187024; c=relaxed/simple;
	bh=5mtKV3lq32PRHhvk5ozP22Uq/yyEIZ/zp9p0r0Gxp58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=awcWEM6vAvXMtK82cHtN8OjynntkZKAsPlco3GIGnjGOybM0dGvhvjBWtOIDCVfMXkWep0h7IadBFEjATOsNQuh5+ZKvzOFcRgs0dXPXr8uIKhtjLprt1TTDPS3COFpxi8ZbDi96wf5yatUPPQvgXufI0S4xEfaeyReKVIwpm/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gLpM2LI2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e55afcf513so306623b3a.1
        for <linux-ext4@vger.kernel.org>; Wed, 28 Feb 2024 22:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709187021; x=1709791821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5P8oG1c/7DSESFr6JtoQmKhazwi5rpIXaMqKZ57x4o=;
        b=gLpM2LI249tXMRigMw2S5H52XsInSDWOgB5G5znFuVaMCcQLNCGwSspYCHxJau9xZL
         FP+DDJIJHiw+aLlShaym3inFLUsRhZad/hv1ZZja3cQNJ0AX8TgK9raVGPjC/2BJRwVM
         XPXI/u8WYwzb0WZlAWEBIhoUcswW6YIivHJUa7d67CPAAbQ5SUzRJmzqB5yLq3J+yIAv
         F2QhgczIlzflT2BSKB/gS3UaH28vS8ulXVwcxG27twrcGWcUR84CoW2dHpvZS73LKMNM
         51n4a2Wpli0/fWgSmspYmvMgRgF+33SLBY6ePEqKWgFL38x5+PghvEwpSSuDQzWOWkpc
         1HHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709187021; x=1709791821;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q5P8oG1c/7DSESFr6JtoQmKhazwi5rpIXaMqKZ57x4o=;
        b=qEbA5Hg92oTnfRPoZc8Fdlfcreb+ZM32YElxFSE2zVRGnQe4wpO0psVZ1hOZZRRFqF
         GWm1GZ6XjrWF4XLS1jJpk6PsJifevKe3hJCA4hJrOzb46W2avF3IL+tXEqIiIRyco8uE
         FTbaLr9UZJKpnNR9kMZb28bg1V/C05CxKeZxYfxYmwGpzH8cbX9FqbN8TFxWYN5wP9f3
         teN0ggBrqiEPCQzgc3pS+VQX9WLhXtXRXpD+LHQtfwwT7rVYQOgjQ+J2fkRoYkMeWWV4
         jh1n05WrA6BwJYyVZQvrPAVs/IYA8UXche+DkGbdkHT/6Y4P6MtMFRCo3L1ktgMb1eKz
         qkKw==
X-Gm-Message-State: AOJu0YzQuceMa7+j/rkcu+P5F+z85cD/Bc+6c2c7/o+ANKaLpcn3mxgn
	i9oUhsrrkhVJ5xS694y6sZYKuLmDoCet6q1oz6qKEzL+j5fGtLFE58KF07MlzEc=
X-Google-Smtp-Source: AGHT+IH2N5ueCq5ZEixlBtgShNVlRSJHHHpe2VGnG01ji6ImzEE6ScvhimLTxAuAYFnX8R06oKiqNg==
X-Received: by 2002:a05:6a00:4fc5:b0:6e4:d3b1:76ca with SMTP id le5-20020a056a004fc500b006e4d3b176camr1451309pfb.16.1709187021483;
        Wed, 28 Feb 2024 22:10:21 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id c25-20020a62e819000000b006e506ff670fsm448996pfi.147.2024.02.28.22.10.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 22:10:20 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	stable@kernel.org
Subject: [PATCH 1/2] ext4: Fixes len calculation in mpage_journal_page_buffers
Date: Thu, 29 Feb 2024 11:40:13 +0530
Message-ID: <cff4953b5c9306aba71e944ab176a5d396b9a1b7.1709182250.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Truncate operation can race with writeback, in which inode->i_size can get
truncated and therefore size - folio_pos() can be negative. This fixes the
len calculation. However this path doesn't get easily triggered even
with data journaling.

Cc:  <stable@kernel.org> # v6.5
Fixes: 80be8c5cc925 ("Fixes: ext4: Make mpage_journal_page_buffers use folio")
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 fs/ext4/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 537803250ca9..bab9223d94ac 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -2334,7 +2334,7 @@ static int mpage_journal_page_buffers(handle_t *handle,
 
 	if (folio_pos(folio) + len > size &&
 	    !ext4_verity_in_progress(inode))
-		len = size - folio_pos(folio);
+		len = size & (len - 1);
 
 	return ext4_journal_folio_buffers(handle, folio, len);
 }
-- 
2.39.2


