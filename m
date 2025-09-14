Return-Path: <linux-ext4+bounces-9997-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ADBAB564AE
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Sep 2025 05:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B18B81A2077A
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Sep 2025 03:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CE22266B56;
	Sun, 14 Sep 2025 03:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a1P8kBWK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC260267AF6
	for <linux-ext4@vger.kernel.org>; Sun, 14 Sep 2025 03:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757821838; cv=none; b=NkL17pV4gr9cmPGLu/PcG9O4JCPWKv/wxCs8UXC/2X0On4ZtAWtQv//Mg3SlFT1v8gREY9L6kP9XrQHDsAUyGPYjtTy3lH0XaS7q7VE8Aeepd3pY0UfujBL/xkZNKs7xyRmgiU2SbwFMxoT5ZXPgwSvEL8xtDkBRfL5pF2V6e+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757821838; c=relaxed/simple;
	bh=UKYo3sZQHTOBTzj/ZrSKU3L73PiTPpOmU1LUHeX039A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UgHqHrklACbl9+4px1LnqvaUJP1miVP7yKcaVYfBwwFFc2MVQL8F9gKec/Bdi9Yv76LS5CoHFwaj3vjwG4ct7+7XXMPS+HiLQFNKjUIS9QerSs964glxPu8QuKF7cRBzVcEyy62ixEIafA5/7Ej6pZZVRdt5n81OQL7x+X3nxF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a1P8kBWK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-628f29d68ecso6259924a12.3
        for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 20:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757821833; x=1758426633; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xULsRy9EzPzDuVUBFXoTlnqFZHMdg+FSwp5f1Vonn0Q=;
        b=a1P8kBWKhC/YGuTQ1qtgdu/eEmNliJm6xmjHlAYF/nZVCc+MkYl483G0Hq/aOPOuVQ
         co1t+z2BxO/DqCnrZV/EXoLvGXKtEHZqFdATOOJ7EzTdu3MgJ41k6O6rnPR886VF0J+g
         jgvNa+Ki1aT0KILtz2E0BMca3UYgzXBOakUCCFuFTU7ebx7Nd0hzzslIgv4hyWtZH0Us
         YbZQmnVSwIBoXEECRLCw5/S9dNhg9pi/sa5YxeFeAtv7H0GbAy2fZWrU6+0CkFOt7mcb
         RR3YbY8LMKAJx2sciiyJGNfQKUPjHVakvWWvmZVaCaVDH0xUngt3/RwvkIeU1VGaFSWY
         JGOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757821833; x=1758426633;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xULsRy9EzPzDuVUBFXoTlnqFZHMdg+FSwp5f1Vonn0Q=;
        b=m5AVpiNWgBfqH5uzYfySD499tfBJH/bn17n/VZFCqVMMiVPluZqcoyikdmA46lwN5f
         50PhOPN6JCNVk38IrZgb1sywnFeqIGdU6qThGjB0R2wHYN9zuz9+ui0G0wsrdVfhCeC0
         wdXdv37C0Z9AUyRovjsgnEBcIVuP/ipVSmNsK8PAY2wi2dW20Ri/fguBCCjRAJTx3Tq+
         FGt6bQW8TLAadNu2wV3SA4Z+1MyK4pTBqbl5gL04K21UMpDcdxYCNVzAXjIPBluuUJnk
         uOrex9nOKp+Tn4beTeKSb2KAhj+e7jasRJ1lyZshBX0AGBsp1ujJtQpH7by00b1rxcUU
         es9A==
X-Forwarded-Encrypted: i=1; AJvYcCUd0Rzxz8TYhYctOCI3kzSv7HpVyg45r2LTG0OKqdkY7yss4cQ+cl2KNJd5XYua22Vt2xfYP+JSa24h@vger.kernel.org
X-Gm-Message-State: AOJu0YwY6APKzIRmv7hRQii5In3Ek8FvjQlLDmYjMKI9VJhuLXBwBVtq
	0jpWUOI1lsFBL814kZDjx+AmajVQ6Rx5PZfQbLG2tyKXuXlDcx1m14Qk
X-Gm-Gg: ASbGncthAvx4jmR7N/e+vUAtLsWQ+QSVF1ktaK0oQA1LTvHo6VBwGQ15W/iUoUqZdiH
	/0dnp3eVrslPF8wMb5obAgrXvVoIYGCtUKe+FiUA4ZwZnXrxA5wDWQ4kWKWXFbm8j4FYfTxFQKD
	sj+Q9bsW3WO0IV27uKOphCKMsEO2GxNPDcL1VaEn+oG6o3d8lt3wk0LcPOYd4I/OI7/eom5o2xi
	IzG0cts1HbkGN2hB+UhDlNKvTUVeCHT8JEgv+mreFgyL6KlDx0MJVJSv858D+PSQR9T3DzlmPjV
	ZebgnIIsR2lC6WSWn4T06VejqVlb2vslA3gU54d7pTqqXrijVXup6/8AT/+8jYoMpDjwQlHkZMR
	H9XLlHP3e7thU6mxdFsG7VH9KyCZv6Q==
X-Google-Smtp-Source: AGHT+IHE3K7efxQ+hk8pVBE6YY31PD4G3LjwwPuEi1DqCDNI+Ud0foCSPIjpPnt40T661VaNMc1/Ow==
X-Received: by 2002:a17:907:3e8c:b0:b07:8836:dea9 with SMTP id a640c23a62f3a-b07c3819dc5mr855439466b.39.1757821832889;
        Sat, 13 Sep 2025 20:50:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b32dd3efsm668828766b.55.2025.09.13.20.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:50:32 -0700 (PDT)
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
Subject: [PATCH RESEND 38/62] init: remove most headers from init/do_mounts.h
Date: Sun, 14 Sep 2025 06:50:27 +0300
Message-ID: <20250914035027.3609569-1-safinaskar@gmail.com>
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

This is cleanup after initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 init/do_mounts.c |  2 ++
 init/do_mounts.h | 10 ----------
 2 files changed, 2 insertions(+), 10 deletions(-)

diff --git a/init/do_mounts.c b/init/do_mounts.c
index 7ec5ee5a5c19..5b55d0035e03 100644
--- a/init/do_mounts.c
+++ b/init/do_mounts.c
@@ -5,12 +5,14 @@
 #include <linux/fd.h>
 #include <linux/tty.h>
 #include <linux/suspend.h>
+#include <linux/blkdev.h>
 #include <linux/root_dev.h>
 #include <linux/security.h>
 #include <linux/delay.h>
 #include <linux/mount.h>
 #include <linux/device.h>
 #include <linux/init.h>
+#include <linux/init_syscalls.h>
 #include <linux/fs.h>
 #include <linux/initrd.h>
 #include <linux/async.h>
diff --git a/init/do_mounts.h b/init/do_mounts.h
index e225d594dd06..53e60add795a 100644
--- a/init/do_mounts.h
+++ b/init/do_mounts.h
@@ -1,14 +1,4 @@
 /* SPDX-License-Identifier: GPL-2.0 */
-#include <linux/kernel.h>
-#include <linux/blkdev.h>
-#include <linux/init.h>
-#include <linux/syscalls.h>
-#include <linux/unistd.h>
-#include <linux/slab.h>
-#include <linux/mount.h>
-#include <linux/major.h>
-#include <linux/root_dev.h>
-#include <linux/init_syscalls.h>
 #include <linux/task_work.h>
 #include <linux/file.h>
 
-- 
2.47.2


