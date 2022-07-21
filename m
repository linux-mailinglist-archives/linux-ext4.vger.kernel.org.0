Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B28B057C40B
	for <lists+linux-ext4@lfdr.de>; Thu, 21 Jul 2022 08:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229925AbiGUGC5 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 21 Jul 2022 02:02:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231706AbiGUGCz (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 21 Jul 2022 02:02:55 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C8787A537
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:02:54 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id b133so836493pfb.6
        for <linux-ext4@vger.kernel.org>; Wed, 20 Jul 2022 23:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FxGGMmlLwZZ0Pcl+pyV4f2JjegRcpKju0alMKaqYJh8=;
        b=Tq0rKwcFAGV9CXVMDI7BcImoAJDBlZye+DunBN5D5gvqqkE4A6oYO5uWVoqiOYUzZ2
         MKxTwrexg99aUsNBk/EZ1S7keEalUC4stuZBElhqm9NRB7LG2GLuBNt328TjK6lkpN8z
         atUw6xgpenwnoUwiowRsseHO9F/A/V/doFZfwSjrm5ieYzcZqHGi6MCWCunnXM/HLzmV
         pIZ6GyyCCOc6l9DfH+ts1i/xcR/87fMuDIi279ssFKHswgMGOVGSERppR2mka05hxTvu
         yy02NdSyDaLiyi3oysCybx1wPQPCPVveOP6oeboeEY8cxkSJ+B91DMagNQrt84pOZdOT
         gtJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=FxGGMmlLwZZ0Pcl+pyV4f2JjegRcpKju0alMKaqYJh8=;
        b=vl8qTU94Dt0K1Wld1ed8xH6AQOGNdRibL4FcfkQt9hkLkMtpiN7ONxMgwmnjOlMHr+
         f3NuyIVLF6E5CkWl0AUAegrZh4JWhBIuHVrNktME/abzf72J7YD7ADJfpqQOYYUfVkD7
         /GFBXefpCtaUtxWBr5UTE317NC9Di2wVgQqKMwc3NpkHyYACBOGPzIDNcCVMzfnNsGsD
         tZfWh9ywNVlFwD98BGHhC06QhJUFM3lPEOUofjpUgKPTad5JMou2ufvUKrMpdLxPLR31
         +w45mFmdmP5BxG/DoVEJ8NAMQggD9O76CCG5DtjtK/ZdY2gSYeXL7TWqVInDEkOsJ9Eu
         sB/w==
X-Gm-Message-State: AJIora8L4hQQU2MqoaYdMmBiVPHqLGu3aKgjmQH4+0SOPXcR6v1YHU8f
        JQ3KYhs+5KFfkx4QvimDeLRlm9SaOiPanQ==
X-Google-Smtp-Source: AGRyM1sWTOiqOtEz5UwCfJVQwcfV2kvaOl18fH+hnisb0RfEMp8DN92TSXua6PyeA0FKG63rZNFXFw==
X-Received: by 2002:aa7:88c3:0:b0:52a:d6ee:eb5d with SMTP id k3-20020aa788c3000000b0052ad6eeeb5dmr42517082pff.63.1658383373167;
        Wed, 20 Jul 2022 23:02:53 -0700 (PDT)
Received: from harshads.c.googlers.com.com (34.133.83.34.bc.googleusercontent.com. [34.83.133.34])
        by smtp.googlemail.com with ESMTPSA id rm10-20020a17090b3eca00b001ed27d132c1sm9105377pjb.2.2022.07.20.23.02.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:02:52 -0700 (PDT)
From:   Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     linux-ext4@vger.kernel.org
Cc:     tytso@mit.edu, Harshad Shirwadkar <harshadshirwadkar@gmail.com>
Subject: [RFC PATCH v4 0/8] Ext4 fast commit performance patch series
Date:   Thu, 21 Jul 2022 06:02:38 +0000
Message-Id: <20220721060246.1696852-1-harshadshirwadkar@gmail.com>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

This is the V4 of the patch series. This patch series supersedes the
patch "ext4: remove journal barrier during fast commit" sent in Feb
2022.

The main difference from V3 is that this patch series makes use extent
status tree in the commit path. While this results in no regressions
in the "quick" group, there is a failure in "log" group (generic/311)
when fast commit is turned on. I am in the middle of getting to the
root of it, but my experiments so far suggest that there is an
inconsistency in ext4_map_blocks()'s behavior when
"EXT4_GET_BLOCKS_CACHED_NOWAIT" flag is passed even if shrinking es
tree is disabled. Due to that failure, I have converted this patch
series to RFC. I will update the series once I fix the inconsistency
issue. But, I wanted to get the current version out any way to get
feedback on the direction this patch series going and also to
potentially catch issues that I might have missed.

Original Cover Letter
---------------------

This patch series reworks the fast commit's commit path to improve
overall performance of the commit path. Following optimizations have
been added in this series:

* Avoid having to lock the journal throughout the fast commit.
* Remove tracking of open handles per inode.

With the changes introduced in this patch series, now the commit path
for fast commits is as follows:

 [1] Lock the journal by calling jbd2_journal_lock_updates. This
     ensures that all the exsiting handles finish and no new handles
     can start.
 [2] Mark all the fast commit eligible inodes as undergoing fast commit
     by setting "EXT4_STATE_FC_COMMITTING" state.
 [3] Unlock the journal by calling jbd2_journal_unlock_updates. This allows
     starting of new handles. If new handles try to start an update on
     any of the inodes that are being committed, ext4_fc_track_inode()
     will block until those inodes have finished the fast commit.
 [4] Submit data buffers of all the committing inodes.
 [5] Wait for [4] to complete.
 [6] Commit all the directory entry updates in the fast commit space.
 [7] Commit all the changed inodes in the fast commit space and clear
     "EXT4_STATE_FC_COMMITTING" for all the inodes.
 [8] Write tail tag to ensure atomicity of commits.

(The above flow has been documented in the code as well)

I verified that the patch series introduces no regressions in "quick"
and "log" groups when "fast_commit" feature is enabled.

Harshad Shirwadkar (8):
  ext4: convert i_fc_lock to spinlock
  ext4: for committing inode, make ext4_fc_track_inode wait
  ext4: use extent status tree in fast commit path
  ext4: rework fast commit commit path
  ext4: ext4_fc_track_inode() bug fix
  ext4: drop i_fc_updates from inode fc info
  ext4: add lockdep annotation in fc commit path
  ext4: update code documentation

 fs/ext4/ext4.h           |  21 ++--
 fs/ext4/extents_status.c |   3 +-
 fs/ext4/fast_commit.c    | 248 ++++++++++++++++++++-------------------
 fs/ext4/inline.c         |   3 +
 fs/ext4/inode.c          |   5 +-
 fs/ext4/super.c          |   2 +-
 fs/jbd2/journal.c        |   2 -
 7 files changed, 149 insertions(+), 135 deletions(-)

-- 
2.37.0.170.g444d1eabd0-goog

