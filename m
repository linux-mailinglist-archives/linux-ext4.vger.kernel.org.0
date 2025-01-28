Return-Path: <linux-ext4+bounces-6248-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 747BBA203DB
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 06:08:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B5D593A3A2F
	for <lists+linux-ext4@lfdr.de>; Tue, 28 Jan 2025 05:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6652E1DE88D;
	Tue, 28 Jan 2025 05:00:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F6qLkr9V"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30841DE3C0;
	Tue, 28 Jan 2025 05:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738040450; cv=none; b=RGhhgr+OB09BW9UhHQy5D63X5h59PTGNsB+cvGw0UpahCt2T6x340M1ydTnGzO6OfegiFkkHeseztZe4kfUK/s4Zz4kyKjBbN0iWauFkmKbUE/j2fsYcHa9c4h+RUSVJa/i1MwnGq8cjwAc8NhE1wqh44VuR7cltM1M9NkMaAS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738040450; c=relaxed/simple;
	bh=YnMrgM0kAbn7HbwId81HWNeX/UNge8flowFNY+L5siw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sA2GIjVr8bReK+jpV4S3HJE3UyzCbVWHuLMzF5Oz32KU1cX1iNCWIdtAgwM/2VNDoLjZ9zta+JUBB5FuGquvBRokPPLfZ6ROmdzOyAItV6xp6WI1vE8Y6dP7HCzjxGa5Z7d3lPd0yLUQdlTeevXl7C13Unh8Jsc4VGUXuOIqDUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F6qLkr9V; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-2efe25558ddso6901100a91.2;
        Mon, 27 Jan 2025 21:00:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738040447; x=1738645247; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lI6ZsKdm3CPgRxaFaoLcGi7VSzV9xwpMY9SMD0KXp50=;
        b=F6qLkr9VKn00MtT3eVo385veO7IYOyF7Y/oCZi1z2mkzrwK1Toj7EA3DxJWh5ZNh22
         1QcKNruuHW3HkcZe0hBlNeQMFbwwcQF5WX9PsiuUwfnqPmQZLZBGm6Eq5rv2gTB1U8Y/
         1jASecpEHok2QDVnO+KqxwSDXqNrXyRWnH5If+CuNEOqb36W0Dwcnz5+MbKFEjKvGm+7
         UswFLtiYQNbd/A3uVJ/CkMcDCR7WCR51F2EsaUKsmGZhXDqoCKbuXg/4NQKLHA3IeFYl
         f32IpYstFPD5ZjOYgUzxZfTZ3Sr4hjceVlRJxKw4yyFdrQR3t8Z+BvZ0qqpBN94LWdZO
         HP4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738040447; x=1738645247;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lI6ZsKdm3CPgRxaFaoLcGi7VSzV9xwpMY9SMD0KXp50=;
        b=Eg3/eL6rutPM4GGtX69xq+fmm1QCzfPKWM03TNA6SybJwyAg2X1LiCUOZLAR1LU1Gf
         PISpTt5wEiYVuuvx81tR/5Kri5S8VRyhXVcMtKOdQl3Bo4F2GbtAO7rfsKsdLttqMLi7
         qVTWGChr0RXX3scJlBAvMetGHC8vAhNKtqv11afQTcRRZk9IKbW/pcPNyyG2ipdagdY5
         No1Jms4TqLo47TLus8Y3q5jhghZAdVNeUyb2LDkAgajvcn4M99jYMKJPAr/wSmvcMAeM
         43gE+WC22mUy3Xr7/wiidlEoiQ6wkNRMj2aKVGRhYd1jpU1OX7aZ1iKaPhRvSq0xGzYI
         9otg==
X-Forwarded-Encrypted: i=1; AJvYcCWFlKH6GIYQhMOdnOhAA3NQGPgzH0TvYY5XGxU2PRpYM1BZbtj0Cj83FWnFWzHBVsjYekKajLXNED0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzeCuP+Jx+dEL9jlefEPdZ0UqH65iYm6/oBjkLi7XJzAixnkqGX
	TeuaPyuVgn2nTgO/0sgOmUfSF2UlZJhwvs0/PFTLpevZwozsma1PUT/C7A==
X-Gm-Gg: ASbGncuuBBfWB0KkRuxkW30cCh0/YUfO/TGsATr6AamIr/Qx1+sa7xUVieQfflri418
	5qCibvkdKOquD4RCqFJuIEvqYzN/Y4Zujyw97rgcPgkoSuzfc+8/fkvm1ITB3aC8fN/ruY3uD/3
	Ey19UjeDt+/2d3887/vvGQU/hlVhQOEJui/W8a7eyf1t0Nvtw2FfYNuBX+eeOuV+0GVGIUmo0Oz
	RWiGqDlehq3d5teu5U6rDOBSYg8tZ7QHjRxiGgebCAVxVSpNazPXUutfaMpZ/wunJISAqk9iTQ4
	jYuWcq86n+wwcrT71Ys=
X-Google-Smtp-Source: AGHT+IEKdrFVDQQHdjT3PhB0R5ZBzQ9rTVUXpRMk7c414rupxSwuOFMs6r7axppA7LTYRZZ0T6t5Gw==
X-Received: by 2002:a17:90b:5483:b0:2ee:f076:20f1 with SMTP id 98e67ed59e1d1-2f782afebcamr72962321a91.0.1738040446860;
        Mon, 27 Jan 2025 21:00:46 -0800 (PST)
Received: from citest-1.. ([49.205.33.247])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffb18b90sm9120915a91.41.2025.01.27.21.00.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jan 2025 21:00:46 -0800 (PST)
From: "Nirjhar Roy (IBM)" <nirjhar.roy.lists@gmail.com>
To: fstests@vger.kernel.org
Cc: linux-ext4@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	ritesh.list@gmail.com,
	ojaswin@linux.ibm.com,
	djwong@kernel.org,
	zlang@kernel.org,
	nirjhar.roy.lists@gmail.com
Subject: [PATCH v2] check: Fix fs specfic imports when $FSTYPE!=$OLD_FSTYPE
Date: Tue, 28 Jan 2025 05:00:22 +0000
Message-Id: <3b980d028a8ae1496c13ebe3a6685fbc472c5bc0.1738040386.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Bug Description:

_test_mount function is failing with the following error:
./common/rc: line 4716: _xfs_prepare_for_eio_shutdown: command not found
check: failed to mount /dev/loop0 on /mnt1/test

when the second section in local.config file is xfs and the first section
is non-xfs.

It can be easily reproduced with the following local.config file

[s2]
export FSTYP=ext4
export TEST_DEV=/dev/loop0
export TEST_DIR=/mnt1/test
export SCRATCH_DEV=/dev/loop1
export SCRATCH_MNT=/mnt1/scratch

[s1]
export FSTYP=xfs
export TEST_DEV=/dev/loop0
export TEST_DIR=/mnt1/test
export SCRATCH_DEV=/dev/loop1
export SCRATCH_MNT=/mnt1/scratch

./check selftest/001

Root cause:
When _test_mount() is executed for the second section, the FSTYPE has
already changed but the new fs specific common/$FSTYP has not yet
been done. Hence _xfs_prepare_for_eio_shutdown() is not found and
the test run fails.

Fix:
Remove the additional _test_mount in check file just before ". commom/rc"
since ". commom/rc" is already sourcing fs specific imports and doing a
_test_mount.

Fixes: 1a49022fab9b4 ("fstests: always use fail-at-unmount semantics for XFS")
Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 check | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/check b/check
index 607d2456..5cb4e7eb 100755
--- a/check
+++ b/check
@@ -784,15 +784,9 @@ function run_section()
 			status=1
 			exit
 		fi
-		if ! _test_mount
-		then
-			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
-			status=1
-			exit
-		fi
-		# TEST_DEV has been recreated, previous FSTYP derived from
-		# TEST_DEV could be changed, source common/rc again with
-		# correct FSTYP to get FSTYP specific configs, e.g. common/xfs
+		# Previous FSTYP derived from TEST_DEV could be changed, source
+		# common/rc again with correct FSTYP to get FSTYP specific configs,
+		# e.g. common/xfs
 		. common/rc
 		_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
-- 
2.34.1


