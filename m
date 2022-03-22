Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 103D44E371E
	for <lists+linux-ext4@lfdr.de>; Tue, 22 Mar 2022 04:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235728AbiCVDBn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 21 Mar 2022 23:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235718AbiCVDBm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 21 Mar 2022 23:01:42 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD2FC1FE55D
        for <linux-ext4@vger.kernel.org>; Mon, 21 Mar 2022 20:00:15 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: krisman)
        with ESMTPSA id 1831D1F40876
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1647918013;
        bh=iuW/kNTAqjLM8QUg93SQL2oMf2dI2xLQL64Ee5Z2zks=;
        h=From:To:Cc:Subject:Date:From;
        b=N8Jb9a3yDkJIEFwBqDpNd3yrAh/7p3yjuD2Am3G22J17x4VL1EIZLXD54y+ARV78Z
         3hpBIE6R/0BFqBZbvnOVYtH0Eu93U6bKGZdM4bia5GQW7CYF+AGZRzg2+1NsaQDQIS
         Qm7HG2mfipzg2SVkL8WxQ8Ewvw0gXfavuK17wBjId25KkUUwMGiw6u4hN+iUms3xyz
         y+kK6oDsNj0NceqrUCbDnHjt0fJdm1DwR5lTp1XaqeB9RAJc3LPMtAkZvg//zE9bek
         3sKsNEaOpCs6nb/alSn9MlwshnI/0VCXsAutVoAilN598rbJ8/NuFMmgrW3YDHUgEm
         4WOloqYE+EB3g==
From:   Gabriel Krisman Bertazi <krisman@collabora.com>
To:     tytso@mit.edu
Cc:     ebiggers@kernel.org, jaegeuk@kernel.org,
        linux-ext4@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        kernel@collabora.com
Subject: [PATCH 0/5] Clean up the case-insenstive lookup path
Date:   Mon, 21 Mar 2022 22:59:59 -0400
Message-Id: <20220322030004.148560-1-krisman@collabora.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

The case-insensitive implementations in f2fs and ext4 have quite a bit
of duplicated code.  This series simplifies the ext4 version, with the
goal (not completed) of extracting ext4_ci_compare into a helper library
that can be used by both filesystems.

While there, I noticed we can leverage the utf8 functions to detect
encoded names that are corrupted in the filesystem. The final patch
adds an ext4 error on that scenario, to mark the filesystem as
corrupted.

This series survived passes of xfstests -g quick.

Gabriel Krisman Bertazi (5):
  ext4: Match the f2fs ci_compare implementation
  ext4: Simplify the handling of chached insensitive names
  ext4: Implement ci comparison using fscrypt_name
  ext4: Simplify hash check on ext4_match
  ext4: Log error when lookup of encoded dentry fails

 fs/ext4/ext4.h          |   2 +-
 fs/ext4/namei.c         | 110 +++++++++++++++++++++++-----------------
 include/linux/fscrypt.h |   4 ++
 3 files changed, 68 insertions(+), 48 deletions(-)

-- 
2.35.1

