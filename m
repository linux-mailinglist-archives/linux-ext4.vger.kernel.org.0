Return-Path: <linux-ext4+bounces-8565-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43099AE1953
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 12:57:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B23981BC5629
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Jun 2025 10:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6534B28A3E1;
	Fri, 20 Jun 2025 10:57:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bKqT6DS0"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ED722853EF;
	Fri, 20 Jun 2025 10:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750417047; cv=none; b=kDHi6p0AYcWlgkMKzMrBYS4B0eJKAwyJGAnCTnOFuKskVPW/jCH3O//ragaELTqSGKIfLnGeKkvQ0mqFb1QaCEk43q/u9IE3sR9/e8gfLPCPvhlYiNr/dysPBwfgCSTs1uAFlaW2eEjgKNDBlWjKWkpAH+qM8MV8We3TUt7Rpc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750417047; c=relaxed/simple;
	bh=++7Yml9JsmL3GZk3oycWGg4YVpXZATaK+KA1ZT02l/o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LctyS17VK0PXQv7qBldBumwk2oxBLAbI2a27b398c1n6XyGUQWb4q9OONjBoPhVuLh2j3URxj4YaiRf19YrTbL218UYE3c3n6KlZQ8EPsm6Zyq/aUHeOSqzTn/EP2WZpqB9noaLTFvlbs5J5Tw2JYmQSZ6XGvp6l/rIlpdtHVfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bKqT6DS0; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-23508d30142so22961975ad.0;
        Fri, 20 Jun 2025 03:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750417045; x=1751021845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7I8lZqQE+SoK80AKgdvUGtRJHMKihQjX5aQWXaxRPDw=;
        b=bKqT6DS0TnwTgO6eV9j2CMAD/kb7qJwoz+qhHFymNciNUYlDMn2KQW05i4cccUW7Nm
         d8xjEjPJ4ukEQWPN+EqgJdsuY5eyXOjK3OTPmXhE+kn335kDgmvn+KOEbUz6dWLw1sAj
         IRx7AXtl9kVmB6Vi+uHypTtEB5IgYQFU8+3rjJbCgW8imumAbM3v66f/GS8WSIrfhqYR
         zJ2ppbCux4kZBJ12tZ3Ww3RAimGJ6RJVO0lHMoAAn3/5nRhKdXFAc/24EMLoCauC3t2V
         QqgOPaYdT0ncgiCw43hXcubG3W7adbgBOQ+k8qhi8imkBPBsubibRUzlH8sPoNzIDbI6
         eJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750417045; x=1751021845;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7I8lZqQE+SoK80AKgdvUGtRJHMKihQjX5aQWXaxRPDw=;
        b=XHs/txi0O8rkaX6/xsD3x5WtIVDwP+gu99Ae7pPp3KL//BdtrOIIe3AjL/s95oKCR3
         /E6JK0Qtuw5VGDyh5n0Da3KhN+KUVbSCwQx/h6apUaMBxj1KJjOAJO0QavtK5Rq98Jeh
         I7ODN/Mzz7wVGdNMmOhzo7xSVbRdqP6jDcgN/8pVUDGsLEVAqYNR/GI2hO9HYS2xfp9B
         Zhf2N94uplXe9HoKhB5GCWCW5drCR6U6azD7MorGRmRNzpsvu8SaZ9NbwEHBokwNVDUp
         Z8Eg/5QJ3zJNK1VIXgsgKDvN1Ruc2Sacc7SWwynTVvNgRDdypqhFTVk7XIDo8Y3shfTI
         oO5A==
X-Forwarded-Encrypted: i=1; AJvYcCUkiJ0nJYSz5knRFyj4nJzsPncPPTVjZz1H48VxDWEuKr1m3f1x6RVLIVlo0exOeWsLQ5G8WybngxiI+Q==@vger.kernel.org, AJvYcCXwx4hImFYWh8gFJh/TOf67otVqQ6lP0Re9yUgJx/0mVUoSJxxVZndzvfJZYno04LoOG8Pkl7Sm/Ow=@vger.kernel.org
X-Gm-Message-State: AOJu0YyE0qQuWh6D5avfc7XWMMqRAdLHEyKTlsGYPIsrLjvDWoJAG795
	UxYFvnYeE+nKGW3vhVf5KCs/qtWYPLN6d5epIxS22t+wyONAN81EMv9G
X-Gm-Gg: ASbGncv8hJW1wViBvYRiDDWJb+XFfD47EuEt9K0dDKzqOzp50jnkMhVsUQmZNLi6pdX
	7G7fMeyMznqsZkoH6fNzzalJAYropVBxPEYgXrxaPBF+IEcerCmdMDELPzd6hR01fT5PwNdhZLY
	9K/vzFr+t34dm011qh1fu3H1+Mz7NgtFTfEPo7l9Cxbc8gy05WqmB2aLW0br68kYVtovGQxclfq
	RXg1DEO+fIQ6W1X0MADLSG9JuFAEsDMbGeUig5V5uFe4JdpDBltGb3+ZTuvD/Chip52okiGauhR
	UfFJXRLOpMcabji65L5X9Y1Om780OUXtEOTpBLyZRAlFKyapvUW4zTmDxkVwOcgliFGSHpgk
X-Google-Smtp-Source: AGHT+IFnnpcerGp2wXOFmxQ6vBkym6Su9/uEj+sOvsLI0n891gdnwbda7YqfqA3PKfARBkBGEIQ90w==
X-Received: by 2002:a17:902:c94a:b0:235:ef67:b595 with SMTP id d9443c01a7336-237d9acc6e7mr39575965ad.35.1750417044822;
        Fri, 20 Jun 2025 03:57:24 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-237d8393565sm15578765ad.46.2025.06.20.03.57.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Jun 2025 03:57:22 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id 8A8D940ED457; Fri, 20 Jun 2025 17:57:16 +0700 (WIB)
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
Subject: [PATCH 3/5] Documentation: ext4: atomic_writes: Demote last three sections
Date: Fri, 20 Jun 2025 17:56:42 +0700
Message-ID: <20250620105643.25141-5-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620105643.25141-2-bagasdotme@gmail.com>
References: <20250620105643.25141-2-bagasdotme@gmail.com>
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050; i=bagasdotme@gmail.com; h=from:subject; bh=++7Yml9JsmL3GZk3oycWGg4YVpXZATaK+KA1ZT02l/o=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBmhtvdUOC3V/59/9cBKRWDroy/rtW1i7BzyroX2eH2IY nnwXCu1o5SFQYyLQVZMkWVSIl/T6V1GIhfa1zrCzGFlAhnCwMUpABNJjWL4K+H0U8edrVrgIPMf pu6zt2TE4vM7e+TN3q46Jf3Fdda3QkaGRwo+e8LXX01X6/3OK7l5X1tqYEDx1w1OAbcK5L47a7v xAwA=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Last three sections of atomic block writes documentation are adorned as
first-level title headings, which erroneously increase toctree entries
in overview.rst. Demote them.

Fixes: 0bf1f51e34c4 ("ext4: Add atomic block write documentation")
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/filesystems/ext4/atomic_writes.rst | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/Documentation/filesystems/ext4/atomic_writes.rst b/Documentation/filesystems/ext4/atomic_writes.rst
index f65767df3620d5..aeb47ace738dfa 100644
--- a/Documentation/filesystems/ext4/atomic_writes.rst
+++ b/Documentation/filesystems/ext4/atomic_writes.rst
@@ -148,10 +148,10 @@ reserved during:
     only required to handle a split extent across leaf blocks.
 
 How to
-------
+~~~~~~
 
 Creating Filesystems with Atomic Write Support
-~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 
 First check the atomic write units supported by block device.
 See :ref:`atomic_write_bdev_support` for more details.
@@ -176,7 +176,7 @@ Where ``-b`` specifies the block size, ``-C`` specifies the cluster size in byte
 and ``-O bigalloc`` enables the bigalloc feature.
 
 Application Interface
-~~~~~~~~~~~~~~~~~~~~~
+^^^^^^^^^^^^^^^^^^^^^
 
 Applications can use the ``pwritev2()`` system call with the ``RWF_ATOMIC`` flag
 to perform atomic writes:
@@ -204,7 +204,7 @@ writes are supported.
 .. _atomic_write_bdev_support:
 
 Hardware Support
-----------------
+~~~~~~~~~~~~~~~~
 
 The underlying storage device must support atomic write operations.
 Modern NVMe and SCSI devices often provide this capability.
@@ -217,7 +217,7 @@ Nonzero values for these attributes indicate that the device supports
 atomic writes.
 
 See Also
---------
+~~~~~~~~
 
 * :doc:`bigalloc` - Documentation on the bigalloc feature
 * :doc:`allocators` - Documentation on block allocation in ext4
-- 
An old man doll... just what I always wanted! - Clara


