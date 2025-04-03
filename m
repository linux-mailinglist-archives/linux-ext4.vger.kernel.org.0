Return-Path: <linux-ext4+bounces-7043-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF1D2A79ED1
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 10:58:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA0E1892387
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Apr 2025 08:58:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2C782417EE;
	Thu,  3 Apr 2025 08:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c3v+tNwu"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0689C224B15;
	Thu,  3 Apr 2025 08:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743670723; cv=none; b=hmZ5kiPIVNIE9Xa6sdi78fEP9Kxjd+WvaU9miWsyJZD1fLeZJ4bj7lEa1VTliyBqVf2LW9MlKPEmg6oJgfxVaXQDeGm0JRVQxUyTTimcFokNSfRPpabKLZ7RjJK1h3rHCmyUI7kkYKZ9SO9igToWU7GMHu5Y3qS2f/axs0qFkvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743670723; c=relaxed/simple;
	bh=BAFBffp+2IW88LaFnf2KXoGLKeMywDAdIarX7YmiZ6I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=K7mNoaWh+vKZPE5aNRHsagp9rkEjIPHmw7VNAOBoyLm2AshRv4nvTLSCWhqjUFRA463FzBwmvbin6i3ckU0QKZOnK1/ivNoBGq9/Tq5Bn5mSorm2RwrYY8KW5teqJqe51tdVi2EtJcl46pKU41WOHHUAzmSlbagMtnSXTD6gvYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=c3v+tNwu; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22580c9ee0aso7562255ad.2;
        Thu, 03 Apr 2025 01:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743670721; x=1744275521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pG55eC7kD08tB6RhJpYEC+maso2wcLG652Shxf64GEs=;
        b=c3v+tNwuyMGq0S1witnp74nsBcV9PoDbxl/0cTO+TSP1R2rbqzIMQI3zZws7V+cg/1
         4IU71b2oYuGV8I1DD0QJ3diE+zB/OQRFZjrokSY0ELmwUbubxPHdLntWVsqUWEhjzcZY
         lS6Vjor2wL4wVfrmjejVq8ddS40efiG7Gg8wvEhNcjg36+pGSRk1PcXT5Z/6wP3tTp7C
         IduF/D6CYP/NbeHz2ou1UlEYCqF0KjpKYGjwH6QeqxRQScx+qwBEnW0cLGLUp/AEasFz
         uv4zJTcB+ikpYiG3nrYTSuRTzwoqvctBf5wM4S3UkZKQbvc6Qv6vz5MwI42Z8O7GNo++
         Um2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743670721; x=1744275521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pG55eC7kD08tB6RhJpYEC+maso2wcLG652Shxf64GEs=;
        b=g/N6mgTPtOJENnOeaLpyj7rV4soPVvoytr5pWBTm4vd/O1S59UtW9ToKzE7wTJSAWk
         hNpVI6detucdXzwE5+aUnMf6qgQeRDp6ql/7LWJsXoegmoiBXAaGNPp3YQSC2WW1opN2
         te7nOLT4YeEApcDzVWgo/xbEtXWpkRx2IMixX9Y1ASV8geX2UHs6GskRUcNQehO2LW6z
         LbZbJrOP6LX/hdR1HJQ8Di2gm2ownKBY05AyHWjeojnkqMRBneKerSGpurVeh/0t7ZYF
         +l4GBpxEr1YuVYsNR4PzzKpWTc25UcIr3b8oODL/btKpVZ+WHF6PR7uaEfwc+apbpYxo
         8cew==
X-Forwarded-Encrypted: i=1; AJvYcCVC4Rhn9/9CU6WQvO6CuPmQsAzIoG1wiilPmMyxtglXw78onniuDgjZ/rpOBv9CDiRpUsC1cgiI7E0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1gcRZSSmpTMv7yuJSd2eWVIeCnPbONFOa0vJDJrv7QuIwPxJ7
	zhTZYCMab8Y92zIgicQ8whlmmnEtf3AaUdMWVQJX5Um1R8m5pJMZqvYXZg==
X-Gm-Gg: ASbGncto6ZH6ls+DKG6CzJNWzIp6ljsq+B/J0HLlKB2Reo+owJiXKYR2RKvWmpBYFkl
	5upjEJmLPASPAdikiuiIpEZYFLOSOw9aEXWvbNr9zT6+bbvT5gP/VzMOXYs7tRr71wCqz0da8fg
	aIf+BXHSU+ULvjN7FcMIBpIhhTqILxwL8ZBP41Zdzq8y75HXf8d/lJEyKmJtkOzbh9X7P21rHGy
	R6m/nQmEev80n2ahGeZIJoch6cT3RDdfaRTO2b1Ni4QNe/HCBDpJv7MPzmWiMfUEK2IhlHfLCso
	OcUx+k0aGHvybWvkHHYP/7JgB9QZg1vANwDVr2XR89QAUhaicrwbnnRfHYA=
X-Google-Smtp-Source: AGHT+IFCOm80c/tpwtxfgHhmKE58Hf829JvXz4CRSMoKhCdRyM3gNkW3LIcjEjjczg2bhBGewA5gNg==
X-Received: by 2002:a17:902:ce09:b0:224:10a2:cae1 with SMTP id d9443c01a7336-2292f9df155mr293191705ad.37.1743670720734;
        Thu, 03 Apr 2025 01:58:40 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-229785c01cdsm9535715ad.99.2025.04.03.01.58.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 01:58:40 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Add support for -q <n> unconditional loop
Date: Thu,  3 Apr 2025 08:58:17 +0000
Message-Id: <cover.1743670253.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series introduces "-q <n>" option to support unconditional looping.
Along with this, it also brings some improvements to output data both, in stdout
and in result.log.

-q <n> option can be useful for fast unconditional looping (compared to
-I <n>) to test a certain flakey test and get it's pass/fail metrics.

This is similar to -L <n>, although with -L the test only loops if it
fails the 1st time.
The individual patches can provide more details about other changes and
improvements.

[v1] -> [v2]
 1. This patch series removes the central config fs feature from [v1] (patch 4
    patch 5) so that this can be reviewed separately. No functional changes.
 2. Added R.B tag of Darrick is patch  1/5.

[v1] https://lore.kernel.org/all/cover.1736496620.git.nirjhar.roy.lists@gmail.com/

Nirjhar Roy (IBM) (3):
  tests/selftest: Add a new pseudo flaky test.
  check: Add -q <n> option to support unconditional looping.
  check: Improve pass/fail metrics and section config output

 check                  | 113 ++++++++++++++++++++++++++++++-----------
 tests/selftest/007     |  21 ++++++++
 tests/selftest/007.out |   2 +
 3 files changed, 105 insertions(+), 31 deletions(-)
 create mode 100755 tests/selftest/007
 create mode 100644 tests/selftest/007.out

--
2.34.1


