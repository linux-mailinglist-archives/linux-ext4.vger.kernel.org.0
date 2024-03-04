Return-Path: <linux-ext4+bounces-1499-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD50F8707D6
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 18:01:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DF9121C235BC
	for <lists+linux-ext4@lfdr.de>; Mon,  4 Mar 2024 17:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EBC9604AF;
	Mon,  4 Mar 2024 17:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="ftkDgRLz"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0A6A5FBB0
	for <linux-ext4@vger.kernel.org>; Mon,  4 Mar 2024 17:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709571677; cv=none; b=SEzQ2vgDGmFZVbrWaWL7jyj6yFCARyEzj5sX9oWtfKbYnSvwN+gqEoA7yRbNc9GExLPG8yg7UVwXBL4PVKRIGGpSlqR0rg0IcK/mysfD1kTTx4aIjSaN5rRnXNMbpnvKu0jLDR35k6CTkdlPp8GTUTjvnyfOLMYjRHDO8nw2nS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709571677; c=relaxed/simple;
	bh=Y1hODsyOTqk2qNlu5XLNFWyxBpWwax0wrwGYV8h0bf8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jc8pScauEG3XI+tADOpMG5G3Q1c7Uus/OhB6q+JXyOvUfyCa0oWPkPUfhmVV2xOFN1J9nRrGJbG1QSfAXl9lT59LguqdnqJndWjyTn7X57Qt9u4vBmGwaurkKxcEO+O2TmKvMVJMG5WzWjbLMbAOhwWWNbEOHTU1NAqTqp/hMwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=ftkDgRLz; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-412e6ba32easo5883885e9.0
        for <linux-ext4@vger.kernel.org>; Mon, 04 Mar 2024 09:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1709571674; x=1710176474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s/uotU1HGCeXUT4H5saUqikW28hMXwwL7oNQgmFD0EY=;
        b=ftkDgRLzdt3TOkpuSPtEhIa8mNuW44Q1s/dMB9989NckTQdAQOTkHz8VkbjJfgtBcN
         OOuUZy/qAeJ6l9Ml/MopbxazrybNVMvVekbKFcdc2qv1hs5cBSs24zl3vpVKHdI6PGEU
         YzVnE/Y+Tldeq5YJizSLoExKhEucKfdnmD1NyA/ZUXnqHaqwBvt46fqGOQ8MxQ1JLOmg
         gIR0NZrQnqe+pnqVNgM1xkWoQC8h2yu7VFMlxgp4B4ZsDdk8Cvy9lGIRWjxqqOyQsK3S
         h3vyeTQhvAq8w/6NeELLB7eLSVoTqWZIRV8h+DG275N9IldIeAD268Prr91OR15hJlW6
         Gl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709571674; x=1710176474;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s/uotU1HGCeXUT4H5saUqikW28hMXwwL7oNQgmFD0EY=;
        b=opUMpaTF+eQQ/N+y3NytAr3uKxA/NIG6e617E2chaE/OBdtXgJ9NVvkHkvNYRHgpKB
         lm7NC0zcVdM++0Y2sLs8rs4wnsAOfOuXoFsM147KM+zJzuAoiwhr/QuiAO057JjKpjPw
         7B6fS/WeAGEX50sOK9pRauDzsO6yiqVdByuQyJkv/K5VimyBpQ3mpeqyyoJaJgWAzKgp
         vVqLEhz1p0wi1kIdXl4z8Qf/DFnvfGShkGXDyvU5z8lGGmBUXeLpxmlsTTXfqDiH2+ms
         LoIk9cQhbgKZoXeWYHqWrtaMQl51/T9UjBpU572be2Ikm5cgb65BkmEy/rVT1tm0T4fZ
         TgkA==
X-Gm-Message-State: AOJu0YweibnuMzy+75itNtgb5uWz5/7kT0PoqZ+WTrpkH6XDHRzD5j2l
	/fKqhSWryJ+8tqU+u/iOAH8jyaMjSS4vAu4fFBJ+HyfKJvPLg9EXs+DcNqjO2NVxhNJe9gMtbsZ
	mK5k=
X-Google-Smtp-Source: AGHT+IGZzfhyMUkVQDEbxidUeo+sp6ipbXiw/f98kRVENVpcTyhXxPwrE0AypKvSiUcuMEpZK88sqQ==
X-Received: by 2002:a05:600c:458f:b0:412:bfa1:2139 with SMTP id r15-20020a05600c458f00b00412bfa12139mr6919053wmo.37.1709571674138;
        Mon, 04 Mar 2024 09:01:14 -0800 (PST)
Received: from fedora.fritz.box (aftr-82-135-80-152.dynamic.mnet-online.de. [82.135.80.152])
        by smtp.gmail.com with ESMTPSA id i4-20020a05600c354400b004101f27737asm18520049wmq.29.2024.03.04.09.01.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 09:01:13 -0800 (PST)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] ext4: Remove unneeded if checks before kfree
Date: Mon,  4 Mar 2024 17:55:08 +0100
Message-ID: <20240304165507.156076-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kfree already checks if its argument is NULL. This fixes two
Coccinelle/coccicheck warnings reported by ifnullfree.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 fs/ext4/super.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0f931d0c227d..9b7a0b4f2d3d 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -2079,8 +2079,7 @@ static int unnote_qf_name(struct fs_context *fc, int qtype)
 {
 	struct ext4_fs_context *ctx = fc->fs_private;
 
-	if (ctx->s_qf_names[qtype])
-		kfree(ctx->s_qf_names[qtype]);
+	kfree(ctx->s_qf_names[qtype]);
 
 	ctx->s_qf_names[qtype] = NULL;
 	ctx->qname_spec |= 1 << qtype;
@@ -2485,8 +2484,7 @@ static int parse_options(struct fs_context *fc, char *options)
 			param.size = v_len;
 
 			ret = ext4_parse_param(fc, &param);
-			if (param.string)
-				kfree(param.string);
+			kfree(param.string);
 			if (ret < 0)
 				return ret;
 		}
-- 
2.44.0


