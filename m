Return-Path: <linux-ext4+bounces-8563-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 33878AE194E
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 12:57:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC19C4A6C77
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 10:57:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63E3C2836B5;
	Fri, 20 Jun 2025 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MnLzrA5L"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB340255250;
	Fri, 20 Jun 2025 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417045; cv=none; b=YtkfKRuDZ6bzSQGTj6gEuZ6I/g6d3EpmZ28T9xaqzMzdKJUJoNmJfVFGKNUddcrkZMuYZe1SodIvQDwf6qWKcqTjNZeCpQHDU3ZsRttO6JF3LiSPep5pyFeBe0X4zUnzuvxyM8u2+THpOgwhKQAQkubTqefX/FvVZedmeft4NkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417045; c=relaxed/simple;
	bh=gfpQ9Z1lO0AdW5KcdamZiog6rGkXAvMNKaOLrBOPLNw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ft8jnDX4cUkKcy7va4+UeKCwDDlQKKkDyGEx0VlqpXF+mVLCLbBpmzIGLwsTl1JsohqDqww9jKtM1R0M/PYzAgBd2kDPOJPIKd+5btLGrQmhYY5QAQvwrlTkfR7Syx4+PI4UTVXRkrrtUOs3IFwFhG2hxS+KD1s+weMjPMsI3Pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MnLzrA5L; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-235e1d710d8so23833465ad.1;
        Fri, 20 Jun 2025 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750417043; x=1751021843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AlAPYPP3NMkx/T2TTChwBuzZguwripR1Sp0yK++aGls=;
        b=MnLzrA5LNc+V05XuFBrW6/W6q1XIwpDfMiIhpznOf7jcjNYmfES/npsO0L5Upx6bwe
         JFp2wRTRjjd4vTZ4l3paZnFQsj/DQlJBZso7ArMc9T3zh6IPOGKdsIRsuc1nLf6n8mgn
         OXQTcoXrscShGN593/w7+nmS5xN1miod9bytcNXNs7jKD9heZFuz6+9zs8RR7F3AcGIS
         5A5ck1yixs9NlSfARleFxY4XqEBwt3iNFlXQV26spabtrlJLlP9kA3hTHrRrpTja3DQt
         PDFuomlE+0mQJ1clg6NnR5fNNhfzHeIHlM0f02hTdt7ol+a9+F2+twk0JjfBy7gWf6cS
         ygbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750417043; x=1751021843;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlAPYPP3NMkx/T2TTChwBuzZguwripR1Sp0yK++aGls=;
        b=inlm9ke3uN+ZM6xia04qFatGKytblKEqiv3bEeOi+O8aus3XwKtY1xbokQRn4QCy3I
         GIanGwlt9Ii7rUuAEOjH16jtkEhlXCzHXYO6b9Yrirk55Z9lHNTfjXOKffz0KgnbWEZU
         gPxysqeVhvO7ATI0U9QqVLox6ETtQ8fyemUOkYhGGDJXzIMw1UF9luM6UtTF21sQ8Lkw
         2NTk+KvV0bPzs4k7PqkazSYoN1CAkGVTza5HHrx94YKAkQlaFiB+HqQwTx17BV6y7bTB
         au1UAfFmigZWKdjhU0mywdRvO2sTY7s2VqqgHvmzcneOUYVta8mqMUIEizS84Kp2SuMy
         hhLg==
X-Forwarded-Encrypted: i=1; AJvYcCV6MvLoK7867Zm07cgI9fyulT90YXPfkdINF0kYTQ95US4wtmV9PlnNI13xVZDaogj0WmVjB9Jz6NqlVQ==@vger.kernel.org, AJvYcCXDqH4u3jCKngZy3YBtmJdVk8xWRFPSasCxi/VsxzvmRyavRjGPc20DijEDgPyEEDXBNZ0IV+Z+Osc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8pRdoiz3Ls5yWQ3wQXE13SWCuy+PKV0/gQvoM96grGOeQvgMk
	7sCgy/l4swcoZJ+/M4qbjwyEpnBulyzfy0vd8+xL5UQw/Re7+vzLonMkkiEcww==
X-Gm-Gg: ASbGncvfaD9Hwj9UGuBSPvnW00VBih93Rp/wQSOp3RGkz4K1s3NcRcq13rI5oQ8BBj3
	EnTeqmmZw2W/avROdQzBRRlRZdSWIpHJe+oRiZwH/EDC5Z9Ip+WgI4zGtWh7TmV4If/fNy2KF1g
	bxZ23cD26FqURC8z/8JqMHc8f79FU8s+gXdT2TrAR/vGDOhUxFdDMGMYjDLbWR+2tHO5BvvjD6m
	io3KAxYCHx2cVW6aYv40534Mo5bk5GX+TdBq32BknSD9Uaf3OYOGznsyIAwnbaMhXdUxWkedR3a
	Wxg2LfmosOZxedSbQceCBSlDh6F4z8lWeuuKirBNHAnRo22Z6gWs8eFxNk2omQ==
X-Google-Smtp-Source: AGHT+IEZIOIYcbLmKVn6OdTDx/fVh+JZECXH8bDK27l5O1moyHdw7IFlw3BFDYTdtlG0UVt3Q8Xc2g==
X-Received: by 2002:a17:902:d542:b0:235:ed01:18cd with SMTP id d9443c01a7336-237d997a5aemr47687515ad.44.1750417042771;
        Fri, 20 Jun 2025 03:57:22 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8640c61sm15653225ad.141.2025.06.20.03.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:57:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id C308641F3D9A; Fri, 20 Jun 2025 17:57:15 +0700 (WIB)
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
Subject: [PATCH 0/5] ext4 docs toctree reorganization
Date: Fri, 20 Jun 2025 17:56:39 +0700
Message-ID: <20250620105643.25141-2-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1662; i=bagasdotme@gmail.com; h=from:subject; bh=gfpQ9Z1lO0AdW5KcdamZiog6rGkXAvMNKaOLrBOPLNw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmhtrf07+/2KT1tEar6fO5jBfNrZQyl5+7skDebtSj+s kwya9CtjlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAExknSjDX6nVYqV9vCn9j0/P rnV87tTJIbP+IzePIsfqecUG/4+ucWH4X3/np9kD7gPb/PgrOP98tjRd/8ZmI5dvmP0lvrPfRBa eYQAA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Hi Jon, hi Ted,

While discussing on my previous ext4 docs reorganization attempt
by merging contents [1], Jon suggested that considering current docs
file structure, a proper toctree would be ideal [2]. So, here's
the patchset that does exactly that.

Actual conversion to toctree structure is in [1/5], while the rest
is cleanups to make the resulting toctree nicer.

This patchset is based on docs-next tree.

Enjoy!

[1]: https://lore.kernel.org/linux-doc/20250618111544.22602-1-bagasdotme@gmail.com/
[2]: https://lore.kernel.org/linux-doc/87bjqjh5dr.fsf@trenco.lwn.net/

Bagas Sanjaya (5):
  Documentation: ext4: Convert includes into toctrees
  Documentation: ext4: Reduce toctree depth
  Documentation: ext4: atomic_writes: Demote last three sections
  Documentation: ext4: blockgroup: Add explicit title heading
  Documentation: ext4: Move inode table short docs into its own file

 .../filesystems/ext4/atomic_writes.rst        | 10 ++++-----
 Documentation/filesystems/ext4/bitmaps.rst    |  7 ------
 Documentation/filesystems/ext4/blockgroup.rst | 11 ++++++----
 Documentation/filesystems/ext4/dynamic.rst    | 10 +++++----
 Documentation/filesystems/ext4/globals.rst    | 15 ++++++++-----
 Documentation/filesystems/ext4/index.rst      |  2 +-
 .../filesystems/ext4/inode_table.rst          |  9 ++++++++
 Documentation/filesystems/ext4/overview.rst   | 22 ++++++++++---------
 8 files changed, 49 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/filesystems/ext4/inode_table.rst


base-commit: d3f825032091fc14c7d5e34bcd54317ae4246903
-- 
An old man doll... just what I always wanted! - Clara


