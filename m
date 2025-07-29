Return-Path: <linux-ext4+bounces-9212-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C042B145C2
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 03:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2EA29540E7D
	for <lists+linux-ext4@lfdr.de>; Tue, 29 Jul 2025 01:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD0511F239B;
	Tue, 29 Jul 2025 01:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ei/y7HXS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47EA1428E7;
	Tue, 29 Jul 2025 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753752738; cv=none; b=Qookg93Qvj9jEWMgD1IKt6tVG68/7HVluGBOdkPaHzzlv8fwOr3M+laVC0dswTH0Qt3enNC12wsYM9+kM18gsFuN+YikveiU/WEk3ErCRqxEjvVELZljO8M1nCr6PJcezY4CL+lyW/Q9m08U8RI+fiZIk0KSChkbGBFw0HyMhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753752738; c=relaxed/simple;
	bh=vIa3tGqyPkXcn4ICh16DMsWYrC2pjZzhbU+o6wZNUQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jDH/kNnNPgRtThjKpnsrTsWgcV5qXAlXdn5SZPdbIgU0eqAbS2Mxdv+kzYzxkkw2Y6etBCwMtIMHY1Z6weW7w4PoB+fZKDU31uwiCoPeY4A/ZBQyzwhPp7B55L05TW/ploiLF6Nr8aP2cKblnZ231xK+yZdJPwYacHc3PVA6y9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ei/y7HXS; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7600271f3e9so492193b3a.0;
        Mon, 28 Jul 2025 18:32:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753752736; x=1754357536; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MraiPYf2+FbTMmayxJzfGpBb+bg366e5GcMnwSJ/XSQ=;
        b=ei/y7HXS1hD8RwkMcT3ZFX3/qhdnl0ygSrtY6v/2Hvqz0TVJIySpJNM64205dDrYRX
         HyzZ7U07yVKnRKavhfUEmyyiqSCeGB4UgPnsHOLA3YDZzahGF3fzS6t8gPik1sgkaKL5
         to2W3DNz4u+E981E2cPdYWzUnv0kDYDkg/3vTzs+kUJ5xhmpD/ngREu745u0T0cEMmLB
         +Uc2D9Ev1ScijGlDH+IsWrQiWBYPXDdp3aVjhTiS4fEfK0aGmEZI8slkhxM0+n0Ny5r0
         8eJLTh8W9yL9fHjPo0LG2IMlI2SgOAHYMaGWfjXSQWWCOjq3+LlKgvOwC+DBJRTErnYT
         7rNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753752736; x=1754357536;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MraiPYf2+FbTMmayxJzfGpBb+bg366e5GcMnwSJ/XSQ=;
        b=L/tAy7UFTkFnUinQVw4A6WjMucD0WEqwf8d+6HFf5kJX5nsRi3AkG0Y1tCczc80qP0
         wJCsKi+rYxqXNZ0eVL75Px+mFlDyHz08X61ZG6JXUjxlJ3l5KyBXuOwiNvbpFTnbJxGY
         Z/ZDs/PoZb/blQ11sQxrwvr3e0cTccsvZ8OKKO5ETrk2+4SwX8ZDr8TfE0DaBvOH90lq
         v4e/55QDantsXafbTwKkVnTvcQGk85dJd6Z/RmmTXKTHjj4PmWw3yZcCLTik1vowjwW9
         qDT5h8rvqlSl7anVWM5WpEtFcJWIMY6CZcZlTn3TILorYB/NNidC+uzTrKpGpLb/7nw4
         YW/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUTR/O1GvYLEwiNjLT+jzouTCYftUxsBcqULBroqlXUIO5hX+WD5f0Un1BLNqWZnhUtFsBbpkn9a3NVwQ==@vger.kernel.org, AJvYcCXNjtDn4RCnqFCkHhvidSAmah0OenI37IbnEVdjaAxFCLIiObSNAQk7XKa02j3t/Z80bWTJCQ5IZDA=@vger.kernel.org, AJvYcCXnRF1u2psz8yqs4Xz1dvzSfI+W8fH4wZhttwQdWgyFu1sSbgvJfLmm4ULyLZUQ7RQV5KVVFVUr5af1down@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5WziisxS5JwKw8c3RSxZBXhkqubx+jKqoiyITzJszJCscnKE0
	fYYh6ViHaz0TzEu/uYSf6oLuFIVRkxt0Qny+fantmW2jqROnB+UAaQxkN16ADhCZd0Y=
X-Gm-Gg: ASbGnctA7NhNO5gwl7iUlZC0IqBQkptbItiHXdQf7C5JnQCchwZxA4eUZxc+bGfs0B7
	10abDFwxrpIcsm9C0sWUJPMMEPMRHyw/x3jW8b236bzaGtP2/L7rAmK2TXgmMjzbIm7uKg8jPld
	eDpUJYCyON/tFWLfzNfjWC6Sza71muIaB5X3RTR1q0oL0Y4Nq5Bratu2W0+yMkqejcJQMAKLj7L
	+dnX0pMgm5EFc8WWFdu7EsrAali1thnmxz/WjMDFrLd6NQlki72ujdXLYEOVxRHYyF+CULuvc2C
	dlpDz644y5fVWdT0CXW69upvUXHEQF9tlNFNCE42GIizWhWx7sjME3UoJrK1sbJOL5UaJgEro4h
	eMEjciwBv6pGEvcNO2c+vbz4BrdmF2RhErwhWFfo+8Xv4pA==
X-Google-Smtp-Source: AGHT+IHWto+iJ+vUCURLqJpNabBDdIsDCieG85fhrW1rK0u12Wa78eQmvHVH9vy7EXSUvyDmNGNAVQ==
X-Received: by 2002:a05:6a00:1144:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-76967971ed6mr2073049b3a.10.1753752736008;
        Mon, 28 Jul 2025 18:32:16 -0700 (PDT)
Received: from alkaleus ([168.0.235.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7640ad06762sm6593299b3a.80.2025.07.28.18.32.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Jul 2025 18:32:15 -0700 (PDT)
From: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	corbet@lwn.net,
	linux-ext4@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	skhan@linuxfoundation.org
Subject: [PATCH] Fixed commit: Fixes Sphinx warnings about duplicate reference labels in Documentation/filesystems/ext4/atomic_writes.rst.
Date: Mon, 28 Jul 2025 22:32:00 -0300
Message-ID: <20250729013200.84919-1-andreluizrodriguescastro@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Specifically, the label '.. _atomic_write_bdev_support:' was renamed to
'.. _atomic_write_bdev_support_section:' to ensure label uniqueness
within the document.

Signed-off-by: Andre Luiz da Nobrega <andreluizrodriguescastro@gmail.com>
---
 Documentation/filesystems/ext4/atomic_writes.rst |  2 +-
 warn_output.txt                                  | 12 ++++++++++++
 2 files changed, 13 insertions(+), 1 deletion(-)
 create mode 100644 warn_output.txt

diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
index 80f83112d24d..e8cf983049b4 100644
--- a/Documentation/filesystems/ext4/atomic_writes.rst
+++ b/Documentation/filesystems/ext4/atomic_writes.rst
@@ -204,7 +204,7 @@ writes are supported.
 .. _atomic_write_bdev_support_section:
 
 Hardware Support
-----------------
+-----------------
 
 The underlying storage device must support atomic write operations.
 Modern NVMe and SCSI devices often provide this capability.
diff --git a/warn_output.txt b/warn_output.txt
new file mode 100644
index 000000000000..593c6fa5b65d
--- /dev/null
+++ b/warn_output.txt
@@ -0,0 +1,12 @@
+Using alabaster theme
+[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/filesystems/ext4/atomic_writes.rst:5: WARNING: duplicate label atomic_writes, other instance in /home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/filesystems/ext4/atomic_writes.rst[39;49;00m
+[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/filesystems/ext4/atomic_writes.rst:207: WARNING: duplicate label atomic_write_bdev_support, other instance in /home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/filesystems/ext4/atomic_writes.rst[39;49;00m
+[91mWARNING: ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1068 struct member 'mcm' not described in 'mpc_funcs'[39;49;00m
+[91mWARNING: ./drivers/gpu/drm/amd/display/dc/inc/hw/mpc.h:1068 struct member 'rmcm' not described in 'mpc_funcs'[39;49;00m
+[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/gpu/drm-kms:360: ./drivers/gpu/drm/drm_fourcc.c:362: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:35.
+Declaration is '.. c:function:: const struct drm_format_info * drm_format_info (u32 format)'.[39;49;00m
+[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/gpu/drm-kms:476: ./drivers/gpu/drm/drm_modeset_lock.c:375: WARNING: Duplicate C declaration, also defined at gpu/drm-kms:49.
+Declaration is '.. c:function:: int drm_modeset_lock (struct drm_modeset_lock *lock, struct drm_modeset_acquire_ctx *ctx)'.[39;49;00m
+[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/gpu/drm-uapi:557: ./drivers/gpu/drm/drm_ioctl.c:915: WARNING: Duplicate C declaration, also defined at gpu/drm-uapi:70.
+Declaration is '.. c:function:: bool drm_ioctl_flags (unsigned int nr, unsigned int *flags)'.[39;49;00m
+[91m/home/alkaleus/Documentos/PESSOAL/LFX_dev/linus_tree/Documentation/arch/powerpc/htm.rst: WARNING: document isn't included in any toctree[39;49;00m
-- 
2.50.1


