Return-Path: <linux-ext4+bounces-10064-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C327B587A7
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Sep 2025 00:40:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43FAD7A9CD7
	for <lists+linux-ext4@lfdr.de>; Mon, 15 Sep 2025 22:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D732D47E7;
	Mon, 15 Sep 2025 22:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ixohDzRX"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D620A2D23A4
	for <linux-ext4@vger.kernel.org>; Mon, 15 Sep 2025 22:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757976051; cv=none; b=nrtg0nsHT+4UD8fv0wFMKU/b3fmYLksZQzwHoD/ox71hajIESkO44IucMeo5XGZcx/LZCuVEfvckkPZaiDwXLWPnS+BeKT1Y7yOIA4+f9uw4srGVbhQ/5jqBOwBWn3yB+UER59GYl4Fld9dmOLjGBw3aW12/3RzgWc8iu0C0Gos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757976051; c=relaxed/simple;
	bh=bYTXNOoKbKBww0fGWz7S+FrC6l9N80iJFfUSaXTm6Vo=;
	h=Date:Subject:From:To:Cc:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c54WFQSXoOFf2EtVx5Z9l2BEDrX/kt4t3DfiY1vs4H05qZyv1k8A0hxqJq3tOwD71KxQG4DJ6a3FEHKiwg4h3PG9gDNmSeYLm68dIbicJAWNLTCkRowOCrS0zVOxvFKuCWZp98zeI/NHiWLhsOVm+ijse8oTeHn5UU/g4rX+WQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ixohDzRX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6156AC4CEF1;
	Mon, 15 Sep 2025 22:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757976051;
	bh=bYTXNOoKbKBww0fGWz7S+FrC6l9N80iJFfUSaXTm6Vo=;
	h=Date:Subject:From:To:Cc:In-Reply-To:References:From;
	b=ixohDzRX6Mg8fAoH6mlYhZDGaARQfldXfSjU8cv4bMjkRBfVwM6seX7V9qCAyhcZj
	 7lmDZuYYyg4ut7JTmPIIbP6gNNXf5mVK1O+o0cjvX+98wEDppVdzKruew5uPD5etIT
	 18t0c6pRD6yydM3uvf9WU7dUteBRkl9QLct9FKNL7jxYKWCCQJLQhhleiNAzIELBnv
	 xhnjD8PE8EXMqYTIRXUVZD8oYAvLHClZ3LBJHmrr4Ipg+FuPnbLQ0+sELwK2l8G46g
	 DfSVyzRNezfZBlmYfn+4co7q+WsmmJpXhvBqjtU/gAp82RJxLIYWIDc2XkL8oDXjZ0
	 4Ym4a3HPAtN+w==
Date: Mon, 15 Sep 2025 15:40:50 -0700
Subject: [PATCH 12/12] fuse2fs: check free space when creating a symlink
From: "Darrick J. Wong" <djwong@kernel.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, linux-ext4@vger.kernel.org
Message-ID: <175797569835.245695.17963678318721637704.stgit@frogsfrogsfrogs>
In-Reply-To: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
References: <175797569564.245695.4628729304068635201.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Darrick J. Wong <djwong@kernel.org>

Make sure we have enough space to create the symlink and its remote
block.

Cc: <linux-ext4@vger.kernel.org> # v1.43
Fixes: 81cbf1ef4f5dab ("misc: add fuse2fs, a FUSE server for e2fsprogs")
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
---
 misc/fuse2fs.c |    4 ++++
 1 file changed, 4 insertions(+)


diff --git a/misc/fuse2fs.c b/misc/fuse2fs.c
index c09b2aa04c02fb..569ac402427767 100644
--- a/misc/fuse2fs.c
+++ b/misc/fuse2fs.c
@@ -1825,6 +1825,10 @@ static int op_symlink(const char *src, const char *dest)
 	*node_name = 0;
 
 	pthread_mutex_lock(&ff->bfl);
+	if (!fs_can_allocate(ff, 1)) {
+		ret = -ENOSPC;
+		goto out2;
+	}
 	err = ext2fs_namei(fs, EXT2_ROOT_INO, EXT2_ROOT_INO, temp_path,
 			   &parent);
 	*node_name = a;


