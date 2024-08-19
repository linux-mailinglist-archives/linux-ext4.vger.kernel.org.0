Return-Path: <linux-ext4+bounces-3783-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 012E39573A1
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 20:41:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9EE201F237DA
	for <lists+linux-ext4@lfdr.de>; Mon, 19 Aug 2024 18:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D81418DF67;
	Mon, 19 Aug 2024 18:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCz9Ql6C"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8597F18CC12;
	Mon, 19 Aug 2024 18:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724092715; cv=none; b=je9DkjfgwUgwNbu81kPv85L/xuRDG0a6Y//0Aps3f0f/NLj7eeq4nRQJfS2U9SnIeFb0E+WbWLuUtOhLALyid2tC8Qh+PD0RvA45XdS4rDX/7lD+VegIhUSp8PnmqhObs6GXGVU8OuSQZ+UtIQNbroAaeCJx62NsXOqEjd4IGC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724092715; c=relaxed/simple;
	bh=gQ7h/+9NM1R1MvDJ9c4bAzOjFGlhrq9YjLswnHaS6fc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kvpsKBEtPKaERRSdWW75iZztgTRkzJkAdMclImqtt33YVXFQG2AshDDuNrbYKaq4y8dJ18R9BaAZNG0NYSQ4pSdsKnmMR9ZvwWGeqxcv0PDRFgJJ3SmCqgJvC0bi35+hyViJBzoFoPDIfLnlG0JvWdoQuSgsAa881HSSedV1YgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCz9Ql6C; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2020ac89cabso24233795ad.1;
        Mon, 19 Aug 2024 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724092714; x=1724697514; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JXXK/4KH2yGZgUetkyX+OjqTrCB13SrSr+rUDxIOU+o=;
        b=mCz9Ql6CTEfgKfku2v7Zqb9ZocIdKRVkaQmVDtw4RSKrluLV2pQ4sd4GVnR22kh3Om
         JoYYPGCEt6KG+9++mpYIzSOC5jCwBpkiL4iClKxmdCelyrJiGN4/ZFBj1TLf9LeTHZqV
         +hPjz8NmxbUPrV/HXwNQ7MOrZGXEAb+CQy/1BbO1K+5VVB05wEBsFDmUkIY3gCJYs3Ce
         H1CmmXzA5nbOB1KjUmoaRDwbiLSN8/2hnHKf7ILDQoV9dk0vdjSl0884RpvQa02B/6Sl
         qwuvTR71QbnYZBi0h97A6VFw7gHtCnW/LGm+ydKCo4hZcuQLldFgdcIR71HqqajCjt5b
         zekQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724092714; x=1724697514;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JXXK/4KH2yGZgUetkyX+OjqTrCB13SrSr+rUDxIOU+o=;
        b=gD4fc6KW9YZXIt2zAPSRL6c8gEO/9GQMTQ8iMOIU+CKQ7YeifUfFxNhP8Vl17kX6Mr
         3N2I0TWvr+ifDhbxF3CgEmOENWmqq4tvXu2qi6cAhGW1uMF5aZ1UmVCgK0wi4ayfPQKz
         HOf2n5/IEzrJMxdapXXAKndFiLyjYp0j7zYNnBTqKhWU5ROwrWRPmXe0cd91LDC23xhh
         EVnkTAld70fKHF4JvGXIL5Nvv8ItkhThkecwF+gKFaeR7N6zY94U+NxZnduKv4JvE8ch
         5qykH32X9ZXj0PvJl70z4H9NLM0gG0jup9KA96T6sM2KXyj0JoYt67YKo4O6iRRyiBow
         3d8g==
X-Forwarded-Encrypted: i=1; AJvYcCU0vBdEwBfyve1EYKVFaVqgZsZolINglpI0P0vp1Y1j1/w0zCIvKi9L0ekeWb29d+OY5KYlsrngQDSlohoZk+zQbikRlqhveS8tg19nxn8yfKEiK1kly2zZsYmU1k8u978IZFQIFpVn7A==
X-Gm-Message-State: AOJu0YzouqzjzREDTTdhlumylPZukepACwR9vAPKCWnXREX+kkJG97Tt
	XruZoEGt8FkdA5uyt7sMCnGNfmkDVDZ9M+V0DIxJ4GG15sUxLiH8
X-Google-Smtp-Source: AGHT+IFkQxHxl9krTJtCnhUwjlImHAy38TpHAs6kiv5teg641dNfgE6PCFb2Rojs27BfrrCX2RjF4w==
X-Received: by 2002:a17:902:ce91:b0:201:f065:2b2c with SMTP id d9443c01a7336-20203f4fac1mr130422615ad.55.1724092713413;
        Mon, 19 Aug 2024 11:38:33 -0700 (PDT)
Received: from debian.tail629bbc.ts.net ([103.57.173.133])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f03a125dsm65363185ad.252.2024.08.19.11.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 11:38:33 -0700 (PDT)
From: abid-sayyad <sayyad.abid16@gmail.com>
To: airlied@gmail.com
Cc: daniel@ffwll.ch,
	dmitry.baryshkov@linaro.org,
	mripard@kernel.org,
	ankit.k.nautiyal@intel.com,
	jani.nikula@intel.com,
	imre.deak@intel.com,
	mitulkumar.ajitkumar.golani@intel.com,
	quic_abhinavk@quicinc.com,
	dianders@chromium.org,
	marilene.agarcia@gmail.com,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	tytso@mit.edu,
	jack@suse.com,
	linux-ext4@vger.kernel.org,
	skhan@linuxfoundation.org,
	abid-sayyad <sayyad.abid16@gmail.com>
Subject: [PATCH v2] Fix member variable description warnings while building docs
Date: Tue, 20 Aug 2024 00:03:52 +0530
Message-Id: <20240819183351.262492-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
---
Changes since v1:
- Split the original patch into two separate patches as per feedback
  from Jani Nikula.
- Acknowledge that the `drm_dp_helper.h` change was already merged in `drm-tip`
  as per feedback from Mitulkumar Ajitkumar Golani.
  link to previous commit :
  https://lore.kernel.org/all/20240818112543.1089986-1-sayyad.abid16@gmail.com/
 include/linux/jbd2.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
index 5157d92b6f23..17662eae408f 100644
--- a/include/linux/jbd2.h
+++ b/include/linux/jbd2.h
@@ -1086,7 +1086,7 @@ struct journal_s
 	int			j_revoke_records_per_block;

 	/**
-	 * @j_transaction_overhead:
+	 * @j_transaction_overhead_buffers:
 	 *
 	 * Number of blocks each transaction needs for its own bookkeeping
 	 */
--
2.39.2


