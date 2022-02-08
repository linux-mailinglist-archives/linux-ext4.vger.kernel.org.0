Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC6C4ADE0E
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Feb 2022 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350782AbiBHQOd (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Feb 2022 11:14:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382802AbiBHQOc (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Feb 2022 11:14:32 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008CBC06157B;
        Tue,  8 Feb 2022 08:14:31 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8FC22210F9;
        Tue,  8 Feb 2022 16:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644336870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=98sUaBfT6bTkcZtNC3rY5d1ATCC+qtqJnkBQ8m+kV0c=;
        b=jBeXXhOSD4HyDxtqXAAkUonps07pSQv7erAb09XVTKnKiIyQ7m1ivJYfYw8zsGPMUV7jZl
        h/lUjJVeYKt/DunpS4AfM4XExRjNVy2YBHyUclKESGHbCmcUTWa662lemz6ybcmGW6llo6
        9VMPrcUeKE3bXGIdFze4yeBJj+tFl4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644336870;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=98sUaBfT6bTkcZtNC3rY5d1ATCC+qtqJnkBQ8m+kV0c=;
        b=kSepq6v2kc34EkoUVZrTeY2wmSwGVSXnXZqQoJ0Pun6WNv1q4AmG0QeJjWz4rwkboA2pC9
        voZDMUn/xR/jU6Bw==
Received: from quack3.suse.cz (unknown [10.100.224.230])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 7A0D4A3B87;
        Tue,  8 Feb 2022 16:14:30 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id DF4E7A05C7; Tue,  8 Feb 2022 17:14:29 +0100 (CET)
Date:   Tue, 8 Feb 2022 17:14:29 +0100
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>
Cc:     jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, Ritesh Harjani <riteshh@linux.ibm.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in jbd2_journal_wait_updates
Message-ID: <20220208161429.6oviyrpovqpcwpz5@quack3.lan>
References: <00000000000040c94205d78125af@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <00000000000040c94205d78125af@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 08-02-22 04:49:19, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=17e55852700000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=88e0a6a3dbf057cf
> dashboard link: https://syzkaller.appspot.com/bug?extid=afa2ca5171d93e44b348
> compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b03872700000
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com

So the syzbot reproducer looks bogus to me but the bug is real.
jbd2_journal_wait_updates() looks at commit_transaction after dropping
j_state_lock and sleeping which is certainly prone to use-after-free
issues.

Funnily, Ritesh's removal of t_handle_lock should "fix" the problem by
removing this dereference. So Ritesh, please just add some reference to
syzbot report and maybe a backport to stable would be warranted.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
