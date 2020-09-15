Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B34A269FD2
	for <lists+linux-ext4@lfdr.de>; Tue, 15 Sep 2020 09:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbgIOHdb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 15 Sep 2020 03:33:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46098 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726087AbgIOHdW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 15 Sep 2020 03:33:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600155201;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NuL3Yd8/YXcGgFrD3H7Mh6oQlLO0y8IzzOlQqEaeDeQ=;
        b=duTA9Xg2iPl65Jugi5uv8MXTyEHtNr8O0UgpLeKvrix0ylYiO+xsZ69hcAjTSE1Y7pGiOD
        KiL7rCkBc2SpeuQDSy0O6bk9W80YKbGJHww1J6PPTX89luwnIBT0LFU/naUeagtm/cGOJU
        rSd2wUI8MsxJRAdj2Z3POj13/QRNLSs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-387-9MikSqX5MaGF-B7lPqIxig-1; Tue, 15 Sep 2020 03:33:17 -0400
X-MC-Unique: 9MikSqX5MaGF-B7lPqIxig-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 8C4CB10199AA;
        Tue, 15 Sep 2020 07:33:15 +0000 (UTC)
Received: from T590 (ovpn-12-38.pek2.redhat.com [10.72.12.38])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9675060E1C;
        Tue, 15 Sep 2020 07:33:08 +0000 (UTC)
Date:   Tue, 15 Sep 2020 15:33:03 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200915073303.GA754106@T590>
References: <990cc101-d4a1-f346-fe78-0fb5b963b406@kernel.dk>
 <20c844c8-b649-3250-ff5b-b7420f72ff38@kernel.dk>
 <20200822143326.GC199705@mit.edu>
 <aff250ad-4c31-15c2-fa1d-3f3945cb7aa5@kernel.dk>
 <7f0e2d99-5da2-237e-a894-0afddc0ace1e@kernel.dk>
 <049a97db-c362-bcfb-59e5-4b1d2df59383@kernel.dk>
 <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
 <20200904035528.GE558530@mit.edu>
 <20200915044519.GA38283@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200915044519.GA38283@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Theodore,

On Tue, Sep 15, 2020 at 12:45:19AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Sep 03, 2020 at 11:55:28PM -0400, Theodore Y. Ts'o wrote:
> > Worse, right now, -rc1 and -rc2 is causing random crashes in my
> > gce-xfstests framework.  Sometimes it happens before we've run even a
> > single xfstests; sometimes it happens after we have successfully
> > completed all of the tests, and we're doing a shutdown of the VM under
> > test.  Other times it happens in the middle of a test run.  Given that
> > I'm seeing this at -rc1, which is before my late ext4 pull request to
> > Linus, it's probably not an ext4 related bug.  But it also means that
> > I'm partially blind in terms of my kernel testing at the moment.  So I
> > can't even tell Linus that I've run lots of tests and I'm 100%
> > confident your one-line change is 100% safe.
> 
> I was finally able to bisect it down to the commit:
> 
> 37f4a24c2469: blk-mq: centralise related handling into blk_mq_get_driver_tag

37f4a24c2469 has been reverted in:

	4e2f62e566b5 Revert "blk-mq: put driver tag when this request is completed"

And later the patch is committed as the following after being fixed:

	568f27006577 blk-mq: centralise related handling into blk_mq_get_driver_tag

So can you reproduce the issue by running kernel of commit 568f27006577?
If yes, can the issue be fixed by reverting 568f27006577?

> 
> (See below for [1] Bisect log.)
> 
> The previous commit allows the tests to run to completion.  With
> commit 37f4a24c2469 and later all 11 test scenarios (4k blocks, 1k
> blocks, ext3 compat, ext4 w/ fscrypt, nojournal mode, data=journal,
> bigalloc, etc.) the VM will get stuck.

Can you share the exact mount command line for setup the environment?
and the exact xfstest item?



Thanks,
Ming

