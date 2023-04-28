Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A06986F10C0
	for <lists+linux-ext4@lfdr.de>; Fri, 28 Apr 2023 05:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345076AbjD1DQn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 27 Apr 2023 23:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345065AbjD1DQf (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 27 Apr 2023 23:16:35 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F78D3584
        for <linux-ext4@vger.kernel.org>; Thu, 27 Apr 2023 20:16:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 33S3GFdr012366
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 27 Apr 2023 23:16:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1682651780; bh=CiDfb1KbcVMW3QMUCm+CO5W3wvstfq8sN26307vZdlc=;
        h=From:To:Cc:Subject:Date;
        b=J0AqLbgbx21FkSJG/etOfrkS6lQnqg2/oO2M8sZO3XeDcJXBYmcIG4b77/Lkze4uG
         GC8vJEAI9jUMu8HhR8rY3WDmtU9AkqSKpvMr/luX26vjlCK9e8lRnqZAFm4HcmnGai
         379xihGdzN71diUibzPphfqPoYXifPCF0QnqhGFM32EklhZRwFpkyBBHkcuVNIA28c
         mbL/w6QHZIn1VOt9uPRfyCwkWwGqUHpRbm60BW7zwihl8uzcKty+nV2ol4f4qLRjOC
         27olgXbgBsm0JZoOMLvIkd8DrRoRYJIchL4Jz/4y8gRHGUgzgPN75Xv1IH9B+VMM9I
         Mka/2di8ZQ0iQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A97EE15C3AC2; Thu, 27 Apr 2023 23:16:15 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Jason Yan <yanaijie@huawei.com>,
        "Theodore Ts'o" <tytso@mit.edu>
Subject: [PATCH 0/3] ext4: clean up error handling
Date:   Thu, 27 Apr 2023 23:15:59 -0400
Message-Id: <20230428031602.242297-1-tytso@mit.edu>
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

The recent code cleanup of __ext4_fill_super() resulted in a bug
reported by Syzkaller.  When I investigated this issue, I found that
the bug was caused by a fragile and partially redundant way error
codes were set to be returned by the __ext4_fill_super() function.

The first patch fixes the bug found by Syzkaller, and the second and
third patch cleans up the error handling in __ext4_fill_super() and
__ext4_multi_mount_protect().

Andreas, please take a look at the second patch, as it changes the
error codes returned in various cases when the MMP feature prevents
the file system from being mounted and other failure cases.  For
example, when another system has the file system mounted, mount will
now return EBUSY instead EINVAL.  In other cases, if a memory
allocation fails, mount will now return ENOMEM instead of EINVAL.  I
think this is an improvement, but there might be some userspace code
that might get confused by this.  Since Lustre users tend to be most
common users of the MMP feature, I'd appreciate your review of this
patch.


Theodore Ts'o (3):
  ext4: fix lost error code reporting in __ext4_fill_super()
  ext4: reflect error codes from ext4_multi_mount_protect() to its
    callers
  ext4: clean up error handling in __ext4_fill_super()

 fs/ext4/mmp.c   |  9 ++++++-
 fs/ext4/super.c | 68 +++++++++++++++++++++++++++++--------------------
 2 files changed, 48 insertions(+), 29 deletions(-)

-- 
2.31.0

