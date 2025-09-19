Return-Path: <linux-ext4+bounces-10250-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEC45B87B1C
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 04:15:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8369C1893BC3
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Sep 2025 02:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9427C1F30A4;
	Fri, 19 Sep 2025 02:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RsVLoyJG"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67391862A
	for <linux-ext4@vger.kernel.org>; Fri, 19 Sep 2025 02:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758248096; cv=none; b=F+Nxv94kHNltc8/CbqXK6vaS/Q3nk7B32AUUpgcWL8TXU4LWTtQKjR0YN9fI9l32HaWBA6hcjUFWHr6HADzEpm8Hs9ctnamDQM+JPd+WiaqI/qRzDkBTByEIbQ/bzFB39/9Y0Jq6u3qza4Y8BURyn4KxYVcCuu4VNNIZrwVE6Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758248096; c=relaxed/simple;
	bh=AwRt98PLF+0uNY1wnFqWynqXeGH365J0oHAiztHFnH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k85lOrgdrB7Uo2X1pJAZO+74aYWNDeqA+T7+yJ1erShd0jRwrX3iea378NAWE1Rc+kIyksB2j2fK23s7kDX9m4LInuZnA0Ni6IhO11kSIK1D7IJR1xo8iGPj/mM397AdKde9WKVRFsrV4gfN9dwNh+drYXOXBeA04tOXhfIYXto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RsVLoyJG; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-244580523a0so17537235ad.1
        for <linux-ext4@vger.kernel.org>; Thu, 18 Sep 2025 19:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758248094; x=1758852894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=CmYWM8Z/roMtlrp5aO89HRVded3LToe4TxL6a/RxYVM=;
        b=RsVLoyJGiVEB+KfXQGeuSJ9c4w9W9U+dFQ5FN+T0Gsz9vwAWozON0Ak7oTBifYeun3
         yL9O4KdeQjRUp300QvkL53siP+C7dCr/p4kYzjcVjwuFbUteNndC+yDTwsv6DutCDW8x
         ciatJEJpmmnjja/xlXp+kr5DPLzXgyOUQvpUdS8voQCB35BMVdCIYuoMY+Nwxd0WJK7i
         BBCtoHghPpLBxpvFrRpbaYzA86Q2xOLaNp71bLg2u5zj/GxeHlY44Rk4D+ywRSLXmDGD
         15l3PodoxXY1HGSgeKWt+NUWuJfRjBxjSjYRXqN8V8I8WwINq96Ta9fUKS55LEwhl4W/
         efGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758248094; x=1758852894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CmYWM8Z/roMtlrp5aO89HRVded3LToe4TxL6a/RxYVM=;
        b=uGZyLrEFIV/kuaXziwXYzblCEn/To8ama6xvCgpwleyICeXXW4t3wbjdDwHsO9+dPj
         YWPRNTAk+asPV2rzL/HYgTBr9yOrMok8e9yhsovsafePAgE3cYTJntIQ/W+sltcy7vrb
         oKnWfXPpP+8ZqfJl4XXzczCiu7+g81KKBF4A+7JWN4MP6UTorFOh7l/keDiU5ObIEjkt
         wO9a04my6L1yOloOEyr867sjR/gReSyZl2inU6XP3I42zuktBvlP3tswscekDWvRwqEe
         RJV48R+O2Y5Ecv27RXxjA1z3j0FLftLuHCIlbaZxhLYE5DF4NfGl6qfXKXqZBaNLJ5SI
         H0oQ==
X-Gm-Message-State: AOJu0Yxqe+n+ZkUmhggYefjyNdAUwLzAqfi+h1Ycc6VZo7WLK8g2yDxZ
	sCmHwygBkuT4HxafP7UHyPqx6TGTWMKMmSEg2kYLmyNLev+Dz5bV6YO0
X-Gm-Gg: ASbGncs+ztdtecwFfzg12ZTUmTik248NLWqK/1JxHCtwoOc/I1gvUwi+6Mgwc1FqPY2
	AFU9QJAYHoAxMtae4xuoRyxZHH6GGG0WlqPcUfwaj5g8VwNip6HXKVteWDW568apHrgeeWHv9ig
	Q5WlJ03WzQfbVqhlpYIxgQGd1pql1VhH7pX/RsTkhlGANFcpgLn8GXqPNMsXzPjh+7Y3IbCIu7W
	0iFk79ABILCnq5eX4SoOjcO5LXn4kduSjoxxlo7/jQviL4UKRBiOo8xia92HbFydEvQ68Z2BYzh
	Y8l4bHF3sVYnK+DtWyVpOZZs3F20vvLGSfAl5XP6oO3MasEnvJypAg1yFcIJFSjxarsqGjoFgWC
	RjCrbcGapzc/xpdlPqsk1VyYMC5N+Y+UWSar8QxUKrIQsdTOW/Hyx1U9FB6ewT1yBxG1ZaEzew2
	Z1rR8=
X-Google-Smtp-Source: AGHT+IGZk8lulv43wFeeFKyhgMFXOt58nduE8m8AkCKHwb/2IW27w9tnYsQiosN46ioUVw8GcvIptA==
X-Received: by 2002:a17:902:db05:b0:25c:19b4:7ae3 with SMTP id d9443c01a7336-269ba476d87mr25918995ad.24.1758248094030;
        Thu, 18 Sep 2025 19:14:54 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:9a89:926e:b413:48d2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2698018a6b3sm38733775ad.59.2025.09.18.19.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Sep 2025 19:14:53 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: skhan@linuxfoundation.org,
	david.hunter.linux@gmail.com
Cc: linux-ext4@vger.kernel.org,
	Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Subject: [PATCH] ext4: fix allocation failure in ext4_mb_load_buddy_gfp
Date: Fri, 19 Sep 2025 07:44:46 +0530
Message-ID: <20250919021446.534097-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix WARNING in __alloc_pages_slowpath() when ext4_discard_preallocations()
is called during memory pressure.

The issue occurs when __GFP_NOFAIL is used during memory reclaim context,
which can lead to allocation warnings. Avoid using __GFP_NOFAIL when
the current process is already in memory allocation context to prevent
potential deadlocks and warnings.

Reported-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Tested-by: syzbot+fd3f70a4509fca8c265d@syzkaller.appspotmail.com
---
 fs/ext4/mballoc.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index 5898d92ba19f..61ee009717f1 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -5656,9 +5656,11 @@ void ext4_discard_preallocations(struct inode *inode)
 	list_for_each_entry_safe(pa, tmp, &list, u.pa_tmp_list) {
 		BUG_ON(pa->pa_type != MB_INODE_PA);
 		group = ext4_get_group_number(sb, pa->pa_pstart);
+		gfp_t flags = GFP_NOFS;
+		if (!(current->flags & PF_MEMALLOC))
+			flags |= __GFP_NOFAIL;
 
-		err = ext4_mb_load_buddy_gfp(sb, group, &e4b,
-					     GFP_NOFS|__GFP_NOFAIL);
+		err = ext4_mb_load_buddy_gfp(sb, group, &e4b, flags);
 		if (err) {
 			ext4_error_err(sb, -err, "Error %d loading buddy information for %u",
 				       err, group);
-- 
2.43.0


