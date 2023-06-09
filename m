Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76A26728E69
	for <lists+linux-ext4@lfdr.de>; Fri,  9 Jun 2023 05:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238021AbjFIDQK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 8 Jun 2023 23:16:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238191AbjFIDPb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 8 Jun 2023 23:15:31 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D6F358C
        for <linux-ext4@vger.kernel.org>; Thu,  8 Jun 2023 20:15:24 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 3593Elua024531
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 8 Jun 2023 23:14:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686280489; bh=toNjQdoCeAvnZ6qZsKcXjmAWgV2OEZsjUbkzA9vLDRc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V6Xb8aegEOkeEyBeN38ysZfp1jEhTXOT8SnHbHJEdkEOCNCz8W92E0MqReTdntL+h
         I/j8hxJr2P9INH7AujnGp2Ark0F6nVRhn/kc+X0wknN8N0WisNoNT09oLDK/GK/vTU
         m5YGoyQ4XiDBQ91DKR9qsgPL2bw3AMWNPAiskpRUXrCpSfYxwUEj4QsiUHE58BKd/g
         Oes+Nu7mZHaT+HAQMTbhyiRMIT48ixKxqhJopCkJs+OBAyaKxNX0gbn1DQPYVukJk0
         40XWHBN5ZrHweekmNPD0FscxIeqcLQRq8obODjZhENMyqkJWnxkPqLnzaPGhlwFF8a
         SPpZzn1i1KRXg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id C817B15C00B0; Thu,  8 Jun 2023 23:14:46 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Baokun Li <libaokun1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, ritesh.list@gmail.com, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, yangerkun@huawei.com, yukuai3@huawei.com
Subject: Re: [PATCH v4 00/12] ext4: fix WARNING in ext4_da_update_reserve_space
Date:   Thu,  8 Jun 2023 23:14:42 -0400
Message-Id: <168628045803.1458216.15147562703737118169.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230424033846.4732-1-libaokun1@huawei.com>
References: <20230424033846.4732-1-libaokun1@huawei.com>
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


On Mon, 24 Apr 2023 11:38:34 +0800, Baokun Li wrote:
> V1->V2:
>         Modify the patch 1 description and add the Fixes tag.
>         Add the patch 2 as suggested by Jan Kara.
> V2->V3:
>         Remove the redundant judgment of count in Patch [1].
>         Rename ext4_es_alloc_should_nofail to ext4_es_must_keep.
>         Split Patch [2].
>         Make some functions return void to simplify the code.
> V3->V4:
>         using nofail preallocation.
> 
> [...]

Applied, thanks!

[01/12] ext4: only update i_reserved_data_blocks on successful block allocation
        commit: 58f109aeac17eb37069e63a082264683bbfaf696
[02/12] ext4: add a new helper to check if es must be kept
        commit: 353c585db33932679f6f8c00414745ce09c841c2
[03/12] ext4: factor out __es_alloc_extent() and __es_free_extent()
        commit: eee0d79e61a904b103a5604496f595a435690a82
[04/12] ext4: use pre-allocated es in __es_insert_extent()
        commit: 2e7ff3411271a1dec6b8bf58b8f81286e927727c
[05/12] ext4: use pre-allocated es in __es_remove_extent()
        commit: d89b8ec674242325c2a4dcb894fdb7ee04d63312
[06/12] ext4: using nofail preallocation in ext4_es_remove_extent()
        commit: 413ebcba8610df6db5740f9bb551ea41dc353171
[07/12] ext4: using nofail preallocation in ext4_es_insert_delayed_block()
        commit: d40d2a66f5035413531f5450ed94731bb907d852
[08/12] ext4: using nofail preallocation in ext4_es_insert_extent()
        commit: bbaaebb30b6e75c1998d7ef58a2207a01a611524
[09/12] ext4: make ext4_es_remove_extent() return void
        commit: d0dc2a074d20492b46339eb7674c3527a1a9b0a2
[10/12] ext4: make ext4_es_insert_delayed_block() return void
        commit: 6b014bd8fede82619a08e5abe497daef5ef1796c
[11/12] ext4: make ext4_es_insert_extent() return void
        commit: 4ac358b63dba50218b8e46352ef319f490945a86
[12/12] ext4: make ext4_zeroout_es() return void
        commit: 703f64cb4dc0b7d30a7125bd3f28ba785f1e4351

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
