Return-Path: <linux-ext4+bounces-9653-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B11B36E75
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 95D6D36823A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7813368098;
	Tue, 26 Aug 2025 15:41:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="NpSH2p4T"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC663629BC
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222892; cv=none; b=kWl6m4iJ79X8jbzZTnmSkVvc9oR9jX+AWcLHf86IO9ANPLtjWSkPumqy9jWlkuTim1UtOIJjNIlan6oVXuddIoZnxRMWtYK5bl+8e7N/37pw/waQ8wa/KU16ziYQI3hw6ownQMnSR4ZE4Ce19KYpjNB9WIq69h0DAvfhls3uAWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222892; c=relaxed/simple;
	bh=da2l454EY3RDXmu4EckOSRuB1DAXzvcsmcg7FnzAFBA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=idMIrEAWwN9syz2b1/IIc0k8FFe8uK0iTeTvrsNTUQLttXUkgY2AjnMZh2/HB9V5XGkDJ0v8idChW+y/Ygwf+nuVnUHXFCuc6LJV/LgrqfoH6ojNwK5+j3jWkRYhsEwmNyu6zdCS4IrNm0EYg/7ZtJBseiU5OFbBI+v0WEJ/uYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=NpSH2p4T; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d603f13abso50817997b3.0
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222889; x=1756827689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1J8X3O3fTDW+jaZZ9ZUDLQSX9BKwP490GcePdQCSTYU=;
        b=NpSH2p4TwrhYqyS+JNvyj2RFxnRO8GderDQpdNwrEtTwAl6etuRWZC0DxEfavawTwr
         JN9oG6Fj5sQf3hsTt8bUNwA98mZ+FjJrmIMs57VdAJ0u//t1x+6G+AatgmBBqgtQeOcL
         EjdHR6EeE5IGJyXx4wQJzJaVYcJDocwsiMlsSsqRdqNazntvaGkEUaZeeGQLXt4j3BwJ
         NG5CKPhg10u9fMotJh80BBGfrfOzbZy54EdJGY//l//ru3UIugRLrwenwxpIFDqw8k44
         yI+RPEaXO7z1pGffmoHJ0gznWoXgnw0mgjuam2HhRefh9VqOfn7OmIp8lw1ijMGQT5A2
         bbJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222889; x=1756827689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1J8X3O3fTDW+jaZZ9ZUDLQSX9BKwP490GcePdQCSTYU=;
        b=Czg7CrCfxU2tGGHXLLidZ+fycLQUix3TYBfFoeNg65tOxatNsYofxWvlclJdNpN190
         Nlz6iFsvw7/pLkRfHETtUnLLPDdrgH8E20ahAZhD3r2IJ8RW1PNmdmnOggkC34sPZ4A5
         /CvTJYkCDe0XwUC1UNWofy6XFXqxa0yyCtqx9m6+5GDL0hLLobLXs6NgF3MXxfgHc1VN
         9fHS5towg0c21XMTkuRS0TwcmhZ5ISDLgwv6pgziayKTV1+AXV+b2q7D7FVygqdtmEJp
         NKwTG8TTmDrIftKsvm3Da3Nez+RCPggblclk23jgrHd5HX6e/k6+QzOwGnSuIucaFYGB
         SLyg==
X-Forwarded-Encrypted: i=1; AJvYcCVc30Xuqw0njXVw8OgI5BP5x/buaBinU4k7OZMtrC+R/AzXgKhAdh03mzr4ZZ4Z3/rXO1vI/HXhvMyx@vger.kernel.org
X-Gm-Message-State: AOJu0YylcT4sZpgRVMzUBBJBvKzK/5PYxq+2n0R50a3C+MuH1+2JABsQ
	938Ex9bW8jXjiFdN8LJogmMnjmbkiHzgGq6ad8pae+E+K51QxA+s8nRGqtgqJmjcCEM=
X-Gm-Gg: ASbGncsPWmK1aXTZegJlcJ8J/OP13mH98g4lRvDWEFWuRv57RiHXjYfJ+PnoYEcvoVj
	8tDPg+w8A1uZkg7If6wu5LF9I5ATfA5DyZmDjcSsVcE7DNC7Un+pFzDGSKTgOuOknbCaOWiRIwI
	gQWyWZgUnaRLwzwSl6CZo3lcY6CbjfQ9wIgU6Whj55+6FBN0PlDcHLq8pB+g16sScJw+e9z7UDO
	Xf0zOtpNMXenq8NmSyFZBLrPavWYeY+jPIhqyY2+UlfKIPfEKa9C2Qel5ujm+TBe+y5qQz5129F
	xEXtGn8uuXQ5UOg15sKSFOyw5oT2zeG4ltAopU0QQjbA9RBGrMAHsyH3OZGsW2rzM0cNPxpCCHs
	yXkhAcXwbK3U6euuRmWwkDeB0d1fWPx1oNVy0GKci4yexhGY84bf9J2HdM80=
X-Google-Smtp-Source: AGHT+IGeqctPLqrW8y8Jmm08bG1yVz3laGgupDgU9tlxtVYuPYypXQM+Rifx08nHERJsv8bMHECX7Q==
X-Received: by 2002:a05:690c:3507:b0:71d:5782:9d58 with SMTP id 00721157ae682-71fdc2b731fmr152872667b3.8.1756222889415;
        Tue, 26 Aug 2025 08:41:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71ff18ee79esm25043387b3.73.2025.08.26.08.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:41:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 28/54] fs: remove I_WILL_FREE|I_FREEING check in inode_pin_lru_isolating
Date: Tue, 26 Aug 2025 11:39:28 -0400
Message-ID: <aae290b95e0a84f47145256295841c2d5c533d9d.1756222465.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1756222464.git.josef@toxicpanda.com>
References: <cover.1756222464.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the inode is on the LRU list then it has a valid reference and we do
not need to check for these flags.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/inode.c b/fs/inode.c
index 082addba546c..2ceceb30be4d 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -666,7 +666,7 @@ void inode_lru_list_del(struct inode *inode)
 static void inode_pin_lru_isolating(struct inode *inode)
 {
 	lockdep_assert_held(&inode->i_lock);
-	WARN_ON(inode->i_state & (I_LRU_ISOLATING | I_FREEING | I_WILL_FREE));
+	WARN_ON(inode->i_state & I_LRU_ISOLATING);
 	inode->i_state |= I_LRU_ISOLATING;
 }
 
-- 
2.49.0


