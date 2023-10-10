Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED71C7C0443
	for <lists+linux-ext4@lfdr.de>; Tue, 10 Oct 2023 21:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjJJTQp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 10 Oct 2023 15:16:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjJJTQo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 10 Oct 2023 15:16:44 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C372B93
        for <linux-ext4@vger.kernel.org>; Tue, 10 Oct 2023 12:16:42 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2776ca9adb7so3796961a91.1
        for <linux-ext4@vger.kernel.org>; Tue, 10 Oct 2023 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696965402; x=1697570202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WNENytKr+VSqa3ak/S6FPuXuPKG7QYWc/tEULvde6og=;
        b=c4AxfVZcw2Wz015TvH7VHfBYz2B3nb31L8ilHuMK4ueRMxxZQ8m/787TeQaj0FM9yo
         qrbIDDav9xqK3BhgUQm98dDBGGaqtmk5QdDWf9kOky732M9bY0VRUEFLdOAXfGnFoe4W
         vzMCwJ4WpjUuzv6/l03Dk8DT49ckSOl1B8k/oSA+sxkk53xEu9B5eM+qpRyJv3O2cFXK
         g47z4LP+mlR2mWjichyg46HCMEyvVXzWKrALucQazqDMkbkKvVoAcwNzjHFAK5sIzAf3
         bR5ATbfpyWcgFgW0a7jnlJSq+NddhoRd6cXMCNXpXyU48UiIL3ahqrMRhpE7e+VJexwB
         Shvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696965402; x=1697570202;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WNENytKr+VSqa3ak/S6FPuXuPKG7QYWc/tEULvde6og=;
        b=bpqcahonkvhXB4cUxKaNWDzRGibcpYgHPUL0z14dKUx8k89+YUQs7IIHnpDfmGqTQ7
         DVlPFlgMhkAuihPQ1qSI5tidXrPemq8VekpN4M0zLnI0RaNJQAvj3uvVcZMaeOthXrFX
         asoUDDij1MAz98CJlvREO35Z6Y4dc3mt1S4FfNboP8DM75iAY/D3MiCPk25KLl/EVOWO
         1nLNyh/ziSx92wnsxTdZYsxU81+V0HygJr7mIkjxDeFJtP+VQZhpL0WbCTPtHAFWnWHf
         +fGqbx9n+W72pmpIyEGWAADAUohOy6sgAzDnyD0zVYRw5cjv/O3n8xcVOdMqdp5ITUYV
         8ybA==
X-Gm-Message-State: AOJu0YwBDpJjmBAhnYx8x5YM20kv9eFPSo/BJOe5Yye6i128L9uLN1H4
        w/s2vcXH58qh7ujhXpJEbI0=
X-Google-Smtp-Source: AGHT+IE6+LpkkoTUBGvubKYXrW6xiNodCvJGat6zOV2zuwqgAkKctHkFBadAAmt+JKokF1m7cTCzHQ==
X-Received: by 2002:a17:90b:3a8e:b0:274:2906:656a with SMTP id om14-20020a17090b3a8e00b002742906656amr17133195pjb.5.1696965402172;
        Tue, 10 Oct 2023 12:16:42 -0700 (PDT)
Received: from dw-tp.ihost.com ([2401:4900:1cc4:c403:d76d:9a77:e4fd:36be])
        by smtp.gmail.com with ESMTPSA id l19-20020a17090b079300b002791491f811sm10373001pjz.8.2023.10.10.12.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Oct 2023 12:16:41 -0700 (PDT)
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, Ojaswin Mujoo <ojaswin@linux.ibm.com>,
        "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
Subject: [PATCH 2/2] kvm-xfstests: Add support for ppc64
Date:   Wed, 11 Oct 2023 00:46:31 +0530
Message-ID: <eb1f8f0fb0ff9a6358129a2a45bd0c88421ac669.1696965271.git.ritesh.list@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <060d9fef332979fd5d53b1c28c13b2043a16ab25.1696965271.git.ritesh.list@gmail.com>
References: <060d9fef332979fd5d53b1c28c13b2043a16ab25.1696965271.git.ritesh.list@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

These changes adds support for powerpc ppc64le to kvm-xfstests including
building rootfs image.
(Note: this requires latest qemu i.e. "qemu-system-ppc64 -machine help"
should atleast support pseries-8.1)

Here are the cmds which have been tested.

1. ~/src/tools/xfstests-bld/kernel-build/install-kconfig --arch ppc64le
2. ~/src/tools/xfstests-bld/kernel-build/kbuild --arch ppc64le
3. ~/src/tools/xfstests-bld/run-fstests/kvm-xfstests --arch ppc64le \
	-N -o "fstesttyp=ext4" -n 4 -r 4096M -c 64k generic/001 -v
4. ./kvm-xfstests -N --kernel ~/src/linux/out-qemu/vmlinux --kernel-arch=ppc64le \
            -o "fstesttyp=ext4" -n 4 -r 4096M -c 64k generic/001 -v
5. ./setup-buildchroot --arch=ppc64el && ./build-appliance --chroot=bookworm-ppc64el
6. On a linux build repo, we can directly use
   ~/src/tools/xfstests-bld/run-fstests/kvm-xfstests -c 4k,64k generic/001
7. On x86 it will default to tcg mode instead of kvm.

<log>
-------------------- Summary report
KERNEL:    kernel 6.6.0-rc1-next-20230913-xfstests-dirty #1 SMP Sat Oct  7 13:35:24 IST 2023 ppc64le
CMDLINE:   -c 4k,64k generic/001
CPUS:      2
MEM:       1982.81

ext4/4k: 1 tests, 3 seconds
  generic/001  Pass     3s
ext4/64k: 1 tests, 5 seconds
  generic/001  Pass     4s
Totals: 2 tests, 0 skipped, 0 failures, 0 errors, 7s

Co-developed-by: Ojaswin Mujoo <ojaswin@linux.ibm.com>
Signed-off-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 kernel-build/install-kconfig               |  3 ++
 kernel-build/kbuild                        |  9 ++++++
 kernel-build/kernel-configs/ppc64le-config |  9 ++++++
 run-fstests/kvm-xfstests                   | 35 +++++++++++++++++-----
 run-fstests/util/arch-funcs                | 19 ++++++++++++
 run-fstests/util/parse_cli                 |  5 ++++
 run-fstests/util/parse_opt_funcs           |  3 ++
 7 files changed, 76 insertions(+), 7 deletions(-)
 create mode 100644 kernel-build/kernel-configs/ppc64le-config

diff --git a/kernel-build/install-kconfig b/kernel-build/install-kconfig
index f5b2b8e..a79e0e6 100755
--- a/kernel-build/install-kconfig
+++ b/kernel-build/install-kconfig
@@ -31,6 +31,9 @@ do
 	--arm64)
 	    ARCH=arm64
 	    ;;
+	--ppc64le)
+	    ARCH=ppc64le
+	    ;;
 	--arch)
 	    shift
 	    ARCH=$1
diff --git a/kernel-build/kbuild b/kernel-build/kbuild
index 28b81b4..3d5ccaa 100755
--- a/kernel-build/kbuild
+++ b/kernel-build/kbuild
@@ -52,6 +52,9 @@ do
 	--arm64)
 	    ARCH=arm64
 	    ;;
+	--ppc64le)
+	    ARCH=ppc64le
+	    ;;
 	--dpkg)
 	    DO_DPKG=yes
 	    DPKG_EXPLICIT=yes
@@ -104,6 +107,12 @@ case "$ARCH" in
 	    BLD_DIR=$BLD_DIR_X86_64
 	fi
 	;;
+	ppc64le)
+	if test -n "$BLD_DIR_PPC64LE" ; then
+	    BLD_DIR=$BLD_DIR_PPC64LE
+	fi
+	;;
+
     *)
 	echo "unknown architecture: $KERN_ARCH"
 	exit 1
diff --git a/kernel-build/kernel-configs/ppc64le-config b/kernel-build/kernel-configs/ppc64le-config
new file mode 100644
index 0000000..e748d0d
--- /dev/null
+++ b/kernel-build/kernel-configs/ppc64le-config
@@ -0,0 +1,9 @@
+CONFIG_PPC64=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_PAPR_SCM=y
+CONFIG_KVM_BOOK3S_64=y
+CONFIG_KVM_BOOK3S_64_HV=y
+CONFIG_HVC_CONSOLE=y
+CONFIG_HVC_RTAS=y
+CONFIG_HVCS=y
+CONFIG_VIRTIO_CONSOLE=y
diff --git a/run-fstests/kvm-xfstests b/run-fstests/kvm-xfstests
index 2df74c1..f23c9be 100755
--- a/run-fstests/kvm-xfstests
+++ b/run-fstests/kvm-xfstests
@@ -52,16 +52,29 @@ QUIET="quiet loglevel=0"
 
 DOWNLOAD_BASE_URL="https://mirrors.kernel.org/pub/linux/kernel/people/tytso/kvm-xfstests"
 if test -z "$EXPLICIT_ROOT_FS" ; then
-    ROOT_FS="$(dirname $DIR)/test-appliance/root_fs.img.$ARCH"
+    if [ "$ARCH" == "ppc64le" ]
+    then
+        # root_fs follows debian naming convention ie ppc64le -> ppc64el
+        ROOT_FS="$(dirname $DIR)/test-appliance/root_fs.img.ppc64el"
+    else
+        ROOT_FS="$(dirname $DIR)/test-appliance/root_fs.img.$ARCH"
+    fi
+
     if ! test -f "$ROOT_FS" ; then
-	ROOT_FS="$(dirname $DIR)/test-appliance/root_fs.img"
+        ROOT_FS="$(dirname $DIR)/test-appliance/root_fs.img"
     fi
     if ! test -f "$ROOT_FS" ; then
-	f=root_fs.img.$ARCH
-	ROOT_FS="$(dirname $DIR)/test-appliance/$f"
-	echo "Downloading $f..."
-	wget -nv --show-progress -O "$ROOT_FS.new" "$DOWNLOAD_BASE_URL/$f"
-	mv "$ROOT_FS.new" "$ROOT_FS"
+        if [ "$ARCH" == "ppc64le" ]
+        then
+            # root_fs follows debian naming convention ie ppc64le -> ppc64el
+            f=root_fs.img.ppc64el
+        else
+            f=root_fs.img.$ARCH
+        fi
+        ROOT_FS="$(dirname $DIR)/test-appliance/$f"
+        echo "Downloading $f..."
+        wget -nv --show-progress -O "$ROOT_FS.new" "$DOWNLOAD_BASE_URL/$f"
+        mv "$ROOT_FS.new" "$ROOT_FS"
     fi
 fi
 
@@ -206,6 +219,14 @@ case "$ARCH" in
 	MACHINE_TYPE=virt
 	CPU_TYPE=max
 	;;
+    ppc64le)
+	QEMU_ARCH=ppc64
+	ACCEL=kvm:tcg
+	CONSOLE_DEV=hvc0
+	MACHINE_TYPE=pseries,cap-ail-mode-3=off
+	CPU_TYPE=max
+	GDB=""
+	;;
     *)
 	echo "Unsupported architecture: $ARCH"
 	exit 1;
diff --git a/run-fstests/util/arch-funcs b/run-fstests/util/arch-funcs
index 3933867..bc7cf47 100644
--- a/run-fstests/util/arch-funcs
+++ b/run-fstests/util/arch-funcs
@@ -21,6 +21,7 @@ function set_my_arch () {
 	aarch64)   MY_ARCH=arm64  ;;
 	i386|i686) MY_ARCH=i386   ;;
 	x86_64)    MY_ARCH=amd64  ;;
+	ppc64le)   MY_ARCH=ppc64le ;;
 	*)         MY_ARCH=$arch  ;;
     esac
 }
@@ -60,6 +61,12 @@ function set_canonicalized_arch () {
 	    GCE_ARCH="X86_64"
 	    KERN_ARCH="x86_64"
 	    ;;
+	# setup_buildchroot uses ppc64el
+	ppc64el|ppc64le)
+	    ARCH="ppc64le"
+	    GCE_ARCH="ppc64le"
+	    KERN_ARCH="powerpc"
+	    ;;
 	*)
 	    echo "Architecture $ARCH not supported"
 	    exit 1
@@ -76,6 +83,11 @@ function set_cross_compile ()
 		CROSS_COMPILE=aarch64-linux-gnu-
 	    fi
 	    ;;
+	ppc64le)
+	    if test "$MY_ARCH" != ppc64le ; then
+		CROSS_COMPILE=powerpc64le-linux-gnu-
+	    fi
+	    ;;
     esac
 }
 
@@ -133,6 +145,13 @@ function get_kernel_file_info () {
 		KERNEL_VERSION=$(dpkg -I "$KERNEL" | grep "^ Version: " | \
 			  awk '{print $2}')
 		;;
+	    *"PowerPC"*)
+		KERNEL_ARCH=ppc64le
+		d=$(dirname $(dirname $(dirname $(dirname "$KERNEL"))))
+		if test -f "$d/.git_version" ; then
+		    KERNEL_VERSION=$(cat "$d/.git_version")
+		fi
+		;;
 	    *)
 		echo "get-kernel-arch $i is not a kernel" >&2
 		echo "$info"
diff --git a/run-fstests/util/parse_cli b/run-fstests/util/parse_cli
index c7e133f..9dc574b 100644
--- a/run-fstests/util/parse_cli
+++ b/run-fstests/util/parse_cli
@@ -422,6 +422,11 @@ while (( $# >= 1 )); do
 	    ARCH="$1"
 	    EXPLICIT_ARCH=yes
 	    ;;
+	--ppc64le)
+	    supported_flavors kvm
+	    ARCH="ppc64le"
+	    EXPLICIT_ARCH=yes
+	    ;;
 	--arm64)
 	    supported_flavors kvm gce
 	    ARCH="arm64"
diff --git a/run-fstests/util/parse_opt_funcs b/run-fstests/util/parse_opt_funcs
index 5457760..83df45a 100644
--- a/run-fstests/util/parse_opt_funcs
+++ b/run-fstests/util/parse_opt_funcs
@@ -25,6 +25,9 @@ find_kernel_to_use()
 	arm64)
 	    kernel_in_build=arch/arm64/boot/Image
 	    ;;
+	ppc64le)
+	    kernel_in_build=arch/powerpc/boot/zImage
+	    ;;
 	*)
 	    echo "Unknown architecture in find_kernel_to_use: $ARCH"
 	    exit 1
-- 
2.41.0

