Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DDC93188B7
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Feb 2021 11:59:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231150AbhBKKyC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Feb 2021 05:54:02 -0500
Received: from mx2.suse.de ([195.135.220.15]:48168 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231145AbhBKKv0 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 11 Feb 2021 05:51:26 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1613040639; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4s2C2BZFhkoBihiMEkn19ehOaFXagHjco1YWPm9BhEA=;
        b=J/+yW0TLTI1Bs4oZleqC5qNCielOfUwlAdoe+IMOiBuxdCVl8giPKKxAa1AlyHDRZ+y0kP
        FyzcgioyJ69R3FWdBYsPwFDy7E6O7ux5eua3GGXMNhMhDH3PabQiswLg/sHNeJdbUGA8cC
        n0LnPz+/3ICYd5vgJ7eicvJY9sMKv4Q=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B5D99AEA3;
        Thu, 11 Feb 2021 10:50:39 +0000 (UTC)
Date:   Thu, 11 Feb 2021 11:50:38 +0100
From:   Michal Hocko <mhocko@suse.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+a7ab8df042baaf42ae3c@syzkaller.appspotmail.com>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        Tahsin Erdogan <tahsin@google.com>, tytso@mit.edu
Subject: Re: possible deadlock in fs_reclaim_acquire (2)
Message-ID: <YCUL/icHBWeEV1Ex@dhcp22.suse.cz>
References: <00000000000086723c05bb056425@google.com>
 <20210211040729.12804-1-hdanton@sina.com>
 <20210211102225.GK19070@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210211102225.GK19070@quack2.suse.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 11-02-21 11:22:25, Jan Kara wrote:
> On Thu 11-02-21 12:07:29, Hillf Danton wrote:

I haven't received Hillf's email.

[...]
> > Fix 71b565ceff37 ("ext4: drop ext4_kvmalloc()") by restoring the
> > GFP_NOFS introduced in dec214d00e0d ("ext4: xattr inode deduplication").
> > 
> > Note this may be the fix also to possible deadlock
> >  Reported-by: syzbot+bfdded10ab7dcd7507ae@syzkaller.appspotmail.com
> >  https://lore.kernel.org/linux-ext4/000000000000563a0205bafb7970@google.com/
> 
> Please no. Ext4 is using scoping API to limit allocations to GFP_NOFS
> inside transactions. In this case something didn't work which seems like a
> lockdep bug at the first sight but I'll talk to mm guys about it.
> Definitely to problem doesn't seem to be in ext4.

Agreed. kvmalloc(NOFS) is not even supported because vmalloc doesn't
support GFP_KERNEL incompatible requests.
> 
> 								Honza
> 
> > 
> > --- a/fs/ext4/xattr.c
> > +++ b/fs/ext4/xattr.c
> > @@ -1459,7 +1459,7 @@ ext4_xattr_inode_cache_find(struct inode
> >  	if (!ce)
> >  		return NULL;
> >  
> > -	ea_data = kvmalloc(value_len, GFP_KERNEL);
> > +	ea_data = kvmalloc(value_len, GFP_NOFS);
> >  	if (!ea_data) {
> >  		mb_cache_entry_put(ea_inode_cache, ce);
> >  		return NULL;
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR

-- 
Michal Hocko
SUSE Labs
