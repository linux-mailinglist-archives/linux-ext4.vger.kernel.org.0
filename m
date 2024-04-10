Return-Path: <linux-ext4+bounces-1939-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCC489F0CE
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Apr 2024 13:30:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 090401C21817
	for <lists+linux-ext4@lfdr.de>; Wed, 10 Apr 2024 11:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25C415B553;
	Wed, 10 Apr 2024 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6LAVQo+"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2DA15B15A;
	Wed, 10 Apr 2024 11:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712748489; cv=none; b=ZfUrPj64xURxvC4p29DNCq0/7bf9gT2KWhEiRAd/6mUAR/hq2EcDyqtkmBPuNEV6xXPl+Bb/6m/u0AC+3IMIevhzpAXsUf2J+QJbGpdGHhZZPYKeCKdcs2mijowcBlqo2x9Bn5f6t5/437t++q5D0Rlvg4k/7YAqZmbjtlDv1zY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712748489; c=relaxed/simple;
	bh=zQD9reb1Og/2cv0dqHDZdUJcbucn8FwX4wKjO/1ShN0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=e4iGGhzm7HDG3RzfK03yutaU0C/DWIvUTSDOH+3HNlOEiMXmz9rvnH8oC6WFMZS9hhii99+Shei+1ptyx6oXgs/NYKedk26kwR+QN7UqrOuNR8TlAx9r+CFxwkFcgrstVOOEmn6uxT8Jj39fr/d18fKZXCD6JHQUJzo6VoydfBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6LAVQo+; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516d756eb74so5912746e87.3;
        Wed, 10 Apr 2024 04:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712748485; x=1713353285; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5Di3el+9O+K85+qwRdX3FObg5JWhX17wOpW5ZhQZowA=;
        b=U6LAVQo+e+3MHW/feKZDb2eLmL1Dg3ya1HICPgyXsrapgVhWFG2T1lofCvmh/uyfL3
         I2qruVX+eyRtCHAPW5BA14+NE2INDgi0IIh7y2feQfzJIKhe0qZTipueIKj3SNtfNAIs
         xHqmGD7llF+qwyo3OTe/RQm/bZMtbYlkqt9yYl33NS/SpD+nKsPLT0xozFOOufVctmMK
         lNyv+FFSvwLWHpmg/jOEDTAbS+hROsj3rb4iOr5sjMqZK2n0fZ6U776MWSbyGQo643ft
         g8Zve4kzSFqwRolHBcMPqvEy6pXapboZ+C6z8NFuupJ0dKiSDUCE6MBuSFyl0MmJ+ujU
         Pcjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712748485; x=1713353285;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Di3el+9O+K85+qwRdX3FObg5JWhX17wOpW5ZhQZowA=;
        b=uwCHENxQOJeOmwQdpJuy2YHFM6a47A7gJdmjJEZpVMplDUk1f9IBK2Vd+JRDujZjMh
         Xb58Z5M9ClRThUE494uTel2XI1RDbft0UX//m5+C5Xt6FbB+3wT8i9BcR2bXVeOp3a7q
         pH1fBwOYCcQJCxuJWUfbPSuTpxIrZNQIqw58QLJLcEo7t6Cs/DSpHIhN6q5S7hwAJx0k
         6xjz762P0O+Zyzn9jZKYXv0ha0fAMX+mV87ngKaXG9JGYy6ITPf2F3BQYUq2bz2KWLcU
         NCx5CwaW5tgNIin2GN833WuPpr8vw1Nymw835Jze1QlyTfkq21hohUhd0YvV3szHl9eq
         18Ww==
X-Forwarded-Encrypted: i=1; AJvYcCWCgcLUimUpdgY5s/C0GjUPvmA7AKa/PITXhtMEi5WZ4dxDd4XBIPwdzKV18PpBYXRAv9bWXthHme1042DrAVkAz75B98/lxEiVqdt9g4FVwnmkZ99AKUmzEuYZv9X0ZA0YgJI4rEGhOg==
X-Gm-Message-State: AOJu0Yyhgy8y3H76R74XvK3nX+/CHv2erYzJ2iCXBSxx+tlxkKgy61lE
	SudJC/JbCbKr4+ceALBPKXCdeVPkEW6/D3boDo1ZJQk0OgsBq2bw
X-Google-Smtp-Source: AGHT+IGf1h0UiA0XnNpSWQPwb+7C7LUshO+9D6IWkNrocMZzRR2s4bom2PG43tzhgkyK+fAY/XOupw==
X-Received: by 2002:a19:a403:0:b0:515:8564:28c8 with SMTP id q3-20020a19a403000000b00515856428c8mr1236389lfc.67.1712748485357;
        Wed, 10 Apr 2024 04:28:05 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id r6-20020a05600c458600b004162a9f03a6sm2001182wmo.7.2024.04.10.04.28.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 04:28:04 -0700 (PDT)
From: Colin Ian King <colin.i.king@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>,
	Jan Kara <jack@suse.com>,
	linux-ext4@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] jbd2: remove redundant assignement to variable err
Date: Wed, 10 Apr 2024 12:28:03 +0100
Message-Id: <20240410112803.232993-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

The variable err is being assigned a value that is never read, it
is being re-assigned inside the following while loop and also
after the while loop. The assignment is redundant and can be
removed.

Cleans up clang scan build warning:
fs/jbd2/commit.c:574:2: warning: Value stored to 'err' is never
read [deadcode.DeadStores]

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 fs/jbd2/commit.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/jbd2/commit.c b/fs/jbd2/commit.c
index 5e122586e06e..78a9d08ae9f8 100644
--- a/fs/jbd2/commit.c
+++ b/fs/jbd2/commit.c
@@ -571,7 +571,6 @@ void jbd2_journal_commit_transaction(journal_t *journal)
 	J_ASSERT(commit_transaction->t_nr_buffers <=
 		 atomic_read(&commit_transaction->t_outstanding_credits));
 
-	err = 0;
 	bufs = 0;
 	descriptor = NULL;
 	while (commit_transaction->t_buffers) {
-- 
2.39.2


