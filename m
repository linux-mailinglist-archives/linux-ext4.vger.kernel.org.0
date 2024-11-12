Return-Path: <linux-ext4+bounces-5094-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC8249C5F9F
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 18:57:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92795286978
	for <lists+linux-ext4@lfdr.de>; Tue, 12 Nov 2024 17:57:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0C721764F;
	Tue, 12 Nov 2024 17:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="XMoQOzrv"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FBF217442
	for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 17:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731434196; cv=none; b=EqWZtcN9Eaz40faHbAHBxG87DUxUZDJOdz3SBzH59Qsc9MqVqwNDrdFaPc+vF1h3EMka9gst7UlLLZe1VsriWkyh06BqhXa+RyK0mdr2WNpOvjk8qf20oFszjDpna/6IqfQ/HO8GlCWZQumGsBN7mQ+F04Wc9q7n0P9ESHDQe5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731434196; c=relaxed/simple;
	bh=u0ZPC8RBKGOY//W0g1jPdakQ+vbKZNphZ2gNuJs6b/U=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQbQG7kE88Iw05dRSDScMtxH+VJSYdb6kWA3EJvNjbqAac8Nl4TcLnX+lxOtO5sZEJxrzYZ1LXPXPUSVlWVxLBojbB+7ePCoeph15aKLts1P8JCS2verA1mncENaJIIvzKntIl965ZkneVP6RnWCXYcd3RkHCQpHQ6lujwYhLxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=XMoQOzrv; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e35e9e993f9so421060276.0
        for <linux-ext4@vger.kernel.org>; Tue, 12 Nov 2024 09:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1731434194; x=1732038994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c28yJdRjKgJn+HaLKJzmXzT/1RpIgNKOoAPY3XeErlk=;
        b=XMoQOzrvEsYiOUnEsMfaTLSM58Yq9sb6Q8ID0Fj0l4cr1ivMfFEH0c+/Sg5bbWo+3W
         uPK0vKSfZQM5YEOoD9mdZkdcQbDnigWN0dr7qUSmwFDwOhBqhrL0+K0K5cdDoG2Dve87
         Nf1bBla/bLmsgx7JERwMIt3LMda4dXfViF43WZ3tR0P0bxptUdjKv8TIMkhUXwVgKIKZ
         TkE02kc0y+hJlobk9S6CHZA32GoK83hZJRm7XIkJK5Bd34l/IjAofhVjSfp+9rgrhsNE
         sY1NVPhqhipn8nU3s6Nj89aADj6zW1MCZOPR+wia7OAj8rF5wo29+8bWKE6GWJkT1rQO
         2NIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731434194; x=1732038994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c28yJdRjKgJn+HaLKJzmXzT/1RpIgNKOoAPY3XeErlk=;
        b=i+EGCjLw4XNG49XWa8Mhhx4w0hmBlo5BSQqNXeUo1FbLFLrZefal2aOxFI0f0ZWxSS
         wPtD/ICfTaBu/W9oRelsz3dr00LdNgzhIkJBqbSa5X7DC/KwPRmmfXdwOXJ/PNQcNCH9
         jtiVmi0IYehpJhvUqn5B/CIURsCEISMyW5CEf80szeP+8obCSS6vY7hz1+zyxVZG6gCu
         G0dcCo3SjpUbR3CBI8HS9bjKf7dS3FZI0JqEdhh5c3Cqs8kmyhII+VsIrIN68F/A1Brg
         tJDpeOzUTeElEqtlLT9NY2m8wiBBm48IEwZfW/4/h6iixqPJhvkU1fweljVGHvHzjNNB
         k4Tg==
X-Forwarded-Encrypted: i=1; AJvYcCWf+F2B1YEnFlqgpKXvzIVW4lgB02K0ZGZN1bIYnvG9Kgr7jaiAW0ft0egiDjxKuZ8GrH6EWHoZ2dsW@vger.kernel.org
X-Gm-Message-State: AOJu0Yxf7WXjMJ23+xL2xiWUL9zdFV+MaN1lEAAiDOklSZQx4sfy/cTV
	bv/rs6hB17SHY1TFhqifSsHkqHjOHIKCVPZdBv1h1qK94D0M9duekbbTuWI75F4=
X-Google-Smtp-Source: AGHT+IGHOswKyJpRxtAUdSHm9RVyiLr7O2lKHvfik/aOxq8+Vnb458JxpogP2HSmvoOplu22cOYVQg==
X-Received: by 2002:a05:6902:728:b0:e2b:dce5:9c93 with SMTP id 3f1490d57ef6-e337f844799mr17781398276.7.1731434194365;
        Tue, 12 Nov 2024 09:56:34 -0800 (PST)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e336ef48465sm2752627276.31.2024.11.12.09.56.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 09:56:33 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
To: kernel-team@fb.com,
	linux-fsdevel@vger.kernel.org,
	jack@suse.cz,
	amir73il@gmail.com,
	brauner@kernel.org,
	torvalds@linux-foundation.org,
	linux-xfs@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-ext4@vger.kernel.org
Subject: [PATCH v7 04/18] fanotify: reserve event bit of deprecated FAN_DIR_MODIFY
Date: Tue, 12 Nov 2024 12:55:19 -0500
Message-ID: <22d02743468d137aeb73dfbc7bef44efd361785d.1731433903.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1731433903.git.josef@toxicpanda.com>
References: <cover.1731433903.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Amir Goldstein <amir73il@gmail.com>

Avoid reusing it, because we would like to reserve it for future
FAN_PATH_MODIFY pre-content event.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---
 include/linux/fsnotify_backend.h | 1 +
 include/uapi/linux/fanotify.h    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/include/linux/fsnotify_backend.h b/include/linux/fsnotify_backend.h
index 3ecf7768e577..53d5d0e02943 100644
--- a/include/linux/fsnotify_backend.h
+++ b/include/linux/fsnotify_backend.h
@@ -55,6 +55,7 @@
 #define FS_OPEN_PERM		0x00010000	/* open event in an permission hook */
 #define FS_ACCESS_PERM		0x00020000	/* access event in a permissions hook */
 #define FS_OPEN_EXEC_PERM	0x00040000	/* open/exec event in a permission hook */
+/* #define FS_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 /*
  * Set on inode mark that cares about things that happen to its children.
diff --git a/include/uapi/linux/fanotify.h b/include/uapi/linux/fanotify.h
index 34f221d3a1b9..79072b6894f2 100644
--- a/include/uapi/linux/fanotify.h
+++ b/include/uapi/linux/fanotify.h
@@ -25,6 +25,7 @@
 #define FAN_OPEN_PERM		0x00010000	/* File open in perm check */
 #define FAN_ACCESS_PERM		0x00020000	/* File accessed in perm check */
 #define FAN_OPEN_EXEC_PERM	0x00040000	/* File open/exec in perm check */
+/* #define FAN_DIR_MODIFY	0x00080000 */	/* Deprecated (reserved) */
 
 #define FAN_EVENT_ON_CHILD	0x08000000	/* Interested in child events */
 
-- 
2.43.0


