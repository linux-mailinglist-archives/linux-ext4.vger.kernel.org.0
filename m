Return-Path: <linux-ext4+bounces-5815-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 10F089F952F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 16:17:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7974516562F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Dec 2024 15:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90951215F73;
	Fri, 20 Dec 2024 15:16:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cD+ifSsS"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDEB72C182;
	Fri, 20 Dec 2024 15:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734707817; cv=none; b=EIAl7XwyEVHKaDCQnTXO3ZL2Q3F37It/EDYQbNIMv3UCWUA8syCtXbLsBX0P7D1HubLuL2hXYxPWX1bpIZ/STKR7WREGZCyseQlM9lRFhk1NkvgdizO1Ap/moS0bXJpTtB69efQWfH5XWOSS8mBXBKpTgA1rGleP+WadTWuItIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734707817; c=relaxed/simple;
	bh=POPUBkX4xwSzrQpC06P4GACynQvxpDIBpcEUhsEcefc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eTo9LR3LvguG/iZr3e/q5fKMxXkKvwE2eX9b7YhG5JpFMEvQaiJEGB5Y86zU5FXC6trodQXCIydCl6XnWW+XFI0BHJ0jlJIvOcvDoRTqi78RiTC/yfzGLvjeMtXIEqYpgbrX+nT3ich64ioJqeRpw5dU4+kb9eZGDTJyNNIZHG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cD+ifSsS; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7292a83264eso1852107b3a.0;
        Fri, 20 Dec 2024 07:16:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734707814; x=1735312614; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QC3DAK3l36+AtgcbFOAiS4zO7nJeQkEF3UjeqiDNK38=;
        b=cD+ifSsSSpbX1Gs1/gRveET1tgyMpssUR8DWmrsI0KDrkCfV9+hyVRQMWynqTtnmsx
         H6WZEKb8ALlQdaMiSbitf0N4aglgW2HpoIflIc14Yrdyd3FATqPEVKDc7LAFFmoo8iIT
         YPIXRG5FAUMopcCvMPZQ3WfcM4bS8JIxJKJog8b1JCrFMwWqb/IT1mEwertjIFPf7nF2
         zUBQxYjYDCsX9z3aPebdm5zuHIjmtJ18IYGN1WXWGOO/QPCjiEKAnCeNPstKndN48V4d
         Vvy6KZZ5W2cDgGgZZz5iHtzVpjqnoSvmYIAPMYYXMN4WJv9K1ICr222AYjQzf5DX0YAC
         zvtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734707814; x=1735312614;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QC3DAK3l36+AtgcbFOAiS4zO7nJeQkEF3UjeqiDNK38=;
        b=Bs8UVttvlfQgEh5UOf9AQMTlQ7KGflD+fjw2UD/Nbj5qPs1sGoU9HRPKO2LHTSPrMd
         kiQ8a7c0JvxYRHyIERw58FravDXcKy/NP4rT+25/z/TOU4GPza/oiYsmC57McHc8k/8U
         2d6nbWW3OO1nIu33Mxg0jl7UKEL57v0a5ID6vXuRQi75l9H6yox58z9myeIDDGz87SHU
         MIoGKvW655zuhCBUqywig8LqsIP55CKe2btiTSwcThsn+AU62TgLfHFCgOXgIGIwdUyC
         qlyq+dh+5/3LlfKaYJWJ/lyJ5wJukFOMjWf4/MrWCxHly0CwCIcmzPXz5Zrv1bQrDlkr
         JeBQ==
X-Forwarded-Encrypted: i=1; AJvYcCUcswxK4cgcGNmM3O8EZdygbRqt1liysaIINmNh43ssBOg9LIrkyLVUFJcG27YIBMQ49h4xoibfxI7xgoA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwuoQ9VY+pDfHfaYORu2gI5SC8C6deNDTyLxGQwPeKr+w6kaYTN
	9SJiqZ2KpHXiryLYR0/vn9CiHzp5m+7aeZzPIrkfTsgxZeQuc8H///74bvLKS4M=
X-Gm-Gg: ASbGnctAcNvU6nnRqDGAPTtulqf5+Sn6Zdo3zt6IJCvHvhNKcszPdGgnCirbfn/+A+r
	a9HEFuz9zyA6cgboToVZnXiex0TCIMyl1LH9taxTEEkqV5OHS809xnTqHuN6+mHjoavCTQYb4Kw
	+mY2C/9zLpcouRrqLZHbpfgneTrS3MLPDjf43LtLS1o82rX82X9ud7/tKZSdboGTfM/cKJ1+I0g
	qlyfDqSm2hFJiSG5B5hU0G29oZBGxk/NbAbohcHZ4KZET6l5UDjqNiS6Et6
X-Google-Smtp-Source: AGHT+IFoetFvzCf/Dfm7CcTReUGKLEJ+3RAPOmwNlHsYOQfMTKHquSO1br5OW2OYafZpQLPQvzXhUA==
X-Received: by 2002:a05:6a21:670b:b0:1e3:e77d:1431 with SMTP id adf61e73a8af0-1e5e04a3035mr6109727637.23.1734707814158;
        Fri, 20 Dec 2024 07:16:54 -0800 (PST)
Received: from localhost ([36.112.204.124])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fd610sm3207307b3a.136.2024.12.20.07.16.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 07:16:53 -0800 (PST)
From: Julian Sun <sunjunchao2870@gmail.com>
To: linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: tytso@mit.edu,
	adilger.kernel@dilger.ca,
	jack@suse.cz,
	boyu.mt@taobao.com,
	tm@tao.ma,
	Julian Sun <sunjunchao2870@gmail.com>
Subject: [PATCH 0/7] ext4: Convert truncated extent data to inline data.
Date: Fri, 20 Dec 2024 23:16:18 +0800
Message-Id: <20241220151625.19769-1-sunjunchao2870@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Ext4 provides the feature of storing data inline and automatically 
converts it to extent data when appropriate. However, files stored 
as extents cannot be converted back to inline data after truncation, 
even if the file size allows for inline data storage. 
This patch set implements the feature to store large truncated files 
as inline data when suitable, improving disk utilization. 
Patches 1-3 include some cleanups and fixes. 
Patches 4-6 refactor the functions responsible for writing inline data, 
consolidating their logic for better code organization.
Patch 7 implements the feature of storing truncated files as inline data 
on the next write operation. 

Below is a comparison of results before and after applying the patch set. 

Before:
root@q:linux# dd if=/dev/urandom bs=1M count=10 of=/mnt/ext4/test
10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.0770325 s, 136 MB/s
root@q:linux# filefrag -v /mnt/ext4/test
Filesystem type is: ef53
File size of /mnt/ext4/test is 10485760 (2560 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..    2559:          0..         0:      0:             last,unknown_loc,delalloc,eof
/mnt/ext4/test: 1 extent found
root@q:linux# echo a > /mnt/ext4/test
root@q:linux# filefrag -v /mnt/ext4/test
Filesystem type is: ef53
File size of /mnt/ext4/test is 2 (1 block of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       0:      34304..     34304:      1:             last,eof
/mnt/ext4/test: 1 extent found

After:
root@q:linux# dd if=/dev/urandom bs=1M count=10 of=/mnt/ext4/test
10+0 records in
10+0 records out
10485760 bytes (10 MB, 10 MiB) copied, 0.0883107 s, 119 MB/s
root@q:linux# filefrag -v /mnt/ext4/test
Filesystem type is: ef53
File size of /mnt/ext4/test is 10485760 (2560 blocks of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..    2559:      38912..     41471:   2560:             last,unknown_loc,delalloc,eof
/mnt/ext4/test: 1 extent found
root@q:linux# echo a > /mnt/ext4/test
root@q:linux# filefrag -v /mnt/ext4/test
Filesystem type is: ef53
Filesystem cylinder groups approximately 78
File size of /mnt/ext4/test is 2 (1 block of 4096 bytes)
 ext:     logical_offset:        physical_offset: length:   expected: flags:
   0:        0..       1:    4340520..   4340521:      2:             last,not_aligned,inline,eof
/mnt/ext4/test: 1 extent found

Using filefrag, we can see that after applying this patch,
large truncated files also utilize the inline data feature.
This patch set has been tested with xfstests' check -g and has not 
introduced any additional failures.



Julian Sun (7):
  ext4: Modify ei->i_flags before calling ext4_mark_iloc_dirty()
  ext4: Remove a redundant return statement
  ext4: Don't set EXT4_STATE_MAY_INLINE_DATA for ea inodes
  ext4: Introduce a new helper function ext4_generic_write_inline_data()
  ext4: Refactor out ext4_da_write_inline_data_begin()
  ext4: Refactor out ext4_try_to_write_inline_data()
  ext4: Store truncated large files as inline data.

 fs/ext4/extents_status.c |   1 -
 fs/ext4/ialloc.c         |   2 +-
 fs/ext4/inline.c         | 205 ++++++++++++++++-----------------------
 fs/ext4/inode.c          |   5 +
 4 files changed, 91 insertions(+), 122 deletions(-)

-- 
2.39.5


