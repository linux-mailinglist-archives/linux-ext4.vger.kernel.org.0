Return-Path: <linux-ext4+bounces-7964-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF61ABB4F3
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 08:17:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3ECC1729E6
	for <lists+linux-ext4@lfdr.de>; Mon, 19 May 2025 06:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4386A244693;
	Mon, 19 May 2025 06:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DfVvA1Ro"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A397243364;
	Mon, 19 May 2025 06:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747635453; cv=none; b=FvV7LZRfG9GBw18jHomVictVc0sMzCr5espPOP2HE90GJn1IamyGmGFJJNeN4VVhYNPld0UNxXca8LFJ7z0Fhh469ebNNXdnMb3lvMdkMcgK+u91qQecK/JvI4mouc4SVmcz0x0MxqLvDnDIc5jW5hfGiof6f8fuu1fH+/n4+6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747635453; c=relaxed/simple;
	bh=5dxxU7c8+r+464RZvzPJQQM825qAm5R4Gr5H0SgZRxw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=V/WvHCqV+Tib697enyY7DHaw1u5UGDZ+58fgiDfcFYE7sVH3xu/NgWIBB1+IJhUmyvAf1hpzhPbKzWphafu87QBtvHthzyiWy7BUVHT1P3lMhCf5RRNpEPIjaD/Op8nxCKNqEk6FeKuMTNsV8eCXM01eefy+dPrUzw3XCNFZz8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DfVvA1Ro; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b26f01c638fso2401601a12.1;
        Sun, 18 May 2025 23:17:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747635451; x=1748240251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=12xeklId4o9lCsEcd8OTP1SwPsiZrTxDOcu/fb34HIs=;
        b=DfVvA1Ro0lspN4Bw4UUcZY0g7I9cGY49hx2xNguvA/PQWzhe5meA9W75dcWeYfncxs
         Vmow/xEs/iZWoyGBIu8gxqpZaXIPLXdWpQCuwcXwYE+XGdIK8PBzRermCpnSDX444m6M
         dihWTRlqlEDc4S2PvDDwQv0gQDK9olvVb1RE3H5nXsUZsprSGwLGZd6EQeiAEVJsNf+8
         r4CS91WaxoOw9uMUxQ/2mizmUDNXd1OJEWPKlEZtimtvdxN+E4wqj8n3EmmlYmmehCx7
         8KwPfOmjhPMhRNE7UHQBY/mMsQEYoC1qeiLyZSiBouGJrDsH/0j5mf0BetNbqhrIz3rk
         LGYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747635451; x=1748240251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=12xeklId4o9lCsEcd8OTP1SwPsiZrTxDOcu/fb34HIs=;
        b=NOP9nNf6FsHpn7ShOvcxZJZy4x0fOdljiiddhhLs+R32gHIwBTqNZQ3Ucg3NB59VNk
         dWSJjivwVDL9svFPLyS2bxiiQjaSus5WbWgV8gf/2Nr/7jnvLg8QfvBRb1hZHi29XUbQ
         8p3pdHBvbIvrf4pJP808Wa9XoQHKtOmKjZwP6U2nOI5p1iUPpQRYIDdz3SgIHtTB7NiW
         WVYrC3jgCpQfA++0o4Mw9DxhkZ+1d/fTlFGLoUqIs1+HpRzmoRHz6QRTAaih8eY4HpSu
         0Qwk6JoD3LGcC8RiicaWf2/BdsYltv/y+TPIKlXn0GMySLixvh0983fPhtWSZSMxgNm3
         Jj1g==
X-Forwarded-Encrypted: i=1; AJvYcCWDdRj+3mFxDheo1Br3OLLTJGXnLmGiRGewjbpsXVdrO9xIpa40Ew5XfD6wncWpReA5opWiQaoN0K4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyilfu7eA6mER0/AKZBwk/ttQ5Tc+JNHuUxXa13yPNEMM9etTLo
	1aQh5sUDuV2s4GZUpq60ys4NUXXevufCu4XZh+noCYNFgDa8axh2en7eualE4Q==
X-Gm-Gg: ASbGncvsEJ6N2tiq2RDCsYsr9Q7jJH3GEGH6bVALNFFdI7KnuCyw/tMS/LO6gqUpPYD
	fua4AHVMU0vRMj11rZjDc+nu+HrKlOdN1NAWF8PTgz40i252PmO5NKq1XzJMYcmu3/dkdSozdD6
	IeKjhoGU6Yk4UBACVdhl+ipSwBwfspwLnEOZTE0fmAmg8lbcsbg8NUhglJ+mN6AziSCHJ8etSzw
	fiQbenYvqZDVDBbr15/3l85wezqnZhC7gwH8mgeZkfxQ1XCh/Uq+IN0GlSoeiH1oT85e0lOSc5A
	NuVRk3LlMjKX6Wyn0kxhkZQzJ2ypICjCaJTm5G1P2V7JDWg73FRxqTs=
X-Google-Smtp-Source: AGHT+IHaTLy4JHIGKbmcZ6w/ADcINRDTteIi6x5poLelCOSAhvqS2ERvlzJ0a6E+IXomG8K4YVhGpw==
X-Received: by 2002:a17:903:17cb:b0:229:1cef:4c83 with SMTP id d9443c01a7336-231d438b415mr173688515ad.4.1747635451295;
        Sun, 18 May 2025 23:17:31 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2325251da10sm6939385ad.42.2025.05.18.23.17.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 23:17:30 -0700 (PDT)
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
Subject: [PATCH v3 1/2] new: Add a new parameter (name) in the "new" script
Date: Mon, 19 May 2025 06:16:41 +0000
Message-Id: <2b59f6ae707e45e9d0d5b0fe30d6c44a8cde0fec.1747635261.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747635261.git.nirjhar.roy.lists@gmail.com>
References: <cover.1747635261.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch another optional interactive prompt to enter the
author name for each new test file that is created using
the "new" file.

The sample output looks like something like the following:

./new selftest
Next test id is 007
Append a name to the ID? Test name will be 007-$name. y,[n]:
Creating test file '007'
Add to group(s) [auto] (separate by space, ? for list): selftest quick
Enter <author_name>: Nirjhar Roy <nirjhar.roy.lists@gmail.com>
Creating skeletal script for you to edit ...
 done.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 new | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/new b/new
index 6b50ffed..636648e2 100755
--- a/new
+++ b/new
@@ -136,6 +136,9 @@ else
 	check_groups "${new_groups[@]}" || exit 1
 fi
 
+read -p "Enter <author_name>: " -r
+author_name="${REPLY:=YOUR NAME HERE}"
+
 echo -n "Creating skeletal script for you to edit ..."
 
 year=`date +%Y`
@@ -143,7 +146,7 @@ year=`date +%Y`
 cat <<End-of-File >$tdir/$id
 #! /bin/bash
 # SPDX-License-Identifier: GPL-2.0
-# Copyright (c) $year YOUR NAME HERE.  All Rights Reserved.
+# Copyright (c) $year $author_name.  All Rights Reserved.
 #
 # FS QA Test $id
 #
-- 
2.34.1


