Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95D404A5077
	for <lists+linux-ext4@lfdr.de>; Mon, 31 Jan 2022 21:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbiAaUrP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 31 Jan 2022 15:47:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:48603 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1348150AbiAaUqd (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 31 Jan 2022 15:46:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643661992;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nlHslKz1cGxHLBwn88wZKDWe9MiG6x7ySEZHx4PfzqQ=;
        b=KhIoRo/jtFIzMd9kNZrbhSCmZVxf7WPkJbt/8LfqSQyjRCk0niho8KQkOR1CnqTnqQI1l4
        JMt4sSSfSEv0xp3XOIB7nSc57wx7dB1oX1qreVXP+t5KOYb8cAQSmdxmgAQZIoJnB2Cz4c
        B5AoPWzEKJGWEVc0gJlPAhNZwFd5s9Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-YnzQenGqORC08BwzFxuxjA-1; Mon, 31 Jan 2022 15:46:31 -0500
X-MC-Unique: YnzQenGqORC08BwzFxuxjA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 01AED1091DA0;
        Mon, 31 Jan 2022 20:46:30 +0000 (UTC)
Received: from work (unknown [10.40.194.245])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 00FDA46975;
        Mon, 31 Jan 2022 20:46:28 +0000 (UTC)
Date:   Mon, 31 Jan 2022 21:46:25 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     fstests@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] common/rc: set maximum label length for ext4
Message-ID: <20220131204625.eimkrccyp4lqit57@work>
References: <20211123101119.5112-1-lczerner@redhat.com>
 <20220131170700.GA8288@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220131170700.GA8288@magnolia>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jan 31, 2022 at 09:07:00AM -0800, Darrick J. Wong wrote:
> On Tue, Nov 23, 2021 at 11:11:19AM +0100, Lukas Czerner wrote:
> > Set maximum label length for ext4 in _label_get_max() to be able to test
> > online file system label set/get ioctls.
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
> 
> After reviewing the ext4 ondisk format, 16 is the correct value.
> 
> Though I wonder, what actually prevents generic/492 from running on old
> kernels without GETLABEL support?

_require_xfs_io_command "label"

should take care of that. This is why I though it was no problem to get
this change in early.

-Lukas

> 
> Either way this patch is ok, so...
> Reviewed-by: Darrick J. Wong <djwong@kernel.org>
> 
> --D
> 
> > +		;;
> >  	*)
> >  		_notrun "$FSTYP does not define maximum label length"
> >  		;;
> > -- 
> > 2.31.1
> > 
> 

