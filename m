Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BAE845B87A
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Nov 2021 11:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241141AbhKXKkx (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Nov 2021 05:40:53 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:41356 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240770AbhKXKku (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 24 Nov 2021 05:40:50 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 7165C1FD2F;
        Wed, 24 Nov 2021 10:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1637750258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ygjLxT1vNWvM7BpkjUAizePFnFDQ6P24V9QpTUuBDHM=;
        b=FlLXVmBBiK0xHYh/dmhpEtYnI1Je0+R5Sck4289giKOmWtkEWG12RT/EULIyq+vtifT4Yf
        ut0VEtdoNmeyspT7xGX/ZIX82NtWWlDsPwIwNbbVjqgtsX/lLuhIdG+tmN4PT3vi2gcb5Y
        VdYRM4/vDhgdMlWFSeO9O8OHn6whezQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1637750258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ygjLxT1vNWvM7BpkjUAizePFnFDQ6P24V9QpTUuBDHM=;
        b=ozteY1g7L6Go1JOJVCOkJyMVtwpu0ezM8XDUY6qoAJC7qWVOZ85WeF7YvLE5m1AX1F3SlI
        MOgd0of5YiD9UAAA==
Received: from quack2.suse.cz (unknown [10.100.200.198])
        by relay2.suse.de (Postfix) with ESMTP id 627D4A3B88;
        Wed, 24 Nov 2021 10:37:38 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0E7961E14AC; Wed, 24 Nov 2021 11:37:37 +0100 (CET)
Date:   Wed, 24 Nov 2021 11:37:37 +0100
From:   Jan Kara <jack@suse.cz>
To:     yangerkun <yangerkun@huawei.com>
Cc:     Jan Kara <jack@suse.cz>, Theodore Ts'o <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        yukuai3@huawei.com
Subject: Re: [PATCH] ext4: if zeroout fails fall back to splitting the extent
 node
Message-ID: <20211124103737.GI8583@quack2.suse.cz>
References: <YRaNKc2PvM+Eyzmp@mit.edu>
 <20210813212701.366447-1-tytso@mit.edu>
 <715f636e-ff1b-301f-38a9-602437fdd95a@huawei.com>
 <20211123092741.GA8583@quack2.suse.cz>
 <d5346e36-3331-0d0d-e36d-83f543986ccb@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d5346e36-3331-0d0d-e36d-83f543986ccb@huawei.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed 24-11-21 17:01:12, yangerkun wrote:
> On 2021/11/23 17:27, Jan Kara wrote:
> > Hello,
> > 
> > On Sun 26-09-21 19:35:01, yangerkun wrote:
> > > Rethink about this problem. Should we consider other place which call
> > > ext4_issue_zeroout? Maybe it can trigger the problem too(in theory, not
> > > really happened)...
> > > 
> > > How about include follow patch which not only transfer ENOSPC to EIO. But
> > > also stop to overwrite the error return by ext4_ext_insert_extent in
> > > ext4_split_extent_at.
> > > 
> > > Besides, 308c57ccf431 ("ext4: if zeroout fails fall back to splitting the
> > > extent node") can work together with this patch.
> > 
> > I've got back to this. The ext4_ext_zeroout() calls in
> > ext4_split_extent_at() seem to be there as fallback when insertion of a new
> > extent fails due to ENOSPC / EDQUOT. If even ext4_ext_zeroout(), then I
> > think returning an error as the code does now is correct and we don't have
> > much other option. Also we are really running out of disk space so I think
> > returning ENOSPC is fine. What exact scenario are you afraid of?
> 
> I am afraid about the EDQUOT from ext4_ext_insert_extent may be overwrite by
> ext4_ext_zeroout with ENOSPC. And this may lead to dead loop since
> ext4_writepages will retry once get ENOSPC? Maybe I am wrong...

OK, so passing back original error instead of the error from
ext4_ext_zeroout() makes sense. But I don't think doing much more is needed
- firstly, ENOSPC or EDQUOT should not happen in ext4_split_extent_at()
called from ext4_writepages() because we should have reserved enough
space for extent splits when writing data. So hitting that is already
unexpected. Committing transaction holding blocks that are expected to be
free is the most likely reason for us seeing ENOSPC and returning EIO in
that case would be bug. Secondly, returning EIO instead of ENOSPC is IMO a
bit confusing for upper layers and makes it harder to analyze where the
real problem is...

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
