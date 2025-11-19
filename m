Return-Path: <linux-ext4+bounces-11916-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 550F5C6F575
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 15:39:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 882122F19B
	for <lists+linux-ext4@lfdr.de>; Wed, 19 Nov 2025 14:34:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE93B35C187;
	Wed, 19 Nov 2025 14:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LDZ5Zp28"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2B8827A442
	for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763562739; cv=none; b=jQu8vE4cnWwLGYPcrX8VxKnAkBbmSzdev6/HWRj9QKEUpD4zPva29/YG1S7I5LDU6o8IZ0Us72BFPsh3A3nrx5d4pQGFnViZ71ww8JXtcMrv2kUoOd5EhYfMQYJmJLgDQl3K+8tVUrFC2PNR8ZFlPxaAk5NeIKbnM1dnVP79cnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763562739; c=relaxed/simple;
	bh=rKto9SRu25FK3OZzqAfW5fo67ECEjbM1vEpx/2n+f18=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hzg89GnXTHCZTzX/xzGCOqUF4WwQekH6UVkvtaJZlzoB8uVHfa6bUyHiGBFZhdjwWxCUh7Pa7G/DmjvBi/8UXOV9egiBzw+ywHGcO+i8HFNsyBA43pkFpJMCHxJLC2IDzyIbXb8hv8NxhzSEWbofU2Uy9HT2kbh4uzBXFgF5+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LDZ5Zp28; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-882475d8851so71771046d6.2
        for <linux-ext4@vger.kernel.org>; Wed, 19 Nov 2025 06:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763562736; x=1764167536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8q+znNodto0M98KR2R7NvRlXozxhYBImnhJeUCTUfOM=;
        b=LDZ5Zp28D9pg6OITdqZINoD6vpc3cnXfo8FCVqi/NJex6lFMD0Pe8cMgLWwOlGDLJt
         BC1fJptCcwbzvsz3I8VjRcdDDi6KZlR4Dag3nc79yCbDbViqIX9RJ32gmUhd8AdyFaUY
         /tbBwqIPkCi68Fjua+z4UrHIZvyRYTXBCAnrjiULgaXH3wZqmev2tiOFeORZzQUIGffg
         AZvPbXGUnBIAapi4BNDXPt12wzN82NLhZu6+0IBf5iQy0/CBtjzqo0g/4r4dgR8MAWfH
         3xDxmuvdxju9zNq3hu3w/8lQRUSWOQHYqhQB8/pPwpOaOc1ef+zYHreqvmSzN4kWEFB5
         EDZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763562736; x=1764167536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8q+znNodto0M98KR2R7NvRlXozxhYBImnhJeUCTUfOM=;
        b=uNDOaLiGxNEuvAt2mCtyNxfYFljf1hl+OT9VkDjefIZF2MAtodfVqwpPbi03IvMLHG
         1SIwWdlvGqgv7php0R99F0Gh80lTxELEp35gnFKZ/+9Z8BjqMDL7+1QWNK3Bhx2oW+zc
         pOXQ0OU1UuJaXipjZneaAn1pZ4C9UhEkeLBnYsnjN8pHMFVklaNuUHSCkvCOVEZbLgNf
         RPy460U2xUffEafO1xIXlcuU/8bedAUQyoGRc6Xay1ZWudxlyiuE/Gzk1CzdQaorpeyd
         RrLrWycfIL1CzgLjRrbR7U3w9s7RS0+w1KPqQUIOHox8rKQVYRG2POpfM5xhPHV8DdHe
         JjTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVrGNctAkyEuDoL8FWYoEcY79FxfHr9fyuFGCmP4kmRAXXcY+M1jG7q4p0LU80k50yyW4bJm+MOYYt6@vger.kernel.org
X-Gm-Message-State: AOJu0Ywe8n1CBkqgpyFMrKdoqCryN3ja3yPp+kJgLIDdCDu5o21XX3Vs
	vjAGPdCoVU9KSbwi/C34uVGJTqwv5sQTpdMwBCO9L8HVuEe0wzU/FE1BbbCL0q5w
X-Gm-Gg: ASbGncutYCamFT6bwhNIfby9ShjFE/8o9e5DS7WGG5U4WzRHqjdqbn3V9b3RnYudrEr
	0Gu3b8zaF8cS6VJYbtQwwYc36cxDr05tRQaBDcfHwFY7oFvrmpL8v9p0J3I5Gv6a92tOQCnOPsc
	DUja6ylErPDikdMZKo1/dS9oelvhiQWB4laIBQhiVuBdqVK2j40hKKQOelnrQaGPOYQQx2wPduX
	BAALhjHWaEbdFEi7djTrUB3LHS+IhZ3EASoMOCDb0XDBiCBK38ZzCum8NyXtivmh1ufULaWC0yT
	ZmXUncx0Zxh1vggS0UwKtsVSloYZ9UUksDYV7kz73WxcRT22pyfi6vQzMgMHoUILv4w0y/WUqAZ
	W2HNN9y1tuECmJwYVMoq+ceLdfo/wfeTZhAtkjkW/Zhc5ZKCfZDMr0c/JKuMn0qillpzrxkFroj
	PDXafux2A7xEvGFzB2OTHymfnmCn1GqYUj+J1PR+LBV8vQDS3G7sWrlw==
X-Google-Smtp-Source: AGHT+IGNwVHZG6eQtwltPkgeDUi2dIyGh2VvkiqNs3dYVp85iL+oe1f8oZwXdAoI/FJovvVWmP2TTQ==
X-Received: by 2002:a05:6214:d0f:b0:880:278d:d4aa with SMTP id 6a1803df08f44-8845fc3e0c3mr36773686d6.7.1763562736083;
        Wed, 19 Nov 2025 06:32:16 -0800 (PST)
Received: from daniel-desktop3.localnet ([204.48.77.252])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-882863923fcsm134305136d6.25.2025.11.19.06.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 06:32:15 -0800 (PST)
From: Daniel Tang <danielzgtg.opensource@gmail.com>
To: linux-doc@vger.kernel.org, linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
 Eric Biggers <ebiggers@google.com>,
 Gabriel Krisman Bertazi <krisman@collabora.co.uk>,
 "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: [PATCH] Documentation: ext4: Document casefold and encrypt flags
Date: Wed, 19 Nov 2025 09:32:13 -0500
Message-ID: <4506189.9SDvczpPoe@daniel-desktop3>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"

Based on ext4(5) and fs/ext4/ext4.h.

For INCOMPAT_ENCRYPT, it's possible to create a new filesystem with that
flag without creating any encrypted inodes. ext4(5) says it adds
"support" but doesn't say whether anything's actually present like
COMPAT_RESIZE_INODE does.

Signed-off-by: Daniel Tang <danielzgtg.opensource@gmail.com>
---
 Documentation/filesystems/ext4/inodes.rst | 2 ++
 Documentation/filesystems/ext4/super.rst  | 4 +++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext4/inodes.rst b/Documentation/filesystems/ext4/inodes.rst
index cfc6c1659931..55cd5c380e92 100644
--- a/Documentation/filesystems/ext4/inodes.rst
+++ b/Documentation/filesystems/ext4/inodes.rst
@@ -297,6 +297,8 @@ The ``i_flags`` field is a combination of these values:
      - Inode has inline data (EXT4_INLINE_DATA_FL).
    * - 0x20000000
      - Create children with the same project ID (EXT4_PROJINHERIT_FL).
+   * - 0x40000000
+     - Use case-insensitive lookups for directory contents (EXT4_CASEFOLD_FL).
    * - 0x80000000
      - Reserved for ext4 library (EXT4_RESERVED_FL).
    * -
diff --git a/Documentation/filesystems/ext4/super.rst b/Documentation/filesystems/ext4/super.rst
index 1b240661bfa3..9a59cded9bd7 100644
--- a/Documentation/filesystems/ext4/super.rst
+++ b/Documentation/filesystems/ext4/super.rst
@@ -671,7 +671,9 @@ following:
    * - 0x8000
      - Data in inode (INCOMPAT_INLINE_DATA).
    * - 0x10000
-     - Encrypted inodes are present on the filesystem. (INCOMPAT_ENCRYPT).
+     - Encrypted inodes can be present. (INCOMPAT_ENCRYPT).
+   * - 0x20000
+     - Directories can be marked case-insensitive. (INCOMPAT_CASEFOLD).
 
 .. _super_rocompat:
 
-- 
2.51.0




