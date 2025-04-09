Return-Path: <linux-ext4+bounces-7159-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 52500A81DBF
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 09:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E67C1BA5ACB
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Apr 2025 07:03:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 736A522A4EC;
	Wed,  9 Apr 2025 07:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JmJYOD9m"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43E2189B84;
	Wed,  9 Apr 2025 07:02:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744182176; cv=none; b=MGScwwTjp56g++RJ8bEdGawuwPL4FFMKAe3PhlDB7SDOC4kffSenJDVcQQJI/vGMUGk6qc6m2r88egRNphdE+C6yBQP2ZKF1fEcZs8xFs8Vi74ZwJqdrRFhj6OIcYx+aYDYco8PGfR3j/nujnRqssi2kGLxeRWc2lQy+PyPLYyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744182176; c=relaxed/simple;
	bh=NScYKfZiukSHpYD7qhRdkKSy1meCPCFQ3/cUV+Mv8t4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=AZpt0RLfoZV4cZfhiyo6zzHZDhRPm53IFE1mdWdF2qhNIWuc438W0PHsqqnvwN567ycYJc2s2canxGvi9Hpz3+8hf49sf/bYrRg9Yunm4L9ZvcDaqfFGZFxkSE9hjekMKsfeqoOK2goWj53FxfunwE+KGWoUtbigjm/30xdw4Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JmJYOD9m; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-22409077c06so78895385ad.1;
        Wed, 09 Apr 2025 00:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744182174; x=1744786974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9dGydz7wudeyPdprvaLADMuw3e5GdkMcvYs3YCTWanU=;
        b=JmJYOD9mhmHXaHYVvYov2iOsxvijNdjJGnMEe3vwrztK6xPWd00ksHBn6jkQblXRwG
         56RA+1E/HBcPjX3Xgg2NpIvXjgK4SXZyuiiA2NySQx4GwtdO92Sgl7cvgS+DbRkboQbi
         1+6phsKZX0eT6AQli2xjiQlk8WR5/LWx2fwru++wBSg7eLTwshdcYAJVGq2w+iwjqIV1
         /LjeQEFKFmync6y648TnWSwAQOUQIg1/RfU4JLaBfeUNdb2fhk6g2A6R12mvli6WeeXo
         xG1Et3anFwJPk0Jt/y2ov+jOW8Yf2wjRfcZrQVTPD8+34One7pl7h/iDKkerKb/dmwIm
         jX0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744182174; x=1744786974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9dGydz7wudeyPdprvaLADMuw3e5GdkMcvYs3YCTWanU=;
        b=orwtbAoj5gvjz6hr2RBuHK/pbtuLm6pkDb41dzGhY0A0ZGAUtEDR+0MkkJNx5YhMZ/
         b3KyfotvnPevV9Srp1vda7nF4Y0ucyTB0FTeMdYYUz4CdvH0VXm5JvYxnuHEmtBqJKHQ
         4kzqSV1NkfRHAUBHY4q8O63yBC3IpBGNx+q+XHbwcatogjthRgCkl1sxJTil92J80FAW
         lmquMquhwx5Ki4Wdz6ESaj9KHGwP7owSRd4iPZxeeQ+2nG7dGUPKkI45HJMCGpGqZoft
         Qe9LeqFo9/CIu8KPg2F2zetFSF+4srKXrhsb1AZ1DN+PSeK8ym4R0Z7HPVf1HJWaCF87
         6QPg==
X-Forwarded-Encrypted: i=1; AJvYcCVUyk3QQkL7Z2AvAKEKmMBWZYPqY/xkdFBCU/1XTCguJlGVLAKvTr1zvqyOtgsnjH+CRP9Z+B6eBts=@vger.kernel.org
X-Gm-Message-State: AOJu0YyI8yp8bqcd+RhfLJxQQ5l0qM0PkDb8bUivmq3GYY7Mbjleyikq
	7ZrQdrkF5Iw6sIYxbg0VnX1EgBwwyZ7mlVKWQmIhATHkK/h5FK49Re4OQkRQ
X-Gm-Gg: ASbGncvF2IeQDVKbwKgZhsb9tdBjdVte7T07HI96xF3Snvd/m5Jl37kPpkMzGFaCKi4
	MNO0tagtAnALe1oIO6z5IQOWd+v0pxn8VfwqnzAMB0aWKUThuHJMPLm31bTeSW1OG5ZdgF8Tfq2
	P5jyPSJhkwgSGkMTXn/MDgXTYJHgoIvkDpW6NO5T6IvWL2EPai/OK+yGBpqRRjZixMZmhMTyl3r
	abiY6ni9xEsyyR7XH5l3qZiQWqgREvwIfTlv6r4ruzp2mhzn00/MLRvxps2zgjUZygX2mWziXn+
	SF75TuV3ynO1wcrHr/exyrszMrefkeRzIpoOfPJNOCSCA6DvuahKJjc=
X-Google-Smtp-Source: AGHT+IHt0SjHveTK9PQOyYg/QqBrNsLetzY2wkg+Zyr40yqsxHL+YkulPJ3vF1thapgDmKl0a/qqfQ==
X-Received: by 2002:a17:902:d4cf:b0:224:a96:e39 with SMTP id d9443c01a7336-22ac295d279mr23978385ad.9.1744182173436;
        Wed, 09 Apr 2025 00:02:53 -0700 (PDT)
Received: from citest-1.. ([122.164.80.96])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22ac7c939a3sm4491985ad.117.2025.04.09.00.02.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Apr 2025 00:02:53 -0700 (PDT)
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
Subject: [PATCH v4 2/6] generic/367: Remove redundant sourcing of common/config
Date: Wed,  9 Apr 2025 07:00:48 +0000
Message-Id: <022be73df43379408c355cc18e1a3243f2ee7faf.1744181682.git.nirjhar.roy.lists@gmail.com>
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

common/config will be source by _begin_fstest

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
Reviewed-by: Zorro Lang <zlang@redhat.com>
---
 tests/generic/367 | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tests/generic/367 b/tests/generic/367
index ed371a02..567db557 100755
--- a/tests/generic/367
+++ b/tests/generic/367
@@ -11,7 +11,6 @@
 # check if the extsize value and the xflag bit actually got reflected after
 # setting/re-setting the extsize value.
 
-. ./common/config
 . ./common/filter
 . ./common/preamble
 
-- 
2.34.1


