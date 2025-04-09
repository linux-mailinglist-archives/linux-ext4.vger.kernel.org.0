Return-Path: <linux-ext4+bounces-7161-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44CB5A81DEB
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D22EF8820B1
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 07:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A7C022A819;
	Wed,  9 Apr 2025 07:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoBqsGUd"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CCF1DDC0F;
	Wed,  9 Apr 2025 07:03:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182199; cv=none; b=rX1a/2luMn01Vl0DbeMOWDE3cdRAlwfLIpS4i004VSx4aQ5vP6v1Exl2G1kV20+WqGOQQUH3O7jnaafGvoQcEgoHEFHlGQ2VXU7QXUCAy2NUXHETT0cQ2sM5zh+/okfgOR2RP1xdR+frVJPU4Gniymz7rpAGftlt4zeaxty/MzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182199; c=relaxed/simple;
	bh=XCt1kyasE1XY20aZjCzaUcm0Y5hgMOcK+3Pe2olmp8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=msWHOAzCes3Lor2NDPAupHvWu3DN5iDtn/d2dSGMRvFmzmk20iZ0FbnyuDPM5gJJObcLtWJMT3yEmKAlfC1cuJIDWoT4MUjA4aIbK68rF+OaGjSFEbYeKmQeGhWw8/BKfiIZF9bdEWHT0ICKe+VQ+ZgNRgvBfNwF02nLbqCZDaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoBqsGUd; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-227a8cdd241so74550535ad.3;
        Wed, 09 Apr 2025 00:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744182197; x=1744786997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2d2DslWEv7yQwaAAxiXP+OSESFDexTJBC3aziNgclw=;
        b=PoBqsGUd4HTjMaTP2pi9wCLlcMU7MfRTJW89PcVtF+3iSg50djZ1wX0ycID6sseLni
         8L/GGAXEI+hSNYG4MYFCGVCJCSHjUAWlo0XIhf9zVHGu/u3G25AfoPj/NZwDIQjqy4DZ
         VNM492ScG4p5j80H5sNmJ+wn6zBTK5RZkVpFNme7aKcs8sQpH/Jg25ePRwuBvRtPgkp7
         9NzWQ2/Sa3mB2WBerXr0JXebHDdM1YWXYrchzACTPYTjN9oo81q9aPtbUAJSOl2F9qNB
         WCTgdW8oLpr49aZqOE2Gkcp7zGJ25E6A44/ITNJktYqRhdR1pZ6LH6f+UdkPOn+grux5
         p1dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182197; x=1744786997;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2d2DslWEv7yQwaAAxiXP+OSESFDexTJBC3aziNgclw=;
        b=ATzHJj5DVO8gGWgTgC/m4mqk0gaKJlgVLFqyzQl9b89wi0VkCYntgiXbjH7BrAynG5
         hdLOQASYOk3AabhwIJrwRyBqwP8lrMuEoInn17Fo5hIL5CnCl2av5wDt4hUCbmnKBTSA
         tog6eJb72Xt6ulYw3DYGZOr2IJ3vHYQMS4yCJVp4TD55wdUyEFbD3YJ/EtqTnkgcC6Ns
         BNHH79IneuyHw+pkXGhwn//mxYpdjaskW9m3a5KApJzEoy3BiZakOHAed7LA79dXS4MF
         0lkitE90vV8a5OL8BEvhrQ/WmwEHRoNtRE/Z4yqi2vbSSnPR/ylcIVOMZQm+r1Tacqvc
         b9pg==
X-Forwarded-Encrypted: i=1; AJvYcCViBL164YNDdwZc2l+LI204VHvCX6mXN6UKePMUhFfpPISBr/jAlf1wpXcsAV4G2ASngGG0jeJ3nPE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxMlkAVOuCP8oX+m/Cj1JCKFMHRcG2C63rJAy9rA4Z0a9jLSf3
	OuzUSrpSX8ANAGM+zAw/e7gFYV47Z7u0FOHvqDboDaQXGuPcry9ktm4Nlyij
X-Gm-Gg: ASbGncuOE0jE6vvJC1wTqdrx1jFGXm76GM3k1qUBQx2fSerQwKUxOCXvIlQknusofLz
	nEPx6SG574KWJ2rnyiBGWP/Jm4GbMqncRjo4oMMZcpSySXoBMxDAEvZb7gqKyEYmnh0pEmkumPH
	AEeae+HH5mw3jnm/t1jOMmyqET6IUKi+dmwqkrMBrtNE+VS78Es7GXwU3n8bbOEn5AEFE5viAxP
	jdBS76ptlk0CMl5F/xGkD4LLgPQ0byr++S4rnx1ve1Mts+26Iowi+av+b4a2dJ+fkJpRF7uGLkT
	uD8oi6DPCEySuJ23mYMNheR2jD25W+ocTyY+g088gnNr
X-Google-Smtp-Source: AGHT+IHRM+ZuSZBnyFXzxqUlXMlhD5d4SxguaVDifQkMzlEgw4vdyY/9lqR+BFkfcHAIPF8qPy9JsQ==
X-Received: by 2002:a17:902:ccce:b0:216:644f:bc0e with SMTP id d9443c01a7336-22ac29bc06dmr33707745ad.24.1744182196479;
        Wed, 09 Apr 2025 00:03:16 -0700 (PDT)
Received: from citest-1.. ([122.164.80.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c939a3sm4491985ad.117.2025.04.09.00.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:03:16 -0700 (PDT)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	david@fromorbit.com,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v4 4/6] check,common{rc,preamble}: Decouple init_rc() call from sourcing common/rc
Date: Wed,  9 Apr 2025 07:00:50 +0000
Message-Id: <419090f011da6494c5bf20db768bcb8f646737df.1744181682.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
References: <cover.1744181682.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Silently executing scripts during sourcing common/rc isn't good practice
and also causes unnecessary script execution. Decouple init_rc() call
and call init_rc() explicitly where required.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Reviewed-by: Dave Chinner <dchinner@redhat.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
---
 check           | 2 ++
 common/preamble | 1 +
 common/rc       | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 3d621210..9451c350 100755
--- a/check
+++ b/check
@@ -364,6 +364,8 @@ if ! . ./common/rc; then
 	exit 1
 fi
 
+init_rc
+
 # If the test config specified a soak test duration, see if there are any
 # unit suffixes that need converting to an integer seconds count.
 if [ -n "$SOAK_DURATION" ]; then
diff --git a/common/preamble b/common/preamble
index 0c9ee2e0..c92e55bb 100644
--- a/common/preamble
+++ b/common/preamble
@@ -50,6 +50,7 @@ _begin_fstest()
 	_register_cleanup _cleanup
 
 	. ./common/rc
+	init_rc
 
 	# remove previous $seqres.full before test
 	rm -f $seqres.full $seqres.hints
diff --git a/common/rc b/common/rc
index 16d627e1..038c22f6 100644
--- a/common/rc
+++ b/common/rc
@@ -5817,8 +5817,6 @@ _require_program() {
 	_have_program "$1" || _notrun "$tag required"
 }
 
-init_rc
-
 ################################################################################
 # make sure this script returns success
 /bin/true
-- 
2.34.1


