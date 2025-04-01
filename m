Return-Path: <linux-ext4+bounces-7024-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8B6A774A6
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 08:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08ADF3A97A7
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 06:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367F51E47DD;
	Tue,  1 Apr 2025 06:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="js+vVb9H"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 849921DF73B;
	Tue,  1 Apr 2025 06:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489862; cv=none; b=m+XMVK0I+C7HJWFqOTktvHrbjtBIPa7KCZM/ekD5eJteDJ7rW+ARI8mVe4JF41Tr1iRftqOZHEr9AkcFECLt7CGF2Wz3Y3cZU76FJpyvolyYUYB0ySh55ciBt1ANOizSn8Juwv7alpHUohwP5CS1IPEOEPSnz+E0+tKdKvqpdmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489862; c=relaxed/simple;
	bh=pqyuiXctopdL45kPAN8q9Vk0TMk1imWPOTpqO9u/tto=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OB/1YmXB3Fu+D4f/1qYtEJBqnxCev0FCujTm92sf25lttTIs2MJjm1OvQG0hhwsPyfHnTsAUcKvsp8S4qvwZvYQsUWupNafefKzFPLxYPkIo4uLqjOOVg9x6kbUrEzS92E70eGJUWctWzZeANCGFch0YKTOZnt2Il8VnaVR2qPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=js+vVb9H; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-224171d6826so73953495ad.3;
        Mon, 31 Mar 2025 23:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743489859; x=1744094659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LUlm2nuzsQpJwZehgy4BHgOFTRHAHUfFsd30F277e7A=;
        b=js+vVb9HJCtx5j7I8j5ziQEmh7SiSzd6OozP1zfxnVd4rNZGnVSIdoZBiesK+VUJfI
         tRjVk1UmNA7iBlLQ21UX3E5lsVBj82zS11a8So8VmDprDyD3aSaaVEzK9nijzOqTWw2P
         8ChQ8Qjb8cFbPEFtDyGCvynaOG+xbWsrsANKxIK3qjJq0IE5FB2SLcEjGfWfZzdIWhM7
         bJ1f86fBr0RSwUq2VfjMiv3Pagdq9WB9czCPiF9U4hhXEO9Wd49ARABuc+tfTeuiGqpG
         Y4RStcoNu17+EhMN3z8p/pqRezhXKsNkB2CzfpFWpYhBILN1WGvW0Rx/eOYz4JUO70hb
         otCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743489859; x=1744094659;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LUlm2nuzsQpJwZehgy4BHgOFTRHAHUfFsd30F277e7A=;
        b=sv9yOokh46V66B2tyKSFzWfYc3sDNVc44g9X5t5o+gajcgHl8gwURcxnH/OiiTN2xG
         /Yt2GjlNxecc83QEzA7d7uklb/R/HBRcFZse+yhhtXOtSe83O7JRpCBvoal8kcxd7jDt
         IzrqcZOy0n0dQGk1ksWXNrDnV7ADTUI7qd/ZMHuS5Ohx7kUTx1gjuKEZTrBRmi+K5WtG
         bejlern3MFH5ayXYq/Tre6UWPfzEuIeyL7pIQjP+MHXQsharaDe0rjNKsU6KwOYxj0A8
         8wW5BF3thlOrq/2rh9OzthA4UFX9BpY4ZcOEPMyFh8knqq938TsE8p0iKRL9P9Mffgtq
         sKOg==
X-Forwarded-Encrypted: i=1; AJvYcCWlzLKfehYKjcF8SJ9nITfWOoeLyKR7B2dQBu6MAbXg78TQ3KmHZ86hJ5oOP6TPjeSQtpZozgLauBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzxREDFNRv9qtjciKdMeayedW/WtsqUaKc56cbtEkAvAlXyapnS
	zDhbwNWpdNKCl37IETTkGF6YtRPyBKBgqH485GTJ16oCl49VahUfL/uTWw==
X-Gm-Gg: ASbGnctOL/FPQWt05xkqu0xpgB9RdYKurjN+pZRuWBNWjAZSIa1t/+xqsh5V7EC5TDV
	X8l8IGjJO0h4H7gIAIJMI0Yh/o/5YAi8gajbLpFpVmi0s7CdUQE8lFeKKuOxalfS2tqOvehEbB5
	mKJkRCDzMsKjRzFEOdQxiTx+ARQoe+io45queiOjTHOYFLyjtEqH5qJqdZIJ4wRyk9evxE8elQl
	iTUeYrJJ8oCGYl7SyhYkxwuc49YSMpuaRTVrzinDzGv4BhyQ5LSvjc+SseDlF9gCollVER1+Ygu
	kpmrbV9C2QE3ZFZqIJyNR4HAoTONZnFKtPhJk6QNic4fDFhR
X-Google-Smtp-Source: AGHT+IG16OwlDGp1lDWBbwCp8ES2erJvvKiuX/9rl7aqJjvI0apZZuQo/BJHW/htjrLsuVdvdt14sA==
X-Received: by 2002:a05:6a21:3482:b0:1f5:5b2a:f629 with SMTP id adf61e73a8af0-2009f75b1damr23077882637.30.1743489859336;
        Mon, 31 Mar 2025 23:44:19 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106ae4asm8135092b3a.110.2025.03.31.23.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 23:44:18 -0700 (PDT)
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
Subject: [PATCH v2 0/5] Minor cleanups in common/
Date: Tue,  1 Apr 2025 06:43:55 +0000
Message-Id: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series removes some unnecessary sourcing of common/rc
and decouples the call to init_rc() from the sourcing of common/rc.
This is proposed in [1] and [2]. It also removes direct usage of exit command
with a _exit wrapper. The individual patches have the details.

[v1] --> v[2]
 1. Added R.B from Darrick in patch 1 of [v1]
 2. Kept the init_rc call that was deleted in the v1.
 3. Introduced _exit wrapper around exit command. This will help us get correct
    exit codes ("$?") on failures.

[1] https://lore.kernel.org/all/20250206155251.GA21787@frogsfrogsfrogs/

[2] https://lore.kernel.org/all/20250210142322.tptpphdntglsz4eq@dell-per750-06-vm-08.rhts.eng.pek2.redhat.com/

[v1] https://lore.kernel.org/all/cover.1741248214.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (5):
  generic/749: Remove redundant sourcing of common/rc
  check: Remove redundant _test_mount in check
  check,common{rc,preamble}: Decouple init_rc() call from sourcing
    common/rc
  common/config: Introduce _exit wrapper around exit command
  common: exit --> _exit

 check             |   8 +---
 common/btrfs      |   6 +--
 common/ceph       |   2 +-
 common/config     |  15 +++++--
 common/ext4       |   2 +-
 common/populate   |   2 +-
 common/preamble   |   3 +-
 common/punch      |  12 +++---
 common/rc         | 105 ++++++++++++++++++++++------------------------
 common/xfs        |   8 ++--
 tests/generic/749 |   1 -
 11 files changed, 81 insertions(+), 83 deletions(-)

--
2.34.1


