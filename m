Return-Path: <linux-ext4+bounces-761-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16A4B829381
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 06:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C5D4289564
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Jan 2024 05:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB96DF6B;
	Wed, 10 Jan 2024 05:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="szMnQ9+R"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBDBDF56
	for <linux-ext4@vger.kernel.org>; Wed, 10 Jan 2024 05:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8C8C433C7;
	Wed, 10 Jan 2024 05:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704866244;
	bh=xkhsXl2XxQncRLZtJH3dNZO8A2VEAbuIHCWU+u6gSkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=szMnQ9+RKDxoFOooylPKO357HNuKL+GpAsuCr7bxcrOGido25mnn/JEt1INjwyPnh
	 VBOQBEPv8BRYygjs156iJcLGdU2XlhBX6g69OwXf67xzClN8xQGgnFZ7JgitGhQ8/c
	 sjzNXF+axDJGjsq3n73PeT5et3ejNSzKOuzKRdeW8MmDOUjpZufN2isHK/eLvJXg4c
	 RI+pjTjxqPmGHcb3VrE3v8h6Jcdr5CCAcEEuvabN71r4C/aFk6sVekOae+dqss6ztC
	 NMdWinOvmcKeN/YsB6JKlKedWPr9erKObo3n91in8oww3RtdrxLKT0/V5mGT9sge4e
	 AXgTa5iEd0O4Q==
Date: Tue, 9 Jan 2024 21:57:24 -0800
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org
Subject: [PATCH 4/2] debian: don't restart e2scrub_all when upgrading package
Message-ID: <20240110055724.GC722946@frogsfrogsfrogs>
References: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <170268089742.2679199.16836622895526209331.stgit@frogsfrogsfrogs>

From: Darrick J. Wong <djwong@kernel.org>

When installing or upgrading the e2fsprogs package, only start the
e2scrub_all timer and the reaping service.  Don't restart e2scrub_all
itself, because that will kill any scrubs in progress, which will
trigger the failure reporting.

Signed-off-by: Darrick J. Wong <djwong@kernel.org>
---
 debian/rules |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/debian/rules b/debian/rules
index b85976f0..0120fe6a 100755
--- a/debian/rules
+++ b/debian/rules
@@ -148,6 +148,10 @@ override_dh_installinfo:
 	dh_installinfo -pcomerr-dev ${stdbuilddir}/lib/et/com_err.info
 	dh_installinfo -plibext2fs-dev ${stdbuilddir}/doc/libext2fs.info
 
+override_dh_installsystemd:
+	dh_installsystemd -p e2fsprogs --no-restart-after-upgrade --no-stop-on-upgrade e2scrub_all.timer e2scrub_reap.service
+	dh_installsystemd --name=service1
+
 override_dh_makeshlibs:
 	for i in $(SYMBOL_LIBS); \
 	do \

