Return-Path: <linux-ext4+bounces-8688-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9632AEC51F
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 07:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569051C20659
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jun 2025 05:14:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2882521CC64;
	Sat, 28 Jun 2025 05:14:37 +0000 (UTC)
X-Original-To: linux-ext4@vger.kernel.org
Received: from net153.net (unknown [216.82.153.212])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47A21B908
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 05:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.82.153.212
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751087676; cv=none; b=mGMapwLP3kcHal4vkQ+846QDGhLd61a5vaaBBJXWUbqHysf1TmzOzd35obezaTEK/ux772FaOziHOSnz3TiV9QNtXSjzU22gp7095XyBTFuRn+FbdvvkRr0F/IyukZi51dc2ZWYErbNNni/mXkBw/tXozcbcpqA0I6SoshCfyfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751087676; c=relaxed/simple;
	bh=qXpnFkkCcwUvi5Q/cm+q/QXOJk2MgF0e6z++6+gq/Js=;
	h=From:To:Subject:Date:Message-Id:MIME-Version; b=ALs7oofvndL/L44VJ3MVt4DhJSfr3oYipH5JIOwP5d+v+kOflxVH9lmhq+/HFVKRe5+GfW1N8FlqhJV8XjLrf7MR+QSiAXG2TqytvOFnvkXRG76uA1WP6mcSY1ueraWG6WeIaKLyGGvPhVcE8HewLEKjUBvELa/jZNsJUR9NJbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net153.net; spf=pass smtp.mailfrom=net153.net; arc=none smtp.client-ip=216.82.153.212
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net153.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net153.net
Received: from t14.. (unknown [IPv6:2604:af80:3044:f8e1:91c8:deac:ac19:9fc0])
	by net153.net (Postfix) with ESMTP id 83180671
	for <linux-ext4@vger.kernel.org>; Sat, 28 Jun 2025 00:14:27 -0500 (EST)
From: Samuel Smith <satlug@net153.net>
To: linux-ext4@vger.kernel.org
Subject: [PATCH] e2scrub: honor fstrim setting in e2scrub.conf
Date: Sat, 28 Jun 2025 00:14:15 -0500
Message-Id: <20250628051415.3015410-1-satlug@net153.net>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The systemd service unconditionally passes -t to e2scrub, forcing
fstrim to run after every scrub regardless of the fstrim setting
in /etc/e2scrub.conf. Removing the hardcoded flag will allow users to
control the behavior via the configuration file.

Signed-off-by: Samuel Smith <satlug@net153.net>
---
 scrub/e2scrub@.service.in | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scrub/e2scrub@.service.in b/scrub/e2scrub@.service.in
index 6425263c..3c9893c5 100644
--- a/scrub/e2scrub@.service.in
+++ b/scrub/e2scrub@.service.in
@@ -16,5 +16,5 @@ User=root
 IOSchedulingClass=idle
 CPUSchedulingPolicy=idle
 Environment=SERVICE_MODE=1
-ExecStart=@root_sbindir@/e2scrub -t %f
+ExecStart=@root_sbindir@/e2scrub %f
 SyslogIdentifier=%N
-- 
2.39.5


