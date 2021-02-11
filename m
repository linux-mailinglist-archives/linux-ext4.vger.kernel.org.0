Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D290C318A30
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 13:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbhBKMOw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 07:14:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:34764 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230436AbhBKMMo (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Feb 2021 07:12:44 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 80C01ACD4;
        Thu, 11 Feb 2021 12:12:02 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 1B4BA1E14B2; Thu, 11 Feb 2021 13:12:02 +0100 (CET)
Date:   Thu, 11 Feb 2021 13:12:02 +0100
From:   Jan Kara <jack@suse.cz>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Jan Kara <jack@suse.cz>,
        syzbot <syzbot+a7ab8df042baaf42ae3c@syzkaller.appspotmail.com>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "syzkaller-bugs@googlegroups.com" <syzkaller-bugs@googlegroups.com>,
        Tahsin Erdogan <tahsin@google.com>
Subject: Re: possible deadlock in fs_reclaim_acquire (2)
Message-ID: <20210211121202.GP19070@quack2.suse.cz>
References: <00000000000086723c05bb056425@google.com>
 <20210211040729.12804-1-hdanton@sina.com>
 <20210211102225.GK19070@quack2.suse.cz>
 <20210211120424.86857A3B85@relay2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211120424.86857A3B85@relay2.suse.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 11-02-21 20:04:14, Hillf Danton wrote:
> On Thu 11-02-21 12:07:29, Jan Kara wrote:
> >> Fix 71b565ceff37 ("ext4: drop ext4_kvmalloc()") by restoring the
> >> GFP_NOFS introduced in dec214d00e0d ("ext4: xattr inode deduplication").
> >> 
> >> Note this may be the fix also to possible deadlock
> >>  Reported-by: syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com
> >>  https://lore.kernel.org/linux-ext4/000000000000563a0205bafb7970@google.com/
> >
> >Please no. Ext4 is using scoping API to limit allocations to GFP_NOFS
> >inside transactions. In this case something didn't work which seems like a
> >lockdep bug at the first sight but I'll talk to mm guys about it.
> >Definitely to problem doesn't seem to be in ext4.
> 
> Feel free to elaborate why we can find ext4  in the report?
> Why is ext4 special in this case?

Please read my reply to the syzbot report [1]. It has all the details.

[1] https://lore.kernel.org/lkml/20210211104947.GL19070@quack2.suse.cz

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
