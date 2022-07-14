Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6AAE57513A
	for <lists+linux-ext4@lfdr.de>; Thu, 14 Jul 2022 16:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239660AbiGNO6R (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 14 Jul 2022 10:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239655AbiGNO6K (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 14 Jul 2022 10:58:10 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8342F5C9E0
        for <linux-ext4@vger.kernel.org>; Thu, 14 Jul 2022 07:58:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 26EEvrVn009941
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Jul 2022 10:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657810675; bh=LniF0VaQb7G8jQOtwHp006IFOhhLUxQVn8FynPI4Cic=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=C1uxIweFbEJYz9EJYTA+SLpBabzbBcLVerm6M7BgWeaonB7FPNfZXGSzBW/WdMnQV
         Te2Xn8Ab8TVeqSy142SlWiQpQnZ0waZTnHknuz3909Hb2lpAC2P/4XpIiCTKOoeMna
         s0TSNRwuQPaygJTNdEB3VOFOEh4cLjHaF0sTHS4rg5fTKHYtofGa2aELgK5TmOYkiU
         mbAhPCMjJm4B8qsyeOMk5f+mUriHOYT6+ts6JiakY96KRkeClbKtHQZULAKVKVDXY0
         pUsla2RvwiuOI37xo/fLVKqez9P2HswSDCetzu9fq1SeVCdkSgoXtTYKZ1wfkObVpC
         GIAZrU60Ii5hA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id B4FF715C003C; Thu, 14 Jul 2022 10:57:53 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     enwlinux@gmail.com, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yebin10@huawei.com
Subject: Re: [PATCH] ext4: fix extent status tree race in writeback error recovery path
Date:   Thu, 14 Jul 2022 10:57:52 -0400
Message-Id: <165781065440.2470585.17226618557732749649.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220615160530.1928801-1-enwlinux@gmail.com>
References: <20220615160530.1928801-1-enwlinux@gmail.com>
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

On Wed, 15 Jun 2022 12:05:30 -0400, Eric Whitney wrote:
> A race can occur in the unlikely event ext4 is unable to allocate a
> physical cluster for a delayed allocation in a bigalloc file system
> during writeback.  Failure to allocate a cluster forces error recovery
> that includes a call to mpage_release_unused_pages().  That function
> removes any corresponding delayed allocated blocks from the extent
> status tree.  If a new delayed write is in progress on the same cluster
> simultaneously, resulting in the addition of an new extent containing
> one or more blocks in that cluster to the extent status tree, delayed
> block accounting can be thrown off if that delayed write then encounters
> a similar cluster allocation failure during future writeback.
> 
> [...]

Applied, thanks!

[1/1] ext4: fix extent status tree race in writeback error recovery path
      commit: 8e469e57340049d4735b71660d29bd4fd3ae1607

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
