Return-Path: <linux-ext4+bounces-8826-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB917AF9E33
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Jul 2025 05:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4348A7A12EE
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Jul 2025 03:37:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2154214D29B;
	Sat,  5 Jul 2025 03:38:42 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from net153.net (unknown [216.82.153.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD60617BCE
	for <linux-ext4@vger.kernel.org>; Sat,  5 Jul 2025 03:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.82.153.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751686721; cv=none; b=QTidBFQE3y71kFU+oDa4jV3+FbbKJhpPsT2eEqIHyWbJ6tf8TIspYqNwktHK+6+aMfN57mvgLJ5f269szreOwhACKHl+RhcxLkpXHiS1fejA5yGEvtmTNMiPJjjtJqBN3qRNj4clnP9dgfCmz4aOo4yY4mGrC0qI/o8DBOTh87I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751686721; c=relaxed/simple;
	bh=+HO67CVlSqYGahtjKLQf+SjTHP4ZpfjXuO6+zF8YHy0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=X/hUpO9XYEZggCacPLsUP/B380Mn0E3M1l7bDoUrVnryZWE3D9ZQDOWKmxzOKIP4fFLh0EhxzYJDI3SUcUpjrz7pZw+VvpUy6AXkEGzdi/BquY3zW+ZFk0U1lARzo1m8Mxv2Jvu8Yjyb/RWZKUkfrxFT2enqyB2p4J+LJ/AkKE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net153.net; spf=pass smtp.mailfrom=net153.net; arc=none smtp.client-ip=216.82.153.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net153.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net153.net
Received: from t14.. (unknown [IPv6:2604:af80:3044:f8e1:db36:2587:57ca:42c2])
	by net153.net (Postfix) with ESMTP id E4B1B1CD;
	Fri,  4 Jul 2025 22:38:30 -0500 (EST)
From: Samuel Smith <satlug@net153.net>
To: linux-ext4@vger.kernel.org
Cc: tytso@mit.edu,
	Samuel Smith <satlug@net153.net>
Subject: [PATCH] e2scrub: reorder exit status check after calling lvremove
Date: Fri,  4 Jul 2025 22:38:21 -0500
Message-Id: <20250705033821.3695205-1-satlug@net153.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Checking for snapshot device existence resets the status code in $?.
Reording the conditions will allow the retry loop to work properly.

Signed-off-by: Samuel Smith <satlug@net153.net>
---
 scrub/e2scrub.in | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scrub/e2scrub.in b/scrub/e2scrub.in
index 043bc12b..6f9b5ce2 100644
--- a/scrub/e2scrub.in
+++ b/scrub/e2scrub.in
@@ -182,7 +182,7 @@ snap_dev="/dev/${LVM2_VG_NAME}/${snap}"
 teardown() {
 	# Remove and wait for removal to succeed.
 	${DBG} lvremove -f "${LVM2_VG_NAME}/${snap}"
-	while [ -e "${snap_dev}" ] && [ "$?" -eq "5" ]; do
+	while [ "$?" -eq "5" ] && [ -e "${snap_dev}" ]; do
 		sleep 0.5
 		${DBG} lvremove -f "${LVM2_VG_NAME}/${snap}"
 	done
@@ -210,7 +210,7 @@ setup() {
 	# Try to remove snapshot for 30s, bail out if we can't remove it.
 	lvremove_deadline="$(( $(date "+%s") + 30))"
 	${DBG} lvremove -f "${LVM2_VG_NAME}/${snap}" 2>/dev/null
-	while [ -e "${snap_dev}" ] && [ "$?" -eq "5" ] &&
+	while [ "$?" -eq "5" ] && [ -e "${snap_dev}" ] &&
 	      [ "$(date "+%s")" -lt "${lvremove_deadline}" ]; do
 		sleep 0.5
 		${DBG} lvremove -f "${LVM2_VG_NAME}/${snap}"
-- 
2.39.5


