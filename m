Return-Path: <linux-ext4+bounces-5008-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A63A9C1E69
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 14:49:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06CDF1F22D69
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Nov 2024 13:49:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A118F1EF94A;
	Fri,  8 Nov 2024 13:48:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="b4RtYMAS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3251EF0AF
	for <linux-ext4@vger.kernel.org>; Fri,  8 Nov 2024 13:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731073716; cv=none; b=OXd8C+TRT/HaQqT1dsy42zf255oNhWURwYt+BMWDyz1VdmzrUp8n6Mdf6HUCahHRtbeEwhXiLu5MyZOyCKhV/UTAFirJJVoqs1g9vHLbHkFSb/dhBtIiFWfbepQ4jtMfI8b099TJFUxGEES0MZl8jk6gB9wIAjjwLDDFxqBcJzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731073716; c=relaxed/simple;
	bh=HXll/USNPXm9osgO9GDNWVRMyn2qi6KDiYjdAd4rm2I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O7b4NdS/uLkukNul6ToElY1KtRieq2TlWhwJTn0kSnqzZ2EOgP+UhPMn/NKDm2GqpSrTTRSl4WueUm2z2AUux0zW4phJLF5NVfFiE+DAIM6xUE/dS846mNlH3AKG32utmWGobrc8dAH5hfA+v2LFrHGss/wy647CvWTM0gHQtNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=b4RtYMAS; arc=none smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 956883F296
	for <linux-ext4@vger.kernel.org>; Fri,  8 Nov 2024 13:48:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1731073710;
	bh=NetQDVoDx3YBHIR6egryvpy51aqIFhsEmHs2mG5SPpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version;
	b=b4RtYMASswtjEKszG4HbMn4EKveZ83hfC2b1PyHwyUrX2Zd/gHZ239h7VBlzH110c
	 yqTrC5ka3YcVcq8oMwxqJ5jaOnTKfK6CIqKFn5o8pIADIOH/cEh6kn6aF8s19TdTny
	 iCR4d55Ptp7rZLIaX4YeaIKwknjAezPpGxoATZ2pnXAnhZs7lHZFO+CVKcdPzgOC8+
	 kdhVjKqzp6yC43Thrh+TiIJqI31m9Z2MsyAY6bMoUpUrCI7hxzBn/qiOxx+FoeM0jb
	 f0iIzH2JKrc9WX9/Dmxl0Plkbr7YG/shss1WY+3GyBkyBJSdz0kUhdeX+488XHNJpd
	 LQlReLTYJUOhg==
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9ad6d781acso188164366b.2
        for <linux-ext4@vger.kernel.org>; Fri, 08 Nov 2024 05:48:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731073710; x=1731678510;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NetQDVoDx3YBHIR6egryvpy51aqIFhsEmHs2mG5SPpg=;
        b=PehxvTAEflbaUo9PqCCOBfNaOIqXd5t03ifm3SMQECuw7qzzAJrUbiqSA8+KyY7PXY
         yeP2NCV43U27QKOa8q9ipRkVKA9MRI++alEO0PmTFQUBf1wyhid7AHXtHdKN5Gcn5PEF
         M4eKxxjCfyl3SshK5L1syuL4FNSq2CoWi1t2dhn311vdZtrZC787IzHcHpShUEKswOmp
         p1UsNhDXg6MCIi2qk0a9WdfeTYfNkM0SSZ8sll/NwgV6s38MSVGiINOmftXgjv03E3sJ
         ScTAvaKPhLm/LzadfcGW/uAsXd37rr1VPGgNjQXT7+lnLxp/lIdH5d23Bhy1RRMQ46yW
         Nh7Q==
X-Gm-Message-State: AOJu0YyY7j8Eym7thaPvkAmHyIYoqRx53i4Avix8aXwQUkMvi70R2gbB
	zalMTNptat8bR4z89EGIkBOekgyDYN/wDoAMON0FYE857Q9haylYueBcgRjwwFBNMvRopW2mmsP
	G9ENT3i1V9m82cmePp7MiNcBEFmeCLb3U0QKP6T5DgCV8WfVJXf3WQupuDPDqjh/h/4vIds7HDR
	8=
X-Received: by 2002:a17:907:a09:b0:a9e:b5d0:4ab7 with SMTP id a640c23a62f3a-a9ef004ab81mr291565466b.52.1731073710007;
        Fri, 08 Nov 2024 05:48:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IELza7P8x5H3b/u2qEA2ug56jAkmBU7ECYtpN4HyVG0aKkn3lo7Jul5BbYnaLkLnCHrUKT9xg==
X-Received: by 2002:a17:907:a09:b0:a9e:b5d0:4ab7 with SMTP id a640c23a62f3a-a9ef004ab81mr291562966b.52.1731073709621;
        Fri, 08 Nov 2024 05:48:29 -0800 (PST)
Received: from amikhalitsyn.lan ([188.192.113.77])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0e2ea76sm233539966b.205.2024.11.08.05.48.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 05:48:29 -0800 (PST)
From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	libaokun1@huawei.com,
	jack@suse.cz,
	tytso@mit.edu,
	Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Subject: [PATCH] ext4/032: add a new testcase in online resize tests
Date: Fri,  8 Nov 2024 14:48:17 +0100
Message-ID: <20241108134817.128078-1-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new testcase for [1] commit in ext4 online resize testsuite.

Link: https://lore.kernel.org/linux-ext4/20240927133329.1015041-1-libaokun@huaweicloud.com [1]
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 tests/ext4/032 | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/tests/ext4/032 b/tests/ext4/032
index 6bc3b61b..77d592f4 100755
--- a/tests/ext4/032
+++ b/tests/ext4/032
@@ -97,6 +97,10 @@ mkdir -p $IMG_MNT || _fail "cannot create loopback mount point"
 # Check if online resizing with bigalloc is supported by the kernel
 ext4_online_resize 4096 8192 1
 
+_fixed_by_kernel_commit 6121258c2b33 \
+	"ext4: fix off by one issue in alloc_flex_gd()"
+ext4_online_resize $(c2b 6400) $(c2b 786432)
+
 ## We perform resizing to various multiples of block group sizes to
 ## ensure that we cover maximum edge cases in the kernel code.
 for CLUSTER_SIZ in 4096 16384 65536; do
-- 
2.43.0


