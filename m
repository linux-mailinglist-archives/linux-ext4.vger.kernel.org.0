Return-Path: <linux-ext4+bounces-10021-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 682B2B5668E
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Sep 2025 06:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAACB3A9780
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Sep 2025 04:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE0F6248176;
	Sun, 14 Sep 2025 04:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kPbZj1qM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A5F26E6E4
	for <linux-ext4@vger.kernel.org>; Sun, 14 Sep 2025 04:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822702; cv=none; b=rGPHvL6UnHgB5bb6Iuuup2ULRppxh6w5/iDcekZ/nSMjfUt2rg3dsPne81abSrp/6cO0eGlTPOGe7jFl4am4QQzqRgkv/mwzu/IbRp+Il/xN7Q3t/d0SeVSb3+s4BPyEm1b3nwIPYjc0igHgZ2dW50+ym6Dak+FJxer8OPusN6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822702; c=relaxed/simple;
	bh=K5eh5PFkTwqgMsR/pgApUC7mRgd5tIkIjFvctye1Fsc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EUG+4obcnDjEg9vQvEn2+hh1gENB/Jy3v05bythZyPit/5mcgfKxmW9ZTCnvPJQGIWhqKK4kxCz1pcc8/gPsyfbI5qR0xwo7xxzgemgFlQ90hryKWnU64hZkqp31FP73UH4ZV0D2E5XPqGbdYSsoveN75S1TSy9LWlkufQWwWVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kPbZj1qM; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b0787fc3008so458248766b.3
        for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 21:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822698; x=1758427498; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mw6NNXq6XfJ0FNmZ5frjZGClHo0iZVSxbFf+bMTHIN8=;
        b=kPbZj1qMmGYeecjJGUIlyIHIYamuich/CNzkJDmaNgGaqWvmKRH/xWtRF41uM5qkzv
         aCOo6S2Jlgd26xKUeuaakbbG7HEqDWn4lpel7AStmc2VlwPrBzY5joso88BimDPHYlXE
         lGKrirBAgOS/lwpoTHzC/tUmPxv1QF+CBszBJWWwZ+66J7mYEyOimyL2AtSvZIWLx1gK
         5mb9tOIr2zMFazTcGHaTU8u9ffMEBQkt1YmPKV0KVFaH5qyy1RH+UXAWhuy3AcjFOjXc
         Kxvqk7LMiYKMLQ7+ce+4bi1vcyj+dMrkLMVvDZ3cpLh4Ep/R+rND2M09mBBHfKuxH8K6
         CeEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822698; x=1758427498;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Mw6NNXq6XfJ0FNmZ5frjZGClHo0iZVSxbFf+bMTHIN8=;
        b=qyEpoujCWj7b5ln5MXf1c/LCkX3nO5iocTbSWbIzvc7dOn+1xFdF5w/10OhTqL0TJq
         WanX2rdh2IaII55X/PMc+0QxU8IdMO79nDfktNPXBt9Z6vtWsSQmCQK8t9uRmBByyD6n
         tVGdN3E3i98oBPAzP4Ju31f0BOcXBmqogw4HE2LPKYlZ0a+oagLXqjqlisM5NrKU3khy
         2CF0RWC85lALoSuXWEI8R6DxswC/Xnvy7jbKJ1SbvjopxMufa8IpDSARI0bSyuRQ6ruW
         9P+VYhCXadF6amsjM7UlLsu9C7pAcguFp9tRu4oPxrnsPvkDPa6Pk063eH7qgkhV0uAB
         0xZA==
X-Forwarded-Encrypted: i=1; AJvYcCX1TFIV1k0hyNi9UE0VPTrRCZ5SrngoNaARp9uoVq5UW/lxXXJjI8PSfvkS8ThSkB2Lc5O/S/ul4upV@vger.kernel.org
X-Gm-Message-State: AOJu0YxU3QljFwg9xDXi/AxcULvQ0o05EbFo8t5FZbkwg4aWRhWu1D7M
	Bikoz2qba4CtPYxW0LM0uN+jUQPAx1uxSobCX/mWGkNg0wdvMTl6xgDb
X-Gm-Gg: ASbGnctpqWuPytmuIwm01R4FV/HcnmHc5ztU37Vph/9JAgRCAdajhaWMgSFbG8P8eNi
	3Fbov0rScE93okVtNi3gRGW+yPAHVDr0fJPXoAofFLnX0ZjJhNgSR8Mk1qpuLwka+ZLGoFl2Hxt
	Q1eEyZgZZ2+pBQZT/nO/O3Q8EZBW6CMLp1JBmoTI6zq8NeASMIndvhRurQp8B1nm7L9ydb4kjX/
	tSuJWCsxu/QS/jMhc+I8SV8qVN4+uM4cJq+H4m6nWqGY42Rr4IKIqJC7MxCcjsSNcV4RShx4qTr
	we17+XNt06IDQqM6UGWieUPrRjsXTiiFnI9QfGPIHvKVNzlXKnZL33M9fJ6agNpKIcm2qqfzTKd
	1uLnn7/gmEOhIaZtZB/Q=
X-Google-Smtp-Source: AGHT+IEha/cEycx+vu0xF7TxjEegwfvZABBYj962u8Q3zWPEYF1LD+BxwewIqIoCpytaOJDSx3nrIQ==
X-Received: by 2002:a17:907:3d8e:b0:b04:706a:bcfc with SMTP id a640c23a62f3a-b07c37fd45cmr876333266b.33.1757822697695;
        Sat, 13 Sep 2025 21:04:57 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07dbf5dbf5sm308085466b.79.2025.09.13.21.04.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:04:57 -0700 (PDT)
From: Askar Safin <safinaskar@gmail.com>
To: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Aleksa Sarai <cyphar@cyphar.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Julian Stecklina <julian.stecklina@cyberus-technology.de>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Art Nikpal <email2tema@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Curtin <ecurtin@redhat.com>,
	Alexander Graf <graf@amazon.com>,
	Rob Landley <rob@landley.net>,
	Lennart Poettering <mzxreary@0pointer.de>,
	linux-arch@vger.kernel.org,
	linux-alpha@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	x86@kernel.org,
	Ingo Molnar <mingo@redhat.com>,
	linux-block@vger.kernel.org,
	initramfs@vger.kernel.org,
	linux-api@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-efi@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	"Theodore Y . Ts'o" <tytso@mit.edu>,
	linux-acpi@vger.kernel.org,
	Michal Simek <monstr@monstr.eu>,
	devicetree@vger.kernel.org,
	Luis Chamberlain <mcgrof@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Heiko Carstens <hca@linux.ibm.com>,
	patches@lists.linux.dev
Subject: [PATCH RESEND 62/62] init: rename CONFIG_RD_ZSTD to CONFIG_INITRAMFS_DECOMPRESS_ZSTD
Date: Sun, 14 Sep 2025 07:04:51 +0300
Message-ID: <20250914040451.3848715-1-safinaskar@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250913003842.41944-1-safinaskar@gmail.com>
References: <20250913003842.41944-1-safinaskar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Initrd support was removed,
and CONFIG_RD_ZSTD has nothing to do with ramdisks.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/riscv/configs/nommu_k210_defconfig | 2 +-
 usr/Kconfig                             | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 6e961256a941..68cae0496b54 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -7,7 +7,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
-# CONFIG_RD_ZSTD is not set
+# CONFIG_INITRAMFS_DECOMPRESS_ZSTD is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_SYSFS_SYSCALL is not set
 # CONFIG_FHANDLE is not set
diff --git a/usr/Kconfig b/usr/Kconfig
index 3a891a0c9ef4..06e1c1474b68 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -100,7 +100,7 @@ config INITRAMFS_DECOMPRESS_LZ4
 	  Support loading of a LZ4 encoded initial ramfs.
 	  If unsure, say N.
 
-config RD_ZSTD
+config INITRAMFS_DECOMPRESS_ZSTD
 	bool "Support initial ramfs compressed using ZSTD"
 	default y
 	select DECOMPRESS_ZSTD
@@ -206,7 +206,7 @@ config INITRAMFS_COMPRESSION_LZ4
 
 config INITRAMFS_COMPRESSION_ZSTD
 	bool "ZSTD"
-	depends on RD_ZSTD
+	depends on INITRAMFS_DECOMPRESS_ZSTD
 	help
 	  ZSTD is a compression algorithm targeting intermediate compression
 	  with fast decompression speed. It will compress better than GZIP and
-- 
2.47.2


