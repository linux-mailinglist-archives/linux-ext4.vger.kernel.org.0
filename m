Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7539D5F0340
	for <lists+linux-ext4@lfdr.de>; Fri, 30 Sep 2022 05:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiI3DVK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 29 Sep 2022 23:21:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230126AbiI3DUk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 29 Sep 2022 23:20:40 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D7148E95
        for <linux-ext4@vger.kernel.org>; Thu, 29 Sep 2022 20:20:13 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 28U3Jntc002453
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 29 Sep 2022 23:19:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1664507991; bh=AeyHeJ3wT2EC/YfdFC5ktY0BUCWVRVfIllqcVYrrQqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=XTa4Um90zNJmY0vTKiPx4Rkc3FJ7miKP6a/qegX+Cd3kiF+kXnRq3pTuS4WdHdGG9
         /WpG+bHogpafAE+tMabGnK64wdXXfteEzq2RdfqHek/ozjljO/sw6eE74bCiAXkejW
         PK9vg3i/OJvK26AZD9Ho9HagiPo3JUyvGZhzHhgfuwsrfz56BDEw/APIn2Kh0qyoa1
         Uj4UlXcM/OGjH95uDf4OoNsgzM/R72B6shnx90cdCg3pqZZdy5U01SDbLB5Br25cPC
         oay/rdhWr0BN/LOMD/NCUbI6c6UIeQSY6t2apFPw2WuborRf/w6r6rR9ipES83Aznw
         QRG80iLfv8m4Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9631115C34CC; Thu, 29 Sep 2022 23:19:47 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     lczerner@redhat.com, linux-ext4@vger.kernel.org,
        ritesh.list@gmail.com, adilger.kernel@dilger.ca, jack@suse.cz,
        yanaijie@huawei.com
Cc:     "Theodore Ts'o" <tytso@mit.edu>
Subject: Re: [PATCH v3 00/16] some refactor of __ext4_fill_super()
Date:   Thu, 29 Sep 2022 23:19:38 -0400
Message-Id: <166450797717.256913.5071420906642032429.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220916141527.1012715-1-yanaijie@huawei.com>
References: <20220916141527.1012715-1-yanaijie@huawei.com>
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

On Fri, 16 Sep 2022 22:15:11 +0800, Jason Yan wrote:
> This function is maybe the longest function I have seen in the kernel.
> It has more than one thousand lines. This makes us not easy to read and
> understand the code. So I made some refactors. The first two patches did
> some preparation to the goto labels so that we can factor out some
> functions easily.
> 
> After this refactor this function is about 500 lines shorter. I did not
> go further because I'm not sure if people like this kind of change. If
> there is any bad side effects, please let me know. If you strongly
> dislike it, I am ok to stop this refactor.
> 
> [...]

Applied, thanks!

[01/16] ext4: goto right label 'failed_mount3a'
        commit: 98f3969c5b85fd27229e37b97c112ee732f62d3a
[02/16] ext4: remove cantfind_ext4 error handler
        commit: 5cf7f37e18c56dc282ea3abf5fa0937584e91818
[03/16] ext4: factor out ext4_set_def_opts()
        commit: a8266de7242e9cdb3fe2f100b5073a164036bd24
[04/16] ext4: factor out ext4_handle_clustersize()
        commit: 47c95214fa8e716f51e4f2a28a46ad0b0f11f354
[05/16] ext4: factor out ext4_fast_commit_init()
        commit: 5d5f6bbb2c862451099e97800eb6a52a130d9dba
[06/16] ext4: factor out ext4_inode_info_init()
        commit: f3c31f5ef8aa829e26a4a66ed27878dbc4847da7
[07/16] ext4: factor out ext4_encoding_init()
        commit: b97ca755477a914613eb62a716d982f894d59c10
[08/16] ext4: factor out ext4_init_metadata_csum()
        commit: db77f42df8d9c5e5b8a5224fdcf13d526adcfbda
[09/16] ext4: factor out ext4_check_feature_compatibility()
        commit: 2549b575adfacd8dab97e161c6d889a4b13e2cd7
[10/16] ext4: factor out ext4_geometry_check()
        commit: 86081e376696a62811d31cb9ecacdd1243c3e5a0
[11/16] ext4: factor out ext4_group_desc_init() and ext4_group_desc_free()
        commit: 40eccabfecc75dac98a498e2c00792aeb0ee12f4
[12/16] ext4: factor out ext4_load_and_init_journal()
        commit: c06b378db2baf68e2621a9aca6ff2d4f080baae2
[13/16] ext4: factor out ext4_journal_data_mode_check()
        commit: 74e328480987b97c12152e465a208edbf421c8cd
[14/16] ext4: unify the ext4 super block loading operation
        commit: 6853983d170ec54fca63c5cc25435f1b5fccee7d
[15/16] ext4: remove useless local variable 'blocksize'
        commit: eadbef67b08653a90770a0402ba0b679735e4583
[16/16] ext4: move DIOREAD_NOLOCK setting to ext4_set_def_opts()
        commit: 697cc59edc6052795b10e63f2f6c27e33615d59b

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
