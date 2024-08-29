Return-Path: <linux-ext4+bounces-3967-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ABD149649E2
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 17:22:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 62325283BF8
	for <lists+linux-ext4@lfdr.de>; Thu, 29 Aug 2024 15:22:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AE191B1D72;
	Thu, 29 Aug 2024 15:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7JFfLrt"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1417243ADE;
	Thu, 29 Aug 2024 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724944942; cv=none; b=pVqagynGdokaOVxrrbLZNn3Ab95+tp6lGNYvgIyv5g55n3zJ97NEOtGS7vyK7UMg0HxYkNsA9xLZVZldFkEKbTO6OoAbIsrVFOpt9CeqmNdTVhJ+DApm6jXlqMXun3MKpmPVbH2bm7XQVd1ku3jxHCtDX5r2p+tJVPv6+3saYdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724944942; c=relaxed/simple;
	bh=291jpGjLUM4gv+row/g40/RkHWc54EuUBwrXNjFkY6k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YJnprD7KxL8hnOzKNESONL0fol63Ry7ygqCNYqOQXAC3PP1/O10qabVD5HzK5St17QXN4MBoU3ITqcjJns6kM9rfJRddQWzHWaHtxG92wbCDb9Bcvjj+GfiLJBVbZes3iYXbmfJ6+dfrnRZgD/IMTAI43vi+mdibcWrX/wFmNWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7JFfLrt; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-371936541caso502711f8f.0;
        Thu, 29 Aug 2024 08:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724944939; x=1725549739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q7PRQy+Kz5kGB4uu1V7mT3d6Kex4l7Rw9r1Zl56FLww=;
        b=W7JFfLrta/R9EdXeQ1c8aSFDofTVdmLB12sdg9fI9mS82cHPL8H6WR/XOKxj9xyfJX
         PhQLkAZhLnhGPfH7qwd5FbFnt1X1Qh/M1lH/Qjnxxsj1SwUlMimiH0sjMHkkSDF/RLmQ
         I2hAJKkkOmTCegMJqwhRw05cJ4wiHrFVEkn6+/dd9nrjhbEZ0xGdmmtURCDMx1izQy9d
         bId1FaU0bcbxf9eLI91Nm6gHQR2OOPowvXYJ5oZ5jLevcw91K5BTNiylz8QmomtvXJfT
         dOB2cuTggRbPY19nAtUjozoLwJaYn6w+aBD3vNbrcjfYsP6f99Q+CNsUGXaFu91jOJaE
         pfzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724944939; x=1725549739;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q7PRQy+Kz5kGB4uu1V7mT3d6Kex4l7Rw9r1Zl56FLww=;
        b=Es1qHvcjJYb99WbfkaONmC8H7gXSPoypUhPRIt+NMySSxWIMVGuo3Kws9V5jaHL0/O
         6XdjbjTxkmYrKc9LKm8fcw3LA6tc92ng2A/2YiJXWr/P0O4PTpbaPBO3XcAv4VDU5urB
         9I8nrGvRximtCcx/4NbcX3Xdhg1N+Jh/Q07ghOjW8cd/U3w1kzYKlR4kVGeOijGW+olk
         VC9T0HKhVPSsQd1+ciVmvbSo0ivmU6dAV1+pNHqTvo0tS9gui30RQXEOHoa8HsBu0SHV
         nST86DzQ39ve94ts18AYPQtG8+sdGHpL5AG+PnvqXguckcT/mwZ1fN3+613x8tnaS9/5
         r/CQ==
X-Forwarded-Encrypted: i=1; AJvYcCXOA/LXemUSote+Gws5pcqe91FwfCkQm0reNmAONOq5PPe6rzpT5En9ipOx1cAVo4QKT3y1lks2qehZ@vger.kernel.org, AJvYcCXR3XGVS1ofoJI5CasAWRMyOzrEYW4LVja2n9BE2mRM5kfjgkrixPkQfH8xpRx9yiYNEM2JZAkJFyEozLb8@vger.kernel.org
X-Gm-Message-State: AOJu0YwpQAOISgSUAZ2sq3rNYDKKwgpcFxqMidlrE9TtDaqQfzPQCTCs
	bx7+9k5MrH5hOW1TP1LulXcqRVeK4tr2OkKjp8TaRka5FcOWX/jD
X-Google-Smtp-Source: AGHT+IE9EbO37rVQiUYeKd06kc7c+K9fxQJuaQQZs5Dj+NSsAWnQCSg8FEnaompj8W50zKhoZqdaaA==
X-Received: by 2002:a5d:45d2:0:b0:368:3b1a:8350 with SMTP id ffacd0b85a97d-3749b5498eamr2215641f8f.19.1724944939096;
        Thu, 29 Aug 2024 08:22:19 -0700 (PDT)
Received: from localhost.localdomain ([178.69.224.101])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3749ee71b9dsm1692336f8f.38.2024.08.29.08.22.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 08:22:18 -0700 (PDT)
From: Artem Sadovnikov <ancowi69@gmail.com>
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Artem Sadovnikov <ancowi69@gmail.com>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Mikhail Ukhin <mish.uxin2012@yandex.ru>
Subject: [PATCH v3] ext4: fix i_data_sem unlock order in ext4_ind_migrate()
Date: Thu, 29 Aug 2024 15:22:09 +0000
Message-ID: <20240829152210.2754-1-ancowi69@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fuzzing reports a possible deadlock in jbd2_log_wait_commit.

This issue is triggered when an EXT4_IOC_MIGRATE ioctl is set to require
synchronous updates because the file descriptor is opened with O_SYNC.
This can lead to the jbd2_journal_stop() function calling
jbd2_might_wait_for_commit(), potentially causing a deadlock if the
EXT4_IOC_MIGRATE call races with a write(2) system call.

This problem only arises when CONFIG_PROVE_LOCKING is enabled. In this
case, the jbd2_might_wait_for_commit macro locks jbd2_handle in the
jbd2_journal_stop function while i_data_sem is locked. This triggers
lockdep because the jbd2_journal_start function might also lock the same
jbd2_handle simultaneously.

Found by Linux Verification Center (linuxtesting.org) with syzkaller.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Co-developed-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Mikhail Ukhin <mish.uxin2012@yandex.ru>
Signed-off-by: Artem Sadovnikov <ancowi69@gmail.com>
---
 v2: New addresses have been added and Ritesh Harjani has been noted as a
 reviewer.
 v3: Description updated.
 fs/ext4/migrate.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/migrate.c b/fs/ext4/migrate.c
index d98ac2af8199..a5e1492bbaaa 100644
--- a/fs/ext4/migrate.c
+++ b/fs/ext4/migrate.c
@@ -663,8 +663,8 @@ int ext4_ind_migrate(struct inode *inode)
 	if (unlikely(ret2 && !ret))
 		ret = ret2;
 errout:
-	ext4_journal_stop(handle);
 	up_write(&EXT4_I(inode)->i_data_sem);
+	ext4_journal_stop(handle);
 out_unlock:
 	ext4_writepages_up_write(inode->i_sb, alloc_ctx);
 	return ret;
-- 
2.43.0


