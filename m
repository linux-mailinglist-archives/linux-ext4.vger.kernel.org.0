Return-Path: <linux-ext4+bounces-9886-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D28E2B50349
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 18:55:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BFCB5415D0
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 16:55:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6AF35E4DB;
	Tue,  9 Sep 2025 16:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X7nTeuZo"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D552426E165;
	Tue,  9 Sep 2025 16:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757436889; cv=none; b=hRehAAjbYoUBivos15nKnTN9/5Be3nVDyKbJrqA4hLV++oFsacWYARXOldalfsFX+Yr+qiut91PS8g5TXKQiwdyfgDoGwuFefGdVAKQIESRzJiK6QrtrPmeEWlMJg1yJv9ZYiQiItBr5yfGsAvjCkKgfbK7A9qydQQaK86RbnbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757436889; c=relaxed/simple;
	bh=6wDwSZQTdkZ0K6r7ARP+lPOkd/GdIG5zCPz9SFVrFE0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GiwoukhFVKgASXD7vTjrUogfE6HiUI8xIjoHD7CBp76koU8Af+WV+tt2HACgQhzveuq/pmic8vyzXNZteUG0gYoj2WKnos4q6J5B4AmvDGBGXRTy0B4fqAo4OkgOGlQPg/oi2rA8gILEepGbC01ATSFByV1uDpvvZfLjE1nUO1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X7nTeuZo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-772627dd50aso7381436b3a.1;
        Tue, 09 Sep 2025 09:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757436887; x=1758041687; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDPNTwpJax4vDS4+xWgLAHPOpHhyQT4nEZr7m0wZXMw=;
        b=X7nTeuZoaJ7zp0AxZ2342Ep5eBeoi7GIXovA/YXVm5iGIzyJ+x7ruEMFeF4L3eSzHH
         027fQwCuFPfdI6xlAg15uaohWlFmtDM1PmsAUFF78dEMXCWZrvoLKAnge9wPvFS7ZzDT
         x5X7BbjN57uFBz9MncuXF15iVmG6H2kTTu0gYnc7U5Mp8Bw52oBL3niVEnugyNOrWDJU
         RBUEFs7c4bdrdIBseA2VdBKJashy89RX/+GPkhbjPCkooDk30+mS8YkvlSY09CFilfcc
         A0E+S+W7XbhXkvyrpEySyrpSGE1+RaQ1Y/fApWCD7clK9fGSfaCRFlG5dGXJpRsTgLhx
         kQiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757436887; x=1758041687;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jDPNTwpJax4vDS4+xWgLAHPOpHhyQT4nEZr7m0wZXMw=;
        b=fVWUQUbKjHEJV3T26Rs+UMo8YoOR8x6c675TAewskKUO4AiYD4Qkbw15ZOvPw4pLZd
         DCnmSip4fH+WGEQYuuFJkw5TPAu+Rnm9x9lckono9+Q9GK4IJjV1TmjG8OLRR6kWuY+q
         cTy3/54S9Mpaac8WI29p7tOq56hv/0draqL9RXxKaxrHosdZOQafg2P2xcTlPp7QylH8
         BWF43E2l0VSW706opkyKbfjJb9tFUI5WjRzX1Kr/GahxTp3Ij4R6VFWoaox/PhVwI6rF
         rmmSOU6B8zW6v3VYoTVt5m5FZkkshscowduRWZz3a+QoYxWdottjy9BxECwkT5t5iZ9H
         Gljw==
X-Forwarded-Encrypted: i=1; AJvYcCViH0dbHalbZT8rmWZXnd++oFsJLo9VgZGgA1ovTfN1lPGKH9ROzuRENUsh/ce3Cv9zfH4CRbtE5P3Y@vger.kernel.org
X-Gm-Message-State: AOJu0YxwQzvTvvv2XAaL5N9lJwV+uNz8cE1YETIZHxyQ7u8MzgYq6zPz
	s+qi0tKSkPeDIQFJhk0NXcp43Ucbi76MPPwF4xSHorL5Gu78zoCpmk59
X-Gm-Gg: ASbGncv5dIwRh9EzM7NlUW1ZBxGC9BgpMwW4X3LNEsvSppkk7FKFIValuLaiNLj7HyS
	Z0SzPlmu6nQNjeE5K8sYRL0jSTUxHRxZcqopWyEWHnd+glAkhnOdKumnqW5QyW63opzOx4lLa+J
	Jpz863waiJ22LBalMY3azBO0hH7uFY0r3ej80gOVyJaq9M5b4VmgAJmYGDn1gnpv/U3bi0Tdnp3
	cxGsf8OdHNucAoHTYFHvtRhKG54tCcHJ7EW7XAZF0X3wqZcTbuuGOhxJiF8l68xNuuPOnvy/Ck1
	3IaLbmde5fTfwPjxAuAPElZMaJKE7KE1G1CgkrlxAXXyzpUul/j0GD72e+NRYArPwNJNHSKpBEf
	v/euQ5CN1NyCVrP925JrOASVUkB1ZJnQ3s+6DFg1G08A=
X-Google-Smtp-Source: AGHT+IFrYN8CUrJUZf40DuX4y97YP/kms4GG/GBFv83blRmALDwU+NZgfuWuuuA1HX44RC7TCcek2w==
X-Received: by 2002:a17:903:234e:b0:248:f844:678f with SMTP id d9443c01a7336-24ceff455eamr258584605ad.30.1757436886803;
        Tue, 09 Sep 2025 09:54:46 -0700 (PDT)
Received: from archlinux ([205.254.163.103])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-25a2a921953sm2565805ad.103.2025.09.09.09.54.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 09:54:46 -0700 (PDT)
From: Suchit Karunakaran <suchitkarunakaran@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	djwong@kernel.org,
	linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	Suchit Karunakaran <suchitkarunakaran@gmail.com>
Subject: [PATCH RESEND] fs/ext4: remove unused variable 'de' in ext4_init_new_dir()
Date: Tue,  9 Sep 2025 22:24:38 +0530
Message-ID: <20250909165438.7583-1-suchitkarunakaran@gmail.com>
X-Mailer: git-send-email 2.51.0
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


