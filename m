Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1783567FB6D
	for <lists+linux-ext4@lfdr.de>; Sat, 28 Jan 2023 23:58:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230325AbjA1W6r (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 28 Jan 2023 17:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbjA1W6o (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 28 Jan 2023 17:58:44 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08CE62385A
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 14:58:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B40A2B80B98
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 22:58:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42F95C433D2
        for <linux-ext4@vger.kernel.org>; Sat, 28 Jan 2023 22:58:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674946721;
        bh=rFWAdyalPzpS6duMowqA2FZRYCyOGGdFd/CGvObopeA=;
        h=From:To:Subject:Date:From;
        b=IjvXSahoOge3faMFlMUocMCexV5YAtRwoH8iLacFfldubBzLuHaXCWMT8+GJaxymP
         FZODeID1EbH9Hom1+NbOfLQE9fMZngQEczSf9yAnVB/U7YC+qtYbOOuCxKZXguJSuY
         b0Ma8VVdF4UEKXp2UsyStoVEv2fFT0menJhD/ozcioCUDGjVP+eNheYzF8tq1SXSxr
         pXz9lOLYZYtkZ5Crw2iH/hgAEMsNUDWllUjMApg58wV1yKiKeJ2hOcekcUeUsgyNp4
         /HZo/2Cn0sZ89AxRUzh39o63hH+tQwvtupFweyF7NML805Q6XE0/9RERZ0/4NXcHtv
         O86GoWKhpISsg==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 0/4] e2fsprogs: a few more warning fixes
Date:   Sat, 28 Jan 2023 14:46:47 -0800
Message-Id: <20230128224651.59593-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fix the GitHub Actions workflow to really use -Werror when building the
libraries, fix a recently introduced warning in debugfs, and fix two
warnings in the Windows build.

Eric Biggers (4):
  ci.yml: ensure -Werror really gets used in all cases
  debugfs: fix a -Wformat warning in dump_journal()
  lib/ext2fs: don't warn about lack of getmntent on Windows
  lib/uuid: remove unneeded Windows UUID workaround

 .github/workflows/ci.yml | 28 ++++++++++++++--------------
 debugfs/logdump.c        |  3 ++-
 lib/ext2fs/Android.bp    |  1 -
 lib/ext2fs/ismounted.c   |  2 +-
 lib/uuid/Android.bp      |  2 --
 lib/uuid/gen_uuid.c      |  5 -----
 lib/uuid/tst_uuid.c      |  6 ------
 lib/uuid/uuid_time.c     |  6 ------
 8 files changed, 17 insertions(+), 36 deletions(-)


base-commit: 0352d353adbe6c5d6f1937e12c66e599b8657d72
-- 
2.39.1

