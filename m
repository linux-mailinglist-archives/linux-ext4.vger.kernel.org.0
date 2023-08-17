Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FC3377F99D
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Aug 2023 16:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352247AbjHQOsu (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Aug 2023 10:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352367AbjHQOsk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Aug 2023 10:48:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F4A10E
        for <linux-ext4@vger.kernel.org>; Thu, 17 Aug 2023 07:48:25 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-102-95.bstnma.fios.verizon.net [173.48.102.95])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 37HEltQp012291
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 10:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1692283677; bh=HJTer2z5/DnhmsdkIuJxf9HaKJdfL78gXkI1LxMt2B0=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=S/PlR6beFqEr5kCdv01hpCgQ3usl3XGm2FgyMHuvBmpYr98UhXCvznsF/Bgmjbrbl
         YsfiNJ32d0VKTVs/k8V7H+DCegn3BESXT9Sf3FKEzJfU2WmfMCXlip4ELx8gPzYOTu
         Tn25+vPBwA9+CaKTiHoVkMSFKa3T6uM9h2abFW1yoaSvhI5sC49ONGg2wptU37fY3N
         z6lbjDeDExPQ2XdaE3h2gEbVbh49H8wYB/4M3mKhE53piWSwwZ0wr8g+FIYY6QU/fp
         yNusmqJyzwQdvtJbeoRSu6yFvr0CuzgI96TGo5RKVbt7YCRumwO1C4AZ4Yj1pch6JW
         TtWX13GEbHy3w==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 267D915C0502; Thu, 17 Aug 2023 10:47:55 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, yi.zhang@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v3 00/12] ext4,jbd2: cleanup journal load and initialization process
Date:   Thu, 17 Aug 2023 10:47:53 -0400
Message-Id: <169228359792.3428939.4459127626146442938.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
References: <20230811063610.2980059-1-yi.zhang@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Fri, 11 Aug 2023 14:35:58 +0800, Zhang Yi wrote:
> v2->v3:
>  - Fix the potential overflow on journal space check in patch 7.
>  - Rename ext4_get_journal_dev() to ext4_get_journal_blkdev() in patch 11.
> v1->v2:
>  - Fix the changelog in patch 1 and 2.
>  - Simplify the comments for local functions in patch 6.
>  - Remove the incorrect zero fast_commit blocks check in patch 7.
>  - Fix a UAF problem in patch 11.
> 
> [...]

Applied, thanks!

[01/12] jbd2: move load_superblock() dependent functions
        commit: 29a511e49f33426c8d24700db4842234a84678b2
[02/12] jbd2: move load_superblock() into journal_init_common()
        commit: c30713084ba5b6fa343129613ec349ea91f0c458
[03/12] jbd2: don't load superblock in jbd2_journal_check_used_features()
        commit: 9600f3e5cfd0360b10c271149032c77917baedc5
[04/12] jbd2: checking valid features early in journal_get_superblock()
        commit: e4adf8b837087b5bb57fff6827e10ec877a50f64
[05/12] jbd2: open code jbd2_verify_csum_type() helper
        commit: 18dad509e7bd3189ac1e7f7904faf1561a908871
[06/12] jbd2: cleanup load_superblock()
        commit: 054d9c8fef14d476f1a9c6434de86813c5990052
[07/12] jbd2: add fast_commit space check
        commit: 0dbc759ae9971568af24def1b01d5b1aa87bd546
[08/12] jbd2: cleanup journal_init_common()
        commit: 49887e47a5262cc7b87d547de57a21a072c6ea5e
[09/12] jbd2: drop useless error tag in jbd2_journal_wipe()
        commit: d9a45496019a73c240bd22912ae18a04b8496364
[10/12] jbd2: jbd2_journal_init_{dev,inode} return proper error return value
        commit: c279913275eb9fcab79fe713925dcf9b037070cf
[11/12] ext4: cleanup ext4_get_dev_journal() and ext4_get_journal()
        commit: e89c6fc9b191318238c2e211ee02be2fe943a69d
[12/12] ext4: ext4_get_{dev}_journal return proper error value
        commit: 99d6c5d892bfff3be40f83ec34d91d562125afd4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
