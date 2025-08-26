Return-Path: <linux-ext4+bounces-9675-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F8AB36ED0
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 17:53:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 523951BC0E9A
	for <lists+linux-ext4@lfdr.de>; Tue, 26 Aug 2025 15:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3502E372898;
	Tue, 26 Aug 2025 15:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="CcXmBDoi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F04374261
	for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 15:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756222924; cv=none; b=JSYZz0wf0YtfzyOuKExxFjJQxHI+2V8El2Qe2MJSXdce7UL+ey8wV3hJeFLidrzcfvYGXgy5oSK6m76N+ncxmXaXXO9+wmgwu7SzTqfu/B205oDaKSCLFCrW3736cIYA+Rp+WWIHTbGDr8IxSY++B1eAUC26zeDQhuTkRGPAcrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756222924; c=relaxed/simple;
	bh=K7JnBj/EGzyS1OdbBFrvkh4RZsBpYi+IyFwAgh+Lb+g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkFN+2ZS1lC4Pe86cpnzWeSJSJpV3KRlF3fWhYuqU7Wr35aumlNqkdYbeztUqWjvDlXfM9gTrVob/LXkXYffV4TPwub81wMYMwDvkA7jSrZQOm71giZxHtx+6/V9QNwCrVBypSNMx2Rh8GUvwjryuwQjP9IVo7zQWgq3VGQT77I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=CcXmBDoi; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-e9537c4a2cdso2415082276.2
        for <linux-ext4@vger.kernel.org>; Tue, 26 Aug 2025 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1756222922; x=1756827722; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jXIzcijPr4pONzroTEWGlRY1GomK1Uf0HH+VMUMLr6k=;
        b=CcXmBDoiH7UHwsRT60LSrV7SmnGq9uE88meV7SsSNmbGtSiB0MaDV0cz7q/u4sTW3Z
         p1nhA1FYvdd068iSgfZ8hHeMRYbsxtC4YPMwMv6pH5nYjx00Cu8JdDmqCF0Esa/ngR48
         e1qZRYwUBc4t//MSjfW9+RKVB1nMOcsDzNR5jIAe0iHgoH8MVAivUGYpr284edYy+6Xz
         Yl7oj2ONs0ldfR/rfuoryj0eRbsV8IztfW6KjoMasPBSsDLTOJEu2bbV0dVye3MOTH8A
         azX78hj5p7p/kD7w0ILKWjjtukVP102afjtCQYN5XITRQIXWjO1W9yMZpXmA8XFvwyJa
         R6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756222922; x=1756827722;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jXIzcijPr4pONzroTEWGlRY1GomK1Uf0HH+VMUMLr6k=;
        b=Y2tDo4RsyI/l/xIJtsODvTRQWEFvpHQKQVxMQCWennt6HxlCkNx4i+L92HADv1Q9Yl
         GtseFN6VjkC4YwpP639AaeInnIReYzYn4IjCTJ7CdFgzRKkDzbFGQA5yfpaYp8FklGct
         ofoDtNtdnDWdz7F+ZejQqbd7feUVrrX5l2P3Cl2CkX61HEIS0WQEj4S+KdL4F6fQAcZq
         x3/3sIKD8ksL9IxeaD9q9qyD15omG7J3aNSpk1ETBoUjgz8GgB9P61BmosF2xoePJRii
         o2AErzvy2XflBj2FmsNZ7QdpBAewknuuItlXfYcHqkXhzGpfY0GqalsfRhbFmqG4OsJM
         K7YQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkpBo9BYT35Bg+tsubr2CG/vsbkZxoDegQld0rLDIunTf04XIzngjhSFPkVARzlUaDYGFfDpOzd/Rw@vger.kernel.org
X-Gm-Message-State: AOJu0YxozXArh98BlwZx6hV4a4+xP7xHG/gAaTw6W+5w+P8hqvotCv45
	rtLBNKHlgrRQ6UIZzLHkQi1JHnGZEQISKMq6CQagWt9fsY1YIuD0+t5yVHILQPL/Vvc=
X-Gm-Gg: ASbGncusebdrfHTshWJgE5ps/2lT6nnMbC4U9FJLOz+ikkc6SPbC7zon71VVWRgGipa
	wYYAsTJSmeuLQAc8W6Ft+bwFggDedv+Ov2NW1YUec+cPRGcDZbD0dyUncwbXRR4YNhUmr5Ha0k6
	VRyUt0PrLF53iS9Y88X0D4Dzl+urLkg+kZNmbn5N9k2qoe+XsRwctsQiFKxy0HdOMQfvvGeUXiQ
	0Exr/mAp35AN1PtkYenwxIVknRibVN4jAC/P9T04nZpnWIChhhHIpHJTqFL7m5wXHpnl5/px7bE
	Gdzky4Ht4/bO8oldRTF5sEMewp25DpbzbyuYmbYs7Sf4lEWTzz/LXmzV/SHUSKxbZ/P9Ewz01KN
	h1D4iWjOUIrLb812zzzh/8yjGYTwARv7grLpJflh/PMAVXi3xFN5vpDhoxPY=
X-Google-Smtp-Source: AGHT+IHBtsQWSCLpB7xIpgRX+GYPCXlwVtPiwWdiW8tSSeLPJz1VzFydiCu6poBucgjFzua/Cytgwg==
X-Received: by 2002:a05:6902:72a:b0:e95:3406:76d2 with SMTP id 3f1490d57ef6-e953406787dmr12450703276.0.1756222922220;
        Tue, 26 Aug 2025 08:42:02 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e96e9fa5d42sm190473276.18.2025.08.26.08.42.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Aug 2025 08:42:01 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk,
	amir73il@gmail.com
Subject: [PATCH v2 50/54] ocfs2: do not set I_WILL_FREE
Date: Tue, 26 Aug 2025 11:39:50 -0400
Message-ID: <edbfcfda0154042de084183b9670db0e7242eab0.1756222465.git.josef@toxicpanda.com>
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


