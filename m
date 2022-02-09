Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B18CB4AF0C7
	for <lists+linux-ext4@lfdr.de>; Wed,  9 Feb 2022 13:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232562AbiBIMHV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 9 Feb 2022 07:07:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232938AbiBIMGa (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 9 Feb 2022 07:06:30 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A512C035415;
        Wed,  9 Feb 2022 03:18:35 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id B6A861F383;
        Wed,  9 Feb 2022 11:18:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1644405513; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ecb8kVlF7a5at0PDcBUbE7FnB0BbH/drXtwZ1H37VY0=;
        b=2zaMGnkRseoohcMxJ0UKiQwBH3HT9zxNZwrqmAQeK/hxQsPtZ2cPaagOQGLr84S+gKTbuq
        XSiabKkFxoT75plqyz5vp64poTlQkctQ58HlNtAhY16ou/ERlhv4NoyTrCzzhA1o5gEosq
        SHHLKc7P2gGJeNhh/MdqMHbh4WBCxmI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1644405513;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ecb8kVlF7a5at0PDcBUbE7FnB0BbH/drXtwZ1H37VY0=;
        b=/ERE/ROgj7d+GmcSRkLN49t/Q3Ze37kTBXhwsDN8kfZpxCElt1nJJp5MLM4vNlnvWYocLv
        Xboil1h+ibhmhICA==
Received: from quack3.suse.cz (unknown [10.100.200.198])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id A4CABA3B83;
        Wed,  9 Feb 2022 11:18:33 +0000 (UTC)
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id 63DD5A05C6; Wed,  9 Feb 2022 12:18:32 +0100 (CET)
Date:   Wed, 9 Feb 2022 12:18:32 +0100
From:   Jan Kara <jack@suse.cz>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com>,
        jack@suse.com, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu
Subject: Re: [syzbot] KASAN: use-after-free Read in jbd2_journal_wait_updates
Message-ID: <20220209111832.b7rrzaadwtbhj4f5@quack3.lan>
References: <00000000000040c94205d78125af@google.com>
 <20220208161429.6oviyrpovqpcwpz5@quack3.lan>
 <20220209095615.rhoizbwcn3kbazzq@riteshh-domain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220209095615.rhoizbwcn3kbazzq@riteshh-domain>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 09-02-22 15:26:47, Ritesh Harjani wrote:
> On 22/02/08 05:14PM, Jan Kara wrote:
> > On Tue 08-02-22 04:49:19, syzbot wrote:
> > > Hello,
> > >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    555f3d7be91a Merge tag '5.17-rc3-ksmbd-server-fixes' of gi..
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=17e55852700000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=88e0a6a3dbf057cf
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=afa2ca5171d93e44b348
> > > compiler:       Debian clang version 11.0.1-2, GNU ld (GNU Binutils for Debian) 2.35.2
> > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b03872700000
> > >
> > > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > > Reported-by: syzbot+afa2ca5171d93e44b348@syzkaller.appspotmail.com
> >
> > So the syzbot reproducer looks bogus to me but the bug is real.
> > jbd2_journal_wait_updates() looks at commit_transaction after dropping
> > j_state_lock and sleeping which is certainly prone to use-after-free
> > issues.
> 
> Yes, thanks for taking a look at it.
> 
> >
> > Funnily, Ritesh's removal of t_handle_lock should "fix" the problem by
> > removing this dereference. So Ritesh, please just add some reference to
> > syzbot report and maybe a backport to stable would be warranted.
> >
> 
> This actually looks like a regression because of commit [1].
> So I am thinking of sending a separate patch [2] as a fix for this (after my
> testing).

Yeah, and my fault for not catching this during review :-|. Anyway the
proposed fix looks good.

> Not sure why fstests testing didn't pick this up (given it's a common race),
> or is it because of my recent removal of CONFIG_KASAN from my testing :(
> 
> I will try a full "auto" test with CONFIG_KASAN enabled and see if we could hit
> this in fstests or not. If not then I will work towards adding a targetted test
> to capture such race.

Yeah, without KASAN this could lead to memory corruption by the spin_lock()
but in most cases it will just pass by unnoticed because the memory does
not get reused so quickly.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
