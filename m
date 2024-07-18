Return-Path: <linux-ext4+bounces-3319-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AE293515D
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2024 19:52:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 029D8281E17
	for <lists+linux-ext4@lfdr.de>; Thu, 18 Jul 2024 17:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDBAE14535F;
	Thu, 18 Jul 2024 17:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="maM4bxWu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB433144D37
	for <linux-ext4@vger.kernel.org>; Thu, 18 Jul 2024 17:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721325131; cv=none; b=cTTtl6itmaR1TkJXnr+T3vvZY1C7gTp8VW7B9qx1QIKeQFmHpRmIeWLiSH9FFfTvaIXPWjuGjotC1XeEq5rcWnIlcijF70HPgcTFjj4RNZDjO6L8kb1L0aFNGIpXAItHEQVXb/0Ha/q7bGrYBKNkvsmVkyFkuderOgzvnPOIjRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721325131; c=relaxed/simple;
	bh=JDne91vBlQuz2wK9jid67VPBUuVFaDf60urM/BN/G8c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=thN6bHqqXZJYomkczDG/bdwlGwhtBuV4mUphR98eoVBi7r2Xdm1gcpEKOENp2zZDptqdqtRPUPaUrKDhtHcEfeMZ00EqibFf46mRldb5Pg7+wTS3kjzp01X4qC2g52PjH5UXdKDUMSsJhVBICFnHn0T8Oyqn1dFCXA76t7A+7Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=maM4bxWu; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-75c5bdab7faso722381a12.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Jul 2024 10:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1721325129; x=1721929929; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=c+qb8ZB4KX4nV9rrY3tw38d7rphn9daa9DIZucNXE9Q=;
        b=maM4bxWuJe+n4tw4uovWQkXhdlo3II8wKDoue/jqXdOmyGlNrS3WgYdbQzR1pUomi8
         4XcxelqIPzOYrvBvntDKIxjmrzm7bhfHM99JOld4mh3uI7k1fzTgqpGGd1zGWpTT3KqX
         QJLkTMQkEMKE2PTtQt7edwaC5WmA9mlsEwUA0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721325129; x=1721929929;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c+qb8ZB4KX4nV9rrY3tw38d7rphn9daa9DIZucNXE9Q=;
        b=pwqlQIcs9oeph/XbezocQkr22/AGexqRd7SQGycBoLqfsdIwHsMY+1/2URgqMu4hob
         P16XA2uj4risAVHUIqqFsYjcQu2nOKHoqF+/D2VTDAGss51zV+izyvcqkFFqjobFiHE8
         eTCKlMmZAciW14m4k/s0t+6Dujsy3GQpbX5lLYKd3FtY35khbFPSoIxhSlrvpgg/pRZY
         xv3Fu+BqDkmnuV97ea+OU+nmuAWezfCmn+39hmxc7lVAjCeAJxUXwPvY5YfWCCpBxh87
         xZHnCXNl7uS+ay19qL8xdJSK+p0/azHiqXlCkHB5f8xN9NossLc1tHwxVfjRe8qN4nNa
         J7ww==
X-Gm-Message-State: AOJu0YxN/g9zz9mXDWxH6nosT67h40tLO4A8bEK3SpJUB/8U2DBcYot6
	mQsyE7gki1DgfT5xPTOwG/Hn9EURMBeEoVCg0slAGPH5LpNHZKhW+HsO76Dvmw==
X-Google-Smtp-Source: AGHT+IHCJLy/Neo28CHmpNSzYZAncSuuxbTCXTxsK3aHs3j6UEhyxjbxlZf+9O2v+WItCPvirl5oPA==
X-Received: by 2002:a05:6a20:7483:b0:1c3:b1e6:d27f with SMTP id adf61e73a8af0-1c3fdd995b6mr7658361637.46.1721325129291;
        Thu, 18 Jul 2024 10:52:09 -0700 (PDT)
Received: from localhost ([2620:15c:9d:2:df7c:d80e:c39f:3412])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-1fc0bb7020asm95771005ad.1.2024.07.18.10.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Jul 2024 10:52:08 -0700 (PDT)
From: Gwendal Grignou <gwendal@chromium.org>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org,
	Gwendal Grignou <gwendal@chromium.org>
Subject: [PATCH] tune2fs.c (main): do not set dirty when default is not changed
Date: Thu, 18 Jul 2024 10:52:04 -0700
Message-ID: <20240718175204.1590917-1-gwendal@chromium.org>
X-Mailer: git-send-email 2.45.2.1089.g2a221341d9-goog
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the default group is not modified, don't set the superblock
dirty bit.

Similar to commit 2eb3b20e80, it speeds up `tunefs -g` command when
the group argument is identical.
---
 misc/tune2fs.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/misc/tune2fs.c b/misc/tune2fs.c
index 8ae13705..facc8dc9 100644
--- a/misc/tune2fs.c
+++ b/misc/tune2fs.c
@@ -3382,9 +3382,13 @@ _("Warning: The journal is dirty. You may wish to replay the journal like:\n\n"
 		printf(_("Setting error behavior to %d\n"), errors);
 	}
 	if (g_flag) {
-		sb->s_def_resgid = resgid;
-		ext2fs_mark_super_dirty(fs);
-		printf(_("Setting reserved blocks gid to %lu\n"), resgid);
+		if (sb->s_def_resgid != resgid) {
+			sb->s_def_resgid = resgid;
+			ext2fs_mark_super_dirty(fs);
+			printf(_("Setting reserved blocks gid to %lu\n"), resgid);
+		} else {
+			printf(_("Reserved blocks gid already set to %lu\n"), resgid);
+		}
 	}
 	if (i_flag) {
 		if ((unsigned long long)interval >= (1ULL << 32)) {
-- 
2.45.2.1089.g2a221341d9-goog


