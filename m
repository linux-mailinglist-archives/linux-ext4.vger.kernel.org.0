Return-Path: <linux-ext4+bounces-8508-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B4F7ADE9B3
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 13:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC6813A7E1C
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 11:15:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0384A2980DD;
	Wed, 18 Jun 2025 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HoYViUjU"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A9E295DA5;
	Wed, 18 Jun 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245365; cv=none; b=rvSoEQWJyupaPn7l5RWvA9eeqdmzl+9YehuU5e3xk+dRDN59LKP2h18JZVkKZEueYVSHkUUQ77DnjwOeE7OIyh3WusAKT8sdAEjJz5BkyBFtV0A1qbufZebe3RM2jo4HLzS4V/zv2w15nPZ57duOm3k+GX/EJxCZ2DisITQiQH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245365; c=relaxed/simple;
	bh=WM+fr1mKglNeWX++E+JHAdUnDqdYDjuycRYTRJ7Ja+0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CzDpRFOyPTN/jBro70WsK+8j5d39QO9JFLI2adoAU0cDl9sdsQJvl5EhiQQj1Ushxm24eVQ+qr9JQxkJBOeRX3W2RVn42hSnO+nfinhlko91yT0dPvOn3uUJDs6YLIyzJETwIpNS4H4/4T0hOEmpjlKBdA7AboKSvpkPr4E72Xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HoYViUjU; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-235f9e87f78so71196775ad.2;
        Wed, 18 Jun 2025 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750245363; x=1750850163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMcoFd2PaoUji5rvbYhQVmlHYP9geUwUg20LItQ+Jiw=;
        b=HoYViUjUD5POiHqvin/mh0/qP2uJlZxDWtUXGfZ5nuaUVXG+pIir9sAdCP+XImpROE
         pFMRuZeKZH7gJUOGo0HT310TOZlm1wJ/1owwI6yP77JbfZW35wCepDWzbXQvyrOXk5+T
         pr8NGnHmvdZ50t4QweoZRRoauDxCoH1DLWr7XhZh31guvrMfM/skGPnUgHynK8Acautt
         bQ9R4ZWfjbeYzfTYrR8hkMEqa1ARSn03KsysqBeqcX3oNQWSBCVYnjzJdP+jyxe7mjFs
         cu3oORlDJMC7tGx9QoUakKJv1e6xnBEk0woChUmgRkNZ79LY2ARtxYkBzadVgm6RoL3o
         NLNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750245363; x=1750850163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vMcoFd2PaoUji5rvbYhQVmlHYP9geUwUg20LItQ+Jiw=;
        b=WYPzt8cZZZvmziKHZxxRhkxzl3NLUKE/CCOKQ+5sLbp3KuTuGA+7NqiNbI1Ltt4k9d
         3EKTy9DDwTivvemuRziGkmLWgH9G56obxlTW309q7f/0rG0lb4WMPSiUNE524S9J0ref
         DB2varAmWCorNjhoXC5TuOsYf+fScvAnPcw/dZ0JRBrH0WRclrRkBYN/MtD7Hx1W/GoQ
         0FDn9SEY4Sg8Qb10XWNk6eL4rpkVo51Lfk4X2Ili7Rq7gA0TAQxzEuW1iHUOyH7Hotsr
         YIMUC96wyXLjj8yqSee615qKqZw/C/3hrCHXPmr5vpzlmMIQU8lqjQ8RRxj9qXamRkJB
         521Q==
X-Forwarded-Encrypted: i=1; AJvYcCVlE3eJPNFsGaRG+JghCqSFELoso2g1PW2xAbRbr5zXk6p50+kbL+oGpKZaplwqmXBc+Nc8Id6IJWPc+g==@vger.kernel.org, AJvYcCXrAownO61IFhSrOgWOjjr4GDCgO1o5ocunlmeDiySAvQCUA6euw982CF+Lwoxr2CfPrGFf6T5lWaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyjspvANQX4vsr+P/BSAQJchnlJt1gM1kxu9iir3907jF8lYEI
	Z1SDU3Z6tCKXtrb9Q545m+dyLJYhJeKffBX1zoSYj+bZLOHxAT/JUGTb
X-Gm-Gg: ASbGnctJBoX84yjUZlHuL2hqCTOsjs6m+NHzD5mHMkM7384f5bYO8cM+BgS8niU11Om
	B6364ug6eLnbeX9BIlcNwyCYCOiA8w5qUjBaD+s9ty4OcXEsWUZ6Bk70cQZb6dzgeyBdeJLGip/
	t9uWXFH073lFaKBWbuiBwzLJipYhO5cXcBgOmNo7z6vMYG8P8Hm8BUbSZGMDhdLB8ISnpl75dEU
	kVZhvaVQUn3ncE7nn/VQTk/PsyuClmwAcBksB/afXV4Bhft7kwZMTRAnIO/xy2x70d0G08L3q0F
	aywaomFkDSrSugVzf7SoB+32e3TpfNguTABjPWUEmNd3Kg6FddWciZp+BSZVoA==
X-Google-Smtp-Source: AGHT+IEcbWHZGa9kWaS0mqzRZhwsAbPkTcAOZCgJa8ddYgoukpVgeiwalevyyYvBr7XLWYgdCQEuRQ==
X-Received: by 2002:a17:902:ccc2:b0:235:f70:fd39 with SMTP id d9443c01a7336-2366afd37d4mr308513475ad.10.1750245363391;
        Wed, 18 Jun 2025 04:16:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c077sm97551075ad.17.2025.06.18.04.16.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 04:16:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id F07384629FB0; Wed, 18 Jun 2025 18:15:59 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux ext4 <linux-ext4@vger.kernel.org>
Cc: "Theodore Ts'o" <tytso@mit.edu>,
	Andreas Dilger <adilger.kernel@dilger.ca>,
	Jonathan Corbet <corbet@lwn.net>,
	"Darrick J. Wong" <djwong@kernel.org>,
	"Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
	Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH 4/4] Documentation: ext4: Reduce toctree depth
Date: Wed, 18 Jun 2025 18:15:37 +0700
Message-ID: <20250618111544.22602-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250618111544.22602-1-bagasdotme@gmail.com>
References: <20250618111544.22602-1-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=888; i=bagasdotme@gmail.com; h=from:subject; bh=WM+fr1mKglNeWX++E+JHAdUnDqdYDjuycRYTRJ7Ja+0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlB89W3TVX2ceLmfNWwxjmj9/E3LuE1sxOOiolx1zg3P /oaKjilo5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABPpjGJkmM7E9q7RUfCWoJdM zVR9zwv/3v49EPwk0crlQ2v9Pet59xn+O7de7QryuHCe/+6VFKH/a5a+c5aXmHtq5epK8yv+bzb uYwQA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

ext4 docs toctree has an arbitrary :maxdepth: of 6 (which is presumably
intended to cover all possible heading levels), whereas the docs has at
most 4-level section heading depth. Reduce the option instead to 2 (only
showing the title and sections).

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


