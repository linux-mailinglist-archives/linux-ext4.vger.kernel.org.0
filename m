Return-Path: <linux-ext4+bounces-1172-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6AD884DB82
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Feb 2024 09:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ABA71C23CDA
	for <lists+linux-ext4@lfdr.de>; Thu,  8 Feb 2024 08:35:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1F926A35A;
	Thu,  8 Feb 2024 08:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="3plkq6QD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB526A348;
	Thu,  8 Feb 2024 08:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707381330; cv=none; b=bx93e7qKm2k3kl4x0ddv10n1zelCM8Z60uglYz46wRxIyQO/gZlnVGyL0VhmtxsB4v8nEnIkCO/Ux2WbJpR5YqO6GbXliXFp8M55HxgC14y0oGjBNQCnUs6nTFm2lwaFiz4kAvvJ9vEIkhn8pD3hzW1dSVeYT86MmkQl3RohmVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707381330; c=relaxed/simple;
	bh=i+4EJdQagleZnPVT30vGe5GcWcJwF8pGXhFiUpMrbvY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iy+Zyt+UwUxf+vzgLv026Hi0M967HJDFnXHn9LnWNiWR9DWf4oMVY0GO/kMG3gU7brNp2R0L0cei/W27OtXJG0xOEdU+YRIIqkmVcccMSCwTTZoRGMYfHjiGmB4xUWxSejYrbExha6wDWtPb7pmNmyKoBMAWUn3leKIPgLMVJ6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=3plkq6QD; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707381326;
	bh=i+4EJdQagleZnPVT30vGe5GcWcJwF8pGXhFiUpMrbvY=;
	h=From:To:Cc:Subject:Date:From;
	b=3plkq6QDr0KOy28qxSuhelZKegSfVyetRK0espglhhTPRrjhskVEOF277eHOzNNhc
	 cT9FPWkDWXEMKwTZeW6tdmbDpcYNBcQI4xwZWfALjXBGLakRYhKwPboOJ1R4H6gfqI
	 D2j6rF6/afCXS2ZCg0xF299yv4kU3WCugaK0azfcIF9q+pvDF5W5ygHgH6MBobhh6m
	 fj4MEcfJ6aMiqYEMWdtwZoPQ5vsGpUwdANodbM61JLsgTvqO1APzCdpdWWOFRjd+vp
	 VRwzyvpOTTL8IvTORtJmiWsCAyBz2ssuRdi2JrX1ukKJWEfYgZ3V0hnVWDFUFRw/xb
	 ZXOoZMfrImINQ==
Received: from eugen-station.. (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: ehristev)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id 764EE3782098;
	Thu,  8 Feb 2024 08:35:21 +0000 (UTC)
From: Eugen Hristev <eugen.hristev@collabora.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	kernel@collabora.co,
	eugen.hristev@collabora.com,
	Gabriel Krisman Bertazi <krisman@collabora.com>,
	Eric Biggers <ebiggers@google.com>
Subject: [RESEND PATCH v9] ext4: Log error when lookup of encoded dentry fails
Date: Thu,  8 Feb 2024 10:35:11 +0200
Message-Id: <20240208083511.270636-1-eugen.hristev@collabora.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Gabriel Krisman Bertazi <krisman@collabora.com>

If the volume is in strict mode, ext4_ci_compare can report a broken
encoding name.  This will not trigger on a bad lookup, which is caught
earlier, only if the actual disk name is bad.

Reviewed-by: Eric Biggers <ebiggers@google.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Eugen Hristev <eugen.hristev@collabora.com>
---
Hello,

I am trying to respin the series here :
https://www.spinics.net/lists/linux-ext4/msg85081.html

To make it easier to apply I split it into smaller chunks which address
one single thing.

This patch simply adds an error message in the UNICODE path.

 fs/ext4/namei.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index 6e7af8dc4dde..7d357c417475 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -1477,6 +1477,9 @@ static bool ext4_match(struct inode *parent,
 			 * only case where it happens is on a disk
 			 * corruption or ENOMEM.
 			 */
+			if (ret == -EINVAL)
+				EXT4_ERROR_INODE(parent,
+					"Directory contains filename that is invalid UTF-8");
 			return false;
 		}
 		return ret;
-- 
2.34.1


