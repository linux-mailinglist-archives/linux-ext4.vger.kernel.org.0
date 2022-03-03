Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 274804CB3F7
	for <lists+linux-ext4@lfdr.de>; Thu,  3 Mar 2022 02:08:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbiCCAm0 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Mar 2022 19:42:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiCCAmX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Mar 2022 19:42:23 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F822443D0
        for <linux-ext4@vger.kernel.org>; Wed,  2 Mar 2022 16:41:38 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 2230fTWx019236
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Mar 2022 19:41:30 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 9F87315C33A4; Wed,  2 Mar 2022 19:41:29 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>, linux-ext4@vger.kernel.org
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com,
        Jan Kara <jack@suse.cz>
Subject: Re: [PATCH] jbd2: Fix use-after-free of transaction_t race
Date:   Wed,  2 Mar 2022 19:41:24 -0500
Message-Id: <164626805478.621144.10561349500023646398.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com>
References: <948c2fed518ae739db6a8f7f83f1d58b504f87d0.1644497105.git.ritesh.list@gmail.com>
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

On Thu, 10 Feb 2022 21:07:11 +0530, Ritesh Harjani wrote:
> jbd2_journal_wait_updates() is called with j_state_lock held. But if
> there is a commit in progress, then this transaction might get committed
> and freed via jbd2_journal_commit_transaction() ->
> jbd2_journal_free_transaction(), when we release j_state_lock.
> So check for journal->j_running_transaction everytime we release and
> acquire j_state_lock to avoid use-after-free issue.
> 
> [...]

Applied, thanks!

[1/1] jbd2: Fix use-after-free of transaction_t race
      commit: cc16eecae687912238ee6efbff71ad31e2bc414e

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
