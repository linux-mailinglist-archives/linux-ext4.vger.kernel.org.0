Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11E2D5E90B3
	for <lists+linux-ext4@lfdr.de>; Sun, 25 Sep 2022 03:55:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229458AbiIYBzN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 24 Sep 2022 21:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbiIYBzL (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 24 Sep 2022 21:55:11 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFBBF2A252;
        Sat, 24 Sep 2022 18:55:09 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28P1t33c028813
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 24 Sep 2022 21:55:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664070904; bh=37AvudU+2RcZXPsBoQfv6QjDwsbpfDJ6c1k4PgL7c1A=;
        h=Date:From:To:Cc:Subject;
        b=aydjswFim7Peq2/k2acc9rTw08zTtTE0mTfS5lnQwcnVL8x0/zAApNNDKlv443SA1
         clNxj6rvCAXUg6cihK59AG2mpu/j8D4t3nzaP+H8Yn11rbV7GBaR7MZKFlRPGV7Xhu
         AslPYUFM/uS/DWIzrQGIDuMaKPNVBBAjvfpjrtNEQY2vZes5xPtz7VhpYaJNdUCfVn
         SIfiNziSxwCgSjBLbjFIYb/aw5Xu5nfNjUAkpHraZKdmchQK8StJjv1/33HRbE1iBV
         3vDD/kdNjQITz02//w1wDKOlRitXlTbhTxPKvTraTtax+ZIkw7O7WtYTQqX96FdQaD
         /9fNjaLeo1oqw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 37C9E15C5274; Sat, 24 Sep 2022 21:55:03 -0400 (EDT)
Date:   Sat, 24 Sep 2022 21:55:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 bug and regression fixes for v6.0
Message-ID: <Yy+090ziVE6+vBlH@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 7e18e42e4b280c85b76967a9106a13ca61c16179:

  Linux 6.0-rc4 (2022-09-04 13:10:01 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 80fa46d6b9e7b1527bfd2197d75431fd9c382161:

  ext4: limit the number of retries after discarding preallocations blocks (2022-09-22 10:51:19 -0400)

----------------------------------------------------------------
Ext4 regression and bug fixes:

- Performance regression fix from 5.18 on a Rasberry Pi

- Fix extent parsing bug which triggers a BUG_ON when a (corrupted)
  extent tree has has a non-root node when zero entries.

- Fix a livelock where in the right (wrong) circumstances a large
  number of nfsd threads can try to write to a nearly full file
  system, and retry for hours(!)

----------------------------------------------------------------
Jan Kara (5):
      ext4: make mballoc try target group first even with mb_optimize_scan
      ext4: avoid unnecessary spreading of allocations among groups
      ext4: make directory inode spreading reflect flexbg size
      ext4: use locality group preallocation for small closed files
      ext4: use buckets for cr 1 block scan instead of rbtree

Luís Henriques (1):
      ext4: fix bug in extents parsing when eh_entries == 0 and eh_depth > 0

Theodore Ts'o (1):
      ext4: limit the number of retries after discarding preallocations blocks

 fs/ext4/ext4.h    |  10 +-
 fs/ext4/extents.c |   4 +
 fs/ext4/ialloc.c  |   2 +-
 fs/ext4/mballoc.c | 318 ++++++++++++++++++++++++++++---------------------------------
 fs/ext4/mballoc.h |   1 -
 5 files changed, 154 insertions(+), 181 deletions(-)
