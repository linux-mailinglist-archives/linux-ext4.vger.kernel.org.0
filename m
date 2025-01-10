Return-Path: <linux-ext4+bounces-6028-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B4219A08AF6
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 10:11:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70AF63A8541
	for <lists+linux-ext4@lfdr.de>; Fri, 10 Jan 2025 09:11:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C07420967C;
	Fri, 10 Jan 2025 09:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kViv+lhm"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE9B1ADFE4;
	Fri, 10 Jan 2025 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736500297; cv=none; b=SZs76LbDMzl0/LbuwD1+wxTwYnrug/noYAiDoyKEzmNbGJ/Rat4dkjL+5yyyaVopVT+kxsFTAvuc+AaK9n0IOvt7eBowE5D4rimzneKxttrUMgl1bycGsO+V+TBb+fI1jBXu/HT6i+tsr6P5nYS0cNoEeq4Ilwxbjgr5rsqz/8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736500297; c=relaxed/simple;
	bh=s0eqmDR0nwVXW9B1/kAixQN9wVrFQXSU7ZjLGfbzmGM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=eAM6v5SaGO281cTsZOM4Bu0bK/OobM5k3lo9yM6ToQ6DtgZpBaeohNYb3UVwCghbqVQbkmN0GJzi1gtrMeGNlnQ6IXDQ6Gooy1+5/Ea9Bdy1L2gs8w45Q2tH/ii8JPpgxu5JbmRuyeSmUHNlXs5RQDTimzXPz7o+U02xU8c0WD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kViv+lhm; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21634338cfdso41138555ad.2;
        Fri, 10 Jan 2025 01:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736500295; x=1737105095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jq+qwXlyjAth+B/D9H3q695N0HoUtv4FJt4RTgu0gjU=;
        b=kViv+lhm2imh5pS6pFeJreik578qZvTmtLZCLkFZ3wEVhN44Dq1cb1iQDzgBaFNlU0
         Ds0PjjDAsOxzC0iZJF+ub+nTXlifQd9uQpb/DKVBO3d3Mr5Z5oeCsajXP9l2zNg435lo
         stjtd3ze2RLDQ1tJmR2n5Dg0aJh9DhdELcBE7xwg6TRvoLYJxQbh+Bqk5aONrDtoReCJ
         LLdvrLbit4rHNd7vYeK+Y1AxD6oeeMbXbNfiqjhDK04+p+AzUskfZzWBIXqwloUnQnTW
         SSGn4psMzRrhtevZXy7F4OZm1SDEt7APwD/9svi9FdwPCRzzcChtkVQwnBN47e0Pdid/
         jIhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736500295; x=1737105095;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jq+qwXlyjAth+B/D9H3q695N0HoUtv4FJt4RTgu0gjU=;
        b=XFsKp/n103s3Aucr4yC6MXD8jn5tlfPiesumApSKbP8oO70WHbenrdpOQa/l5beHVT
         I+Q54kKwCx7jkztoy+wJl8Fj7BZuiUgS1UfWYeoyJYgo+aMpmsioFhJcY9YCNYzxTcqV
         CzyPk8rY4xJBtjvp/mZazw5I/7jnZUNDkmLMj6XG4xyXn6fAjE6h4VRDRhMkwJhShSdk
         54KVvZVG6mS+hLwFAxkwaQxdVKT4Uyvw8kLWqDQLiVc/3Lhzd1J7q09DpBrd3G7tramG
         eyuwEBq/LuEp3SQajoYKakdX6D7gfUcRCCqHn578lBCJ06tonpK/TyGNCTWbjUyAEwUi
         BWkw==
X-Forwarded-Encrypted: i=1; AJvYcCUfmeQaIz1Bz7kz+0eZs/Hk2gX6dHqzoiWMMfQ8wovPGeCYUflICFN0BDJoo4IoelfxOu/Vr/rpsmI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3+sjN/rTTL1FiYHRjJosiIjbcc1jaiWpQgnyECmc2984qHQ8q
	C9N1rJoCCX7yWe7hs0H4ZIz9i6R16ESWifcVNVITA59nM4HlBdHc05hDtK/J
X-Gm-Gg: ASbGnctFofZIfAFl51deg7BFA/K5uvxDQ4eevyTU9/ugIvhtY/lXuA6QGIv7NSl/c6m
	V/GA07V5/kUVxhpUexWU+RAvL4YoMscsSQfEwHsgHmHKQUZ4WnCSKjVIYe3InkDPwWiWBMcWC5+
	xIedPsNRXcfUh3UYBSrUuVaileFbJV4m9He5ogEstcC0NdHG5GyD+ssXetnAja6tb3qu1eThFCb
	8LiUIQ8sp6QRB4n+t8wqjOoTRFbRlMPJZYNXZIYZjbiodwlHBg/yqiRXmMm
X-Google-Smtp-Source: AGHT+IHIolPqHoM3Btx+OHX6JDgXJX7dOVIfwL2vzxsuoNzlVYunjv435q+NKYHaIk3NUW14W1bm0Q==
X-Received: by 2002:a17:902:db0e:b0:216:3d72:1712 with SMTP id d9443c01a7336-21a83fdf36emr150598605ad.48.1736500294676;
        Fri, 10 Jan 2025 01:11:34 -0800 (PST)
Received: from citest-1.. ([49.205.38.219])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21a9f219a94sm10166485ad.129.2025.01.10.01.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 01:11:34 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [RFC 0/5] Add support for central fsconfig and -q <n> unconditional loop
Date: Fri, 10 Jan 2025 09:10:24 +0000
Message-Id: <cover.1736496620.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series introduces 2 new features, central fsconfig support and "-q <n>"
option to support unconditional looping. Along with this, it also brings
some improvements to output data both, in stdout and in result.log.
Central fsconfig feature allows us to define MKFS and MOUNT options for
different filesystems and use this central config to invoke any test.
We don't need to maintain different sections in local.config file for
different mkfs and mount options of any given FS.
e.g.
./check -c configs/xfs/4k,configs/ext4/1k -g quick

Central fsconfigs can be useful for below reasons:-
1. Testers and other FS developers can know what is being actively
tested and maintained by FS Maintainers.
2. It "reduces" the need to maintain different local.config files or
different sections within local.config file for subsystem maintainers
for testing different filesystem configurations.
-q <n> option can be useful for fast unconditional looping (compared to
-I <n>) to test a certain flakey test and get it's pass/fail metrics.

This is similar to -L <n>, although with -L the test only loops if it
fails the 1st time.
The individual patches can provide more details about other changes and
improvements.

This is something that was discussed during last LSFMM [1]
[1] https://lore.kernel.org/all/87h6h4sopf.fsf@doe.com/

Nirjhar Roy (IBM) (5):
  tests/selftest: Add a new pseudo flaky test.
  check: Add -q <n> option to support unconditional looping.
  check: Improve pass/fail metrics and section config output
  check,common/config: Add support for central fsconfig
  configs: Add a couple of xfs and ext4 configuration templates.

 README.config-sections |  12 +++
 check                  | 193 +++++++++++++++++++++++++++++++----------
 common/config          |  51 ++++++++++-
 common/report          |   2 +-
 configs/ext4/1k        |   3 +
 configs/ext4/4k        |   3 +
 configs/ext4/64k       |   3 +
 configs/xfs/1k         |   3 +
 configs/xfs/4k         |   3 +
 configs/xfs/64k        |   3 +
 configs/xfs/adv        |   3 +
 configs/xfs/quota      |   3 +
 tests/selftest/007     |  21 +++++
 tests/selftest/007.out |   2 +
 14 files changed, 256 insertions(+), 49 deletions(-)
 create mode 100644 configs/ext4/1k
 create mode 100644 configs/ext4/4k
 create mode 100644 configs/ext4/64k
 create mode 100644 configs/xfs/1k
 create mode 100644 configs/xfs/4k
 create mode 100644 configs/xfs/64k
 create mode 100644 configs/xfs/adv
 create mode 100644 configs/xfs/quota
 create mode 100755 tests/selftest/007
 create mode 100644 tests/selftest/007.out

--
2.34.1


