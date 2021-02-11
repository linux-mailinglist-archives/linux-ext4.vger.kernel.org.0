Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA6C318B20
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 13:48:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231337AbhBKMrF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 07:47:05 -0500
Received: from mx2.suse.de ([195.135.220.15]:49772 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231260AbhBKMoc (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Feb 2021 07:44:32 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613047420; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9yDpXZT/IPKfsYIAYekJj37GWKhX8+EMi5wFh+elIO4=;
        b=pH27LfB9QFyOPghIHYyH78kg3TKNwwCr1i+qRzYDbEXXKM0glo0nkq7Y1djXh2JOX+hZSS
        sHm4EK1DD6ReXcKeCjs33K7tN4n2bu0Iz7xTUTuf4FNJZy9ZAhArE1VXDRz68n4+CaNRK2
        bJwbEeNOnmLXGt0LpBDaGQEpdCVtMt8=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id BA6CAACD4;
        Thu, 11 Feb 2021 12:43:40 +0000 (UTC)
Date:   Thu, 11 Feb 2021 13:43:34 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Jan Kara <jack@suse.cz>, Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+a7ab8df042baaf42ae3c@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Tahsin Erdogan <tahsin@google.com>, tytso@mit.edu
Subject: Re: possible deadlock in fs_reclaim_acquire (2)
Message-ID: <YCUmZ1SBTbDGfAN6@dhcp22.suse.cz>
References: <00000000000086723c05bb056425@google.com>
 <20210211040729.12804-1-hdanton@sina.com>
 <20210211102225.GK19070@quack2.suse.cz>
 <YCUL/icHBWeEV1Ex@dhcp22.suse.cz>
 <20210211114943.GH2696@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211114943.GH2696@kadam>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 11-02-21 14:49:43, Dan Carpenter wrote:
> On Thu, Feb 11, 2021 at 11:50:38AM +0100, 'Michal Hocko' via syzkaller-bugs wrote:
> > On Thu 11-02-21 11:22:25, Jan Kara wrote:
> > > On Thu 11-02-21 12:07:29, Hillf Danton wrote:
> > 
> > I haven't received Hillf's email.
> > 
> > [...]
> > > > Fix 71b565ceff37 ("ext4: drop ext4_kvmalloc()") by restoring the
> > > > GFP_NOFS introduced in dec214d00e0d ("ext4: xattr inode deduplication").
> > > > 
> > > > Note this may be the fix also to possible deadlock
> > > >  Reported-by: syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com
> > > >  https://lore.kernel.org/linux-ext4/000000000000563a0205bafb7970@google.com/
> > > 
> > > Please no. Ext4 is using scoping API to limit allocations to GFP_NOFS
> > > inside transactions. In this case something didn't work which seems like a
> > > lockdep bug at the first sight but I'll talk to mm guys about it.
> > > Definitely to problem doesn't seem to be in ext4.
> > 
> > Agreed. kvmalloc(NOFS) is not even supported because vmalloc doesn't
> > support GFP_KERNEL incompatible requests.
> 
> Okay.  I have created a new Smatch warning when people pass GFP_NOFS
> to kvmalloc() and friends.  We'll see if it finds anything tomorrow.

Thanks! Let me just clarify a bit. The kvmalloc doesn't support
GFP_KERNEL incompatible requests and it simply skips vmalloc fallback.
So this is not a correctness issue. It is the API abuse though.

-- 
Michal Hocko
SUSE Labs
