Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85686BDE4F
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Mar 2023 02:53:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjCQBxF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Mar 2023 21:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjCQBxC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Mar 2023 21:53:02 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A885461537
        for <linux-ext4@vger.kernel.org>; Thu, 16 Mar 2023 18:53:00 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 32H1qlF1031894
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 16 Mar 2023 21:52:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1679017969; bh=Dpb5lFuYBD+4vnKs9bysSdGWrOl3vpQOpIwx8+7CXTc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=KzLxTCpxFxW2oJcfLtcW50/CNaGIDYSG1+CVomhzMAd/NmUKtwvHFyCMJHmn17UFD
         DDQ9rMt6jrI4g6p+/WcKOXlHAFARiQ6w6Laq/ELFxjnd/NZorcamXkYCxGzJvzIp9O
         cy8ekKbNjkk/s/BVXp1ao/Io/JS2BWsUt3mOFGF5qO+XUMC0sODKzxJgwaXBc16BfC
         3lmUKITyMr/Nd0WHQ3AIT7me6OpBhp8HG2slw152+qBCm98O7dTsU4aG5iEekzLYDr
         1X+xbvK5l8ij0HUB39zaiUjOWuzIDYcHJuapLqg6lFhXnUvVTJ0/Jry3di8zTG9O20
         OOYstVMCtRIfw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 287A115C45BC; Thu, 16 Mar 2023 21:52:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Kemeng Shi <shikemeng@huaweicloud.com>, adilger.kernel@dilger.ca,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/20] Some bugfix and cleanup to mballoc
Date:   Thu, 16 Mar 2023 21:52:45 -0400
Message-Id: <167901794966.3178390.4675690414969962516.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
References: <20230303172120.3800725-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat, 4 Mar 2023 01:21:00 +0800, Kemeng Shi wrote:
> patches to make EXT4_MB_HINT_GOAL_ONLY work properly, protect pa->pa_free
> from race and so on. More details can be found in git log.
> Thanks!
> 

Applied, thanks!

[01/20] ext4: set goal start correctly in ext4_mb_normalize_request
        commit: 98860659740354352783cb55c8443e0e46e0978c
[02/20] ext4: allow to find by goal if EXT4_MB_HINT_GOAL_ONLY is set
        commit: cace8c0f41382effffa8a14cfc4666a5ae171d03
[03/20] ext4: get correct ext4_group_info in ext4_mb_prefetch_fini
        commit: 36a366185c1c733ce43e8d6d8ca43997c5b601ce
[04/20] ext4: correct calculation of s_mb_preallocated
        commit: a53b8e3f47d790cb8b520b89b59cf0b65aee7e38
[05/20] ext4: correct start of used group pa for debug in ext4_mb_use_group_pa
        commit: 043a9c31c51a26c5926fd62bdd9d7a057cc4acd1
[06/20] ext4: protect pa->pa_free in ext4_discard_allocated_blocks
        commit: 5ddfc1b03d405d2890dc75eee6e1659c0e022407
[07/20] ext4: add missed brelse in ext4_free_blocks_simple
        commit: a8735a61d23ce9f91c965041eb3ff2a8501853f2
[08/20] ext4: remove unused return value of ext4_mb_try_best_found and ext4_mb_free_metadata
        commit: 1104c3ce5375bbc1229a8e56f7ac84e23953b887
[09/20] ext4: Remove unnecessary release when memory allocation failed in ext4_mb_init_cache
        commit: d5e46843e6db39ae386dd7c728861caca3bb0e6e
[10/20] ext4: remove unnecessary e4b->bd_buddy_page check in ext4_mb_load_buddy_gfp
        commit: d53c2664698f218acd8ce8848427be4da039dee9
[11/20] ext4: remove unnecessary check in ext4_mb_new_blocks
        commit: 4e91261632b0b1d0dee4a9bd99ac70d49d35ebc5
[12/20] ext4: remove dead check in mb_buddy_mark_free
        commit: 0b6d4554bdc97d40692abf05a0f087656acfa876
[13/20] ext4: remove ac->ac_found > sbi->s_mb_min_to_scan dead check in ext4_mb_check_limits
        commit: 38121fdf014cbd631e83fe9aa20a93a57670c2fe
[14/20] ext4: use best found when complex scan of group finishs
        commit: be52c043d5d18d23605980c3485ae41de19cc99c
[15/20] ext4: remove unnecessary exit_meta_group_info tag
        commit: 1a5500baa0235477ac6eef76d75c70540522e886
[16/20] ext4: remove unnecessary count2 in ext4_free_data_in_buddy
        commit: 8df82ffee909b633f727414a4b50c2638de9c3d4
[17/20] ext4: remove unnecessary goto in ext4_mb_mark_diskspace_used
        commit: 101cbefae32efa89e717c89919a9164c4ea2b0a5
[18/20] ext4: remove repeat assignment to ac_f_ex
        commit: b9a0763df46aaa1d7c33859e24ff0ebd4fea009c
[19/20] ext4: remove comment code ext4_discard_preallocations
        commit: e0057b7ceade573f52a51a5bce75de8a1abe60b0
[20/20] ext4: simplify calculation of blkoff in ext4_mb_new_blocks_simple
        commit: 7bb392f6f9c465182aea60cc55287595bf28f866

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
