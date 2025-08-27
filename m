Return-Path: <linux-ext4+bounces-9687-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA7DFB37E74
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 11:10:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB0181881A9D
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Aug 2025 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 904E535082E;
	Wed, 27 Aug 2025 09:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUoo4ji2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F9634F46B
	for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 09:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756285711; cv=none; b=SMcZ+tm4Yqij3lkjZD6p2Wig+my+Z7mgHCel3TSfUVlT9DBAUsxj8M0dunj7gnEdFimqDAI4Gz8LWrSUyKuFAyFhxIjHpD8S8xaArF1JTfokyl5XtDSTcavmpcWtIVQRk0o1TkxeGMI4tYRZqa08SkxJgTl+kEmSR4zrSs+s/Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756285711; c=relaxed/simple;
	bh=HSoyRRGbqwKrrPWn0b3Gxv3O7atFcfaJ2Ou+bHXSKWI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KuAmJcpOwSvqPMBhJ6Up/Mr8JU/tUXIrGiyy1fckn0tlTo6YaQhyAcBKrYbH35oed85NHSwVwigdENb7uwMvcNAB/TC9qS19McWcWbqELvF3c8hKUakuQhlmGfPGGQpfxNchJ1e++TBS7DLbv8o6hHjZ9dVp66pg8hqPm2D1ZFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUoo4ji2; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756285704;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=btmAfnbOXrpj/8xKgw2LcnKjNrejkITdGU2HjYixq9M=;
	b=SUoo4ji2jfYoumXrBmQEEd8PxC8sRjle6RGYlO7xHU3Qle7cXBzZaduQQZDItjDXcjT7C0
	24N4JJrpW5Rgk6M6vyoZCVgXfO9PA3Gf/cJ05tLXHdx1y8dwyFSuncZ7/x3Pc/RvlpV6O0
	ylro3jsXMrWYDnyRFtcsj/eYipRdmK0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-vH1VJya7OpuEN2rfGnYmhQ-1; Wed, 27 Aug 2025 05:08:18 -0400
X-MC-Unique: vH1VJya7OpuEN2rfGnYmhQ-1
X-Mimecast-MFC-AGG-ID: vH1VJya7OpuEN2rfGnYmhQ_1756285698
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-70a9f55eb56so127151226d6.2
        for <linux-ext4@vger.kernel.org>; Wed, 27 Aug 2025 02:08:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756285698; x=1756890498;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=btmAfnbOXrpj/8xKgw2LcnKjNrejkITdGU2HjYixq9M=;
        b=HxMwqKBjqcIl1eWiRVkvrkbpT8Wmr0nspzzxDrJKGCNmxDOSMriFTDQizFPhgW1ZGJ
         b+xzhUjxQ86witfnOb2Hw1E7kClQFHl4m/nyECSh1zqQ7Ntenv92Q9TSPbZSFsvKXI3B
         CmxT9fc8n1xbcSAbmOXk7xzbL/xAwcUYC6dvCozn7pa9XgPNzNmeexsqMsz7IjMJwQiR
         AaytHLoffOBuWRGkCR9EcIIR6KKRnrXVZpg5v4avRqe9Re165LFlBp0lBDDJZuEW/Z7o
         YAI12O4jztXDEisWHFeA2hmPbslWsCfSxYq6IGxsvGYYSLkGh2Lh+ZsMdlnDxJ/AIV7A
         ieGA==
X-Forwarded-Encrypted: i=1; AJvYcCWW6ev+QNeyy3VSOdF/zqi5QlviWCJh2hjPOejL9jHDTHy7iQ4sUWPGX9bUIuJYeOeJ3DEQk8vjR3lY@vger.kernel.org
X-Gm-Message-State: AOJu0Yxxxq/FIt19XLzbv+oJDLFHLziVx/jJjM8H75Dk5couNmHREk7f
	DojgUovnnqu+KXZLZ6UHe4s8zAorkhJtNUfbI4GPjQVyvuRMioFMFilxRt3RVX4u7jgc0RQq8u8
	KTizB/ueegHzpNAzXQ1iBylhcw02Y/Zm5vlyXRLV0PAs+GpRpI55zSZnkGF4bvwcu2l3wUCM=
X-Gm-Gg: ASbGncu8WwLERTpS2igTITRicuaRdVW6hHfX4IyvBVPyHvbDtm9yHqKOukucZdn4Laa
	AgXkFSzDdkalE5lKxwp6Ras303qs7KpzQ8w+QKZBYnQGm/wu01MHurHG+QohcKmBa1H/0jeJwvF
	jfvsosjhAjUC4lanmeaNAm2BBrlvR9F3qJfnkBwHaBo4rW3ueCTSKVjtCPgOr8Al9MHBWeSqtl1
	AhaKXp2bW8d32d261mgy1pBaxPlLhANgaMGVyGgQD+YkKq8ZRcNj6++twoIq8RU5VudhzzkLhdu
	C5zTR/36jBw3WhPYCvUKFWpmVaKMi2d51TAs00cRrE2DlWyG3/xa5/eIne4ojHwgXHgbWTDpPYc
	rjZDgqRfRlA==
X-Received: by 2002:a05:6214:f2f:b0:70d:ad2e:ced8 with SMTP id 6a1803df08f44-70dad2ed051mr7559346d6.54.1756285697885;
        Wed, 27 Aug 2025 02:08:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKnx0Sy0uoUmTwX2Z3OLZ81WV24S78smOZB6VPkrYeFf13KoSmBl+HyiIGutNgl+jaQogtkw==
X-Received: by 2002:a05:6214:f2f:b0:70d:ad2e:ced8 with SMTP id 6a1803df08f44-70dad2ed051mr7559106d6.54.1756285697478;
        Wed, 27 Aug 2025 02:08:17 -0700 (PDT)
Received: from lbulwahn-thinkpadx1carbongen9.rmtde.csb ([2a02:810d:7e01:ef00:b52:2ad9:f357:f709])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70da72b3c1csm81764646d6.58.2025.08.27.02.08.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Aug 2025 02:08:16 -0700 (PDT)
From: Lukas Bulwahn <lbulwahn@redhat.com>
X-Google-Original-From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: [PATCH] ext4: remove obsolete EXT3 config options
Date: Wed, 27 Aug 2025 11:08:08 +0200
Message-ID: <20250827090808.80287-1-lukas.bulwahn@redhat.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukas Bulwahn <lukas.bulwahn@redhat.com>

In June 2015, commit c290ea01abb7 ("fs: Remove ext3 filesystem driver")
removed the historic ext3 filesystem support as ext3 partitions are fully
supported with the ext4 filesystem support. To simplify updating the kernel
build configuration, which had only EXT3 support but not EXT4 support
enabled, the three config options EXT3_{FS,FS_POSIX_ACL,FS_SECURITY} were
kept, instead of immediately removing them. The three options just enable
the corresponding EXT4 counterparts when configs from older kernel versions
are used to build on later kernel versions. This ensures that the kernels
from those kernel build configurations would then continue to have EXT4
enabled for supporting booting from ext3 and ext4 file systems, to avoid
potential unexpected surprises.

Given that the kernel build configuration has no backwards-compatibility
guarantee and this transition phase for such build configurations has been
in place for a decade, we can reasonably expect all such users to have
transitioned to use the EXT4 config options in their config files at this
point in time. With that in mind, the three EXT3 config options are
obsolete by now.

Remove the obsolete EXT3 config options.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
---
 fs/ext4/Kconfig | 27 ---------------------------
 1 file changed, 27 deletions(-)

diff --git a/fs/ext4/Kconfig b/fs/ext4/Kconfig
index c9ca41d91a6c..01873c2a34ad 100644
--- a/fs/ext4/Kconfig
+++ b/fs/ext4/Kconfig
@@ -1,31 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0-only
-# Ext3 configs are here for backward compatibility with old configs which may
-# have EXT3_FS set but not EXT4_FS set and thus would result in non-bootable
-# kernels after the removal of ext3 driver.
-config EXT3_FS
-	tristate "The Extended 3 (ext3) filesystem"
-	select EXT4_FS
-	help
-	  This config option is here only for backward compatibility. ext3
-	  filesystem is now handled by the ext4 driver.
-
-config EXT3_FS_POSIX_ACL
-	bool "Ext3 POSIX Access Control Lists"
-	depends on EXT3_FS
-	select EXT4_FS_POSIX_ACL
-	select FS_POSIX_ACL
-	help
-	  This config option is here only for backward compatibility. ext3
-	  filesystem is now handled by the ext4 driver.
-
-config EXT3_FS_SECURITY
-	bool "Ext3 Security Labels"
-	depends on EXT3_FS
-	select EXT4_FS_SECURITY
-	help
-	  This config option is here only for backward compatibility. ext3
-	  filesystem is now handled by the ext4 driver.
-
 config EXT4_FS
 	tristate "The Extended 4 (ext4) filesystem"
 	select BUFFER_HEAD
-- 
2.50.1


