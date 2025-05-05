Return-Path: <linux-ext4+bounces-7674-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA6CAA94FE
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 16:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33F093A55BF
	for <lists+linux-ext4@lfdr.de>; Mon,  5 May 2025 14:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A426B18DB2F;
	Mon,  5 May 2025 14:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l9pOz8H3"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E877219A;
	Mon,  5 May 2025 14:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746453665; cv=none; b=eodT2ZcwmGgkhIcHpfg3yzo3M7FkdAqHzA9kym3c++2BD+o0NtdyvpkxCppY/pPXGq/NwMRiqnbpvBZbbqHQAJtD4CN8njr8m9bsoCTR3iXLYM067YIzy2Setoljsk7IzyaebF5qB+slL11jHnvLPcDXGdIslNuxw2CAU4ChvCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746453665; c=relaxed/simple;
	bh=+T4t0E1AvzFlseVujKkjpIRtDQKZOBL1GVGMwicagU0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IdyEf/JHZoLOKQM/js+/5aZbAT4dp/8FZn0lSb/uYxEppBCkToDWSiOTa49FaXefvlNKy8zyBV/QnxwSp9h+umG7GFEM54TptIqKiv7LMoqC1v9zF+TVJ1pJ4+cTQduASSddL+YzBMM6ttiIb8OAyWG0m8h/HlEWor2yVN0IuiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l9pOz8H3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-739525d4e12so4263985b3a.3;
        Mon, 05 May 2025 07:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746453663; x=1747058463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hHySQiscOw8SVzevGvVNGnU70DECf+frWxVcL4RvRJY=;
        b=l9pOz8H3oeOAVTDtalL5dVB7Od1DRHzMTjpybwnIkaE+nwxXF/l/3FKfRkyCDVFjiS
         sMR2I9Oc2nkPItXFR0s9Ntu8LcW1+p1A2lbgl3ivM+bB/vUiD2CDPRQy8GVKxAKjMFJy
         K/Kspqi4wPHguCzQKguXRa6OllGogRJum3OqGykJSh1guDlpegM5WuhGIwlrz20jpSJA
         fiGSpNQMg+YQ7dVCETXO/dkOs045kCsNpDxAtwKrMWnYDSyS7x5XnPCxpt4/3u2A1ghH
         qNl5yL0BaQxSLTng/AhwI0unW0EjXa3aYetS2MK8ll1YnkEkRheCvRSA1YtdNh0RjDKA
         kunA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746453663; x=1747058463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hHySQiscOw8SVzevGvVNGnU70DECf+frWxVcL4RvRJY=;
        b=aDoein4O1pBI1Ld8KJqBpEorfllZut6fjxXbsUteBDIM5REnINsRQg2o8UycZCyKxg
         sOSYWa12r6PDLAWzxemWFp+bnoh+pb7q26QVosDLz6fwS+qthx1MazBpORdvOK0Rb3VM
         6i5WYfmjsO4liJqq4CZ5YKheeZzL2KMrbecFs19XoQz92+7wSNVirhuNug5/faTofxzr
         6FrQVEcW5TGAD7hmU7FkhObuYL26nsDLMkcdOHnh6JpJUPcUQbkHdmCptC+hUvH8cYW5
         FKAO6MggVuqDbjtK0jedvmNhVvtkY+I6VSzAILoHEDpx8rdMk5mB8eaj7BOXuP8vEwid
         +WxA==
X-Forwarded-Encrypted: i=1; AJvYcCVCNxYg8rVHGrEuZzm8NTXfFAEWIzzHmzAU+L1piBfx+udgkU9R/F8AhkOoOKmcF245Dadc2iW9ZJk2@vger.kernel.org, AJvYcCWkpExEOlJENj0MBMNVkXjQrcY4NnkAueYvzdZrp8zyDu2yFHotwfh5+iThSwQk0NyRUIeobHX+UXFCq3xe@vger.kernel.org
X-Gm-Message-State: AOJu0YwSb2+8euu5lVg6N13yqTdsQU1xPQxn0yRLvxS06ymigURHImz6
	9sp5xcxc5ckz/zBy62ZzvJFY9ZAeIeFbx3QYkKLIqugl0VTR+TKEq90ZOy5f
X-Gm-Gg: ASbGncv6ZJt2qOAHGJ9iPjZBBfXqs0q54LU7TUIcuGGSbjO/gIOHHOMF1Y8lGPr/tX1
	lOnnVzeFjI9nbETzbK2jvhjqUPfdPbD4d0qkYT1LLMw7DDSw3NUM4afZZlA+2xVsEqPipl6QbfZ
	FGPpvAGhmTXOz7ZCNpVQ+qyx9vbx6N18nizBGxcMvJKlwHuu/Sm3UhsNUd8Fwh1mpi3sHe/cjhv
	j5vx0fFl/urnPvCxfT2x7FUyPXQeviETlApnOKkPjQthKI8n631zP6TnaamjyXcTovVMaKQlcau
	6YVnCnClqpfYCBmGjT+9+pL0mVc++EMeB1f9AXfQ35Qu+1mbvzZx1qLfHbtCs69j1jYp1w==
X-Google-Smtp-Source: AGHT+IG6g9bzwnnD3O6nEhEBfDyNMzs4/TfXhJ4z87zcfDREZ5HkCqivvrwU0UgH8yj2zoDSiaISUw==
X-Received: by 2002:aa7:9309:0:b0:730:4c55:4fdf with SMTP id d2e1a72fcca58-74058a247f4mr17332204b3a.7.1746453662892;
        Mon, 05 May 2025 07:01:02 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:afa:5db4:54e4:f59c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74058dbcdd0sm7017902b3a.67.2025.05.05.07.01.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 07:01:02 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	skhan@linuxfoundation.org,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [RFC PATCH] ext4: Error handling for ext4_get_inode_loc()
Date: Mon,  5 May 2025 22:00:57 +0800
Message-ID: <20250505140057.671758-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of "ext4_get_inode_loc()" inside
"ext4_xattr_inode_dec_ref_all()" lacks of proper error handling. If it
can't find correct "loc" for "parent" inode, the value of "end" can't be
guaranteed as valid.

Link: https://scan5.scan.coverity.com/#/project-view/36179/10063?selectedIssue=1645904
Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
I wonder if there's an default value for "end" ? so we can still loop
through certain amount of inode without return directly from the error.
If we use "iloc" from with ext4_get_inode_loc() return an error, it
might corrupt some inodes it shouldn't be able to.

Wish to know what's the correct and thorough error handling here, I'll
make the change if it's possible. Or it's guaranteed that the error
never occurs?

Best regards,
I Hsin Cheng
---
 fs/ext4/xattr.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 7ab8f2e8e815..416500ae5248 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -1169,7 +1169,11 @@ ext4_xattr_inode_dec_ref_all(handle_t *handle, struct inode *parent,
 	if (block_csum)
 		end = (void *)bh->b_data + bh->b_size;
 	else {
-		ext4_get_inode_loc(parent, &iloc);
+		err = ext4_get_inode_loc(parent, &iloc);
+		if (err) {
+			EXT4_ERROR_INODE(parent, "inode loc (error %d)", err);
+			return;
+		}
 		end = (void *)ext4_raw_inode(&iloc) + EXT4_SB(parent->i_sb)->s_inode_size;
 	}
 
-- 
2.43.0


