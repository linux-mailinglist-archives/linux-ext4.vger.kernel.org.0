Return-Path: <linux-ext4+bounces-8509-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ECE2ADE9B6
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 13:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7CC461787CC
	for <lists+linux-ext4@lfdr.de>; Wed, 18 Jun 2025 11:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37FC29AB11;
	Wed, 18 Jun 2025 11:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J7ICkUa6"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49C8296176;
	Wed, 18 Jun 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750245366; cv=none; b=BU4AE3OQYG0M45ypyvlmnD21xQZk6Z2BWLkS+QUL2Ht/L+skWjOenpZa8OHQs5QqLsVGw2uguWh98K100rtlALQIjI9JCbpI30nLxM9WBCBJaoxXfJwqN0reNmMTNpcE9W/zOO5B5c1uRzy9Xay0xBbBrfrt9g1odqdZIRCjUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750245366; c=relaxed/simple;
	bh=qO5+hse++TSYAipCHNoD5cz5lYesnNYf/JXdf6/iRaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a+RWV3kM2aNyosB7UMqEHYSXbN0q1cVrBy/T3luJi0+Oj3SCsp09GHUXJGcxpToEfWGeFtAaYitscAknLtkhg6XVW//9UU1GsnWT+tjAV5eW4RG3MFuv5dpgZXqyaimwX/VBKMaiTgnbxiUrwNUT/rRp1YZ6SrDFSMYLZ+pMTi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J7ICkUa6; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-312116d75a6so5726547a91.3;
        Wed, 18 Jun 2025 04:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750245364; x=1750850164; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9O+vJuJuV06+zwWJoAI6MyfIqvFehU3X63DGHJZLjrg=;
        b=J7ICkUa6uW6be9trP2+rqovHMlmh+yEgHE+gpaCW0ecUS+UySewJqeZs8UQrmk8HtB
         ZXLhDP9H8VDwCoyMEV23jWgVBaO5TfoREQLhUlmZFyiKtx6VzNO3ZLUQ6MPXVF/V819X
         9tAkZ3KDg+CDhB+eZO1RfDij1P54uDD8oT1/VyJOt4ZPDmXc9hfpuw+kA4gr+fISIV74
         cCNjKqDxIwhjcy8MqDmqXdKBmDjT/YDTBdJnOF/PWKIV9h3XdPnK1zwAsqomLXoz5CvZ
         c7hG8nsqQw4Ug6C5KSnipweFtvSAYHLmZKvpOiiasFFBdxMOdetXhzD/a0J4EQGdMOEd
         f4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750245364; x=1750850164;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9O+vJuJuV06+zwWJoAI6MyfIqvFehU3X63DGHJZLjrg=;
        b=tmZkvPPEzu1uk6cVW4UNZghhxob00EQ91FrLxmfVKawyZ3C6jOlhpmoCA2qgfc1ePY
         LuFDSxcm7jpIIwiAu/vAnQ9I4KfqfYSsPMLvyI80SZ7ExuZAOtu1xTzizKVsuFCDL3EM
         K4zpbT9OCPvDZqRI2YO5pBHGabDOKjB86K5g2RRR1kPQqrGqIm03cAwI7ZldGxNgqAqR
         UsmzqH3BOgyEmVEWRcgC2CJYU1Mlf0qZgiKLzaF8oJa01p1CLVRZx6NGEXGV587+XRIt
         mIGNYtIvjhKt2M+hFkIq2YNXZJlROnDJ8xdqOKPSz7JEA2ka4KbJcf4hDgZhwCCNjiLY
         rg0w==
X-Forwarded-Encrypted: i=1; AJvYcCXK+6QFW1PHsGU3QDruQY2T5vqnbSsvENjzSc2PO/deXpL2I3KGSqkWST1kEs+CKyZR80oLdSVwjz0=@vger.kernel.org, AJvYcCXgOBsP4pDSOJXGav8JdRmI5ZZdGkk/Ta3eLOp9AdRngpo+zzQSzAdEwLC5FkkoON3+D+4ZVzuH8CmkJQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzMq/B0sAV2zbeB5rlx+tErybsPl/3eD5ol1tLk6TCpijyaCvCE
	Cv9lTN4U0kLwbYcT+3ipBuuoOuAqIObz/ZgZaX10WAm2pna1KCNx1Pjr
X-Gm-Gg: ASbGncuhHxAgY/mC0+mMQFnqvtIFBxFtYCbxJfb4+PmsjM3JCc5GWImJKy8atZdCzTK
	29s7bI2QzCWPQ7ClpWNRRQl3kEKvPxqpZMKgZ5lFhXLPgTLAktsRE0O6wm3nOK1zWUUAkV5LCpF
	WsjnhaSgbB604lxVOq6SksXiRqnwZhq7a7eHyY3gHz7FVkmx5lJBVYrJi0emx9Rn8egGGzCZUVD
	rs+ZTp2wJ7VUE3JA2h6iwe0/fZ3Dglbmu/US1Iyaq6HW9UUs5YacInoTZuwkxZ9AQTHmL3Ua8g9
	dwaD4aO9ZIX0Y8R3dTkA9f0xgbWiwsVRV+c64dSdFYiRvm8s7j6G2qe20vnq1GOVKbqI0Si6
X-Google-Smtp-Source: AGHT+IHHpnCIkTZNAO8s9NLrcr8iBPrQLo7xMHe9qOZucq/BXqJjkvinDNE/LSBT089WpP3+NtC47Q==
X-Received: by 2002:a17:90b:57e8:b0:30e:5c7f:5d26 with SMTP id 98e67ed59e1d1-313f1dab662mr27162514a91.24.1750245363732;
        Wed, 18 Jun 2025 04:16:03 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2365d88c200sm97362735ad.51.2025.06.18.04.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Jun 2025 04:16:02 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8C77640036F8; Wed, 18 Jun 2025 18:15:59 +0700 (WIB)
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
Subject: [PATCH 0/4] Slurp (squash) ext4 subdocs
Date: Wed, 18 Jun 2025 18:15:33 +0700
Message-ID: <20250618111544.22602-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4717; i=bagasdotme@gmail.com; h=from:subject; bh=qO5+hse++TSYAipCHNoD5cz5lYesnNYf/JXdf6/iRaw=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBlB89X4dwjM637b3P8+wI0lRPKUGufREMVW4QeybyLj7 9xfGOLTUcrCIMbFICumyDIpka/p9C4jkQvtax1h5rAygQxh4OIUgIl8nsfwP9KE3WvhT9lj25oe xBR0yzp1fXx64dsP2wWn8x2M+fafu8vwP03WQWXxsx8HQ8KPyXkuXaSeNy1uv+2ypYJNS+/efX9 7DyMA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

When a doc is included by other doc via include:: directive, Sphinx will
pick the included doc and parse it independently from the including doc
regardless if it is listed in the docs toctree. This, however, can
exposes duplicate label warning that refers the label to itself (bug?)
when the label is placed before any section heading, since Sphinx
encounters the label twice, both when parsing the included and the
including docs.

This could be solved by removing the problematic label. However, when it
is heavily referenced by other doc (e.g. via :ref: directive), this can
be a churn. Furthermore, the include:: usage pattern in kernel docs is
to use it to included a common doc part that is shared by many docs
(e.g. isonum.txt). ext4 docs, though, is the opposite: splitting docs
into multiple reST files (subdocs) and including them in three master
docs (overview.rst, globals.rst, and dynamic.rst)

Let's slurp (squash) the subdocs instead. This will make the master docs
larger of course (although not as big as KVM API docs), but one can use
cross-reference labels without hitting aforementioned warning bug. Also,
docs directory structure is tidier with only 4 files (master docs and
about.rst). As a bonus, also reduce toctree depth as to not spill the
whole hierarchy.

This patchset is an alternative to the fixup patch that is actually
removing the offending atomic_writes labels ([1]).

[1]: https://lore.kernel.org/linux-doc/20250610091200.54075-2-bagasdotme@gmail.com/

Bagas Sanjaya (4):
  Documentation: ext4: Slurp included subdocs in high-level overview
    docs
  Documentation: ext4: Slurp included subdocs in global structures docs
  Documentation: ext4: Slurp included subdocs in dynamic structures docs
  Documentation: ext4: Reduce toctree depth

 Documentation/filesystems/ext4/allocators.rst |   56 -
 .../filesystems/ext4/atomic_writes.rst        |  225 --
 Documentation/filesystems/ext4/attributes.rst |  191 --
 Documentation/filesystems/ext4/bigalloc.rst   |   34 -
 Documentation/filesystems/ext4/bitmaps.rst    |   28 -
 Documentation/filesystems/ext4/blockgroup.rst |  135 --
 Documentation/filesystems/ext4/blocks.rst     |  144 --
 Documentation/filesystems/ext4/checksums.rst  |   73 -
 Documentation/filesystems/ext4/directory.rst  |  453 ----
 Documentation/filesystems/ext4/dynamic.rst    | 1415 +++++++++++-
 Documentation/filesystems/ext4/eainode.rst    |   18 -
 Documentation/filesystems/ext4/globals.rst    | 1923 ++++++++++++++++-
 .../filesystems/ext4/group_descr.rst          |  173 --
 Documentation/filesystems/ext4/ifork.rst      |  194 --
 Documentation/filesystems/ext4/index.rst      |    2 +-
 Documentation/filesystems/ext4/inlinedata.rst |   37 -
 Documentation/filesystems/ext4/inodes.rst     |  578 -----
 Documentation/filesystems/ext4/journal.rst    |  761 -------
 Documentation/filesystems/ext4/mmp.rst        |   77 -
 Documentation/filesystems/ext4/orphan.rst     |   42 -
 Documentation/filesystems/ext4/overview.rst   |  819 ++++++-
 .../filesystems/ext4/special_inodes.rst       |   55 -
 Documentation/filesystems/ext4/super.rst      |  839 -------
 Documentation/filesystems/ext4/verity.rst     |   44 -
 24 files changed, 4138 insertions(+), 4178 deletions(-)
 delete mode 100644 Documentation/filesystems/ext4/allocators.rst
 delete mode 100644 Documentation/filesystems/ext4/atomic_writes.rst
 delete mode 100644 Documentation/filesystems/ext4/attributes.rst
 delete mode 100644 Documentation/filesystems/ext4/bigalloc.rst
 delete mode 100644 Documentation/filesystems/ext4/bitmaps.rst
 delete mode 100644 Documentation/filesystems/ext4/blockgroup.rst
 delete mode 100644 Documentation/filesystems/ext4/blocks.rst
 delete mode 100644 Documentation/filesystems/ext4/checksums.rst
 delete mode 100644 Documentation/filesystems/ext4/directory.rst
 delete mode 100644 Documentation/filesystems/ext4/eainode.rst
 delete mode 100644 Documentation/filesystems/ext4/group_descr.rst
 delete mode 100644 Documentation/filesystems/ext4/ifork.rst
 delete mode 100644 Documentation/filesystems/ext4/inlinedata.rst
 delete mode 100644 Documentation/filesystems/ext4/inodes.rst
 delete mode 100644 Documentation/filesystems/ext4/journal.rst
 delete mode 100644 Documentation/filesystems/ext4/mmp.rst
 delete mode 100644 Documentation/filesystems/ext4/orphan.rst
 delete mode 100644 Documentation/filesystems/ext4/special_inodes.rst
 delete mode 100644 Documentation/filesystems/ext4/super.rst
 delete mode 100644 Documentation/filesystems/ext4/verity.rst


base-commit: d3f825032091fc14c7d5e34bcd54317ae4246903
-- 
An old man doll... just what I always wanted! - Clara


