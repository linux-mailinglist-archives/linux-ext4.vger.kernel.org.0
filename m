Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F041C46117E
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Nov 2021 10:58:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238411AbhK2KBU (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Nov 2021 05:01:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26233 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243214AbhK2J7T (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Nov 2021 04:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638179756;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NjpvYOJ7k4kFXh6Cfw8LSu8k+oFfeYQhWv+oBgZbe5g=;
        b=Vr+VTnOM5JVEgR3DUraiOmk479YiasfhbM5YueCQsSOTIRnmahc0xmQeD5AiN07yLpLTu3
        Jq/UY5b3vjuvNafHdEZvOFs5yEdkxaaanHs7Y+h6zr/tL4GsxArQDzExWSdqotMVEwnf67
        9goYrgZmXq5fZY4zGNWDFCmTwhWQ4zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-70-0z4if9jkN9-qi_v7kJw3DQ-1; Mon, 29 Nov 2021 04:55:53 -0500
X-MC-Unique: 0z4if9jkN9-qi_v7kJw3DQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2CC971006AA0;
        Mon, 29 Nov 2021 09:55:52 +0000 (UTC)
Received: from work (unknown [10.40.194.53])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 42DCF5D9DE;
        Mon, 29 Nov 2021 09:55:50 +0000 (UTC)
Date:   Mon, 29 Nov 2021 10:55:47 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] common/rc: set maximum label length for ext4
Message-ID: <20211129095547.wrrv6vbc2rcaeiwg@work>
References: <20211123101119.5112-1-lczerner@redhat.com>
 <YaOTRYYkEwlbnvPb@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaOTRYYkEwlbnvPb@desktop>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Sun, Nov 28, 2021 at 10:33:41PM +0800, Eryu Guan wrote:
> On Tue, Nov 23, 2021 at 11:11:19AM +0100, Lukas Czerner wrote:
> > Set maximum label length for ext4 in _label_get_max() to be able to test
> > online file system label set/get ioctls.
> 
> Some background info included in commit log would be good, e.g. ext4
> didn't support get/set label ioctl but we're going to add that support
> in both kernel and e2fsprogs.
> 
> And I noticed the kernel patch is still in review, and has no comments
> so far. So I'd like to wait and make sure the new ioctl will be accepted
> first.

Sure, just note that the maximum label length for ext4 will be 16 with, or
without the ioctls. This patch just fixes what was missing in the first
place.

Thanks!
-Lukas

> 
> Thanks,
> Eryu
> 
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> >  common/rc | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/common/rc b/common/rc
> > index 8e351f17..50d6d0bd 100644
> > --- a/common/rc
> > +++ b/common/rc
> > @@ -4545,6 +4545,9 @@ _label_get_max()
> >  	f2fs)
> >  		echo 255
> >  		;;
> > +	ext2|ext3|ext4)
> > +		echo 16
> > +		;;
> >  	*)
> >  		_notrun "$FSTYP does not define maximum label length"
> >  		;;
> > -- 
> > 2.31.1
> 

