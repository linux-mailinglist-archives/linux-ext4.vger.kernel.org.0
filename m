Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA775E1DF
	for <lists+linux-ext4@lfdr.de>; Sun, 23 Jul 2023 14:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbjGWMbl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 23 Jul 2023 08:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229990AbjGWMbl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 23 Jul 2023 08:31:41 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B149B9
        for <linux-ext4@vger.kernel.org>; Sun, 23 Jul 2023 05:31:36 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-116-181.bstnma.fios.verizon.net [173.48.116.181])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36NCVUhi012601
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 23 Jul 2023 08:31:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1690115492; bh=KRaRdv8sZip4zgfIO8lKonrloUyAeZQVDf4MAdtMJ0k=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=i7tZgKn9e3H5upniFN+n5j2uIbILoEDpU/NqSUFa2PpimYfwMWLG8v5uKXwHOJpXJ
         EA14vwTD53aT7r7Xb9Z+IVtkl9o2xwSKdrm78wai2fms0JvsrEj3jV75e4XWHBgXlK
         sl9p5tSEkVBaKTTkDiviW9GpZ9sd8x7t2HGNtyyvJae/nJNpUHEq7johaitY9kGmAi
         TbpsIw4T6EH8HT7y+S1ikXo6o8OmyjFVcbpCVTJCc+i8V6qv6HX+ooxW/j8j5pieXj
         o9gxyK8321rkhzhDzJEyvy2ToUIRcmSPp987TjJSlrL3cH1l5Oqzx1N7wrK4+KG0x3
         UcEFROr7rX9Nw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 5E5DF15C04D7; Sun, 23 Jul 2023 08:31:30 -0400 (EDT)
Date:   Sun, 23 Jul 2023 08:31:30 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 updates for 6.5-rc3
Message-ID: <20230723123130.GA10840@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5:

  Linux 6.5-rc1 (2023-07-09 13:53:13 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus-6.5-rc3

for you to fetch changes up to 9d3de7ee192a6a253f475197fe4d2e2af10a731f:

  ext4: fix rbtree traversal bug in ext4_mb_use_preallocated (2023-07-23 08:21:14 -0400)

----------------------------------------------------------------
Bug and regression fixes for 6.5-rc3 for ext4's mballoc and jbd2's
checkpoint code.

----------------------------------------------------------------
Eric Whitney (1):
      ext4: correct inline offset when handling xattrs in inode body

Ojaswin Mujoo (2):
      ext4: fix off by one issue in ext4_mb_choose_next_group_best_avail()
      ext4: fix rbtree traversal bug in ext4_mb_use_preallocated

Zhang Yi (5):
      jbd2: recheck chechpointing non-dirty buffer
      jbd2: remove t_checkpoint_io_list
      jbd2: remove journal_clean_one_cp_list()
      jbd2: fix a race when checking checkpoint buffer busy
      jbd2: remove __journal_try_to_free_buffer()

Zhihao Cheng (1):
      jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint

 fs/ext4/mballoc.c           | 172 +++++++++++++++++++++++++++++++--------
 fs/ext4/xattr.c             |  14 ++++
 fs/jbd2/checkpoint.c        | 277 ++++++++++++++++++++++-----------------------------------------
 fs/jbd2/commit.c            |   3 +-
 fs/jbd2/transaction.c       |  40 ++-------
 include/linux/jbd2.h        |   7 +-
 include/trace/events/jbd2.h |  12 +--
 7 files changed, 262 insertions(+), 263 deletions(-)
