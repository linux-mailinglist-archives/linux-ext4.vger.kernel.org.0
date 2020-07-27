Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1DD22EB1C
	for <lists+linux-ext4@lfdr.de>; Mon, 27 Jul 2020 13:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726916AbgG0LWj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 27 Jul 2020 07:22:39 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24170 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726475AbgG0LWj (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 27 Jul 2020 07:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595848958;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HVgCEppMiwew88OVQW0bSq15+C6jHj4kixsqEwo0Rbk=;
        b=Ng5AJfV6/bsfCde/VE03SORuMQ/lfuLYaZ+PFKQTCLIVWSRDI6soAW6n4a3VNt6IqGB+Xc
        DPTagHW/VuZbenUfPPZiWJ2wRydPkesy0GyNdQ3+pY+MgGORVsq4CyGGownr8hVbwWlf+I
        rydRpedKqCNpw3EjeJH3dxWssgvfLQw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-450-alcUap_pNfmNV2IDIFi4nA-1; Mon, 27 Jul 2020 07:22:33 -0400
X-MC-Unique: alcUap_pNfmNV2IDIFi4nA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0E03B1B18BFF;
        Mon, 27 Jul 2020 11:22:29 +0000 (UTC)
Received: from work (unknown [10.40.192.203])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B3F9A10840C1;
        Mon, 27 Jul 2020 11:22:27 +0000 (UTC)
Date:   Mon, 27 Jul 2020 13:22:22 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        Ritesh Harjani <riteshh@linux.ibm.com>,
        Wolfgang Frisch <wolfgang.frisch@suse.com>
Subject: Re: [PATCH 1/4] ext4: Handle error of ext4_setup_system_zone() on
 remount
Message-ID: <20200727112222.o456ugnebuzu2hks@work>
References: <20200715131812.7243-1-jack@suse.cz>
 <20200715131812.7243-2-jack@suse.cz>
 <20200721101802.e6xl2oewirqmxcjr@work>
 <20200727110221.GM23179@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727110221.GM23179@quack2.suse.cz>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 27, 2020 at 01:02:21PM +0200, Jan Kara wrote:
> On Tue 21-07-20 12:36:28, Lukas Czerner wrote:
> > On Wed, Jul 15, 2020 at 03:18:09PM +0200, Jan Kara wrote:
> > > ext4_setup_system_zone() can fail. Handle the failure in ext4_remount().
> > > 
> > > Signed-off-by: Jan Kara <jack@suse.cz>
> > > ---
> > >  fs/ext4/super.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/fs/ext4/super.c b/fs/ext4/super.c
> > > index 330957ed1f05..8e055ec57a2c 100644
> > > --- a/fs/ext4/super.c
> > > +++ b/fs/ext4/super.c
> > > @@ -5653,7 +5653,10 @@ static int ext4_remount(struct super_block *sb, int *flags, char *data)
> > >  		ext4_register_li_request(sb, first_not_zeroed);
> > >  	}
> > >  
> > > -	ext4_setup_system_zone(sb);
> > > +	err = ext4_setup_system_zone(sb);
> > > +	if (err)
> > > +		goto restore_opts;
> > > +
> > 
> > Thanks Jan, this looks good. But while you're at it, ext4_remount is
> > missing ext4_release_system_zone() and so it we want to enable block_validity
> > on remount and it fails after ext4_setup_system_zone() we wont release
> > it. This *I think* means that we would end up with block_validity
> > enabled without user knowing about it ?
> 
> And vice-versa, yes. I'll add a patch that fixes this bug to the series but
> it's independent issue. Can I add your reviewed-by for this patch?

Yes, of course. You can add

Reviewed-by: Lukas Czerner <lczerner@redhat.com>

Thanks!
-Lukas

> 
> 								Honza
> -- 
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
> 

