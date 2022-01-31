Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B92E4A3F75
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jan 2022 10:43:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236888AbiAaJnE (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jan 2022 04:43:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:21444 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238819AbiAaJnE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 31 Jan 2022 04:43:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643622184;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fM0hWX1Hvc4K9LjDrBo1FgLahCr8ka4rEYWLjkOURK0=;
        b=R/9bLbR4aQdyH7U+ObZW1yQXC+2nL3SaujbgowgDboGRjr/TG6BepFtZtmSI72BJck8SVF
        tqs3Q4DQS78HsZE18/Oe+Qu0wo4Ck2MQvCtgPkm8hiNRuzq3m8R2y77gIKBX49yNnGI3vX
        TfWbdNtbGAJdaGzRuTqhflBW3WzxYl0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-251-t6e8Hm-VPp-FTjA7OIFswA-1; Mon, 31 Jan 2022 04:43:00 -0500
X-MC-Unique: t6e8Hm-VPp-FTjA7OIFswA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D61C346860;
        Mon, 31 Jan 2022 09:42:58 +0000 (UTC)
Received: from work (unknown [10.40.194.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F082E62D75;
        Mon, 31 Jan 2022 09:42:57 +0000 (UTC)
Date:   Mon, 31 Jan 2022 10:42:56 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Eryu Guan <guan@eryu.me>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] common/rc: set maximum label length for ext4
Message-ID: <20220131094256.zfdsbzda5abtufvw@work>
References: <20211123101119.5112-1-lczerner@redhat.com>
 <YaOTRYYkEwlbnvPb@desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YaOTRYYkEwlbnvPb@desktop>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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
> 
> Thanks,
> Eryu

It's upstream now, can we have this change in so that it can be tested?

Thanks!
-Lukas

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

