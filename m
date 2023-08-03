Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49F176ECD3
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Aug 2023 16:39:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236813AbjHCOjN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 3 Aug 2023 10:39:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236797AbjHCOi5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 3 Aug 2023 10:38:57 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D19001FF3
        for <linux-ext4@vger.kernel.org>; Thu,  3 Aug 2023 07:37:41 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-112-100.bstnma.fios.verizon.net [173.48.112.100])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 373Eb59h009287
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 3 Aug 2023 10:37:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1691073428; bh=XK7KMm3UiyXrs0/XRn2UB9Xi80A1mq2T3nlAar3pszY=;
        h=From:Subject:Date:Message-Id:MIME-Version:Content-Type;
        b=YN3g4rzIkFY5xEBieAiV3LMInWpGF3gonVt4WhUtyy/7yJSpydF6AGG6RKJrVfLkQ
         XUTdZrR4VadG999S8sSkKebeatlZtA0/YrZL4x9PvQQKcw1kiHem0LEo2w7Vsxyroo
         DR9pDIJDNFRyUiGkMA5Wrv0fvdK+qTlVfqyAM8M7BCOtdgnvDS10pltpakr/s8DvfB
         Obr8wSx0xGu/ZzAVVA4lFgi1kcRr+PAd4GHtKBIHgY77+Y6EwtjC7HdfM2RcNrcViY
         dFh6WffL0ZW7BZsMdrytvhYFHpWDB2JEQVjh6kRbtfRl2r+bv7UHXDXnUoMzwJLR7i
         Itid2w5TMiAzg==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B040A15C04F3; Thu,  3 Aug 2023 10:37:05 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.com>, Guoqing Cai <u202112087@hust.edu.cn>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        HUST OS Kernel Contribution 
        <hust-os-kernel-patches@googlegroups.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] fs: jbd2: fix an incorrect warn log
Date:   Thu,  3 Aug 2023 10:37:03 -0400
Message-Id: <169107341682.1086009.6038933080699741994.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230413095740.2222066-1-u202112087@hust.edu.cn>
References: <20230413095740.2222066-1-u202112087@hust.edu.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On Thu, 13 Apr 2023 17:57:39 +0800, Guoqing Cai wrote:
> In jbd2_journal_load(), when journal_reset fails, it prints an incorrect
> warn log.
> 
> Fix this by changing the goto statement to return statement.
> 
> Also, return actual error code from jbd2_journal_recover() and journal_reset().
> 
> [...]

Applied, thanks!

[1/1] fs: jbd2: fix an incorrect warn log
      commit: 1d40165047456923fa4343d519353d9440cd68df

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
