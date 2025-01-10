Return-Path: <linux-ext4+bounces-6033-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB28A08B06
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 10:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBEF53A992B
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 09:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69588209F24;
	Fri, 10 Jan 2025 09:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QeBNd6jD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A07BE206F06;
	Fri, 10 Jan 2025 09:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500412; cv=none; b=XeC+eTvLjXaZH49VQ3LtfpvYrNUHXEvXOlTom+Krn24wq2F6Jdt/btsLqvvjqmLkSuN21y3jXrLIqpiN3+Ei4nimSSAnvDRXfxhlaRKjDx/FLo0vVkz/h08Xz2ASLXrhDPR04CKN6d7EpXbxZFGk/LI5JNvMHOnYYVXCaMyjq3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500412; c=relaxed/simple;
	bh=SRbCW5elgWrfQrsMHXEyXZfnCTiDhxeyV6LBA3Y2WKU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=QG2wsRCxu9uuhSy5eWwgkdECuRhyrDgN7yCHeSIbnSk41BK6zDoA55s+ahRFpwnHncnJOdS+3K8RWjIctODZWyLShH4MjxmMb7eMLcej2JgxPIm0ctLIpsLp4jMHVrty1nWRkE3KeWN3YZ5JJKlEZToXztEr5LARnoPR1etTaKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QeBNd6jD; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2ee989553c1so2956368a91.3;
        Fri, 10 Jan 2025 01:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736500409; x=1737105209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0eMn14kRYlF/w5tvKcVfVLe+UkdswT1vD8flcxY22Ew=;
        b=QeBNd6jDx3pUC/0M2rwcLJg16QV7TEmmS4A79PIYKdZSU92tQRrAlY0fsIOyvzCUsF
         BJSJUKMQS/a/H9HyoQGTt3scf7sjAbSvr95YCW5aU8g0hzsywP5M5zNIGIGyGgWhlq55
         3fIYZ10A18KUGrTVezQr9vh+8iYgy07x7XbDtjkOdCQBLWaIiPar6hKeO/6DFu0GPmkE
         8MEKzw2Zi/slw+UMZmfaGbXlLHpNcv3GnzmIQQg17X/yv3qN+qf1iecmT2v0v9a4LD5T
         pV0USuv/Gbh1owL1V1HQH5CGg/2K1jUTxQh8RqKz3VbB6I3FKz+o7pNlVw1giBPQqeeF
         ITSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500409; x=1737105209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0eMn14kRYlF/w5tvKcVfVLe+UkdswT1vD8flcxY22Ew=;
        b=egFa5SlfScSYzx5oKoPzNSZgK0+fnd9xOi1HESG4OuvCltrD9eIcg3HiVyKqDpe/tW
         X09q7sh5CdGIA8cy7EqDQFK0BVU8vhAbKGeqxHVhybZZJ4lIs2suiJEcSuqJPt6S6UvP
         vBrT0iM8oC6thUQTUiw22iqLF3OnjUiUYqSjtikdIc22l9HalADECiseMflNBlZmJL7+
         StFyR8oY68wj6nk6OA9HiCHFty/H0om+G49XbK2j8vr3Cu8FoW9WZkXvwed86w8K2PEw
         frFG9vGMO467HNLvxSrhgZyqKJqkI5m4f7FrgiWkDarSni1Vx6WwlaFcGruQlzYqv9RA
         uQAg==
X-Forwarded-Encrypted: i=1; AJvYcCX5cOwkiL2Gp7DFGtJuVOu4dJZZM5DyWGYKuisQG0637Qh4+3lxc0ME5BENBUgrd5KYHtOjXLk6haU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzOwOaK/xM4TOVTzsihv1zsCDjqQ49jcOibfXY1a4V8jL8TnVqg
	mc2EjZFus69iwNZDmAzPY3s+YjWgqvAKp+ny6QIpdfdIY+okrXh778lZHbYn
X-Gm-Gg: ASbGncuxgYvxBWyNDzA+46mymord4hHbSlDURQdmW5gfoONVSeBPcTXCaXxnTZ8IQRY
	FHy5Lq9Q3KJqgww0ta/luQ6Y4bZCi2A7E7Hy9UGzHLu12/ludExTcfEL752shAM8PBiwNHjcF8e
	PIWfx7MPsIcis8DLumndhLAL9+CDyPi7cx1EKutFnkAZBep489p00cwjc+yMj9HTEKIJ1nIs5gb
	VRyiHy0tZINJM2oj0CvOkcPbB6a3nhBq3/woXPdVS5FWhWnSHTM5+5a23qM
X-Google-Smtp-Source: AGHT+IHdxYNRKqI5sJMPe7bnhy+5VJJDr8pnOhgoaKyf6j477Yi5CYZ3esqn9S9ENXAtHVVy4xhIgQ==
X-Received: by 2002:a17:90b:3d50:b0:2ea:9ccb:d1f4 with SMTP id 98e67ed59e1d1-2f548e3c0demr17106561a91.0.1736500409491;
        Fri, 10 Jan 2025 01:13:29 -0800 (PST)
Received: from citest-1.. ([49.205.38.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219a94sm10166485ad.129.2025.01.10.01.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:13:29 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [RFC 5/5] configs: Add a couple of xfs and ext4 configuration templates.
Date: Fri, 10 Jan 2025 09:10:29 +0000
Message-Id: <df56f684b585cda919f8cc01a77c2c8454aefc7c.1736496620.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
References: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit adds a couple of simple configuration templates. Developers
should add more templates based on the tests they add.

Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 configs/ext4/1k   | 3 +++
 configs/ext4/4k   | 3 +++
 configs/ext4/64k  | 3 +++
 configs/xfs/1k    | 3 +++
 configs/xfs/4k    | 3 +++
 configs/xfs/64k   | 3 +++
 configs/xfs/adv   | 3 +++
 configs/xfs/quota | 3 +++
 8 files changed, 24 insertions(+)
 create mode 100644 configs/ext4/1k
 create mode 100644 configs/ext4/4k
 create mode 100644 configs/ext4/64k
 create mode 100644 configs/xfs/1k
 create mode 100644 configs/xfs/4k
 create mode 100644 configs/xfs/64k
 create mode 100644 configs/xfs/adv
 create mode 100644 configs/xfs/quota

diff --git a/configs/ext4/1k b/configs/ext4/1k
new file mode 100644
index 00000000..6f16fc44
--- /dev/null
+++ b/configs/ext4/1k
@@ -0,0 +1,3 @@
+FSTYP=ext4
+MKFS_OPTIONS="-F -b 1024"
+MOUNT_OPTIONS="-o block_validity "
diff --git a/configs/ext4/4k b/configs/ext4/4k
new file mode 100644
index 00000000..32f02ea9
--- /dev/null
+++ b/configs/ext4/4k
@@ -0,0 +1,3 @@
+FSTYP=ext4
+MKFS_OPTIONS="-F -b 4096"
+MOUNT_OPTIONS="-o block_validity "
diff --git a/configs/ext4/64k b/configs/ext4/64k
new file mode 100644
index 00000000..6c50b839
--- /dev/null
+++ b/configs/ext4/64k
@@ -0,0 +1,3 @@
+FSTYP=ext4
+MKFS_OPTIONS="-F -b 65536"
+MOUNT_OPTIONS="-o block_validity "
diff --git a/configs/xfs/1k b/configs/xfs/1k
new file mode 100644
index 00000000..ab74d3a7
--- /dev/null
+++ b/configs/xfs/1k
@@ -0,0 +1,3 @@
+FSTYP=xfs
+MKFS_OPTIONS="-b size=1024"
+MOUNT_OPTIONS=" "
diff --git a/configs/xfs/4k b/configs/xfs/4k
new file mode 100644
index 00000000..9a390404
--- /dev/null
+++ b/configs/xfs/4k
@@ -0,0 +1,3 @@
+FSTYP=xfs
+MKFS_OPTIONS="-b size=4096"
+MOUNT_OPTIONS=" "
diff --git a/configs/xfs/64k b/configs/xfs/64k
new file mode 100644
index 00000000..ddcd7977
--- /dev/null
+++ b/configs/xfs/64k
@@ -0,0 +1,3 @@
+FSTYP=xfs
+MKFS_OPTIONS="-b size=65536"
+MOUNT_OPTIONS=" "
diff --git a/configs/xfs/adv b/configs/xfs/adv
new file mode 100644
index 00000000..f1b2ec2e
--- /dev/null
+++ b/configs/xfs/adv
@@ -0,0 +1,3 @@
+FSTYP=xfs
+MKFS_OPTIONS="-m inobtcount=1,bigtime=1,rmapbt=1"
+MOUNT_OPTIONS=" "
diff --git a/configs/xfs/quota b/configs/xfs/quota
new file mode 100644
index 00000000..a7f0c7e7
--- /dev/null
+++ b/configs/xfs/quota
@@ -0,0 +1,3 @@
+FSTYP=xfs
+MKFS_OPTIONS="-f "
+MOUNT_OPTIONS="-o usrquota,grpquota,prjquota"
-- 
2.34.1


