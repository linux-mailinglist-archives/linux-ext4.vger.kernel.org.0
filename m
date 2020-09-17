Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6977426E943
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Sep 2020 01:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725858AbgIQXI7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Sep 2020 19:08:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47392 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726004AbgIQXI7 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Sep 2020 19:08:59 -0400
X-Greylist: delayed 74755 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 19:08:58 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1600384138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uzfwQDrkfORvWeEWQ/DT80gvpbqXcqJubxjDGJKPNLI=;
        b=ZcKYikLqug1Id/n/rJB3efIgxGGK4oa8QtAKzr3EiB+dNHrJGT5dTO1xH7R1yVDe7uxZgJ
        MEQ9Z8s/ZOQpGh947XlqE0Bnb5dEbk/iAcHnElo2Vg7HYJ/X9+4Tro/bOGqBR6EkFhB1nf
        PbBmGLYQqgDrk+LalSbOEkOpdBF3GjA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-euwv-xhLMlWa5iZ5HdKl-w-1; Thu, 17 Sep 2020 19:08:56 -0400
X-MC-Unique: euwv-xhLMlWa5iZ5HdKl-w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C25F01882FB0;
        Thu, 17 Sep 2020 23:08:54 +0000 (UTC)
Received: from T590 (ovpn-12-51.pek2.redhat.com [10.72.12.51])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id C42D055769;
        Thu, 17 Sep 2020 23:08:46 +0000 (UTC)
Date:   Fri, 18 Sep 2020 07:08:42 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200917230842.GA1139137@T590>
References: <5140ba6c-779c-2a71-b7f2-3c3220cdf19c@kernel.dk>
 <68510957-c887-8e26-4a1a-a7a93488586a@kernel.dk>
 <20200904035528.GE558530@mit.edu>
 <20200915044519.GA38283@mit.edu>
 <20200915073303.GA754106@T590>
 <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590>
 <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590>
 <20200917143012.GF38283@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200917143012.GF38283@mit.edu>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 17, 2020 at 10:30:12AM -0400, Theodore Y. Ts'o wrote:
> On Thu, Sep 17, 2020 at 10:20:51AM +0800, Ming Lei wrote:
> > 
> > Obviously there is other more serious issue, since 568f27006577 is
> > completely reverted in your test, and you still see list corruption
> > issue.
> > 
> > So I'd suggest to find the big issue first. Once it is fixed, maybe
> > everything becomes fine.
> > ...
> > Looks it is more like a memory corruption issue, is there any helpful log
> > dumped when running kernel with kasan?
> 
> Last night, I ran six VM's using -rc4 with and without KASAN; without
> Kasan, half of them hung.  With KASAN enabled, all of the test VM's
> ran to completion.

From your last email, when you run -rc4 with revert of 568f27006577, you
can observe list corruption easily.

So can you enable KASAN on -rc4 with revert of 568f27006577 and see if
it makes a difference?

> 
> This strongly suggests whatever the problem is, it's timing related.
> I'll run a larger set of test runs to see if this pattern is confirmed
> today.

Looks you enable lots of other debug options, such a lockdep, which has
much much heavy runtime load. Maybe you can disable all non-KASAN debug
option(non-KASAN memory debug options, lockdep, ...) and keep KASAN
debug only and see if you are lucky.


Thanks, 
Ming

