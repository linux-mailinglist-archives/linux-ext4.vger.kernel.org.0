Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F72379A1F6
	for <lists+linux-ext4@lfdr.de>; Mon, 11 Sep 2023 05:44:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232798AbjIKDoN (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Sep 2023 23:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjIKDoM (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Sep 2023 23:44:12 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48B831A2
        for <linux-ext4@vger.kernel.org>; Sun, 10 Sep 2023 20:44:08 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-113-225.bstnma.fios.verizon.net [173.48.113.225])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 38B3hX7a032534
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Sep 2023 23:43:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1694403817; bh=sflCkPaeqjSyYsmubZgxdPUkXAkyhlmWv9CNMaF7d88=;
        h=Date:From:Subject:Message-ID:MIME-Version:Content-Type;
        b=FBkPNjuXqX5F+ZbdOQzZKp2o6BnKz5swcj0lGaKX/z622vQcrRrkqi6Rr2y5Y2HHv
         BYBKHvU9YVEDtLBTAwD0K8w4Hi5oAURlwekLv//dtw5gEH/DbXeL3vw7+E2fgkaqVl
         pYLhbERSPI5f9L1c2PXPyazMyjM76ryBva0XfsgVgr431uLL1VHbS1+FgI+T1XLqfv
         4+ewp2LCD1Fn9REKwD7Dm6MbGhY1UwZo530kd+b7bUCd0Q3acndNiF3WJIKLtQlLKO
         B0klyuDoiGLXsHYhtsp0AqE9zvSk66uqF7NtZWLEYXfKhj7evqL/NF3OuuTbNBduo9
         cSZDeQRACvs+Q==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0CA6D15C023F; Sun, 10 Sep 2023 23:43:33 -0400 (EDT)
Date:   Sun, 10 Sep 2023 23:43:33 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Linux regressions mailing list <regressions@lists.linux.dev>
Cc:     "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
        Matthew Wilcox <willy@infradead.org>,
        Zorro Lang <zlang@kernel.org>, linux-ext4@vger.kernel.org,
        fstests@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
        Jan Kara <jack@suse.cz>
Subject: Re: [fstests generic/388, 455, 475, 482 ...] Ext4 journal recovery
 test fails
Message-ID: <20230911034333.GG701295@mit.edu>
References: <87o7ie2fmm.fsf@doe.com>
 <eb707c22-b64a-4b08-9cf9-fcbeb1ddf16c@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eb707c22-b64a-4b08-9cf9-fcbeb1ddf16c@leemhuis.info>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Sep 10, 2023 at 11:26:00AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> 
> #regzbot fix: jbd2: Remove page size assumptions
> #regzbot ignore-activity
> 
> (fix can currently be found in
> https://git.infradead.org/users/willy/pagecache.git/shortlog/refs/heads/bh-fixes
> as
> https://git.infradead.org/users/willy/pagecache.git/commit/fc0a6fa4a2c7b434665f087801a06c544b16f085
> )

Per our discussion at last week's ext4 video chat, I've cherry-picked
the two fixes on the ext4 dev tree:

147d4a092e9a - jbd2: Remove page size assumptions (3 days ago)
f94cf2206b06 - buffer: Make bh_offset() work for compound pages (3 days ago)

I didn't take the reiserfs change, since this is for the ext4 git
tree, and as near as I can tell, it's more of a code cleanup rather
than an immediate fix.

Cheers,

						- Ted
