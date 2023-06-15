Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90D8A731C13
	for <lists+linux-ext4@lfdr.de>; Thu, 15 Jun 2023 17:00:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238879AbjFOPAg (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 15 Jun 2023 11:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244879AbjFOPA3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 15 Jun 2023 11:00:29 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC681273C
        for <linux-ext4@vger.kernel.org>; Thu, 15 Jun 2023 08:00:27 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-128-67.bstnma.fios.verizon.net [173.48.128.67])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35FExxAe026886
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 11:00:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686841202; bh=tgle4UqVECPLWQfg/ZwxNkNJR442spWrhIwFYeeKZCY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=Ikc+QaXQlvQ3x3NFjmeKou5uxhvqZkJ1q1Zn0r1YZw8av5OTMZUNM2ci7frlFJCDR
         3C7u33pbPL5N+ZwCyQiODtXUqUDg9nMxaBQBGvoVmjgZaXwnzeMaC6rOm9a04dBjs/
         x8myv+eERKdyBvtH+iDjkmarhviwCkvYZlSkxp5TPk1NQxSdxItup4bxBAXb74YVIi
         A3IaaAshV4XqgwJqnczbRSAMBiUjx4O93uHe03gNI8TpmMYdIDiCboo0Qh3QuVbQMi
         RNgEXbQvqoyhJxi+DfOXD+bZdBbloXizAocYX31GnxivcbZS4jiUWE/T/p80/+qrXE
         01F7Q1b9OxKLA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id CF96215C02DC; Thu, 15 Jun 2023 10:59:59 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     adilger.kernel@dilger.ca, jack@suse.com, tudor.ambarus@linaro.org,
        Zhihao Cheng <chengzhihao1@huawei.com>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com
Subject: Re: [PATCH v3 0/6] ext4: Fix stale buffer loading from last failed
Date:   Thu, 15 Jun 2023 10:59:53 -0400
Message-Id: <168683994076.282246.1635937592564086219.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230315013128.3911115-1-chengzhihao1@huawei.com>
References: <20230315013128.3911115-1-chengzhihao1@huawei.com>
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


On Wed, 15 Mar 2023 09:31:22 +0800, Zhihao Cheng wrote:
> Patch 1 fixes reusing stale buffer heads from last failed mounting.
> Patch 2~4 reconstructs 'j_format_version' initialization and checking
> in loading process.
> 
> v1->v2:
>   Adopt suggestions from Tudor, add fix tag and corrupt 'stable' field
>   in patch 1.
>   Reserve empty lines in patch 4.
> v2->v3:
>   Split block device checking cleanup into a new patch (2th).
>   Add 'Reviewed-by' tag in patch 3-6.
> 
> [...]

Applied, thanks!

[1/6] ext4: Fix reusing stale buffer heads from last failed mounting
      commit: ffea255f4052e6416a4b5738925337afbccd795a
[2/6] ext4: ext4_put_super: Remove redundant checking for 'sbi->s_journal_bdev'
      commit: a8f17d78525adf325c80f9dd1db469d337a5ce49
[3/6] jbd2: remove unused feature macros
      commit: 870a42846c1055c4ff9dfd492a0929c52a367d63
[4/6] jbd2: switch to check format version in superblock directly
      commit: 6014c2204f10b1199e15ab61aa30274a14999b1d
[5/6] jbd2: factor out journal initialization from journal_get_superblock()
      commit: 51bacdba23d85af2a9a145d97bfb77e6e85c98ad
[6/6] jbd2: remove j_format_version
      commit: 1f15ee267c0498016cc4aee2cdcc18e56ff42bae

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
