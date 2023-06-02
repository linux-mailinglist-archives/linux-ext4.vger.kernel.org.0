Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AABDE720AE0
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Jun 2023 23:12:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236351AbjFBVMJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Jun 2023 17:12:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236423AbjFBVMI (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Jun 2023 17:12:08 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924941A1
        for <linux-ext4@vger.kernel.org>; Fri,  2 Jun 2023 14:12:07 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 352LC3bJ014726
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 2 Jun 2023 17:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685740324; bh=W1COaov+ziUHiLx8l+WIK7qc1h3GVJbo2J7RNcQ9yik=;
        h=Date:From:To:Cc:Subject;
        b=bNuij2yYBt17YINKKG/Pc6f4o/ESxlsXvHvPHAHmPkM58vt4LXPmj2FGe9fkHUzzJ
         exzX0CdFTAtGulKzkeeyP0QDqLuozuPwPS7k4UFy52YCOobazEFjgZ9Cbzs3gMbV3n
         1RbP2ruvxrVEcNKyJlSW+wXqPOu/aT8R1/P7AGO8/qk1CCpKTP6F2kt28xHYgJ6sJ5
         hgNyLJNbskkg8YMn0LSJBnYiwmTMrekVGAbHpzyh5+zAqNmEzbXCJ8g3fSpVrIhiJP
         0lO2RRTKe+X98BcHhieoQxnrgzvYDFbpRQ6ff1+TB2uLJNXCSSHduXZYYlkI1T98Fy
         N/mIA/fLGtt/Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 182CE15C02EE; Fri,  2 Jun 2023 17:12:03 -0400 (EDT)
Date:   Fri, 2 Jun 2023 17:12:03 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] (one more) ext4 fix for 6.4-rc5
Message-ID: <20230602211203.GA1164822@mit.edu>
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

The following changes since commit eb1f822c76beeaa76ab8b6737ab9dc9f9798408c:

  ext4: enable the lazy init thread when remounting read/write (2023-05-30 15:33:57 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_stable

for you to fetch changes up to 3582e74599d376bc18cae123045cd295360d885b:

  Revert "ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits" (2023-06-02 14:47:29 -0400)

----------------------------------------------------------------
Fix an ext4 regression which landed during the 6.4 merge window.

----------------------------------------------------------------
Ojaswin Mujoo (1):
      Revert "ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits"

 fs/ext4/mballoc.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)
