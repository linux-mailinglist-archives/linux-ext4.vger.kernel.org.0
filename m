Return-Path: <linux-ext4+bounces-10454-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3ABCBA5689
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 02:18:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A38DB6C09A3
	for <lists+linux-ext4@lfdr.de>; Sat, 27 Sep 2025 00:18:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA4A191F72;
	Sat, 27 Sep 2025 00:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ji76DU+Q"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1683C282E1
	for <linux-ext4@vger.kernel.org>; Sat, 27 Sep 2025 00:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758932302; cv=none; b=tX4MWP2qtFIO2RAvCHjm/MGb2L5VwR2+PPFe7QvT//w6eGrWkBKS/FliNXDmzCV0aIuEDELygbO+gwU77M6TqRM7BkjkLR96x3Yf+gEib1qpGPBvyR0lBPghSYaHAeQ0CDEcuYNPb7ejPbHaGvaw5H1yyF14U4mMQni7xLgZpU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758932302; c=relaxed/simple;
	bh=OCMM1i+marxjh6pUkwTDhMRBuqlU+02sLHnJrahSSHk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GiWUc6FgTrYyzbT4dYzATD/Ppg6XBkOlYukDaiHigtCQ+2vnj3KSWgcr9TMWZ32+6lD4f5iyU3tf2iTXxAtffUxy/VgxPevaKE5llIOCj9WGE5iPjQmI1aLmUZWQ6l5knMCd3e0F2SGnQy6s53F48kdc/shnUOJi4HNMWJyQRig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ji76DU+Q; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-781010ff051so1974844b3a.0
        for <linux-ext4@vger.kernel.org>; Fri, 26 Sep 2025 17:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758932300; x=1759537100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xoCdX6M4UpRUuPuNk8r9g0MkweOF1WQ1ahjsQ+1be2I=;
        b=ji76DU+QqbB+DgNlMxXt2KlSbBre8YycpupJP8mMKUOXqBQ2/QjdZS3HjgAfAMq5K5
         HPFYBqOEJ6dyhgWxcCr/foew9HGtqbkSbakhCf9fk/JGyOA03XTgcztfjKtTSW+VkRkN
         xwY6VvUKmYbvw25D5SzwXltiiFQL602rFGdIB4R+0qiU+ovfHlEakqN5uX1I5jNi1aUo
         fLATDnxZ5unFzWRaB1ntHV9jo+/IvZZDCdptPSZJuJdBW5Zv6wIiD7WvLW9nkfy2Tb/g
         uhDWix9ML8rydZqSCfjbZYVJzjTfPnN8dABdiZ30RR42XsGgosfoFPHR7z5EtTIYPUoR
         mcRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758932300; x=1759537100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xoCdX6M4UpRUuPuNk8r9g0MkweOF1WQ1ahjsQ+1be2I=;
        b=LPDb+duc7xtOgUqoz8wPLN6h7bmPphcq3B3DJRZuNEAE8YaBcVTJl5slUe22p5gSM3
         2Yfl6xAdmGWKUlZsxJbKy65SbF5w5iahWeoOwJbZTOmCaOQg6gwZPiO9d6fCzbA/OHRE
         maG3EZ2KnFQh50GvKJAS7bDzowqRCCB/puKkvjNyKbZIN2ElKWwxsCRX0GvVnzuNE4jG
         dnr9KCa9c8xc0vmUYWDRnJSukRQsHAzq3QqDIg1GK8aIK7pQTg2BZXKhHqH+Mq/O4x0o
         IBqxsUn3iIB7gee9hGbl5ZVYYBfqNcsy71U/aQy5xtkHQI1Cpwf31AVZ0Ga5XDsp304s
         d7uQ==
X-Gm-Message-State: AOJu0YxX9mnviosAcIN1QK9FpFY2mWrnszXrjdENe3lxYDBQ9hjqbre7
	G05QI9npsfI4RQEMM2wZ9sHYhNaMVvyV9JskDDUzTbGsQwVuQPLP40yoOx0Yr+x2f0s=
X-Gm-Gg: ASbGncuMtJ5XnqXng8IPIlYq7JHX1nN9eKB82z+ADJyH33h7HbveQwL1uPpFg+EftHE
	Zn45ScJbo/APMEYrPiFgscKCnT7UwzMZro057i6ujgLerK/3UAQln3/6NBlg/IEG8W/wqoJo1ec
	xLiTaKPDgZHey5mtGdY+HCN2s5ytfHIicXgCN6s8sHTq2RrRV2+MOFc1RFMQxZ5itkLZUweITmv
	+VpuRak4I0dWrRTFU/8QmK3KNdAN50TE60PWLovozMcxL0GWS8kCqgS24nVhPri+EibDtmp6z6n
	s+HwpYdRrbyl/W7J8inG5UfdlVWZuUoYRwTTWaeYMkM4bIkJTmDQ8X9e88J7FYEaVHcxIMvhTDT
	srcO8oD1DyonMk+//8gm800X8THfrDQAP4r43gCcyaS3bmZzjy4zy3J4Zo7FjVZ3FNFy2g9gPA6
	L1tMyUkYNmHapO
X-Google-Smtp-Source: AGHT+IE9iOU0xGbfc6wu5KJMpk4TLbi5OzVytsj49pIWcOaRGPjom/RdtIiWb7W0JE+msvBxROCd0w==
X-Received: by 2002:a17:90b:3e83:b0:32e:389b:8762 with SMTP id 98e67ed59e1d1-3342a158113mr10059781a91.0.1758932300355;
        Fri, 26 Sep 2025 17:18:20 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:9584:386:9d60:7b43])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-334352935d3sm3151967a91.3.2025.09.26.17.18.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Sep 2025 17:18:19 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Sat, 27 Sep 2025 05:48:15 +0530
Message-ID: <20250927001815.16635-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Andreas,

Thank you for the detailed analysis of the tradeoffs.

Looking at the syzbot report (https://syzkaller.appspot.com/bug?extid=fd3f70a4509fca8c265d), 
this WARNING appears 4 times, so while not frequent, it's a real issue that occurs 
under memory pressure conditions.

Your -EAGAIN suggestion makes sense. The approach would be:
1. During memory reclaim, use GFP_NOFS without __GFP_NOFAIL
2. If allocation fails, return -EAGAIN to let reclaim skip this inode
3. Preallocation cleanup happens later when memory is available

I understand this requires modifying the function signature and updating all call 
sites. I'm willing to do this work and properly test each caller's error handling. 

Questions on implementation:
- Should callers like ext4_clear_inode() ignore -EAGAIN (leave cleanup for later)?
- Should callers like ext4_truncate() retry or also defer?
- For the unused "int needed" parameter you mentioned - should I remove it in the 
  same patch or separately?

I'd like to implement this fix properly rather than leaving the WARNING unaddressed. 
Could you provide guidance on the preferred error handling for the different caller 
contexts?

Best regards,
Deepanshu

