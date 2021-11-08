Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E870F44980B
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Nov 2021 16:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238681AbhKHPWK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Nov 2021 10:22:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36510 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238613AbhKHPWJ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Nov 2021 10:22:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1636384764;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=VBQwVfthRqhBVsV02+PGFr06WW3g76O0Ft6JuXFnCiw=;
        b=KfVefynoPOQ1REWyLotHjee4v0SuEes4b1T7S9QcR7KhcVsVTrLRkG19PSjRXTvdeazBtW
        mOEKToGqDs+GDx8sfeIAIR+jGttnZ1Lwpi4lH/Qzb8l7q3sxCV99x/OF7AXebnwBzZZ/uV
        ieLRft560PrBItwJ9QJ5e2c1jATQiCg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-560-4WGVZO6eNTS_TXQ_uvjWIw-1; Mon, 08 Nov 2021 10:19:22 -0500
X-MC-Unique: 4WGVZO6eNTS_TXQ_uvjWIw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C602280A5CA;
        Mon,  8 Nov 2021 15:19:21 +0000 (UTC)
Received: from localhost.localdomain (unknown [10.40.194.220])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 622A55C3E0;
        Mon,  8 Nov 2021 15:19:20 +0000 (UTC)
From:   Lukas Czerner <lczerner@redhat.com>
To:     fstests@vger.kernel.org
Cc:     linux-ext4@vger.kernel.org, tytso@mit.edu, guan@eryu.me
Subject: [PATCH 1/2] common/rc: add _require_kernel_config and _has_kernel_config
Date:   Mon,  8 Nov 2021 16:19:15 +0100
Message-Id: <20211108151916.27845-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Add _require_kernel_config() and _has_kernel_config() helpers to check
whether a specific kernel configuration is enabled on the kernel.

Signed-off-by: Lukas Czerner <lczerner@redhat.com>
---
 common/config |  1 +
 common/rc     | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+)

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

