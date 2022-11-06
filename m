Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D582561E084
	for <lists+linux-ext4@lfdr.de>; Sun,  6 Nov 2022 07:18:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229571AbiKFGSS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 6 Nov 2022 01:18:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiKFGSR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 6 Nov 2022 01:18:17 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BD0DE98;
        Sat,  5 Nov 2022 23:18:16 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2A66IBAa000632
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 6 Nov 2022 01:18:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1667715492; bh=sq9x0ixmES8dQm2ed+yrpLJsiG3/CLeyCVNL98AuebQ=;
        h=Date:From:To:Cc:Subject;
        b=KeDTB2YJHjfFeEZiKxAPZdbHvf9uj5Yg+OxXguoK2/vq/wKvJz4Wzf2F4LuQZ9j/B
         xtKwSxqimNG53Y5ySbiBgkV2iRYWuo7GhnpijlAtkTUhJBjO0JJEo+9z9n1Zezmr7I
         eAUFns798OaK6ISeQYvVbqp/T4Rx05UbAwPxW2o069RlyFy8b1/2KA9XkPzpHcHn4K
         i/CuhaLQqPRRaVfJLcYoXZ4S+XGrttzQPTo0+yqPClHf5Q54kOR8LcM8pv95U0xNtU
         wIBs0fj2rRpivgkJQVWnS2w2c3pmQdLtpLHOB5CTjrcXUiC+aAUd1QLCMxZc/AaSuq
         C4ag0xDMbevnQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 68D3715C45B9; Sun,  6 Nov 2022 01:18:11 -0500 (EST)
Date:   Sun, 6 Nov 2022 01:18:11 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: [GIT PULL] ext4 bug fixes for 6.1
Message-ID: <Y2dRoyP5tKIZj/b4@mit.edu>
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

The following changes since commit 4c86114194e644b6da9107d75910635c9e87179e:

  Merge tag 'iomap-6.1-merge-1' of git://git.kernel.org/pub/scm/fs/xfs/xfs-linux (2022-10-06 17:57:50 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 0d043351e5baf3857f915367deba2a518b6a0809:

  ext4: fix fortify warning in fs/ext4/fast_commit.c:1551 (2022-11-06 01:07:59 -0400)

----------------------------------------------------------------
Fix a number of bug fixes, including some regressions, the most
serious of which was one which would cause online resizes to fail with
file systems with metadata checksums enabled.  Also fix a warning
caused by the newly added fortify string checker, plus some bugs that
were found using fuzzed file systems.

----------------------------------------------------------------
Jason Yan (1):
      ext4: fix wrong return err in ext4_load_and_init_journal()

Luís Henriques (1):
      ext4: fix BUG_ON() when directory entry has invalid rec_len

Theodore Ts'o (2):
      ext4: update the backup superblock's at the end of the online resize
      ext4: fix fortify warning in fs/ext4/fast_commit.c:1551

Ye Bin (1):
      ext4: fix warning in 'ext4_da_release_space'

 fs/ext4/fast_commit.c |  5 +++--
 fs/ext4/ioctl.c       |  3 +--
 fs/ext4/migrate.c     |  3 ++-
 fs/ext4/namei.c       | 10 +++++++++-
 fs/ext4/resize.c      |  5 +++++
 fs/ext4/super.c       |  2 +-
 6 files changed, 21 insertions(+), 7 deletions(-)
