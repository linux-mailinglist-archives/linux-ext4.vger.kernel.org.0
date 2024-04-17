Return-Path: <linux-ext4+bounces-2131-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF108A839C
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 15:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC4321C21EE3
	for <lists+linux-ext4@lfdr.de>; Wed, 17 Apr 2024 13:01:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D2C813D2BD;
	Wed, 17 Apr 2024 13:01:20 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from zenith (plouf.fr.eu.org [213.41.155.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D8684DF6
	for <linux-ext4@vger.kernel.org>; Wed, 17 Apr 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.41.155.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713358880; cv=none; b=herKWq7NX2XePRIABnOSZ//ROBZ+qU2H2NWM9p/BVN5iHZCd9i/Qiam6X6DRVCqaKaXv6y+ka75l5rsPyNM3VWuAbmgdFi6ZUeQx+EuaNvyLOlD4FVg55Eo2Xc2622Orpsvjpc0r8Ku4sCp2C32YkxnQyzZkuYu5oQol2qvEbM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713358880; c=relaxed/simple;
	bh=ek1c/hCbyqp86pL/u1a5SLcMSXjleLPnPjgURcO5Jlw=;
	h=From:To:Date:Subject:Message-Id; b=NO2otDVGMqJHFVlZQZhe+a3vXYX3uIReFd/FciBvJqtymCM155nsaX1e4RaIGbmoV2LitCR2ePsK38XpnAq9tkz1BfNWbKt2W4lTogrxYCB9DwuQupG7IqDbNU4HiaqOZGWpBlXc0SqIVCe2VFb27B3Hu1qJPdWt43ArGgfX1aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plouf.fr.eu.org; spf=pass smtp.mailfrom=plouf.fr.eu.org; arc=none smtp.client-ip=213.41.155.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=plouf.fr.eu.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=plouf.fr.eu.org
Received: from [192.168.0.252] (helo=chantecler)
	by zenith with esmtp (Exim 4.89)
	(envelope-from <pascal@plouf.fr.eu.org>)
	id 1rx4t4-00073d-1e; Wed, 17 Apr 2024 15:01:11 +0200
From: Pascal Hambourg <pascal@plouf.fr.eu.org>
To: <linux-ext4@vger.kernel.org>
Date: Wed, 17 Apr 2024 13:48:22 +0200
Subject: [PATCH] e2fsprogs: misc/mke2fs.8.in: Update default inode size description
Message-Id: <E1rx4t4-00073d-1e@zenith>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>

Since a23b50cd ("mke2fs: warn about missing y2038 support when
formatting fresh ext4 fs"), the default inode size is 256 bytes
for all filesystems, including small and floppy, except for the
Hurd since it currently only supports 128-byte inodes.

Signed-off-by: Pascal Hambourg <pascal@plouf.fr.eu.org>
---
 misc/mke2fs.8.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/misc/mke2fs.8.in b/misc/mke2fs.8.in
index 30f97bb5..8122e7f7 100644
--- a/misc/mke2fs.8.in
+++ b/misc/mke2fs.8.in
@@ -508,8 +508,8 @@ The default inode size is controlled by the
 file.  In the
 .B mke2fs.conf
 file shipped with e2fsprogs, the default inode size is 256 bytes for
-most file systems, except for small file systems where the inode size
-will be 128 bytes.
+all file systems, except for the GNU Hurd since it only supports
+128-byte inodes.
 .TP
 .B \-j
 Create the file system with an ext3 journal.  If the
-- 
2.39.2

