Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 398144CC0F3
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 16:15:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232505AbiCCPPw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Mar 2022 10:15:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234357AbiCCPP1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Mar 2022 10:15:27 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8803847045
        for <linux-ext4@vger.kernel.org>; Thu,  3 Mar 2022 07:14:37 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 223FEHkY016325
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Mar 2022 10:14:17 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 13A4415C3786; Thu,  3 Mar 2022 10:14:16 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     linux-ext4@vger.kernel.org, Zhang Yi <yi.zhang@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        jack@suse.cz, yukuai3@huawei.com
Subject: Re: [PATCH v3] ext4: fix underflow in ext4_max_bitmap_size()
Date:   Thu,  3 Mar 2022 10:14:14 -0500
Message-Id: <164632037182.689479.17594587165510308394.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220301111704.2153829-1-yi.zhang@huawei.com>
References: <20220301111704.2153829-1-yi.zhang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, 1 Mar 2022 19:17:04 +0800, Zhang Yi wrote:
> when ext4 filesystem is created with 64k block size, ^extent and
> ^huge_file features. the upper_limit would underflow during the
> computations in ext4_max_bitmap_size(). The problem is the size of block
> index tree for such large block size is more than i_blocks can carry.
> So fix the computation to count with this possibility. After this fix,
> the 'res' cannot overflow loff_t on the extreme case of filesystem with
> huge_files and 64K block size, so this patch also revert commit
> 75ca6ad408f4 ("ext4: fix loff_t overflow in ext4_max_bitmap_size()").
> 
> [...]

Applied, thanks!

[1/1] ext4: fix underflow in ext4_max_bitmap_size()
      commit: 5c93e8ecd5bd3bfdee013b6da0850357eb6ca4d8

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
