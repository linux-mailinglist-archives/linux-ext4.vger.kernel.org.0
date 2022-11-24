Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE4B637189
	for <lists+linux-ext4@lfdr.de>; Thu, 24 Nov 2022 05:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbiKXEkp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 23 Nov 2022 23:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbiKXEkm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 23 Nov 2022 23:40:42 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79014C8CA1;
        Wed, 23 Nov 2022 20:40:41 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2AO4ebmC019502
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 23 Nov 2022 23:40:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1669264838; bh=yTZ1vOjbSao4b6lfEzRlJ5Kl+qDVtDO9/SMu8iMOUeU=;
        h=Date:From:To:Cc:Subject;
        b=ELiC+o+o7WaPlhHkkGgWL81mDubQse5JL2iDFdFWiNPyyt9PM77XziI6vV3zWIJlJ
         h2e/Vll8IxJqctmjou8SJuq0+6F1MM/mCndPY/Q2mC9/Sv2hDGVGNRKOfaYhCoXn04
         D2zvixmF8KZ+k4dx/lk1UYUwIyTpmh62NBZuEK4ctycUWISk/CDLx9cEh2lDeOr6pQ
         qhp/Cg5g3cgdNrTjg/Q9k2Nt3JKQ17kspHzuSGgDEWds7jCMTTsOvsF7fPDClCNPZ+
         MgHpQYUf9ymvQZMrc2RlQG6M5qy75P3UnJz2GolNlKq9CEoipwTYBD7FYKzyyENFrF
         KvUgpTdsN1oag==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 13D2215C003D; Wed, 23 Nov 2022 23:40:37 -0500 (EST)
Date:   Wed, 23 Nov 2022 23:40:37 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: GIT PULL] ext4 fixes for 6.1
Message-ID: <Y371xdJURvBvgGOi@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The following changes since commit f0c4d9fc9cc9462659728d168387191387e903cc:

  Linux 6.1-rc4 (2022-11-06 15:07:11 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable2

for you to fetch changes up to 4e3c51f4e805291b057d12f5dda5aeb50a538dc4:

  fs: do not update freeing inode i_io_list (2022-11-22 17:00:00 -0500)

----------------------------------------------------------------
Fix a regression in the lazytime code that was introduced in v6.1-rc1,
and a use-after-free that can be triggered by a maliciously corrupted
file system.

----------------------------------------------------------------
Baokun Li (1):
      ext4: fix use-after-free in ext4_ext_shift_extents

Svyatoslav Feldsherov (1):
      fs: do not update freeing inode i_io_list

 fs/ext4/extents.c | 18 +++++++++++++-----
 fs/fs-writeback.c | 30 +++++++++++++++++++-----------
 2 files changed, 32 insertions(+), 16 deletions(-)
