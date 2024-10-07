Return-Path: <linux-ext4+bounces-4525-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D1759934C3
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Oct 2024 19:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146601F24B01
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Oct 2024 17:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8B021DD550;
	Mon,  7 Oct 2024 17:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ALKNzRJj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A9E1DD536;
	Mon,  7 Oct 2024 17:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728321622; cv=none; b=Ivj4HiWFJSqhCjkZhR+dxKTt8Gn1d7Sf4oUumG3WJrGoqBzK3+aiS9nzMgfSWWW8WgaJn+NXbdEVrx/HmPqBS93PiR9Z3v8pSDbi59sEbkxxE1wR+byTDGAb4QDJJ64BBy2ChlGbHqLDoQesJaU/JQ+HevJ5beY1328rBhPn6UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728321622; c=relaxed/simple;
	bh=+nHdP0CRzxXGYUNrcO8SvBJYed7YBYWo/gPX6y3dyXk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mFYk3mUKHXgMOuo8KWoDukdzYLAHqxqlGtPZICo5JR8Pg3NiRtDPIe9OkgNc6F4o5sizX7OOtpLvUhoAerhgqc2dg1hw2tklSee0PdHwfZCkQFxbZb5ab3nZf4hzYj2JrGbHQ1k6zkuN8ILAHQ4yBTrpp785IMG5MDeuTwCWweM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ALKNzRJj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-20bc8cd7134so4187315ad.3;
        Mon, 07 Oct 2024 10:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728321620; x=1728926420; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=an0L/rV/vkBqGjIrfNcu/hfafXdqkuQOyhzA7vdtBsA=;
        b=ALKNzRJj8wO3MIHmtjF/1IN5EPdGtkCL/ESZ1+zyJqrgxwF6jSFxDE1JUAQafO5c1i
         w7ujUL8s8JRrL4eSbPkrW7cq2Gpu83E6liZDu6KHEKdD+Eu0TMDFyhIjpe7VNvZwiREz
         fZPWIRg6CE2ToOKEShbhaN1dmsJt0RQSKGjk0po4pmLqXdP63+TteyOH7wXu8+MAMvn2
         Wf5rApOYer99izXqQ7JBad3MNAKDi+6YRp/t+KkY7uYiP/MWtl3+FjPC9aqqctvsaiNj
         m8NrhVnjK0j0OsSgHzYva3i3zN6tR5UsG508Gjj1q9ngKlk/Ij0hupOdVfijxCXRQVr1
         4eZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728321620; x=1728926420;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=an0L/rV/vkBqGjIrfNcu/hfafXdqkuQOyhzA7vdtBsA=;
        b=drXMJRgTczow5PX6QxSIXdeRFNZGRqCUnsrBHXvwbe/+EHzRpfa1UWhPcIoA7isFuJ
         nu+GYY/1INAvGZofM41t+WVoe9DynolpGI1qmKrVXeQU3+W9wtNjKhvB5DaqXO8VzdzO
         d5SUBTBieeUigeKAAbcYT+e97Wl+1TSad5NVuASca4kCAj4BFSx9lkXAR80G0hNyCXZT
         2jkFImdBujcYXIUgI8o3e5l1vKscVfnIqaVllh2hUe7bTu2ZD4m++xB+OoFmJmyT3wlb
         YSZsB9H/kUOL/gPxTM0EwtE2uitSEnlxwiluCm2KmIZU5U4VbQZ3znhl85SnqiFET2AW
         oG/Q==
X-Forwarded-Encrypted: i=1; AJvYcCUFYwCcDmsJ55kPFzN6zLYdxVkjO0TFZYVfaLCdLJLOAB4FIL+c3UBWLt/hKhwANubH3g0DoLVJ9ZMBxzc=@vger.kernel.org
X-Gm-Message-State: AOJu0YylHbFejQkjMuf/cML6kgFWb9L82KisrVEF42WFVtOqcSsgBd33
	KU67GElx8cncjZfwASUtX84NtVdEW+wk3yq0Pha7FlWVYSDkZ8uo
X-Google-Smtp-Source: AGHT+IHZv/1UbXr0nVyHk0fU3ne8Wddj62YTTctd0f6irMCtLxyT8OqXsm7FHu/4BWoLsEKSU9fJxg==
X-Received: by 2002:a17:902:d48c:b0:205:861c:5c37 with SMTP id d9443c01a7336-20bfe04c77bmr78308495ad.6.1728321620188;
        Mon, 07 Oct 2024 10:20:20 -0700 (PDT)
Received: from dev.. ([2402:e280:214c:86:a843:852f:eac4:ff92])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20c139353f3sm42243025ad.168.2024.10.07.10.20.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Oct 2024 10:20:19 -0700 (PDT)
From: R Sundar <prosunofficial@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	riteshh@linux.ibm.com,
	R Sundar <prosunofficial@gmail.com>,
	kernel test robot <lkp@intel.com>,
	Julia Lawall <julia.lawall@inria.fr>
Subject: [PATCH linux-next] ext4: use string choices helpers
Date: Mon,  7 Oct 2024 22:50:06 +0530
Message-Id: <20241007172006.83339-1-prosunofficial@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use string choice helpers for better readability and to fix cocci warning

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Julia Lawall <julia.lawall@inria.fr>
Closes: https://lore.kernel.org/r/202410062256.BoynX3c2-lkp@intel.com/
Signed-off-by: R Sundar <prosunofficial@gmail.com>
---

Reported in linux repo:
tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

cocci warnings: (new ones prefixed by >>)
>> fs/ext4/mballoc.c:4597:47-50: opportunity for str_yes_no(ret)

vim +4597 fs/ext4/mballoc.c

compile tested only.

 fs/ext4/mballoc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/mballoc.c b/fs/ext4/mballoc.c
index d73e38323879..49dd27c2f2dc 100644
--- a/fs/ext4/mballoc.c
+++ b/fs/ext4/mballoc.c
@@ -6056,7 +6056,7 @@ static bool ext4_mb_discard_preallocations_should_retry(struct super_block *sb,
 	}
 
 out_dbg:
-	mb_debug(sb, "freed %d, retry ? %s\n", freed, ret ? "yes" : "no");
+	mb_debug(sb, "freed %d, retry ? %s\n", freed, str_yes_no(ret));
 	return ret;
 }
 
-- 
2.34.1


