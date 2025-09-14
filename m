Return-Path: <linux-ext4+bounces-10004-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A51EB56533
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Sep 2025 05:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 88FB8189765A
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Sep 2025 03:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BB4B272E63;
	Sun, 14 Sep 2025 03:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SnKvRore"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21F6A25334B
	for <linux-ext4@vger.kernel.org>; Sun, 14 Sep 2025 03:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822089; cv=none; b=XoiYQEDLq5aPI+8z62XExmtir29XCmfIffhERLSw5x1N/geS5SoRI96TUdzw29taWdAPP8ReanKwKVK027ySI0skko9R+SZTuZJvbXLd5KB54kenJkDqGEpwkzHQh6bitCjpOaFQ7TSXROf+HAZaPQJPRdelcVClc7X3G9KkvSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822089; c=relaxed/simple;
	bh=z148AkYrWgRabAliJ93Wt4Z2ZD8niTFA9cUReN1NNec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BZ4D7MogUJWsqE+SDCpVhpdDf84UOyagztyD9u1VPNLATeSX9ml0z0a/HlvNlq0J6eIKD1TWzOWIeZ4Dg36WJamAQPdQ0YX2fWt++FuwZBvJhoylL+/t1nUDnHZIVF2RNga9Le4LtZIvSQuuGkfWTt/VQB2BVnvlHBK+W3TtJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SnKvRore; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b07dac96d1eso212501766b.1
        for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 20:54:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822083; x=1758426883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pjKVSjXysip/b5UNUwgMX+OIg9u3DNn6e0+I8Cmpn0k=;
        b=SnKvRoreLVbwLq3ZfOlOAtKHzJTK+2CRHD7ST4oqw6m/ZX2K/TZA22o1yNoPXi2wZ5
         G7kuVImssYITwW/jgXP4hkFh2XUZ+TERnohXGu6hptn3aDrOoY98hw+QU1dhrDTt5T8k
         mMC8GCnLmrUP1UL8ToJv32F/LGSgjUKrOXx4232qqs1cxpwgRVRk7tE8FWchEOHHC9Tp
         2SVUSHGslP+mCL9Z2UrOW6k9kv36DNY8Z2iTZPf0J8NDSEFQeGls4ACw/IuSe9ucFlYV
         m/I19RcmkFI3CO/PBZXuNWwi6tPZdk4wyrRTTsiUNwQ1IuWcK82Mr0pn/is7hcMyR4y2
         XIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822084; x=1758426884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjKVSjXysip/b5UNUwgMX+OIg9u3DNn6e0+I8Cmpn0k=;
        b=Ws9jBLbpbFLMO+Ri2Y+dgs6ixZqfsUPs2y+eVfZ5780sDsVYWMbtuO1VmQPiFYQy62
         xIyFlwFdh25XCi0lVuRXhFWyLel0jSfpPFvtOOZPSPXR/2EJ3EOtQwE4YypQo9xJVxBA
         toP2rP1J+dNu0avNHETNtNqHERh5jesww/tiY6wEkzJ025r+xOCwPqzzxjHkrArFwNpZ
         VonIOHIiCjZh4B0ZbLMqLHL1u4wl0CWB0tw2fVw/Z4wKffnGGoSSi6GXxIxVRQEmMj50
         P4eRw1jV5p2IKgwVB7vFMKWqroR8cWKpKFTF4ceGlL7f4G7/uEoWQMxLjsqHeDZsxA0I
         wX6Q==
X-Forwarded-Encrypted: i=1; AJvYcCW8FUuJvxe04aJVqR1vgkKjV75MvJpo7DTGfnD3EXlwYemi+KxBDUUOvxl48BxpFHU+MzEhlY+dlUTE@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZbKSmBFdd4+U9HRBOa8Nx+TVnpixMduGlkaUbGWR0QEKTClP
	O3qlo8KkrS0ty7Ow4p/zXaVXPSJdtR4BtUH12c6pCIEdQMw2JMDcza/n
X-Gm-Gg: ASbGncsKJ/0NvF3LzThLCyNEtrCNnHYZQfPnYjRByFB4PhaVPh01dH0+8J6yIuTUYeI
	ssEQnX1s1RNgtTf2QD3D0G5G7pk89bO/3qDC4WL59iUwr4f98pEB6uyetxfhiMsfCrePIJWO+18
	0eSGju8VF4zYkC3NNsHbuIcpdhu8PdvIglcp/UdRYagjHtpGl5RntewAHwAG3jPtfY6KInZOK9D
	5QbaSTed2OCt01cOTm4ECZCMuLiicmCgiyLb53Mi99fKYXWqu8vvH/47MclaIzmM1bPe+3FcTtb
	XlCLkkNTdxS3jbgIki8G8TrFMsp3mrxDtkgtniaFEgA6UmvKFcIWa5dZF0sp/GBnjYn5AY8br9t
	fua0sX9MoADYY2bIVc+wZxMHd8z5+EQ==
X-Google-Smtp-Source: AGHT+IFpMpCVJeNrUipt0dZC4eBHRTy08fiFy9cwywIocPIoMawoMDT0bJrFyHi72vkPeUNRc3Oodg==
X-Received: by 2002:a17:906:114e:b0:b0b:35d8:248e with SMTP id a640c23a62f3a-b0b35d8267fmr237998166b.18.1757822083468;
        Sat, 13 Sep 2025 20:54:43 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd5a9sm665619166b.57.2025.09.13.20.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:54:43 -0700 (PDT)
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
Subject: [PATCH RESEND 45/62] doc: kernel-parameters: replace [RAM] with [INITRAMFS]
Date: Sun, 14 Sep 2025 06:54:38 +0300
Message-ID: <20250914035438.3682240-1-safinaskar@gmail.com>
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

Also, do other initramfs-related edits, while we are here

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../admin-guide/kernel-parameters.rst         |  4 ++--
 .../admin-guide/kernel-parameters.txt         | 20 +++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.rst b/Documentation/admin-guide/kernel-parameters.rst
index 39d0e7ff0965..22af6bbffc35 100644
--- a/Documentation/admin-guide/kernel-parameters.rst
+++ b/Documentation/admin-guide/kernel-parameters.rst
@@ -123,7 +123,7 @@ is applicable::
 	CMA	Contiguous Memory Area support is enabled.
 	DRM	Direct Rendering Management support is enabled.
 	DYNAMIC_DEBUG Build in debug messages and enable them at runtime
-	EARLY	Parameter processed too early to be embedded in initrd.
+	EARLY	Parameter processed too early to be embedded in initramfs.
 	EDD	BIOS Enhanced Disk Drive Services (EDD) is enabled
 	EFI	EFI Partitioning (GPT) is enabled
 	EVM	Extended Verification Module
@@ -134,6 +134,7 @@ is applicable::
 	HW	Appropriate hardware is enabled.
 	HYPER_V HYPERV support is enabled.
 	IMA     Integrity measurement architecture is enabled.
+	INITRAMFS Initramfs support is enabled.
 	IP_PNP	IP DHCP, BOOTP, or RARP is enabled.
 	IPV6	IPv6 support is enabled.
 	ISAPNP	ISA PnP code is enabled.
@@ -167,7 +168,6 @@ is applicable::
 	PPT	Parallel port support is enabled.
 	PS2	Appropriate PS/2 support is enabled.
 	PV_OPS	A paravirtualized kernel is enabled.
-	RAM	RAM disk support is enabled.
 	RDT	Intel Resource Director Technology.
 	RISCV	RISCV architecture is enabled.
 	S390	S390 architecture is enabled.
diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0805d3ebc75a..8e10abac4cc7 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -565,7 +565,7 @@
 			Format: integer
 
 	bootconfig	[KNL,EARLY]
-			Extended command line options can be added to an initrd
+			Extended command line options can be added to an initramfs
 			and this will cause the kernel to look for it.
 
 			See Documentation/admin-guide/bootconfig.rst
@@ -1005,7 +1005,7 @@
 			may be missing from the dump.
 
 			A standard crashkernel reservation, as described above,
-			is still needed to hold the crash kernel and initrd.
+			is still needed to hold the crash kernel and initramfs.
 
 			This option increases the risk of a kdump failure: DMA
 			transfers configured by the first kernel may end up
@@ -2298,7 +2298,7 @@
 			initcall functions.  Useful for debugging built-in
 			modules and initcalls.
 
-	initramfs_async= [KNL]
+	initramfs_async= [INITRAMFS,KNL]
 			Format: <bool>
 			Default: 1
 			This parameter controls whether the initramfs
@@ -2310,10 +2310,10 @@
 			unpacking being completed before device_ and
 			late_ initcalls.
 
-	initrd=		[BOOT,EARLY] Specify the location of the initial ramdisk
+	initrd=		[BOOT,EARLY,INITRAMFS,KNL] Same as initrdmem=
 
-	initrdmem=	[KNL,EARLY] Specify a physical address and size from which to
-			load the initrd. If an initrd is compiled in or
+	initrdmem=	[BOOT,EARLY,INITRAMFS,KNL] Specify a physical address and size from which to
+			load initramfs. If initramfs is compiled in or
 			specified in the bootparams, it takes priority over this
 			setting.
 			Format: ss[KMG],nn[KMG]
@@ -2749,7 +2749,7 @@
 			between unregistering the boot console and initializing
 			the real console.
 
-	keepinitrd	[HW,ARM] See retain_initrd.
+	keepinitrd	[HW,ARM,INITRAMFS] See retain_initrd.
 
 	kernelcore=	[KNL,X86,PPC,EARLY]
 			Format: nn[KMGTPE] | nn% | "mirror"
@@ -6129,8 +6129,8 @@
 
 	rdinit=		[KNL]
 			Format: <full_path>
-			Run specified binary instead of /init from the ramdisk,
-			used for early userspace startup. See initrd.
+			Run specified binary instead of /init from initramfs,
+			used for early userspace startup.
 
 	rdrand=		[X86,EARLY]
 			force - Override the decision by the kernel to hide the
@@ -6324,7 +6324,7 @@
 			Useful for devices that are detected asynchronously
 			(e.g. USB and MMC devices).
 
-	retain_initrd	[RAM] Keep initrd memory after extraction. After boot, it will
+	retain_initrd	[INITRAMFS] Keep initramfs memory after extraction. After boot, it will
 			be accessible via /sys/firmware/initrd.
 
 	retbleed=	[X86] Control mitigation of RETBleed (Arbitrary
-- 
2.47.2


