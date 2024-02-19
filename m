Return-Path: <linux-ext4+bounces-1268-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 48EF7859C4E
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Feb 2024 07:37:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 062962819A9
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Feb 2024 06:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5709420311;
	Mon, 19 Feb 2024 06:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LgfBsflg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF7F20300;
	Mon, 19 Feb 2024 06:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708324649; cv=none; b=dLXMfqlh1MlYUtiR2q/mAEM9DBcuX28v4xJYm9n5mfp/11mZr9KaQ0XWhsAZ2ZVq9GnplgzvFLhtCL5YxMSM8atCL0xPrg5ICkJ9hnCEynw+ldhXwgus1V443qpFf26oCfHAxCLtTRy8jH56u+mNSn7Z9S+9bAbDlEg5B4zKmYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708324649; c=relaxed/simple;
	bh=in2TAPGhyrgxIAXDEV6P/+GXvaWE5867GfU014GPCJY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RP5j+4p3Cdv1CxtUbhLEDmtwKM22FdQFAOkSG1xky8OEaZq8Qu0rhXiFjznYhRWoQn0C8kzZTBNJurEzLOEfO6XS/j2Hpto5Tz/8/5OsUSAkPXCOlAjTMVe54Q2CXH/hPZCZeUxTMaFpgXzSD2LJTqusbrh1dNvEGwDAoCeQb/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LgfBsflg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1ACAC433F1;
	Mon, 19 Feb 2024 06:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708324649;
	bh=in2TAPGhyrgxIAXDEV6P/+GXvaWE5867GfU014GPCJY=;
	h=From:To:Cc:Subject:Date:From;
	b=LgfBsflgyGJRUY/xh1tjqCFh8reYm0b50sQgD2T1XxnDD7JNCc5o2/n3cGvoKd+rh
	 3MCbwLlYWEnEzTLdrC2Ls7f/KdZRKTTNhBWtCNCEV7l/3fzi2iTMxeWp8zuG8yueJg
	 MRqZagRhbvUks6x8fqFTWSMvCq8rUbj5wssdeR98rLej8BJxZSjH4VOCDhLpBqLi6l
	 NIB5fJ5aw37KhNs210YenujxNqjXfUrKKoGKE1OKDcd0EOb1M6Xl0NBvi6PFHD38vq
	 mm33nr3ES4Rw0MMG3bX91hMBRVHL+KydLIIhT5pWB2ZegUNScshDqRK09xncj6l/oO
	 PFAjm1ls8pUGw==
From: Chao Yu <chao@kernel.org>
To: jack@suse.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH] MAINTAINERS: add missing git address for ext2 entry
Date: Mon, 19 Feb 2024 14:37:18 +0800
Message-Id: <20240219063718.3682824-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ext2 git address is missing, add it.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 960512bec428..1c72a1301771 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7984,6 +7984,7 @@ M:	Jan Kara <jack@suse.com>
 L:	linux-ext4@vger.kernel.org
 S:	Maintained
 F:	Documentation/filesystems/ext2.rst
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/jack/linux-fs.git
 F:	fs/ext2/
 F:	include/linux/ext2*
 
-- 
2.40.1


