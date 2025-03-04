Return-Path: <linux-ext4+bounces-6662-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D505A4DFA2
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 14:49:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D7FD1896613
	for <lists+linux-ext4@lfdr.de>; Tue,  4 Mar 2025 13:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE142046B0;
	Tue,  4 Mar 2025 13:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lQwTiDQG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C38B20469B;
	Tue,  4 Mar 2025 13:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741096144; cv=none; b=Qpazp+NGRlv+ES1oH5Ko3Poz+oKvCpBr7tyXYH5Tb6t5ijEO/GOeq0Sj9WkpdDv9Nkmtw/pVa4SlOIXszzuaaodZtwRNac8Ooo0BxLst+FP1z2m4s/y7gKb1TyfcFieSrcs1d5fsLc97pOKobIWwa3XcT8vxC2RnvvMgwN2tUhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741096144; c=relaxed/simple;
	bh=vy1k9F0SM4zfnCTs4ElVIC5k/ZQjHFrSJBQ/MVRfUIo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pGg+nuqVuMqYbat1c78s1bITvU19089Q+BYsuzRVapn3ECc2BURpLo3ug2pzqSSXBAuopDB6YfbA48zHHG0Vx9Rs/BWY678GEDoQ959ZcH+R5W1/FZ0vvbXnNVtev0P3M8T/Ma4IV95zCxN3Lr5/93qu/sPtdD5Z8DmFjKmfrfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lQwTiDQG; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-223a7065ff8so60773405ad.0;
        Tue, 04 Mar 2025 05:49:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741096142; x=1741700942; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bNHo4lB4TIJmnmfydF2jNgEYMFOQjDqBD84OErdtm0=;
        b=lQwTiDQGc34qq+gf/9uQxAAQBjBKcj6Dp6rpubAU4SLW8yric6lC/FquAGyIXMHcW+
         WhXIG4wJ4ec45VUZrn82lFeLF/UlGn0K0qbi0+JRl/I9jySUZEsOON9i7E30IYUDMfFo
         OBzla43ahLIxzP6SnXQugVeUw9aLC9aY6QN0gYxUOyH54foud5GnF3MDpoXNzhC99YIu
         nzTT+nz0Bl6lqfDqw7l5uO+ExqknF8MJ4ixlsv6+zlGjQ+bWVEwh2DGhpmjXUyBPPqVF
         ZYj93A+o4h7pWnkZ8Hz5LNWj/fj58MnIW8d2K4BCqTJ8y23pDmML3rQg9TqGPX7UeNxz
         zgjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741096142; x=1741700942;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0bNHo4lB4TIJmnmfydF2jNgEYMFOQjDqBD84OErdtm0=;
        b=PzU65WEdu45ClqIczDGvM3qar/JsqlpsIkxeS//DOF4ybDkpxSeEs8CEg6IxH6ugZZ
         nXm3nUIMcqD636xiqVUbXM+ETXhiQHYPFqEm/CL7QXQC0XDLQySV8vTFk356FNfpuCW6
         9kEWhNUUAJsxahvsHYCXNFdBT08ghWy6a/gk5ZfA0jKaRKkGbJjy60mDpD+FegkoXZYI
         OL9AYFShmZjeIKIBTyoPBcJhyqe+SClPzEIYRVVszRJG9A8E78H/fa6hRDQNgp/RB3O6
         sK7iMap5mKnw/G+KD6E72fcWBV/08zJpkkHoyoFtRubcOER/ux8iFZYFGtYfkRSIpBGl
         TorQ==
X-Forwarded-Encrypted: i=1; AJvYcCVzJVC6ONGKf91EhhQEiSaRijnyKrxwzyUP8mjITAfshcphVSNwmhqK0Dbn7S2Lxg2NnOUb2Xm1kZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqeYoVnBBWXHbJE/d/x1LQyOuhXFGBy7NH+J9qXWZX6m5d+SJs
	siRbbvBN8hF9XL6s3i+bCYbm8O1I/KNUt1JN1xwXgVlXvCNfNJRSCVMlDCqq
X-Gm-Gg: ASbGnctAqCS9+axkfD4t405L7Hk78Q1qPL7eUkAOp1eUGp01Vh08Gd2zp6OE6bIiiEK
	c9qnPAVME6Mu6VZbPT6CMo19yTMRxEVPXNsjD6xUe/HJVq2JyitNla6BgN2hOkhrPj97x7QfUNi
	8j856uVOfqCt8b2qQ1chKzFuo51pMHcTaIsO6mpl3sWqCE52MNAS6lg953Q69cdqWKe2OV1asFx
	M/zwYLCVOocrrpJsoyVvmUQTJYTBOm4wMLZng2Fm7GQwRJXUq2Y6Aurpu9oLJsMlC69g7uQlzXw
	7f0eGinUl9s+wA87Fg4UTncgqILuUc7IgrEzx5EtYkNi9g==
X-Google-Smtp-Source: AGHT+IGJ7kQj2OezkquY8iOpBrvWr2PjqNDOqLD7Dmf8RKg7fo4Z+LjJhRaQ4tBvqip3ezfnlboIbQ==
X-Received: by 2002:a05:6a00:ad0:b0:730:8a0a:9f09 with SMTP id d2e1a72fcca58-734ac3f3155mr26374527b3a.18.1741096141961;
        Tue, 04 Mar 2025 05:49:01 -0800 (PST)
Received: from citest-1.. ([49.37.39.11])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-734a003ecb6sm10879106b3a.150.2025.03.04.05.48.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Mar 2025 05:49:01 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v2 1/1] xfs/539: Ignore remount failures on v5 xfs
Date: Tue,  4 Mar 2025 13:48:16 +0000
Message-Id: <5cd91683c8eec72a6016914d3f9e631909e99da8.1741094926.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1741094926.git.nirjhar.roy.lists@gmail.com>
References: <cover.1741094926.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remount with noattr2 fails on a v5 filesystem, however the deprecation
warnings still get printed and that is exactly what the test
is checking. So ignore the mount failures in this case.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 tests/xfs/539 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/xfs/539 b/tests/xfs/539
index b9bb7cc1..5098be4a 100755
--- a/tests/xfs/539
+++ b/tests/xfs/539
@@ -61,7 +61,7 @@ for VAR in {attr2,noikeep}; do
 done
 for VAR in {noattr2,ikeep}; do
 	log_tag
-	_scratch_remount $VAR
+	_scratch_remount $VAR >> $seqres.full 2>&1
 	check_dmesg_for_since_tag "XFS: $VAR mount option is deprecated" || \
 		echo "Could not find deprecation warning for $VAR"
 done
-- 
2.34.1


