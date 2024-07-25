Return-Path: <linux-ext4+bounces-3466-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E4693C678
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 17:33:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D9671F22B5B
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2024 15:33:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C203A19D067;
	Thu, 25 Jul 2024 15:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SfNEw4YK"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40A3C19CD0C;
	Thu, 25 Jul 2024 15:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721921576; cv=none; b=Wlu/JNSB2cdE0wCndAPXCl363azb6A6Pz6YZf2t+Kmq1N+PpZAdkUlklC/0TwAS72DcpUIccLF8jej/QLXyJNF4f1qKDB9MLcL9QUJ3luuK1b7TxTXsUZVSHcbFy6zhnMETk3VU+m1gV6bBt8A0UTw0UirjAPi3kwVgH7BvgKDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721921576; c=relaxed/simple;
	bh=9NhPVCOSiYhE4Lh0HIoQ8KgV4VoAls7UrG2nCM2hIcg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ja9P/yXILwKgFNeJ7yRY6P51pBKwPIrj/4AItRbUV784PhSR/ydL2+hPoM+LDQhc79dpOubpkgfhybOBkfNBgeYVNnwJj+iWFKdX1pMp9JByVByofgl78/iVDgLFzcv+HxI8tReKecfExTtNBODJqZjOxj8EI0MStsBdzbCnNCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SfNEw4YK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A108FC32782;
	Thu, 25 Jul 2024 15:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721921575;
	bh=9NhPVCOSiYhE4Lh0HIoQ8KgV4VoAls7UrG2nCM2hIcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SfNEw4YKL8w3znuW2Zir0U7WuSnC3XNZNjsH4R3+gxtMDyQGmU2NaLM6dfnFp3+p+
	 E/SpePOlJiE6HzPL8fJjN94tWXahSVZfsQ0zS8KMRm48MbI2IGULkoEkkj+wFFWrk/
	 MRo+Woi3M/MsSCfx2asEjqFr4jEJ4RH3ZYNrfwtqG4E8hJV458ItLl4eSySd/tkU6K
	 dUbrPzIqo0785C8WFX/5rkK7zchvK21cZhlbEWuGYvK7CQv5ouYwfhS9HtwPf3apTr
	 zoPYRfHzAIbiErgN5P9+aTIZ+p6Qy+TZRp+E7VqvJ05uVNJUgEa/yev3LKJ59u4Q1J
	 kZsD+rfVQoBeQ==
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
Subject: [PATCH v5.10.y 2/3] samples: Make fs-monitor depend on libc and headers
Date: Thu, 25 Jul 2024 11:32:28 -0400
Message-ID: <20240725153229.13407-3-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240725153229.13407-1-cel@kernel.org>
References: <20240725153229.13407-1-cel@kernel.org>
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
index cecd311ff321..a98e89992a18 100644
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


