Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 61155278198
	for <lists+linux-ext4@lfdr.de>; Fri, 25 Sep 2020 09:32:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727392AbgIYHcG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 25 Sep 2020 03:32:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:20417 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727238AbgIYHcG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 25 Sep 2020 03:32:06 -0400
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1601019125;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OAW0t8KRUC4c7xqD0bS+SqinnFap8rpYlqZ1QIeslGs=;
        b=h6C/9OX81qxbSAfqnzqgaqeUhELpLdUW5jAM7xpycRySgOLULe0Jf2wTqJJgKdBzrzTsU6
        yQypINw0WPVGM4pp5JtpqyXPLUfz3c/6A/cEPE5NXicD9FZtX949KUBl5UJiO5Wmpazg1Y
        npJTOcvjsd4Ljqq78stq+2M94iUhwZc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-259-f8TCAxi5Ni-7JRU_QYwxdg-1; Fri, 25 Sep 2020 03:32:00 -0400
X-MC-Unique: f8TCAxi5Ni-7JRU_QYwxdg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A47B11DE1B;
        Fri, 25 Sep 2020 07:31:58 +0000 (UTC)
Received: from T590 (ovpn-12-168.pek2.redhat.com [10.72.12.168])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D1E4B1A918;
        Fri, 25 Sep 2020 07:31:49 +0000 (UTC)
Date:   Fri, 25 Sep 2020 15:31:45 +0800
From:   Ming Lei <ming.lei@redhat.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-ext4@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-block@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org
Subject: Re: REGRESSION: 37f4a24c2469: blk-mq: centralise related handling
 into blk_mq_get_driver_tag
Message-ID: <20200925073145.GC2388140@T590>
References: <20200915044519.GA38283@mit.edu>
 <20200915073303.GA754106@T590>
 <20200915224541.GB38283@mit.edu>
 <20200915230941.GA791425@T590>
 <20200916202026.GC38283@mit.edu>
 <20200917022051.GA1004828@T590>
 <20200917143012.GF38283@mit.edu>
 <20200924005901.GB1806978@T590>
 <20200924143345.GD482521@mit.edu>
 <20200925011311.GJ482521@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200925011311.GJ482521@mit.edu>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 24, 2020 at 09:13:11PM -0400, Theodore Y. Ts'o wrote:
> On Thu, Sep 24, 2020 at 10:33:45AM -0400, Theodore Y. Ts'o wrote:
> > HOWEVER, thanks to a hint from a colleague at $WORK, and realizing
> > that one of the stack traces had virtio balloon in the trace, I
> > realized that when I switched the GCE VM type from e1-standard-2 to
> > n1-standard-2 (where e1 VM's are cheaper because they use
> > virtio-balloon to better manage host OS memory utilization), problem
> > has become, much, *much* rarer (and possibly has gone away, although
> > I'm going to want to run a lot more tests before I say that
> > conclusively) on my test setup.  At the very least, using an n1 VM
> > (which doesn't have virtio-balloon enabled in the hypervisor) is
> > enough to unblock ext4 development.
> 
> .... and I spoke too soon.  A number of runs using -rc6 are now
> failing even with the n1-standard-2 VM, so virtio-ballon may not be an
> indicator.
> 
> This is why debugging this is frustrating; it is very much a heisenbug
> --- although 5.8 seems to work completely reliably, as does commits
> before 37f4a24c2469.  Anything after that point will show random
> failures.  :-(

It does not make sense to mention 37f4a24c2469, which is reverted in
4e2f62e566b5. Later the patch in 37f4a24c2469 is fixed and re-commited
as 568f27006577.

However, I can _not_ reproduce the issue by running the same test on
kernel built from 568f27006577 directly.

Also you have confirmed that the issue can't be fixed after reverting
568f27006577 against v5.9-rc4.

Looks the real issue(slab list corruption) should be introduced between
568f27006577 and v5.9-rc4.


thanks,
Ming

