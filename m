Return-Path: <linux-ext4+bounces-7027-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0070BA774AD
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 08:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3DF9B3A9915
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 06:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E6FD1E5702;
	Tue,  1 Apr 2025 06:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KhJ+hBWj"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC921E378C;
	Tue,  1 Apr 2025 06:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489907; cv=none; b=dpD6n+94s1JdmoycOW4NxagpqJoFZC3tivLpXwakEwyIJdNTM6Ak35h6JA9pWMCCPTVp8Vi1vEh4/FQB9NWTirYuNju/WRofrfSzCq8hUaet84cKlSnQJq0wa0UufuynGt1bMYMMXYhEq6UduLLwZmR8Ff1iYKEVSAxDKa7j3r8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489907; c=relaxed/simple;
	bh=lkKHWmNIdUANkalyX7UzElc1YsT4NlD/u6aSaUSHckQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EE/Z0eEw9CfA6GH5hjIh3OoSbig/urAekAkI/cR9UPlsrNzXLrxZjssKbvxtOd8tYud5+ngZsk56uj08ntZ4ZYriZp7uqCJMnXdDcCpNJOne8bKb3PHc/ED76DD5OVHyMZ3u1+jjFsUiHS6M1/8XKXGp+JppwrQNhYks7fuWx3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KhJ+hBWj; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-225df540edcso114590145ad.0;
        Mon, 31 Mar 2025 23:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743489904; x=1744094704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nWkClC32TOX/KRE7kH0VGIztpLwpRoczq5FgEMQ37aI=;
        b=KhJ+hBWjr+3qPNe9nGdhFOrSgHJDtWgsSqkUDYB1cNc/RlQja5HdyMBkgUMxKSlqzn
         KBjPZUFBrGp1qrfD6IdV+EnFpqxLOR6H7k2W2/iaGrBEHr17VL8Cb7b0p8iEIbWwzDaB
         6q+8TQfjnAv77r5NiSixG+EPcrCsZBfuknvusGL1BpRzfXe1HI28xjcmivG7zp5/GY0/
         BaipvjXdX/0qUtBwyabn3JfNDR9D8Wxhx/Ur2rtrpw7KOOmGU0C6cgM0VObq4gTAD8SM
         9HfWbz0ffnK+mtqAvz9aKWOBtMgw9cRN8GTJXevMZz6UFjbzhWOPmffEVyhaQIzEmvU8
         ufTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743489904; x=1744094704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nWkClC32TOX/KRE7kH0VGIztpLwpRoczq5FgEMQ37aI=;
        b=gRd/9zeBzbS34BCpqKxAEKXMkBBPS3+W3LyiFBDj1OcX5xQtlWROQGjvnFxtAgo92w
         s87xDJRnmjUXJLevPXoKgYAzPmts9oFUtIueKP5I4+FKXFrYHemuCAOt+rirCGMBvIys
         TlKBBei28P2qk7HuRTAzLpYdik0l3aibQqvhePwIAM9eqDkALFD2fkrJPaPJXVeCQHY7
         PnxkbbjbrCfAcykquyCca7eXq8P7le5Haj/gN0i06AszOUPBgme6KyLXfFfgOBUZ7jiQ
         JgFR+mzfoQUFY0R3t7amay67yjWwtk4K7ii077pDEsEG57dvBTRndDsZghD18LyFo2HW
         anLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUF74MI9/u3jmrdh9bEC2O1pxISsBiTSDHd7jlVZ5XUxqFkaBmzPEhwNKHpTLgETCR77zfLUVHbKu0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVl2QFXfjeqi+vxGZvExDLH4ULGVsAd6WxF5K989TPfANQncoc
	f9TzcV5RcJvTJy4hgoRHKep+rQcWaDagHqkf4WG50qKgfI/Tt40JZG3e0K3m
X-Gm-Gg: ASbGncsh4z2E5I34rQ+u7B96Bm4hHZuIlGJ2wlu19wMLeiIUNKJVAYZiJaSPOJ5Qj4m
	KxmMX3QowCNv96fhm43ovNtjL5H6oB/IncmiRigc1ri5V56gLkv6CTi4c93mhjt1X9IzQfMDlOv
	FxwSI633vHncl8nC49GYSqXz8oPjZbKZw9x+aEMQCTIKkjVEnwAC1rEnVUCLr/Fe0AKr4WqOL6p
	TKvjFXkQXQjS5HDKzzsH3DQP/bGEr6FkkMPNiL9cqh/nqdAEU0xZRGcKtj6G1XFsKIMqTQnx7df
	uXId8g5lsTVWA3r/NQHb1Pg/sTHGQelED7I2BOwktD3MbesC
X-Google-Smtp-Source: AGHT+IFFBfWrnHhHopyna0tpGEXTdQuyLx9fl2iioEWifwHL2E+e+qr3gFnpoHAc1m1+aCsVwUL4Bg==
X-Received: by 2002:a05:6a00:a26:b0:736:4e14:8ec5 with SMTP id d2e1a72fcca58-7397f4c421emr16634585b3a.11.1743489904133;
        Mon, 31 Mar 2025 23:45:04 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106ae4asm8135092b3a.110.2025.03.31.23.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 23:45:03 -0700 (PDT)
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
Subject: [PATCH v2 3/5] check,common{rc,preamble}: Decouple init_rc() call from sourcing common/rc
Date: Tue,  1 Apr 2025 06:43:58 +0000
Message-Id: <ad86fdf39bfac1862960fb159bb2757e100db898.1743487913.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
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
---
 check           | 2 ++
 common/preamble | 1 +
 common/rc       | 2 --
 3 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/check b/check
index 16bf1586..2d2c82ac 100755
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


