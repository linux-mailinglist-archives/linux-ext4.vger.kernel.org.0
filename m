Return-Path: <linux-ext4+bounces-9980-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9B7AB55CCB
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Sep 2025 03:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26E1F1CC4EE0
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Sep 2025 01:09:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECF4219F12A;
	Sat, 13 Sep 2025 01:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aN1KTiCS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0ABA17C203
	for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 01:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725710; cv=none; b=jua6m7mGT65WzD85oNS5nHNbBl4Y38eiNCIRhPORuGO6CAHmdzr0nNzpOHXrOjnpFPcAFvmYiJf12+TXyZzCRCKvRPTAKZZI4fFyDWkROb48ZbmDpIJ/qPhR3Iad2rrAcB1mGIBBOF+rjUUo02HcUGmthQBQIViB4MWcwFHJ40E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725710; c=relaxed/simple;
	bh=gH7Rddwu9MUu/+t3B7A94tjqEJhL770gz/5Md0mQZOk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jq6YvFuhELq29hIy/Hp4srosi1Ia3sjkLUy4tJ+ysx8ZhhxpyQP/jJIcBDlcs9E+oxMaz0Tof3sUHUFL47CLIOWH2t0xUvBqK/yMbTaEXCqxHxH0dW/20Z/gmea9nmS8NvPi0s2Ia5hTwdZmeCUtrll+gI/NFy25Chg1NsEU6mk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aN1KTiCS; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6188b5ad4f0so3992572a12.0
        for <linux-ext4@vger.kernel.org>; Fri, 12 Sep 2025 18:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725706; x=1758330506; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=076xoEVbaVUh2WXJ09mT2DE1QkI5WvxeMmJOzlrP1Zs=;
        b=aN1KTiCSwNPhtSh+4uLVVS63QBvN1SQIF/X+JI6JOkxphBHQx6cZlucBweKr0dd0aN
         TyaIVk7Wj1K4VbPS2H1rxAtLy39JfuTVaf8ZjwqRG3ylPlDNWaL8Rk8F3bDrnhZ7xQ9e
         zWgd+E9p49vul5ymwY8zacDsBH+TLU0baB9Emkeu29h5FMnkiJxkorjM2Rx/2vd3Wutp
         N9bjlEMsBJ83lkS8d/LH2Pnq6MagRHvRD+W+JloMVC4Fp4g8J5IWzZtPVJoAMLtnuXwv
         zaoOA/2BrTy+aWoOHpYqAtaMEkFqAJBBJyuc53gZ0vBFnbXXf6VzmFsbv1wjwLn3amUT
         doXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725706; x=1758330506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=076xoEVbaVUh2WXJ09mT2DE1QkI5WvxeMmJOzlrP1Zs=;
        b=F28/4O3uV40WqC44YVUq9hN8Eh9ng8DBXHSvKau3C4aCW9M+139vkXV6BRTINxwJGA
         /lkGS7O1XrCqlDNKi4i61p5oqJBG9rx/nywWDzmycTT0H5+86sKJn7Nar4x+G+w3pDDC
         JAuqSfh9Lfi1rcHg4ZwWsWQJkV7PIZjc9ltA7kZy19p5GI/ydSbD22oYJI9JZVgvldiq
         QzsTXGLOxQkfPX6dRwqeaiinTbFKf1HxQGEQl8ENirkt77B0sogXuaC7a7AvvZuRrUnY
         P3QFcMu6hpOnrckwweREhmm28zDGmFckdxuIxujxpEKIiT6ulmGVEbUof6f3wR1hZnAw
         /xjw==
X-Forwarded-Encrypted: i=1; AJvYcCWt8+QsFA0u1k4kRmPPbAK8w5z4q5Cu360jAIslcefHYhHRyE/sOZbUuZ1ngvxyHWiTn3ru/6Lejzl+@vger.kernel.org
X-Gm-Message-State: AOJu0YwW9EGUuHun5W/CVPsuVPUe0UdP/mhFTX5RY2wJBuhnREvBohYj
	Ix/tKgt1ThIZjpFZbZmuium0V6AdjmLBhma5BPbcSjU3JWSQnd0uBFyA
X-Gm-Gg: ASbGncufafWBV3n9cl7Cu9ZfdhhLoDL5Rg6UK151kjFWFcpi7yTvEaUhncyH+ZLh3l0
	FQpDajlRS2bBkjjymJjgSV0ny4Qz4FIHgsad6DC1exKyUL6Q0VZ4K5tJjgNkco1OSddhTF7uRIK
	/KvKhvwvsibO2w4jCRj3DvjZvS34siPX0mXF2nzti7oOUtuImb5+6HhUXugk7zSVgOjSNvLEJEr
	KSkO5HgfuCeOrCvSYdLPhb4iYSWLHdPoPWg9nPEw0Qq29/5JAYY6VVO/Y2Zz2IKiZIpELRkIjSA
	wQAiIgMJtQVPhhybyjFst0tx2eYT8zm8IQrUPspvUDKrLLyTMh9rBVMBEdGimTTxeq0BtdhsNzf
	L3V7Q8ceAKiUF5ZzsE/qrMqGQdea/1w==
X-Google-Smtp-Source: AGHT+IGdk3XVuMADNouJH/aBQO3dgisawWr0ra1gK5dmtwng/BJ+8DUWD+mdbhpnTmhbFrSAIQbncg==
X-Received: by 2002:a05:6402:26d0:b0:62e:e5b3:6388 with SMTP id 4fb4d7f45d1cf-62ee5b367b9mr3462166a12.19.1757725706048;
        Fri, 12 Sep 2025 18:08:26 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62eff1a5c6esm720024a12.50.2025.09.12.18.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 18:08:24 -0700 (PDT)
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
Subject: [PATCH RESEND 26/62] init: move phys_external_initramfs_{start,size} to init/initramfs.c
Date: Sat, 13 Sep 2025 00:38:05 +0000
Message-ID: <20250913003842.41944-27-safinaskar@gmail.com>
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

Move definitions of phys_external_initramfs_start and
phys_external_initramfs_size to init/initramfs.c

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts_initrd.c | 3 ---
 init/initramfs.c        | 3 +++
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/init/do_mounts_initrd.c b/init/do_mounts_initrd.c
index 444182a76999..06be76aa602c 100644
--- a/init/do_mounts_initrd.c
+++ b/init/do_mounts_initrd.c
@@ -15,9 +15,6 @@
 unsigned long initrd_start, initrd_end;
 int initrd_below_start_ok;
 
-phys_addr_t phys_external_initramfs_start __initdata;
-unsigned long phys_external_initramfs_size __initdata;
-
 static int __init early_initrdmem(char *p)
 {
 	phys_addr_t start;
diff --git a/init/initramfs.c b/init/initramfs.c
index 6abe0a3ca4ce..5242d851e839 100644
--- a/init/initramfs.c
+++ b/init/initramfs.c
@@ -600,6 +600,9 @@ __setup("initramfs_async=", initramfs_async_setup);
 #include <linux/initrd.h>
 #include <linux/kexec.h>
 
+phys_addr_t phys_external_initramfs_start __initdata;
+unsigned long phys_external_initramfs_size __initdata;
+
 static BIN_ATTR(initrd, 0440, sysfs_bin_attr_simple_read, NULL, 0);
 
 void __init reserve_initrd_mem(void)
-- 
2.47.2


