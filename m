Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7911B58D528
	for <lists+linux-ext4@lfdr.de>; Tue,  9 Aug 2022 10:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236261AbiHIIJS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 9 Aug 2022 04:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233351AbiHIIJR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 9 Aug 2022 04:09:17 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676F01A3B7;
        Tue,  9 Aug 2022 01:09:16 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id s5-20020a17090a13c500b001f4da9ffe5fso16879370pjf.5;
        Tue, 09 Aug 2022 01:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=qj2sAgduDJCkQNtrBGeea4FoJYpx6O+LHVUr4daOQBc=;
        b=C7KKOnTRJR6PwATaY5Z6sgQg/5cDESpIK/uEmqFq2JBFobdtPUnamMAKdtGK2RDyfl
         HmcPx/DQz+hqiP2xzLQ9UAG8hIRtu8ms4Q9Qf/ZFb4FeCeZqxx37s+QfuYHGWv5boASK
         V8RnQT0PrT+/v6VdGkhKPJmfvxn9et0QqtENA0c7fBWB3cg5Z4HAlcoAF+tUg5ctc/zC
         oKrDDP68K5lClYl1U8FqNXkwMn948Gqq6/MfaJTCRdrtBHh3dTWBP6juRLpq8ItIRpCv
         q3zTrkGLALckyckacOXPDc9BQXzgvDETGxDjQ6kpMyrPPpfz+QB2aclvGzgGzLSvD+jO
         yE3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=qj2sAgduDJCkQNtrBGeea4FoJYpx6O+LHVUr4daOQBc=;
        b=FrIhKbuz47df5166fBDLSt5kFlQT9VCPsywHtFpa03r3asyhn0rbOwJVvgfIYdInoh
         qlNm2dVuYuxL27X1sSbhVav2Fp1E/fhpH5/MN6L6iLXRnkfNcFGLxJK7/dQuuTt1JIME
         2Ek5/zT3zRoO+A2V1WemnUW0N5/Rqk7ZoMkXNLM8H+cly/GSyH3gjXkU/AraYePF03ND
         O9nY82G/TofRtXKSBFOQtrhfU6Dj/IzeAA2SZTE88QCFzrOZE90rgsfO5XhaJO3fQiPp
         3Tn0XB9cDIQr0TRN1ozq60rqBl0w0ynDPp6rgIZY5LNF12qytTXA6LN2bPryJk6Ta5NX
         JtJw==
X-Gm-Message-State: ACgBeo3grqqPSwgL0lUiYZ2wDqEc5WptcqMaDSYULHLKSFeMxLYTcHQd
        ZCoC+oqHPGoGKjglrPL0xWg=
X-Google-Smtp-Source: AA6agR7D4fCxjYn4tBU3GasZntfQu1ztZAyRId9u+Qwfdx10pVNATl9ZvJYJwRRQx01hP3HvvyTZvw==
X-Received: by 2002:a17:90b:3e8b:b0:1f5:2a52:9148 with SMTP id rj11-20020a17090b3e8b00b001f52a529148mr24482781pjb.175.1660032555869;
        Tue, 09 Aug 2022 01:09:15 -0700 (PDT)
Received: from debian.me (subs28-116-206-12-42.three.co.id. [116.206.12.42])
        by smtp.gmail.com with ESMTPSA id b6-20020a655786000000b0041d9e78de05sm2398825pgr.73.2022.08.09.01.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Aug 2022 01:09:15 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 018F0103C44; Tue,  9 Aug 2022 15:09:11 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, stable@kernel.org,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jonathan Corbet <corbet@lwn.net>,
        Wang Jianjian <wangjianjian3@huawei.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH 5.19] Documentation: ext4: fix cell spacing of table heading on blockmap table
Date:   Tue,  9 Aug 2022 15:08:28 +0700
Message-Id: <20220809080827.108363-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3797; i=bagasdotme@gmail.com; h=from:subject; bh=XxD58lc72yHrQoA56bdSYtQ12k5W8/o3WJsOVv7vBEo=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDEmfRN9/jj775nb8toW67D/sw3KKbxleX+wxr6m4TL/u29Q8 cS33jlIWBjEuBlkxRZZJiXxNp3cZiVxoX+sIM4eVCWQIAxenAEyk9Dkjw5ly/ibDQnPlTY97GQ8E9O 29a1OXseZ6Tfe21K47M4sW72T4n5I7/cmZdEsGiwrjCwx7y0VzH95l2/H8xR6zX7JugtNEuAE=
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

commit 442ec1e5bb7c46c72c41898e13a5744c84cadf51 upstream.

Commit 3103084afcf234 ("ext4, doc: remove unnecessary escaping") removes
redundant underscore escaping, however the cell spacing in heading row of
blockmap table became not aligned anymore, hence triggers malformed table
warning:

Documentation/filesystems/ext4/blockmap.rst:3: WARNING: Malformed table.

+---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| i.i_block Offset   | Where It Points                                                                                                                                                                                                              |
<snipped>...

The warning caused the table not being loaded.

Realign the heading row cell by adding missing space at the first cell
to fix the warning.

Fixes: 3103084afcf234 ("ext4, doc: remove unnecessary escaping")
Cc: stable@kernel.org
Cc: Andreas Dilger <adilger.kernel@dilger.ca>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Wang Jianjian <wangjianjian3@huawei.com>
Cc: linux-ext4@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
Link: https://lore.kernel.org/r/20220619072938.7334-1-bagasdotme@gmail.com
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---

 Seems like this patch is merged to Linus's tree as merge window
 material for 6.0, but it should have been -rc fix material for 5.19
 cycle. Now that the version have been stabilized (and now on 6.0 merge
 window), it should be logical to submit this backport for 5.19 tree.

 Documentation/filesystems/ext4/blockmap.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/filesystems/ext4/blockmap.rst b/Documentation/filesystems/ext4/blockmap.rst
index 2bd990402a5c49..cc596541ce7921 100644
--- a/Documentation/filesystems/ext4/blockmap.rst
+++ b/Documentation/filesystems/ext4/blockmap.rst
@@ -1,7 +1,7 @@
 .. SPDX-License-Identifier: GPL-2.0
 
 +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-| i.i_block Offset   | Where It Points                                                                                                                                                                                                              |
+| i.i_block Offset    | Where It Points                                                                                                                                                                                                              |
 +=====================+==============================================================================================================================================================================================================================+
 | 0 to 11             | Direct map to file blocks 0 to 11.                                                                                                                                                                                           |
 +---------------------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
-- 
An old man doll... just what I always wanted! - Clara

