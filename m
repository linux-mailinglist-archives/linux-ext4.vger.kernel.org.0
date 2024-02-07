Return-Path: <linux-ext4+bounces-1141-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C61C84C517
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 07:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EDF48288D91
	for <lists+linux-ext4@lfdr.de>; Wed,  7 Feb 2024 06:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5B6C1CF8C;
	Wed,  7 Feb 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="BqVpIOAa"
X-Original-To: linux-ext4@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B541CF90;
	Wed,  7 Feb 2024 06:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707288224; cv=none; b=Ri5VXsagrk0a65Oqj5xkNKDFpJpu4x1eK3YQNEauK7nW5toQJl8yHUqiA3oRFSZ84e2QAgXxkfv6quSaTFH95W3po0wFBpp/x88M9D46/BkPy66DaIoCr2gxWV9vypOAxBXNTyR6bDc33HtCMLu0Cxx2VwVS+ZHfJFcMX8IIwMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707288224; c=relaxed/simple;
	bh=A2Koex6RA/Pnpr/3Zxy4fTLH4zSUL1TGk+vIg6Cqh1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OdVKmFCDJx/saW0gu6Pq/7hWNrCSGL2TqaG+xff9yBfbgmqnfeIVY0WTL9429lffAS67M978FXreuQ5V2KntdOq35ELffzOIfN0Ly2CcVZEW8Zp6MEzI63SDI5zffHVbdXUoXW5RyA9wv70aWJbXtnKM4d5qHQQzAgXhnzv/ZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=BqVpIOAa; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707288216;
	bh=A2Koex6RA/Pnpr/3Zxy4fTLH4zSUL1TGk+vIg6Cqh1Y=;
	h=From:To:Cc:Subject:Date:From;
	b=BqVpIOAaQXPuUL3DeSNCsgpCJCi/TzAqROL98jFRr0oHyIilvynJxxKXWtkhou7FU
	 BeA/Xdhli16LJvEQ49XlrjWC5T/iBZ6W+kRBgc2XQsjMarI4kBWuTye5orvu5zzvMV
	 GDeU8RX3RnpkRUhs0Nx6+I8w+Vv7LXor09Z5guvflJR/JrZBh5A6TRuAGDoQXT2OsF
	 ORZvzA0nFPWQ/RWOEzV5lFe8l+GjFxD4+9skeuTe6hy/CK+vmK4AT9ZiW34IvNbf5j
	 t4EU808xGX+mIsjPxVPr29dizixel/w2wMilmgVqchJarPuFr5Ercrd/nzOn0OcuOS
	 IKKOfvFGlT3Nw==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 2FCB73780C22;
	Wed,  7 Feb 2024 06:43:32 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	jaegeuk@kernel.org,
	linux-ext4@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Cc: chao@kernel.org,
	adilger.kernel@dilger.ca,
	linux-kernel@vger.kernel.org,
	kernel@collabora.com,
	eugen.hristev@collabora.com
Subject: [RESEND PATCH v9 0/2] Minor cleanup for case insensitive path
Date: Wed,  7 Feb 2024 08:43:00 +0200
Message-Id: <20240207064302.221060-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am trying to respin the series here :
https://www.spinics.net/lists/linux-ext4/msg85081.html

To make it easier to apply I split it into smaller chunks which address
one single thing.
This series will just convert to qstr the storage of the filename
currently using fscrypt_str .

Gabriel Krisman Bertazi (2):
  ext4: Simplify the handling of cached insensitive names
  f2fs: Simplify the handling of cached insensitive names

 fs/ext4/ext4.h     |  2 +-
 fs/ext4/namei.c    | 23 ++++++++++----------
 fs/f2fs/dir.c      | 53 ++++++++++++++++++++++++++--------------------
 fs/f2fs/f2fs.h     | 16 +++++++++++++-
 fs/f2fs/recovery.c |  5 +----
 5 files changed, 58 insertions(+), 41 deletions(-)

-- 
2.34.1


