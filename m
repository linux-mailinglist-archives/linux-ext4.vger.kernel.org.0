Return-Path: <linux-ext4+bounces-8503-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930F1ADDDA1
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 23:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 572687AC1CB
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Jun 2025 21:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8047F2F002F;
	Tue, 17 Jun 2025 21:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8MXDIVq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775CB1F1315;
	Tue, 17 Jun 2025 21:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750194604; cv=none; b=ko75NGuAiLRUAT9cBMF6gmiVe5lZfJVI1UofocL2enzfuNOIrpWVACG8jiXETt4jqBtH2AHuVHudxijefDZ8JGfcdgUee6Gk1Qx4Ab9KQJwqv9Dlz0HPReG8PpRoW1nzPhs3vN4B9kGaT4ZuqDv/sgIZQ3I1dhubDzWQ16cSQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750194604; c=relaxed/simple;
	bh=6h5HyU+7sEYivNzJgYWmYbcAldtr3uB9+w5FyIuWTyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Q8MLJLoDkpIroJDb8P0NqOIVnHkBeFIS6w6Igm+pFoPbyk4+1UpEltrvNO22eRo4Wh3OZRY0ZI1R//c4VBRZo9jJvbI/qH9Rmj/ekJkLdEjEZrdCizU2f6/k3igPl/2ZC0RdgS9wlJacKtsVYBel3rtZrFme1SAFB/M2V4/IUKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8MXDIVq; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60702d77c60so13071871a12.3;
        Tue, 17 Jun 2025 14:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750194601; x=1750799401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=s1er4d9l8Ij5+uO2QQyMYaV46wq4H9DE4zUkepQurz0=;
        b=W8MXDIVqZpAlJKocKuWDNhM+4MaNd90KGZUqkbfXairGqZplT6RN1kGrSRVngEMf+8
         ZVAvgWDMW3qjNHGSt86kTcj49XOgMdqMILpNsGZBqwD6HqvAuEZAxF688cMfE+5EK6n6
         8rA6p/oFTATldf09+ISFFz3MQUKrB5AN7XI0AOSimA8Dzb4rr0YQdUyXfHs7Ac6uuERr
         MG/lMdBA+i5XHobQLzOz7ZpMyxf4mO1qNURgfOsb+/3euctAueK2JIs61ookZl6cpGJa
         JmsexXqF5ke/KW2l7GzWx+qy85qzs2yVws8aWW8REvcltfzsziVjU5G4QZNTCQ+5vBio
         P9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750194601; x=1750799401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s1er4d9l8Ij5+uO2QQyMYaV46wq4H9DE4zUkepQurz0=;
        b=HcKEQQDynZfMgslBzPUo1w3VpV5vhAxM3fP8rlQtJROqjKgoo0RD7cC+9hnPuf203B
         US638IdQKhrJA2VJSH++KmRhJUWHUZ0ypmg3mD78eeog//4qMPQZAYotWQlasSEsCLyI
         kwPWZhK/t6HKAqyN/RMDmXbvIaVUpR9vEHBTDgx6UEHxOsaT1ANilc2DdCKgVyOXvj1d
         a1qd1ZdqryoiQWSHAOzXQ89l3PX7sYq2yz+ctbmKNvG7aGyhMeTpRIs7zSKDKdTQzJor
         XqEsXAKfrTH0m5slFobAMqVu6Qiy1EDjAoeRnRpLsr1RDRhzymNwFqFm9MA4grfBLGwC
         Bjpg==
X-Forwarded-Encrypted: i=1; AJvYcCV4gF+zU7JTaYpsONnGW3Coo15UvM0VUKrc5ql7n8su7QC5tzQtwpU7ipWYWSwE5HLpL32HHQUv@vger.kernel.org, AJvYcCVr50jO/xMBbcdw2t3Xzj00Raufq74bIbRo+a0z2pA2mIXAEabzPmnOK4mEbOpmTQ12vOh3@vger.kernel.org, AJvYcCVyI6Cb54kZi3cPVzLIDoJZToiiwb9LS2VudDIK9ZVBrL/y/s+hnNMfrxvVoGxTbAmFl/iR9MFYNp6L@vger.kernel.org
X-Gm-Message-State: AOJu0YzihaRn++s3NwzmRiUZHxQgqR2YTGagH+aggrMAqTIXEM75j7Sd
	oEykiwWc4V4EEp1JpIkdzHSu9Ud4DlaF/ajHtV3694eG7dv/miM8FPx/
X-Gm-Gg: ASbGncuI1jT6H0Fnaw9aj82GnEHGeE7fMm6xr9Ahg8GVbb+iVXRAhrDZvV8AFLbITrb
	wSzxGd5ozOHkxC/3/PxYj10jMobxaD3traS0h2FS3jp6SaBX+1Ei5MNtUwEHjJtOX4VQrRKvjQe
	BqQKjlGSftqc4YDVYRUHUXfYtd6in1mPPkhtO8EqtSVrdQNo1G41/83mVUEmgZg8biKz64Atonb
	OS0y3OmiopmRAwF512IDKZ3mmt2Ew4Mgt2cxLP3oMv6D8dKm7TkqNTtCuI2E2/Gm1FSKIUIZWom
	mKCzYd+xv5x4VKe1lFchA5RkU4iM2IaPe6uC1xY41VNTAV7QdJaRqKV8hAxzY8Nk5LIBQNDfExT
	p32p7e9AUysrd8bS8l3ssSzLzG2OfkaSs41uxp/cKI+0hdNwamqIrNSe7V8c=
X-Google-Smtp-Source: AGHT+IFsWPPEISUc3/DTIP+5sI5p90uo4Vsio8TOeyupzElOw9Aue1Rl0aYQ+PigCqmbCYFzSpPhBw==
X-Received: by 2002:aa7:c90b:0:b0:609:7ed1:c792 with SMTP id 4fb4d7f45d1cf-6097ed1d0e8mr4209218a12.29.1750194600546;
        Tue, 17 Jun 2025 14:10:00 -0700 (PDT)
Received: from amir-ThinkPad-T480.arnhem.chello.nl (92-109-99-123.cable.dynamic.v4.ziggo.nl. [92.109.99.123])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-608b4a93a01sm8506711a12.65.2025.06.17.14.09.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 14:10:00 -0700 (PDT)
From: Amir Goldstein <amir73il@gmail.com>
To: Jan Kara <jack@suse.cz>
Cc: Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-ext4@vger.kernel.org,
	ltp@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 5.15 0/2] fix LTP regression in fanotify22
Date: Tue, 17 Jun 2025 23:09:54 +0200
Message-ID: <20250617210956.146158-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Jan,

I noticed that fanotify22, the FAN_FS_ERROR test has regressed in the
5.15.y stable tree.

This is because commit d3476f3dad4a ("ext4: don't set SB_RDONLY after
filesystem errors") was backported to 5.15.y and the later Fixes
commit could not be cleanly applied to 5.15.y over the new mount api
re-factoring.

I am not sure it is critical to fix this regression, because it is
mostly a regression in a test feature, but I think the backport is
pretty simple, although I could be missing something.

Please ACK if you agree that this backport should be applied to 5.15.y.

Thanks,
Amir.

Amir Goldstein (2):
  ext4: make 'abort' mount option handling standard
  ext4: avoid remount errors with 'abort' mount option

 fs/ext4/ext4.h  |  1 +
 fs/ext4/super.c | 15 +++++++++------
 2 files changed, 10 insertions(+), 6 deletions(-)

-- 
2.47.1


