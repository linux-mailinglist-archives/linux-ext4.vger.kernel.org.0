Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4643B25E769
	for <lists+linux-ext4@lfdr.de>; Sat,  5 Sep 2020 14:11:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728486AbgIEML2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 5 Sep 2020 08:11:28 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:52627 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726597AbgIEML1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 5 Sep 2020 08:11:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1599307885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=0HJzFO7pAp71wK9aXPM9q5yt4bMuyYKdTaYajwPv7ro=;
        b=USetTins5hZ9/jwekFv3Sf43shqw3jqIYOaieFj3O01aWOl8CA3DNDtX5/iFcRXaG+Eeba
        zCXvi38etgQlp+82mUpvedCw7Rk6mN+jnOfeCdIeEVGn2UR0nV5Hdw/+9MnQlJju0Y5EXO
        qw8/Q8QNri40q5mdPj6EXqne0OVfeGk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-zs11oeW0P32FFs86Hfex0w-1; Sat, 05 Sep 2020 08:11:21 -0400
X-MC-Unique: zs11oeW0P32FFs86Hfex0w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 106EB10054B0;
        Sat,  5 Sep 2020 12:11:18 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 60FAC7FB92;
        Sat,  5 Sep 2020 12:11:14 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 085CBDc6012762;
        Sat, 5 Sep 2020 08:11:13 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 085CBBbB012758;
        Sat, 5 Sep 2020 08:11:11 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Sat, 5 Sep 2020 08:11:11 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Dave Chinner <dchinner@redhat.com>
cc:     Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: make misbehavior on ext2 in dax mode (was: a crash when running
 strace from persistent memory)
In-Reply-To: <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2009050805250.12419@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com> <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On Fri, 4 Sep 2020, Mikulas Patocka wrote:

> Hmm, so I've found another bug in dax mode.
> 
> If you extract the Linux kernel tree on dax-based ext2 filesystem (use the 
> real ext2 driver, not ext4), and then you run make twice, the second 
> invocation will rebuild everything. It seems like a problem with 
> timestamps.
> 
> mount -t ext2 -o dax /dev/pmem0 /mnt/ext2/
> cd /mnt/ext2/usr/src/git/linux-2.6
> make clean
> make -j12
> make -j12	<--- this rebuilds the whole tree, althought it shouldn't
> 
> I wasn't able to bisect it because this bug seems to be present in every 
> kernel I tried (back to 4.16.0). Ext4 doesn't seem to have this bug.
> 
> Mikulas

I've found out the root cause for this bug (XFS has it too) and I'm 
sending patches.

Mikulas

