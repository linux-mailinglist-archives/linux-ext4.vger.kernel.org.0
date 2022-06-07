Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C39D953F51C
	for <lists+linux-ext4@lfdr.de>; Tue,  7 Jun 2022 06:25:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236541AbiFGEZq (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 7 Jun 2022 00:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236549AbiFGEZo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 7 Jun 2022 00:25:44 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9F2B82CB
        for <linux-ext4@vger.kernel.org>; Mon,  6 Jun 2022 21:25:42 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2574PRSr005545
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 7 Jun 2022 00:25:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1654575929; bh=w+poh8gtYCNG8Es7zEuMWkXxFTCqKP5C/9m/Dib5Cns=;
        h=From:To:Cc:Subject:Date;
        b=SvIVR9ZHLXO1bomFUizAr/7wmMARopW+8vtjNjjR3G4UAyMrNGArzV0dpgH2Kps/Y
         bY3NN+xc4ApEAQTmZ5yGRRLUANa9fqGx2ytQUPLFnkeDSJQbkm3u5clzlG9KO5tEGx
         p3vdgbA7vEriCG67q1+p/kF7avBwd7nj30pDFffaywLJRTajlRCkCpavH5Fj92I1c8
         tL8XGaAubdffyARg0QbGIulmzuxrkc8Pz9BMCGQhhFEUGtnx6Ut7aKwfoZA7O9mMP1
         oB5plH1u+FW0JVAETwcQkz4fJZoeiZcu0Ycl+mBbgK5NKUNo/iwYbUXpiUAlLQVUpm
         +whjJfq1Ltfiw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id BD32215C3E1F; Tue,  7 Jun 2022 00:25:27 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Nils Bars <nils.bars@rub.de>,
        =?UTF-8?q?Moritz=20Schl=C3=B6gel?= <moritz.schloegel@rub.de>,
        Nico Schiller <nico.schiller@rub.de>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/7] Fix various bugs found via a fuzzing campaign
Date:   Tue,  7 Jun 2022 00:24:37 -0400
Message-Id: <20220607042444.1798015-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Theodore Ts'o (7):
  e2fsck: sanity check the journal inode number
  e2fsck: fix potential out-of-bounds read in inc_ea_inode_refs()
  libext2fs: add check for too-short directory blocks
  e2fsck: check for xattr value size integer wraparound
  e2fsck: avoid out-of-bounds write for very deep extent trees
  libext2fs: check for cyclic loops in the extent tree
  libext2fs: check for invalid blocks in ext2fs_punch_blocks()

 e2fsck/extents.c           | 10 +++++++++-
 e2fsck/journal.c           |  9 ++++++++-
 e2fsck/pass1.c             | 21 +++++++++++++--------
 lib/ext2fs/alloc_stats.c   |  3 ++-
 lib/ext2fs/dir_iterate.c   |  4 ++++
 lib/ext2fs/ext2_err.et.in  |  3 +++
 lib/ext2fs/ext2_ext_attr.h | 11 +++++++++++
 lib/ext2fs/extent.c        | 11 +++++++++--
 lib/ext2fs/punch.c         |  4 ++++
 9 files changed, 63 insertions(+), 13 deletions(-)

-- 
2.31.0

