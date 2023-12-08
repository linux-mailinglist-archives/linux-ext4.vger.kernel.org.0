Return-Path: <linux-ext4+bounces-347-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 384FC80A24D
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Dec 2023 12:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D88081F2147E
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Dec 2023 11:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24531B27E;
	Fri,  8 Dec 2023 11:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sophiabehling.com header.i=@sophiabehling.com header.b="Ess35AY6"
X-Original-To: linux-ext4@vger.kernel.org
X-Greylist: delayed 400 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 08 Dec 2023 03:35:03 PST
Received: from mail.ud09.udmedia.de (ud09.udmedia.de [194.117.254.49])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AF910F7
	for <linux-ext4@vger.kernel.org>; Fri,  8 Dec 2023 03:35:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	sophiabehling.com; h=from:to:cc:subject:date:message-id
	:mime-version:content-transfer-encoding; s=k1; bh=yurkQ/ZqFfKvq0
	8uoF1jZvFIH/CYdc+MkXYG9jhrQNM=; b=Ess35AY6QFLEESJ87S87T+LV2KyHSQ
	ndsaPrFl+aD3eybrvoSJONLzzxc/4XjHQZ2yYf5n+aqfaolNz1auEpJs97zyNsQB
	1JF2QVWGnNC5sYX45sTqR+kYcn3jtyvH1umfg66uPOQSPp2GF6kkNK8vwQgEbZkc
	XqvTOnQonNUKwim6l1e1OzlBjQheiLvG6/gvjM1N0TWp52/IBm7BRuHc5/H4FlvJ
	h9OP4iSKNVAIG0GT7pMVqo/QdTmaSc8u2cZBIukn4eJNEyt8hkQiPTMN7NHebNZw
	bzedq5u7M7ksxIxt/4WjA0sbSWCSpXST9oW7svul1pQcoDT9xbadz7kg==
Received: (qmail 3348025 invoked from network); 8 Dec 2023 12:28:20 +0100
Received: by mail.ud09.udmedia.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 8 Dec 2023 12:28:20 +0100
X-UD-Smtp-Session: ud09?115p3@wfhS4f0LoLU+kC+T
From: Sophia Behling <solutions@sophiabehling.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: linux-ext4@vger.kernel.org,
	Sophia Behling <solutions@sophiabehling.com>
Subject: [PATCH] e2fsprogs: Document old requirement for block size with 'verity'
Date: Fri,  8 Dec 2023 12:23:02 +0100
Message-Id: <20231208112302.92724-1-solutions@sophiabehling.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With kernels predating 6.3 the block size had to equal the page size to use
'verity'; with kernel version 6.3 this limitation was removed. However, the
current LTS and SLTS kernels (6.1) predate this. At the same time, 'verity'
is currently a set-only feature in tune2fs.

This combination can cause problems with small partitions (like /boot) or
64k kernels (as on ppc64le, aarch64). Hence, the added note informs users
about the previous kernel limitation.

Link: https://lore.kernel.org/lkml/Y%2FKLHT3zaA0QFhVJ@sol.localdomain/
Signed-off-by: Sophia Behling <solutions@sophiabehling.com>
---
 misc/tune2fs.8.in | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/misc/tune2fs.8.in b/misc/tune2fs.8.in
index dcf108c1..b44660fd 100644
--- a/misc/tune2fs.8.in
+++ b/misc/tune2fs.8.in
@@ -706,7 +706,9 @@ full time, but subsequent e2fsck runs will take only a fraction of the
 original time, depending on how full the file system is.
 .TP
 .B verity
-Enable support for verity protected files.
+Enable support for verity protected files. Linux kernels older than version
+6.3 require the file system block size to be equal to the kernel page size
+to mount file systems with this feature.
 .B Tune2fs
 currently only supports setting this file system feature.
 .RE
-- 
2.39.2


