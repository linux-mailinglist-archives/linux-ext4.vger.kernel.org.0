Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E82E3F47B1
	for <lists+linux-ext4@lfdr.de>; Mon, 23 Aug 2021 11:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232168AbhHWJgI (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Aug 2021 05:36:08 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:40132 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231679AbhHWJgH (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Aug 2021 05:36:07 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 8A9BC21EDB;
        Mon, 23 Aug 2021 09:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1629711324; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEQXU303m18GEih/91eVH67ti89qaTIhbqs+WseBOiM=;
        b=sYGV4y1jYMnWB1NyGZqlD/SPcbdTAb0HtvMrPQYtFkZhVP5UbLFVKyxgsTd4Ti8akIaclP
        RnQ3Cz8FVwNcwyohnfNb8SibGA15VZZpeWmFdgdqOvELCX9NeXqFvK5wSpe5FLEoRfCl/s
        D12I3XC84UDjca8QBfzzsui8Yv3RwDs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1629711324;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZEQXU303m18GEih/91eVH67ti89qaTIhbqs+WseBOiM=;
        b=XiuJDPz7pWuCWrv2iIhrq6MasytlLYcIGfiYluG+C/8YxoPph/j0GG5HkpP9XTnI/G2nrc
        Z2VOsmImzwRzpCAg==
Received: from quack2.suse.cz (unknown [10.100.224.230])
        by relay2.suse.de (Postfix) with ESMTP id 60074A3BB0;
        Mon, 23 Aug 2021 09:35:24 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id 0AC231E3B01; Mon, 23 Aug 2021 11:35:24 +0200 (CEST)
Date:   Mon, 23 Aug 2021 11:35:24 +0200
From:   Jan Kara <jack@suse.cz>
To:     Matthew Bobrowski <repnop@google.com>
Cc:     krisman@collabora.com, pvorel@suse.cz,
        Amir Goldstein <amir73il@gmail.com>, kernel@collabora.com,
        Khazhismel Kumykov <khazhy@google.com>,
        Jan Kara <jack@suse.com>, Ext4 <linux-ext4@vger.kernel.org>,
        LTP List <ltp@lists.linux.it>
Subject: Re: [LTP] [PATCH 3/7] syscalls/fanotify20: Validate incoming FID in
 FAN_FS_ERROR
Message-ID: <20210823093524.GB21467@quack2.suse.cz>
References: <20210802214645.2633028-1-krisman@collabora.com>
 <20210802214645.2633028-4-krisman@collabora.com>
 <CAOQ4uxjMfJM4FM4tWJWgjbK4a2K1hNJdEBRvwQTh9+5su2N0Tw@mail.gmail.com>
 <87fsvphksu.fsf@collabora.com>
 <CAOQ4uxj_WwDPxZv0nr9+Hh+pim6+2onaBdFq_BR-qK=xz+8yUg@mail.gmail.com>
 <YR+CH2+GYzwU2/SG@pevik>
 <YSAlb7XGUNoc73ZJ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YSAlb7XGUNoc73ZJ@google.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sat 21-08-21 07:58:07, Matthew Bobrowski wrote:
> On Fri, Aug 20, 2021 at 12:21:19PM +0200, Petr Vorel wrote:
> > Hi all,
> > 
> > > No problem. That's what review is for ;-)
> > 
> > > BTW, unless anyone is specifically interested I don't think there
> > > is a reason to re post the test patches before the submission request.
> > > Certainly not for the small fixes that I requested.
> > 
> > > I do request that you post a link to a branch with the fixed test
> > > so that we can experiment with the kernel patches.
> > 
> > > I've also CC'ed Matthew who may want to help with review of the test
> > > and man page that you posted in the cover letter [1].
> > 
> > @Amir Thanks a lot for your review, agree with all you mentioned.
> > 
> > @Gabriel Thanks for your contribution. I'd also consider squashing some of the
> > commits.
> 
> Is the FAN_FS_ERROR feature to be included within the 5.15 release? If so,
> I may need to do some shuffling around as these LTP tests collide with the
> ones I author for the FAN_REPORT_PIDFD series.

No, I don't think FAN_FS_ERROR is quite ready for the coming merge window.
So you should be fine.

								Honza

-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
