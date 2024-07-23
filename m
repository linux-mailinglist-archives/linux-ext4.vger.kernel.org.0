Return-Path: <linux-ext4+bounces-3394-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA1793A8CE
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 23:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC7B7281B1F
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jul 2024 21:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61485145FE2;
	Tue, 23 Jul 2024 21:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pCvVmba0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD57813D503;
	Tue, 23 Jul 2024 21:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721770981; cv=none; b=XUomMNA49XgmqPhh9/qlZjTFYrTiEBZ3PHSIT72Mhss33aiwFnrm4Udu5GXfXcFMs94xzXl6Ja3QeGV7Qp6xZCX3S6inHEVz1Lp9oX4snFgsXUVZTN8TUsIf/OtIDgUQMozkdxvxKViwjbmcaGFrf1/TGJFwjcfuAC5bxNp+3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721770981; c=relaxed/simple;
	bh=BqY4zdlIC8KxqEyGDovO+UDlazzrtr00MyipE6wLIa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=apsuMPHX8nrvLV2vX8+9rC3v9SNQE1RZxV4BrmQw+sdyRah4S746WF6B+F6oihQ0Rdlx8M0ITeKE7gRTfg7CblD6+zS/gYR7VddI0HVgaikbvaF/Tb0fpZDq1r3ttab0XHJcYTCHq9EIzeiB2jXmjX7wLdfYLWfDoUh3Kb2jgRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pCvVmba0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FD42C4AF09;
	Tue, 23 Jul 2024 21:42:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721770980;
	bh=BqY4zdlIC8KxqEyGDovO+UDlazzrtr00MyipE6wLIa4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pCvVmba0MiYHAVK4sYnBmaD5jKJfqCbSzgSTL3X44ZcaiDYnSaQX3nV0Pauntco0m
	 RcLpZrHmtU+D2QULoSgCZ7cF6FqNSGuiEFSsk68H4zZXSgvvrpXRlLbAmhok5nAwRS
	 ZnyTsZfy3127gO3pwgIs7bxHfPBzc8P4Id11FhUgz0tKvLLq1NbNdtiJIit8p/VCe6
	 pyn9KQix5PGxxGEYakJ2IuiKgEz/DZOTao8zkgbssUkQa+1yCrQYvK6lW0ZbI04FXj
	 ZcRSt/k5sZuz1nwEugWgqZYEiZjpd3lcMNZKRsJURnNDN+1HnqFTDp0/Ro8qo9u9r2
	 VghOVXSKFdJ4A==
From: cel@kernel.org
To: amir73il@gmail.com,
	gregkh@linuxfoundation.org,
	jack@suse.cz,
	sashal@kernel.org,
	stable@vger.kernel.org,
	adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	alexey.makhalov@broadcom.com,
	vasavi.sirnapalli@broadcom.com,
	florian.fainelli@broadcom.com
Cc: Chuck Lever <chuck.lever@oracle.com>,
	Gabriel Krisman Bertazi <gabriel@krisman.be>
Subject: [PATCH v5.15.y] Revert "fanotify: Allow users to request FAN_FS_ERROR events"
Date: Tue, 23 Jul 2024 17:42:46 -0400
Message-ID: <20240723214246.4010-1-cel@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <875xswtbxb.fsf@mailhost.krisman.be>
References: <875xswtbxb.fsf@mailhost.krisman.be>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chuck Lever <chuck.lever@oracle.com>

Gabriel says:
> 9709bd548f11 just enabled a new feature -
> which seems against stable rules.  Considering that "anything is
> a CVE", we really need to be cautious about this kind of stuff in
> stable kernels.
>
> Is it possible to drop 9709bd548f11 from stable instead?

The revert wasn't clean, but adjusting it to fit was straightforward.
This passes NFSD CI, and adds no new failures to the fanotify ltp
tests.

Reported-by: Gabriel Krisman Bertazi <gabriel@krisman.be>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/notify/fanotify/fanotify_user.c | 4 ----
 include/linux/fanotify.h           | 6 +-----
 2 files changed, 1 insertion(+), 9 deletions(-)

Gabriel, is this what you were thinking?


diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index d93418f21386..0d91db1c7249 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -1701,10 +1701,6 @@ static int do_fanotify_mark(int fanotify_fd, unsigned int flags, __u64 mask,
 	    group->priority == FS_PRIO_0)
 		goto fput_and_out;
 
-	if (mask & FAN_FS_ERROR &&
-	    mark_type != FAN_MARK_FILESYSTEM)
-		goto fput_and_out;
-
 	/*
 	 * Evictable is only relevant for inode marks, because only inode object
 	 * can be evicted on memory pressure.
diff --git a/include/linux/fanotify.h b/include/linux/fanotify.h
index 558844c8d259..df60b46971c9 100644
--- a/include/linux/fanotify.h
+++ b/include/linux/fanotify.h
@@ -97,13 +97,9 @@ extern struct ctl_table fanotify_table[]; /* for sysctl */
 #define FANOTIFY_INODE_EVENTS	(FANOTIFY_DIRENT_EVENTS | \
 				 FAN_ATTRIB | FAN_MOVE_SELF | FAN_DELETE_SELF)
 
-/* Events that can only be reported with data type FSNOTIFY_EVENT_ERROR */
-#define FANOTIFY_ERROR_EVENTS	(FAN_FS_ERROR)
-
 /* Events that user can request to be notified on */
 #define FANOTIFY_EVENTS		(FANOTIFY_PATH_EVENTS | \
-				 FANOTIFY_INODE_EVENTS | \
-				 FANOTIFY_ERROR_EVENTS)
+				 FANOTIFY_INODE_EVENTS)
 
 /* Events that require a permission response from user */
 #define FANOTIFY_PERM_EVENTS	(FAN_OPEN_PERM | FAN_ACCESS_PERM | \
-- 
2.45.2


