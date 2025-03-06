Return-Path: <linux-ext4+bounces-6682-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD72AA54482
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 09:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80C21885CFF
	for <lists+linux-ext4@lfdr.de>; Thu,  6 Mar 2025 08:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5BFF1EF0BC;
	Thu,  6 Mar 2025 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NGFS7ORn"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E431A9B3F;
	Thu,  6 Mar 2025 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741249113; cv=none; b=QGRziUJH8uF1pZeoWRquZVV8l4VM3PMwOsfz1ekSXBWAGw/jrS50AEX0+L68csJ+B7yCgbUK1a1+g1o6HuoKy0gzAzy3v65PVei5uGzwuJ1L27MCpkfRwC0Yx2hCkuexQZuCc4h10jse7xuxB9+Ex7cWXOSRsgi6P7NkETeG/tc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741249113; c=relaxed/simple;
	bh=HZ3OhSZ5sxkNoBi0DqWz7CUf/EoRnD+71qKqZ8/JAPc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KJuNypyW9XV1DerS/OeuOlO2CCWBO0X7ctmbeJK8hNBEkXlyfJ8THLB9giI039haQIWK5o3kzBIMybFFTuThLQM7m0sSK76K3u8w72nhOBe9DzxoR80riGpphLy1Thj1Onf4E0Q3ZQEmZBytNDen6IjXw08AOVLRxo2tNY9HGl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NGFS7ORn; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ff6cf448b8so279638a91.3;
        Thu, 06 Mar 2025 00:18:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741249110; x=1741853910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UrPvB2qz8Psj3189Qpc6a9Xw7DkMBW1775/mHLQQwMk=;
        b=NGFS7ORnNQdYHkkfwhiMw1fpWhMUtBq9fJEMGpt27FZTw+sXhVrtYBVJBAqd1zin1G
         Z69tSdi5wo7jXiVaHA4NMbaqbjTG+5DKwB5TlgM0kDUzALvMpYAORHIHz7IA2aJv1Owv
         rhpuXRaToVUZBflYiCszxyg8Jc2e7d1PzRe1xOKudn5WIGvjWO8p3qmD5Q9ItxIEr+QY
         GM1bq7jPlbxSydiKbDVlriWykjfFF+NooyTKAAAVYX1l3A22PM3ggzhaixB0XneXRYAc
         VVGZic2XPbOR8FGQeMCqu3wz83lHMB6zfXXD5rHcn7IXZy+X+suk35wb65Hl6QqPSMcA
         ML2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741249110; x=1741853910;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UrPvB2qz8Psj3189Qpc6a9Xw7DkMBW1775/mHLQQwMk=;
        b=uyEjKDf6PM6iMk+pT9H0B/zFzawkv0L17qphHSqiLH/ty2NQhi66m06PoXg0zAObhz
         Umjztvmi993MiXC23l6zEPqavTmpxIPS47glgPkJu/pOZED8uXomEDHF1vIoOg5E+FL2
         XFAYQBMWmaJXb4e7ss/WVlvEV0zAAK22n9g4FUW4Fx6U600zG1y/VSNd3t2iKuNQ5m2u
         59OvjAh53ru+sv5fOVFlVbsBdzeNQx88QWGvIiEaeydPDTYKgnvLAiYvwAaNT2PxG01k
         yJlEpliwcg5flG8nxsbplaROUo61UIlo4/rdAea1ueefxYXxQhmVcz0ZDcTFkLvnhGcv
         A2oA==
X-Forwarded-Encrypted: i=1; AJvYcCU2k3LKkcH6a3D9fNi5AkJggz9t+dtigWLCKWsQn1+066HV3L9kvOtXU2RuCU7EVc6G2N0pGmcjpWw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwY7kFp7pT4l5/WM6ehW63euj1BSEpO6/uPgc1C7Aubf5yGClVZ
	HtKYJASIae/egd0b+ormSSuvwQt13BmF4G30S4svdEJYtjXhfX8LoQLzMA==
X-Gm-Gg: ASbGnct9A1IRRodZ8QKxxCsYna9sHbrI56T2qidwgAP2h+XhgpSh5kKLdVk9V9+5Woi
	mx0QkZb++Uh+tgzr0YDQHjBs1rqe3WJuT187juo6TSme1VbkMclN+XPS770ep+PzcF7aC1TVTF/
	NlOJibCViQSUcNCNwKC8waYnfj3c83bZ5BteOSXh+A6gy0qnkjZVq/DhGecxao/sdRntDuovA6m
	+YYWuzlLXAGS2ocW0YSl52riSWkzdTFczGpnbQQHwR6k/X8AWU0pED5092Mwqz2FqW7UVCAxZcS
	Y/vGslc8+fa/lI1gO++L6PFU03Gsp1V8uibgO1DZmXC+lw==
X-Google-Smtp-Source: AGHT+IEgb1b3Q0QzxwVAsbYQVHNM66LLXhiuojcqhwa9Z3XaYWDgA4/nTJA7IiIQdOag+Cxs41cUqA==
X-Received: by 2002:a05:6a21:150d:b0:1ee:c093:e235 with SMTP id adf61e73a8af0-1f34957edd3mr11151597637.41.1741249110450;
        Thu, 06 Mar 2025 00:18:30 -0800 (PST)
Received: from citest-1.. ([49.37.39.11])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-af2810c6349sm660257a12.46.2025.03.06.00.18.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 00:18:30 -0800 (PST)
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
Subject: [PATCH v1 0/2] Minor cleanups in common/rc
Date: Thu,  6 Mar 2025 08:17:39 +0000
Message-Id: <cover.1741248214.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series removes some unnecessary sourcing of common/rc
and decouples the call to init_rc() from the sourcing of common/rc.
The individual patches have the details. This is proposed in [1] and [2].

[1] https://lore.kernel.org/all/20250206155251.GA21787@frogsfrogsfrogs/

[2] https://lore.kernel.org/all/20250210142322.tptpphdntglsz4eq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

Nirjhar Roy (IBM) (2):
  generic/749: Remove redundant sourcing of common/rc
  check,common/{preamble,rc},soak: Decoupling init_rc() call from
    sourcing common/rc

 check             | 10 ++--------
 common/preamble   |  1 +
 common/rc         |  2 --
 soak              |  1 +
 tests/generic/749 |  1 -
 5 files changed, 4 insertions(+), 11 deletions(-)

--
2.34.1


