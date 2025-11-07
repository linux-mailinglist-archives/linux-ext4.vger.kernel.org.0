Return-Path: <linux-ext4+bounces-11647-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D3CBC404A3
	for <lists+linux-ext4@lfdr.de>; Fri, 07 Nov 2025 15:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id E3C1C3435F7
	for <lists+linux-ext4@lfdr.de>; Fri,  7 Nov 2025 14:22:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78004328B63;
	Fri,  7 Nov 2025 14:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FIwMtlhg"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65FC431A808
	for <linux-ext4@vger.kernel.org>; Fri,  7 Nov 2025 14:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762525320; cv=none; b=tLUu5+3Gz/jkyoileVSdR/DZRc0pY3VEFoyVlZ3OjM3F9Joac/NWDTzYegGrQHYS2lsHYOTnpL1Gh2XCahXShRyyylnlXOSdoQZhG3UOeHBxA96cNQ8q+9qVa4Jb7J98OfI6w0ae+TJlMdXQhvBY5pbNkH7T5DVvwx+M07iwG7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762525320; c=relaxed/simple;
	bh=4YA7rnYANBJbSIxSqVtePmwnGUnHrdSlVUABR4BCN1E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BrvBsk+A2Q4jXpIhuCtpacn9AzxPma60CPFD9sAUbVJeX4BB+cAEYY7csp01zcIbWrZAxEbdiSc2RO3KHzljKAo/KkAD/6eUiIuEOTKWKThCiIn5P/xd+R+AlyAE6vtEMbgJXwcIOMyTEWmLMIMTTUYmJJDI5/NdyTZAIRQCHkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FIwMtlhg; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-640b9c7eab9so1575590a12.1
        for <linux-ext4@vger.kernel.org>; Fri, 07 Nov 2025 06:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762525317; x=1763130117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8ScNFRclv7Ib95LOsyE3eeWyv7nmH8lB+sNT5DkF52E=;
        b=FIwMtlhgRRHb42jG4xF2+KwRKd9EoY9Z+Msfsc2XiHljGQTjDUIsxCQF2UenqsShcx
         LGAYWAyEGxww6NpDxPAHJBBPo9eR5ZBY4k7cbZKxQ4hYUq36li+6WOstaQDzOCyC5wM5
         5e1g7VbZFByt8Rf4foW6My9ceu1aGjl26F66DvHzvuK2RAiUp/AOixJEeMnZpOZfMQIa
         41qwPZxNdZBnx4992oSL8Wzrr/DtpoybWKfd2j+8h4V6Wy5hUmWUOg/hz5m1qtkIt7HW
         hBETLgadW/3mHmuDEYxqJxw4by+qa2eCIR/HA99GA77bMuDKI5SvuijmOt5GPsjiAmAs
         iGDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762525317; x=1763130117;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ScNFRclv7Ib95LOsyE3eeWyv7nmH8lB+sNT5DkF52E=;
        b=hF17VpHllEVUbvqN0z6UQQChNDVTrdyc7j0Poh2E34mBBJ2wCRUARcDtlBbhq6IBUI
         UCq07bM85fQMimTTg8rG5Krwbz6mkGYwIofVh7zyVisaHjI07Z8R438QJ8wxxu31o9nO
         EIFCiWhlEmOMiHHeCqtPV+Gua5dowNHDvOmvh1xtqq82y4+jDGVisJc332h9oAYFKe/L
         t8GAwV8K+C9wMBRe+twqkHOfMeACS6yM+HzTDJGsPsLFkhXnMfYSetxZg9OnRqv+0lX7
         aoUMie/LyagSD0BEv52DL6SyxDsBhV7WSO1Tm6UrI9P23rLMe6Qkj2b2XGu7zIL2Z2Ue
         jUaA==
X-Forwarded-Encrypted: i=1; AJvYcCW8YrdHFNWWJs9SZPcaowjhJS578Jrofd82aFpH00UANWXYNCHA5NtbBt9JWkttT7SRUssmY6VKOlz5@vger.kernel.org
X-Gm-Message-State: AOJu0Yxx8gFxQP0CiFeJpy8FebfHcE6EMtZwA8udwkRnKwX2uXd6+GoE
	5S8dC4JyphRaSeEoFd76JmChd649LA21tHvpGnstKkOksd067FSOFpk+
X-Gm-Gg: ASbGnctsKHss04f5NmnJb1PDCAniCM9F76j+N73U9lnbZNl9e9vw7HM2tE70BbemyZ9
	mUZUQtsPlu8SDOSHXBiLDAYfKKyMkxxnvA/zDtz/7GPX2w0KMLY5IN8zKfB8YRgN5PTafqCLVBa
	6/NCRdlEfjfNVbfqrkYU9J+CCoTvcoKx38kSi+qINchOtqRBEDpYjheFPsKOrxjjFgj0aJjz/Vb
	zRIXlZxrY0zcTPN+Z4G+Dtn3mJvI7wsasMXrbvUO8X2IbO3A4HtC/9CzlyFNN//fCKki+gbNoZQ
	W4K10j3ObOUWkVqhTmIuTO16X6EyTPTSH4icYgHtj2UctJJjeAHJyC/P/Yf/r4/jmT9YuH3hBhC
	kPXWTSjda9DwtjYrd7dnn73hgOrvitt9UPCbOMjQ5TB1BPe4rGrjIlsynFq+a1QnMRnR4FzLCVd
	iUG57CG9w2n8aYRolBUvoivngHgCZJbGHjDmILi+brn7KS2Tv/
X-Google-Smtp-Source: AGHT+IGGYwqyyUENw1V0QXHKNHeOJ8/rc+O+s/OC/PAhV+9kOen2ldV0JAlre4vOLRyVBu782YEqbw==
X-Received: by 2002:a17:907:c1d:b0:b49:2021:793f with SMTP id a640c23a62f3a-b72c0d9fae1mr392049066b.53.1762525316591;
        Fri, 07 Nov 2025 06:21:56 -0800 (PST)
Received: from f.. (cst-prg-14-82.cust.vodafone.cz. [46.135.14.82])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf97e563sm253322766b.41.2025.11.07.06.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 06:21:56 -0800 (PST)
From: Mateusz Guzik <mjguzik@gmail.com>
To: brauner@kernel.org
Cc: viro@zeniv.linux.org.uk,
	jack@suse.cz,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-ext4@vger.kernel.org,
	tytso@mit.edu,
	torvalds@linux-foundation.org,
	josef@toxicpanda.com,
	linux-btrfs@vger.kernel.org,
	Mateusz Guzik <mjguzik@gmail.com>
Subject: [PATCH v3 0/3] cheaper MAY_EXEC handling for path lookup
Date: Fri,  7 Nov 2025 15:21:46 +0100
Message-ID: <20251107142149.989998-1-mjguzik@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit message in patch 1 says it all.

In short, MAY_WRITE checks are elided.

This obsoletes the idea of pre-computing if perm checks are necessary as
that turned out to be too hairy. The new code has 2 more branches per
path component compared to that idea, but the perf difference for
typical paths (< 6 components) was basically within noise. To be
revisited if someone(tm) removes other slowdowns.

Instead of the pre-computing thing I added IOP_FASTPERM_MAY_EXEC so that
filesystems like btrfs can still avoid the hard work.

v3:
- drop the pre-computation idea and inline the perm check
- add IOP_FASTPERM_MAY_EXEC for filesystems with ->permission hooks so
  that they can also take advantage of it

Mateusz Guzik (3):
  fs: speed up path lookup with cheaper handling of MAY_EXEC
  btrfs: utilize IOP_FASTPERM_MAY_EXEC
  fs: retire now stale MAY_WRITE predicts in inode_permission()

 fs/btrfs/inode.c   | 12 +++++++++++-
 fs/namei.c         | 47 ++++++++++++++++++++++++++++++++++++++++++----
 include/linux/fs.h | 13 +++++++------
 3 files changed, 61 insertions(+), 11 deletions(-)

-- 
2.48.1


