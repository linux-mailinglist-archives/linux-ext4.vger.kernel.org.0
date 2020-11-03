Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07A512A3D74
	for <lists+linux-ext4@lfdr.de>; Tue,  3 Nov 2020 08:20:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727527AbgKCHUK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 3 Nov 2020 02:20:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45330 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725958AbgKCHUK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 3 Nov 2020 02:20:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604388008;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qLV/t+6Ml39pPuv/0G21a0JE7v/OjKlCd8B/U2u/iWo=;
        b=AX1u+YykkuVTBhkenEsN4cgRdNzISMEEu+KAjEgDqjhLgBKxHbe+0HUVKeSxY61CqkCiTs
        LqIBKw+fkbu1APkYk6mFf0GRoQxj8VjTVGe3oDoGklvPCgWRofkybz7rsubGPOJosYJm0S
        czVCQFTypt3SLAkAAvmDOB1qRFd2xlc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-kloXe3lvPYGVg10AUgF8zw-1; Tue, 03 Nov 2020 02:20:06 -0500
X-MC-Unique: kloXe3lvPYGVg10AUgF8zw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C315F186DD29;
        Tue,  3 Nov 2020 07:20:05 +0000 (UTC)
Received: from work (unknown [10.40.194.49])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 0EC2721EC3;
        Tue,  3 Nov 2020 07:20:04 +0000 (UTC)
Date:   Tue, 3 Nov 2020 08:20:00 +0100
From:   Lukas Czerner <lczerner@redhat.com>
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] mke2fs: Escape double quotes when parsing mke2fs.conf
Message-ID: <20201103072000.yfdgqo7yro4bwx3b@work>
References: <20201102142631.87627-1-lczerner@redhat.com>
 <94DB7654-D529-499C-80F9-7ABF25FC3939@dilger.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <94DB7654-D529-499C-80F9-7ABF25FC3939@dilger.ca>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Nov 02, 2020 at 02:37:38PM -0700, Andreas Dilger wrote:
> On Nov 2, 2020, at 7:26 AM, Lukas Czerner <lczerner@redhat.com> wrote:
> > 
> > Currently, when constructing the <default> configuration pseudo-file using
> > the profile-to-c.awk script we will just pass the double quotes as they
> > appear in the mke2fs.conf.
> > 
> > This is problematic, because the resulting default_profile.c will either
> > fail to compile because of syntax error, or leave the resulting
> > configuration invalid.
> > 
> > It can be reproduced by adding the following line somewhere into
> > mke2fs.conf configuration and forcing mke2fs to use the <default>
> > configuration by specifying nonexistent mke2fs.conf
> > 
> > MKE2FS_CONFIG="nonexistent" ./misc/mke2fs -T ext4 /dev/device
> > 
> > default_mntopts = "acl,user_xattr"
> > ^ this will fail to compile
> > 
> > default_mntopts = ""
> > ^ this will result in invalid config file
> > 
> > Syntax error in mke2fs config file (<default>, line #4)
> >       Unknown code prof 17
> > 
> > Fix it by escaping the double quotes with a backslash in
> > profile-to-c.awk script.
> 
> What about using single quotes for this?  That avoids the need to escape
> the double quotes, and avoids significant issues (IMHO) when the number
> of escapes grows over time as they are swallowed by various levels of
> processing.

Hi Andreas,

I am not sure I understand what issues you have in mind. The way I see
it, the profile-to-c.awk is used just during compile time to generate a
mke2fs_default_profile string and that's consumed by mke2fs in the case
no external config file can be found. There is only one level, or am I
missing something ?

Regardless it is possible to use a single quote by changing the code in
parse_line(). However I don't think we can just stop supporting double
quotes since that would technically change the mke2fs.conf format so it
would not solve the problem.

Thanks
-Lukas

> 
> Cheers, Andreas
> 
> > 
> > Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> > ---
> > misc/profile-to-c.awk | 1 +
> > 1 file changed, 1 insertion(+)
> > 
> > diff --git a/misc/profile-to-c.awk b/misc/profile-to-c.awk
> > index f964efd6..814f7236 100644
> > --- a/misc/profile-to-c.awk
> > +++ b/misc/profile-to-c.awk
> > @@ -4,6 +4,7 @@ BEGIN {
> > }
> > 
> > {
> > +  gsub("\"","\\\"",$0);
> >   printf("  \"%s\\n\"\n", $0);
> > }
> > 
> > --
> > 2.26.2
> > 
> 
> 
> Cheers, Andreas
> 
> 
> 
> 
> 


