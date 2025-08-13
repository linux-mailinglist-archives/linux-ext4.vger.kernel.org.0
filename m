Return-Path: <linux-ext4+bounces-9366-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D4BB252FB
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 20:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 45E115A7CDA
	for <lists+linux-ext4@lfdr.de>; Wed, 13 Aug 2025 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F000B2E5B3B;
	Wed, 13 Aug 2025 18:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mHurdd43"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616C02D7381;
	Wed, 13 Aug 2025 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755109494; cv=none; b=U2sc25AyXYp2cdvjm3DP1vb5HC8qLirILS/B1fIl723tnb5b5lQmWCNIKSdnSYyt9WFpT8sxnC2idr1UCs+vsvGzcC6AfZX+NjnsTzkB7lbYKrdOuxbWw/z1mUWfpec2L5H2poGbHAo8KYO1PTZGm/RJpFfeame62D+oJvIjA9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755109494; c=relaxed/simple;
	bh=rMZI/++Sl83oEviYROVHczJ3NA9sNaqcT1YdK0dP1Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bBrMvDmdIrucwHdwIZTglojEZm+QxaycWgGQbnl+qrtb1/IwhRmTeAahlC/tWmnKWD/udgjOBKtx2p3uXhmLTVFF6bXYPzQ2BKZAe83vbkgcYzLGZVxxxa6FAjMe8TrqYeNFHmsx0M4vwVNxjS9ql0CbMzmmiWciFEf41Bmjxz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mHurdd43; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-76e2ea94c7dso244328b3a.2;
        Wed, 13 Aug 2025 11:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755109493; x=1755714293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lf4c4+X3SHCf0c7CaWo3n9zdv/g/JaUx8MF3KOPrPUg=;
        b=mHurdd43f+Zo0ijFe8LwYpm1oGVMdzbrPuchfk64Bj8b04ZzkWe7rd1GhgbyrwxgeZ
         3a3x69dhkJEY5NcqHjo13u+J2zCNnTTud37GkqWsSMFUH0uer1/s1XTUZEVC14pzs9ed
         ydrpeby0EYDPdttcvuWAIOsajh2AbZv614rCSuzmgXqttKkFwfIS1vd6clyjKw3LxGOU
         GajgqE6YSMAw3GPiSMQu5uAGugDEKJXOxQ2gmBsCnz6kGAgYkRV6r31Yt63XiKnTwcys
         5ZYY7EZ51au2To74+DVrqnC/bAAglAOynLZOI2LqbmGNSzVI58aZH14PqZ86a1cj10Ny
         G4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755109493; x=1755714293;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lf4c4+X3SHCf0c7CaWo3n9zdv/g/JaUx8MF3KOPrPUg=;
        b=RGUPirsGSZy/J94c1ucbWn4aLkomoMkyDAbC49Qz3i0EAQR1hroSKjJm+gsBuj54CX
         faOD1pOs4lIWjhPWPNP1088pRhS4ooslusErYzwnCaOYtswxOqqhOpVkIJkUGllE/3f7
         C+SqgIct0PThbUDupgyPGcTrpEOrscl9PsZhTBohLwwpIYq/MehXwxKM1HRHsGoRadx9
         NTrT4JfzPALRrIK2hGbNbi0zFdluS9I4z9qTTLKBf4s/Q/1WE69JCMAsJ8potLXfxt0c
         XiCmvnM7BbGyf0zMBMh0ttmnX0TvMXBuEO46I7jUNvSzFBPZbIhvJ99kDRh0LaeX8TEy
         7M0w==
X-Forwarded-Encrypted: i=1; AJvYcCWIjoOcdSZxwg1qI7QYntXwqtxuwW/wLFobzsJ+lP4v20vX/EnYN/A52lspXiOJiy1iEUzgJ7JOkYpD@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbt/tfJC4Jqlk7dXD1OUAjAKekZhNICeHUFYCswgXKpLeNHKLF
	W44kEpF1w7NbnHSKZqqJuPhDJJ8ZqAyzAd/3ryaP/pPFL5RmnPKW0OYi
X-Gm-Gg: ASbGncvKKvScuhTwAmhkn+75nk4s0zl3erQCD7bNFz4+eWAVVlynag/HPFIu76TQty6
	/KKe+mPJbCjzE7d/+oibHSaH/0mrnPUyHdYJl2oTOgfybMru+jwsaVF8AQckwzIzaHtqL75ml9C
	QMRUj1gCJz4fQJ5QrWpTQYz6QLLoeV4Bs87OFf+I8XMg2CGCaTdXwkMWfAXwG34wI+Su+VasSw5
	SFo5SkCgK1bLtuWz9tU2sQVUkMSrwcihlncRiEVDn7IwuzezfHyp5sHZlyDJQftglkiXngmRRcL
	jzeatNQzATO7Z/dFS7iJSlWovI17u2im/MoyUeZypjxtgxIny8Xx90G9nLVG834QnWcanJUBZi6
	KsZomaMBBJ/dZlS8XbACq+gk4eB+czIQ4LRuB1+zP
X-Google-Smtp-Source: AGHT+IGFPWxg01RMwiGU0dEwChvK6RJmUSmpiGeA5HRM48y193iq5Ghvtn2vXWFMsWE1r5tKYUst2Q==
X-Received: by 2002:a05:6a20:3ca2:b0:240:11b3:bef3 with SMTP id adf61e73a8af0-240a8b50ffbmr7204349637.38.1755109492421;
        Wed, 13 Aug 2025 11:24:52 -0700 (PDT)
Received: from archlinux ([205.254.163.26])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4263836324sm20670472a12.10.2025.08.13.11.24.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Aug 2025 11:24:52 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH RESEND] fs/ext4: remove unused variable 'de' in ext4_init_new_dir()
Date: Wed, 13 Aug 2025 23:54:40 +0530
Message-ID: <20250813182440.17581-1-suchitkarunakaran@gmail.com>
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


