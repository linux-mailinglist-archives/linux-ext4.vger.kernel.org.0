Return-Path: <linux-ext4+bounces-7824-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2364DAB4DC8
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 10:13:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97DBD3B87D1
	for <lists+linux-ext4@lfdr.de>; Tue, 13 May 2025 08:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34FAC1F583D;
	Tue, 13 May 2025 08:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FuYzV8Gq"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 704BA1EB1A8;
	Tue, 13 May 2025 08:13:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747124022; cv=none; b=muTT1Uwa4lDM2aMmxv91ydGbzj/S2Z/ZxXOHzUarR9y8jxegBRwxw6yr2vINSBSVPXFF3nyygwbFUWfPSJZAOte8QOfp/MoB/0GJ/zOLcgmCTY6EIQ0934zM9WXNBdDk1oU1LfEgGMjyaYHMH1Kq7REKOh4BtUZ1cH62nvKEpVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747124022; c=relaxed/simple;
	bh=yVhtb993UjXv3KDtO3A46vZCw/cZ772iRXSh6K5qovc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q77rgEY8R19LBZf6zTAHEdjtQIzbP4DvCUXoZry8qeIr3cMbApqiLRDCRBiGc0HL399Nc1bnhh7Z7s+deAbIrvhEeL1GtPy4r0tn++bZknVWtXxgW/t24YflSc45GbxWbGJkEJQuq/dscHdRRfHOdO3H6tJsS5u2mdEIEOPK3KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FuYzV8Gq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-22fa47f295aso34964645ad.0;
        Tue, 13 May 2025 01:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747124020; x=1747728820; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tGhtA+b9yCGjl1qMYlaLImTH7fClB+hY0dTCbKcCN4U=;
        b=FuYzV8GqazQZqtIcG+wtZGwap7XqGKC95fYW99IblLdceg7Zuxo2eN+kh5ZROAyWKR
         PNPSQUclZaGT+If5br+bWpo8a+/To194QVlkHU4/yUCyE2XUQXG60v4U5C5dTfpzvoy6
         bC+VGqxhimi8Bq+5V+Js6N57NlDp/QV2/jch4bz+Ag2tGibaEvKle0nMVoj11SKnYvGl
         Vv5VydfWDjHXPT/XU7sKz/5k7V+ActxE6DINRyEZLD7PICuhjr6qM/M02L1TnaVyLiqC
         cMGDfFfF/ys1WigzT8NPtIYHbywNOyxsfOjoJ1sWGJSFna/WnVxU4o3GAy0GV7D1OSVD
         1VHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747124020; x=1747728820;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tGhtA+b9yCGjl1qMYlaLImTH7fClB+hY0dTCbKcCN4U=;
        b=V1Ha8PfL08kDmu/2606gy7Kq2RHGx9dcMvY+JLZCzvXY5+X5pR8DuDDR1oB5z2yixe
         f1kq5lKlVFnDFONOgFjpfGrS4qOaj5yF90LXJl288kDVu/fINnIoik6nauV3z1Bz2xKi
         ejJGMw7A0cyfadjOVYK24zoHGAHH2+9cVeG3K5/nfjiT+h+UUZtO5PJrMMDkefVph7JF
         hyqT+xf6kLh2qUduO4fN56+F1D/bvTKxwIrBSdeRmlhrgPTHAVafOE7igH2PAU/eVraA
         5wB0Xi8EeOq9FUn2l6SNEqNqHwXtJjDmFp17B3LOoUZMfNDsOuIMcAHriY/6fEvs4JL+
         rgrA==
X-Forwarded-Encrypted: i=1; AJvYcCWEcO4fCxsY4PLPAHrjlPruoTcw2Kz3qdVyjVz1zQHssTwNJSQ54HaEtucwq/qCKZK8gRwlMQp48OY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxH3kH4CfSRtidt+GszIdTlE+K4Sog/OStUw8UD2/78gj6GLyLf
	CfSTNNeExRRrT7Qheqo0oZNgUMG1EmYnrV/a0mJ5VFGWhH0Yi3KokmzD2Q==
X-Gm-Gg: ASbGncv+QYS9Qdd1f+mkfCjwza6kvzZvAevvS3JERx/DaJbw95ze2640Nj3IBukHSMK
	PE8DZHgF/hdPpndvfdPCpoogeYoCszZUPSEtxmI2a/5zfkzEtygfCISHxS/DdwsCNs+Dvg1Os1E
	2PZeacLRbuGS0oNqr6tga0vKhdpExRacGIvnp2KOCW5TQH2Oe6uBs+BxaG1080UHr9jgiZmzimH
	X2KFXplq6xH0Gz9Fh+P7tPX5W85eRaES12jBoy3K3kUkBCGgSMd4QAFAebISREDSCjha784CGYL
	WABMWSQBKMG0Me9caJuO6s91HG8kBpe9Xl/ZOrbabNMqnMay07WH9e0ugZQ/lyDnJA==
X-Google-Smtp-Source: AGHT+IHiaMF0KToAbtG9M6C1knaVtY2O9CZtUjcWhzTog+OC0jkqtdZPfZ2TYyQC8I1HriMYG0iw7w==
X-Received: by 2002:a17:902:d581:b0:223:3b76:4e22 with SMTP id d9443c01a7336-22fc8b0b618mr207261875ad.6.1747124019778;
        Tue, 13 May 2025 01:13:39 -0700 (PDT)
Received: from citest-1.. ([49.205.34.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22fc75450b6sm75896585ad.49.2025.05.13.01.13.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 01:13:39 -0700 (PDT)
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
Subject: [PATCH v1 3/3] new: Run make after adding a new test file
Date: Tue, 13 May 2025 08:10:12 +0000
Message-Id: <cf589731ad93deb067f6dadf0d80604884fb330a.1747123422.git.nirjhar.roy.lists@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
References: <cover.1747123422.git.nirjhar.roy.lists@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Once a new test file is created, it needs to explicitly
added to the group.list file in tests/<FSTYPE> directory
in order for it to get run. Automate
that by running make by as a part of creation of the new
test file in the "new" script.

Signed-off-by: Nirjhar Roy (IBM) <nirjhar.roy.lists@gmail.com>
---
 new | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/new b/new
index e55830ce..647763c1 100755
--- a/new
+++ b/new
@@ -191,5 +191,13 @@ QA output created by $id
 Silence is golden
 End-of-File
 
+echo "Adding test $tdir/$id to the test list..."
+make >> /dev/null 2>&1 || true
+
+if ! grep -q $id $tdir/group.list; then
+	echo "$tdir/$id created but not added to the $tdir/group.list."
+	echo "Possible reason is make failure. Please ensure a clean build"
+fi
+
 echo " done."
 exit 0
-- 
2.34.1


