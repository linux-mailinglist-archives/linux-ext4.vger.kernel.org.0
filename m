Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 539942811EA
	for <lists+linux-ext4@lfdr.de>; Fri,  2 Oct 2020 14:02:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387412AbgJBMCK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 2 Oct 2020 08:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:40139 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726090AbgJBMCK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 2 Oct 2020 08:02:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601640128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+cnau3/HRGjXSqdC1+Ui9/MqGPNClEPXShJ/UzO4bhU=;
        b=FshSqCcql1eO4YAZxpci0VrR5dHvGTO0iqq8y5Hi3oDCBXqOnFNkM6ONNvS0hvOR6Tsdly
        9mD/fVXzug7qsDpAgCfIGBd48v5+c+WtoTmzOPxzh/b2LQWpcV8xehdwYjOkcXy+4i0UYy
        rmD5Yml3y/dN+ZiS+CeeqA0JqOjrKIw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-ufDwdzQnPKONofOCLboBSw-1; Fri, 02 Oct 2020 08:02:05 -0400
X-MC-Unique: ufDwdzQnPKONofOCLboBSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98BD864082;
        Fri,  2 Oct 2020 12:02:03 +0000 (UTC)
Received: from work (unknown [10.40.192.137])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id DB62A19C78;
        Fri,  2 Oct 2020 12:02:02 +0000 (UTC)
Date:   Fri, 2 Oct 2020 14:01:58 +0200
From:   Lukas Czerner <lczerner@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: State of dump utility
Message-ID: <20201002120158.uyyx3cg5gdeoe665@work>
References: <20200929143713.ttu2vvhq22ulslwf@work>
 <20200930020646.GD23474@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200930020646.GD23474@mit.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Sep 29, 2020 at 10:06:46PM -0400, Theodore Y. Ts'o wrote:
> On Tue, Sep 29, 2020 at 04:37:13PM +0200, Lukas Czerner wrote:
> > 
> > lately we've had couple of bugs against dump utility and a after a quick
> > look at the code I realized that it is very much outdated at least on
> > the extN side of things and would need some work and attention to make it
> > work reliably with modern ext4 features.
> > 
> > However the code has been neglected for a while and talking to the
> > maintainer he is pretty much done with it. At this point I am ready to
> > pull the plug on dump/restore in Fedora, but before I do I was wondering
> > whether there is any interest in moving dump/restore, or part of it, into
> > e2fsprogs ?
> > 
> > I have not looked at the code close enought to say whether it's worth it
> > or whether it would be better to write something from scratch. There is
> > also a question about what to do with the tape code - that's not
> > something I have any interest in digging into.
> > 
> > In my eyes dump had a good run and I would be happy just dumping it, but
> > it is worth asking here on the list. Is there anyone interested in
> > maintaining dump/restore, or is there interest in or objections agains
> > merging it into e2fsprogs ?
> 
> One of the interesting questions is how reliable the dump utility
> really is; that's because it works by reading the metadata directly
> --- while the file system is mounted.  So it's quite possible for the
> metadata to be changing out from under the dump/restore process.
> Especially with metadata checksums, I suspect dump/restore is going
> much more unreliable in terms of the libext2fs returning checksum
> failures.

Hi Ted,

this is a very good point. I have not even thought about checksums, but
that is just one example where it is likely to fail miserably. Granted
that's a relatively new feature, as well as inline data however it can't
even handle uninitialized extents correctly and hardly anyone is
noticing.

> 
> In the future, if we ever try to bypass the use of the buffer cache,
> and instead have jbd2 write out directly to the bio layer so we cant
> get better write error codes.  There was a discussion about this
> recently, and there are two problems.  First, we need to worry about
> programs like tune2fs and e2label that need to be able to read and
> modify the superblock while the file system is modified.  We'd want to
> add ioctl's to set and get the superblock, and update e2fsprogs to try
> to use those system calls first.  And then.... there is dump/restore.i
> 
> I could imagine adding ioctl's which allow safe read-only access to
> all metadata blocks, and not just for the superblock.  The question,
> though is... is it worth it, especially if it's only to make
> dump/restore work?

I have a feeling that the answer is no, it's not worth it for
dump/restore alone.

> 
> On the other hand, if we want to try to implement some kind of on-line
> fsck work, then -perhaps safe metadata reading would be part of that
> interface.  So I'd never say never, but I do wonder if it's time to
> pull the plug on dump/restore --- especially if we want to allow it to
> support not just inline files/directories, but also things like
> extended attributes and ACL's.
> 
> 						- Ted
> 

Thanks Ted, you made some good points and while there are some good
ideas for the future, there is no place for dump there. I think we're in
agreement to pull the plug on dump.

Thanks!
-Lukas

