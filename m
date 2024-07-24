Return-Path: <linux-ext4+bounces-3435-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DE5593B732
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 21:07:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB4C1F22006
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Jul 2024 19:07:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9556167D8C;
	Wed, 24 Jul 2024 19:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8u86VRb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EEBC65E20;
	Wed, 24 Jul 2024 19:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721848025; cv=none; b=Rjq2PDuG/rhEy0W2DoVRr1MG6FKcHwYwEyCP8ZxaGYYbKS8kyJKsYi4NSzdrgoAp8E4l6EIUAbgZFC+uYwWOK9OfzNaET9ty3Kh+W+jVuV2JLoiM919wVYdH6RoF711h7jpHFI0r2dPrkuPeldwiUCv8v0H12Ue4+8AAFtlXJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721848025; c=relaxed/simple;
	bh=iphHr0EX7lolNkzQUwFnzeU1+uuZ9oEjhGKPWWI4urs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5sAcCxJ35OlKi9xCBSsHFzwAkC0Rq+kWnbdB9l6kiU8z8VdhCIGmkZQtgp7HNw08kvA2JRJrnVsWYmzbLnG0AbqWI6+1cFuEJwninddWtkpMnLt1Su1rVJ2ATQAR6EqucVG8Ze3kVQrs1sHpaXDdoaINxxNYw0WPC6xOEKzna4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8u86VRb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6ADCC32781;
	Wed, 24 Jul 2024 19:07:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721848024;
	bh=iphHr0EX7lolNkzQUwFnzeU1+uuZ9oEjhGKPWWI4urs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T8u86VRbowcjTD6LPdW03OXUi9ddvRyoDNDqe1X6HujEaXYOasaXHFGghPQPoGaL1
	 nHnNqt/wG7ePf8YpJkUSNoMC1JA9tdukxO76x+QGoUDfZAw3fFXAXXiFeTdrpxjf4n
	 a2QL8If1FKCN2PMIL+zsY6E5pEU05b8UVUv5crrUKu2B2uTEa7M479yJlxFqhoLf36
	 BRqo+uCEcsm7+H+g9aNfYFPax5yl/z4F7ScsSnnGk87PwZpqyNHHaY1Ep1nDsjTl1k
	 lGjVX1UQoPAvgjWusX5qMkqn6kwLzuZ2fKZKLGB/s0g2RkPnnfQfAm3UxzJXypUuv0
	 mBtvh4JCjQN9A==
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
	Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH v5.15.y 3/4] docs: Fix formatting of literal sections in fanotify docs
Date: Wed, 24 Jul 2024 15:06:22 -0400
Message-ID: <20240724190623.8948-4-cel@kernel.org>
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

[ Upstream commit 9abeae5d4458326e16df7ea237104b58c27dfd77 ]

Stephen Rothwell reported the following warning was introduced by commit
c0baf9ac0b05 ("docs: Document the FAN_FS_ERROR event").

Documentation/admin-guide/filesystem-monitoring.rst:60: WARNING:
 Definition list ends without a blank line; unexpected unindent.

Link: https://lore.kernel.org/r/87y26camhe.fsf@collabora.com
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Jan Kara <jack@suse.cz>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 .../admin-guide/filesystem-monitoring.rst     | 20 +++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/filesystem-monitoring.rst b/Documentation/admin-guide/filesystem-monitoring.rst
index 5a3c84e60095..ab8dba76283c 100644
--- a/Documentation/admin-guide/filesystem-monitoring.rst
+++ b/Documentation/admin-guide/filesystem-monitoring.rst
@@ -35,9 +35,11 @@ notifications is Ext4.
 
 A FAN_FS_ERROR Notification has the following format::
 
-  [ Notification Metadata (Mandatory) ]
-  [ Generic Error Record  (Mandatory) ]
-  [ FID record            (Mandatory) ]
+  ::
+
+     [ Notification Metadata (Mandatory) ]
+     [ Generic Error Record  (Mandatory) ]
+     [ FID record            (Mandatory) ]
 
 The order of records is not guaranteed, and new records might be added
 in the future.  Therefore, applications must not rely on the order and
@@ -53,11 +55,13 @@ providing any additional details about the problem.  This record is
 identified by ``struct fanotify_event_info_header.info_type`` being set
 to FAN_EVENT_INFO_TYPE_ERROR.
 
-  struct fanotify_event_info_error {
-	struct fanotify_event_info_header hdr;
-	__s32 error;
-	__u32 error_count;
-  };
+  ::
+
+     struct fanotify_event_info_error {
+          struct fanotify_event_info_header hdr;
+         __s32 error;
+         __u32 error_count;
+     };
 
 The `error` field identifies the type of error using errno values.
 `error_count` tracks the number of errors that occurred and were
-- 
2.45.2


