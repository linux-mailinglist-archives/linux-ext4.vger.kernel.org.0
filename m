Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A59B2476FC
	for <lists+linux-ext4@lfdr.de>; Mon, 17 Aug 2020 21:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729961AbgHQTnw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 17 Aug 2020 15:43:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49778 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729540AbgHQTnv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 17 Aug 2020 15:43:51 -0400
Received: from callcc.thunk.org (pool-108-49-65-20.bstnma.fios.verizon.net [108.49.65.20])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 07HJhiHt008517
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 17 Aug 2020 15:43:45 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id A6F21420DC0; Mon, 17 Aug 2020 15:43:44 -0400 (EDT)
Date:   Mon, 17 Aug 2020 15:43:44 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     =?iso-8859-1?Q?Rog=E9rio?= Brito <rbrito@ime.usp.br>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: Generic questions about ext4
Message-ID: <20200817194344.GA6755@mit.edu>
References: <CAOtrxKPMpNh7MZ2wX2wxju15rrY9rzrjNAwFneyAwCy2Z7DVMQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOtrxKPMpNh7MZ2wX2wxju15rrY9rzrjNAwFneyAwCy2Z7DVMQ@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Aug 17, 2020 at 03:54:29AM +0000, Rogério Brito wrote:
> Dear developers,
> 
> I have been using ext4 for quite some time and I have some ext4
> filesystems that led me to some questions.
> 
> I have at least 2 "large" filesystems (with 2TB each, both almost
> full) dating back from 2011 and 2010. I believe that I even converted
> one of them from ext3 to ext4, but my memory is not that clear after
> almost a decade. As such, they were created without some useful
> features that are useful nowadays, like inline files. With that in
> mind, here are some questions:
> 
> 1 - I know that some features can be enabled with tune2fs, but, in
> particular, inline files don't seem to be. I've seen some people
> indicate that using debugfs, I can mark the superblock as having
> support for it. Would that really work? I don't plan on booting old
> kernels. One of those filesystems is running on an armel device that
> is quite slow and I would really like to avoid copying all the files
> to an external HD, recreating the filesystem and, then, copying back
> the files to the system.

Inline data is not enabled by default, because there are still a few
corner cases that will cause stress tests to fail.  So it's not
something I'd encourage enabling; it doesn't make that much difference
unless your workload creates huge numbers of small (< ~100 bytes)
files.  If you do create lots of small files, but then don't attempt
to append to them, or truncate them, etc., later., inline_data will
work, but it's likely that the presence or absence of inline_data
probably won't make that much difference to your application, unless
you're doing something super unusual.

> 2 - Is there any way to get transparent compression with ext4? That
> would really, really rock and is, perhaps, one of the features that
> some users like me would greatly benefit from.

No, transparent compression is not a feature ext4 has.  There has been
some thinking about creating a read-only compression feature,
primarily to speed up reading from slow devices, but full transparent
compression where users might want to seek to the middle of a
transparently compressioned file, and then writing into the middle of
said file, and making sure this is reliable even in the face of a
crash in the middle of doing such an update, etc., is something that
would be a large amount of work, for relatively little benefit, and so
I'd be surprised if that were ever to be supported in ext4.

Read-only compressed files is something that might happen at some
point, but while we have a design sketched out for it, no one is
currently actively working on that feature.

Cheers,

					- Ted
