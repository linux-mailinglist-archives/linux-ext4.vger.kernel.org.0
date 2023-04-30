Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC8D86F2A29
	for <lists+linux-ext4@lfdr.de>; Sun, 30 Apr 2023 20:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230317AbjD3SIf (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 30 Apr 2023 14:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjD3SIe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 30 Apr 2023 14:08:34 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9791173F
        for <linux-ext4@vger.kernel.org>; Sun, 30 Apr 2023 11:08:32 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33UI8SCd023590
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 30 Apr 2023 14:08:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682878110; bh=DkHAcRGSEuXknCmEuszxe+3AQ1tdkv5urhPP3UW/3K8=;
        h=Date:From:To:Cc:Subject;
        b=GF7ckwdCkUY3WYxJAsCaTgFy4nEboUyaaG/xDNW6J4AK1WxqxsmIVZa5pbLPoOBsU
         HciGQrUuqtl8MzwZdyjrSwL3UmlBXD6AbWOLNN3n2CKYB/y+88as+240vDaFWs2d5C
         9awts6dAH0PXcLBRugjZX8sA2hIzyXT10UF5ye6L/86DspmpoiwF7OI05higM6eb6V
         poa92BdWdUEOC15W7F6PiBOfWEKpVJiCbAW8T6Z9omZUwub4Ol89tftdKv7Beafwsi
         jKdZG+xpje0hQB3BKbL53K+bden1FE+C8IiiYGzsWTPUGyKlZRNEiA2hWB9hzpO7Pk
         y9PMudbv4Azzg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 20E8415C02E2; Sun, 30 Apr 2023 14:08:28 -0400 (EDT)
Date:   Sun, 30 Apr 2023 14:08:28 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 bug fixes for v6.4-rc1
Message-ID: <20230430180828.GA584597@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit 519fe1bae7e20fc4e7f179d50b6102b49980e85d:

  ext4: Add a uapi header for ext4 userspace APIs (2023-04-19 23:39:42 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to d4fab7b28e2f5d74790d47a8d298da0abfb5132f:

  ext4: clean up error handling in __ext4_fill_super() (2023-04-28 12:56:40 -0400)

----------------------------------------------------------------
Some ext4 regression and bug fixes for -rc1

----------------------------------------------------------------
Nathan Chancellor (1):
      ext4: fix unused iterator variable warnings

Theodore Ts'o (3):
      ext4: fix lost error code reporting in __ext4_fill_super()
      ext4: reflect error codes from ext4_multi_mount_protect() to its callers
      ext4: clean up error handling in __ext4_fill_super()

Ye Bin (1):
      ext4: fix use-after-free read in ext4_find_extent for bigalloc + inline

Zhihao Cheng (1):
      ext4: fix i_disksize exceeding i_size problem in paritally written case

 fs/ext4/extents.c |  3 ++-
 fs/ext4/inode.c   |  3 +++
 fs/ext4/mmp.c     |  9 ++++++++-
 fs/ext4/super.c   | 77 +++++++++++++++++++++++++++++++++++++++++++----------------------------------
 4 files changed, 56 insertions(+), 36 deletions(-)
