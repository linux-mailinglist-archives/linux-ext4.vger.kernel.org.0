Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 714F5123296
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2019 17:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbfLQQen (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Dec 2019 11:34:43 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:34975 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727802AbfLQQen (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 17 Dec 2019 11:34:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576600482;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JRhNoK6ecjIEWZT9z2fmsJ4MliKY9CsSRK7g7FgLN48=;
        b=Ww+Gn2AbkUNG/CNkFhUnw2sRPVt6ku+6qz7WvfrDualtFbRSRjbUWWcMkHNST9vwKyySLW
        s1xBmsQ3fpOnBWOYCXauliZz8ZGosCtKUHVW+RnRjpK3F06ZX/X3IpeQ19u4fUP3KgUk2L
        H9VXhbGV9wClhML0Mfd1CIjaImkpHOI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-130-Jlr96TkuPL-rvRrrR78slg-1; Tue, 17 Dec 2019 11:34:38 -0500
X-MC-Unique: Jlr96TkuPL-rvRrrR78slg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C6748DBA7;
        Tue, 17 Dec 2019 16:34:37 +0000 (UTC)
Received: from work (ovpn-205-130.brq.redhat.com [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id B232E100164D;
        Tue, 17 Dec 2019 16:34:36 +0000 (UTC)
Date:   Tue, 17 Dec 2019 17:34:32 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 02/17] ext4: Add fs parameter description
Message-ID: <20191217163432.diborehdrfkmfqxp@work>
References: <20191106101457.11237-1-lczerner@redhat.com>
 <20191106101457.11237-3-lczerner@redhat.com>
 <20191217004419.GA6833@ZenIV.linux.org.uk>
 <20191217121956.amsymslmuoy6kzu4@work>
 <20191217152012.GY4203@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217152012.GY4203@ZenIV.linux.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 17, 2019 at 03:20:12PM +0000, Al Viro wrote:
> On Tue, Dec 17, 2019 at 01:19:56PM +0100, Lukas Czerner wrote:
> > On Tue, Dec 17, 2019 at 12:44:19AM +0000, Al Viro wrote:
> > > On Wed, Nov 06, 2019 at 11:14:42AM +0100, Lukas Czerner wrote:
> > > > +	fsparam_string_empty
> > > > +			("usrjquota",		Opt_usrjquota),
> > > > +	fsparam_string_empty
> > > > +			("grpjquota",		Opt_grpjquota),
> > > 
> > > Umm...  That makes ...,usrjquota,... equivalent to ...,usrjquota=,...
> > > unless I'm misreading the series.  Different from mainline, right?
> > 
> > Unfortunatelly yes, I do not think this is a problem, but if you have a
> > solution within the new mount api framework I am happy to use it.
> 
> Er...  Dump the fsparam_string_empty() use and instead of your
> +       if (token == Opt_usrjquota) {
> +               if (result.negated)
> +                       return clear_qf_name(sb, USRQUOTA);
> +               else
> +                       return set_qf_name(sb, USRQUOTA, param);
> do
> +       if (token == Opt_usrjquota) {
> +               if (!param->string[0])
> +                       return clear_qf_name(sb, USRQUOTA);
> +               else
> +                       return set_qf_name(sb, USRQUOTA, param);
> with the same for grpjquota?

Ah right, it's been a while I guess I didn't realize that it will accept
usrjquota as well as usrjquota=

It makes sense to check the string directly, thanks.

> 
> > > > +	fsparam_bool	("barrier",		Opt_barrier),
> > > > +	fsparam_flag	("nobarrier",		Opt_nobarrier),
> > > 
> > > That's even more interesting.  Current mainline:
> > > 		barrier		OK, sets EXT4_MOUNT_BARRIER
> > > 		barrier=0	OK, sets EXT4_MOUNT_BARRIER
> > > 		barrier=42	OK, sets EXT4_MOUNT_BARRIER
> > > 		barrier=yes	error
> > > 		barrier=no	error
> > > 		nobarrier	OK, clears EXT4_MOUNT_BARRIER
> > > Unless I'm misreading your series, you get
> > > 		barrier		error
> > 
> > Not really, this seems to be working as expected. Assuming that this
> > didn't change since 5.4.0-rc6. I does make sense to me that specifying
> > bool type parameter without any options would express "true".
> > 
> > 
> > > 		barrier=0	OK, sets EXT4_MOUNT_BARRIER
> > 
> > 
> > > 		barrier=42	error
> > > 		barrier=yes	OK, sets EXT4_MOUNT_BARRIER
> > > 		barrier=no	OK, sets EXT4_MOUNT_BARRIER
> > 
> > Those three are different, just because of how param_book() work. I do
> > not really see a problem with it, but if we want to keep it exactly the
> > same as current mainline it would be difficult with how the current api
> > works. Any suggestions ?
> 
> If fsparam_bool() doesn't do the right thing, perhaps it shouldn't be
> used in the first place?  Or changed, for that matter - it's not as if
> we had many users of that thing and the only in-tree one is definitely
> breaking userland ABI.
> 
> In case of ext4, after rereading that code (and getting some sleep) the
> current behaviour is, AFAICS to accept barrier | nobarrier | barrier=<number>
> with the last case being equialent to nobarrier when number is 0 and barrier
> in all other cases.  Is that an accurate description?

Yeah, the documentation says
barrier=0 / barrier=1 / barrier / nobarrier

but we do accept any number from 0 to 2147483647

> 
> If so, I would prefer
> 	fsparam_flag_no("barrier", Opt_barrier),	// barrier | nobarrier
> 	fsparam_u32("barrier", Opt_barrier),		// barrier=<number>
> as the solution, with fs_parse() having been taught to allow argument-bearing
> and argument-less options with the same name, picking the right one.  That
> way Opt_nobarrier gets removed as well...
> 
> I'll push a branch with that stuff later today; will post when it's out...

That would be great, thanks.

-Lukas

