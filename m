Return-Path: <linux-ext4+bounces-8567-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2E5AE195C
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 12:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 990FD4A6E94
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 10:58:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D53D028B3E8;
	Fri, 20 Jun 2025 10:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fT1tNTVb"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC828A419;
	Fri, 20 Jun 2025 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417049; cv=none; b=NySPDQByjUc1EVmbnhqMK0Bfji2OTUT7kMZ5qbiA+TyJ/LERfdOBkbk32szqyjeX2oXKUn7oesMh8UPZP7k/NHhaS7FVBOo6RCebQkMDFQvvKmLkqUgvmKqbELjjCu37QFdyk03dgCRHv77dNjqUNCcJFHeBBCyyKpLyg0PINGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417049; c=relaxed/simple;
	bh=hdtGy+eE91zOpoxtx7icapkbJlNjxVAS55+I6kWc/KQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oZA5Vptig+5IO+sp2kzRFdIei9PEai5js4+xiMfiVKu8Oqoo1e7HSQpPRC2AZ2T6GwUPFZ4ghjNmeHQAQSEFOpRaCFccMhpqVdAHbeF2v4M/w8SItcxOXqBRNFsADGcx6whOUFjrkLxVYWdz3cOkuOyhBeMKYqA9R5V9KI1teSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fT1tNTVb; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2363e973db1so11654785ad.0;
        Fri, 20 Jun 2025 03:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750417047; x=1751021847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TzzSaEQGD8In1MJqQue0Y7giT+CuTWR39sy5earL9WU=;
        b=fT1tNTVbztMS5/E6zt4QGevamwVRmqGC9bUOfodo8uQshftD6lnChnxJ/JIIgqsMVh
         58YXfkv2sE/CY34xiS1BxhYcRCSx7ELPyHUrblNfy5iy6KVSsA5DDFGe80HeKdfqa41t
         pHZzDWJQ6H0FOdmM+bWsNsGGIbcX4Frj0WtvMG8/HMnsNB4xBcIhl8DksZ0/9lL9lFVG
         gVH1Dvf6pCFL6OAlE2OcPwW6JtXHXgBtmx6YXz4jS/DxlyXgGkn2omx/fKxkfJVPj5n6
         LBGbUJWXqCcMnW1dPMPaR/bCTPDEjmCciIdfUjGEtyIEABE13bImWel4/DLlaWaU4iFn
         a/UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750417047; x=1751021847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TzzSaEQGD8In1MJqQue0Y7giT+CuTWR39sy5earL9WU=;
        b=sTSZVTXVuh5S0az4RxIqBh/KyApsCa9eXgPu4dD+TYZ+z0KtCq+C3EZtySf8K6a+Me
         kWbCdNw0V38SooVGDjbEI7IToxnBCtrohuYEKO5JvS/4y8hlpBoKcIEiuvWuJZeuVprS
         K0aMSxt56Q6h3/caQSGLj7Eu7/cAlG3nXYYxMdbZQ++gw7fmDOK/kK1sTo47qimr8H9J
         UTpCSiXeF62qWVWlOdfp4Ym8SJtAeal8AtmZKp6BxQyMMZoXRiKmsGCQm8gMhheZTKX0
         5xxAFRMKC36SZJN/t5DSWBcTbuUaqEi523qnOCXcUhvkXEMQqjO18tB3wyiy6oqFe8As
         wN9w==
X-Forwarded-Encrypted: i=1; AJvYcCV5ig0QroYQTz0Ei12CVH5USdm/PetEuzSD0R+3luRZ/vw603EoqG2z6QpZAD0aBU5gk/rNEgJaTntipA==@vger.kernel.org, AJvYcCWOyvwbLgYd4j/BGdpgp2AcESBrrp9ffXdTncBSCxDbpdITK1SF58GHt4rMSL1wOFOKsyh2YZdN6zw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz89CWGzcIIqkZzZpollmgwb7YSfjRk4HKmKRrMJk93oba4Qjo6
	uOdKSemJC7TzUZ1BJJ/glMw6rRaan2Y8HOO5PYQCB+Ml2SMuW15v1Oj+
X-Gm-Gg: ASbGncsPmsPuyAtJATigzRTubCg1M+zJ+4pKCloS6KFnE+UFA2PJ9ECvOIRq5dwshxh
	/8w0S2EHViKBMmkCFG6a9fJRKlkl54oJGFJRm5j6tvlk7cvYnru5P5XnhWjG+L1OVxUhXunvITu
	ixxpTCxoVODN+MAh16OeYTJ3vk/Ki8t6WZnEn4JcWAZVMMzandxIQmSvKQPd1Y5ZWrI3Kkn5Y6n
	w00SWuT68rDemq+hWs3PNmHwKO3lneyk1YDtlRcXlW6eVtuyM9UDrACOSN8XfqNN8f/STvjm3iD
	9O7IhHzstq0Yg5uCgexeNwyjmpwB8bdaf/XIHm+m+QrY707Kfj6VuV2s/3BwpQ==
X-Google-Smtp-Source: AGHT+IGMK3jxq+z/lqKEo1x3qZ5tRJYa8c2eozM4LXNv+784rUS4wVIsgy3XLPCIQ4geHe3JgbSvtw==
X-Received: by 2002:a17:903:2a8d:b0:232:59b:5923 with SMTP id d9443c01a7336-237db0ff56dmr32256975ad.23.1750417047080;
        Fri, 20 Jun 2025 03:57:27 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d873845esm15595775ad.243.2025.06.20.03.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:57:25 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 319E8421D91C; Fri, 20 Jun 2025 17:57:15 +0700 (WIB)
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
Subject: [PATCH 1/5] Documentation: ext4: Convert includes into toctrees
Date: Fri, 20 Jun 2025 17:56:40 +0700
Message-ID: <20250620105643.25141-3-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620105643.25141-2-bagasdotme@gmail.com>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3013; i=bagasdotme@gmail.com; h=from:subject; bh=hdtGy+eE91zOpoxtx7icapkbJlNjxVAS55+I6kWc/KQ=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmhtveez1j8UP1ew7SQidZOlxq87/z9WTXRXSLNdk+V3 GH+B9O5O0pZGMS4GGTFFFkmJfI1nd5lJHKhfa0jzBxWJpAhDFycAjCRtBiG/57eb5bP5mwuXdVW 4WQhu89HII/VZ/UKlrt9ojfCpm8/upGRYXfGnImyufNXfG83mfpWpvwPw4HTfwzmvnzAea2nbfu fAwwA
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

ext4 docs are organized in three master docs (overview.rst, globals.rst,
and dynamic.rst), in which these include other docs via include::
directive. These docs sturcture is better served by toctrees instead.

Convert the master docs to use toctrees.

Fixes: 0bf1f51e34c4 ("ext4: Add atomic block write documentation")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
This actually fixes duplicate label to itself warning as tried to be
fixed in another approach [1], hence the Fixes: tag.

[1]: https://lore.kernel.org/linux-doc/20250610091200.54075-2-bagasdotme@gmail.com/

 Documentation/filesystems/ext4/dynamic.rst  | 10 ++++++----
 Documentation/filesystems/ext4/globals.rst  | 14 +++++++------
 Documentation/filesystems/ext4/overview.rst | 22 +++++++++++----------
 3 files changed, 26 insertions(+), 20 deletions(-)

diff --git a/Documentation/filesystems/ext4/dynamic.rst b/Documentation/filesystems/ext4/dynamic.rst
index bb0c84333341a5..bbad439aada262 100644
--- a/Documentation/filesystems/ext4/dynamic.rst
+++ b/Documentation/filesystems/ext4/dynamic.rst
@@ -6,7 +6,9 @@ Dynamic Structures
 Dynamic metadata are created on the fly when files and blocks are
 allocated to files.
 
-.. include:: inodes.rst
-.. include:: ifork.rst
-.. include:: directory.rst
-.. include:: attributes.rst
+.. toctree::
+
+   inodes
+   ifork
+   directory
+   attributes
diff --git a/Documentation/filesystems/ext4/globals.rst b/Documentation/filesystems/ext4/globals.rst
index b17418974fd35e..2264b76e873cc9 100644
--- a/Documentation/filesystems/ext4/globals.rst
+++ b/Documentation/filesystems/ext4/globals.rst
@@ -6,9 +6,11 @@ Global Structures
 The filesystem is sharded into a number of block groups, each of which
 have static metadata at fixed locations.
 
-.. include:: super.rst
-.. include:: group_descr.rst
-.. include:: bitmaps.rst
-.. include:: mmp.rst
-.. include:: journal.rst
-.. include:: orphan.rst
+.. toctree::
+
+   super
+   group_descr
+   bitmaps
+   mmp
+   journal
+   orphan
diff --git a/Documentation/filesystems/ext4/overview.rst b/Documentation/filesystems/ext4/overview.rst
index 9d4054c17ecb7b..171c3963d7f687 100644
--- a/Documentation/filesystems/ext4/overview.rst
+++ b/Documentation/filesystems/ext4/overview.rst
@@ -16,13 +16,15 @@ All fields in ext4 are written to disk in little-endian order. HOWEVER,
 all fields in jbd2 (the journal) are written to disk in big-endian
 order.
 
-.. include:: blocks.rst
-.. include:: blockgroup.rst
-.. include:: special_inodes.rst
-.. include:: allocators.rst
-.. include:: checksums.rst
-.. include:: bigalloc.rst
-.. include:: inlinedata.rst
-.. include:: eainode.rst
-.. include:: verity.rst
-.. include:: atomic_writes.rst
+.. toctree::
+
+   blocks
+   blockgroup
+   special_inodes
+   allocators
+   checksums
+   bigalloc
+   inlinedata
+   eainode
+   verity
+   atomic_writes
-- 
An old man doll... just what I always wanted! - Clara


