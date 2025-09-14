Return-Path: <linux-ext4+bounces-10020-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD36FB56681
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Sep 2025 06:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 073EF1A21D02
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Sep 2025 04:05:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863202773E5;
	Sun, 14 Sep 2025 04:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O4aOOK0f"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D100C1A5B9E
	for <linux-ext4@vger.kernel.org>; Sun, 14 Sep 2025 04:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822668; cv=none; b=t20h2l0Q0Xay77hOjwxaK0Gtf+JZh1Cczw3As4TNnj0QqlCdrSYfAYZ2g6hllPi3lvJI3x+tK0HVGR61JxUJDp5HvJ28mzUpsz7sgY1+iQeLAshtz5PjrW5HcrbpS/XUW2fAVqg38X8T8DVr4i544rkLrHBxH3Rxn8TjogMR0dk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822668; c=relaxed/simple;
	bh=CLKN0vFxPTCS+4xpoDHyCjYmZBC4ifFWYJ0ane4ULJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lzrWNCrovTyR/Y3bSPC1YDlnlJD0ZlS3RH8CKfo9u/sQoKllb51bA00wX1r9Lq2zGWdwr5/GTvOly6zFAzDMNeLL0phm1ngjY6i48rTd8tzxdfhku5KVKFy4SMx+XKtibSrtD9Wm8owHHqwJwoTTFQDoFqxY0ndG0qnOjIJx/ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O4aOOK0f; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b07c081660aso429360266b.0
        for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 21:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822661; x=1758427461; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQmt9Zed9iIletHUt2qeYNjKhIuvjCTi/Cw19xUj63o=;
        b=O4aOOK0f+GtOsGAAPPlXg8fFE95tuM2EQFB49oUx3b3Nl5B/5OA5rXfu1q9ojKkWV9
         Zo4btBxuUzDdk+pqdb3IYp5Ulqq+lzZJsgtJmaCa457noCUwaLR81qIJL6ouiGc00gRk
         5p5Br5m/TW7pvovRPr7L5WYkpqnIZE+y8IbYJliRhk3YkABphhkugbXrSPHoLgu3y7Dw
         zcgwcsd9h4d8FZo0id5gds80lttGaQtyWJwWGsS7UuoN3+ALaZgIusniAiKigUAClqEY
         lZ5zRA8Q2QenwaZ7oHQJKbrqN0oMNsoM1No9BD7u+iVWyDHQlQyPBD2XSYErmZSkQp4k
         iSOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822661; x=1758427461;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zQmt9Zed9iIletHUt2qeYNjKhIuvjCTi/Cw19xUj63o=;
        b=Vf5EsclLRtM6bgSzAFzs3n56oK9Hvlxr2p7o4y7+09dmN21NmcsTH2odATg/8vsAKp
         tMJKj1iTUMdepqO23Un+/Grglr1NaH1aoo65IdaD2nKjDtxv6c+0nblQUU8REcOByUrk
         GO0js7FErZV3QJK1w2eXu7K/UyZhjME+aPCHKp+nRAuBhb9n7iyFAjuXZ72yIWuKXA3n
         rJZZQbZlaVYyKTMDaoTrPugJ5o6bb7XromB6a1g07I5vpPXxOvNppvCBV0Mry0UIE1g8
         7Z9tUJdImTtAIWFF+5CFZcA4k7OSI8HsWDBAMsM5iW4Ntnfa3Sqq5HXS27aFH2+3J6aZ
         WtwA==
X-Forwarded-Encrypted: i=1; AJvYcCV+80UNEUV2IC1BnvxfPDzFvYKInDmHwSpc2JM6seo1hHg8F38+mYHNUIkJD7fKSfsTftomEpIKQwTw@vger.kernel.org
X-Gm-Message-State: AOJu0YyzQhaXqDLiTsYYPCShGK2FRgoVAkaklHEcGDKq8tbD8EXrI7JD
	rbw78CYC36LpBA2PhOdbu56m302E+Wzxzqmj4i3qgimx8uEHbXGCASkY
X-Gm-Gg: ASbGncvjormShZhscuU/J7GIAkbpA+9cilGiVSUU0NUHTpAgLKhY9G1J8RqTKZ0R3pU
	6B13JFZpjvxgqsPCv9LgN+NRvc1OTRYjJXfTQTDITA2Xegdfy+ezlwEZdSAXkMWuyPwRMYbBOYa
	aOUi2mOKCK6MVmvGH92IamMZveTj+HzOfV3AA3oY277qAD87ibT23QwgRl10Br+fEAoKWKjpWce
	ezVKjZ9rZsz3cTVAyiPV+Bmeh8XXZv5ns7zs1/UVfME/FYzGTVSWdIgQr0Sz32nIfoFPS0Tl70g
	2ZxzQ8dFSVPfC4gkqIUbhYKzbf7cucJe4B6iILXg5BR8YzCyqIRrbHNAr7mwqfoYTFUVesfT+Ul
	I/WJtlws6VDa6FSk3NYYZg9Kjd9R+rw==
X-Google-Smtp-Source: AGHT+IHaFT6KFwuX+yIp0UoOdQj6J/d/IOTebo0H4gG0vMFBsMmT50PoMXVLJ+eEN7aUH8ZQwvBwiA==
X-Received: by 2002:a17:907:3ea6:b0:b09:48c6:b7b0 with SMTP id a640c23a62f3a-b0948c6c713mr431888166b.56.1757822661177;
        Sat, 13 Sep 2025 21:04:21 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd57csm669318166b.52.2025.09.13.21.04.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 21:04:20 -0700 (PDT)
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
Subject: [PATCH RESEND 61/62] init: rename CONFIG_RD_LZ4 to CONFIG_INITRAMFS_DECOMPRESS_LZ4
Date: Sun, 14 Sep 2025 07:04:15 +0300
Message-ID: <20250914040416.3840072-1-safinaskar@gmail.com>
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
and CONFIG_RD_LZ4 has nothing to do with ramdisks.

Update your configs

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/arm/configs/aspeed_g4_defconfig       | 2 +-
 arch/arm/configs/aspeed_g5_defconfig       | 2 +-
 arch/arm/configs/lpc18xx_defconfig         | 2 +-
 arch/arm/configs/sp7021_defconfig          | 2 +-
 arch/arm/configs/vf610m4_defconfig         | 2 +-
 arch/mips/configs/ath25_defconfig          | 2 +-
 arch/mips/configs/bmips_stb_defconfig      | 2 +-
 arch/openrisc/configs/simple_smp_defconfig | 2 +-
 arch/powerpc/configs/44x/fsp2_defconfig    | 2 +-
 arch/powerpc/configs/skiroot_defconfig     | 2 +-
 arch/riscv/configs/nommu_k210_defconfig    | 2 +-
 arch/riscv/configs/nommu_virt_defconfig    | 2 +-
 arch/xtensa/configs/cadence_csp_defconfig  | 2 +-
 arch/xtensa/configs/nommu_kc705_defconfig  | 2 +-
 usr/Kconfig                                | 4 ++--
 15 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/arm/configs/aspeed_g4_defconfig b/arch/arm/configs/aspeed_g4_defconfig
index 2b22ce99e42d..a65bdc6e6c2f 100644
--- a/arch/arm/configs/aspeed_g4_defconfig
+++ b/arch/arm/configs/aspeed_g4_defconfig
@@ -11,7 +11,7 @@ CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
 # CONFIG_SYSFS_SYSCALL is not set
diff --git a/arch/arm/configs/aspeed_g5_defconfig b/arch/arm/configs/aspeed_g5_defconfig
index 764fde3d416b..24954645c34f 100644
--- a/arch/arm/configs/aspeed_g5_defconfig
+++ b/arch/arm/configs/aspeed_g5_defconfig
@@ -11,7 +11,7 @@ CONFIG_NAMESPACES=y
 CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_EXPERT=y
 # CONFIG_UID16 is not set
 # CONFIG_SYSFS_SYSCALL is not set
diff --git a/arch/arm/configs/lpc18xx_defconfig b/arch/arm/configs/lpc18xx_defconfig
index b14ebbe5b023..4dee6346a6a8 100644
--- a/arch/arm/configs/lpc18xx_defconfig
+++ b/arch/arm/configs/lpc18xx_defconfig
@@ -5,7 +5,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_UID16 is not set
 CONFIG_BASE_SMALL=y
diff --git a/arch/arm/configs/sp7021_defconfig b/arch/arm/configs/sp7021_defconfig
index e65c94f24341..6b1166cbf478 100644
--- a/arch/arm/configs/sp7021_defconfig
+++ b/arch/arm/configs/sp7021_defconfig
@@ -10,7 +10,7 @@ CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_PERF_EVENTS=y
 CONFIG_ARCH_SUNPLUS=y
diff --git a/arch/arm/configs/vf610m4_defconfig b/arch/arm/configs/vf610m4_defconfig
index 7d457a196dfc..acec039e2f16 100644
--- a/arch/arm/configs/vf610m4_defconfig
+++ b/arch/arm/configs/vf610m4_defconfig
@@ -3,7 +3,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 # CONFIG_MMU is not set
diff --git a/arch/mips/configs/ath25_defconfig b/arch/mips/configs/ath25_defconfig
index baf32dfe8295..5e84ee24e372 100644
--- a/arch/mips/configs/ath25_defconfig
+++ b/arch/mips/configs/ath25_defconfig
@@ -7,7 +7,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_FHANDLE is not set
 # CONFIG_AIO is not set
diff --git a/arch/mips/configs/bmips_stb_defconfig b/arch/mips/configs/bmips_stb_defconfig
index 44830de10527..b5fb138bf237 100644
--- a/arch/mips/configs/bmips_stb_defconfig
+++ b/arch/mips/configs/bmips_stb_defconfig
@@ -19,7 +19,7 @@ CONFIG_MIPS_O32_FP64_SUPPORT=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 CONFIG_INITRAMFS_DECOMPRESS_XZ=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
 CONFIG_PCIEASPM_POWERSAVE=y
diff --git a/arch/openrisc/configs/simple_smp_defconfig b/arch/openrisc/configs/simple_smp_defconfig
index 9f4bb9d940f0..5265f6f940a5 100644
--- a/arch/openrisc/configs/simple_smp_defconfig
+++ b/arch/openrisc/configs/simple_smp_defconfig
@@ -7,7 +7,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_EXPERT=y
 # CONFIG_KALLSYMS is not set
 # CONFIG_EPOLL is not set
diff --git a/arch/powerpc/configs/44x/fsp2_defconfig b/arch/powerpc/configs/44x/fsp2_defconfig
index e5e4f6721728..34486aa5155f 100644
--- a/arch/powerpc/configs/44x/fsp2_defconfig
+++ b/arch/powerpc/configs/44x/fsp2_defconfig
@@ -12,7 +12,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_KALLSYMS_ALL=y
 CONFIG_BPF_SYSCALL=y
 CONFIG_EXPERT=y
diff --git a/arch/powerpc/configs/skiroot_defconfig b/arch/powerpc/configs/skiroot_defconfig
index fc1a718af17a..d159882484f6 100644
--- a/arch/powerpc/configs/skiroot_defconfig
+++ b/arch/powerpc/configs/skiroot_defconfig
@@ -14,7 +14,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_BZIP2 is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_SGETMASK_SYSCALL is not set
diff --git a/arch/riscv/configs/nommu_k210_defconfig b/arch/riscv/configs/nommu_k210_defconfig
index 7507045e9c4a..6e961256a941 100644
--- a/arch/riscv/configs/nommu_k210_defconfig
+++ b/arch/riscv/configs/nommu_k210_defconfig
@@ -6,7 +6,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 # CONFIG_RD_ZSTD is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 # CONFIG_SYSFS_SYSCALL is not set
diff --git a/arch/riscv/configs/nommu_virt_defconfig b/arch/riscv/configs/nommu_virt_defconfig
index afa79217f06e..eb289c44dfc3 100644
--- a/arch/riscv/configs/nommu_virt_defconfig
+++ b/arch/riscv/configs/nommu_virt_defconfig
@@ -5,7 +5,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 # CONFIG_SYSFS_SYSCALL is not set
diff --git a/arch/xtensa/configs/cadence_csp_defconfig b/arch/xtensa/configs/cadence_csp_defconfig
index dad9383c6deb..26a4a9f3886a 100644
--- a/arch/xtensa/configs/cadence_csp_defconfig
+++ b/arch/xtensa/configs/cadence_csp_defconfig
@@ -18,7 +18,7 @@ CONFIG_INITRAMFS_SOURCE="$$KERNEL_INITRAMFS_SOURCE"
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_EXPERT=y
 CONFIG_PROFILING=y
diff --git a/arch/xtensa/configs/nommu_kc705_defconfig b/arch/xtensa/configs/nommu_kc705_defconfig
index 0a0e94ae7b1c..988998806661 100644
--- a/arch/xtensa/configs/nommu_kc705_defconfig
+++ b/arch/xtensa/configs/nommu_kc705_defconfig
@@ -19,7 +19,7 @@ CONFIG_INITRAMFS=y
 # CONFIG_INITRAMFS_DECOMPRESS_LZMA is not set
 # CONFIG_INITRAMFS_DECOMPRESS_XZ is not set
 # CONFIG_INITRAMFS_DECOMPRESS_LZO is not set
-# CONFIG_RD_LZ4 is not set
+# CONFIG_INITRAMFS_DECOMPRESS_LZ4 is not set
 CONFIG_EXPERT=y
 CONFIG_KALLSYMS_ALL=y
 CONFIG_PERF_EVENTS=y
diff --git a/usr/Kconfig b/usr/Kconfig
index 62c978018565..3a891a0c9ef4 100644
--- a/usr/Kconfig
+++ b/usr/Kconfig
@@ -92,7 +92,7 @@ config INITRAMFS_DECOMPRESS_LZO
 	  Support loading of a LZO encoded initial ramfs.
 	  If unsure, say N.
 
-config RD_LZ4
+config INITRAMFS_DECOMPRESS_LZ4
 	bool "Support initial ramfs compressed using LZ4"
 	default y
 	select DECOMPRESS_LZ4
@@ -195,7 +195,7 @@ config INITRAMFS_COMPRESSION_LZO
 
 config INITRAMFS_COMPRESSION_LZ4
 	bool "LZ4"
-	depends on RD_LZ4
+	depends on INITRAMFS_DECOMPRESS_LZ4
 	help
 	  It's compression ratio is the poorest amongst the choices. The kernel
 	  size is about 15% bigger than gzip; however its decompression speed
-- 
2.47.2


