Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C119F728E61
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jun 2023 05:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237784AbjFIDPG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 23:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231580AbjFIDPC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 23:15:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A8230D1
        for <linux-ext4@vger.kernel.org>; Thu,  8 Jun 2023 20:15:01 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3593El9L024530
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 23:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686280488; bh=bi5YUImZsrQre+HL6PNbB7PVoPRHILL6mBkAHMmvEd0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=h21FJYYihyi0JmJwLYLNfQ+JEABe8wREGlFlklmw5Nj8lF7FN1JNVxY0AnDxylz/o
         lMk8ZCHI24ryObO4VnttT2Bu04WV71QEh0ub/SwM240XD3eVtxItim2K1bXMu0xxPo
         M3YcI6x5oGefJ0LwKnj3kjNaPD1W2u/dvBDozw9j2wMNuOa6gyjh6knuae6TCnp/g/
         7Zjz0foe4XcecQrxxyt46Z+11DTCL05J77PlhvYZzMEUuQvivC0uB0HAeoZw0HHtkz
         jzMsJYLUMprrCYsL1Y6kxpUNd4XiLiBkK3CZJNe0vfREtz0L+0y61ufZbTSE5FrAKC
         SBZtS6R5TmrCg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CD7C515C02DF; Thu,  8 Jun 2023 23:14:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, ojaswin@linux.ibm.com,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 00/19] Fixes, cleanups and unit test for mballoc
Date:   Thu,  8 Jun 2023 23:14:45 -0400
Message-Id: <168628045802.1458216.6038952360450376953.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
References: <20230603150327.3596033-1-shikemeng@huaweicloud.com>
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


On Sat, 03 Jun 2023 23:03:08 +0800, Kemeng Shi wrote:
> v3->v4:
> 1. Collect Reviewed-by from Ojaswin
> 2. Do improve as Ojaswin kindly suggested: Fix typo in commit,
> WARN if try to clear bit of uninitialized group and improve
> refactoring of AGGRESSIVE_CHECK code.
> 3. Fix conflic on patch 16
> 4. Improve git log in patch 16,17
> 
> [...]

Applied, thanks!

[01/19] ext4: fix wrong unit use in ext4_mb_normalize_request
        commit: cc891ea78ad04df2fedd419c23237cdc5a5dda62
[02/19] ext4: fix unit mismatch in ext4_mb_new_blocks_simple
        commit: abf6b44598cc3aa8684ff3fa5605a5a0104d69e7
[03/19] ext4: fix wrong unit use in ext4_mb_find_by_goal
        commit: ae04f8c997b0043e429e484019560417ffdb416f
[04/19] ext4: treat stripe in block unit
        commit: 7e1fb2de7d72fbb354c8ed883be34daf95cf3121
[05/19] ext4: add EXT4_MB_HINT_GOAL_ONLY test in ext4_mb_use_preallocated
        commit: 4423c2f31548dd464ab56a716eb5868d7f599417
[06/19] ext4: remove ext4_block_group and ext4_block_group_offset declaration
        commit: 61896327e1c69492c5433aa60516a9256f0781b0
[07/19] ext4: try all groups in ext4_mb_new_blocks_simple
        commit: 7de4b9d4409a267abe088cbd5b06fba849626d62
[08/19] ext4: get block from bh before pass it to ext4_free_blocks_simple in ext4_free_blocks
        commit: 9c90b9af90f233c66ce7e1a30e6477f9f8b482dc
[09/19] ext4: remove unsed parameter and unnecessary forward declaration of ext4_mb_new_blocks_simple
        commit: e8a7cea1d0a43b78c934425b8640c8764b39772a
[10/19] ext4: fix wrong unit use in ext4_mb_clear_bb
        commit: 99101b01b1b63aaee4d573f4c857738171b455bf
[11/19] ext4: fix wrong unit use in ext4_mb_new_blocks
        commit: bec857ed03e324d2b111e920f467d201c900c8ed
[12/19] ext4: factor out codes to update block bitmap and group descriptor on disk from ext4_mb_mark_bb
        commit: 80b9027c69d439d5fce276245f10c51153fa5301
[13/19] ext4: call ext4_mb_mark_group_bb in ext4_free_blocks_simple
        commit: 60ba685c5998aa8f8f0b4dd1bd8653062ee720dd
[14/19] ext4: extent ext4_mb_mark_group_bb to support allocation under journal
        commit: b989e0b98798c235a3f8b3b424590c4721c861a5
[15/19] ext4: call ext4_mb_mark_group_bb in ext4_mb_mark_diskspace_used
        commit: 2df9dcb865f335eea4edb4ce03f0e0bbb63a7d86
[16/19] ext4: call ext4_mb_mark_group_bb in ext4_mb_clear_bb
        commit: d83b42442e9d1f7a4a418c34514c7a7f3282f39a
[17/19] ext4: call ext4_mb_mark_group_bb in ext4_group_add_blocks
        commit: 797f324727ba1c07208431deec8d3ccf5ef4c3c6
[18/19] ext4: add some kunit stub for mballoc kunit test
        commit: b8eb90a9a9c2ceddd93bf5cbc16bbec69a2af0f5
[19/19] ext4: add first unit test for ext4_mb_new_blocks_simple in mballoc
        commit: d21e7bd66903c8f1f7264e63f310a463086d7bd2

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
