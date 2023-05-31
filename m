Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 816AB7189CA
	for <lists+linux-ext4@lfdr.de>; Wed, 31 May 2023 21:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbjEaTFk (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 31 May 2023 15:05:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjEaTFj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 31 May 2023 15:05:39 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C98A3
        for <linux-ext4@vger.kernel.org>; Wed, 31 May 2023 12:05:33 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-119-27.bstnma.fios.verizon.net [173.48.119.27])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 34VJ54nT004112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 31 May 2023 15:05:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1685559905; bh=5zpB2N6cg8tOIYlbrjI1WVqsVhEWOyVTXTLbcT3DTGw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=TNsQ3RreFHJKkxPt7s8MqnBcrRmNnV8mNnkuxITayfQM19cOv4Zk5seSo6l+7kCFI
         mOTyryhrFChBdbo5Rx4lnyVZhL8P9EaCDBrOkFBgGtgs1qIXeX97ToKtkm1Nn2mzb1
         GXXs2gSPzEfBiOvx4htvrVDjzdRbR4Oj+DE5vzMhd3UMzL2OtXgjLiBqXtknacLIsh
         BGTA1Q+2lsIezZwESRC3JJ8y4HZWHsfMjwy0bIow/KmEq/yNIjwNA+G0svHQbkvew2
         8WaUD8Sz/zBez6+EDYBZ8SLOhRoHu4jXisP71UOCOvmf4JoASzqWe/s9tmqGwajc8+
         9wQ6F+lL1yevg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 4F1C715C02EE; Wed, 31 May 2023 15:05:04 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH 0/3] e2fsprogs: test cross-compiling for Android
Date:   Wed, 31 May 2023 15:05:02 -0400
Message-Id: <168555980407.847504.14002335940863098331.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230322032945.31779-1-ebiggers@kernel.org>
References: <20230322032945.31779-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Tue, 21 Mar 2023 20:29:42 -0700, Eric Biggers wrote:
> This series adds jobs to .github/workflows/ci.yml that cross-compile
> e2fsprogs for Android.  To make that possible, it also fixes a couple
> warnings and an error that show up when building e2fsprogs for Android
> using the autotools-based build system.
> 
> This applies to the latest 'maint' branch.  I've tested that the updated
> GitHub Actions workflow passes
> (https://github.com/ebiggers/e2fsprogs/actions/runs/4486115058).
> 
> [...]

Applied, thanks!

Note: I needed to apply 74571d9430da ("libsupport: fix function
prototype for quota_write_inode()") to address a mingw64 compiler
warning.

[1/3] e2fsck: avoid -Wtautological-constant-out-of-range-compare warnings
      commit: c8ae60988c1240a7305dd6fe1dabda30da74ffc5
[2/3] e2freefrag: don't use linux/fsmap.h when fsmap_sizeof() is missing
      commit: 5598a968f3ee2ba5a8a6b988343905a2831f963c
[3/3] ci.yml: test cross-compiling for Android
      commit: 018ddcb29239fbd0a16a54e00613954e2d88b2b6

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
					- 
