Return-Path: <linux-ext4+bounces-9972-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1499AB55C2B
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Sep 2025 02:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8CDB5C4F0E
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Sep 2025 00:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D43814EC62;
	Sat, 13 Sep 2025 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ci0pMqa8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1630D14B953
	for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757725185; cv=none; b=i6nOzmEfJj3csysHAvlvAl+bRvPGvQeGaaf6LaBVkosF4hQn9/duWQOERP82i2Ahiwe+/XB53277s/LprHzOCbfIEtZBtQN5o7C5g3w/ITl85I0vgArQAoecmUVnQqKkMMtYUIKywT2hbvahOTdlhffU85KdXlTJnOvPe/SM2f0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757725185; c=relaxed/simple;
	bh=96PHKpKkduNWBMWlLUmXlhnRkmSl0kWQr4vXMbTyP8M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t9A7bwCCK9207h4IRO8sfo8X1bqepkldQcoAzM/ZXslTmMYbjs540HtZnzoNQbWc/FvgUpBFRmS9+cuhYyuzL9P1p4tmIBEwkLZ2eTMrlC8+zrQ/8GBkNbVZNr6OGlIqLCYx/X74pb0WZ5cMWGowVXdwkiah1ndX5cON3xR5ifw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ci0pMqa8; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b07e081d852so68051466b.2
        for <linux-ext4@vger.kernel.org>; Fri, 12 Sep 2025 17:59:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757725180; x=1758329980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6fWPoN959WwxjoYegCw0rDaXLTHmPmQJSliJ+OqkRJY=;
        b=ci0pMqa8PcrROKjXJdT069LT+w8CTpISWITlbfW/qtYcYwN/E9/DcLWNr/TpFiq3Ad
         QGOTKU53qwruWOiJs5/ZIzTaYZOVhAin6txhF3hPH2+OOlejQh98VgHulezohlcdDX2m
         cVt2AZhT8uGbv4Nec92z8dbeQO4pbNjpEB22pjBywRVyKIrHmXfsYMflIYY46yePUVU6
         zdaw3mLA+fJrXUrEodmWoWb+jz/WCuthgKwyfcLoSI4ydp/v7D+ibgsafGt0CUUX2ZqN
         rS12SoggmKIRUIi+KHUDdtLvHiabq8s8eQgov8mHArCKjQL5NIxrYkQXHjJscrZKeMwI
         odwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757725180; x=1758329980;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6fWPoN959WwxjoYegCw0rDaXLTHmPmQJSliJ+OqkRJY=;
        b=YAM5IriVVmEbnVPK8wxyl0nHS3hiMpMwx6OcY4Ppnq3e3vwFAurr9TQVKrIwxeuT88
         wbzDEYsETNgDZSll6AWzlrEZrsoRE5RZtZctwdgdaKJWbWVxK4KfwDBSgNuDLbf42WLf
         EI39MmNgMxsJzftv1wQV8Kd0Lg95bYn981hd37VfIiAokAMZWkoTWYLuV3Q8QBUgDea5
         RFAoaLZXbK8x4CZaL5p+mKmixRwz/1j49pLPcZqnaeLCb5EWxZ9GabXPz4pm7CwFs37u
         dD7xw+hy6n6ae96iDokN1mhHr0N95Vsvg9xZzYO8kgbFLK+dDxiqE0Y/I2GQVjmJ9H+p
         rwyA==
X-Forwarded-Encrypted: i=1; AJvYcCXtg920b/BKWtAMf6P/wPKskGQTc3PgipbSZe7R2JX55EbEmNZADB9+xYh8JNp5/fkueTxAwEBi03AK@vger.kernel.org
X-Gm-Message-State: AOJu0Yxt0knLs8QOfj1wI8as7j/kGAbFvTVSGqKnGmvQ4rOpqjQa52Rw
	1XBvd2qlBpfKXQpPZ1pnpKSB7My/OCuY/A3UFieOwR8RlmhIoGkSYU+r
X-Gm-Gg: ASbGncu/9WW9gHeW5moy0cxWroUfmHjiAv1sywO36uuACM9bf3BjJo73wxgFTTb8QKP
	hGj2mqIXkWsbdJEohEedB8Bz5XcvPHdrRq1n9TUpET/6SZz2V8whFBKVqRCSgXjp9CFXc/0lgqE
	990OzNudRTzei7Fqydbp0iq02izOaA/HlBWGqH2ytiIYmJIijNSd+XP7xitWTRA8HXZ1khPwyUJ
	YqfELekTI/xTYBHHMd0cSG8l+HgTUEqTnwhP6TgdfXvDBav3elcRptzc8xInTzdlFNa6nS5T9UU
	LidAQADtT5kti1hVfvfhLH6tVwQEhebmRkllKdy+T5RIpx5gUsb9MruPnq7k9RRnDF0EKFWZ2t4
	hW1PwXNqRyQlDueHGN54=
X-Google-Smtp-Source: AGHT+IGLvsatTRrbnodGqisgzpCsfnT+5kjCyZkQGsCYdRKthq/XXLBOPdic+fyhUVGMnj7YztyCUg==
X-Received: by 2002:a17:907:3f1a:b0:b04:ae7c:703e with SMTP id a640c23a62f3a-b07c35bca5fmr458205966b.24.1757725180390;
        Fri, 12 Sep 2025 17:59:40 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b07b3347a2dsm471368266b.98.2025.09.12.17.59.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Sep 2025 17:59:39 -0700 (PDT)
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
Subject: [PATCH RESEND 18/62] doc: modernize Documentation/driver-api/early-userspace/early_userspace_support.rst
Date: Sat, 13 Sep 2025 00:37:57 +0000
Message-ID: <20250913003842.41944-19-safinaskar@gmail.com>
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

Update it to reflect initrd removal

Signed-off-by: Askar Safin <safinaskar@gmail.com>
---
 .../early_userspace_support.rst                | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/Documentation/driver-api/early-userspace/early_userspace_support.rst b/Documentation/driver-api/early-userspace/early_userspace_support.rst
index 61bdeac1bae5..0ca923c1007b 100644
--- a/Documentation/driver-api/early-userspace/early_userspace_support.rst
+++ b/Documentation/driver-api/early-userspace/early_userspace_support.rst
@@ -127,28 +127,22 @@ mailing list at https://www.zytor.com/mailman/listinfo/klibc
 How does it work?
 =================
 
-The kernel has currently 3 ways to mount the root filesystem:
+The kernel has currently 2 ways to mount the root filesystem:
 
 a) all required device and filesystem drivers compiled into the kernel, no
-   initrd.  init/main.c:init() will call prepare_namespace() to mount the
+   initramfs.  init/main.c:kernel_init_freeable() will call prepare_namespace() to mount the
    final root filesystem, based on the root= option and optional init= to run
-   some other init binary than listed at the end of init/main.c:init().
+   some other init binary than listed at the end of init/main.c:kernel_init().
 
-b) some device and filesystem drivers built as modules and stored in an
-   initrd.  The initrd must contain a binary '/linuxrc' which is supposed to
-   load these driver modules.  It is also possible to mount the final root
-   filesystem via linuxrc and use the pivot_root syscall.  The initrd is
-   mounted and executed via prepare_namespace().
-
-c) using initramfs.  The call to prepare_namespace() must be skipped.
+b) using initramfs.  The call to prepare_namespace() must be skipped.
    This means that a binary must do all the work.  Said binary can be stored
    into initramfs either via modifying usr/gen_init_cpio.c or via the new
-   initrd format, an cpio archive.  It must be called "/init".  This binary
+   initramfs format, an cpio archive.  It must be called "/init".  This binary
    is responsible to do all the things prepare_namespace() would do.
 
    To maintain backwards compatibility, the /init binary will only run if it
    comes via an initramfs cpio archive.  If this is not the case,
-   init/main.c:init() will run prepare_namespace() to mount the final root
+   init/main.c:kernel_init_freeable() will run prepare_namespace() to mount the final root
    and exec one of the predefined init binaries.
 
 Bryan O'Sullivan <bos@serpentine.com>
-- 
2.47.2


