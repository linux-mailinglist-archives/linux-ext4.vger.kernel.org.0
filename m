Return-Path: <linux-ext4+bounces-1554-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A390C873537
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Mar 2024 12:00:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3074A1F23FB8
	for <lists+linux-ext4@lfdr.de>; Wed,  6 Mar 2024 11:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D189663102;
	Wed,  6 Mar 2024 10:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="biMJIoh/"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A7604D5
	for <linux-ext4@vger.kernel.org>; Wed,  6 Mar 2024 10:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709722755; cv=none; b=hsEf6LTmk5rZ9MSXlklmxKp/OdlxSBURQKust7zaJ4RroQjAhEK2YhSslhcy81jfUv8JhnVfBtvZ4onGn5JrCCsIjIbJJ6d3RcgZizwweXbAHh1ScmPi3mLkcEO4eIu7NnTItFfreXkCwNLN8oxdOL881/80r+sWKd/uCUmUSZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709722755; c=relaxed/simple;
	bh=zaXvKaorrrCyipP+9H3KeoIuEMKMNGtAb136852yvMs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=INnm5tFKzIkYWaXIb9gqNBrQQ+trTjIxtBz364C2yavHrDOpdXsu6CqwZz/DP/dbCNvqdwziuAO1lg1eGIQBjHbJ36a+nct86CSAMJ5xG96+RHz39xG2F4EXAKp9PGjipBVNFEMkIThBRdrYIoLNUiFMTgctlU8uW6JQfMkLU5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=biMJIoh/; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-6e4e8be9c85so1097049a34.3
        for <linux-ext4@vger.kernel.org>; Wed, 06 Mar 2024 02:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709722752; x=1710327552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k7WDrH9ecfdKhKPXS0pZAyDS0/o1hY/uAjYt83vHTV4=;
        b=biMJIoh/0KMKjE2u5/sOK4WX6D5CoheRPmEGbqqaoIHoamrsbk4RRVzpmAI+fMO2si
         L9NUUkMYuOVBrRnd4B42Quj83GeKLUq99oppKNJNSTK8McZT7YuNET0zlJ6tDfXdWH4m
         S/Bde5vUPcxv65DFXie4sQTfgW/zjD2uERd7f7KxB5UlIV7DtEmeKwtWHV+ocgzVuDGr
         3IWzS8QxIX7KBejb9QJXqAFueKaWYqczOHA3MQNulb6FvD5C4k0HyaLBjzIL8//dS8H/
         omnaNytvf0gyH+L8yF4/Eu1T4V3wb3bRgMhA5TGl+wtV/b475M0+Om5B1qr1juXGT6Pq
         Xegw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709722752; x=1710327552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k7WDrH9ecfdKhKPXS0pZAyDS0/o1hY/uAjYt83vHTV4=;
        b=PGe75IeXWZTv2ufOuI6hQRBEN3Z9vmxQwK+SHOPN/3Z1Foqe1Oq0spmrWaGcP66jrE
         wdjyv1l7WS3IdVFMM6swcps6UCfPOyNcKf/Xq2lIWZYK6xCM8gFo6r1/wm8lT5rzDUCK
         3Y+j2jYXihCbOtomcHm+JKGmaXF9lnjlXep6kZQBXD+0xeQZT70nlhvOiUo4wMh6ebRy
         HKFJXcXg6p3clhQTh4O9Bg3x1Q92QFCC05QVUmYfZp2SSrfOCsqPJPkvZX+qP7Hlu8Hb
         xwFhj9VRREqw8AVo95UzHsrpcgotlaJpfwJYG5y8ygGhswPM6IINJNr6gGskGCPiUNCH
         6rtg==
X-Gm-Message-State: AOJu0YwiXH9MEu0LYAV5q4eumL9xbiBbxyN2lSLpGjDhr+tVoZi/baVm
	NjeKiM6BHtOELI4zrkYb4iAByILMNyiVmmAI/XuRkDjpAWJgYe6gYpBdAMeuGtY=
X-Google-Smtp-Source: AGHT+IGfmf4HM3hXxRItimR1SlkoKFqx1vqXbUyzjo+5fiiwooUcfRpjAYMTyB8WRE6fZh8V9Rk7tQ==
X-Received: by 2002:a05:6830:1d62:b0:6e4:8d2d:64e5 with SMTP id l2-20020a0568301d6200b006e48d2d64e5mr4373718oti.13.1709722751761;
        Wed, 06 Mar 2024 02:59:11 -0800 (PST)
Received: from dw-tp.. ([49.205.218.89])
        by smtp.gmail.com with ESMTPSA id r31-20020a63fc5f000000b005dc3fc53f19sm10514431pgk.7.2024.03.06.02.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:59:11 -0800 (PST)
From: "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To: linux-ext4@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Theodore Ts'o <tytso@mit.edu>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH] kvm-xfstests: Add 1k config for ext2
Date: Wed,  6 Mar 2024 16:29:05 +0530
Message-ID: <c5dea04b0e955402258835f2c880ceaf3b1f0ab5.1709721921.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This adds 1k config option in test-appliance for ext2.
This will come in handy for testing bs < ps path for ext2
for e.g. it's useful in testing iomap bufferd-io work going 
on for ext2.

Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 test-appliance/files/root/fs/ext2/cfg/1k      |  4 ++++
 .../files/root/fs/ext2/cfg/1k.exclude         | 19 +++++++++++++++++++
 .../files/root/fs/ext2/cfg/all.list           |  1 +
 test-appliance/files/root/fs/ext2/config      |  6 ++++--
 4 files changed, 28 insertions(+), 2 deletions(-)
 create mode 100644 test-appliance/files/root/fs/ext2/cfg/1k
 create mode 100644 test-appliance/files/root/fs/ext2/cfg/1k.exclude

diff --git a/test-appliance/files/root/fs/ext2/cfg/1k b/test-appliance/files/root/fs/ext2/cfg/1k
new file mode 100644
index 0000000..d669104
--- /dev/null
+++ b/test-appliance/files/root/fs/ext2/cfg/1k
@@ -0,0 +1,4 @@
+SIZE=small
+export EXT_MKFS_OPTIONS="-b 1024"
+export EXT_MOUNT_OPTIONS=""
+TESTNAME="Ext2 1k block"
diff --git a/test-appliance/files/root/fs/ext2/cfg/1k.exclude b/test-appliance/files/root/fs/ext2/cfg/1k.exclude
new file mode 100644
index 0000000..215dd2c
--- /dev/null
+++ b/test-appliance/files/root/fs/ext2/cfg/1k.exclude
@@ -0,0 +1,19 @@
+// exclude file for ext2/1k copied from ext4/1k
+
+// The test fails due to too many block group descriptors when the
+// block size is 1k
+ext4/033
+
+// This test tries to create 65536 directories, and with 1k blocks,
+// and long names, we run out of htree depth
+ext4/045
+
+// This test creates too many inodes on when the block size is 1k
+// without using special mkfs.ext4 options to change the inode size.
+// This test is a bit bogus anyway, and uses a bunch of magic calculations
+// where it's not clear what it was originally trying to test in the
+// first place.  So let's just skip it for now.
+generic/273
+
+// This test creates too many extended attributes to fit in a 1k block
+generic/454
diff --git a/test-appliance/files/root/fs/ext2/cfg/all.list b/test-appliance/files/root/fs/ext2/cfg/all.list
index 4ad96d5..2d0e07f 100644
--- a/test-appliance/files/root/fs/ext2/cfg/all.list
+++ b/test-appliance/files/root/fs/ext2/cfg/all.list
@@ -1 +1,2 @@
 default
+1k
diff --git a/test-appliance/files/root/fs/ext2/config b/test-appliance/files/root/fs/ext2/config
index e2ad484..a2a333c 100644
--- a/test-appliance/files/root/fs/ext2/config
+++ b/test-appliance/files/root/fs/ext2/config
@@ -28,6 +28,7 @@ function format_filesystem()
 
 function setup_mount_opts()
 {
+    export MKFS_OPTIONS="-q $EXT_MKFS_OPTIONS"
     if test -n "$MNTOPTS" ; then
 	if test -n "$EXT_MOUNT_OPTIONS" ; then
             export EXT_MOUNT_OPTIONS="$EXT_MOUNT_OPTIONS,$MNTOPTS"
@@ -39,12 +40,12 @@ function setup_mount_opts()
 
 function get_mkfs_opts()
 {
-    echo "$MKFS_OPTIONS"
+    echo "$EXT_MKFS_OPTIONS"
 }
 
 function show_mkfs_opts()
 {
-    echo MKFS_OPTIONS: "$MKFS_OPTIONS"
+    echo EXT_MKFS_OPTIONS: "$EXT_MKFS_OPTIONS"
 }
 
 function show_mount_opts()
@@ -60,5 +61,6 @@ function test_name_alias()
 function reset_vars()
 {
     unset EXT_MOUNT_OPTIONS
+    unset EXT_MKFS_OPTIONS
     unset MKFS_OPTIONS
 }
-- 
2.39.2


