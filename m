Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FD9F4D7278
	for <lists+linux-ext4@lfdr.de>; Sun, 13 Mar 2022 05:46:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbiCMEq6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 12 Mar 2022 23:46:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCMEq5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 12 Mar 2022 23:46:57 -0500
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02ED7606F0
        for <linux-ext4@vger.kernel.org>; Sat, 12 Mar 2022 20:45:50 -0800 (PST)
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 22D4jkHg009260
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 12 Mar 2022 23:45:46 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 044C515C3E99; Sat, 12 Mar 2022 23:45:46 -0500 (EST)
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Warn when dirtying page without buffers in data=journal mode
Date:   Sat, 12 Mar 2022 23:45:39 -0500
Message-Id: <164714672856.1260831.8397472020365050278.b4-ty@mit.edu>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20220310101832.5645-1-jack@suse.cz>
References: <20220310101832.5645-1-jack@suse.cz>
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

On Thu, 10 Mar 2022 11:18:32 +0100, Jan Kara wrote:
> Recently I've got a report of BUG_ON trigerring during transaction
> commit in ext4_journalled_writepage_callback() because we've spotted a
> dirty page without buffers. Add WARN_ON_ONCE to
> ext4_journalled_set_page_dirty() to catch the problematic condition
> earlier where we have better chance of understanding which code path is
> creating dirty data without preparing the page properly. Also update the
> comment with current information when we are at it.
> 
> [...]

Applied, thanks!

[1/1] ext4: Warn when dirtying page without buffers in data=journal mode
      commit: 2bb8dd401a4f96973d6a9de4218d7f01fbd497ee

Best regards,
-- 
Theodore Ts'o <tytso@mit.edu>
