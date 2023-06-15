Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95745732125
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 22:55:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbjFOUzx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 16:55:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjFOUzx (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 16:55:53 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41373270B
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 13:55:51 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-128-67.bstnma.fios.verizon.net [173.48.128.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35FKtlah030832
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 16:55:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686862548; bh=jiR1pkD8mrAKioepSx8QpIxfYrUuzTHoKUgg+1DWDpM=;
        h=Date:From:To:Cc:Subject;
        b=cRDrxjc5q12FT6UM4ZpwQMMDaPiQ8cMYzL4kbRvVqA6lEVi0NAfKqN0Zr0xkhQlwV
         YGL/r2iH8gn7sihmS78AJJmNac1gx/MJhBe/tvwmMQ9l4beVXHe00zuDENXR0ndVcC
         fIBYP9cXhZ3lRuZNNxiUFNS8NJlpa9RgOUGoAurJdGaR1Bb0ohzxR2yoyaPMIn06jV
         iq87Nqf3tgPky+GnIc9QIEZAyWHBGgIv1UTGNQ9B4PsK83JrWAPwUvXjxWPcrthkiu
         fz7xjOuRdtblEyQyMON/3XFp/4/NgnbIjOasCdJjY/twNsp+8qHiLGbKx17275+a5F
         hvW/TkDJ7Id4w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id E152B15C0266; Thu, 15 Jun 2023 16:55:46 -0400 (EDT)
Date:   Thu, 15 Jun 2023 16:55:46 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Developers List <linux-kernel@vger.kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: [GIT PULL] ext4 fixes for 6.4-rc7
Message-ID: <20230615205546.GA323671@mit.edu>
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

The following changes since commit dea9d8f7643fab07bf89a1155f1f94f37d096a5e:

  ext4: only check dquot_initialize_needed() when debugging (2023-06-08 10:06:40 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to f451fd97dd2b78f286379203a47d9d295c467255:

  ext4: drop the call to ext4_error() from ext4_get_group_info() (2023-06-14 22:24:05 -0400)

----------------------------------------------------------------
Fix two regressions in ext4, one report by syzkaller[1], and reported by
multiple users (and tracked by regzbot[2]).

[1] https://syzkaller.appspot.com/bug?extid=4acc7d910e617b360859
[2] https://linux-regtracking.leemhuis.info/regzbot/regression/ZIauBR7YiV3rVAHL@glitch/

----------------------------------------------------------------
Fabio M. De Francesco (1):
      ext4: drop the call to ext4_error() from ext4_get_group_info()

Kemeng Shi (1):
      Revert "ext4: remove unnecessary check in ext4_bg_num_gdb_nometa"

 fs/ext4/balloc.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)
