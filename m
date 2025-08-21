Return-Path: <linux-ext4+bounces-9526-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C98B30688
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5B1A11D01927
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0086373FA8;
	Thu, 21 Aug 2025 20:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="3FnSnXr2"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08314373F80
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807655; cv=none; b=AQ2jt4rJN2g1obcxujsiYtFBi4R/py0IFi4YVP7XmzZDG0kKP4tzRXzIGTLiI9htW/JbumtnEFbByIGYdZmGkd5T/QtnlgzzY7wFhr2REcrge7eYFSXLrz7xpoMrlKBn4wdyFz7mDwvQje2gMtcckaxu6vwOOvVPvTRHxEXGZ3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807655; c=relaxed/simple;
	bh=0lJmklD4oxs+QmY0EdOdZ2TKHxQWMnxFR9kZzYDsLSQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OMKxEy1JIZp71YMoQiuzXAWBVbQDUdzQw6xWcD/NHYRWbrowHMNrxuWAMnpnC3ZIB/uZaMEPH6lI/zWs/m9Xm/S6iFD34WwTqT9PzxVnehnxdD0W6rV1gBq1yaxSUgWCNAxllvUBmgfh2kZj1N+UrxHY1E9K7QTv/9x9fySZZNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=3FnSnXr2; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-71d71bcab69so12152897b3.0
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807653; x=1756412453; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pjkT2Nr/N4rw5SgF7OU0ePclbgK+JFKERg5adjLRg54=;
        b=3FnSnXr2Gj5yC8LL+E8khTsGRxQamoR5vf1dQWNL4hxgzLoq/lAjbNhEDY+7v1VghA
         hpnXAwgQ/zOa/dK8jd5kYbjpGbKaojRnnoOaDQFsicvONuE77VBScYZiX0x1wkYQcwP+
         /9AhsJDlL6L+2+b/E/BHisu5fzYxOPuQpQvAsOpCmc2rwO9ClErZtv1MD0chfwZMcut6
         NVZ3y0AMCblXREB/tHmAAPERlFqUrw1Qbw2hMx33CoksEQutGTjBXAP8QfUKwT5Ze8N4
         72noxgyDc/0S0dGpqOqnechN/3lyTkk2ODALTSRMOuG7JUENrIlz2pXVS+6UP2Q/SHcn
         YuXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807653; x=1756412453;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pjkT2Nr/N4rw5SgF7OU0ePclbgK+JFKERg5adjLRg54=;
        b=rdFakVj1wp/SUXXOKlYH+eSMMVG2oyLw8Jj94d+z871rnuQAujmA4+mcNYRRgt2t3r
         SsEoOlNJ0Vqd2hxWOJ9AV/3nxHLNkWN6ZY129SRHIvh9F+GwwWNGO5uLk+aD/9p6dJTB
         TxmBJLSUqZvzZuHUAOXJktLi9FO+oH1eXt708cAXiTEyPMX7j2T46jjhk0Q0OGfEcXOC
         BxDrvdT4uiUu/OasweSzPGbVX+4xVRDSSR/6GduNfjumNbtStq5njOgp64ppiXgLAicT
         tjsP+wGbtLtNKhKbMg0Rx/A8GZuN5c+cLEMWYgJ0GBx4aIy98BjlHcSADgGwdjGIFcPd
         72Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVUn9UpYf3WvpSQuZuDiKI+9mRkALviZa2mIC0bFCwpjshGBqYAbe9byiGcYYOojAJfdrjKv/CI1pSs@vger.kernel.org
X-Gm-Message-State: AOJu0YwOvn5331chUyFc406Otf3pPob9SpTGLXjpxKRF2KS47Alh/NkZ
	C1Rs28KkLfjGLFceJ0A3WkcT02vVp4QxTC05tBM2Kro6DZNO29/cxfF+Yb5I1FPSFUc=
X-Gm-Gg: ASbGncvfH9C59JAzm+mVjD+MkZL4LqeWVnysteAvTLh8kUA5OIkLIxi4SXFKjt5q+bS
	lZhTQd2hN9115AmHqVwyj0bSOSDsYthjkdqapAkNvmtMzmOAPccUped3XjHuI0RyL/ETMdvStii
	eXSx/CZdfMBJWrjsyI1sD9NlCTMgc1K71vMKpVMaMiQVpoli6LXLdmLNbibEcel9Mh81fl6WSZl
	CZFWg559XlE2DHsUMM3Z5iGbIJtuYumzb5308KyksLTglNW5DiKuSqbtQGd6jDBxN0w6AZTDzdH
	t4YHFh/XzrkISwKgAjys93sWG6yg6EhQyx1tP/LPru/WRGyAdOSiznE/tdC0dzkEZt98i6H7qnD
	lo5mosx+i7HijzZha947JHJrk4y279E/nsznZT3Fi/BCHcHhjYsW9qhxcZvo=
X-Google-Smtp-Source: AGHT+IHkbsShVmVIQwfdIh0hUjUE61OmSFNVWODMerAHLv7/HcdmGwNwtKO6+Co21rSFectU4cHp5g==
X-Received: by 2002:a05:690c:45c3:b0:71c:44eb:fae6 with SMTP id 00721157ae682-71fdc3cdb12mr6675767b3.27.1755807652956;
        Thu, 21 Aug 2025 13:20:52 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-5f52b903320sm54724d50.0.2025.08.21.13.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:52 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 25/50] fs: remove I_WILL_FREE|I_FREEING check from __inode_add_lru
Date: Thu, 21 Aug 2025 16:18:36 -0400
Message-ID: <e42de7e9cd9b5fb17d159dda3de200b1800d671b.1755806649.git.josef@toxicpanda.com>
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

We only want to add to the LRU if the current caller is potentially the
last one dropping a reference, so if our refcount is 0 we're being
deleted, and if the refcount is > 1 then there is another ref holder and
they can add the inode to the LRU list.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 fs/inode.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/inode.c b/fs/inode.c
index 6b772b9883ec..c61400f39876 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -613,8 +613,6 @@ static void __inode_add_lru(struct inode *inode, bool rotate)
 
 	lockdep_assert_held(&inode->i_lock);
 
-	if (inode->i_state & (I_FREEING | I_WILL_FREE))
-		return;
 	if (refcount_read(&inode->i_count) != 1)
 		return;
 	if (inode->__i_nlink == 0)
-- 
2.49.0


