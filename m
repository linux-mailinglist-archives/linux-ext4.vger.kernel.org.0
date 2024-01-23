Return-Path: <linux-ext4+bounces-866-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80D82837DD8
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jan 2024 02:30:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FE83287863
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Jan 2024 01:30:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FA0215EA97;
	Tue, 23 Jan 2024 00:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iQ77wHzx"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FAA51386CD
	for <linux-ext4@vger.kernel.org>; Tue, 23 Jan 2024 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705970172; cv=none; b=cTyf6o++Rh62IFn/q3aIetbHDedllvKJ9qX196NVQiFRja0ZbqCJpSozFzOTUV8v9y2MBWu1yG9lv8N+M6kEMeZ5bcN6DQSOc8sXfIIx7ezs2K6zLFmaPIBpRKEVa55PA/HF8TFMncTa8yiohSR0xIzySKgzicDRO2nz/DBYRVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705970172; c=relaxed/simple;
	bh=XxURT38No80Bn/RVyeHb/5pbIxR90+R/SV2DoW19O2Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=MZrLDPTEUbJesTgPQuZFRO661WzxpXtY/1AjCveLpYOY8Tpkz7of67OLLMAeWFPJsobxnBPQtE2KL6dL5uZCHu7aDyCnr16yV8poR4Hi3DfQoEsO/CIaV+QK2RCwzq6OkobTnKGrsl7N11uko0gXWH8aw87mZso0VgpodTODskE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iQ77wHzx; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ce942efda5so2940707a12.2
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jan 2024 16:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705970170; x=1706574970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7puUcGGiErwlKQZQ/SVSg/vEPPE1AYFaDc22KRy1Uww=;
        b=iQ77wHzxsFB+ydAFWfKd+S/XZ+LypsaJmGoppSMp2hAGydQMfRxG31/YagWh0byQsk
         QvLJk/9wZtwQEIGbq+lNocPiC5KcilJyOv7zSifiXQapjk1jwIDfy44Zxrlwh0cOn1nn
         xaHbG76YcTadqtXDhFk3LcavzP+Oy0xWFTP9g=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705970170; x=1706574970;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7puUcGGiErwlKQZQ/SVSg/vEPPE1AYFaDc22KRy1Uww=;
        b=hiZ/ybfp4Q2Hay4lV0mOwk+QUtUt524fIeOUjTCxaDn+2AmqPbKCplQ+tfHGVHpoeu
         h4bE60Sku6x8PiBG9AwM8MWhqX7H7YAokkwNdPQaLQV2/LhUrgsKC2fwYulnPZAftLYf
         ZhZ9Gh9/emZ+skgyawwAd/vvwbgANO5g4km9AdGwCgRw4VKdbA9/QBptzBeZghy/+/EJ
         k9AsDxLnukyK5+vEdLTeYDYC3wJoJ7giLJl58iQnB7Xz70/2XfiflMDcfDYveAUFMxKS
         2GGj8CpWVZaFq/rhfpQR0HWDhc93Ktnh2eVZxuyx58CLW1h6/xGqCLJlOA9fgbrLZQce
         wrAA==
X-Gm-Message-State: AOJu0YyonqX2hxzGgeUiSUafYzOZmEpBVM8g0fdko1n8EWjBaEVV3iqU
	sn9vUQPh+8rYqJlYlIE8LlqVqWi2B5tlPYxtRkThqNuTW+6Dk0GMRiCgVGRZsA==
X-Google-Smtp-Source: AGHT+IH4qjapN1tMtiuAmMoT6rpraF5HnEMZA53T3kwfW6qMWCEweAk30bq4o+8SIja2fpnNwNfHoQ==
X-Received: by 2002:a17:90b:1e02:b0:28b:2f4f:75e7 with SMTP id pg2-20020a17090b1e0200b0028b2f4f75e7mr2446852pjb.13.1705970170501;
        Mon, 22 Jan 2024 16:36:10 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id sj5-20020a17090b2d8500b0029082d10fc4sm4349054pjb.39.2024.01.22.16.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:36:08 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: linux-hardening@vger.kernel.org
Cc: Kees Cook <keescook@chromium.org>,
	"Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 51/82] ext4: Refactor intentional wrap-around test
Date: Mon, 22 Jan 2024 16:27:26 -0800
Message-Id: <20240123002814.1396804-51-keescook@chromium.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240122235208.work.748-kees@kernel.org>
References: <20240122235208.work.748-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2346; i=keescook@chromium.org;
 h=from:subject; bh=XxURT38No80Bn/RVyeHb/5pbIxR90+R/SV2DoW19O2Y=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlrwgJfc3EWrPnb832ItIHNOA2HJqk4KZ1EF6QZ
 nAnjsOI3MeJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZa8ICQAKCRCJcvTf3G3A
 JgWoD/9yEuahhVuo6Oq9sxAGltEMRA9drZZ1a23BuUOmM7ZvlwVgfKpVuNfm3t/eJQl4ncEuQWj
 /HVpMwC1YBVZdX3w0/rGWglZt+M2kJmIQWeCqGLXHaDMwz5Dxh3Jc7TmXo8q74TLfC2Fjf2th2h
 c7ecJV6IDXQxgEsLqxa3PQ8hWO3PGhD+zM7MQVHjSE6wWqjehc0rmCDcqbTkP74PN3qe7E96VG1
 qI7uzGwGMQNd4NnM+y5A1YjqyBGP04ronv0Xc2RWiXgf28HIHWVpBHlJ+Ub35w3g7AP59giTyep
 TXWgeIzbP5hGlyCDaXms0dm6WsyDOENCHhdxBD4R3awzAkqy8QQGtF8uHNf/O/G8nj4xvMQ+to2
 HTntW8Ue/514yiE0+zj0QO6VWfaP5pj0PEu3Dg19w1eKMGM87Ca2ryqLsKVqPpRBesMm5+IAqHQ
 FT/38xjgNzw+NWo7TTxCHqxToHhwugtPYvTbfAy5G5Qfv6GqTz7+JL/+oJMqeKUfiiyWM7luO+v
 n4YU5karM6VqIQUMmKaXViotzQTQgqY4Fw0GtJtbK6H5HjtDcgMpsncMxAA0hMW1s8XS7G5VbCH
 L5cxsS8UZV0aduIr5pTDUMnRucJipPEdSCwDo/32479Rz+mXzFbaQFky+7aLi1ZY/xczgF1WZ+e m5L/I7exNH7Sh5g==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

In an effort to separate intentional arithmetic wrap-around from
unexpected wrap-around, we need to refactor places that depend on this
kind of math. One of the most common code patterns of this is:

	VAR + value < VAR

Notably, this is considered "undefined behavior" for signed and pointer
types, which the kernel works around by using the -fno-strict-overflow
option in the build[1] (which used to just be -fwrapv). Regardless, we
want to get the kernel source to the position where we can meaningfully
instrument arithmetic wrap-around conditions and catch them when they
are unexpected, regardless of whether they are signed[2], unsigned[3],
or pointer[4] types.

Refactor open-coded wrap-around addition test to use add_would_overflow().
This paves the way to enabling the wrap-around sanitizers in the future.

Link: https://git.kernel.org/linus/68df3755e383e6fecf2354a67b08f92f18536594 [1]
Link: https://github.com/KSPP/linux/issues/26 [2]
Link: https://github.com/KSPP/linux/issues/27 [3]
Link: https://github.com/KSPP/linux/issues/344 [4]
Cc: "Theodore Ts'o" <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: linux-ext4@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/ext4/block_validity.c | 2 +-
 fs/ext4/resize.c         | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/block_validity.c b/fs/ext4/block_validity.c
index 6fe3c941b565..85f859979d2f 100644
--- a/fs/ext4/block_validity.c
+++ b/fs/ext4/block_validity.c
@@ -302,7 +302,7 @@ int ext4_sb_block_valid(struct super_block *sb, struct inode *inode,
 	int ret = 1;
 
 	if ((start_blk <= le32_to_cpu(sbi->s_es->s_first_data_block)) ||
-	    (start_blk + count < start_blk) ||
+	    (add_would_overflow(start_blk, count)) ||
 	    (start_blk + count > ext4_blocks_count(sbi->s_es)))
 		return 0;
 
diff --git a/fs/ext4/resize.c b/fs/ext4/resize.c
index 4d4a5a32e310..fb8d3745d031 100644
--- a/fs/ext4/resize.c
+++ b/fs/ext4/resize.c
@@ -1871,7 +1871,7 @@ int ext4_group_extend(struct super_block *sb, struct ext4_super_block *es,
 
 	add = EXT4_BLOCKS_PER_GROUP(sb) - last;
 
-	if (o_blocks_count + add < o_blocks_count) {
+	if (add_would_overflow(o_blocks_count, add)) {
 		ext4_warning(sb, "blocks_count overflow");
 		return -EINVAL;
 	}
-- 
2.34.1


