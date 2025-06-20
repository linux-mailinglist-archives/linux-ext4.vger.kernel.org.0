Return-Path: <linux-ext4+bounces-8564-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF53AAE1951
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 12:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B65A77AF385
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 10:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5945288C19;
	Fri, 20 Jun 2025 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9rnaYnP"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D72C277C85;
	Fri, 20 Jun 2025 10:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417045; cv=none; b=TYC3RwELOHfI/ZGR57raNPiKI8rFbe2+L5ofIqmwjnawojJPjFdWD8cW5SnnqqoGj0XRJzyKdw4sgN10TSpGkw1HuykLxHnQGHDzns/mpMaKNmd8ogn8GQBHXLjQvFxPy39GbJSa8yNt6RRUHaCpC0r2WCsUoEnFs7fhoiqF+4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417045; c=relaxed/simple;
	bh=DTwiJYQnNc9AGZWZW0Dv+ePYGitT+lzesJK1X8jUrTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mc9JcYgITHVHovDj7pHyOsqMtoYBBHs3KAtJtWRsUiL02Vbgbo+TDRAUZyzZYAJl+V2TxsyNH8ry3C7mNpPyl8YEZT/OLNMaCIrRXdBP2gdVttEZaM5h4mXMQzX0bi6a6wFAISFJAoI1aAsnNTNdsqXrBf7y/MSnABuYs8KlQwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9rnaYnP; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b31fc7c27abso143050a12.3;
        Fri, 20 Jun 2025 03:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750417043; x=1751021843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xm1ygtMFp1yHzj86PnisCVORI9v1g6VWyrI+P42tpdU=;
        b=I9rnaYnP+VWh87+tYtOVG42VLvt5aHzPkxwy84Uj6d7sAxWFYm6eILmmY0LjXRG8GQ
         tXHgxpJ/vSY4SgcYL9Qi1pqoSQ3Ux6yaNN0Hib6itEA74HHoMOJAsZv2PSzu5gfywPKX
         bpERo/s4FgBwtRHtOjv3cuNnIwwj9fd0tH8lG7xFIx9FaY/jVYzPrJlOpZiN3u77Y8/A
         vEnT48MKA6No3ERttjG8ZUWcpSsJF78OF6+fIuGIppPhFysl20vzILTKRju9wr3qIqAy
         z60+BZVXAEFvBCn3KgLy9jqg5H02+qGziFCCII00UZ1VRxrGRdV2O4uwcwg+Z6ND8qbN
         /Vfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750417043; x=1751021843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xm1ygtMFp1yHzj86PnisCVORI9v1g6VWyrI+P42tpdU=;
        b=XTIA0e9qhzBmaXC+NRFclxhOl1wILZryBnLRvqgAWv+lzjHmSlIsaoHvGcK/Bs7hXJ
         eOfQvCzm9kKRjNdMyZjt0cdNpxXH3gh/u0XmxmbHDQqZp1IrdwNiYRTQU3tI8ISYQp/X
         uw/+KL8RHdi0FLeZQZWRuCQcUbrsDkm+mktLBzZgfYJGmTBcMraimbifjeKVI1cCDq+L
         t4tanM1+7qZyWj8eReVzsqKR/0XiL4QNXihP3ioCcejGMJA9ZGUILSl00k9Ida88Jr1K
         gPTiLE/scYJ0l5g0LYYC/VaaCzL4R02n0riVMD9b02JtPRqYYS13PnvI2N3Twdf6IT0i
         Xiog==
X-Forwarded-Encrypted: i=1; AJvYcCUeXUnNXRkKpOht3jhE9FwRB8pO3+SPpjc8OX9n0AoU7ftNJQ6Ig98t3uCXmi8HISQk89zMhrhdyCLSCA==@vger.kernel.org, AJvYcCVGPdFso6BvAih1s6nbH+vvo6j4PIbUkq9KI36Q/R9U6TiT8n29FWNG0JkMW7sXKdKGRK0/eNX5O4Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1Bn6H+9ddzmsqoiFCILSvC+AZ19/7i8JseU5TDcdFxh2N6aYo
	Ds1YCyXsaSCobXMj2rnQRqjP82qoeNviTJv6vyGvKWdpWHq/DEp9Rdes
X-Gm-Gg: ASbGnctlH5OiEr/YKnen3ToGdxYDWS/nra9YBshuGOpiYqm/xy1dln9MUXhiGULVnyj
	pQofgHn4Ba7blKvY4z7X/mGsDNX3AmHJcUp/AKHnBZhpkZ15m5FP+xOXgYem/ejYG5FwHw0wsgO
	Si8iHsu+GO37gH5MRJOpuGC+3oewI2G7WGU+XtLvci25RswvGMe9rv3366n7Q/3mpqPCxXUV/hd
	wRl+kO/QkHoipWG/jsvOdmNpm9NnZ8uVJ8cCuhnKS7GwbfjvbcICSWIxNMHF4Bvr/1+MdPQFs54
	z1QVhDhKA+nb6rjKRqP1pSlTpnoKtGwcYB/ht9JRUiexiCeQHLcp3fq3c1kzgQ==
X-Google-Smtp-Source: AGHT+IEeMzChr5YpXkQSb38TF9ejN+susjUsEzMrX/9I3MOi93qmoL1h4M5wrlhRz4hWEYKylxGcbQ==
X-Received: by 2002:a17:90b:2687:b0:311:a4d6:30f8 with SMTP id 98e67ed59e1d1-3159d641124mr4292834a91.13.1750417043111;
        Fri, 20 Jun 2025 03:57:23 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3159df71c4bsm1407546a91.2.2025.06.20.03.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:57:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 9B85740AD723; Fri, 20 Jun 2025 17:57:16 +0700 (WIB)
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
Subject: [PATCH 4/5] Documentation: ext4: blockgroup: Add explicit title heading
Date: Fri, 20 Jun 2025 17:56:43 +0700
Message-ID: <20250620105643.25141-6-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620105643.25141-2-bagasdotme@gmail.com>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2105; i=bagasdotme@gmail.com; h=from:subject; bh=DTwiJYQnNc9AGZWZW0Dv+ePYGitT+lzesJK1X8jUrTs=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmhtvcenrJIXrfZce2uhRKtGfENEV4WET1y1x+6RClOr 6hef2N+RykLgxgXg6yYIsukRL6m07uMRC60r3WEmcPKBDKEgYtTACbStYnhF1OxVwZ/7NPvG2WV P39Pd+jijNaZ9vyYoJ/y4YucD61uWzIyLHl4gCsjZWpt/atf2ya+UHDL21YavrrHqzBCoLIj7+U DDgA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Block groups documentation has three, first-level section headings.
These headings' text become toctree entries and the first one "Layout"
becomes docs title in the output, which isn't conveying the docs
contents.

Add explicit title heading and demote the rest.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/ext4/blockgroup.rst | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/filesystems/ext4/blockgroup.rst b/Documentation/filesystems/ext4/blockgroup.rst
index ed5a5cac6d40e1..7cbf0b2b778eab 100644
--- a/Documentation/filesystems/ext4/blockgroup.rst
+++ b/Documentation/filesystems/ext4/blockgroup.rst
@@ -1,7 +1,10 @@
 .. SPDX-License-Identifier: GPL-2.0
 
+Block Groups
+------------
+
 Layout
-------
+~~~~~~
 
 The layout of a standard block group is approximately as follows (each
 of these fields is discussed in a separate section below):
@@ -60,7 +63,7 @@ groups (flex_bg). Leftover space is used for file data blocks, indirect
 block maps, extent tree blocks, and extended attributes.
 
 Flexible Block Groups
----------------------
+~~~~~~~~~~~~~~~~~~~~~
 
 Starting in ext4, there is a new feature called flexible block groups
 (flex_bg). In a flex_bg, several block groups are tied together as one
@@ -78,7 +81,7 @@ if flex_bg is enabled. The number of block groups that make up a
 flex_bg is given by 2 ^ ``sb.s_log_groups_per_flex``.
 
 Meta Block Groups
------------------
+~~~~~~~~~~~~~~~~~
 
 Without the option META_BG, for safety concerns, all block group
 descriptors copies are kept in the first block group. Given the default
@@ -117,7 +120,7 @@ Please see an important note about ``BLOCK_UNINIT`` in the section about
 block and inode bitmaps.
 
 Lazy Block Group Initialization
--------------------------------
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
 
 A new feature for ext4 are three block group descriptor flags that
 enable mkfs to skip initializing other parts of the block group
-- 
An old man doll... just what I always wanted! - Clara


