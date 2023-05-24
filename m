Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3476870EC15
	for <lists+linux-ext4@lfdr.de>; Wed, 24 May 2023 05:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239241AbjEXDuP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 May 2023 23:50:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbjEXDuE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 May 2023 23:50:04 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF71198
        for <linux-ext4@vger.kernel.org>; Tue, 23 May 2023 20:50:01 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34O3nvil023545
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 23 May 2023 23:49:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1684900198; bh=d4Y5lN7BkJNBJXjjwgnM1FCPxi88QClAbvXuwBnMXWE=;
        h=From:To:Cc:Subject:Date;
        b=kNyLT4eGUHlDOMZmy2ht6mUoFO9xFRZoISUa++JgKzofbPWHKTR5XkAi4TsHF4zOA
         c/B8/3kVbpZHLkavSTeDrMrx6p/Ad9dJV9x8jj6XkYXtaW1OSrTGKNsVH+Aibpt5ta
         FbNzVCXzO9i2RHwUYRiqKZ1CPsIjvjPpG1Jx0tqQ/M3a+d43uFKlehIvBOFc0ieTUg
         tbCP2VJBHVcfc7Am+8M4VoiZTWQnxkVTKuj1VgUpn5SRkau64yYCPgq43kVgdcRp8F
         DSzuB03vb8o+7hwyzjX+eIYBVLeha0jqsS8TSQzyWa60uHLlDrlERHezhu/uwTNjF0
         92aYbNWBC+kNg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 869C015C052B; Tue, 23 May 2023 23:49:57 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/4] ext4: clean up ea_inode handling
Date:   Tue, 23 May 2023 23:49:47 -0400
Message-Id: <20230524034951.779531-1-tytso@mit.edu>
X-Mailer: git-send-email 2.31.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This fixes a number of problems with ea_inode handling which were
pointed out by syzbot.  The first and third add some additional
checking for invalid / maliciously fuzzed file systems.  The second
and fourth patch adds some lockdep annotations to avoid some false
positive reports from lockdep.

There is still one remaining syzbot report[1] relating to ea_inodes
not handled by this patch series, and that is an apparently deadlock
which happens when a kernel thread is freeing an ea_inode racing with
another thread which is trying to find the mbcache entry (presumably
with the intent of reusing it).  The problem is apparently hard to
reproduce; it's only been hit 4 times, and there is no C reproducer;
just a syzkaller reproducer.  So we'll leave that for another day/

[1] https://syzkaller.appspot.com/bug?extid=38e6635a03c83c76297a
    INFO: task hung in ext4_evict_ea_inode


Theodore Ts'o (4):
  ext4: add EA_INODE checking to ext4_iget()
  ext4: set lockdep subclass for the ea_inode in
    ext4_xattr_inode_cache_find()
  ext4: disallow ea_inodes with extended attributes
  ext4: add lockdep annotations for i_data_sem for ea_inode's

 fs/ext4/ext4.h  |  5 ++++-
 fs/ext4/inode.c | 34 +++++++++++++++++++++++++++++-----
 fs/ext4/xattr.c | 41 ++++++++++++-----------------------------
 3 files changed, 45 insertions(+), 35 deletions(-)

-- 
2.31.0

