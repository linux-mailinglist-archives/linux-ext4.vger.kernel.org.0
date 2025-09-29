Return-Path: <linux-ext4+bounces-10492-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0372BA9D59
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 17:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C34427A49D8
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 15:44:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A61130BBA5;
	Mon, 29 Sep 2025 15:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XURxbhKl"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6719430C0EB
	for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 15:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759160756; cv=none; b=YRc1ZEAlWpPRXU6uKFoT3c+1xYaDQtFxXq4AH27o0eke6aEMOXmegMixuEVIxbNEo1Q2+CfABYLBBQ0pFNLSZyyUMmYH/p6GN0s6udJbObGcOs/GeqJXNi0/eD5q7M2RcH0OWh4QbUpNjAjPYlna5wepXIB5/eUIaroeCIDeUWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759160756; c=relaxed/simple;
	bh=HMVoh979jXl54uDftd/1Xx6tkyfIhAEBek0tPrP+Teo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UkOMFrpsfY21tYR3Cuv5YMwrLdzUq7jPjGk6Ty/0g254MPl6BLXVtSFBUlymmEku2ZBUplT9dscV1s3HrSbu9uKT6kKVnA+KxooRz6V1fP471xC6qGj7R9+SKdGg0FOkz8qhdW64EUojFAPmHqlxfuN0HPeeJoUBgp1S/v1oFWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XURxbhKl; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-781db5068b8so1758719b3a.0
        for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 08:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759160755; x=1759765555; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qipWkB9/4eXftP05+/i6SMamlcpTwPzfnVCspDoPT1Q=;
        b=XURxbhKl4oJDrBG54M9Rw5VRxyd8BR0VK5yDZ0W4wOX62imMdQ/OCphQQHtzsvcY0O
         9lbihRE8MpcaekQCMlq1UKdm2c2bPhnK1vBZEaZcdnL9g3Y4EkCVbhWtHOj3Kt0go1kw
         SM0spX84Jyh6zP7KJi+m7DR8J4TyJUEK9eRiZapY6Csl595NM9rd9ndreUfFfLKpz7Eg
         XB3ujM94fISwHnpo9jvH4B7nImarl9WAilN2UmMVbmyoO0MlWeLLBUIxBBgbPow6qOJU
         sme65whlYodKlODBM5PdE7cQXCdi76SkghmGYlGGDzonwyOTFKpWMZOVkW/Jodgla6uM
         HnjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759160755; x=1759765555;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qipWkB9/4eXftP05+/i6SMamlcpTwPzfnVCspDoPT1Q=;
        b=hhQqrQlBHqsoSXbU6CBkdB3H7/0/U7PLRmbiIOpuL86p/CX5qgo0egvt1uAfbd7OMh
         NBp+TK7kv8okY3ueDmwyBN7iu1QFav456s9k8fna6S+VJKWqgvBp7UxWimv5m6tkpc/j
         co17gyXAbycmEB7sI/swnbGlPtzWTNmypng87K2fN2aiwtK64wRtypz1bQ8wqj1LLioy
         VzYNwiKVJuXSjUidlMb2TlwV0kYMM2IdRGAFr37smFi7IKmV95u9j5yzMpk9sh8U4IUW
         nhu+qfsG7sobKVIV/+4w6I0Ap6JNAzHa+bmYcuOPrM87+q/Ym0PQ9dIt3MGg4iKeqmJs
         s6aQ==
X-Gm-Message-State: AOJu0YyuVdjYdY2T3BRBxdfgOuKf4iUZ4pICqEm50jIe/Tk52l+zFwQb
	uafNCYX9ZQ0YQK94CdqubKgtWfN4xz9vvnf9COkQY+tjJRPRHaWm3WZt
X-Gm-Gg: ASbGnct1eulokeaO2dSKXyJ/aF61MIfAdDaNs4sapNAjiS80Ejdw6M2bCw0Flz1+IWu
	e5yt+CdsLxKml7H4V0fg1KWwPE0mMr2aZ84q7quGoxkr0t0hfOQBb98k4oiydoqfmC6OI+twWiW
	ZuABX6gBgoH4QuZEtpsZnQs1C+MZyOPE/GFOmcC1cpAF5Pu/0bEGDhaWdIITBLxedgceGJhuK3a
	BehdGJSKP5+ju4R94FrMG3svV2Xuv+9UgqZF8tM6Gfnaw/rU/C3FBG1nOy5T8ugpCB7T0KebgDn
	+x5wf8LWqU+zaAd2Btvc2Sl5MLJwv9VMyPzJKsekgfQ4kIIIEGNHUynM0tV5GV2wrM5nCA2zg3R
	fPAIiLdV3Mxne90NeLSAJi1PqQ5+N6XI7+jom6KKbsRraca+yztMryir5JAN7pObEIq9ugqU/3X
	Sf7VEW/mcQv/ev+g==
X-Google-Smtp-Source: AGHT+IFka+mg1Yj9oEyyDd+jKWIEszLBRg9x40H+3xd41AjnTszbN2Gj1wk9UIoSwUXaoShKmeeJXQ==
X-Received: by 2002:a05:6a00:1ac6:b0:781:15d0:8840 with SMTP id d2e1a72fcca58-78115d0952fmr11226048b3a.7.1759160754625;
        Mon, 29 Sep 2025 08:45:54 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:3094:2b82:239a:7350:ef6b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78103f1d1ecsm11434246b3a.90.2025.09.29.08.45.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Sep 2025 08:45:54 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	yi.zhang@huaweicloud.com
Cc: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: validate extent entries before caching in ext4_find_extent()
Date: Mon, 29 Sep 2025 21:15:48 +0530
Message-ID: <20250929154548.360371-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Zhang Yi,

I've prepared v2 based on your feedback about avoiding redundant checks. 
After further analysis, I'm detecting the invalid INLINE_DATA + EXTENTS 
flag combination rather than just VERITY + INLINE_DATA, as this addresses 
the broader issue of mutually exclusive flags.

The v2 patch rejects any inode with both INLINE_DATA and EXTENTS flags set,
which catches this corruption and potentially other similar cases.

Thank you for guiding me to the root cause.

Best regards,
Deepanshu

