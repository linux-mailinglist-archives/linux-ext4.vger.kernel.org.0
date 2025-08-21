Return-Path: <linux-ext4+bounces-9549-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC29B30679
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4E39F4E66E9
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 194343932D1;
	Thu, 21 Aug 2025 20:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="l+PlcfAE"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB0CE3921A6
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807693; cv=none; b=n3ULBbEqjnktfPNLUaXL//XCAVOU9cGdXsYPqJWkO5mud5k1UCzpraWMkYdZLTKny3SfkRgm3GfAVUx6BXFvScBnofh7OH8LfaHHqmRzOnGBmFd62hNWDUtusBz/H2hbu3g7iQ5Xa9F/nVf60ImBuwF2PTQ1p2Rswjk6JlfGrj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807693; c=relaxed/simple;
	bh=K7JnBj/EGzyS1OdbBFrvkh4RZsBpYi+IyFwAgh+Lb+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BQN5yAHbDc29II0sJAryfe65Km8DGOCoJ8NJ3Hq/koFh9QaZIMJOfm+268kX14D88BOe2LSy9o9CDBmB6n3QfXKIrnSZ3aqETYgGhYqrsN56R6dPBdYhu5x3CEpy3jW6IB/aj2fFmFDUqNMVbpx+ShHPV7Pxq/CT5fqxVyiPHr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=l+PlcfAE; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71fd1f94ad9so9271627b3.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807690; x=1756412490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXIzcijPr4pONzroTEWGlRY1GomK1Uf0HH+VMUMLr6k=;
        b=l+PlcfAEmx5i2V8op88cnpZsuRkMTt7IYc41Sfy+HSvLebZfCwtTQZvCH8Bk6CsjJt
         K4jx60j64kmerkjnRTZbVcPgHZU736YIo+p+ZDF8yz/jjL9nIwB+u3m+OFY+rMpWwLAl
         7AH38QWbHlSX645VekRQcQVsAecCcb9p4J1Ml6vxH4WYtcAhaeCvGHNKmZjd8w8e611w
         KQ9KD5ssYCHEffbvY4RRx+FZBsp9k1jgMDuNc2cVHg7U5MhMZcTgIhIFOATLoc3Kciwh
         X/up8AhmF+Y5tChZcdZoK8E82UBhzCXt62EHRVx+lw9Ko0RyUcMS/yw0j5SMCS2XWAQi
         L/vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807690; x=1756412490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXIzcijPr4pONzroTEWGlRY1GomK1Uf0HH+VMUMLr6k=;
        b=gm2MAcw7izky5SbPJw1YxnN9m8L0w0D+Rv74nijU5pXOssvlxoGE21tnt5FiNAKJkc
         B4pEp58Le1f6XTjCvLhDQzPm1tffHpbQSZjPgdM7Xu7sjVm3DbJVu77liFWIFwWuFvWV
         gt7UWMN60ddAUHnPTMxLqyM5V4VnN42siB1wTks/Fc8jRJfUyuHz+asPHzdJ5fhdkjkA
         BLw7cqTSDiHQEr6dibbrPfmAgUPbblD8T1e7qD2MQT5WFwl2uPa+RxI/WaaziLLrLST2
         PT40+PAnBefTTyrGhikZx4hEX82Luw2wwhfb5KQnKQUc7Q6RUOfHm/14LTdJLK8+r0qZ
         OpRA==
X-Forwarded-Encrypted: i=1; AJvYcCXnW9hSSkE+b9Wq7iKnuYGNXTKEUFBEhzz2b3H1PNjPvPExBlhnp13koUJvhND6ldURjkWNW82RVnUO@vger.kernel.org
X-Gm-Message-State: AOJu0YwT1Cll3uIbQUcjlKGgkvBFAKHXaB+hc8JNbYhbI9JXX6OHVgQh
	DiccJgOYJsxeLmKGK1Z8bHONjfAD+Jxk0jk9fkuhp1KojmSexfxjnho0d5p7fR0MBqr8UvOfy/a
	78fEsHK2dww==
X-Gm-Gg: ASbGncvzfO25um+ZCyDX63Vx1ve2GjB4vPLj4Hs262SQQARrhDe3d3vKa1qjuACfhYd
	/NwBeeE3lJ0qbBkIaiL40dWSVX0/omLT/tL+miIBe/xljsObEZqUL2cVL01D7xVyGQRfxZ9yJk1
	Ao+5DeYlfmsp+D0vMBs26X5nSXjetPLGYzOXjEmorshYmjpliX4IyGBrPOBEDcIZSQFOeJgqVlA
	DyMEMLrxJCx8u8yLuKME7/C52p5wwImAfqB3LLtdEassGY4/LPYI/A/JMvvVUgVoTBy98NOyP4S
	PawjZ11k3jV/eaG9lVaHyjhMIcA34tbRQ54EwrDqGq4lT9HcGK3eqfaXxHPwV23SlPwT2eT19H7
	Sp+z24a1V542mwXFug8jwX6SEBfHLZPcTbYQbw6jyhp/eeHMSm/cOIGk1OfIl26LSbOIwAA==
X-Google-Smtp-Source: AGHT+IEO30NmlKq6gjexRRcDwC+IutcN4FswlbECizygJkS4EjREg3MgjupO6wxhwVTETYh4w1p4cA==
X-Received: by 2002:a05:690c:4d02:b0:71b:f755:bbc1 with SMTP id 00721157ae682-71fdc3e00bemr5400007b3.31.1755807689657;
        Thu, 21 Aug 2025 13:21:29 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71faf1e1459sm17292517b3.60.2025.08.21.13.21.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:28 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 48/50] ocfs2: do not set I_WILL_FREE
Date: Thu, 21 Aug 2025 16:18:59 -0400
Message-ID: <c00734df0a9773105cb274cf924f04ac73b3c4e4.1755806649.git.josef@toxicpanda.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1755806649.git.josef@toxicpanda.com>
References: <cover.1755806649.git.josef@toxicpanda.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is a subtle behavior change. Before this change ocfs2 would keep
this inode from being discovered and used while it was doing this
because of I_WILL_FREE being set. However now we call ->drop_inode()
before we drop the last i_count refcount, so we could potentially race
here with somebody else and grab a reference to this inode.

This isn't bad, the inode is still live and concurrent accesses will be
safe. But we could potentially end up writing this inode multiple times
if there are concurrent accesses while we're trying to drop the inode.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/ocfs2/inode.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
index 14bf440ea4df..d3c79d9a9635 100644
--- a/fs/ocfs2/inode.c
+++ b/fs/ocfs2/inode.c
@@ -1306,13 +1306,9 @@ int ocfs2_drop_inode(struct inode *inode)
 	trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
 				inode->i_nlink, oi->ip_flags);
 
-	assert_spin_locked(&inode->i_lock);
-	inode->i_state |= I_WILL_FREE;
 	spin_unlock(&inode->i_lock);
 	write_inode_now(inode, 1);
 	spin_lock(&inode->i_lock);
-	WARN_ON(inode->i_state & I_NEW);
-	inode->i_state &= ~I_WILL_FREE;
 
 	return 1;
 }
-- 
2.49.0


