Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DAE858863D
	for <lists+linux-ext4@lfdr.de>; Wed,  3 Aug 2022 06:21:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbiHCEVn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 3 Aug 2022 00:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233759AbiHCEVm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 3 Aug 2022 00:21:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16A9954656;
        Tue,  2 Aug 2022 21:21:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A5FAF61248;
        Wed,  3 Aug 2022 04:21:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B873C433C1;
        Wed,  3 Aug 2022 04:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659500501;
        bh=vSQ+I1xXkODt6Z1EvH/2VdXQQAfxeOxP2NCCVMd6tv8=;
        h=Subject:From:To:Cc:Date:From;
        b=r3wgEg38sz0WakcWKFORQdiUnpNKEyvZ4DRQwt8g1M4RdOU79lmvEjl8dJ4HE1fiW
         dpj+EF7aLANcP7yGieHMi5VSDahZc4/DhwmIyoCWITmtVO9VoaiaYH7GF4rqNlkdKx
         PvEermeODIF7upcxUAU75n4F0F0L0lNQ4Q1naDopglXjKerqD0+glkppr6Ql+DfgeX
         /7YTSV/3LhTf3c3t58NubBrxhF72FnYv0FwLcS2Cx/sOiLJGPsK7ZlFA591DWM95nO
         IC8w3bdCkCERsT8d1C9t5WUXfN48MkKRS0JjPzA0ZIPGLp8+tIl0GH/afppWsYNF17
         o+/cw67WD93bQ==
Subject: [PATCHSET 0/3] fstests: refactor ext4-specific code
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     djwong@kernel.org, guaneryu@gmail.com, zlang@redhat.com
Cc:     linux-xfs@vger.kernel.org, fstests@vger.kernel.org, guan@eryu.me,
        tytso@mit.edu, linux-ext4@vger.kernel.org
Date:   Tue, 02 Aug 2022 21:21:40 -0700
Message-ID: <165950050051.198922.13423077997881086438.stgit@magnolia>
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

If you're going to start using this mess, you probably ought to just
pull from my git trees, which are linked below.

This is an extraordinary way to destroy everything.  Enjoy!
Comments and questions are, as always, welcome.

--D

fstests git tree:
https://git.kernel.org/cgit/linux/kernel/git/djwong/xfstests-dev.git/log/?h=refactor-ext4-helpers
---
 common/config |    4 +
 common/ext4   |  176 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 common/rc     |  177 ++-------------------------------------------------------
 common/xfs    |   23 +++++++
 4 files changed, 208 insertions(+), 172 deletions(-)
 create mode 100644 common/ext4

