Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9561E449D88
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Nov 2021 22:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239658AbhKHVHU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Nov 2021 16:07:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34262 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230126AbhKHVHU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Nov 2021 16:07:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636405474;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aYCFyFW9sdFWI2EkRbnbLa05ml1VgWPmoPJPgkHDto4=;
        b=DKVG2Sb5H18fj/jo3yLLsKUlXe3Fd3ujVlohQ4xJyt2qByKe4Y7Mnu0XTANotbueOhJ0ee
        YVEdqwOhW8XYP7AXvzJ2WJaRMgV0D75DVkMsLWm24/Vuar3rehOEGsWA2D0Oh+tN23s0gx
        sqljMmXVFjWV1HfyDX3paHE/VDY9NP8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-455-XqGgtz6bMROTS6nB-ddOkw-1; Mon, 08 Nov 2021 16:04:30 -0500
X-MC-Unique: XqGgtz6bMROTS6nB-ddOkw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7F750875047;
        Mon,  8 Nov 2021 21:04:29 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 457E160C5D;
        Mon,  8 Nov 2021 21:04:28 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, guan@eryu.me, djwong@kernel.org
Subject: [PATCH v2 1/2] common/rc: add _require_kernel_config and _has_kernel_config
Date:   Mon,  8 Nov 2021 22:04:23 +0100
Message-Id: <20211108210423.28980-1-lczerner@redhat.com>
In-Reply-To: <20211108151916.27845-1-lczerner@redhat.com>
References: <20211108151916.27845-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add _require_kernel_config() and _has_kernel_config() helpers to check
whether a specific kernel configuration is enabled on the kernel.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
v2: Document KCONFIG_PATH in README

 README        |  2 ++
 common/config |  1 +
 common/rc     | 29 +++++++++++++++++++++++++++++
 3 files changed, 32 insertions(+)

diff --git a/README b/README
index 63f0641a..e9284b22 100644
--- a/README
+++ b/README
@@ -129,6 +129,8 @@ Preparing system for tests:
                xfs_check to check the filesystem.  As of August 2021,
                xfs_repair finds all filesystem corruptions found by xfs_check,
                and more, which means that xfs_check is no longer run by default.
+	     - Set KCONFIG_PATH to specify your preferred location of kernel
+	       config file.
 
         - or add a case to the switch in common/config assigning
           these variables based on the hostname of your test
diff --git a/common/config b/common/config
index 164381b7..e0a5c5df 100644
--- a/common/config
+++ b/common/config
@@ -226,6 +226,7 @@ export OPENSSL_PROG="$(type -P openssl)"
 export ACCTON_PROG="$(type -P accton)"
 export E2IMAGE_PROG="$(type -P e2image)"
 export BLKZONE_PROG="$(type -P blkzone)"
+export GZIP_PROG="$(type -P gzip)"
 
 # use 'udevadm settle' or 'udevsettle' to wait for lv to be settled.
 # newer systems have udevadm command but older systems like RHEL5 don't.
diff --git a/common/rc b/common/rc
index 0d261184..84154868 100644
--- a/common/rc
+++ b/common/rc
@@ -4703,6 +4703,35 @@ _require_names_are_bytes() {
         esac
 }
 
+_has_kernel_config()
+{
+	option=$1
+	uname=$(uname -r)
+	config_list="$KCONFIG_PATH
+		     /proc/config.gz
+		     /lib/modules/$uname/build/.config
+		     /boot/config-$uname
+		     /lib/kernel/config-$uname"
+
+	for config in $config_list; do
+		[ ! -f $config ] && continue
+		[ $config = "/proc/config.gz" ] && break
+		grep -qE "^${option}=[my]" $config
+		return
+	done
+
+	[ ! -f $config ] && _notrun "Could not locate kernel config file"
+
+	# We can only get here with /proc/config.gz
+	_require_command "$GZIP_PROG" gzip
+	$GZIP_PROG -cd $config | grep -qE "^${option}=[my]"
+}
+
+_require_kernel_config()
+{
+	_has_kernel_config $1 || _notrun "Installed kernel not built with $1"
+}
+
 init_rc
 
 ################################################################################
-- 
2.31.1

