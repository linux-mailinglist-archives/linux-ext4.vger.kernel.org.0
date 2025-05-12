Return-Path: <linux-ext4+bounces-7805-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61355AB3445
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 11:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CC9AA3BFF14
	for <lists+linux-ext4@lfdr.de>; Mon, 12 May 2025 09:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCDCC262FD9;
	Mon, 12 May 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KbGI/1oE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EAE25A64C;
	Mon, 12 May 2025 09:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747043859; cv=none; b=tcRmCPaZxCkCnInuM3T/s93dZ5U07YRm4+47VEhAPoNT6Irxqp6+I1HFGdH7Gkuxv+1vnTzBgQPnmvtzXmCu+7PV5U5NJh8vNR1gTPjmNLbyY/4g9Mt1d5/cm09aDxaB17WF3PRGIqIuuguR97nJOOf6h/kHOaV+K1KoFSLhY+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747043859; c=relaxed/simple;
	bh=Bd6yxwD6kvN73DPrWsmOtuMjHP9LS2gPZxDyeA8mbFI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jowjv88jrSjTiTI8iAiqBmP6fbRou9u0cdFQzUL2cO6CP0u0iSHKnbbo90ef3PYKzZ+YDeplwwVBg/wtXncoXBFjyg4yCrem8Wo0uzPl2/zg6VZZGa3a+2nijHPiGx7CfAonT0PkjvB1Ycc8fdGqogejYJlIrr/CAlkzCIyfQb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KbGI/1oE; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-30a9cd61159so3875699a91.1;
        Mon, 12 May 2025 02:57:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747043857; x=1747648657; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cHlG7q9JzoOjjM7u4Bvq8zhN5q0u2c7ZeCjBfPannWo=;
        b=KbGI/1oEkxmSmIoUXy5FftANoDzkVkIfD3Z9LzC3UXtd1NBiEj/1jnFH9LtMZJe70Z
         iyiNgjyJIGXAdiiPbzHeAsoZO2Y1TXs5eL5RhJ+H2m+JBMFtngNOMgp6Wen8o+6iKm/k
         2pwSrbLZC/b+TC9x5zfNrl2nkLQNBECw/mEfC4PeOhxecrVxQJY7xC+/RQjUhRtO/51f
         U8os15zt0PDrYhvb5hpkeTiy0m1WPWb33uiFA6abvMk1omYal0AJ4VaQg8q4KpSiiM4Y
         kuU+w0G5Jd3MJGxqCwG9YtDf84TG8/CZ1NLXCmppDwBWYrOE5eT3WSuRCyEG46ivua9S
         HELw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747043857; x=1747648657;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cHlG7q9JzoOjjM7u4Bvq8zhN5q0u2c7ZeCjBfPannWo=;
        b=fAQI8k30nzwexgAGIFXBfIrRUucyklk1lNcZ6G/udMhp8m78dOunC0pILIIlBInbJH
         VsZI6D6p6EQPJODQwNU4KCaBK0nGdyramSWbdTcyYYBlWUUpbqkUAeWs5YgF4LILY0Xg
         82B/swvK2htFjVktVtnWg+YUp5JMO28tynBrlgDjmWKOBQM/tuRPWnTyZiUEV+serSSs
         O9FpfS0IiATiGYXCq4ujIJcyj/4F9KOLq6ZMJbZw5rCAsItkKSJJ3ammNt+O3hAVC2ta
         /1BGUAMUCW2FTiP7kWQT6LANNAN1fiwu6BSX2w1zK6q2UIAFyQi0itjNmobWc+vDiqM0
         6hYg==
X-Forwarded-Encrypted: i=1; AJvYcCWh5z+wwYBLEy1kdsjDCUY32xGlhxjTeBRynGi6BgbUD2w0bNT43HzyuK8Nl4HVXXFSGYC6SAaL@vger.kernel.org
X-Gm-Message-State: AOJu0YyVnXWRTEoUJAE4J2zLGNDUMa3c91HpTqtfyPgce+1l3+Ygfcru
	mKXf1gwjK37GelRCT69Do6/M2do8dPHZYETBJdBOwM20ma0iovaUVy7xhA==
X-Gm-Gg: ASbGncuaQAX4g1G29U48TELbR5ZJ/JtqiEb58gs+Z0Y1QV/aXf9k3ltC8zgLCbsuLuB
	BuPCjxyR+pQNOjorgpTgKFFABTnWjHQdoPRi0mamMkghExmyytQlSluvArohXaf3Jr95xw9T6HU
	mSc5VFRS6GgzVI/rFGDSB9muRCXTPDTR7Rk+pqBYyIfKLlaMswi4EFuNFQHHl1rEXg5jUQwYrkv
	cseW5XJdyIJdGNEoG1spA2J/RkZ8qjSRvbEFPKYO6ZkJVvjnRruGl9dAqaXKtzBU8Zkx9RWSXk1
	ykt3W9ElMbuslam1sS/jKbfUzZR2Tq1g0m+Rkk+85rMoZ7Q+kLVds/PgL2dBfK6AtkXcVA/m5k4
	x+UMd4aMbYcQjGDg7ckn8GjxTugRT/RAMRGQMN4Vm
X-Google-Smtp-Source: AGHT+IE4vl/+ycjPv007CP7xDLqyemuKhIlfOyqvxS4qFvD3foHco38poD+7BNOM0ygASikBnhvPyQ==
X-Received: by 2002:a17:90b:520d:b0:30a:9cd5:5932 with SMTP id 98e67ed59e1d1-30c4000fa4emr19936646a91.13.1747043856663;
        Mon, 12 May 2025 02:57:36 -0700 (PDT)
Received: from li-5d80d4cc-2782-11b2-a85c-bed59fe4c9e5.in.ibm.com ([129.41.58.0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30ad4fe213bsm8366974a91.34.2025.05.12.02.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 May 2025 02:57:36 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: linux-xfs@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	fstests@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	hch@infradead.org,
	nirjhar.roy.lists@gmail.com,
	cem@kernel.org
Subject: [PATCH v5 0/1] xfs: Fail remount with noattr2 on a v5 xfs with v4 enabled kernel.
Date: Mon, 12 May 2025 15:27:13 +0530
Message-ID: <cover.1747043272.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch fixes an issue where remount with noattr2 doesn't fail explicitly
on v5 xfs with CONFIG_XFS_SUPPORT_V4=y. Details are there in the commit message
of the patch.

Related discussion in [1].

[v4] --> v5
 - Modified the error message in xfs_fs_reconfigure().

[v1] https://lore.kernel.org/all/7c4202348f67788db55c7ec445cbe3f2d587daf2.1744394929.git.nirjhar.roy.lists@gmail.com/
[v2] https://lore.kernel.org/all/cover.1745916682.git.nirjhar.roy.lists@gmail.com/
[v3] https://lore.kernel.org/all/cover.1745937794.git.nirjhar.roy.lists@gmail.com/
[v4] https://lore.kernel.org/all/cover.1746600966.git.nirjhar.roy.lists@gmail.com/
[1] https://lore.kernel.org/all/Z65o6nWxT00MaUrW@dread.disaster.area/
[2] https://lore.kernel.org/all/aBRt2SNUxb6WuMO-@infradead.org/

Nirjhar Roy (IBM) (1):
  xfs: Fail remount with noattr2 on a v5 with v4 enabled

 fs/xfs/xfs_super.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

--
2.43.5


