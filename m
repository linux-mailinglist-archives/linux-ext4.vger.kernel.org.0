Return-Path: <linux-ext4+bounces-9206-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B1BBB13F00
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 17:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51835179110
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jul 2025 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB786271461;
	Mon, 28 Jul 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gp+5VOk5"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DD218A6AB;
	Mon, 28 Jul 2025 15:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717290; cv=none; b=F3XiVkvrh0RlpxFlqkbsEId8AYybVXB+912qRMi6YAp+9hMlbufGm710RTfm2QUkU6VyCnF5VOZcT49zcIIetZoe3Hho3WbBQK6+qRyb4+hbUTgWiQZFlDKK3pTRoLXhYMhnZULdlSxsz8iTwTHa3sfFMpGqCcgRi3BFZftucC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717290; c=relaxed/simple;
	bh=rMZI/++Sl83oEviYROVHczJ3NA9sNaqcT1YdK0dP1Q0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=okugGTij158/JyyYGyatG59NlQcP5V0SrdlVujhJpL7qmMSaMQsFD+gDuw+RuisbPElHyBqb8mdQ7VuOzZb6hO6HjjlT3+idrt2p+47h7vm0k+3i1dTOahsHvZir3w3Wobceoha3PCtvRgBMu5mT2jYfV7mekEA7bHlWql3tqdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gp+5VOk5; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2363616a1a6so37264225ad.3;
        Mon, 28 Jul 2025 08:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753717288; x=1754322088; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lf4c4+X3SHCf0c7CaWo3n9zdv/g/JaUx8MF3KOPrPUg=;
        b=Gp+5VOk5ltFiY5ORrrRlvLeaTgEWlKb+iGtxKH6XZJxeS8CpdoLFGb8NeykA9yvtuo
         ja+dHhxV/5MFc36B/FDAQ1QTVicnd1N3ghwSO0y9dWuFMlod/FaUy/aPXe2GX7QJXqTd
         1sRL7yZdkrrM/J7xAk4kM0XDRsMF8MN1ru00yEjs1yPN4O/UsnY6fJT8WMXAMIZ7KzHT
         efQQu5hW3dmuvBXm688hzV8WnoGbMiycFOi5HdMI8HIFyUuGZ1x2DIjHAGDqUqWPsTE5
         IH2Vb/KF5MlTXnVBa27I0vSlOWDr4EiCSXwASd0LkY1l5yAsE2y+JfF4KINMBmzZoItW
         y8CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753717288; x=1754322088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lf4c4+X3SHCf0c7CaWo3n9zdv/g/JaUx8MF3KOPrPUg=;
        b=fdT8oNcqD/SGlrXbO0QJu5fOHv7jMZLgq70YMIOcKtK8rSajCE2flIWxbUzD0TS7WG
         PpOq7T6OKmmt6kizKVshzazBnq9lCsXcWgG4AyGTDmiIXwUG3cIqpZqyGgqHfyreQrj8
         kT3FLuE3v/beMavJSndjD05MQCjJ31TBFp94Ni7IjDWVw/4Fl6FC+DIakpvgHBJ9u+1w
         2lV9tJJ9VOjGEScNxWTNqd3GcxTgFdebVROQLuQ2ckDMZK+woBs/JKwMNpCwO7/JoNwI
         PU9GUa8lHTbyTkH33Xfcm8teJnJAUpO9iGI/OPcQS0QFKYthlUcQtsRdOzm3o4zaoMc7
         Ngeg==
X-Forwarded-Encrypted: i=1; AJvYcCVoXls9Lh8Q+sJ3hiKEs7XWiQJzKwIkxmAn8FRY6tNNZp+LaoHfmXd8BSLGnpvAq8M8uvfH1ahyTqZW@vger.kernel.org, AJvYcCWJfeq7TmFnKiMpRFVEAFpY3lZhsWvcPT1XpThWlb77uTQRHKxpKXruewQgl8rrEmKGLlKCQjDT4XcLEzKm@vger.kernel.org
X-Gm-Message-State: AOJu0YwvfyenNNafxa85dfucsZ1I3LmHywb8F4KKPF/kmcn6PHustIcd
	PHupkcbEKPZjYf9Jf0vtdhQaJusBmYXCm/t7elwRE+//DPmg5/uHIBnEByIUPCpbZhJ/ow==
X-Gm-Gg: ASbGncsOdP53Tfh58ou2LGbrIu4Lm+c0lM4btmThnJS/JYckl4sXy9JBsl/cYp09y5M
	4fyjBR9J/8Pq5x1aCFznK3vdf01THQxuRxqwTkxMyrK867x+yG9wUJhu6uPJ3Vfm5G3z5ns8wCv
	o/AYAOuiQYHNgTJIzStejoI4KICtlvTJwJ2F+aJ+dvuyAE3Z3JAc+lJQ/d+W50yLL63ndRMzfx5
	UDmMtGxhco7VdpSjiPcdDxkzRl4HOHbqyhT595bQbNuLY9o4Id/Hck1rjw/4MEk8fkWFYUniXAn
	ISL/Y2zVsFB08wr/oyKh07UEWU2g13srD3N9p5rV81fe11Bq3/sxnenCpFYAw9yQZlV0EeUvqx/
	zjaFXCIXk66vBtCYx6uiFwwB9egvCGA==
X-Google-Smtp-Source: AGHT+IHHYZnbOE3Rnoq0U8uMtLJaRU8HxAJqhVzzJC1VVDJaztpfjHvSCzur8LQWHtjsVVHq5/0lmA==
X-Received: by 2002:a17:903:234c:b0:237:cc75:77b0 with SMTP id d9443c01a7336-23fb3129b41mr159525605ad.30.1753717287840;
        Mon, 28 Jul 2025 08:41:27 -0700 (PDT)
Received: from archlinux ([205.254.163.16])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2400a07224esm33226435ad.212.2025.07.28.08.41.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 08:41:27 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH] fs/ext4: remove unused variable 'de' in ext4_init_new_dir()
Date: Mon, 28 Jul 2025 21:11:06 +0530
Message-ID: <20250728154106.55730-1-suchitkarunakaran@gmail.com>
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


