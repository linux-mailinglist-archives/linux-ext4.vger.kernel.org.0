Return-Path: <linux-ext4+bounces-10897-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21934BE44FE
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 17:44:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F3D73B39EC
	for <lists+linux-ext4@lfdr.de>; Thu, 16 Oct 2025 15:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB9134F470;
	Thu, 16 Oct 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cKu4xxBD"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EDE934F46C
	for <linux-ext4@vger.kernel.org>; Thu, 16 Oct 2025 15:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760629266; cv=none; b=jRp2DVeA8JlFOm+vEi7USR5B1m7GMLBoa6UDlNXwrwawCaK7dRdXL4bRhwPbCBC4iKSRcDZGIz570In82ZaOqnqmBnPu0AerF63CJwj7yvpS8D5lcNL1t2uHNRfhS8lULUBDzma4rrXhE2Z/nVjSifdbaMjdRuAmpRJOM6aXxgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760629266; c=relaxed/simple;
	bh=A1Ci0tCHr1rwlUhKWkCioZZ0jHfyIFMKZT1yaGNvtHg=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F6q9lqeB3n+hCpcM4S98fIXv7buA3cePYAgsY8SlZTNyw/cspBO8giS/pmc3fKR/For9VrhrlFNhb7oVPYQ3tvtxzhvFNjqMG8nkM40z40lxuVwDUWaiad06vR3uMN/qjke1GWlVJfbG7l2EB5hHQ7d3J4PAayoJW71PXk9WMCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cKu4xxBD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43B94C4CEF1;
	Thu, 16 Oct 2025 15:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760629266;
	bh=A1Ci0tCHr1rwlUhKWkCioZZ0jHfyIFMKZT1yaGNvtHg=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=cKu4xxBDpUgvv7J947eMuUgpfXqzBLegKZue/Z1um6WdIAi72dLXJDPIELyoj707i
	 CeS4G99dw7ZEtiOLP6YKhURsZIIp2PvT2ykJC/CQymJH2sT7kSdxAPw5CzKoDjUFKi
	 KKugqLq0OPQPapKX9RhIQ3mt0Hig0WNN/CWa1KXJ57ASXzuKD0vsAP/mksXsLh6W0z
	 42Tg0AiTd6Eu3cJm5rSSLcWEeemD7a0LhaeVhqusjhWlMX6Ssaql6ji03QyQf7MjkP
	 xIpyl5e4JKZN21n6zVyYxoWdXDPm74ixMJ5Bl/+Yo2+QOuwqikAGLRuIojvebIxa/J
	 mPSX+WD+uMJug==
Date: Thu, 16 Oct 2025 08:41:05 -0700
Subject: [PATCH 05/16] libext2fs: the unixfd IO manager shouldn't close its fd
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <176062915555.3343688.7371766123646609605.stgit@frogsfrogsfrogs>
In-Reply-To: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
References: <176062915393.3343688.9810444125172113159.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

The unixfd IO manager didn't create the fd that was passed in, so it
should not close the fd when the io channel closes.

Cc: <linux-ext4@vger.kernel.org> # v1.43.2
Fixes: 4ccf9e4fe165cf ("libext2fs: add unixfd_io_manager")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 lib/ext2fs/unix_io.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)


diff --git a/lib/ext2fs/unix_io.c b/lib/ext2fs/unix_io.c
index 723a5c2474cdd5..1456b4d4bbe212 100644
--- a/lib/ext2fs/unix_io.c
+++ b/lib/ext2fs/unix_io.c
@@ -1061,7 +1061,7 @@ static errcode_t unix_open_channel(const char *name, int fd,
 
 cleanup:
 	if (data) {
-		if (data->dev >= 0)
+		if (io->manager != unixfd_io_manager && data->dev >= 0)
 			close(data->dev);
 		if (data->cache) {
 			free_cache(data);
@@ -1147,7 +1147,7 @@ static errcode_t unix_close(io_channel channel)
 	retval = flush_cached_blocks(channel, data, 0);
 #endif
 
-	if (close(data->dev) < 0)
+	if (channel->manager != unixfd_io_manager && close(data->dev) < 0)
 		retval = errno;
 	free_cache(data);
 	free(data->cache);


