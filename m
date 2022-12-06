Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5446644DAA
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Dec 2022 22:02:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229761AbiLFVCW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 6 Dec 2022 16:02:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiLFVCV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 6 Dec 2022 16:02:21 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5056945A05;
        Tue,  6 Dec 2022 13:02:20 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2B6L1tP5001542
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 6 Dec 2022 16:01:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1670360518; bh=3M+ItcVZbBCEgkgbGQ2OdnE5NwSqKq3lFYW45HxjIVM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=hRo7a+LjJvj/DMl64HDnPmaQGzEfPnSA5dotHbfOrx5R1Z2OrCA0FsPMX7KqzbRfb
         WXhdummoVO1EN00MmDOTMPeSM42zOzggRWf52JutjLYrMVHZ+InS/Do1W/sr5EKcKe
         eMkIhPSmwmpaVB+y/KCUmgPIUpV7PxpITYjQNmH7IO5pWQjny/HAU9cSaYuzrxFVIO
         9ninUEEVZoxU8HozMT2h40CDvqaX+Ncj/7wfDK+2IOverCbMIwxlqYGk+D/bvRTsci
         YnRnWBWP6qdHiFHTVejK5cFFOoqcba7pDYo0xbUB9W9+LcPjSR5IQFYTmnVHKO3Q0F
         3R30lxqRMsz+Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D70A715C3AE8; Tue,  6 Dec 2022 16:01:54 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Baokun Li <libaokun1@huawei.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-kernel@vger.kernel.org,
        yi.zhang@huawei.com, ritesh.list@gmail.com,
        adilger.kernel@dilger.ca, yukuai3@huawei.com, jack@suse.cz
Subject: Re: [PATCH v3 0/4] ext4: fix two bug_on in __es_tree_search
Date:   Tue,  6 Dec 2022 16:01:50 -0500
Message-Id: <167036049592.156498.14036136511112425546.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20221026042310.3839669-1-libaokun1@huawei.com>
References: <20221026042310.3839669-1-libaokun1@huawei.com>
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

On Wed, 26 Oct 2022 12:23:06 +0800, Baokun Li wrote:
> V1->V2:
> 	In patch 2, when imode is not set to S_IFREG, the inode also needs
> 	to be initialized. Otherwise, the check can be bypassed, causing
> 	the BUG_ON. (found in the review by yangerkun)
> V2->V3:
> 	a. add EXT4_IGET_BAD flag to prevent unexpected bad inode.
> 	b. check bad quota inode in vfs_setup_quota_inode() instead of in
> 	   ext4_quota_enable() for more generic approach to this problem.
> 	c. add helper to check quota inums.
> 
> [...]

Applied, thanks!

[1/4] ext4: fix bug_on in __es_tree_search caused by bad quota inode
      commit: c7e9666f28ba9bdeeb99fb0c60a27dbb88f452f4
[2/4] ext4: add helper to check quota inums
      commit: 9c4883f1b41181f2096e2ee4e98111008b77165c
[3/4] ext4: add EXT4_IGET_BAD flag to prevent unexpected bad inode
      commit: 10f525fda2faff81f6cfce2a6bc4b50a5254d9ea
[4/4] ext4: fix bug_on in __es_tree_search caused by bad boot loader inode
      commit: db14233edaf579153d8c92bf3a0ba27ceb87eabc

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
