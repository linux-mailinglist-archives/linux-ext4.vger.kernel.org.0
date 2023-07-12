Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05C0751084
	for <lists+linux-ext4@lfdr.de>; Wed, 12 Jul 2023 20:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232341AbjGLSaZ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 12 Jul 2023 14:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232026AbjGLSaY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 12 Jul 2023 14:30:24 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FF701993
        for <linux-ext4@vger.kernel.org>; Wed, 12 Jul 2023 11:30:23 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-193.bstnma.fios.verizon.net [173.48.82.193])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 36CITvAE024956
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 14:29:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1689186600; bh=RqizfbRH3eAcL+WE8YxRGEnEDOWfXV6hN4snAwuYcj8=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=fTuxPT3NJ+yodQ05jGDSC18Jk0miyuBJzdVjp0ejsh0pFp4438l3KYkYd8/vH9LQn
         RM3FNlxGu8OYDmmvjYKd59wcDzDQVcqI8ZULBOWQypC6UCXm26XIw8wFnAFgik/q+R
         9HQfFWjaoVKQf+CYiXrB11g6v6hoHZYqKCWFTPMPSa+pDZxj9pZXRWzIcVyledcdWt
         NdURDCa+8O+8P8E78g3Dams0Ylw4r2rfpe7tRZG9ONPxu+1zvmlNeh9NI2OK5xVtwS
         yslZab3j2OWvixmxcL4sdBrJXNGRZVdt/G1YKhCRVtV5iYzuRV8O2OzPig3nZIxqAF
         Zd0MygxObJ3CQ==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 24B1F15C0280; Wed, 12 Jul 2023 14:29:57 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yukuai3@huawei.com,
        chengzhihao1@huawei.com
Subject: Re: [PATCH v3 0/6] jbd2: fix several checkpoint inconsistent issues
Date:   Wed, 12 Jul 2023 14:29:55 -0400
Message-Id: <168918657577.3681557.17979362698032386800.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
References: <20230606135928.434610-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Tue, 06 Jun 2023 21:59:22 +0800, Zhang Yi wrote:
> v2->v3:
>  - Init released parameter in journal_shrink_one_cp_list() instead of
>    __jbd2_journal_clean_checkpoint_list() in patch 3.
>  - Fix a comment in patch 5.
> v1->v2:
>  - Drop the last patch in [1].
>  - Merge journal_clean_one_cp_list() into journal_shrink_one_cp_list().
>  - Fix the race issues through trying to hold buffer lock and check
>    dirty state under the lock.
>  - Append a cleanup patch, remove __journal_try_to_free_buffer().
> 
> [...]

Applied, thanks!

[1/6] jbd2: recheck chechpointing non-dirty buffer
      commit: c2d6fd9d6f35079f1669f0100f05b46708c74b7f
[2/6] jbd2: remove t_checkpoint_io_list
      commit: be22255360f80d3af789daad00025171a65424a5
[3/6] jbd2: remove journal_clean_one_cp_list()
      commit: b98dba273a0e47dbfade89c9af73c5b012a4eabb
[4/6] jbd2: Fix wrongly judgement for buffer head removing while doing checkpoint
      commit: e34c8dd238d0c9368b746480f313055f5bab5040
[5/6] jbd2: fix a race when checking checkpoint buffer busy
      commit: 46f881b5b1758dc4a35fba4a643c10717d0cf427
[6/6] jbd2: remove __journal_try_to_free_buffer()
      commit: 3c55097c553c49deab60ac62c83ef17565004a97

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
