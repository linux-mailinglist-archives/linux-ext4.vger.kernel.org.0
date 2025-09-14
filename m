Return-Path: <linux-ext4+bounces-10002-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D67BB56511
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Sep 2025 05:54:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2C2178796
	for <lists+linux-ext4@lfdr.de>; Sun, 14 Sep 2025 03:54:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8A2737E4;
	Sun, 14 Sep 2025 03:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lnfVFf76"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 645E0267AF2
	for <linux-ext4@vger.kernel.org>; Sun, 14 Sep 2025 03:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757822019; cv=none; b=YbZZVGQWI/uN/1nLGiykc2hJbYgEdYw/4U757FG8DWY15EfBFEm6/K1nanHRCfy1TpAb6jvYdGaUdVMEzvm/QIeOoV4RUsgKmo2r4kQeHgm6dgQFogf7etXM0gttUfp3QPySuwXP4IyBHYJdumr0Jk9me8BGeWfSYlUT/+whiS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757822019; c=relaxed/simple;
	bh=FZoweijhihxtu6HrPrxAC18gjv4DF8N0f7D122SferU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GoGDavImbI24Pav270Q4eDzOviehSwL1HGuBs5F+WNJQPOUVYLrrm67Wd6mXqngAeltaWnKLSCt8W0uEXhNBXvPpRjDwMopZ/Rzq0CqxgBmpDxvR/HqecOEHXep4gRq+Ao2S9dBdoYLxuu5kbqYQKVqrGdvivmJF9B7mq+KL4Dg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lnfVFf76; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62ef469bb2cso2847388a12.2
        for <linux-ext4@vger.kernel.org>; Sat, 13 Sep 2025 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757822013; x=1758426813; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=;
        b=lnfVFf762khiYz0FDgghMlXPGvOITxGCtk+wu9qrbN5hxLRAJ1gs2+ppk7BKe0HXlG
         G5OREfPjiRmY8EwPfB8G4xt1X/oakdJZUIVKAQidEaQcGSNKY/+M0I9BNsBTVp63txq9
         mWNSh2WPW1lcIW6EbcZonrtOLr+rPOcWu02CjDYUuTOSmFZo9hjdGaUQTIax5JlCS+NZ
         TNYxrphaJHRheaHZZPcAmZYwIMBqEB73xXkFvBqUDa4R/U5otIgxVvxeHp4zNeeaJNCP
         7lKrRo7Ge+7IBKugxANcXh/v7/I3r3NwkZPsvZtjWj9jftx6y6vKzysCIfWd+kJWivtX
         fbww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757822013; x=1758426813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PB2E9PPBAv72v29AyxICCzYyZlb0WEV+ovfXoPOatKs=;
        b=TOvVmsTBiY4dPuj7hPnWT/QR79vtXtmwvYAwJFXLgvRrwFPn/fyhlQfrvuAgaSK9en
         lUX0tXWcu/lA5PB5EkICvKRM78fZTfxnTOXWUhrsq8oLWhOdqCI3/a9kYYJMPzjF8we1
         1nlowmfWdQysVOQP515BhDE0JPZ3oTEbiX4b8i0TRi3/znGoH7nVIueOZvtNuPnkxMKW
         R/U+X6uNUoSAA+bR2DhMOlHFX/jbJZCg4msWei574kx3ktPwcM6Bh3KO2twJh2RvTqJJ
         yRlbTfdIFflDqUJf3NlcWExH2c/e8CeZ/jK1VXUWE2mkyZy2Fr2D2UpZhUyx1tGrkhlX
         dKpw==
X-Forwarded-Encrypted: i=1; AJvYcCXtXKcbQl+rDEJYBmFjMrK2BZOe9aCYMf6fn+gmqGOL/2FhlebpphrqzkBL+5JU8CaxMYtMfdcQdbKC@vger.kernel.org
X-Gm-Message-State: AOJu0YxwZ0Vjg9K3+3BwIqISX2IlEBzF9ej2CviG9fTM61fun73JaOJ6
	tSFKVIh9aS420qxt0ZOUdcr3YGmw2BWPQfsvZDdaun/fmg2NUFpPZvIl
X-Gm-Gg: ASbGnct2ccYjTzqjJgf3pkZV/iD/EiAngW88YoBNMMbELVp6KNeOt4Roz+YXiTEId2F
	Qm50KNZiA/LP0dIvmZXrC9FcshUPYz8hwZ2rMcOZWjdMtm+CeaZujrIr7I0N5ezRxMSowADwjlb
	/cr1+7mz9IDdD2GwPQFpAKh77P/GEA3Plsds4DaoL3dukXuGIYrdexyUR3zqKBW5ij9MxcSKV1j
	ONsQlRBe/egVgADBroQEz/AGr4dtkU2QwYd2l5Xjm/CN91SY5OqLSdRnq0KhYgWE6KL4Nvpcnc9
	WFmh1xp7+6lMuCh8DVhJ+2akZTMk4NWyaotTRXv6wltX3V/ViVv4JSoPTiNpcORkqaAmh7RxIa7
	Amam7ANgaqAVtx1yfpItM00t+3eB5VA==
X-Google-Smtp-Source: AGHT+IGUQXhZVcMzH5x4qrxgNQpCZ4sYyZ3ugDsvfNumu2I8pECs9df4oC+H+CMnm997jPnr5crTug==
X-Received: by 2002:a05:6402:2111:b0:61d:2096:1e92 with SMTP id 4fb4d7f45d1cf-62ed82614c4mr7020136a12.15.1757822012514;
        Sat, 13 Sep 2025 20:53:32 -0700 (PDT)
Received: from localhost ([212.73.77.104])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-62ec33f3a5esm6570485a12.30.2025.09.13.20.53.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Sep 2025 20:53:32 -0700 (PDT)
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
Subject: [PATCH RESEND 43/62] setsid: inline ksys_setsid into the only caller
Date: Sun, 14 Sep 2025 06:53:26 +0300
Message-ID: <20250914035326.3661003-1-safinaskar@gmail.com>
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
 include/linux/syscalls.h | 1 -
 kernel/sys.c             | 7 +------
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index 77f45e5d4413..75e9ee03d19b 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -1231,7 +1231,6 @@ int ksys_fchown(unsigned int fd, uid_t user, gid_t group);
 ssize_t ksys_read(unsigned int fd, char __user *buf, size_t count);
 void ksys_sync(void);
 int ksys_unshare(unsigned long unshare_flags);
-int ksys_setsid(void);
 int ksys_sync_file_range(int fd, loff_t offset, loff_t nbytes,
 			 unsigned int flags);
 ssize_t ksys_pread64(unsigned int fd, char __user *buf, size_t count,
diff --git a/kernel/sys.c b/kernel/sys.c
index 1e28b40053ce..66e1e2dfd585 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -1265,7 +1265,7 @@ static void set_special_pids(struct pid **pids, struct pid *pid)
 		change_pid(pids, curr, PIDTYPE_PGID, pid);
 }
 
-int ksys_setsid(void)
+SYSCALL_DEFINE0(setsid)
 {
 	struct task_struct *group_leader = current->group_leader;
 	struct pid *sid = task_pid(group_leader);
@@ -1300,11 +1300,6 @@ int ksys_setsid(void)
 	return err;
 }
 
-SYSCALL_DEFINE0(setsid)
-{
-	return ksys_setsid();
-}
-
 DECLARE_RWSEM(uts_sem);
 
 #ifdef COMPAT_UTS_MACHINE
-- 
2.47.2


