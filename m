Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED5EC381DE5
	for <lists+linux-ext4@lfdr.de>; Sun, 16 May 2021 12:18:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhEPKTz (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 16 May 2021 06:19:55 -0400
Received: from mail.kernel.org ([198.145.29.99]:37642 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231127AbhEPKTw (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 16 May 2021 06:19:52 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6FC51611BF;
        Sun, 16 May 2021 10:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621160317;
        bh=s1c6FRQrk3Zywp//EKJchxvYSWvmD48lKnYMpgt+0B0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YJuSbr6FqahOnloOnH81PnVaoACs4c5ebe7j4HP5O4hgbj6F6Ibjy47zA+Dc15s1Y
         /2cQWVVTM7cAF1U1flKBR0yavDmV3e3kqJT+jMVxf3qolteplAZW3EnwgCZp4/HWKq
         pcW53gBM9VeuFHi3Xq+4rNxYOKJGSfswu2puWcw9kZVN6b25/RV29rThG/Ts1ucBqf
         KAA6AbVN+CUE+Oq1auf7rUJRAx3wBVRNs2bJ68Vh/X8Jn7ceoVVssXLdNhVGaPwJve
         Jz8V5B5Ie9/dtgE7JB4/xoI5HWituvALF7zgaGigNwLqWqdRpfkgFqHjWlGFwWnv9N
         veuOHEu2zLNkQ==
Received: by mail.kernel.org with local (Exim 4.94.2)
        (envelope-from <mchehab@kernel.org>)
        id 1liDr1-003o8m-I3; Sun, 16 May 2021 12:18:35 +0200
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 10/16] docs: filesystems: ext4: blockgroup.rst: replace some characters
Date:   Sun, 16 May 2021 12:18:27 +0200
Message-Id: <5457dec1f5acbd168e7eead268541cadb2d8018c.1621159997.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <cover.1621159997.git.mchehab+huawei@kernel.org>
References: <cover.1621159997.git.mchehab+huawei@kernel.org>
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

