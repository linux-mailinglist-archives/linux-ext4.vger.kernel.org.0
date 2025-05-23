Return-Path: <linux-ext4+bounces-8190-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81E5BAC2737
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 18:09:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9F8A57B9022
	for <lists+linux-ext4@lfdr.de>; Fri, 23 May 2025 16:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9C929672F;
	Fri, 23 May 2025 16:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tixuUBqM"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B612E221DA0
	for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 16:09:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748016543; cv=none; b=cF4yXWt6mmHlJowTMso5S7YqHmWhHUjN8kqXqsw1Zs7E7BHmiUy5LaZzrCXJA/W02CKEvbepnoevGquV1eXvXYkkXbfKwxv567TcsufptrjymiItdTxb2D55I2O2B77ZLYEYEUX6T9XzVymlH0S9rlnhrYXvMFAkr2RabhoVJrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748016543; c=relaxed/simple;
	bh=1Q3TcfmNzRDazBSppcZtg7wDQJTfh9folbD7FJfXyzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=TprOTIBHHUkUECkg1raeWGG207MY97Es+oxw/M/MZVWXcZi+g1aPVemrWEsxwo17xX3rmp/qGmYZNgWgBKKPgNGZ5LUeu/PVnxb1efWqfQAxEHeIEOAn30ughI0pF8nyOk4mdkC/7ekx8Q75HjyMNXdOsu4wpMX9GFt+Y4xD2VM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tixuUBqM; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-602c4eae8d5so134884a12.1
        for <linux-ext4@vger.kernel.org>; Fri, 23 May 2025 09:09:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1748016540; x=1748621340; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y8YOV9dsCJJ+cVkHK0vlh5ONGz8WQtP2+w3lfUiN9I0=;
        b=tixuUBqMWE/hMZBSo0MbWm0FIJ2l6sPxr4t7bjO1Wo4bzQTnZ4z4GtAQuK4zOrc2qC
         CQ6qQcMYfOtNsIeBzmgXCIb3crHUBvn99l9fFI4HsPNfj0uYw6HtgFOX+dMxV+Wlx0sf
         DbubbFw8gyOKK6dxjPV9K34xggDAww3yLmmg6olcpS+pn4zIVxqCIcjvHh6yVXDOPnqP
         fHVCmbnzH/bQhFhQ0LJtZG52eTAW07MjJqnk/JnpIxnoHPWB9ITwxrzjaHjdNwGZXzex
         J1RtWjGBzSxlbc4VSiLGNXVtKIOUEAQtZdv+rnH2wxNlx1Fc3y1KRoprfRjiFdPEfUY1
         CH1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748016540; x=1748621340;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y8YOV9dsCJJ+cVkHK0vlh5ONGz8WQtP2+w3lfUiN9I0=;
        b=OUHrILx1idoLbK0wQqO6XSjBQ+CaShCYF/EwATx5wD6f7TVywEdhDEUscKyBSFeuoH
         jjkihhwzorH3kGsx4z1vAZyXkvMq4dOYd6nccHJNfkWN672gNcUb+ZXhMsPh+Z2Z1pMO
         oxl+UYgIbZTJnyKIOGYnZNw2XH/m3qZVS/BMZS/qY6EfwfYe8Uxk8dSc7K1goeCulHel
         +KfTiuqZVOHlGQlooDctbryn58Qp2iC2UilgH0WASX6aNbyXBZYIsauVehPIJocqM5Aq
         NfkbhsWN8xMqUWcxrodij+eiVNqC+5qway/+mZC2tmH5lyzokCu5fvsS6ydTpY9Nisuj
         C1dw==
X-Forwarded-Encrypted: i=1; AJvYcCWrjaZcwGtkRrrUzVgxkppHhYqisFiEWeyVe8ycILJ4MXfp7n61O0Tso5/laIUw1K0zb9XPX7VrPLPg@vger.kernel.org
X-Gm-Message-State: AOJu0YzMvluphck6a+CgCIyC15EGbOdV1RHKpxD8t4KSFCMa6eJgXQWL
	Cs93hCi8xm2NpSj2u/gqexAGnWpmKXg85sbIVIZ8HaU3DYyG7NEMLDPz4qnoYk982rF4JWOG1tx
	fFmUP
X-Gm-Gg: ASbGncuPfv9jsF8xGY7VrT7XfmV0DWYeLEIoJ6gjBIvrN2jXF7TQesVTrtgmM1ISU15
	rrXmpzBgmZplyATJZ7jRH6c0chU6yCrn87lf35HX/GIl+sCSJxvn18Puz0++r5fZvfOUeRU9kXg
	+WL+txJ4qRD5ZUknBDWEb6N4UQ0TtEJ1o13gaNf9sS4y1FmeRLAE5j84AvumVl7ByQ412SfEJHd
	AIbWzoi83XtaV4JzgPjGKB9IE0obQxtWlWkGqLv1kopqVDdSxz48DIojrVvpNLrL9UhPzni0P4S
	90SbVuwPOGE7j/9JRb/vQyDFx/o5j6yngkbm6jGQNoh9inZ4I1PfXyTv
X-Google-Smtp-Source: AGHT+IEChUpJRqifxtoHLs2XridRWAwu3U5O6UAsOP+uK971N/P8KY8xSeu1T4wchwPDHayN25tBWg==
X-Received: by 2002:a05:6000:1845:b0:3a3:6ae4:660c with SMTP id ffacd0b85a97d-3a4c153f70fmr4239821f8f.22.1748016528875;
        Fri, 23 May 2025 09:08:48 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3a360b0b766sm26836366f8f.56.2025.05.23.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 09:08:48 -0700 (PDT)
Date: Fri, 23 May 2025 19:08:45 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Ritesh Harjani <ritesh.list@gmail.com>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: [PATCH] ext4: remove unnecessary duplicate check in ext4_map_blocks()
Message-ID: <aDCdjUhpzxB64vkD@stanley.mountain>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email haha only kidding

The previous lines ensure that EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF is
set so remove this duplicate check.

Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
---
 fs/ext4/inode.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index be9a4cba35fd..014021019b22 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -757,8 +757,7 @@ int ext4_map_blocks(handle_t *handle, struct inode *inode,
 				orig_mlen == map->m_len)
 			goto found;
 
-		if (flags & EXT4_GET_BLOCKS_QUERY_LAST_IN_LEAF)
-			map->m_len = orig_mlen;
+		map->m_len = orig_mlen;
 	}
 	/*
 	 * In the query cache no-wait mode, nothing we can do more if we
-- 
2.47.2


