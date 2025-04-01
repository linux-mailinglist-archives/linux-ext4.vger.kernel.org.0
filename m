Return-Path: <linux-ext4+bounces-7026-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F98A774AA
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 08:44:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 32D2416B1C8
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Apr 2025 06:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE4A1E51E7;
	Tue,  1 Apr 2025 06:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEWqXpSZ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637A91E47B3;
	Tue,  1 Apr 2025 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743489892; cv=none; b=l5U0S6EWdru8tAQpKVlfsdtkMdh5m6kVmamFHmgnHolKOJpCr06jFxVMMrddZUiPZ4jVYjk1AblQC5KjNzuvMDUIccrE0u+R7COHw4f3ZpkSx0+3LDzugy8rUFTGH9AnzGDdcLV+h2ynYG19nkMKxFty63IHt4spCluqIvY3gG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743489892; c=relaxed/simple;
	bh=hHAXCr3nq/lhsa1DoZDQ/S+rYmxL90t2z0GRovewTKc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q6mTKQB2fYeZgIWocKvbqyTt1ml8mxyRFreKyL+6CFQxnY5lXhzaVPvNCkmfWRCdDpnO4d8b4ndH3kWOFvBuCxApoLIsxA+pnua5x9omqYd4uoDlCZQAT1GIOn0na1wLw1jFk+z36EbDVMKRodQxmYEnluHgTo9FepqvLfFEBw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEWqXpSZ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2260c915749so71752045ad.3;
        Mon, 31 Mar 2025 23:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743489890; x=1744094690; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h7sAmGKH3P+AHVXMJy/ZUH5KzmfRVUy+dv7rxoyM00A=;
        b=QEWqXpSZZkGfHye05a/x6B7+vctC89tjHnO0zvt4Fy37LhYFoFcnIFyfIM5c9YUXqw
         PLhszAhCsG4IJ+dIdb4OAUmuWZXUHGXNeoWCpkhaEsA9EKmqbn0Uc9q6g/l3mj0dc/J+
         gkAJqApi7Z1uU6YqDBgCBit2ykL1D4igRPDZu0l0HEfIynNcJnXlgir5e80I34S3YTj2
         5bUfBV7zvpyKyPb3AM0s/i03gIg1jsjo2+o0vq21nAm2Bj2nabL7MAY+Jw1u1SXJqGxX
         XYyx5GcGBkvHzd61QsyE9hTGo/3hv6KBXCmWODkUvh3H5lXNp2ZfRMSkO40CM8jvptVo
         Fi9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743489890; x=1744094690;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h7sAmGKH3P+AHVXMJy/ZUH5KzmfRVUy+dv7rxoyM00A=;
        b=sLzqkSAZ1UnGYP2dioq/XbD5Cb9B0lO8HUPKqamP8CE0DbJCS2pvXlDbU554hEm9LO
         UD93fk6o4ELRMEovbA/gptneFWksNqtfjtALjiYB++lKBVY3WQ2OqZThrZbykLEqGMy3
         FMrsoD5aJiZsHuTLPusmp5r5AcR1CFNv5Qf9R+1n6Vdnr9JIzIKsPWX0twE0tGsXUejz
         /68WeTowMrSN9+Bw8Nb00aH0QLgYXuf/QKLx+Nw0ffktC64kuuz3aOkQhKdDXXkPoE3z
         yrUtFAWRGTuaFrUE49G5bXFvFospI7679u8N6Qz9AwO99BYvLw7Wf+Wyv3d90WkkGbU0
         S57Q==
X-Forwarded-Encrypted: i=1; AJvYcCXiClLhPUvyx/0emRdI8TVJ8OGWAJ31tVAyly7EksNYaT+xZXd4sq9EOLfHkhxkZ4ey0FBzRtVZF3g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwygP/ECwwzreaTX89HmqJXH4wjdeEYIP62iDNh16XG6DGHov13
	yYpHdeeSNPMmSWXNHKv6CxSH3LZPIHG53XFGCpVV7pMceqtIOS1WaHTuUybr
X-Gm-Gg: ASbGnctyKo7sgt6j7m31JgMPZiHI1s+eMezbiLleQDdZKAQNwlPzDZa1NFcBsoo+P5q
	NXvMP+4HkO/4c0UjOFTd7pcqsvgo0+ot27bdwGyEBczOCPN2tYirLReGj1tuczk2JbFNO326nQP
	kU0RwOFWOYa548VIB8HW682cyxXxrhqYyacBSSeDw9i7HXq43oPQFaC3dOX/eGtHwmxRAFTZlUD
	FZQW9+T6zCj9AJQwX8jw9qwCHsTjpim+UksJqlMkvS1ppV7MS2ic9tRK2h9Q/Kvt+E59v9U2c55
	/EFfkqYQFOemz45GvcrXUv0jI+olHU3Q7LaQf85NcpnBjBCz
X-Google-Smtp-Source: AGHT+IGScYx34WO+qxCOJqwNZieE94iQGH93k7EpL2EmyUq8P1eB+SmrKJQ/E7cVJAqCRv+WIjaCbA==
X-Received: by 2002:a05:6a00:1412:b0:736:3fa8:cf7b with SMTP id d2e1a72fcca58-739803bc866mr14833352b3a.13.1743489890215;
        Mon, 31 Mar 2025 23:44:50 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7397106ae4asm8135092b3a.110.2025.03.31.23.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Mar 2025 23:44:49 -0700 (PDT)
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
Subject: [PATCH v2 2/5] check: Remove redundant _test_mount in check
Date: Tue,  1 Apr 2025 06:43:57 +0000
Message-Id: <6a8a7c590e9631c0bc6499e9d2986a6d638c582a.1743487913.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
References: <cover.1743487913.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

init_rc already does a _test_mount. Hence removing the additional
_test_mount call when OLD_TEST_FS_MOUNT_OPTS != TEST_FS_MOUNT_OPTS.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 check | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/check b/check
index 32890470..16bf1586 100755
--- a/check
+++ b/check
@@ -792,12 +792,6 @@ function run_section()
 		_prepare_test_list
 	elif [ "$OLD_TEST_FS_MOUNT_OPTS" != "$TEST_FS_MOUNT_OPTS" ]; then
 		_test_unmount 2> /dev/null
-		if ! _test_mount
-		then
-			echo "check: failed to mount $TEST_DEV on $TEST_DIR"
-			status=1
-			exit
-		fi
 	fi
 
 	init_rc
-- 
2.34.1


