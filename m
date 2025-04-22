Return-Path: <linux-ext4+bounces-7373-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D7407A95D9A
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Apr 2025 07:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A85D3189783F
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Apr 2025 05:57:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35C7D1EC00C;
	Tue, 22 Apr 2025 05:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WD/W0Wbx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 746721E9B1C;
	Tue, 22 Apr 2025 05:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745301429; cv=none; b=NS269+vWzeAClUWTLQooZeSYLgWlHI/U2ZrNrlJkYlxP8r272i5sObfXNWybKKjCZBBlDx1FBEXb9C8PBi/XVpQGwPaLtMw+uuADUS9yO5413GYf68d5fOypJ7RchMdEUL1KBVMnM/LkxE+TdPIJdmf6W+zTZX5xDNm7EGQmT/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745301429; c=relaxed/simple;
	bh=AdLmc+wiCdwXinG9IPvx9ZOAcJ3bRqNTo08Kbb78oAc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r49R3rxVwxAH+Ii9x68kcVBCSRkEJ1VqYZGOCGZjTAfi5QwBrkzXQCKXJGIBOvWOvyKCE5RYLQssHKBnHC2tLG0o1uyJVk+B/6CLBBvVv5wlYggMKvB1zTnrJFRU/e7Brg5gPhN6+lOEgULMFlJP9DSwi3E0oF055lGlMouN9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WD/W0Wbx; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-3054ef26da3so3441406a91.3;
        Mon, 21 Apr 2025 22:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1745301427; x=1745906227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=efd+S9Jz6y3DhI5mJO14MniAuJQjBl1kfKZRBddD7pA=;
        b=WD/W0Wbx4UGu4gEml8ARNfCK/tsguDt600Zp3/pOe+txZFSFUu6hX1IEVPrKlmqUEw
         mVgMhybGEx/RbgmXac6pQY1S8WTUmFHHzfjnGvV5aFuhfsZkn4CSEDStJmDZld4xQKGV
         mRhbG0sDanwElTid1Grut3ZTKdWO9HdemHPxpWpAnauDYzI8isgyN7SGcStCRktXljuA
         SwBFwtRqlLF3IkHaPewSEmF56P/X8qflkFpKaIELZtqJ7qPhd9byY5dJGaj8mAxR6Vh+
         nrt8w4kGpdoMHYAA05mr2bAV83T54BkFVNOB5VJZ0R6+1S7+VeD0otuIE0o2uwYS5zO0
         796g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745301427; x=1745906227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=efd+S9Jz6y3DhI5mJO14MniAuJQjBl1kfKZRBddD7pA=;
        b=mi3H8B8ytszooAZvNq+SvnyzYd295fkmWKc0vtJRasLrrootwUZshkGzvtRPDePcvK
         Eeeg1rHAZzXSPT2a27lDzeZvdk4XOsyBrUdbW3Wu2vhDBuzzD9HS+mkOyCMQjrx+wn9d
         tgvwGolQSEPXuYhioN/jCdycVuBpBZsYYWDTJa6k5Nuo/LphhzCJkupt0rzCFnQ432+x
         IIab/dpM2HUJotStQ1lCli2FEHE9UwSEMuJ6WaowBO/s1FmUVkCilyjB05+8WEBldljl
         qlsWgbYaPj12uSZbWPNWE1Bng+FsqR5m6BNhZj1OcyVxXfSe6W3+dp58nPw22r7Aoz7E
         u6vg==
X-Forwarded-Encrypted: i=1; AJvYcCU7OM/NkzyOcnLVmEBbSGn2r7GLngr9rpQtJ+vkjATsdecv8HCU5d+Uc6sHrVPBsKhvnAJbI8fKRH4=@vger.kernel.org, AJvYcCV40GxSlFGp7q2KDCtrMcpNeXh+dOWVSI7vpsaQu0zUF0hCLGsmJkweVZvwE7pRKyI9npls6xrUl+VhnWRd@vger.kernel.org, AJvYcCV7LiZKRoyPeJxbCrtNFPocN4g89R550c8gb3g29lyNCyk16H3QO5VPq/I9ZsqBqvXJF7Vxor2cKeJUEQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzAryVR5iGl4bbhQ3aMKroO90CYPBt9OeJiO3V5wMkZHd5GZoa
	pYcITF2ps6MslqmE6UajmHbvpXx9GqPMCcWaG/tWaRfLUwK9cbiu
X-Gm-Gg: ASbGncuorv/2hi5ompcQdpvaMuffGikCXoNTtDDCxMNmNkuquaHbwHCFv3mA+MEGd9O
	ol2Y2NUvMcgCGXdaGnykDncv8lWVaWjliYcqSNxRQGDi1XUQdz1QEHpq5HpRUjqQtgJIJj2DDJo
	DHyfraSGG8Jmlvx1s/8WCvwBSHSkXKd35jdprlLx9qdfJLhqNFLqssQkfSL6nlFuV4/V18FLOZT
	KoJu/CXebvDqur8kkdwLyO7r6ZkXienRbicH0FSupPIp2CdvElWzkM/q802pkd5PRZBwxpGWze3
	y+1ERjtkUuJ1OpXRQqiGflBqxJMONbRIefcmWOLUXpEpiW1Jne9v8Is5JH/SGAHiyLzKbWA=
X-Google-Smtp-Source: AGHT+IH0F3vBa92QDVMDa4RhrEeLNM/G1NMQXluqfI0wOlvs1wBOm7PMh3/msz+ClY/E04uMK8ENcA==
X-Received: by 2002:a17:90a:fc46:b0:2fe:b907:3b05 with SMTP id 98e67ed59e1d1-3087bbb6abcmr20030866a91.29.1745301427548;
        Mon, 21 Apr 2025 22:57:07 -0700 (PDT)
Received: from vaxr-ASUSPRO-D840MB-M840MB.. ([2001:288:7001:2703:12a8:650b:2dd2:b977])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3087df26445sm7688959a91.29.2025.04.21.22.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 22:57:06 -0700 (PDT)
From: I Hsin Cheng <richard120310@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	corbet@lwn.net,
	linux-ext4@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	I Hsin Cheng <richard120310@gmail.com>
Subject: [PATCH] docs: ext4: Ammend white space
Date: Tue, 22 Apr 2025 13:57:02 +0800
Message-ID: <20250422055702.451729-1-richard120310@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There should be a white space between the words "block" and "size",
instead of writing them together as "blocksize". Ammend a white space
between them.

Signed-off-by: I Hsin Cheng <richard120310@gmail.com>
---
 Documentation/filesystems/ext4/blockgroup.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext4/blockgroup.rst b/Documentation/filesystems/ext4/blockgroup.rst
index ed5a5cac6d40..32a66a956f31 100644
--- a/Documentation/filesystems/ext4/blockgroup.rst
+++ b/Documentation/filesystems/ext4/blockgroup.rst
@@ -108,7 +108,7 @@ block groups which can be described by a single block group descriptor
 block. Since the size of the block group descriptor structure is 64
 bytes, a meta-block group contains 16 block groups for filesystems with
 a 1KB block size, and 64 block groups for filesystems with a 4KB
-blocksize. Filesystems can either be created using this new block group
+block size. Filesystems can either be created using this new block group
 descriptor layout, or existing filesystems can be resized on-line, and
 the field s_first_meta_bg in the superblock will indicate the first
 block group using this new layout.
-- 
2.43.0


