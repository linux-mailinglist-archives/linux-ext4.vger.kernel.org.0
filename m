Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FB445EAF72
	for <lists+linux-ext4@lfdr.de>; Mon, 26 Sep 2022 20:18:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiIZSSM (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 26 Sep 2022 14:18:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiIZSRw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 26 Sep 2022 14:17:52 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DA82474CF;
        Mon, 26 Sep 2022 11:08:47 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28QI8gQ3023305
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 26 Sep 2022 14:08:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664215724; bh=syJbDzzk3vzCCtQWfbwxW952B4bzj79gnrZUWWp8YPw=;
        h=Date:From:To:Cc:Subject;
        b=SqNN2f8qchXfC7jyMhWCK95q2iNKw2VO2DQEtSmTgEXWeTnb3ZaTWeLVo0V6z1Yp2
         NlNOGknCBU1CGIwb9hhC8cVQY82Gb3SQEQSSUzLBcfrlTaTPbRnKJuhBhqUqJGtREJ
         /nCrTpK4VEUWvecCef2NII43FWD7xQrdYUWmHicgQek+L1u68rPbL7CRo0euP+yIOa
         FTl3r598GDiBx2Y6Llc9CTe67OLdYivvJ2jNlbiVV4Z49SShzGrtaNeyQuHyYqgwB/
         mnK/3sDxqglzMOiv4DRitwO9Dl8zGHXfBG97hz37Yr8yN38d76CLxbwl6pNGOmSidm
         bplAp49AC7uHQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B4B7315C526C; Mon, 26 Sep 2022 14:08:42 -0400 (EDT)
Date:   Mon, 26 Sep 2022 14:08:42 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] ext4 last-minute fixup
Message-ID: <YzHqqg46Y34PX0Yq@mit.edu>
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

The following changes since commit 80fa46d6b9e7b1527bfd2197d75431fd9c382161:

  ext4: limit the number of retries after discarding preallocations blocks (2022-09-22 10:51:19 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/tytso/ext4.git tags/ext4_for_linus_fixes2

for you to fetch changes up to a078dff870136090b5779ca2831870a6c5539d36:

  ext4: fixup possible uninitialized variable access in ext4_mb_choose_next_group_cr1() (2022-09-26 13:21:05 -0400)

----------------------------------------------------------------
Fix an potential unitialzied variable bug; this was a fixup that I had
forgotten to apply before the last pull request for ext4.  My bad.

----------------------------------------------------------------
Jan Kara (1):
      ext4: fixup possible uninitialized variable access in ext4_mb_choose_next_group_cr1()

 fs/ext4/mballoc.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)
