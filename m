Return-Path: <linux-ext4+bounces-7162-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FD2A81DD5
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 09:04:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F5F2174D28
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 07:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4646922D7A6;
	Wed,  9 Apr 2025 07:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2cJ8SYQ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865BD189B84;
	Wed,  9 Apr 2025 07:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182210; cv=none; b=AOMJTG3QzWHRHdxGFAeZxUfD+w0GoW5tTfAjwH/W6xVv27jIi9J47P1GYJnv2rPCsVdT/p8zPu2yfuzinxTOkQOIvxSrXO+Rj3DanNfV/Xy0/G1qR0snHS3Enxt5+z8KxTMaXD32dUZ2O64t/UqadVze6HvJ7XBVSB+48nt0Ze4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182210; c=relaxed/simple;
	bh=PEFNGDRyoUSte/wX7CbDGUX9e/cHYk99nv0iQANa3j4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gLGbCHcYTxkSBrqfEzEZaKwTxM12vRy3tV1LYIM4lwZFStXRPBZ/pGtDnGtEKmELq5z6jnRBiAEHExLbDisweb1qScF8DXJNyNzaUxUGAvFuOsla4LT+bDU9g3Dfi8kwUvRHYRjhjlb9KwPUmSuhzaZYkNCcJ7hr7BiKLK54C/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X2cJ8SYQ; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-227c7e57da2so55426575ad.0;
        Wed, 09 Apr 2025 00:03:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744182208; x=1744787008; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w78xk+DSSt8CVqCx85N0h8QcSdb55AR1/Y/x/+6etdo=;
        b=X2cJ8SYQLxkc/jQt4N70VptOsDyYksQWiGZZWnvoXwIDVhKCxZMCmfjVYHaSVL8HPh
         S7fDOLqP/wESFIVvm3uitGV6KT+I04Wlisw7DbZ+DcqD9l3HKt8f/nUdqcDNd9rrekJk
         nN77UWwnIIxTCsc+P968oujM4eunvflt9+y2mHk8EF/zbpyng0MlXhDOTkIRiiwElLfG
         gLAc5zDKavHh54c7RPKaN5EX4xZ+Fp9dPGgGJXX14d7ey0TC+Ji1A9INIL2edGEm08uS
         UvIu79N81+9/dPmk/rP8nVGArlS3ErsmWaTKJuVBKzAOvJn9v10GOv3VxEaItiZhoeYT
         DH/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182208; x=1744787008;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w78xk+DSSt8CVqCx85N0h8QcSdb55AR1/Y/x/+6etdo=;
        b=woNgntCrpuY4Fp3CUjVVSfs3efIS1DLlnEdRgOZGMSGI9ShXKVzq8AypSdH3rIxLrQ
         jXRkjLMb2MsfSIcRlAXdEhbjvlTdes1ZT1ipbIiwqHl5DY4EQgo7zOFgdZNzPLmmHFzy
         PDtPhhdZriA/gYdwvfN1t1EEfm57Xjo3Prd6llEMKixVm8LII/tKz/GWt585gNwfUVoa
         GfVpOuUjGXjPx1r71cVvIz6C/e0z1ozwDhiRTup/oVNoJPTKjwApkGANtB536ZbWPLDs
         NHk1YnXkXkpe9l1YYlN4UDpsiewlli32UN1IuLRwqqjjyAE4BG7q0ht7+/ItTLSXY291
         uswA==
X-Forwarded-Encrypted: i=1; AJvYcCUbCCzaJ8Xju7gSWaQMbub8QdpE8VetNyjTif5dFKrLCqHoJrDonQJDl31+9t9ahDwcfXpmVd+3b8A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJW6MYqJ0KYTRzm4orMXXct8gQJrPx5cCHoC34B1FrYkCkO/MX
	zi2o6Wjhim95XM7VdgNl8tczaRE1KKx5ZqFn/UDxb4uU8a/inlHTmM/0eAaB
X-Gm-Gg: ASbGncviidBxjIAVNivN/+LnV1CSDeQYiHDAOMA6MExh1GK+e0Hpkf/EYRDC51/nzmP
	5GkdmMVhUjP7DGeDa99jsUm4T+ldVvnGIE9J+YKS4mbypqzzAEniiD+V+ZlsWR+oDPGuxEAshBB
	5NQ3BMKAJ8MAgpMbUMVbqUd1q95O2ynNNLleqQZa/jt3+E9tmd5GAvcExDZgqgYZn8RHWuezI4X
	MllK1aHjoYIb+DjyFNFyffDOPy2aLibshZm2J2OBCkCALT8tGTMGBFM2UChiYvycKtAVFsK3l+g
	jrXPmeLGDOjVAkZSoFjzAhYkejEMKcMwklrJA2o89TYq
X-Google-Smtp-Source: AGHT+IHoSX3LYrjEBYmlAumOPRxyb5UlHlO9GYfAekeMlxseZntJF1CmcQsbueeFHmhGqhcO6tQgnQ==
X-Received: by 2002:a17:902:c941:b0:224:10b9:357a with SMTP id d9443c01a7336-22ac3fefd85mr20432485ad.32.1744182207659;
        Wed, 09 Apr 2025 00:03:27 -0700 (PDT)
Received: from citest-1.. ([122.164.80.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c939a3sm4491985ad.117.2025.04.09.00.03.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:03:27 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v4 5/6] common/config: Introduce _exit wrapper around exit command
Date: Wed,  9 Apr 2025 07:00:51 +0000
Message-Id: <b7f56773095bea46c2b6d56c3d87197d900d9e2d.1744181682.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
References: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should always set the value of status correctly when we are exiting.
Else, "$?" might not give us the correct value.
If we see the following trap
handler registration in the check script:

if $OPTIONS_HAVE_SECTIONS; then
     trap "_kill_seq; _summary; exit \$status" 0 1 2 3 15
else
     trap "_kill_seq; _wrapup; exit \$status" 0 1 2 3 15
fi

So, "exit 1" will exit the check script without setting the correct
return value. I ran with the following local.config file:

[xfs_4k_valid]
FSTYP=xfs
TEST_DEV=/dev/loop0
TEST_DIR=/mnt1/test
SCRATCH_DEV=/dev/loop1
SCRATCH_MNT=/mnt1/scratch

[xfs_4k_invalid]
FSTYP=xfs
TEST_DEV=/dev/loop0
TEST_DIR=/mnt1/invalid_dir
SCRATCH_DEV=/dev/loop1
SCRATCH_MNT=/mnt1/scratch

This caused the init_rc() to catch the case of invalid _test_mount
options. Although the check script correctly failed during the execution
of the "xfs_4k_invalid" section, the return value was 0, i.e "echo $?"
returned 0. This is because init_rc exits with "exit 1" without
correctly setting the value of "status". IMO, the correct behavior
should have been that "$?" should have been non-zero.

The next patch will replace exit with _exit.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
---
 common/config | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/common/config b/common/config
index 79bec87f..7dd78dbe 100644
--- a/common/config
+++ b/common/config
@@ -96,6 +96,15 @@ export LOCAL_CONFIGURE_OPTIONS=${LOCAL_CONFIGURE_OPTIONS:=--enable-readline=yes}
 
 export RECREATE_TEST_DEV=${RECREATE_TEST_DEV:=false}
 
+# This functions sets the exit code to status and then exits. Don't use
+# exit directly, as it might not set the value of "$status" correctly, which is
+# used as an exit code in the trap handler routine set up by the check script.
+_exit()
+{
+	test -n "$1" && status="$1"
+	exit "$status"
+}
+
 # Handle mkfs.$fstyp which does (or does not) require -f to overwrite
 set_mkfs_prog_path_with_opts()
 {
-- 
2.34.1


