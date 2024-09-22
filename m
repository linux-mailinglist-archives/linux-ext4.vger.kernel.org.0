Return-Path: <linux-ext4+bounces-4260-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26CB697E18B
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 14:31:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FD181C20B88
	for <lists+linux-ext4@lfdr.de>; Sun, 22 Sep 2024 12:31:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 202C0391;
	Sun, 22 Sep 2024 12:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PJBJDVZV"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49780173
	for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 12:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727008294; cv=none; b=p9MjTvC3anlD9ZIxocyW9KndfCFVo1xUwA6jRRX+9eYkKX4NmPFH9lDI7qGp0/pTbpA8Sx/8WSwVMKn/OU6TsKiDnBX38U125zyeYeGJznGpeYDayjJ69iHL6GEzvIPkU8WDsxrjina6EfYD9Uef21TS+GOrQvvZwPp8b21QCDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727008294; c=relaxed/simple;
	bh=zpOeMCZT93t89r2UOr9JhFbb6uF8KJD/MqHl+Ldbrrg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=YF0YSotf5tSRomAq0+W9CAI9EC+wT39qRmvOoUZjEvgKkVx5jdhRzTrnrbKlDJdaoJTkHwcj00MwMk8r5VGdtb8Xw3gLzJvgF+6iEWYHU9f2bRnO98ZbnuGCpaFu/UT0ViNtDAEy1wAQWRX5xMeza1ZOqIX4WHITINAYodzzbnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PJBJDVZV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c245c62362so4297043a12.0
        for <linux-ext4@vger.kernel.org>; Sun, 22 Sep 2024 05:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727008291; x=1727613091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=zpOeMCZT93t89r2UOr9JhFbb6uF8KJD/MqHl+Ldbrrg=;
        b=PJBJDVZVOW+r8flVaV98yf81Ut4pPaCmP2wXPoqCW8t0rmujVqvswLwGL+vf/4/UOV
         ODK0misJTUpJr/DpLioosFab6rg+tirPRILEHyKT1BVbyEYTqiclDygVYoX8CfUsunCM
         XI7NDl5lS2t18KlluztoLKPS3jn2Gu6iL9fLgArUIVDsIjtsGywg/LryJ9e0AlQQohVC
         hZvx5Q0483GrYuy5BtldEeyFdnw4BzGf/5PG8AWBDqVGmaPvhWxfGP3FFMTCw8jFqKWw
         +lQw5IWQ1MEQnojmwsBu0cE0NkJZ2+fIA25Hm8TGhbSz7sg4HVJzRuQy4hBjox0Ag9MW
         FxLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727008291; x=1727613091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zpOeMCZT93t89r2UOr9JhFbb6uF8KJD/MqHl+Ldbrrg=;
        b=R09MlT3mZoTpAFMFOKvQlgWK86oPZqcqJLWusC4Q4ryr5rhTVSpb2ZMmH2WV35nigb
         MkSKC6+TI+Zl7xuwdvypjnxFsIIArAjoHQQbjQ4GM2rbWKdcKhkhdQMVbz1UM7oOHny8
         KfQTtV9mpLNujz+oeyAjvX46gLu3JWKBkSE7z3pRACcmQ+QOaYxCtolq0ljNIadVjAVB
         Sr/zwg/ZzXJ/ZLIvz5uR10MR2rbqwhfxztnOo07VvYBlWJSUvyyZf631v1kGWM135mR8
         UlfIVJyE2IAPRPYgoCcb7jBeCSPE22TADoIcL1ehGAHkBrb0AI6va0s9j2L+k0L0gxkw
         lg3g==
X-Gm-Message-State: AOJu0Yy4iicE+YRtw5m1rDim7OcueRQiNHD28iqK2zwYQuzxcqRLZ8at
	OwEeIyFqtoe8QoTPn7cVHSnjb1YsAUidw7cDU7V7RjFc2b+77nooMLJ4JHlU
X-Google-Smtp-Source: AGHT+IFgsMUCh9O62+MlYYEVsi9XvgdwxNTu94NHdbndloKWVnOLAXIZQUrnyFNKxdrJYwacOdCGCA==
X-Received: by 2002:a50:8dc5:0:b0:5c4:2c4b:79ce with SMTP id 4fb4d7f45d1cf-5c464df7902mr4639600a12.36.1727008291264;
        Sun, 22 Sep 2024 05:31:31 -0700 (PDT)
Received: from Max.. ([176.12.181.199])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb89c7fsm9050014a12.67.2024.09.22.05.31.30
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Sep 2024 05:31:30 -0700 (PDT)
From: Max <linmaxi@gmail.com>
To: linux-ext4@vger.kernel.org
Subject: [QUESTION] I'd like to make a patch, where can I help?
Date: Sun, 22 Sep 2024 15:29:51 +0300
Message-ID: <20240922122952.62821-1-linmaxi@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello, is there anything specific I can help with in this subsystem? You can give me anything (that is not just testing, but actively patching). Thank you!

