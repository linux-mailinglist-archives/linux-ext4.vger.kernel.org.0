Return-Path: <linux-ext4+bounces-9977-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BBE9B55C98
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Sep 2025 03:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F435C538B
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Sep 2025 01:05:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8528918991E;
	Sat, 13 Sep 2025 01:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXv4iNf2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 381621917E3
	for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 01:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725515; cv=none; b=k1nHGetc+7vdwM7lCtE12ArI5gWHwmmBmdbjTG/2YzRyI9jbMvdOjJqNJgrRksv3CF7k5K6/8ZhOwLuVGrMUmaot8ANzZHcsfGazE6KkpxqgPT8B+yUkIE8/FxJ4PfmwKdVMWWKfA36iQIFDg0ivSi1hl7WlT3atSCG+ow768SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725515; c=relaxed/simple;
	bh=S+LMTI5gKh7jR4HnMBjppMSsjKCA+4Wi7QuAEkwwnu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cDjj8IbICQBnlXwkqO/TO7InokMJWNVMywi62XmFR+2sNriyPRYzLcfczRgrqDj1vDnq6SEbFyly7F0//awM6/KMF8Y59sBT4NMSSNFq4ylyzajgszAVWITF4dTObYtIzr1irXzVUa+2fc5gZJ7CfbuUBZ3rnSryKb4adrivc2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXv4iNf2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b0473327e70so420924166b.3
        for <linux-ext4@vger.kernel.org>; Fri, 12 Sep 2025 18:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725509; x=1758330309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5agMVhmWz9D3tLYyZnqIaP8gTBBboQ75Wn3D7w2vh+Q=;
        b=dXv4iNf2H8URQWzVOiVcXlt/g9fQImXw5sgTfH+9HFtO7xY/TcP/JiWlyVtkxKLaYH
         HKyZQoTqjJf8lbm+SDIT59oKVrtvwBs21iYZ589G+wHyCqc08cqtn0mlfzTt9OPuOBIS
         MvOZqqIqMIPeNg/4A+FX8sv/zeDWyf0s8ePFAoOmS84Ek+oiXa1AVyB9nR4AHHeZvcpW
         rV+hwVJHVPBaVpRxyXeBWkEBhVTD33JGA+xi5mxhx68lc2NZ32dDqjn31/VizAz9l7HR
         +l0d4WIECCoTLmx+3hFjhe+LYu/MD207FATDiWTCBdqdHsiOU2u4rFNsDVidduqFAYo1
         rrYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725509; x=1758330309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5agMVhmWz9D3tLYyZnqIaP8gTBBboQ75Wn3D7w2vh+Q=;
        b=Ob/yKOJ46OUl0sLJg3qxuDnNbvwPicrjc9DDO2vbcl7kj+qSAcM8VTEzGuNMc/g89X
         589XrjDktjrKkSkvCNKsBhQGngVYHMt9uBWckHnLYuFpJbObzmynS20kMlFzq85YlrHU
         8eMNGEOOqtQCJY0vVkoAXIwLD80HSYyA2gkwB+3mKQzFrrysSnG2Oe2qDL0ZcDrP3d8q
         sBxC4aTiEiB69Znyqh41xZHrADJK+ebK8T4XxtROBZLMJAOxE4EySlcTpqFHePmq9uiR
         H9ILtOWXdaPasNQtTV8tqBfxSp7jQtE0Lp31ESdFtbSoVVdUheF38WhD1wqSOdA3G0Rm
         5jpw==
X-Forwarded-Encrypted: i=1; AJvYcCVkOagbSSenl4tC1FrLjSYDII4nzkFlSJMazmCsUADXvUwMo0/Jb0HzZAs/p7unahN45ukVCG1KTJlG@vger.kernel.org
X-Gm-Message-State: AOJu0YykVTVTufXtL/wlf2xO3vAhXCrVKFkzlA4k46TnHfJTlqIsxByj
	0iiLccg2xiKGTYVZD8Ma3xJIRBvqJ1cDB/tOA0PlOGVzrWocDH6Bn5tv
X-Gm-Gg: ASbGncvSWPztPhHoSqF24nvPuPj4Ag3gkxzIO+i14IDxJgz3ylXgqiB1TpjIZTZyTY8
	nkSDtarAY1xY7bRGw0qB5lG08CrO0p7BURI+eC5FubFqNd83TiS+NjmPp4YBqqQxfserWOZhkPO
	xyfgJMsF0JJaf2O4HqCkA8a4nz7RHdyePsTmCT+7LZfT6DH0sDcDAAedPW5F7Ux+ARD68Tz5o2i
	Pa5xn5S+No+b/kdslc9Agx4r+C/5eMvh850vLyioTvtejUKr/Wac/xT3j4eE3BQoO3KW13EOqo4
	ARy7xxwoXLdPkDDZvI7gsjQ5p7P5Ix+pdLPhvGD2+S7I3sGfXTj0VbhdSJVrwEeyoV/vvQ24B0s
	K9MiKER3FibZhpQVy/E0=
X-Google-Smtp-Source: AGHT+IHBVL7U9njYQbYDntatJDbtYTvNiZyrYrp6F3Zot8CfKJXHpFfpfQfFxJfdQecWj/pXbevxCg==
X-Received: by 2002:a17:907:980a:b0:b04:7ea3:a10c with SMTP id a640c23a62f3a-b07c3551576mr448691266b.8.1757725509440;
        Fri, 12 Sep 2025 18:05:09 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b31291b0sm475372166b.34.2025.09.12.18.05.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:05:08 -0700 (PDT)
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
Subject: [PATCH RESEND 23/62] init: rename __initramfs_{start,size} to __builtin_initramfs_{start,size}
Date: Sat, 13 Sep 2025 00:38:02 +0000
Message-ID: <20250913003842.41944-24-safinaskar@gmail.com>
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

Rename __initramfs_start to __builtin_initramfs_start and
__initramfs_size to __builtin_initramfs_size .

This is more clear

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 arch/x86/tools/relocs.c           | 2 +-
 drivers/acpi/tables.c             | 4 ++--
 include/asm-generic/vmlinux.lds.h | 6 +++---
 include/linux/initrd.h            | 4 ++--
 init/initramfs.c                  | 4 +---
 usr/initramfs_data.S              | 4 ++--
 6 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 5778bc498415..4b4e556f1b52 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -87,7 +87,7 @@ static const char * const	sym_regex_kernel[S_NSYMTYPES] = {
 	"__(start|stop)_notes|"
 	"__end_rodata|"
 	"__end_rodata_aligned|"
-	"__initramfs_start|"
+	"__builtin_initramfs_start|"
 	"(jiffies|jiffies_64)|"
 #if ELF_BITS == 64
 	"__end_rodata_hpage_align|"
diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
index fa9bb8c8ce95..3160cb7dca00 100644
--- a/drivers/acpi/tables.c
+++ b/drivers/acpi/tables.c
@@ -429,8 +429,8 @@ void __init acpi_table_upgrade(void)
 	struct cpio_data file;
 
 	if (IS_ENABLED(CONFIG_ACPI_TABLE_OVERRIDE_VIA_BUILTIN_INITRD)) {
-		data = __initramfs_start;
-		size = __initramfs_size;
+		data = __builtin_initramfs_start;
+		size = __builtin_initramfs_size;
 	} else {
 		data = (void *)initrd_start;
 		size = initrd_end - initrd_start;
diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index ae2d2359b79e..a6bd2ff46f7e 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -46,8 +46,8 @@
  * [_sdata, _edata] is the data section
  *
  * Some of the included output section have their own set of constants.
- * Examples are: [__initramfs_start, __initramfs_end] for initramfs and
- *               [__nosave_begin, __nosave_end] for the nosave data
+ * Examples are: [__builtin_initramfs_start, __builtin_initramfs_start + __builtin_initramfs_size]
+ * for initramfs and [__nosave_begin, __nosave_end] for the nosave data
  */
 
 #include <asm-generic/codetag.lds.h>
@@ -969,7 +969,7 @@ defined(CONFIG_AUTOFDO_CLANG) || defined(CONFIG_PROPELLER_CLANG)
 #ifdef CONFIG_BLK_DEV_INITRD
 #define INIT_RAM_FS							\
 	. = ALIGN(4);							\
-	__initramfs_start = .;						\
+	__builtin_initramfs_start = .;						\
 	KEEP(*(.init.ramfs))						\
 	. = ALIGN(8);							\
 	KEEP(*(.init.ramfs.info))
diff --git a/include/linux/initrd.h b/include/linux/initrd.h
index cc389ef1a738..e49c7166dbb3 100644
--- a/include/linux/initrd.h
+++ b/include/linux/initrd.h
@@ -21,8 +21,8 @@ static inline void wait_for_initramfs(void) {}
 extern phys_addr_t phys_initrd_start;
 extern unsigned long phys_initrd_size;
 
-extern char __initramfs_start[];
-extern unsigned long __initramfs_size;
+extern char __builtin_initramfs_start[];
+extern unsigned long __builtin_initramfs_size;
 
 void console_on_rootfs(void);
 
diff --git a/init/initramfs.c b/init/initramfs.c
index 850cb0de873e..2866d7a0afd7 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -597,8 +597,6 @@ static int __init initramfs_async_setup(char *str)
 }
 __setup("initramfs_async=", initramfs_async_setup);
 
-extern char __initramfs_start[];
-extern unsigned long __initramfs_size;
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
@@ -695,7 +693,7 @@ static inline bool kexec_free_initrd(void)
 static void __init do_populate_rootfs(void *unused, async_cookie_t cookie)
 {
 	/* Load the built in initramfs */
-	char *err = unpack_to_rootfs(__initramfs_start, __initramfs_size);
+	char *err = unpack_to_rootfs(__builtin_initramfs_start, __builtin_initramfs_size);
 	if (err)
 		panic_show_mem("%s", err); /* Failed to decompress INTERNAL initramfs */
 
diff --git a/usr/initramfs_data.S b/usr/initramfs_data.S
index cd67edc38797..64ca648a80e2 100644
--- a/usr/initramfs_data.S
+++ b/usr/initramfs_data.S
@@ -27,8 +27,8 @@ __irf_start:
 .incbin "usr/initramfs_inc_data"
 __irf_end:
 .section .init.ramfs.info,"a"
-.globl __initramfs_size
-__initramfs_size:
+.globl __builtin_initramfs_size
+__builtin_initramfs_size:
 #ifdef CONFIG_64BIT
 	.quad __irf_end - __irf_start
 #else
-- 
2.47.2


