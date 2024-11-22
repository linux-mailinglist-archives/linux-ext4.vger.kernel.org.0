Return-Path: <linux-ext4+bounces-5378-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C229D5EE6
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2024 13:37:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39550B28843
	for <lists+linux-ext4@lfdr.de>; Fri, 22 Nov 2024 12:37:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389041DF249;
	Fri, 22 Nov 2024 12:36:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b="esxeqGwZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C688922075
	for <linux-ext4@vger.kernel.org>; Fri, 22 Nov 2024 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732279004; cv=none; b=YHoDcwrw00BghDftAVoMGYs1fjGJslb4rZgbmU6RCt7wluhS9Uow7mr/dZ3mAlj/8ELkMsD9h6ujNa8jYqu4DO7uQbfm3FIFxOosVZm6FyU03i0ml2RPfo7VgpvWkB8dNXZwgOigK5Ii7zY2dNX2TeMqWghvVC1lI+arGOXRldk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732279004; c=relaxed/simple;
	bh=GnNdD7IitAIO7FNE///egr8C3kIxYoOr1Mq3enWauB8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=FpwC9QNptPQ9VZb9l+hnik0dqykB2ADIUYlS/oQXy4H2fSTYuhkwi79tIF683+eszJTltAIY85FL4MWDj6X4S3sSJTSZhXH6vFVMaposVLgVhtfOBqOrI3ZmIINErQ153gdYDCsnaSWHYoe5PQOdaWTunuHpTJmJoIfa8LI2OAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com; spf=pass smtp.mailfrom=heitbaum.com; dkim=pass (1024-bit key) header.d=heitbaum.com header.i=@heitbaum.com header.b=esxeqGwZ; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heitbaum.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heitbaum.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-724e5fb3f9dso359134b3a.3
        for <linux-ext4@vger.kernel.org>; Fri, 22 Nov 2024 04:36:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=heitbaum.com; s=google; t=1732278997; x=1732883797; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9mYMZaHqSUC1SyFyMNWjTu1Kcvsj51Id1slni3bP/+I=;
        b=esxeqGwZYs/sRee9Lt4jZmkh6Hydj9RfNnghDNILQq7LyDcQSbNKzt+jqXSHwn7K3k
         ZFcVx91wF/Rv9GVXiW670AHAPSmWbm64YMIL7fgCZF+oM+AHPkZiypSsglkIfxoUNPnb
         YyRejV0mZjmDKwQNvpE7IoVziKoJxr63l2T94=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732278997; x=1732883797;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9mYMZaHqSUC1SyFyMNWjTu1Kcvsj51Id1slni3bP/+I=;
        b=PEtp3izCePK3PpDlpRbFvj1duj1cx0zG+A+QHxKjvTIbUVJOFGMiY1X2mQnwnelndu
         SbliPYzf+gYWOoJ37rZZIG/7MuA5ZwjKRoIv3gXOuorIsTpiMWcBKUGFGgvtXvsGH5Or
         bHSjG6VIoTZQd96WaKo+Uasd1vgYEU4iFiVXhQyQZfUMZA6MANpOWJSwVroEOCIi3aJD
         qsdCIn7EE2rs++ZOwB+5x6HR1iTlBmsyuDlN26NIc250DWS4GvttAp4Yp0UWqfvJopgi
         23AcEYHIEC5uAE6FRxKulCfZFPQUOOCsfiZvco+608j9Hpy4hz9SvLT2K2kLN3dBMIeU
         lPDQ==
X-Gm-Message-State: AOJu0YzpdNGtl+B4WKGQmSeKeh4WUMlcEy14dl5YPKREkmzw+sx0GcRm
	wE4OVRP32MDfUdgpky7YD703s+fpy+OGhNEv2I0IbDbXRDXPM6napwUo18wLaiQzA/2jezrpD39
	q
X-Gm-Gg: ASbGncv/9RU8QuSyFCAAr4v5VYHAdGP9zxjmpV89ZgDr/k7ruigR09/1HuzI9ApmlBb
	rEjwOh1Fm07fXoWfXG+X26J4NTYGLTTMH50MaQ3TBQCU4owOyvqtTmlPFwZwh8FVKVJpV5dPCfb
	JY3wfRUPnHlcw4litXB89JNEZARlCDnyIMnqV2dzRXD7hh9vcAbx2soglIJdRqjQYDzkU3kbJNd
	jzSW+KdnWFW8dFBgKOpSDHj12IPWhxJT+U8sFpHeUFZJC7d
X-Google-Smtp-Source: AGHT+IEou41fnw4prcdfG3fTtcp/+poq1/CVC8vJWhawNdw18xFE2D0ZvBFNS/pDDN37VxeA/RRYbA==
X-Received: by 2002:a17:903:32cd:b0:20b:3f70:2e05 with SMTP id d9443c01a7336-2129f288ba5mr37453965ad.41.1732278997113;
        Fri, 22 Nov 2024 04:36:37 -0800 (PST)
Received: from 6f91903e89da ([122.199.11.121])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dc207bbsm14961515ad.228.2024.11.22.04.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 04:36:36 -0800 (PST)
Date: Fri, 22 Nov 2024 12:36:32 +0000
From: Rudi Heitbaum <rudi@heitbaum.com>
To: tytso@mit.edu
Cc: linux-ext4@vger.kernel.org, rudi@heitbaum.com
Subject: [PATCH] tdb: fix -std=c23 build failure
Message-ID: <Z0B60JhdvT9bpSQ6@6f91903e89da>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

gcc-15 switched to -std=c23 by default:

    https://gcc.gnu.org/git/?p=gcc.git;a=commitdiff;h=55e3bd376b2214e200fa76d12b67ff259b06c212

As a result `e2fsprogs` fails the build so only typedef int bool
for __STDC_VERSION__ <= 201710L (C17)

    ../../../lib/ext2fs/tdb.c:113:13: error: two or more data types in declaration specifiers
    ../../../lib/ext2fs/tdb.c:113:1: warning: useless type name in empty declaration
      113 | typedef int bool;
          | ^~~~~~~

Signed-off-by: Rudi Heitbaum <rudi@heitbaum.com>
---
 lib/ext2fs/tdb.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/ext2fs/tdb.c b/lib/ext2fs/tdb.c
index b07b2917..98dc95d8 100644
--- a/lib/ext2fs/tdb.c
+++ b/lib/ext2fs/tdb.c
@@ -110,7 +110,9 @@ static char *rep_strdup(const char *s)
 #endif
 #endif
 
+#if defined __STDC__ && defined __STDC_VERSION__ && __STDC_VERSION__ <= 201710L
 typedef int bool;
+#endif
 
 #include "tdb.h"
 
-- 
2.43.0


