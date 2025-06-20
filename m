Return-Path: <linux-ext4+bounces-8566-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655C1AE1956
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 12:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601F54A4107
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 10:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 659E2288525;
	Fri, 20 Jun 2025 10:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f1B6koFJ"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4829289E23;
	Fri, 20 Jun 2025 10:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417048; cv=none; b=B72KIaBHoBlS1RaZWoLlNh/xgNshCVtlRyuwZugIv1v9cnSVvAGFIwJygEvbGSg6mypV2T/HkIMYD+MAYUXXtJwxdS0tooqPJMV8te0EBfFfP/q0SlwWdzRmYVOQ1YV3X4BPqlUGCQyvJdZvu2OdzrdD6SdSUlh9ydkxvC+Hytc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417048; c=relaxed/simple;
	bh=lY/ayXOomIL1r8RZ/GRxVnbF6HVD16IJ2px9/rv4XR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bh0or3BTgOqSki7SWgthhcTmhSO6C3+N6VsCxftPYPjDNs03U6zw5mglRCWO4bKLhgQnEuiJyrd6Bi0wxZ84QSnXFTMXTP+X0HmuOFCE/aLlUAvNvPrzV2besjuahwyYAuGSvBxpLjzrxw6DMH/ZCyjW5ulFNQlAX6ycz2ox64I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f1B6koFJ; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-742caef5896so1244766b3a.3;
        Fri, 20 Jun 2025 03:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750417046; x=1751021846; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vnAiS/NJ2KAGX2dC4sWVLB1kQYs6SJdUQZ+4vbLgyl0=;
        b=f1B6koFJ7XsnT64RNIdO/kCzaAw2qSB9/SiUD7yi0kW+qvNZ5yN/pMU7j87n7zdWCH
         9kBdO4aWr108pTRqWMV40PervHr+VBjx0ue4Y7lUgSaoKjn5CGfF5ZlvwfD8t6bHfd6n
         Wz9nbdarRjN2uc7c0KXGumi5wCqbqU3hQoq88BJmwuiOn/DCbKAhHSCJfdnmkqhkqwbq
         juv1I6mUO+zuWsf38/rlmko60C1y3fE6ik5DhQAz6tFX3pNJjMh6/z5lfflhE+uf4h6s
         o98BSh/4yQ/A4kI2nCzhF93VHQII6JUx8xp/4SnJDAuS9TI1XHJuHThqWAr5E8gRknUo
         G+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750417046; x=1751021846;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vnAiS/NJ2KAGX2dC4sWVLB1kQYs6SJdUQZ+4vbLgyl0=;
        b=KqXc9jiAsj0adlH9N7WFuSxsEntrNLLKYqo1owWw/0LizefDZm05B+82led/4CauQ8
         +dL4DHg/57nZdG/DV7MjWflfqZYuvAbDTwR1RVXmGaXHQK/CGfvs//Jv7VXSxDRF4RRr
         Skh2W5cqjILPfu3qSmBJ8fzF22jbaGEyfKo+Ja9qOxb50tCyOEDvXRWOeF3IwQDJyLDN
         3bJljpE6ipIMoUOLIrjmXfWUUR6sV7p8hktGaKc4YkOJfW3vOSO/dXVZbPG9XHjccZHR
         0ppir5ms38YC62ASpKDRi1Ln7C8K4zwS25FnmWi8pS0pxCMAxeq7ynEpxVbOcgY6fx4s
         QF1g==
X-Forwarded-Encrypted: i=1; AJvYcCW+u9SEQGOyD4c3iavWOunzhWh7Ef3C8Cv90VYNL+sulormHHCVB/AnygyFac3LluOnQEdAgx+ohZI=@vger.kernel.org, AJvYcCW70Pth9tSbZV3UXNmK42DrVSkxnIyCUECIfekvcxukwFgxYBDplp2H6wFh5TSib5N6DcZSgCiPKVxKPg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8yLx+tetjbE77kWKrpL2wYCxGnNR070pWkSqjHoC4xag+jJsS
	f+IXDrts9KMnPPg8m2Pr58ABvNyr+1FDYQ1/LAhBgerfo2fDIp2tje9U
X-Gm-Gg: ASbGncua7cbn+lMzjOeAxJMHKEQCcpSEvFGF3uUoZ/MgxG3UnLkLazvgbEcGn8OK8fi
	PMmi3zVqr4umQZBdMtwTodtZu8LPypvG06+bIdfthVKjchlFx3fuAT3ptWa6e/9iHXrEQ8VfHNq
	6Gajh2kNqeFAafZAc4nqDhnFaHCiV5Uisi/YTa3WbIOXNIOrRmxJpTtV8XyTuyfPCWVpLoJGUXA
	Nx3O0xH5iUFE7MnW8Cg9b2yBUQvZgsgDNnSrb4vpBDMOqQkJaBdcXMRZTTgcQP0cLRaXRAkhcox
	2V5+o4YMEsURjs1ShtNjixMStS2MlE1FN+KLxPiT2ouw7iLF+/QVGZ5ItUa2PV+Udy5Lz3sy
X-Google-Smtp-Source: AGHT+IH20ru9QM1iIZ5c2tDNS4ruPZWTQKdkUFIoWobyCXJuV2LB3qhZD49CwTvd57wRqyKr2htHCQ==
X-Received: by 2002:a05:6a00:138e:b0:742:a77b:8c3 with SMTP id d2e1a72fcca58-7490d73edcfmr3796771b3a.4.1750417045622;
        Fri, 20 Jun 2025 03:57:25 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7490a623e7bsm1741644b3a.89.2025.06.20.03.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:57:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 5CBED40F1700; Fri, 20 Jun 2025 17:57:15 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 2/5] Documentation: ext4: Reduce toctree depth
Date: Fri, 20 Jun 2025 17:56:41 +0700
Message-ID: <20250620105643.25141-4-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620105643.25141-2-bagasdotme@gmail.com>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=777; i=bagasdotme@gmail.com; h=from:subject; bh=lY/ayXOomIL1r8RZ/GRxVnbF6HVD16IJ2px9/rv4XR8=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmhtveemno2aCWn/nvJV/xd64vLacdDW5bqSSrziOTun fzteSpjRykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACYyKYPhN0s02xRnhS1bNLa1 ZrffEVb8/KX0q+8Lwa49G5RM1a6rZDAydJ52f9227uun6/vOZR0o7C39yc5y+acKf2bgy3M9IQH f+AE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Reduce toctree depth from 6 to 2 to only show individual docs titles
on top-level toctree (index.rst) and to not spoil the entire hierarchy.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/ext4/index.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext4/index.rst b/Documentation/filesystems/ext4/index.rst
index 705d813d558f0e..1ff8150c50e927 100644
--- a/Documentation/filesystems/ext4/index.rst
+++ b/Documentation/filesystems/ext4/index.rst
@@ -5,7 +5,7 @@ ext4 Data Structures and Algorithms
 ===================================
 
 .. toctree::
-   :maxdepth: 6
+   :maxdepth: 2
    :numbered:
 
    about
-- 
An old man doll... just what I always wanted! - Clara


