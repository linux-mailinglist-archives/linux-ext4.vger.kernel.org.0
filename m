Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB76D22EA9F
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 13:02:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726957AbgG0LCX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 07:02:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:48410 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726311AbgG0LCW (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 07:02:22 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 17160AC12;
        Mon, 27 Jul 2020 11:02:32 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id B15781E12C5; Mon, 27 Jul 2020 13:02:21 +0200 (CEST)
Date:   Mon, 27 Jul 2020 13:02:21 +0200
From:   Jan Kara <jack@suse.cz>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     Jan Kara <jack@suse.cz>, Ted Tso <tytso@mit.edu>,
        linux-ext4@vger.kernel.org, Ritesh Harjani <riteshh@linux.ibm.com>,
        Wolfgang Frisch <wolfgang.frisch@suse.com>
Subject: Re: [PATCH 1/4] ext4: Handle error of ext4_setup_system_zone() on
 remount
Message-ID: <20200727110221.GM23179@quack2.suse.cz>
References: <20200715131812.7243-1-jack@suse.cz>
 <20200715131812.7243-2-jack@suse.cz>
 <20200721101802.e6xl2oewirqmxcjr@work>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721101802.e6xl2oewirqmxcjr@work>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue 21-07-20 12:36:28, Lukas Czerner wrote:
> On Wed, Jul 15, 2020 at 03:18:09PM +0200, Jan Kara wrote:
> > ext4_setup_system_zone() can fail. Handle the failure in ext4_remount().
> > 
> > Signed-off-by: Jan Kara <jack@suse.cz>
> > ---
> >  fs/ext4/super.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > index 330957ed1f05..8e055ec57a2c 100644
> > --- a/fs/ext4/super.c
> > +++ b/fs/ext4/super.c
> > @@ -5653,7 +5653,10 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
> >  		ext4_register_li_request(sb, first_not_zeroed);
> >  	}
> >  
> > -	ext4_setup_system_zone(sb);
> > +	err = ext4_setup_system_zone(sb);
> > +	if (err)
> > +		goto restore_opts;
> > +
> 
> Thanks Jan, this looks good. But while you're at it, ext4_remount is
> missing ext4_release_system_zone() and so it we want to enable block_validity
> on remount and it fails after ext4_setup_system_zone() we wont release
> it. This *I think* means that we would end up with block_validity
> enabled without user knowing about it ?

And vice-versa, yes. I'll add a patch that fixes this bug to the series but
it's independent issue. Can I add your reviewed-by for this patch?

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
