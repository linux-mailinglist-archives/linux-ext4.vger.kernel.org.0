Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C0DB835C533
	for <lists+linux-ext4@lfdr.de>; Mon, 12 Apr 2021 13:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240350AbhDLLcS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 12 Apr 2021 07:32:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:49214 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237792AbhDLLcR (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 12 Apr 2021 07:32:17 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 1022BAE20;
        Mon, 12 Apr 2021 11:31:59 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id C89371F2B62; Mon, 12 Apr 2021 13:31:58 +0200 (CEST)
Date:   Mon, 12 Apr 2021 13:31:58 +0200
From:   Jan Kara <jack@suse.cz>
To:     Hao Sun <sunhao.th@gmail.com>
Cc:     Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
        jack@suse.com, linux-ext4@vger.kernel.org, tytso@mit.edu
Subject: Re: More KCSAN data-race Reports
Message-ID: <20210412113158.GA4679@quack2.suse.cz>
References: <CACkBjsYrsp5LekZciBjSbnJLHvBwQF3YM5TiKEMPeUX-D_DaSA@mail.gmail.com>
 <20210412090212.GA31090@quack2.suse.cz>
 <CACkBjsYuWeJNYTGUhBVszgiUVOrMdEZ=qcmDtEk97BEtm4ggSA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACkBjsYuWeJNYTGUhBVszgiUVOrMdEZ=qcmDtEk97BEtm4ggSA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon 12-04-21 18:42:58, Hao Sun wrote:
> Jan Kara <jack@suse.cz> 于2021年4月12日周一 下午5:02写道：
> >
> > Hello,
> >
> > On Sun 11-04-21 11:42:05, Hao Sun wrote:
> > > Since the last KCSAN report[1], I found two more KCSAN reports that
> > > Syzbot had not reported.
> > > Not sure if they are valid bugs, I hope the stack information in
> > > reports can help you locate the problem.
> > > Kernel config can be found in the attachment.
> >
> > Do we have symbolic decoding of the traces below? Because involved
> > functions are really big so it's difficult to guess what KCSAN is
> > complaining about... At least I wasn't able to guess it after looking into
> > the stacktraces for a while.
> >
> Sorry, the log processing module of Fuzzer still has some logic bugs,
> only some of the symbolized reports are stored in the disk.
> Interestingly, however, the read-write end that causes data racing in
> both reports are in the same location (fs/jbd2/commit.c:443), and this
> information should help locate the problem.
> 
> Partial symbolized report 1:
> ==================================================================
> BUG: KCSAN: data-race in ext4_mark_iloc_dirty / jbd2_journal_commit_transaction
> read-write to 0xffff88804451d800 of 8 bytes by task 4821 on cpu 1:
>  jbd2_journal_commit_transaction+0x222/0x3200 fs/jbd2/commit.c:443
>  kjournald2+0x253/0x470 fs/jbd2/journal.c:213
>  kthread+0x1f0/0x220 kernel/kthread.c:292
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:294

OK, that is:
	journal->j_flags |= JBD2_FULL_COMMIT_ONGOING;

So likely this is a complaint about j_flags update vs j_flags check race
(we check for JBD2_ABORT flag) all around the code.

So again this is harmless unless the compiler plays some devilish tricks
and doesn't store bogus intermediate values in j_flags during RMW
operations. Not sure how to deal with this one. Just putting data_race()
here doesn't seem right - if the compiler does something unexpected, we are
indeed in trouble. Maybe using bitops for j_flags would be beneficial for
other reasons as well as silencing KCSAN. But it needs more thought.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
