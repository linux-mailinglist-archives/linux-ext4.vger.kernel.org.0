Return-Path: <linux-ext4+bounces-9883-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 08086B501B4
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 17:43:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E45121884DBE
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Sep 2025 15:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6100F265614;
	Tue,  9 Sep 2025 15:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gxn6hljN"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432F436124
	for <linux-ext4@vger.kernel.org>; Tue,  9 Sep 2025 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757432477; cv=none; b=H7U3/Zp51pfVIETmCrkG93d2yBO68PRguv3l7HCskmZvwDK187/Sp0nrWXgM+0uW9UZspSpYcq1XLILotJAr84xEVsuHV/vyvOD3S2ihJeyu3XYP54PxRLMfpXOugAjgSEUZhJwZaA8CIIx00gwcY1dUncFF3iG7Jwfspb7CJDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757432477; c=relaxed/simple;
	bh=HpYsAhEAapsv67Aen1W3oZJ0QiRDDNXxAj6+1Kgv0mE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t5Ilb16XtSngdXNqXS4un9n9p2a6JHCHnlHRfm9GG6Kyns63BKjy58eM4wfz7lomiLfNYUukISub+BgElSzusTo8NxQPE6Y3058EnmlZ7Wgz+rVg6W6DcArgFiUznTV3Syye4nc+nuTcckTLqh5z/rhKdZY+9cgN3O6kDtzIfJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Gxn6hljN; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-810e642c0bbso482126985a.3
        for <linux-ext4@vger.kernel.org>; Tue, 09 Sep 2025 08:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757432474; x=1758037274; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0LpLqJYCLps2VK/5QD/9RunVfHdRy5OXKBONyZKKlSU=;
        b=Gxn6hljNRt8JGSCtkZuEQ86lxL7N/6RzFuSsI2iX84UkRd9gQQjo/xl14yWxCAy+3I
         b9MUMNp0boFxnFGiTbCeFFdroQm9KtQFTP5IL+WTgKun+iGcyvR5X7NTlUdj/9DROPwn
         cEeJ4EwSjlrF/0KpvU7JJnvXB9SpEUGdYVj097wth1Pjs2q6MEn1dWHuap5LJpIUUCW2
         iq2rfxNrqrgWrDtHjU+LDctbSjxOQbnIpTYAqLZ9nNDw+o1TeeLjDkLUCEaFghjdkXwW
         c6nznED9LunXW81WkoE3WCLLYJ8bd12dHFgG5JKBOVpBwaDIFXMrBxGK3lmOmTiXUxQ/
         sP5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757432474; x=1758037274;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0LpLqJYCLps2VK/5QD/9RunVfHdRy5OXKBONyZKKlSU=;
        b=wzPYdAobKn4wIh3lS4WFxBToK2Bg7AO12QRydcVzVQZ7M6ygikxh0Z4vMHZwh+MMZX
         m7NYPwXNcfBxA5kEtY/8zvQqUrKjkEdXRmx06p/ZFu9Z8YgxQURwvs6g3h7ehrLP59Pa
         AXTVwrUIhuZDj4P8cJSMfp4kVodb2gMB1HH3aDzaM/aC/TDg8qZEX8WI9VL9+oOu1mcC
         6oU/wp7IYtlhA7TnLXXWtkorA01RTXKnMQFSkd7nH7w/mWyMwZNvaJWoPIazJCni5r15
         kECggjet/otZvNBWphSjQe1PuioHHuZad/9gscOopVpKhFeAhdPMoTDAJTnMcpSgSvhc
         cCQA==
X-Gm-Message-State: AOJu0YzrZGBAqrZcUrjaOpatTX3KHBSrBcw/LSN67QzdE3O68gtjAPDA
	ls0ky0qtbP7etz/73myUEbCB9HW0CN3W/3E38v3EJKDBYj9W/s+oDMYpNMseGA9STIevUbPAj8l
	Ua2vV
X-Gm-Gg: ASbGnctgjfFaEIZjd+hMCQnDGomeI5+Fk4QVIcxAoXOlV0MAiMLjow2Es8kVHhWBscO
	/MzkZ3A6R0wV6mpIfPa7PBpXCdUYf+lWmywvx/lR0TxvlPUuQLPMhN+pQvDCP03Bo87V+cFwF9B
	H9ADWvfpvP/HxHKl+634qao9g9DDNqp5e+feZs1VhJkfSlEQcfm1rAegyfvYqsxBt6aSlFh4vw/
	o7Nx083O0uo+n0e1WaMOW7EBnpIcvdcWYhLm9wYTTvq3pmlgfR9PxFqILBYpbK6xjOpQxroEolZ
	Bz1ZRNKRWQB67G5+ir11U6vrV2Eaa14xrUqLZynz1ElbOJShcJ0K2ZgZXJDrq2TQ7zKagGVGWUq
	xFbLp0ZeMvk8SIIkmkYmeUSxO2LAUswAk+RrprA==
X-Google-Smtp-Source: AGHT+IHgahu3TNcyPfjJ+IHZHcoXl8ck1sZXFFW2lV/LyJJcAmdiGfEXbRSeWINsQYSSUOh8kwQ36g==
X-Received: by 2002:a05:620a:1998:b0:811:41e5:f945 with SMTP id af79cd13be357-813c596ffe9mr1355603885a.42.1757432473516;
        Tue, 09 Sep 2025 08:41:13 -0700 (PDT)
Received: from maple.netwinder.org ([184.147.192.2])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-81b58c54d9asm138885185a.1.2025.09.09.08.41.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 08:41:12 -0700 (PDT)
From: Ralph Siemsen <ralph.siemsen@linaro.org>
Date: Tue, 09 Sep 2025 11:40:52 -0400
Subject: [PATCH RFC 3/3] mke2fs: add root_selinux option for root inode
 label
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250909-mke2fs-small-fixes-v1-3-c6ba28528af2@linaro.org>
References: <20250909-mke2fs-small-fixes-v1-0-c6ba28528af2@linaro.org>
In-Reply-To: <20250909-mke2fs-small-fixes-v1-0-c6ba28528af2@linaro.org>
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
index 14bae326..6af71fd5 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -426,6 +426,16 @@ Specify the root directory permissions in octal format. If no permissions
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
index 59c7be17..a16a808a 100644
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


