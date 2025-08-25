Return-Path: <linux-ext4+bounces-9615-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 644E3B342DE
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 16:13:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B88F167C18
	for <lists+linux-ext4@lfdr.de>; Mon, 25 Aug 2025 14:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4666D2F3613;
	Mon, 25 Aug 2025 14:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aKdn9mxO"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6911A2F28EA;
	Mon, 25 Aug 2025 14:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756131212; cv=none; b=kzFvIwwxQ/mY77JuqEginqPtdMeHc85wvEVZP2QeaUupUVjz+lV0liwNehy9AkZdrLRAgUOlqlVSbBYuQpNKrYFwBYcoNcBSYDaPT0uttQRSMg4NxMQ02XRfjCib9+38ZggvjmF6INpU4dRtrRUN2aWRgjFhiEzGofsUABd7UCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756131212; c=relaxed/simple;
	bh=6wDwSZQTdkZ0K6r7ARP+lPOkd/GdIG5zCPz9SFVrFE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=reWYwFQLM8iBrH5GZQbpuJPdiyA2LDHgI5upGtSKin0O7PA4jAeQ3BkTtXws0hMXOfq73lxKnXZMlomTbJMjcTD1yqAwcHaFZy//2b89tEcroJoL27A57mhdNJpI2nrwYhUAafo58fP1BMZ5q4G83dUp6sCNizN8yc8haqZUv+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aKdn9mxO; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2445827be70so42783555ad.3;
        Mon, 25 Aug 2025 07:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756131210; x=1756736010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDPNTwpJax4vDS4+xWgLAHPOpHhyQT4nEZr7m0wZXMw=;
        b=aKdn9mxOhgwh400eFpkHIM5sW/wPcmDMGxm3mAGQPid3aRbqPsk2a/KihTUd6JYS32
         sLJIV6A9gWcOZZp3AX2dqjlReA1cWOsEddz2EZxtpVGTnHTJLPFqgEOogxykimxALkO7
         WQHguZGNBxG8nNM5iOZiG9PlbtexD9eTdLCTTgYBoj9ZXxEoPc7zTZhvop1fBVU10jVo
         GjDVpaw829LtGPfQrXzQF1jgB1O3npsNU5s1yfuHzQaOZahWQMJ7AimptGPFUS6jyk7i
         1VaxlkY4uFv6+QOZpSqqjTgI8mmpfU70IM0KNGJerK9yGPv0X9MkH3w8U65WdmlyfYdg
         /myQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756131210; x=1756736010;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDPNTwpJax4vDS4+xWgLAHPOpHhyQT4nEZr7m0wZXMw=;
        b=uw2nj271ecbqzIfUda81GpeZxIesoxrsYGT7oV+A46J+ytNillr+9Zz9es5T3n0kKp
         a0JuDdV9rcfnQ3A5CTpCj/lhLMOjZgnARJ8pr720bq5qEGj5RAM3O5m2NErXMC5dvnU0
         GmLUPj1r8V7lSIIDQklDxmgimZXAO77Elq+rLH9zGEP4odhe/+nbCLFBJZjL2ZZD+PCY
         biw011Fy0undBuH7o6CcyoGmAV0V8pui7eZayyuqdKh9PwJKWJA11YdUKFpDzDRR3T2M
         go8Y9mXp+GkBWQbzm0kSbJPI3+NzDGzoBNqZTTQW0UD9Pkudrp/mx9puBraKBzqeE562
         Ee+A==
X-Forwarded-Encrypted: i=1; AJvYcCWuRtjRmBodNvaAjKWG6fUz2Tfg9zZaXP/+bW3fO6jNagLr9yEjuUX7eVNBt28wNUA5KmnlMybgLENm@vger.kernel.org
X-Gm-Message-State: AOJu0YyZl5pNhYX7IFvulfnhw0zMTS0Tb0jpO36XGvu+2N+flVOSbxEv
	BpPl4KIwDZQaQr9nRJsNCvWjrYKxD8+dkwBEYTSkEWxqdMhiV6oMeicd
X-Gm-Gg: ASbGncvmfpAQsbwXx1bnL0Uu5lBeWBhaM3nu4we/yC/QPnBmhmh/PDUxxp5/uDeFy5O
	dxZcH+Akz84CEVmPdVwRmQS22s/YiqkZWb/qxIs47S1+6cwABZUMtQVbb0NVNzhYAKXkVoEIB7b
	vtDzfRLH+LRKvRskTL1S7P8kxnI05ZRHAicbzmeg6MZ7OkOAL6YHIZvZ0sh7o3lFWjAcJkxquIG
	LaMzKnQpzDt62YZsH3bw66RGzRE8aRTo5FzvC/PHWxMbjcC+o+DJ957jtmJuR/D+Sqwi4DUjABT
	P2lT8PKWYV5YYepEbD5vx8ax/a9lv2KF5TTsnzGd4HFVMczV2ph5G5PJ9htTT0IqInIWq4KNgzc
	H2mzKvKBPfZcfI/lL21HFk4TguACcnm8=
X-Google-Smtp-Source: AGHT+IGFPyKbr3RZ97yi89w7tRiaDA5JIHQrygXMQTece8/mtQ/CS7aBqTxuUTYyJ4Wf/gP1jX7cLw==
X-Received: by 2002:a17:903:41cc:b0:246:b58b:8b86 with SMTP id d9443c01a7336-246b58b8f44mr50517505ad.32.1756131210316;
        Mon, 25 Aug 2025 07:13:30 -0700 (PDT)
Received: from archlinux ([205.254.163.102])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-24668779f85sm70329465ad.33.2025.08.25.07.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 07:13:30 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>
Subject: [PATCH RESEND] fs/ext4: remove unused variable 'de' in ext4_init_new_dir()
Date: Mon, 25 Aug 2025 19:43:21 +0530
Message-ID: <20250825141321.8049-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The variable 'de' was declared but never used in the ext4_init_new_dir()
function, causing a compiler warning:
variable 'de' set but not used [-Werror=unused-but-set-variable]
Remove the unused declaration to clean up the code and fix the warning.

Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
Signed-off-by: Suchit Karunakaran <suchitkarunakaran@gmail.com>
---
 fs/ext4/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index d83f91b62317..bb2370829928 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -2965,7 +2965,6 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 			     struct inode *inode)
 {
 	struct buffer_head *dir_block = NULL;
-	struct ext4_dir_entry_2 *de;
 	ext4_lblk_t block = 0;
 	int err;
 
@@ -2982,7 +2981,6 @@ int ext4_init_new_dir(handle_t *handle, struct inode *dir,
 	dir_block = ext4_append(handle, inode, &block);
 	if (IS_ERR(dir_block))
 		return PTR_ERR(dir_block);
-	de = (struct ext4_dir_entry_2 *)dir_block->b_data;
 	err = ext4_init_dirblock(handle, inode, dir_block, dir->i_ino, NULL, 0);
 	if (err)
 		goto out;
-- 
2.50.1


