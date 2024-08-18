Return-Path: <linux-ext4+bounces-3770-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE4B2955C4C
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 13:40:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58518281B21
	for <lists+linux-ext4@lfdr.de>; Sun, 18 Aug 2024 11:40:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB101B95B;
	Sun, 18 Aug 2024 11:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSxTkthg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EED317BA9;
	Sun, 18 Aug 2024 11:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723981245; cv=none; b=ug2QuywxVcSZ/Zi1CTaYWxvII0HZXeoeMG2C4ihJaL77AXDmPkaUWVkDLelRYpyxkrF80lz4SlnCcZs3nYDcMRURPm65Ncp3kDpOlzKmnFsedwI0J8r/zefP2qbk0l18M1OCLlq96BPtrXCgewcpDeSM8VVpct+QVuy2OLh9dJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723981245; c=relaxed/simple;
	bh=eBYqKGhWmGDwRXKx7wPCMGC9Z3DbPhTQ/VBYxOAysuw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TqGQ9K1Ov3bR46RCVS5dFMODQF8BEY0eMKo6J+Ku7fKQ7Jr7/GH6aHz+lzkR2iHaxSRTzPSKC5SMVKzeO7K9Iq+KT5jJC3yN7ySZ6dgDW6VY+PTN2elSQR7jbiKKZnoezwl777PRI9SgQwvY+DyhTcwiXOcowOXmEb9e35ohOuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NSxTkthg; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-202089e57d8so12361135ad.0;
        Sun, 18 Aug 2024 04:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723981243; x=1724586043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=iPOAyXslVQztvmKtJNEbQBOKGd86i/cZ1d616kyhVrA=;
        b=NSxTkthg1AboN0MNA0ByKvRi2zu6s5QOaqwunlVmd6C4anwVGo3u/6uFNOoEbh1pPq
         vMJ1TrNVIq4ITh1dzVyrfbowV2PGaDtbnPv+7I5PgPCTnPmtMwCqPy0EvkUK/nTgS9Ae
         QF0VdA78BS05ZZcMG8UhgDpL+86rH5wTcRTjs80Lbd8lJyeQ51gCbaYMSJt33mGrZz2v
         5KyFFa4x2mMQ28rrpp61krN3zYFcydQrUHze/c9hDID4gwiSHVE+SGOM6cE5D8efDiwA
         Vxi44SIWVyMwYniuiAGRrJzbmSr+KUvwmLKYE+CC/bZ6WB65pcMZVg3B8mr0LsSDpwMG
         jTYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723981243; x=1724586043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iPOAyXslVQztvmKtJNEbQBOKGd86i/cZ1d616kyhVrA=;
        b=mHWkPiq4TrlMWzO7+1WXM7frCHwuvOwVQ9ojtARMcUyOHWZGWf4T7u5X4xhaLYjzxJ
         BQyGBnWfHrP7zhgNOkzwKJYqjZ5zdKH/uAcGGD38KLVA/go+zFbTn7PgzzZMp5AcFXtu
         gr3gtHS7ODr4M0dL3D5zagNF5tUiGjb4WK2IM7wa6YEj2R2VAai02eoJ1An1DEISflD4
         TguHtILfZFTT+r5IfIXI3uVsSZKmFeM4jlojM/LNACldX8vzvoeY9BwQPxOhgVMfd6iD
         tcqmqb/IOmgcexnmtakzdZAmqFl8wSUFD0JhGWroxQ/rVI+ZOAVXIDA76Z7Vy2tZWLwo
         pI2Q==
X-Forwarded-Encrypted: i=1; AJvYcCVl6XkKzUm2CuVQdJnA1TbbFOKqlGRdwmqsjPnYAF3jWyNySf8iHWP4b1HG9g+58KgaMH2wnhLS1p+JpzTj5OHEzpcrszAtJipoOOJXGbtiefepdD5cH4Ge2SlrEPEs0J7EgYHEsF5fXA==
X-Gm-Message-State: AOJu0YwXwQYDgrc/1UK5XV1PRMcTgbU0nw4aUH0zjZ5G3YNKq13sJJJv
	ltn2N2PsXtMYEcXOAyOvYxGjIElhEG51QyD7AJLg2kxlzYCdnzA1
X-Google-Smtp-Source: AGHT+IGXpW4bTySqg25zXNJ2YjKACfoms2OkyOgFUzjpB9MApiGppPNXEosmS30t53Hr7ahx57tBsw==
X-Received: by 2002:a17:902:e80b:b0:1fc:4acb:3670 with SMTP id d9443c01a7336-202061d3af7mr112886555ad.12.1723981243166;
        Sun, 18 Aug 2024 04:40:43 -0700 (PDT)
Received: from localhost.localdomain ([103.57.174.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201f038d2aasm49085825ad.223.2024.08.18.04.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Aug 2024 04:40:42 -0700 (PDT)
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
Subject: [PATCH] fix member variable description warnings while building docs
Date: Sun, 18 Aug 2024 16:55:44 +0530
Message-Id: <20240818112543.1089986-1-sayyad.abid16@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix the following warnings while building the docs :-

./include/linux/jbd2.h:1303: warning: Function parameter or struct member
		'j_transaction_overhead_buffers' not described in 'journal_s'
./include/linux/jbd2.h:1303: warning: Excess struct member
		'j_transaction_overhead' description in 'journal_s'

Fix spelling error for j_transaction_overhead to j_transaction_overhead_buffers.

./include/drm/display/drm_dp_helper.h:127: warning: Function parameter or struct
		member 'target_rr_divider' not described in 'drm_dp_as_sdp'

Add description for the 'target_rr_divider' member.

Signed-off-by: abid-sayyad <sayyad.abid16@gmail.com>
---
 include/drm/display/drm_dp_helper.h | 1 +
 include/linux/jbd2.h                | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/drm/display/drm_dp_helper.h b/include/drm/display/drm_dp_helper.h
index ea03e1dd26ba..7f2567fa230d 100644
--- a/include/drm/display/drm_dp_helper.h
+++ b/include/drm/display/drm_dp_helper.h
@@ -112,6 +112,7 @@ struct drm_dp_vsc_sdp {
  * @target_rr: Target Refresh
  * @duration_incr_ms: Successive frame duration increase
  * @duration_decr_ms: Successive frame duration decrease
+ * @target_rr_divider: Target refresh rate divider
  * @mode: Adaptive Sync Operation Mode
  */
 struct drm_dp_as_sdp {
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


