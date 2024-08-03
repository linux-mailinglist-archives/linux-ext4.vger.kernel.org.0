Return-Path: <linux-ext4+bounces-3626-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FDC7946A90
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Aug 2024 18:58:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3520AB20EC6
	for <lists+linux-ext4@lfdr.de>; Sat,  3 Aug 2024 16:58:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6DE814265;
	Sat,  3 Aug 2024 16:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IX0FXCSE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D02F9F5
	for <linux-ext4@vger.kernel.org>; Sat,  3 Aug 2024 16:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722704293; cv=none; b=VytjRAk7zg0IBh9HnTmcvc5NKRAzAazK7aVHZpxIM8aQOrba5OFb1YyytYAKE0fgmsFMymQ84BmiPkLGwft4ktgRuOcQO32010rvV4R0x3LTpEslJEZOu4WPQlh0rPfnF6QUaQgvyKp61PjDWkRKilBcK1BlIPO0IU6SO7KhDDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722704293; c=relaxed/simple;
	bh=kq32TDx963rvn6JxiCPL2ktzVuJGHjz73uyDDlkqYPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cPSuJ4cQ9FGZ3efQbg3P7FSLRfIQ15GqhG1BDL7+SgOWmaSSRmlpFSBL1nTFO6fCXHpUgqb7INgbiPVEL9XahHRqtt3BHwzd4yK0Jm5lXEAPOZ8Lrcqb11H69J8ktlcgfG7V3tYoWgHEOHbrv6IHe1bGJisGxok2ep8lQ2SZIfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IX0FXCSE; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-7106cf5771bso1989421b3a.2
        for <linux-ext4@vger.kernel.org>; Sat, 03 Aug 2024 09:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722704291; x=1723309091; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pgNLTzcVm44OAcwddQqqMR6HzAbI2a9P0QcC/5jpyKY=;
        b=IX0FXCSETLr4qc9c9ehMf56lfkJ3EF+Xrb3sE8Kf4muL5c/g3lcvFvQfFZJgoqajgY
         3pKj6dD49yahvmnBTKs/HnF6Wt3l6UORvBhTLQxuyeSEnLp8Pw6gGRpLfwvmRYbkmmVm
         hEKMOiaaR9AK2127R4GMDd/WznVyqBEY259Y/z6SrkHV6OJAAYfAOhEaDtrexhctD3tS
         +2PGl3YvdVmdWyThw1JTRRwjA6Y+bvAweN58fBLaBPnZDpNQgG+ANpu6ydILoRtgBokP
         XS/xYg3r+lBV9+AwY+bwqnUkSMDhb7dsj0HHgmNGCu5Z+VB71f9eumt4+e3Q7U4sfWdn
         0Dmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722704291; x=1723309091;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pgNLTzcVm44OAcwddQqqMR6HzAbI2a9P0QcC/5jpyKY=;
        b=j1MOTmO1fDy/5lNLVjvZvr/NjuRKwMB255KveofXdsycnLxJK6J74SaD0B4CWWed8L
         2VO5BpKLwHAspbLNgJ2M5rbo3WzAMshx8fp5VR3ysJDRDeDNEPaH8b8Tsduyv9OnsXLu
         0bCyYWGsyd7gb/Q5Qerx4k76IXtOBkzW1dHUgsnoKNtq0geslq0IY8riB98UaMfK3jiX
         Wd8epK15L6cgNFVZuhuMHfS3k+8PoM0lr3BfMRATcW4+BU9a0MsqjWmfmJUdfrO7bKW1
         RrJqXvRQJli8H5PVYqW6ofKZCZJi8TmOi9I99SPQHHCYhzWO0+Yzr2+V4h7JSCz6ebPr
         PzPA==
X-Forwarded-Encrypted: i=1; AJvYcCVI3Ktr+hLSe2yw7IH59jjl4RbkvSJzceOgK8ooBcOBW80P/zkUTa6YVUtG6sPyMRxPD3VZC81SlMBKYrNA2cq9LmvwdKD6ZAnItg==
X-Gm-Message-State: AOJu0YxVnuH0RCWb/HYYv3N70Ow6MaOEwzuTqRcA9Jl27dLiFTX8XBVG
	252KoTq75E5A3mldi48KDUF/YAHth70nw9pm5jOjaiI2Qnyb7Ycd
X-Google-Smtp-Source: AGHT+IEaKLqWmmYHcHMNYI8LqMHVRiSZkhZQRq36G9JV3WMvVrNZ31qfwQLXgOe7lrH4hJds7h+mSg==
X-Received: by 2002:a05:6a21:9ccb:b0:1c4:8690:ec24 with SMTP id adf61e73a8af0-1c69964b827mr8127421637.49.1722704291306;
        Sat, 03 Aug 2024 09:58:11 -0700 (PDT)
Received: from localhost ([103.121.155.92])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2cffb36a1c2sm3732458a91.44.2024.08.03.09.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Aug 2024 09:58:11 -0700 (PDT)
From: Shibu Kumar <shibukumar.bit@gmail.com>
To: tytso@mit.edu,
	jack@suse.com
Cc: Shibu Kumar <shibukumar.bit@gmail.com>,
	linux-ext4@vger.kernel.org
Subject: [PATCH] correct the variable name of structure in comment in order to remove warning, seen while building Documentation using make htmldocs command
Date: Sat,  3 Aug 2024 22:27:37 +0530
Message-ID: <20240803165755.29560-1-shibukumar.bit@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

---
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
2.43.0


