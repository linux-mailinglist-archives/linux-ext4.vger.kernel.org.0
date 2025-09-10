Return-Path: <linux-ext4+bounces-9901-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7626B51852
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 15:52:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2A654625AA
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Sep 2025 13:52:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB8851A5B84;
	Wed, 10 Sep 2025 13:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eq3myJcF"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA8D21ABAC
	for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 13:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757512324; cv=none; b=TDbCzXTb1rKWZoF6SPCsPIEETnR0kh+KQnO/HCvvd98l4yhcHO6VOwFhNm/iK3ZNxKwHZzJHhC9P1/E3z8h0OAVsowBUdkORCsmkh/A4Aq2IYEE+tQAMFYBi2HwTQalDY7G+Y5gxk/1SaF8++WWnFXlU4u8AkwytOeIZnd0ei5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757512324; c=relaxed/simple;
	bh=Kk6CWYvW0HLoQUwlerM9IosZtX6qzNl6ggmAtKJb1Qk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Oriu9PTDj0n2O1yROjKdhJAuDnqZxPgqf9ezBnt7YG6dnXyS4nd6QaiScUO5HUXgdStFyJCM12PV1aCWfPNqd+xwoNdc+lBHKGdzrnDHWTT2nVELaptV7m4lj6zym8XI6A7WHySjULkrauOoMtQgOd5gTiHEK/4xwXRxUdvUYrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eq3myJcF; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-807e414bf03so792197785a.0
        for <linux-ext4@vger.kernel.org>; Wed, 10 Sep 2025 06:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757512320; x=1758117120; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pHKdDXbALf8or6x5J233ponxlch4rXzghQSxluNBPeo=;
        b=eq3myJcF2bc1UFcJfyzk9nPZWZPfg+yjDfcS9hVMj6NWnKvwpZAXLdEWtd5RKZV8Ds
         k4cF0lGmlNqpNWBmN7uB1ZwP6pCtd9ppYCpEaLWrTEcB8X+R3Y3brr4Dl4rcei2dQ1pf
         op/BbnyBmOz8XeviIshMEhca3m6itWqH5FSvtDynPuNRl+Izmmm9gVtAiLihMvTXp0lQ
         DDIGxhuTs7Of6VHTU9EO9wUcynNh0+iXO/7xcjNN63ECiUG8gNGkS4b0DXb7kCaxjjVA
         F4V5mzdqiyhflUATuR0H3AulCskV+aUcAofzh0GPpVBXOvSst2ybvbJTB3i5VMOJwAvC
         44HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757512320; x=1758117120;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pHKdDXbALf8or6x5J233ponxlch4rXzghQSxluNBPeo=;
        b=KqftTE7Yxd/ujLxoNWgIrIUWeOd3YA7u5R2X9/pnCTjp+dwPQWf5aJdnelhS0dHhv2
         aN7cFPMASuWnIDyEsGFe+9rT2AHpZ9i/ZgrYqHbe3a0HGNVaEyXsO30B0yB8qeGoNVeo
         MJj1LEa2ZpX1iorhY/TigxRhjbvV+QReuuMARaXNo0j0iccMiXFioAxl8EsEbgfLqgrU
         T6rQueOToCSBlkQHP6AsRGuPZOXGnyRLgGop0OMGjd9CN0yWb7EHiFmKBrKyqU4X20fi
         THa7XBtGaKOWUfRsGUir0Fhua3aWCEiF21F//UTbpX5CLDUu1RQ9R7nuw9oIBBUxigUW
         s7OQ==
X-Gm-Message-State: AOJu0YxsSXF71gW6gl37Faz6xyzawHwYhZWebBAW6SFFImYLvHUSCx6D
	/KQPwX0TATQqPHdWGsgh2hzRh62/yjJLR0St6BRgKHP46O424wx2OOvt1/A0t5cJ6Vq5bKzdIWi
	+v2p1
X-Gm-Gg: ASbGncvqcxyKBik5gIw8G3X5tVjH0Kx//bMRP+QpazvbC8UZSZfDCNveruOoHLU6nFF
	fgt80W3umrEsG0Iunie787cy4oP0DvBIGkKBHg+Ut/RLyOs4m4SZz2r8EF5hrmlq0hPM3SnFDLU
	a3A/ZuF7N2QmnVDJ0o/l7xiJKodJsrTa+GrKuSQGnAJ26g8t7xhS6rN8x0/YfZSaUGrw5vxsLeE
	pAInqWrNN464DlMJYnDZBELipVwW+H2rt6E5Vc0aePyCXd1athEMtnmFzG0jh+JMmreRUTam8Uz
	q+rTi8jhJAvJlvXqRt0c78jZDRpccdrC/mmH0ViDwdevP68iA58lWpm3smGgzPEZNzdry5L4cFz
	yQtDy4rT6d7QThQivvBYEAsZFUuc4KTji2vBLeQ==
X-Google-Smtp-Source: AGHT+IETbWoklCqDFyPqLtFVvzRlTDIjCwOW/dfvHWJ7YrQri0Z+zgtwaysvUGfyIivN8ACFyDp+ag==
X-Received: by 2002:a05:6214:e66:b0:728:854:6c5d with SMTP id 6a1803df08f44-7393ec16860mr145174656d6.40.1757512320360;
        Wed, 10 Sep 2025 06:52:00 -0700 (PDT)
Received: from maple.netwinder.org ([184.147.192.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-7252d6ad05asm137500176d6.62.2025.09.10.06.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Sep 2025 06:51:59 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Wed, 10 Sep 2025 09:51:47 -0400
Subject: [PATCH v2 3/4] mke2fs: add root_selinux option for root inode
 label
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-mke2fs-small-fixes-v2-3-55c9842494e0@linaro.org>
References: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
In-Reply-To: <20250910-mke2fs-small-fixes-v2-0-55c9842494e0@linaro.org>
To: linux-ext4@vger.kernel.org
Cc: Ralph Siemsen <ralph.siemsen@linaro.org>
X-Mailer: b4 0.15-dev-56183

This option allows setting the SELinux security context (label) for the
root directory. A common value would be system_u:object_r:root_t
possibly with a level/range such as :s0 suffix (for MCS/MLS policy).

Signed-off-by: Ralph Siemsen <ralph.siemsen@linaro.org>
---
 misc/mke2fs.8.in              | 10 ++++++++
 misc/mke2fs.c                 | 46 ++++++++++++++++++++++++++++++++++
 tests/m_root_selinux/expect.1 | 57 +++++++++++++++++++++++++++++++++++++++++++
 tests/m_root_selinux/script   |  4 +++
 4 files changed, 117 insertions(+)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index 99ecc64b..ffe02eb0 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -428,6 +428,16 @@ Specify the root directory permissions in octal format. If no permissions
 are specified then the root directory permissions would be set in accordance with
 the default filesystem umask.
 .TP
+.BI root_selinux= label
+Specify the root directory SELinux security context as
+.IR label ,
+typically
+.nh
+.B system_u:object_r:root_t
+with an optional level/range suffix such as
+.B :s0
+for MCS/MLS policy types.
+.TP
 .BI stride= stride-size
 Configure the file system for a RAID array with
 .I stride-size
diff --git a/misc/mke2fs.c b/misc/mke2fs.c
index a54f83ad..6eca46a4 100644
--- a/misc/mke2fs.c
+++ b/misc/mke2fs.c
@@ -95,6 +95,7 @@ static int	num_backups = 2; /* number of backup bg's for sparse_super2 */
 static uid_t	root_uid;
 static mode_t 	root_perms = (mode_t)-1;
 static gid_t	root_gid;
+static char	*root_selinux = NULL;
 int	journal_size;
 int	journal_flags;
 int	journal_fc_size;
@@ -515,6 +516,35 @@ static void create_root_dir(ext2_filsys fs)
 			exit(1);
 		}
 	}
+
+	if (root_selinux) {
+		struct ext2_xattr_handle *handle;
+		retval = ext2fs_xattrs_open(fs, EXT2_ROOT_INO, &handle);
+		if (retval) {
+			com_err("ext2fs_xattrs_open", retval,
+				_("while setting root inode label"));
+			exit(1);
+		}
+		retval = ext2fs_xattrs_read(handle);
+		if (retval) {
+			com_err("ext2fs_xattrs_read", retval,
+				_("while setting root inode label"));
+			exit(1);
+		}
+		retval = ext2fs_xattr_set(handle, "security.selinux",
+					  root_selinux, strlen(root_selinux));
+		if (retval) {
+			com_err("ext2fs_xattr_set", retval,
+				_("while setting root inode label"));
+			exit(1);
+		}
+		retval = ext2fs_xattrs_close(&handle);
+		if (retval) {
+			com_err("ext2fs_xattrs_close", retval,
+				_("while setting root inode label"));
+			exit(1);
+		}
+	}
 }
 
 static void create_lost_and_found(ext2_filsys fs)
@@ -1089,6 +1119,21 @@ static void parse_extended_opts(struct ext2_super_block *param,
 			if (arg) {
 				root_perms = strtoul(arg, &p, 8);
 			}
+		} else if (!strcmp(token, "root_selinux")) {
+			if (arg) {
+				root_selinux = realloc(root_selinux,
+						       strlen(arg) + 1);
+				if (!root_selinux) {
+					com_err(program_name, ENOMEM, "%s",
+						_("in malloc for root_selinux"));
+					exit(1);
+				}
+				strcpy(root_selinux, arg);
+			} else {
+				r_usage++;
+				badopt = token;
+				continue;
+			}
 		} else if (!strcmp(token, "discard")) {
 			discard = 1;
 		} else if (!strcmp(token, "nodiscard")) {
@@ -1174,6 +1219,7 @@ static void parse_extended_opts(struct ext2_super_block *param,
 			"\tlazy_journal_init=<0 to disable, 1 to enable>\n"
 			"\troot_owner=<uid of root dir>:<gid of root dir>\n"
 			"\troot_perms=<octal root directory permissions>\n"
+			"\troot_selinux=<selinux root directory label>\n"
 			"\ttest_fs\n"
 			"\tdiscard\n"
 			"\tnodiscard\n"
diff --git a/tests/m_root_selinux/expect.1 b/tests/m_root_selinux/expect.1
new file mode 100644
index 00000000..19a3d6ee
--- /dev/null
+++ b/tests/m_root_selinux/expect.1
@@ -0,0 +1,57 @@
+Creating filesystem with 1024 1k blocks and 128 inodes
+
+Allocating group tables:    done                            
+Writing inode tables:    done                            
+Writing superblocks and filesystem accounting information:    done
+
+Filesystem features: ext_attr resize_inode dir_index filetype sparse_super
+Pass 1: Checking inodes, blocks, and sizes
+Pass 2: Checking directory structure
+Pass 3: Checking directory connectivity
+Pass 4: Checking reference counts
+Pass 5: Checking group summary information
+test_filesys: 11/128 files (0.0% non-contiguous), 54/1024 blocks
+Exit status is 0
+Filesystem volume name:   <none>
+Last mounted on:          <not available>
+Filesystem magic number:  0xEF53
+Filesystem revision #:    1 (dynamic)
+Filesystem features:      ext_attr resize_inode dir_index filetype sparse_super
+Default mount options:    (none)
+Filesystem state:         clean
+Errors behavior:          Continue
+Filesystem OS type:       Linux
+Inode count:              128
+Block count:              1024
+Reserved block count:     51
+Overhead clusters:        40
+Free blocks:              970
+Free inodes:              117
+First block:              1
+Block size:               1024
+Fragment size:            1024
+Reserved GDT blocks:      3
+Blocks per group:         8192
+Fragments per group:      8192
+Inodes per group:         128
+Inode blocks per group:   32
+Mount count:              0
+Check interval:           15552000 (6 months)
+Reserved blocks uid:      0
+Reserved blocks gid:      0
+First inode:              11
+Inode size:               256
+Required extra isize:     32
+Desired extra isize:      32
+Default directory hash:   half_md4
+
+
+Group 0: (Blocks 1-1023)
+  Primary superblock at 1, Group descriptors at 2-2
+  Reserved GDT blocks at 3-5
+  Block bitmap at 6 (+5)
+  Inode bitmap at 7 (+6)
+  Inode table at 8-39 (+7)
+  970 free blocks, 117 free inodes, 2 directories
+  Free blocks: 54-1023
+  Free inodes: 12-128
diff --git a/tests/m_root_selinux/script b/tests/m_root_selinux/script
new file mode 100644
index 00000000..4ac82918
--- /dev/null
+++ b/tests/m_root_selinux/script
@@ -0,0 +1,4 @@
+DESCRIPTION="root directory SELinux security context"
+FS_SIZE=1024
+MKE2FS_OPTS="-E root_selinux=system_u:object_r:root_t"
+. $cmd_dir/run_mke2fs

-- 
2.45.2.121.gc2b3f2b3cd


