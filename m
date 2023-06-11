Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C34E572B017
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Jun 2023 05:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbjFKDUo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 10 Jun 2023 23:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFKDUn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 10 Jun 2023 23:20:43 -0400
Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 852CB10E
        for <linux-ext4@vger.kernel.org>; Sat, 10 Jun 2023 20:20:40 -0700 (PDT)
Received: from cwcc.thunk.org (pool-173-48-82-39.bstnma.fios.verizon.net [173.48.82.39])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 35B3KXsA008999
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 10 Jun 2023 23:20:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
        t=1686453634; bh=W96TKHAZ6ESySZtEcS194nqdxBj1Tm+gm9r1oC+bMac=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=HdnHDs/1xhavufI/6paF+oJua2+oGGo5S+ezgp/TmaDPWKrXXkcegGeknzSGXnnkM
         RhaDhrD9jOQTFQCYm28uEUdgjnjyqPcMAsQF6LlmnZ/pUkeaD5SKUgse6gYjOOQLyp
         1NJAlM9+DQ7SyM/MBxqgrNSbv99iclMuDH3nTb3EEmD6CFPhFGNACWMqr6Bdg3FRa5
         JuY9JIbKSVwmtQnW/DJ1iLCAhQiiBmCRqzWvJHzT6Yancv1ayjBu9JjKy0AYSWT03G
         gVn9ByAJ3Y93amWqFtk9itR5OWaL21vn7s1KOiSNII2A5kxJZdCF4yJwWT7vPbc4M3
         2D91DVRLrEnxA==
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 0607F15C00B0; Sat, 10 Jun 2023 23:20:33 -0400 (EDT)
Date:   Sat, 10 Jun 2023 23:20:32 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid
 context in ext4_update_super
Message-ID: <20230611032032.GC1436857@mit.edu>
References: <00000000000070575805fdc6cdb2@google.com>
 <7535327.EvYhyI6sBW@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7535327.EvYhyI6sBW@suse>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

(Dropping linux-fsdevel and linux-kernel from the cc list.)

On Sat, Jun 10, 2023 at 10:41:18PM +0200, Fabio M. De Francesco wrote:
> Well, I'm a new to filesystems. However, I'd like to test a change in 
> ext4_handle_error().
> 
> Currently I see that errors are handled according to the next snippet of code 
> from the above-mentioned function (please note that we are in atomic context):
> 
> 	if (continue_fs && journal)
> 		schedule_work(&EXT4_SB(sb)->s_error_work);
> 	else
> 		ext4_commit_super(sb);
> 
> If evaluates false, we directly call ext4_commit_super(), forgetting that, 
> AFAICS we are in atomic context.
> 
> As I said I have only little experience with filesystems, so my question is: 
> despite the overhead, can we delete the check and do the following?
>
> [ Unconditionally call schedule_work(&EXT4_SB(sb)->s_error_work) ]

That doesn't work, for the simple reason that it's possible that file
system might be configured to immediately panic on an error.  (See
later in the ext4_handle_error() function after the check for
test_opt(sb, ERRORS_PANIC).  If that happens, the workqueue will never
have a chance to run.  In that case, we have to call
ext4_commit_super().

The real answer here is that ext4_error() must never be called from an
atomic context, and a recent commit 5354b2af3406 ("ext4: allow
ext4_get_group_info() to fail") added a call to ext4_error() which is
problematic since some callers of the ext4_get_group_info() function
may be holding a spinlock.  And so the best solution is to just simply
to drop the call to ext4_error(), since it's not strictly necessary.
If there is an antagonist process which is actively corrupting the
superblock, some other code path will report the fact that the file
system is corrupted soon enough.

						- Ted

P.S.  There is an exception to what I've described above, and that's
special ext4_grp_locked_error() which is used in fs/ext4/mballoc.c.
But that's a special case which requires very careful handling, In
general, you simply must not be in atomic context when you want to
report a problem.
