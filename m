Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 65051257718
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Aug 2020 12:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgHaKDn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Aug 2020 06:03:43 -0400
Received: from mx2.suse.de ([195.135.220.15]:39574 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725964AbgHaKDm (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 31 Aug 2020 06:03:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id CA31EB702;
        Mon, 31 Aug 2020 10:04:15 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 7CA711E12CF; Mon, 31 Aug 2020 12:03:40 +0200 (CEST)
Date:   Mon, 31 Aug 2020 12:03:40 +0200
From:   Jan Kara <jack@suse.cz>
To:     syzbot <syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        tytso@mit.edu, linux-mm@kvack.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>
Subject: Re: kernel BUG at fs/ext4/inode.c:LINE!
Message-ID: <20200831100340.GA26519@quack2.suse.cz>
References: <000000000000d3a33205add2f7b2@google.com>
 <20200828100755.GG7072@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200828100755.GG7072@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri 28-08-20 12:07:55, Jan Kara wrote:
> On Wed 26-08-20 19:48:16, syzbot wrote:
> > Hello,
> > 
> > syzbot found the following issue on:
> > 
> > HEAD commit:    c3d8f220 Merge tag 'kbuild-fixes-v5.9' of git://git.kernel..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=15f83cb6900000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=bb68b9e8a8cc842f
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3622cea378100f45d59f
> > compiler:       clang version 10.0.0 (https://github.com/llvm/llvm-project/ c2443155a0fb245c8f17f2c1c72b6ea391e86e81)
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1287ac96900000
> > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11c7ac46900000
> > 
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+3622cea378100f45d59f@syzkaller.appspotmail.com
> > 
> > ------------[ cut here ]------------
> > kernel BUG at fs/ext4/inode.c:2598!
> > invalid opcode: 0000 [#1] PREEMPT SMP KASAN
> > CPU: 1 PID: 27612 Comm: syz-executor879 Not tainted 5.9.0-rc1-syzkaller #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> > RIP: 0010:mpage_prepare_extent_to_map+0xd34/0xd40 fs/ext4/inode.c:2598
> 
> Doh, so this is:
> 
>                         wait_on_page_writeback(page);
> >>>                     BUG_ON(PageWriteback(page));
> 
> in mpage_prepare_extent_to_map(). So we have PageWriteback() page after we
> have called wait_on_page_writeback() on a locked page. Not sure how this
> could ever happen even less how ext4 could cause this...

I was poking a bit into this and there were actually recent changes into
page bit waiting logic by Linus. Linus, any idea?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
