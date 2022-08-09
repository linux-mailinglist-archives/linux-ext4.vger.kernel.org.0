Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9743858E169
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 23:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229568AbiHIVB1 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 17:01:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiHIVAs (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 17:00:48 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44D42BB10;
        Tue,  9 Aug 2022 14:00:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF7D0B818AD;
        Tue,  9 Aug 2022 21:00:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A85C433C1;
        Tue,  9 Aug 2022 21:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660078841;
        bh=G4ciTDdVWftbBrneKFQEpoKRpzfbHXtSvwynYLfG3Sc=;
        h=Subject:From:To:Cc:Date:From;
        b=DOaxHb1iyZb5l8C0ArGEC1QMy9I5LmXhiT/XUooTtgKzieDmA/DLEXrRCt/fwNnIW
         wm3chSWf+DIaVjhcAdiLALO+eQeDc7OFt+RpNMWZLHnou5UpAgl+ARhpEvZY7p+vW4
         ndKFLkhftHBUKJX+FQuXvmLL8kGOwCaMRT5wzn5rGCIXgkF+xOI8kA7rI5zF4N9j7k
         6AFEq4Mbk9y6xLRCCtMUlRoNGIHzEWBR7Ednmp+wQLaZ+wCOW1wIyXz/508YVocxsO
         x9o+b7LHOoBM0lkE6wV0YH4oARQSW9URCbPoAUS7BweIaDZy6BCIPxRpYQs98twEXQ
         7Hk1XYXQkioPQ==
Subject: [PATCHSET v2 0/3] fstests: refactor ext4-specific code
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, guaneryu@gmail.com, zlang@redhat.com
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Date:   Tue, 09 Aug 2022 14:00:41 -0700
Message-ID: <166007884125.3276300.15348421560641051945.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi all,

This series aims to make it so that fstests can install device mapper
filters for external log devices.  Before we can do that, however, we
need to change fstests to pass the device path of the jbd2 device to
mount and mkfs.  Before we can do /that/, refactor all the ext4-specific
code out of common/rc into a separate common/ext4 file.

v2: fix _scratch_mkfs_sized for ext4, don't clutter up the outputs

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-ext4-helpers
---
 common/config |    4 +
 common/ext4   |  193 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 common/rc     |  186 ++++---------------------------------------------------
 common/xfs    |   23 +++++++
 4 files changed, 233 insertions(+), 173 deletions(-)
 create mode 100644 common/ext4

