Return-Path: <linux-ext4+bounces-3434-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6834E93B730
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 21:07:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 993CE1C216D2
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 19:07:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619C7167D8C;
	Wed, 24 Jul 2024 19:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c5KnN2sg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3FF65E20;
	Wed, 24 Jul 2024 19:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848017; cv=none; b=mZGv3mem2qHQKee4JbSneedvGyyQ2RRtBhpU9+R9pt/AJdGkuqyrk6QkrKiPqoyz+Yt9g5hv0PTyu61GKycXAOTAObM6ZQIxR+lGYFNgrHc2m5gyLm1tk2mbklMzFIt5mtS0SVRZYCop6c3AVCd5Vjfy1wXzxk//wSIJ1y/isd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848017; c=relaxed/simple;
	bh=rQ153ztKslahUTw3Zcbb4iyRxvj1/+V/XI2lxHnMeO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c/vrQta7jjNKwkW2OwqzBQmlYwUxYsw46G08+hK3YalozX91iiIw0kaHhLsVwBqvdMpAQW6bN+yCdE3Ol01w0ASBDZXnxlljotfS8dX/h8jWgA2rrJ+noeyg0OGSbc3r4shCEqEJ9jINYF5DnsGJW0+K0YGm4kENmcV9dQ4KCw0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c5KnN2sg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9403CC32781;
	Wed, 24 Jul 2024 19:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721848016;
	bh=rQ153ztKslahUTw3Zcbb4iyRxvj1/+V/XI2lxHnMeO8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c5KnN2sgsF4sbsIF+PtbhCS+EooYiZ5qKTfBqCua8GlKrWWG51YCbiIpPXRaNMe4Y
	 WXtzM8PSyhgttSQT5HJHtYrutMxG+wUGhM0tvBfYtFw42oX+8UwNDS3CF7I1yK7G8p
	 +T0ZqvBwLm9XuqsFKj9OVV2U/m9rlx0PkSCOybHJpC+sIBTuBZzm6n380q8FyJqIiE
	 9ovSRLsxU4RVyn+oWLcF/Eq3xxKcxjN33zY/FJ13/e/L7bj8G5TM51q0fqPHPZLHdO
	 AjaoCVIby43VM1raZOjgjd8qXDIb+8OiOoZY8PnPe8Z0yV536/rC1CGzEHLX7nCr5S
	 hgvVv1Q/+zBMQ==
From: cel@kernel.org
To: amir73il@gmail.com,
	krisman@collabora.com
Cc: gregkh@linuxfoundation.org,
	jack@suse.cz,
	sashal@kernel.org,
	stable@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v5.15.y 2/4] samples: Make fs-monitor depend on libc and headers
Date: Wed, 24 Jul 2024 15:06:21 -0400
Message-ID: <20240724190623.8948-3-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240724190623.8948-1-cel@kernel.org>
References: <20240724190623.8948-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

[ Upstream commit 8fc70b3a142f97f7859bf052151df896933d2586 ]

Prevent build errors when headers or libc are not available, such as on
kernel build bots, like the below:

samples/fanotify/fs-monitor.c:7:10: fatal error: errno.h: No such file
or directory
  7 | #include <errno.h>
    |          ^~~~~~~~~

Link: https://lore.kernel.org/r/87fsslasgz.fsf@collabora.com
Suggested-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 samples/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/samples/Kconfig b/samples/Kconfig
index 88353b8eac0b..56539b21f2c7 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -122,7 +122,7 @@ config SAMPLE_CONNECTOR
 
 config SAMPLE_FANOTIFY_ERROR
 	bool "Build fanotify error monitoring sample"
-	depends on FANOTIFY
+	depends on FANOTIFY && CC_CAN_LINK && HEADERS_INSTALL
 	help
 	  When enabled, this builds an example code that uses the
 	  FAN_FS_ERROR fanotify mechanism to monitor filesystem
-- 
2.45.2


