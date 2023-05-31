Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4A587186A1
	for <lists+linux-ext4@lfdr.de>; Wed, 31 May 2023 17:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231194AbjEaPqA (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 May 2023 11:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229993AbjEaPp7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 May 2023 11:45:59 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E83568E
        for <linux-ext4@vger.kernel.org>; Wed, 31 May 2023 08:45:57 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34VFjriK025092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 11:45:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685547954; bh=FpUO1HuGrYYO/m7lFjVgSypydmhgS0qjV/wEA4tclMY=;
        h=Date:From:To:Cc:Subject;
        b=UOS7k3fvT82P+loJuN52Z42w3KlPinRckHgfXaM0nWtpeBIcm1BKceu39pzui6wFn
         vF7wz2QnXsjsIcKSPdeRP4tXwwgO7lt8EunwN4tW4dnLwXLUgp2yeZ3nvip/xUQp9v
         7mS7Ej+jLtxa0SjQsv133Z7FvuwA9V3fBpD0TQ3nlLs8ls8MUfnwlV0Zd+UkLjG1Dv
         tMV1ipkRhnOW3NXybcnm/xLwTjw9/3S3sQ86BLGUF2ilffIOqSyHAJFQpPGb5ufLMW
         X02iyzQ4xv5bZs1sBvJ5Jdwe9ZLx9hba6eqNYOKk4a8TxGNWPVuMDYV1CQU3OficuP
         lKXG8czP5+dyw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0227715C02EE; Wed, 31 May 2023 11:45:52 -0400 (EDT)
Date:   Wed, 31 May 2023 11:45:52 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 fixes for 6.4-rc5
Message-ID: <20230531154552.GA814122@mit.edu>
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

The following changes since commit 7877cb91f1081754a1487c144d85dc0d2e2e7fc4:

  Linux 6.4-rc4 (2023-05-28 07:49:00 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to eb1f822c76beeaa76ab8b6737ab9dc9f9798408c:

  ext4: enable the lazy init thread when remounting read/write (2023-05-30 15:33:57 -0400)

----------------------------------------------------------------
Fix two regressions in ext4 and a number of issues reported by syzbot.

----------------------------------------------------------------
Jan Kara (1):
      ext4: fix fsync for non-directories

Theodore Ts'o (5):
      ext4: add EA_INODE checking to ext4_iget()
      ext4: set lockdep subclass for the ea_inode in ext4_xattr_inode_cache_find()
      ext4: disallow ea_inodes with extended attributes
      ext4: add lockdep annotations for i_data_sem for ea_inode's
      ext4: enable the lazy init thread when remounting read/write

 fs/ext4/ext4.h  |  5 ++++-
 fs/ext4/fsync.c |  7 +++++++
 fs/ext4/inode.c | 34 +++++++++++++++++++++++++++++-----
 fs/ext4/super.c | 24 ++++++++++++------------
 fs/ext4/xattr.c | 41 ++++++++++++-----------------------------
 5 files changed, 64 insertions(+), 47 deletions(-)
