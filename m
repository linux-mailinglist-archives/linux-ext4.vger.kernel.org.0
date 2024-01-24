Return-Path: <linux-ext4+bounces-908-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F8CB83B295
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jan 2024 20:53:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98AC8B25E2D
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jan 2024 19:53:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0F12132C36;
	Wed, 24 Jan 2024 19:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h87dfTpj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com [209.85.167.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0497C133402;
	Wed, 24 Jan 2024 19:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706126007; cv=none; b=oR+hePcR81pz33/xyJ8uYUkpSk1eXGyfrHJRpPkKjWBT3mFDJZvB7nBefoFX6Vb5agHArr+iYBqJaVBWmphRDOh/HUmIO+HBg0TAnL3+VaCnfPAVDMbO+t64OwtqC6N7zZ/ZZ1WhZfoKV0bh2zRSaLMXnrgGAJFigdGUoZ9qa8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706126007; c=relaxed/simple;
	bh=GZTZlWytgHqEBqq1p9miq+hYHxH8TGG1eFO0zcNEjP4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=WuocKDzlg6wYPkqY/6qusXv5uUzCDC0Mkq16CXJ61zW8UW3yNnpFjC9Nm72pqCvT4++LbvvAfSyVb9bWjh/WAccKwnT/8OTNWe49UgjdAXSgBzazw1hpjyVd1tbcC0Dz/Q8+heUPabKp7A2DLcbDv8J82FJ2u5J5qFPQstHw3ms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h87dfTpj; arc=none smtp.client-ip=209.85.167.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-3bdc1ac4463so1707124b6e.0;
        Wed, 24 Jan 2024 11:53:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706126004; x=1706730804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D1rzncq5w78gIVTF9WiuVYRQG2GweIoIZ07vhaxfqJ8=;
        b=h87dfTpjqMAepefvYlXVRXPG1dgc319Xrv9LV1H9c5vTTllUryU9ayUMjUcCBYejUM
         ENDkSMMQQkSoTtdFvyhRIWkHCDkz+R//4FFqkJnVYBSuWANLtWriyifQDQWwvGlm91CM
         89ctS9kD4sZU/WwEqyuZaUWOVamSE5S6J4DNEEro0abTY00bs1XdNJ6O5y6GU1i64+2C
         uKoi/sFhQ+doubI2r4SeoIJw2AmMHVuP0s++qqQ8o4Km/jjdHx2NLSDxpS+6ZOsJIZwd
         4pY8soZdj6i7QfRpbd6FT+A3Lmu5kUNMRguTqAy+tiX4GY7C3xvxm3Mj6nYrrgPeuUBq
         w9rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706126004; x=1706730804;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D1rzncq5w78gIVTF9WiuVYRQG2GweIoIZ07vhaxfqJ8=;
        b=mGaToy76HqJ0JnAiuYEFwRAYXE7OF0ir8VvB2nuoj0W2LoGs/zW0Z6KMoYKVg1kCdU
         uduI3zBySrIQS0ti/1o0zcwHjJsr/A4hm80R3iYf1NbtvgtaMkdeKuMMIO0ExOiv65IB
         rCH0UHITqFAEJ8rHd3uNl/r79dwkNpEZNi1FU86H+i0RuuvfVIaC8WqjouaJlOV43PR3
         4/xQFR7XnTZKbtBblZYkjjHXIi0uCJwHEEcn5ogFfYzjRHNXd4BGran050fOwR7VUCgM
         PFhEv8UCllOTLdwtoMZYuqxwqDr+Z9R5HqDnY5T5RcqffE3w69QRgS1jGs033AsK+0j+
         TGyg==
X-Gm-Message-State: AOJu0Yy4h6+x5vgXPSAZlNX8SGaemKB8C+wDNqI+hYHF5ajB8hnQCWr3
	L7o/hadNoXyEvu5fce5TDfoPIcyfeWBJggUD4DTE5VMqJYucPKcmgl19FJsK
X-Google-Smtp-Source: AGHT+IHncofXqnhY0XToOHD/ZXNYevu+0xNwrsyEd/tcex43bNRyAwwML/jzmnv7NUEhiscWhOpB6A==
X-Received: by 2002:a05:6808:2209:b0:3bb:b700:e2e6 with SMTP id bd9-20020a056808220900b003bbb700e2e6mr2196520oib.114.1706126004651;
        Wed, 24 Jan 2024 11:53:24 -0800 (PST)
Received: from localhost.localdomain (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id w20-20020a05620a095400b007831e92168bsm4344196qkw.124.2024.01.24.11.53.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 11:53:24 -0800 (PST)
From: Eric Whitney <enwlinux@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	Eric Whitney <enwlinux@gmail.com>
Subject: [PATCH] generic/459: don't run on non-journaled ext4 file systems
Date: Wed, 24 Jan 2024 14:53:06 -0500
Message-Id: <20240124195306.1177737-1-enwlinux@gmail.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

generic/459 fails when run on an ext4 file system created without a
journal or when its journal has not been loaded at mount time.

The test expects that a file system that it has been unable to freeze
will be automatically remounted read only.  However, the default error
handling policy for ext4 is to continue when possible after errors.

A workaround was added to the test in the past to force ext4 to
perform a read only remount in order to meet the test's expectations.
The touch command was used to create a new file after a freeze failure.
This forces ext4 to start a new journal transaction, where it discovers
the journal has previously aborted due to lack of space, and triggers
special case error handling that results in a read only remount.

The workaround requires a journal.  Since ext4 is behaving as designed,
prevent the test from running if there isn't one.

Signed-off-by: Eric Whitney <enwlinux@gmail.com>
---
 tests/generic/459 | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tests/generic/459 b/tests/generic/459
index c3f0b2b0..63fbbc9b 100755
--- a/tests/generic/459
+++ b/tests/generic/459
@@ -49,6 +49,11 @@ _require_command "$THIN_CHECK_PROG" thin_check
 _require_freeze
 _require_odirect
 
+# non-journaled ext4 won't remount read only after freeze failure
+if [ "$FSTYP" == "ext4" ]; then
+	_require_metadata_journaling
+fi
+
 vgname=vg_$seq
 lvname=lv_$seq
 poolname=pool_$seq
-- 
2.30.2


