Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B29E701AF5
	for <lists+linux-ext4@lfdr.de>; Sun, 14 May 2023 02:29:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjENA3f (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 13 May 2023 20:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENA3d (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 13 May 2023 20:29:33 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E572019BC
        for <linux-ext4@vger.kernel.org>; Sat, 13 May 2023 17:29:31 -0700 (PDT)
Received: from letrec.thunk.org ([172.102.11.162])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34E0TOFT001902
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 13 May 2023 20:29:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684024167; bh=qkec5ADxFO71hl1xH4tF5OmYZz7x8P8jo+KIik1Vq3s=;
        h=Date:From:To:Cc:Subject;
        b=Ja79xs+Vw/ltOlz0FkAjV+CvXlOwLW2OAtmIuRXgfNVN0/Yoila+YwhZfzvCk3q+C
         lxkr7Cv2xtu9B1yPSIEVL7S42cRTGTEOSey0h6iiO40T9Zurt+c1kFDy0hewY1csEw
         EUHm2D75+I6CylSs2Vqek9I+KP7Y0PPb3KrvLBKpO/fCMiYyS24pF9u8xIutfOv8sN
         TmKVS2f1w3clMWUI9bXl8xlfdpaeZ7Zzy97IKyEnvGtO1+U3WITV9yg9p2oL6OPXSz
         8Dvw/+WFieiLXj2KyM7oNxwWCxbl6BGgkRqQzi8S9tLZ4PVqMdO6/LMijp6ZU6mZ+u
         hzfKk7Em1cm4g==
Received: by letrec.thunk.org (Postfix, from userid 15806)
        id C36928C0479; Sat, 13 May 2023 20:28:41 -0400 (EDT)
Date:   Sat, 13 May 2023 20:28:41 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for v6.4-rc2
Message-ID: <ZGArOUgijBkG1y3G@mit.edu>
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

The following changes since commit ac9a78681b921877518763ba0e89202254349d1b:

  Linux 6.4-rc1 (2023-05-07 13:34:35 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 2a534e1d0d1591e951f9ece2fb460b2ff92edabd:

  ext4: bail out of ext4_xattr_ibody_get() fails for any reason (2023-05-13 18:05:05 -0400)

----------------------------------------------------------------
Some ext4 bug fixes (mostly to address Syzbot reports) for v6.4-rc2.

----------------------------------------------------------------
Baokun Li (1):
      ext4: check iomap type only if ext4_iomap_begin() does not fail

Jan Kara (3):
      ext4: fix lockdep warning when enabling MMP
      ext4: avoid deadlock in fs reclaim with page writeback
      ext4: fix data races when using cached status extents

Theodore Ts'o (10):
      ext4: allow ext4_get_group_info() to fail
      ext4: remove a BUG_ON in ext4_mb_release_group_pa()
      ext4: fix invalid free tracking in ext4_xattr_move_to_block()
      ext4: don't clear SB_RDONLY when remounting r/w until quota is re-enabled
      ext4: improve error handling from ext4_dirhash()
      ext4: improve error recovery code paths in __ext4_remount()
      ext4: fix deadlock when converting an inline directory in nojournal mode
      ext4: add indication of ro vs r/w mounts in the mount message
      ext4: add bounds checking in get_max_inline_xattr_value_size()
      ext4: bail out of ext4_xattr_ibody_get() fails for any reason

Tudor Ambarus (1):
      ext4: avoid a potential slab-out-of-bounds in ext4_group_desc_csum

Ye Bin (1):
      ext4: fix WARNING in mb_find_extent

 fs/ext4/balloc.c         | 43 ++++++++++++++++++++++++++++++++++++++++-
 fs/ext4/ext4.h           | 39 ++++++++++++++++++++++++-------------
 fs/ext4/extents_status.c | 30 +++++++++++++----------------
 fs/ext4/hash.c           |  6 +++++-
 fs/ext4/ialloc.c         | 12 ++++++++----
 fs/ext4/inline.c         | 17 ++++++++++++++---
 fs/ext4/inode.c          | 20 ++++++++++---------
 fs/ext4/mballoc.c        | 70 +++++++++++++++++++++++++++++++++++++++++++++++++++++++------------
 fs/ext4/migrate.c        | 11 ++++++-----
 fs/ext4/mmp.c            | 30 ++++++++++++++++++++---------
 fs/ext4/namei.c          | 53 ++++++++++++++++++++++++++++++++++----------------
 fs/ext4/super.c          | 37 +++++++++++++++++++++++------------
 fs/ext4/xattr.c          |  5 +++--
 13 files changed, 269 insertions(+), 104 deletions(-)
