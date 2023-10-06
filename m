Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0517BBE68
	for <lists+linux-ext4@lfdr.de>; Fri,  6 Oct 2023 20:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjJFSHC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 6 Oct 2023 14:07:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233231AbjJFSGv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 6 Oct 2023 14:06:51 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0D2DE
        for <linux-ext4@vger.kernel.org>; Fri,  6 Oct 2023 11:06:49 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-111-143.bstnma.fios.verizon.net [173.48.111.143])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 396I6Z6W008106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 6 Oct 2023 14:06:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1696615597; bh=kZHChCPqxvhqqrY27I71wBCLP9O/9nv2NFTtafE5VFA=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=ojSVmTqmD2MfpgDucvhdqIjL5Xcfdhy1/g4SzC4j2PoGlLd6IwZgI7rj2YEb9b6w5
         v1OFL/XQAJSyOAF2OaiOatlXXiunKiOg0RA6Hsztl5PxayugXieqWQZuINHBoej1KK
         MOhow07LneMoC3tz0Vnmz5361yekDZnRyWCo4WvGPSjNcdxN0PMzkY7oaEuOClwkAu
         SkJXmERoU0oRdpiUHe4dGMcaERHMj4ih8/+0DR7PhDTvNaCBUCbCNh4f/wP1n5hq+7
         aQp8dk/tJGUP3/b6+UzDQw/JqHsyDj/wlaEYDhunkhg73HO5Zaco0D4PZ9qqzgamT3
         UjrTqgfvphzzg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 285A115C0265; Fri,  6 Oct 2023 14:06:33 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v3 00/13] fixes and cleanups to ext4 resize
Date:   Fri,  6 Oct 2023 14:06:24 -0400
Message-Id: <169661554693.173366.13029736080783552496.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230826174712.4059355-1-shikemeng@huaweicloud.com>
References: <20230826174712.4059355-1-shikemeng@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Sun, 27 Aug 2023 01:46:59 +0800, Kemeng Shi wrote:
> This series contains some random cleanups and a few fixes to correct gdb
> backup copy, fix buffer_head leak and so on. More details can be found
> in respective log messages.
> I run kvm-xfstest with config "ext4/all" and "-g auto" together with
> mballoc patchset I sent before.
> 
> v2->v3:
> -Remove unused ext4_meta_bg_first_group defination in patch 11
> 
> [...]

Applied, thanks!

[01/13] ext4: correct offset of gdb backup in non meta_bg group to update_backups
        commit: 31f13421c004a420c0e9d288859c9ea9259ea0cc
[02/13] ext4: add missed brelse in update_backups
        commit: 9adac8b01f4be28acd5838aade42b8daa4f0b642
[03/13] ext4: correct return value of ext4_convert_meta_bg
        commit: 48f1551592c54f7d8e2befc72a99ff4e47f7dca0
[04/13] ext4: remove gdb backup copy for meta bg in setup_new_flex_group_blocks
        commit: 40dd7953f4d606c280074f10d23046b6812708ce
[05/13] ext4: fix typo in setup_new_flex_group_blocks
        commit: e44fc921b84ff08a9e2fb827a146fa4021d016f3
[06/13] ext4: remove redundant check of count
        commit: 7d4cd3b45af025befe3bca94f87359a6603b6e95
[07/13] ext4: remove commented code in reserve_backup_gdb
        commit: 31458077273b5f883d99bee33a7fb295f155712d
[08/13] ext4: calculate free_clusters_count in cluster unit in verify_group_input
        commit: 1fc1bd2d18bbade157f7b14270f509ebbd89881b
[09/13] ext4: remove EXT4FS_DEBUG defination in resize.c
        commit: 95b635689b58e0ebe5197bf99c82c681eabe17ee
[10/13] ext4: use saved local variable sbi instead of EXT4_SB(sb)
        commit: 70cbfd257995b3f23c2408fd893cc18b61e58b4a
[11/13] ext4: simplify the gdbblock calculation in add_new_gdb_meta_bg
        commit: 9dca529bdaad7a7242a36d04f73cb998b817ab48
[12/13] ext4: remove unnecessary check to avoid repeat update_backups for the same gdb
        commit: 350bb48b84b8f4ad4ea179dbb97f568d12626188
[13/13] ext4: remove unnecessary initialization of count2 in set_flexbg_block_bitmap
        commit: 248b45b621a77155f81129e6b572ec833edb4cf4

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
