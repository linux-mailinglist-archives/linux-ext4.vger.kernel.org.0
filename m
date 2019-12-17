Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C25122B4C
	for <lists+linux-ext4@lfdr.de>; Tue, 17 Dec 2019 13:20:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727656AbfLQMUF (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 17 Dec 2019 07:20:05 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54049 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726859AbfLQMUF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 17 Dec 2019 07:20:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1576585204;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B0+KY2LgohuAAUeLzqgL5r7ybIqzWDh0cTOzyxzvRko=;
        b=SUKC6clyluwOGCEhhe41LeX8/XfIcP10IH4xoijLBi2rpL+jSgHKMcW9FF3DVrPSz+dHyY
        dunuHONI/1hg1Jbs3cyPaYz0qTl8JL/NC6cL/Ta6C5Y5mML/Md8n+nLz7Vgop/DwI+J9ow
        yrmrgVm3WgYZS4uAIQNjxkMXy0fqW+E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-h1B4o9tNNeSyw-9rJna_GA-1; Tue, 17 Dec 2019 07:20:03 -0500
X-MC-Unique: h1B4o9tNNeSyw-9rJna_GA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D77D8056B1;
        Tue, 17 Dec 2019 12:20:02 +0000 (UTC)
Received: from work (ovpn-205-130.brq.redhat.com [10.40.205.130])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 027AD7C830;
        Tue, 17 Dec 2019 12:20:00 +0000 (UTC)
Date:   Tue, 17 Dec 2019 13:19:56 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-ext4@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH 02/17] ext4: Add fs parameter description
Message-ID: <20191217121956.amsymslmuoy6kzu4@work>
References: <20191106101457.11237-1-lczerner@redhat.com>
 <20191106101457.11237-3-lczerner@redhat.com>
 <20191217004419.GA6833@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191217004419.GA6833@ZenIV.linux.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 17, 2019 at 12:44:19AM +0000, Al Viro wrote:
> On Wed, Nov 06, 2019 at 11:14:42AM +0100, Lukas Czerner wrote:
> > +	fsparam_string_empty
> > +			("usrjquota",		Opt_usrjquota),
> > +	fsparam_string_empty
> > +			("grpjquota",		Opt_grpjquota),
> 
> Umm...  That makes ...,usrjquota,... equivalent to ...,usrjquota=,...
> unless I'm misreading the series.  Different from mainline, right?

Unfortunatelly yes, I do not think this is a problem, but if you have a
solution within the new mount api framework I am happy to use it.

> 
> > +	fsparam_bool	("barrier",		Opt_barrier),
> > +	fsparam_flag	("nobarrier",		Opt_nobarrier),
> 
> That's even more interesting.  Current mainline:
> 		barrier		OK, sets EXT4_MOUNT_BARRIER
> 		barrier=0	OK, sets EXT4_MOUNT_BARRIER
> 		barrier=42	OK, sets EXT4_MOUNT_BARRIER
> 		barrier=yes	error
> 		barrier=no	error
> 		nobarrier	OK, clears EXT4_MOUNT_BARRIER
> Unless I'm misreading your series, you get
> 		barrier		error

Not really, this seems to be working as expected. Assuming that this
didn't change since 5.4.0-rc6. I does make sense to me that specifying
bool type parameter without any options would express "true".


> 		barrier=0	OK, sets EXT4_MOUNT_BARRIER


> 		barrier=42	error
> 		barrier=yes	OK, sets EXT4_MOUNT_BARRIER
> 		barrier=no	OK, sets EXT4_MOUNT_BARRIER

Those three are different, just because of how param_book() work. I do
not really see a problem with it, but if we want to keep it exactly the
same as current mainline it would be difficult with how the current api
works. Any suggestions ?

Thanks!
-Lukas

> 		nobarrier	OK, clears EXT4_MOUNT_BARRIER
> 
> Granted, mainline behaviour is... unintuitive, to put it mildly,
> but the replacement is just as strange _and_ incompatible with the
> existing one.
> 
> Am I missing something subtle there?
> 

