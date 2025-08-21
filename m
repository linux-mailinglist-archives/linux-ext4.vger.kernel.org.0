Return-Path: <linux-ext4+bounces-9542-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14474B306DE
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:51:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239E71D25FC5
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAC637440E;
	Thu, 21 Aug 2025 20:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="0EALgZJc"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD23391955
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807681; cv=none; b=pAzJBKQ4QhPsUe4zcYTMsAgTe6ykxiyaDlWdFRb42NIa9go9VXjuPlbW4PASHh3dVMmowZkcpQRFgw8BMpsacY4R5XWM2UqXV/V7KrByE9f3iirgFAaKoV8IhrvAv/RfU4F9+AlxR9AlNF9ESdCiyne6BRC8LXZWxmRrsIplsDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807681; c=relaxed/simple;
	bh=BVFzQz5MM2vwh8WuHoPp+aDwxtfF8jTQaeq36xEpnFM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BsRNe3gutNmxaBGwN/CdGV/i5VVjOS2hf8hKpg9Uj/JF2fFhhvHgyeacYuSryGyg5LvzgekZDjNiaSwWvJ1KSDBDxceMWeZNkg1bicAD4+Za2R2v5N3ZCfegE50yEDxhUEL2LUJy/l/f22VE0P7rcBZWPJShxX1DSeo+TSbHWLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=0EALgZJc; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-71d603b62adso12398827b3.1
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807679; x=1756412479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OJwH/2/AGfycifeN3K6mTcfvLjDiixS7hIcYHA0w3vE=;
        b=0EALgZJcGmEUK0G5O4pBhDWjcwtTiKu+ML1PFtFlnWJLRWnwJbMhtD7NKzAGLKSRyI
         2i2/21mj1G9SYs9Z52Gl/A03sJnpqd2vBA454oH5a0eECCXsjdVFRaveguTqQPLgXAIU
         As14Ad4hYniOV7Q/TitFvLF3BntzNRuAPcAjvWFHPffde6td9E82QvN/Z/F+LBuMDnz8
         KFq6dLUDp0aHPE1Qn1w2K0Gb12INRu2JLYIwaYgTYR0173ITncGGhgZefOjLFgsDoiT5
         pbnfUwmw7IN4vbBg4GJ6hd1qYtTfHIVcrnPRCqFGccfNWl9yM/741WuqSNMz3/IexkdE
         hcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807679; x=1756412479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OJwH/2/AGfycifeN3K6mTcfvLjDiixS7hIcYHA0w3vE=;
        b=hPZJG3OcBF8j3NU1616Wd4VkBTRuYxA4H11KTTtMaf4skKffkucy9pusH3dF0VR23v
         84Ucv2I18fcctAsxOawYCaLMqyoeMbGB4tm5qZEb0Hk2toJy64BSsyHI2KUQGobp04FF
         QI3c7GBI2u2g9vzJaD6kOqsFRuvGuxgoUd28hOM7Zhp5lXLDdXk7LH6IR2pQBe+lAgp0
         SDpuAI6/Jq9GhQW9koh1WOi7GZ9mtdEEHRzw4TPtUhz2IooyLv1Y48Ro3VeZpK1KTyqr
         zcCG9hnoWirrQdFgu6dS62mWLu8F/m14Io8pGD0HVROCZr/6it/0lli5R4Nh9mK6yi3P
         W7Pw==
X-Forwarded-Encrypted: i=1; AJvYcCWU5HqBt7ieeWTpv2OWTUbl5r0BM6ayUfFvGKiXEd9vBo4vG33L9gtDKT7TyK1tRt3jaTJvJ1xpgT1S@vger.kernel.org
X-Gm-Message-State: AOJu0YybaGJFHKTzZphZSqIAWvHD/5fnmZDy7uSAlrN2WucL0Zs9+K02
	cVb681QCTjnmXbX1xvKB2bbE4EPEM4K04lEXM2ppRnqiWBbK3HCzeozF+J2f++/gbek=
X-Gm-Gg: ASbGnct6dZx/algXX4NokuiO6icke9PMR6BpJ9KyJyW7ExIPShURMWEek8Qj1sWtpbM
	hl1Jq8CtSkQwpW2VvsIGjXA5gDprHiUyT1R+C4NTzgDFLhth+EktWkyE2CMlj5QNDp07tM7lPce
	B5+jMWvCd7/J17/9QV1J7b+Eu0NB1gE6lWCxegdVOPmUGhPWf1z87FhzzIPvW/l7dP2Vvz59dWp
	8n3+rWpcrUkIx3peZnrX+8GzgimEVN7UURDt3ydICYKIdA6NpBFEvzqhaSRSUdikFXZ6x7oTt0B
	aN7ydMgd6mjdGh2+RZs/pAvvhAgzU023EPto8Pzovs/V26osZ0eA1iE1Xxuiyxyd1Z62TFzFeIz
	+eUAKouZvPlhjLk91Y69aAdh25Ewd02yj9aqzIbKaqhtrw1VZIYowYXaanC4SFlIydV5nGw==
X-Google-Smtp-Source: AGHT+IFLh1NRGdke0rPvIun6BwDM+j5CUgCx0MIDgv4txaYGE9873VFVFQQgPIyDR56MDTrNJvGMzQ==
X-Received: by 2002:a05:690c:305:b0:719:3e4f:60f7 with SMTP id 00721157ae682-71fdc3e8edamr6284457b3.26.1755807678549;
        Thu, 21 Aug 2025 13:21:18 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71fb82b39ebsm13478727b3.42.2025.08.21.13.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:21:17 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 41/50] fs: change inode_is_dirtytime_only to use refcount
Date: Thu, 21 Aug 2025 16:18:52 -0400
Message-ID: <b4913e1e9613eea90c47c2ec2d8de244e1478668.1755806649.git.josef@toxicpanda.com>
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

We don't need the I_WILL_FREE|I_FREEING check, we can use the refcount
to see if the inode is valid.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/fs.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index b731224708be..9d9acbea6433 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2644,8 +2644,8 @@ static inline void mark_inode_dirty_sync(struct inode *inode)
  */
 static inline bool inode_is_dirtytime_only(struct inode *inode)
 {
-	return (inode->i_state & (I_DIRTY_TIME | I_NEW |
-				  I_FREEING | I_WILL_FREE)) == I_DIRTY_TIME;
+	return (inode->i_state & (I_DIRTY_TIME | I_NEW)) == I_DIRTY_TIME &&
+	       refcount_read(&inode->i_count);
 }
 
 extern void inc_nlink(struct inode *inode);
-- 
2.49.0


