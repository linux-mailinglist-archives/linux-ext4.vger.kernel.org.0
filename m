Return-Path: <linux-ext4+bounces-3360-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1D1939B18
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 08:51:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DB515285000
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 06:51:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 686B614A4DF;
	Tue, 23 Jul 2024 06:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GkAhw1bv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1DF13D520
	for <linux-ext4@vger.kernel.org>; Tue, 23 Jul 2024 06:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721717311; cv=none; b=XJLN+1u2lqvPIV9QfnZbqeAnfCLG+pasvDFNkbntUXxgHfI78IojUS1xDK+DurZ7Nxng7uTeVMTt8FdHNA/leWx1gmfW4rW+JyACJBkkQu3zCBZqkk3Zfe36pI540sXxgZl+txhaLYngvbH2GIIY8MlDr7/Nmmi+3+LhG+B0pKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721717311; c=relaxed/simple;
	bh=0+XntXQQ9v9CMUCR2cJhmVHrlMqCupIkoRdvi4nr1rg=;
	h=From:To:Cc:Subject:Date:Message-Id; b=krNxlQ+2jfU72ZkTEBhOYOLzWcpYQSLVTDB006vfOrmV+fhrH6EN7oG2jwsbvXdJ7L8Z+Ut/9eUrQ+2xn35ECXW+iV90a8Xv7h8KE1E3Zk5Jp/iBsqsAYjS9Ea/FYodWz3qD2kCdHQIpotPSP+vf2sCb5lfAfufsBQbXoA1U248=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GkAhw1bv; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1fc52394c92so3676685ad.1
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jul 2024 23:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1721717309; x=1722322109; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+yG9WnxoAsP5jtqxXungkbLY1jakDH3nyoSv+8Ydvsc=;
        b=GkAhw1bvEfUc8SuOpeaNZC9PVpBPEJoj8mj2c0eIoGojIBF+iABaGHkbdgYgHAjndF
         YQaiQ/KpEUTwsqUrszUSQCEimiiZZsGeuFB7h3JAHXQTqa/fKApRGNdwnaLdhkWqbhQH
         ZCVmVclBtiCstdzdZmUkFqarROlaHl5gJY0Jk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721717309; x=1722322109;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+yG9WnxoAsP5jtqxXungkbLY1jakDH3nyoSv+8Ydvsc=;
        b=oVzUXqtZSs5YT2FeSU+7XJWbY9OHBhsVFzg9hJ+zTLpFSW/UXppcBr8oEDppn/XoGj
         Y2wf/z/V3SsWHzuigVP+rd/rPjIjimAvWrYPK5COXGfdblpt60Z5KseWzVFMEMa8pDt7
         VxWgy+k8pulPbkWkA2mTb+s2f7PsKBGJ7cgE2Tn9qdWh8EZPbFMFLDFUeob6I8XZLhiP
         B1FQFVNBr1n15HDy3qLM3qT7YLsbMyFolPmV+VR3Fvec0q3rhqDOdKoTlaELHQfVGVkl
         JX//m2QzT540jBLEbgyIHaHPidRiq0LNL0BiG07DE0Us/CTs9pIuuE2sGGjAG/YaKKko
         FNiw==
X-Forwarded-Encrypted: i=1; AJvYcCVq2znh1gWsoAw6NgMbIvMLf9hJ+mTRTE+7qj2m314s1yWtdVwfXC4GW/5WKfEG48mmK2MsCLhGIjqnPqbvC1oIFOKsm9A3sviSsg==
X-Gm-Message-State: AOJu0YxoMGXff6ttOwy3SlELn1QO1KPLHAiT8d9K7cqli+aQNlEXBj4i
	81mBa75a8Lzwy4btiFRvxLlFvEiGKYamV5PsfoeLRNUeCAtxL0+Ynd2ZSCSiJQ==
X-Google-Smtp-Source: AGHT+IHAObmxYU1HV+RmN2tsABt6hiYi3Tbms5Abfi+vZEx8a/c2GmYHqxZ9nQrGtERCuO54fBkrRQ==
X-Received: by 2002:a17:902:e843:b0:1fb:415d:81ab with SMTP id d9443c01a7336-1fdb5f6a05bmr19444185ad.20.1721717309537;
        Mon, 22 Jul 2024 23:48:29 -0700 (PDT)
Received: from akaher-virtual-machine.eng.vmware.com ([66.170.99.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f31bd90sm66950175ad.173.2024.07.22.23.48.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2024 23:48:29 -0700 (PDT)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH v5.10] ext4: fix error code saved on super block during file system abort
Date: Tue, 23 Jul 2024 12:17:19 +0530
Message-Id: <1721717240-8786-1-git-send-email-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit 124e7c61deb27d758df5ec0521c36cf08d417f7a ]

ext4_abort will eventually call ext4_errno_to_code, which translates the
errno to an EXT4_ERR specific error.  This means that ext4_abort expects
an errno.  By using EXT4_ERR_ here, it gets misinterpreted (as an errno),
and ends up saving EXT4_ERR_EBUSY on the superblock during an abort,
which makes no sense.

ESHUTDOWN will get properly translated to EXT4_ERR_SHUTDOWN, so use that
instead.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Link: https://lore.kernel.org/r/20211026173302.84000-1-krisman@collabora.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Ajay Kaher <ajay.kaher@broadcom.com>
---
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 160e5824948270..0e8406f5bf0aa0 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5820,7 +5820,7 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
 	}
 
 	if (ext4_test_mount_flag(sb, EXT4_MF_FS_ABORTED))
-		ext4_abort(sb, EXT4_ERR_ESHUTDOWN, "Abort forced by user");
+		ext4_abort(sb, ESHUTDOWN, "Abort forced by user");
 
 	sb->s_flags = (sb->s_flags & ~SB_POSIXACL) |
 		(test_opt(sb, POSIX_ACL) ? SB_POSIXACL : 0);
-- 
cgit 1.2.3-korg


