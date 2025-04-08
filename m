Return-Path: <linux-ext4+bounces-7105-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B156AA7F438
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 07:39:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11C171897C04
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Apr 2025 05:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E47F8215066;
	Tue,  8 Apr 2025 05:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoolgIUi"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 382A72AE74;
	Tue,  8 Apr 2025 05:38:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744090740; cv=none; b=sOtbgkkOX0tikkNtDhYFO0CXbOMyNLb672JSlsXXsHI7q5k++HEV2lR19Ww5qg3x3qfh8lGn1pN6iFYc165NlyE9piGNHw0W9cGAC23uhTM3xtSKStB1Ts5zWkuJDGjrby7Ji/VL7laJ3KCbZcJoQ1NkdwBIWRRm2TTVmz9TUY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744090740; c=relaxed/simple;
	bh=XCt1kyasE1XY20aZjCzaUcm0Y5hgMOcK+3Pe2olmp8U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=W33HFZk84m779mZ9BDft1J9AqIZUbfXaX4W9Eja9qXHyg+l0zmjkLkDSSSqqwVvF2bdK9wnISJ3n2Eox+WnOvgE0h28sUQ3yCNhn2uONwI7m0AEnEnuBqPi+ECVjVh+1NKQxKbwoefnJlO+h8eZ/9byysefMdiRHx23wq/8fRaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoolgIUi; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2241053582dso64937945ad.1;
        Mon, 07 Apr 2025 22:38:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744090737; x=1744695537; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O2d2DslWEv7yQwaAAxiXP+OSESFDexTJBC3aziNgclw=;
        b=IoolgIUiiKOcLt+bnUsxQ8Sq3KWD4CEgF0IgHKKZaqbVPuF1XC3TfRqtLr6z6T97wG
         xELG5I/tQ/5HkHouV5cvat7oh1LkreDZTKdXWfs6fF9j5ev9Jtg81FzRqRgpY8B6Cfhg
         xM6OROMlhQXjv//vpZvvBj5IhTOeohJfnkRmbj0D3p6dU9I/aufiwmNqxq/VD5L6uv0C
         ldAs8bJm/jRNgjKQsviEERqwBj/2ZgshKozGAX8hLqIICBVePG0i1Qga0jOjtj6vw6Cp
         tekwoPtKf1nh/bTGl9ep8+xEAHXPEwGnB6mQZidqNeVyCe/ewu0CBbS7FTzTC3eLqmqE
         Fcig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744090737; x=1744695537;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O2d2DslWEv7yQwaAAxiXP+OSESFDexTJBC3aziNgclw=;
        b=XAISUNoj3zY57Bp3mqOVAMov1zGy5ZZ4IW64WxH/dxZSa5+Fdhe9xwwUkF3U0fw8Uo
         NUq8TKROzSXwoXaB5sIzQdfAiFvdy5fA9sKnsPDoBWm/KaDmHF9X6Hjl/7zX24TcomzU
         WYFsod38mJ/HEUf4BCUTd/wz3kl/dcW2pTpK8elhMt6dXlH+TXKqtFk33mvDtttgHLz/
         blWAkziOTQt3FpkN1e2iTbtIT68CeLPjqVzwOTUHcFZ9MONpSUYSDsUr/MIumGXrRjx1
         lzqXfDW336Cga3+eGnycasnlFx5e7RYRc3Bxy3NNEud1H7l8G6pTOnttGJRke+MyR/zG
         wMjg==
X-Forwarded-Encrypted: i=1; AJvYcCVjvHnOzCq9KXiYh1bC2xNgPVQnsvzSPfYoCrNYRZXpg+KcV7fnY8h8udL+O2k+E9d5RDDf0xOhL34=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy7FmgatjMSxWYOvvkLDpTkdV6fugHZ62OODDSxvGot+UfasmyZ
	Eqpu4GK/Jbbr2bGgt+iqnc1cpwqhDFJpBzSGv8Oah3siU9RvflK2rmTDGQ==
X-Gm-Gg: ASbGncssXpdx3qQvswYPQBUGPmkwhFTO2oBd0GrggQkLnP4jhBgFlu36FfjQMYR4ZkV
	2mGpSOlQctwJ9VWHw9flQ/DhcCmlGM+uEcXRivYe5ZMv8mg3oBFvY/V/YChM1V4TDg9geopxKaj
	DNk0ddl940VkX6MmYj2Wy1va4JuK7RnH/n2kuqQIwoCwJYWAXK0dqoIB2F24zLYwkCUPyPIWcvf
	zL7KkEgaT+DypxcKoh0EDQtXeAqPumt54IzagBoL/MaODcM1KIuDVgr6XwflFLVtlZiSTEy8zBr
	4T2zLWYO1iFjoeKig2rJzXOYHkMw9NlJi5LySLU+OEb46vBj
X-Google-Smtp-Source: AGHT+IFd1twen/Dsm0HFNO1RqWXbYDdLzIkAonPN+pFHvM9hOhqQl2fHENKjTiI5BpPc3/7x1ixZbA==
X-Received: by 2002:a17:902:d4c2:b0:21f:74ec:1ff0 with SMTP id d9443c01a7336-22a8a0a3892mr161417815ad.32.1744090737485;
        Mon, 07 Apr 2025 22:38:57 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229786600b1sm91154875ad.109.2025.04.07.22.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Apr 2025 22:38:57 -0700 (PDT)
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
Subject: [PATCH v3 4/6] check,common{rc,preamble}: Decouple init_rc() call from sourcing common/rc
Date: Tue,  8 Apr 2025 05:37:20 +0000
Message-Id: <3a3679b7f1f38216062b65e671852847c1213049.1744090313.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
References: <cover.1744090313.git.nirjhar.roy.lists@gmail.com>
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


