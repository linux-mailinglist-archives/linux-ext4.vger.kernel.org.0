Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E247A56B0FE
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jul 2022 05:42:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiGHDU2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jul 2022 23:20:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237066AbiGHDUW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jul 2022 23:20:22 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5401660682
        for <linux-ext4@vger.kernel.org>; Thu,  7 Jul 2022 20:20:20 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-118-63.bstnma.fios.verizon.net [173.48.118.63])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2683Jx4o032642
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 7 Jul 2022 23:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1657250402; bh=HoNRSJJRLW+HY3MKf0xV/bkVNhqajsgyhG7aUBUlGXI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=V3+pWgbzAuVkLn2BJkWzPFZaqfC4nvQUeUyso2EJZL07TtUvceaCYmKPrfF3tezIw
         xTiyKUsirydQjO2Ai5xCjT+ZUpR/jjTXH56ozGQ3eA5V7yUlsexP6EYKIiBWbAysAr
         wPchY/vjII0rYZBYPYyD7To1B6O+KRcZ17mRuflZgkQ+oDvtqD4DMamOs5gKnC1ZtA
         NaBJ/rLHfeHhDrMUArRgr8uHDRewYTKcilISiC2uXQkWBc4hMw5ydEAtKhKn9HeIjo
         c5gwP7w4QRkBQxV6rtttM3rBMNXl6SJTm7QihwDQBm3Meh5rabzMA/q3hpfwgJSCyL
         T1U0JlW6dKJrw==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 8EA8515C4344; Thu,  7 Jul 2022 23:19:59 -0400 (EDT)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     yi.zhang@huawei.com, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>, yukuai3@huawei.com,
        adilger.kernel@dilger.ca, jack@suse.cz
Subject: Re: [PATCH] jbd2: fix outstanding credits assert in jbd2_journal_commit_transaction()
Date:   Thu,  7 Jul 2022 23:19:58 -0400
Message-Id: <165725003056.1812964.12369347290179882650.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220611130426.2013258-1-yi.zhang@huawei.com>
References: <20220611130426.2013258-1-yi.zhang@huawei.com>
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

On Sat, 11 Jun 2022 21:04:26 +0800, Zhang Yi wrote:
> We catch an assert problem in jbd2_journal_commit_transaction() when
> doing fsstress and request falut injection tests. The problem is
> happened in a race condition between jbd2_journal_commit_transaction()
> and ext4_end_io_end(). Firstly, ext4_writepages() writeback dirty pages
> and start reserved handle, and then the journal was aborted due to some
> previous metadata IO error, jbd2_journal_abort() start to commit current
> running transaction, the committing procedure could be raced by
> ext4_end_io_end() and lead to subtract j_reserved_credits twice from
> commit_transaction->t_outstanding_credits, finally the
> t_outstanding_credits is mistakenly smaller than t_nr_buffers and
> trigger assert.
> 
> [...]

Applied, thanks!

[1/1] jbd2: fix outstanding credits assert in jbd2_journal_commit_transaction()
      commit: f8dc286e4d942dab79d1814e0708ac91052a34fa

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
