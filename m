Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7EC053A9348
	for <lists+linux-ext4@lfdr.de>; Wed, 16 Jun 2021 08:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbhFPG5Z (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 16 Jun 2021 02:57:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:34682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231446AbhFPG5Y (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 16 Jun 2021 02:57:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E578613DE;
        Wed, 16 Jun 2021 06:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623826518;
        bh=s1c6FRQrk3Zywp//EKJchxvYSWvmD48lKnYMpgt+0B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UvJ0UsIDm8NsC5fHn/n7D7kzyZmXKWDP6mnNDgv7+E656EUh8hNrwVGmlVhN1CuLo
         HaV4V4LbOnI+DHqywGEBa4bi8pIYfgZ7YYzNfAZ/QVfKNQDWelXlEg2h/hHH/zwZLQ
         601buLAPbqXa1YzaiEewaZxka/bdnQvt6Yty/PSOjn8bIEFdabT8OLDuBA3rWte92G
         /0BaQsQpchOoyyvgc2He/hpS2PTu+StoleS9Vr90+m6boWvFuI+BMosjXehWTZz5/O
         fGjYGTEC/r3bbwWfKBCl0wiZBH3nKJ1x3zBrRBu1ddXiYSxH3Uw3jZfj+164pgSSY9
         SEpDbGeL+kqWw==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1ltPSG-004lCa-Fs; Wed, 16 Jun 2021 08:55:16 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/8] docs: filesystems: ext4: blockgroup.rst: replace some characters
Date:   Wed, 16 Jun 2021 08:55:12 +0200
Message-Id: <c5c3c384c48779ca7c9dcd90183cefe20ac82928.1623826294.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1623826294.git.mchehab+huawei@kernel.org>
References: <cover.1623826294.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: Mauro Carvalho Chehab <mchehab@kernel.org>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The conversion tools used during DocBook/LaTeX/html/Markdown->ReST
conversion and some cut-and-pasted text contain some characters that
aren't easily reachable on standard keyboards and/or could cause
troubles when parsed by the documentation build system.

Replace the occurences of the following characters:

	- U+2217 ('∗'): ASTERISK OPERATOR
	  use ASCII asterisk instead of the ASTERISK OPERATOR

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/ext4/blockgroup.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext4/blockgroup.rst b/Documentation/filesystems/ext4/blockgroup.rst
index 3da156633339..d5d652addce5 100644
--- a/Documentation/filesystems/ext4/blockgroup.rst
+++ b/Documentation/filesystems/ext4/blockgroup.rst
@@ -84,7 +84,7 @@ Without the option META\_BG, for safety concerns, all block group
 descriptors copies are kept in the first block group. Given the default
 128MiB(2^27 bytes) block group size and 64-byte group descriptors, ext4
 can have at most 2^27/64 = 2^21 block groups. This limits the entire
-filesystem size to 2^21 ∗ 2^27 = 2^48bytes or 256TiB.
+filesystem size to 2^21 * 2^27 = 2^48bytes or 256TiB.
 
 The solution to this problem is to use the metablock group feature
 (META\_BG), which is already in ext3 for all 2.6 releases. With the
-- 
2.31.1

