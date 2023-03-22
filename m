Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E2D6C4108
	for <lists+linux-ext4@lfdr.de>; Wed, 22 Mar 2023 04:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229833AbjCVDa4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Mar 2023 23:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229876AbjCVDay (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Mar 2023 23:30:54 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332E91ABEB
        for <linux-ext4@vger.kernel.org>; Tue, 21 Mar 2023 20:30:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4E02B819BC
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 03:30:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C0CC433EF
        for <linux-ext4@vger.kernel.org>; Wed, 22 Mar 2023 03:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679455850;
        bh=h5jtfd7slZO0OyHC9FvVshZ56LsV0R3jGENFV3aJ6uM=;
        h=From:To:Subject:Date:From;
        b=Ei80ltr6i0Lg9AaS0q1VGvt6XYsl4nmNAzWRgE16Qr1GdZh+eDM4ESpsDcq/XOUsG
         3Un3w2QrUpThV6cKGTcCVx388959MBG0f75gmemlNb0bxt1jgz1iXd4WWFDGK2oxA+
         sKxrz9I0DJAUfkoLu6RklqhB4B3C6XETuar1tXu6Q3TXkbj+fcd4aSqOlYbbx9EgKU
         ItBq1npAtD5Uop4pzM5HrsdlgXn6fl8/SYupMtWBpcwNavxQfSNJt+Tk7J1aWef9+t
         FRN86ZC07NFvXUWLduhHkoefkmPKISLKyDzbdJZ00+BY53rg9fVToxfvYM4azgyD2N
         nwK1NtwrBi5dA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     linux-ext4@vger.kernel.org
Subject: [PATCH 0/3] e2fsprogs: test cross-compiling for Android
Date:   Tue, 21 Mar 2023 20:29:42 -0700
Message-Id: <20230322032945.31779-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This series adds jobs to .github/workflows/ci.yml that cross-compile
e2fsprogs for Android.  To make that possible, it also fixes a couple
warnings and an error that show up when building e2fsprogs for Android
using the autotools-based build system.

This applies to the latest 'maint' branch.  I've tested that the updated
GitHub Actions workflow passes
(https://github.com/ebiggers/e2fsprogs/actions/runs/4486115058).

Eric Biggers (3):
  e2fsck: avoid -Wtautological-constant-out-of-range-compare warnings
  e2freefrag: don't use linux/fsmap.h when fsmap_sizeof() is missing
  ci.yml: test cross-compiling for Android

 .github/workflows/ci.yml | 33 +++++++++++++++
 configure                | 91 ++++++++++++++++++++++++++--------------
 configure.ac             |  6 +++
 e2fsck/iscan.c           |  3 +-
 e2fsck/util.c            |  3 +-
 lib/config.h.in          |  3 ++
 misc/e2freefrag.c        |  2 +-
 7 files changed, 107 insertions(+), 34 deletions(-)


base-commit: cbc6a5ae4f350bfb0dd0daa39544615a5d0a956a
-- 
2.40.0

