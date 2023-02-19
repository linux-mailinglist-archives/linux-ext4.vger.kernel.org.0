Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E22EB69BEAC
	for <lists+linux-ext4@lfdr.de>; Sun, 19 Feb 2023 06:42:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBSFmD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 19 Feb 2023 00:42:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBSFlr (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 19 Feb 2023 00:41:47 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B25DE1422A
        for <linux-ext4@vger.kernel.org>; Sat, 18 Feb 2023 21:41:31 -0800 (PST)
Received: from cwcc.thunk.org (pool-173-48-120-46.bstnma.fios.verizon.net [173.48.120.46])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 31J5ewLe024911
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 19 Feb 2023 00:40:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1676785260; bh=0TGHAhFG0IqAM3vRu3QgNblByxOEsyPLzsBdi7vUhP0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Z2ORY/59g1STw3WBsm75G/AjvaHXulplYu9MKSpjPmN99+3fnTdERoZFhLEYelyYG
         mz4S6pSKmsq2wuZy3uM0D1a3Xj+05+faCzQtTwYIOLMcAbupH52m8wmnyG1a2q6fOu
         Q+w9VIgMRIaaZavKQh5E67gsMFq16JqY3J68Dr7EvEeM28vZzg2ypx8gIKmf2LXVXH
         GttJ5nlQC1yfTwOBw53rwANn+fSPL4P9rz1qdgDNI1VGzA00YYwLvsfKsRfUq4gFDX
         jrUD9wRme4uo9K/gYFSTzPD1UGSvaNKoGRetXxvMVbeX4Td+Q7YIh4c8+p9FXqktSx
         10sUUEE3bK0YA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id D5B4E15C35AF; Sun, 19 Feb 2023 00:40:55 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     jack@suse.com, zhanchengbin <zhanchengbin1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        liuzhiqiang26@huawei.com, yebin10@huawei.com, yi.zhang@huawei.com,
        linfeilong@huawei.com
Subject: Re: [PATCH] ext4: fix inode tree inconsistency caused by ENOMEM
Date:   Sun, 19 Feb 2023 00:40:54 -0500
Message-Id: <167678522163.2723470.4254795729575378394.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230103022812.130603-1-zhanchengbin1@huawei.com>
References: <20230103022812.130603-1-zhanchengbin1@huawei.com>
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

On Tue, 3 Jan 2023 10:28:12 +0800, zhanchengbin wrote:
> If ENOMEM fails when the extent is splitting, we need to restore the length
> of the split extent.
> In the ext4_split_extent_at function, only in ext4_ext_create_new_leaf will
> it alloc memory and change the shape of the extent tree,even if an ENOMEM
> is returned at this time, the extent tree is still self-consistent, Just
> restore the split extent lens in the function ext4_split_extent_at.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix inode tree inconsistency caused by ENOMEM
      commit: 3f5424790d4377839093b68c12b130077a4e4510

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
