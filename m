Return-Path: <linux-ext4+bounces-10592-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE10EBB5AF6
	for <lists+linux-ext4@lfdr.de>; Fri, 03 Oct 2025 02:51:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F71E19C3D19
	for <lists+linux-ext4@lfdr.de>; Fri,  3 Oct 2025 00:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019251ADFFB;
	Fri,  3 Oct 2025 00:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mqLZeOSW"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 995DD2F85B
	for <linux-ext4@vger.kernel.org>; Fri,  3 Oct 2025 00:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759452674; cv=none; b=EmpSb+XRyHL9kPQw5obc9UDfQk9rRrIsgwpjGwFOdsnK341xtpHP8/rqA9+fcmcZw8nqu7ohywXYIuhkGeiEYE0xuD0DHO4dxCaUF9+0y+vSiRk1vtnCaCmXeV7a/7WCL73u0CNNZLeoe0EvC3mV6+xT7nMXMy7VAUdNPbR+dzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759452674; c=relaxed/simple;
	bh=X5kSDsxxb+XD9CPJBYVIOtNwcZLhvc6wqQVQXU6X/oU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kMjWMXPM6Ln0LV2DoRxfgRNWaIGw4M1XjSFRd70Klu0HPdddOhnB5Qf+AT5YgsE8lJf4TyIPVeuzeMGz8xS3lfqKQD6kkr3SCs+ytgiOo8QXOPH3rkjuFNG5cfXUO/i+mHk3wDRPh4m3gsFIKmCpzSAz0TYAjee45U45aiLfGXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mqLZeOSW; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-7833765433cso2281134b3a.0
        for <linux-ext4@vger.kernel.org>; Thu, 02 Oct 2025 17:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759452669; x=1760057469; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T6bHVlibpYYb4K/JC7+xFZW8SMHjF8M/EaQn4o+DfFI=;
        b=mqLZeOSWe/r8sA2Y3IxX5SsGblBscay8wiM5sTHlk3B7yOi+C2HO7Hhr+EPGWkqGoQ
         6qpSCiLwQ7IMsk8Kg2AOQEkrksvkrsUtqHCi2VqYW/w15foG+zBQK1AFTvqGW6DmIKp1
         yg7OkkaYCHAisSPM9kz3sF9QdXd0jEtz26JCCbHgAdH/pMPtw2FqIER7VC9pQjeQZfA5
         IhbelqRMtArPj1qRvKn0GjEVMaQP1JneeOmbVLVY2t+9un+A9/toxr0aVHRWMBA8CsYM
         d+Ru2e0TcsorQKR2xXh7vBFnugypSOE5okQ2oUaPsrBFEfhSM4IP1gzy2+nfKujv97uQ
         1yTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759452669; x=1760057469;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T6bHVlibpYYb4K/JC7+xFZW8SMHjF8M/EaQn4o+DfFI=;
        b=KMIlXmGPULDDezxmk6vq3ngOtfDTdFrqO6AbD4gbWbYFuPLCMA1VruLuFVzcAjLKsj
         FfZqwGFaNoyHkP2uZDBfv2cyL8DuuOEe/4U+WKD4b8jNv26fcbdyX7UKxoS7n33GDBcA
         i13ei5kguy+0XZmfvYIIdc2uEvqBD05/BHSraM40GShQF58mnVk3jjyx/aT8V6uy7bnJ
         dakmguka/z/UMeLRNG0hbtp9P8eFTcyttv+lpEnKHnu1uE29ECJckywo8OOtmc5FkiCQ
         GH5UWPzVxqt9lLrbbw+t8t/xeVj1fSFQkDdMwPuY2BZ71xh1yuQpQSf7PJSJnjqX9R4a
         TQyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWq3gddHM2n6mnLUHPvpuGnLPaoTl3KYFtnhfEVkaSrLugT6oQHilMlgW7PXxcyjGHj+bdrKxDn1Wjo@vger.kernel.org
X-Gm-Message-State: AOJu0YzWvwG5ZX0AHht0qbT9sCoxUgPH/gm2jabkWysA2lpHlTnu/UK5
	7QOvw9y06BCXkRsfmAJkwmBt2aGyq3Z4yS26RlmryYXMH4KyJYGhoZ4afBfcoGf2
X-Gm-Gg: ASbGncsZqAZeflnDiGfWwFqNv5mOcaiVHIyAMBdfvR4eMoH5W7EZNC79mlodVaOrDpF
	3zU+FscF6h3G37zt/HZQiBCfXaUbrs9EBXYNRtAXO2IThYhD2cziBwp5J55u/eIs8Wi0oHxd2O9
	wh8ul4rKO6ae0Vbu7uoyKSqheAqxspRWsYi7X0SmiVXSVQ3nKiANx5SOVCw62np/gtJif3iRecU
	iw2UQ/FNo8h7xgu1GLWgmW/orzysu9pEB2IW3aNvzPcrl669wMje5kDkWZC31EceNio3TUyfBKg
	QYxO9JCsDBRhswDO1Lhcxcs0nMl7XGTDkF76MaqxGbLfQIKqTgNDsMndLifsLAkQ8XGPiRGtRr2
	5Rp5kkn7dLwQsc+2Wkqh2grn73jYpCAfm4ktAQ/CQoYdKPWZdQMuSkpJUcOWlpkhGyMQ+gwPDMs
	tgr1ijTA0BPObieDC27zJ6/PHgSn44kV794zfi
X-Google-Smtp-Source: AGHT+IEwpomN/IBM+LnVDO+n8UtyRhkgfYEiaynqtsEYJ7oxGVacvwjycgRmKHI0Uzq7yJYetl1FYQ==
X-Received: by 2002:a05:6a00:188e:b0:781:2558:6a3e with SMTP id d2e1a72fcca58-78c98d61decmr1842426b3a.14.1759452668771;
        Thu, 02 Oct 2025 17:51:08 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:38c3:a5e9:d69a:7a4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-78b01fb28adsm3271827b3a.35.2025.10.02.17.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Oct 2025 17:51:08 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: tytso@mit.edu
Cc: adilger.kernel@dilger.ca,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ext4: reject inline data flag when i_extra_isize is zero
Date: Fri,  3 Oct 2025 06:21:03 +0530
Message-ID: <20251003005103.2399934-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit


Looking at the syzbot logs more carefully, I see the initial 'acceptance' was 
because the filesystem failed to mount ('VFS: Can't find ext4 filesystem'), 
so the bug couldn't be triggered at all. My patches were never actually tested 
against the real bug.

I apologize for the confusion. I still cannot test locally to determine what 
the actual corruption scenario is. Today I have re-tested my same patch in 
syzbot and it is failing.

Best regards,
Deepanshu

