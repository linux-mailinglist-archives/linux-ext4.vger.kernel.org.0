Return-Path: <linux-ext4+bounces-9530-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A7FD0B306C3
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 22:50:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B84E602B17
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Aug 2025 20:44:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAF3E38E763;
	Thu, 21 Aug 2025 20:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b="h7StaB7s"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 160E338E767
	for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 20:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755807662; cv=none; b=TKir/F9nLd/rD3DfUic4MoCNiIabArU1AlwQI65AW9vDHPvEtW1dkD/5DQTBVez9B/uc7Bxq1XHaFFlTukeJTbZRww50J+9T4EJMYOixrYWd0ewXLkQOaXHFaTKILfJxib4Jmge51n4+PlxWznYDOPHmPoAnBczBkKk23BVFqK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755807662; c=relaxed/simple;
	bh=Ek+K7HnIxIEopRMdqMnNty91y2VWEE+x+hrrKpFJIDU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vAShIVkg6+QHaU/OJZlFScrBB5EtFKXMOo5xw8DYs9dzYCIfilGO0LbU5grhsNt0Nu4fD8sbER/krgsD8m2KcjXs9gRVIOrCVa5SUhIeWKlandzlZpAxlnzpz5FUrPxsCwSuiF0zPwgj0+bcXqHPZdURZAUge7xTejP6c/nFCjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=none smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda-com.20230601.gappssmtp.com header.i=@toxicpanda-com.20230601.gappssmtp.com header.b=h7StaB7s; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toxicpanda.com
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-71d6083cc69so12299137b3.2
        for <linux-ext4@vger.kernel.org>; Thu, 21 Aug 2025 13:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20230601.gappssmtp.com; s=20230601; t=1755807659; x=1756412459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y3TpSvoC8LjQ68sRQOMNnuf57RQxDl2e4bAAk/7JVig=;
        b=h7StaB7sFaFR3MU6RpylsNnl22azzxV5oSw08GZHVkgu9uKpQh0EIWf4LakiASWhc2
         Hu7r3GBivna5hNDvTHut+WH27OE47U4mWXOcPqnAPKnL20fzCz6iO+YJjqCsk75gcpXa
         Pi7L2b997iBKTv7FOOE42A1AoPHp5yYEPG8QyzzhzTaTPKl2FBBkH0GMAqu29AqVdedk
         P9Coxx/gi2d9vd23T7qyY0MC79V1fsb1qulU3oJ8hxPpCQJFQeVjjG3emy8hvTa9qdjZ
         ZKanmr9ngpInB40VSv3IaA/ylzofoEy/eAPSvLumk58yiLGwKGzBLUuwFiPk4tRlwivp
         shDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755807659; x=1756412459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y3TpSvoC8LjQ68sRQOMNnuf57RQxDl2e4bAAk/7JVig=;
        b=c3JKdKFpqrmFMsa75WHbMzJRNLL6FJy3QqpmT/5yLb8+CTTp7cv4Vv8no48CUArB+E
         KS4frOWJD6cqqM1Lu1alMHC4oXDcUpu2IvfUfdgalL3hiWbNctQXlvZJxN/CaLoqGSdq
         DpXSzXAq0vs1Kkj+4LadgVdgcKdmaFnIznnp1d0zEO7M/+KiD7eIY6OntYjF6VSdhnOG
         fL0CcM2clR2jh9roDpQvb8WHgLdHd0eSErdtmXesMCEz/z6AfYA8bvMC8zIrnyM5IMp7
         z5CJJV4+ClkD161Y4YAQxdeGf/aIyz9QuvBm014mtWooSnfgVa1/r9/dNL+/eZVl3Tj0
         1+eg==
X-Forwarded-Encrypted: i=1; AJvYcCWIBbzks7MOW3tl1P31imAfVcchwi/BFV9UYLOLGpOSsnNP9VNAFrCuhvmyWPe9poe8/xclpX5WQNID@vger.kernel.org
X-Gm-Message-State: AOJu0Yym88LbYENt7RVV9En0JUyeup7MKqU1ucJhPX8o63/cavDno0Qk
	GSLA8RAO8q2Bm08GPEqJn39majRPdycJYZezPIW2VCRuSSpk2kESO9HVPU/CrYB8POKJRHv+M3Y
	Eakx/G4Ap5g==
X-Gm-Gg: ASbGncuanDpXg/OWdAeIIiJv6uXSRbPKCDDmGTK1+fpuERNRMj6PiPmchyEIKqaQRsz
	Jcf7KiyMeIObaw6QSDjsGrsMI7YStjDEi8UFxF2if9hgspcJUWyXW4tM2IZMIbbVLtbRrHXRt3Q
	5h8EDl1xrvKpYEVGbs/7CNy3ehqa9V3vlo6xkgptwTG/aGXS4A2lfvMNYC3nVipHEfT8keWy1A3
	YhHe4ZjjTaOXhew5PVXKmPPFSNqiOLqWFpkL2yAEUt/gshp1jpLcd4fMGRBmKHrcF4upisJCSPF
	vTaRoMeWY+HwZ2YMBal/5qTo5jBrSlyLjuYeRECT5/3mqSTRpRQ+2H2BSH87uOqLU1MQLX2x1IH
	NNSNytI0blakYKO5nwkqjlVY5lGHuEgr1acpuKym95wUSf6LR6UWMWALk+7rtlrbCKLXz5w==
X-Google-Smtp-Source: AGHT+IFzSbbZbVyVfwrrT3zpLyFIJoYYtpY7LXxY8rNCJVnHbwi9tGRQ7nXi3Rf3m3iA+CZ22nlXrQ==
X-Received: by 2002:a05:690c:6b0e:b0:71c:bf3:afc1 with SMTP id 00721157ae682-71fdc2ee8e9mr7159417b3.17.1755807659175;
        Thu, 21 Aug 2025 13:20:59 -0700 (PDT)
Received: from localhost (syn-076-182-020-124.res.spectrum.com. [76.182.20.124])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71e6e058dbasm46453967b3.47.2025.08.21.13.20.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Aug 2025 13:20:58 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
To: linux-fsdevel@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	kernel-team@fb.com,
	linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	brauner@kernel.org,
	viro@ZenIV.linux.org.uk
Subject: [PATCH 29/50] block: use igrab in sync_bdevs
Date: Thu, 21 Aug 2025 16:18:40 -0400
Message-ID: <6dee286aa8a57a874a66d1e9c7fc835a60393197.1755806649.git.josef@toxicpanda.com>
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

Instead of checking I_WILL_FREE or I_FREEING simply grab a reference to
the inode, as it will only succeed if the inode is live.

Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 block/bdev.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b77ddd12dc06..94ffc0b5a68c 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -1265,13 +1265,15 @@ void sync_bdevs(bool wait)
 		struct block_device *bdev;
 
 		spin_lock(&inode->i_lock);
-		if (inode->i_state & (I_FREEING|I_WILL_FREE|I_NEW) ||
-		    mapping->nrpages == 0) {
+		if (inode->i_state & I_NEW || mapping->nrpages == 0) {
 			spin_unlock(&inode->i_lock);
 			continue;
 		}
-		__iget(inode);
 		spin_unlock(&inode->i_lock);
+
+		if (!igrab(inode))
+			continue;
+
 		spin_unlock(&blockdev_superblock->s_inode_list_lock);
 		/*
 		 * We hold a reference to 'inode' so it couldn't have been
-- 
2.49.0


