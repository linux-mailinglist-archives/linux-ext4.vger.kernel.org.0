Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8483652C937
	for <lists+linux-ext4@lfdr.de>; Thu, 19 May 2022 03:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiESB2b (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 18 May 2022 21:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiESB2a (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 18 May 2022 21:28:30 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290928CCE1
        for <linux-ext4@vger.kernel.org>; Wed, 18 May 2022 18:28:29 -0700 (PDT)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 24J1Rwgb002112
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 May 2022 21:27:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1652923680; bh=o9rbRF/0JtPBUviwsBD2ZAEPj/lfdianGZKYMDmN124=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=SHYtYlBfkEFCsNH66/+am2HOYh/gBr8qkbHeUvM+f8j4h2rOG0SIuFiMSHHqFR4z2
         Wu659DqROlUdnzgS9MPc6EYUGztDy3HwMzMtBykAen2rzErOBWXhxm/2p/upYbtSY5
         A2dlOJ0yViGnIb7K9D5pXg7AXz1haF96g5MsqoIZWLELuH6oQMmQA5cZ/e79fX0Ctl
         /svx0DoqrStIXguvdAH4uhgj0qSyluYXpe4ER681PrhF1iihsWMmsd6mSXibORGfZx
         xKdCQLv5u3a34tPN7IQoc04Qtsf00XxraOtw1EEbHjg8Jzb4YWCfJ9qg3XRDbz2e37
         3YUjPujitAwng==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 592C215C3EC0; Wed, 18 May 2022 21:27:58 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Zhang Yi <yi.zhang@huawei.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yebin10@huawei.com, jack@suse.cz,
        yukuai3@huawei.com, adilger.kernel@dilger.ca
Subject: Re: [RFC PATCH v4 0/2] ext4: standardize the journal mode of symlink external block
Date:   Wed, 18 May 2022 21:27:55 -0400
Message-Id: <165292340472.1196199.15146469152809342698.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220424140936.1898920-1-yi.zhang@huawei.com>
References: <20220424140936.1898920-1-yi.zhang@huawei.com>
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

On Sun, 24 Apr 2022 22:09:34 +0800, Zhang Yi wrote:
> Standardize the journal mode of symlink external block, from the
> essentially data=journal mode to 'standard mode' like other metadata
> blocks. (e.g. directory blocks and directory blocks...)
> 
> Thanks,
> Yi.
> 
> [...]

Applied, thanks!

[1/2] ext4: add nowait mode for ext4_getblk()
      commit: 9558cf14e8d2149a8df402b74041a99835801932
[2/2] ext4: convert symlink external data block mapping to bdev
      commit: 6493792d3299b3e33f887ef8a150099d271faf9c

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
