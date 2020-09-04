Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DABE25DFAE
	for <lists+linux-ext4@lfdr.de>; Fri,  4 Sep 2020 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726196AbgIDQVm (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 4 Sep 2020 12:21:42 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:53231 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726135AbgIDQVl (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 4 Sep 2020 12:21:41 -0400
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-218-rbseevaSOzmvEljWHFsisw-1; Fri, 04 Sep 2020 12:21:36 -0400
X-MC-Unique: rbseevaSOzmvEljWHFsisw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6AE1F189E621;
        Fri,  4 Sep 2020 16:21:34 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (file01.intranet.prod.int.rdu2.redhat.com [10.11.5.7])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id E453E7E40A;
        Fri,  4 Sep 2020 16:21:30 +0000 (UTC)
Received: from file01.intranet.prod.int.rdu2.redhat.com (localhost [127.0.0.1])
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4) with ESMTP id 084GLUdx030258;
        Fri, 4 Sep 2020 12:21:30 -0400
Received: from localhost (mpatocka@localhost)
        by file01.intranet.prod.int.rdu2.redhat.com (8.14.4/8.14.4/Submit) with ESMTP id 084GLTGx030254;
        Fri, 4 Sep 2020 12:21:29 -0400
X-Authentication-Warning: file01.intranet.prod.int.rdu2.redhat.com: mpatocka owned process doing -bs
Date:   Fri, 4 Sep 2020 12:21:29 -0400 (EDT)
From:   Mikulas Patocka <mpatocka@redhat.com>
X-X-Sender: mpatocka@file01.intranet.prod.int.rdu2.redhat.com
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     Jann Horn <jannh@google.com>, Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>,
        Kirill Shutemov <kirill@shutemov.name>,
        Jan Kara <jack@suse.cz>, "Theodore Ts'o" <tytso@mit.edu>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Dan Williams <dan.j.williams@intel.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-ext4@vger.kernel.org
Subject: make misbehavior on ext2 in dax mode (was: a crash when running
 strace from persistent memory)
In-Reply-To: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <alpine.LRH.2.02.2009041200570.27312@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.2009031328040.6929@file01.intranet.prod.int.rdu2.redhat.com>
User-Agent: Alpine 2.02 (LRH 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



On Thu, 3 Sep 2020, Mikulas Patocka wrote:

> Hi
> 
> There's a bug when you run strace from dax-based filesystem.

Hmm, so I've found another bug in dax mode.

If you extract the Linux kernel tree on dax-based ext2 filesystem (use the 
real ext2 driver, not ext4), and then you run make twice, the second 
invocation will rebuild everything. It seems like a problem with 
timestamps.

mount -t ext2 -o dax /dev/pmem0 /mnt/ext2/
cd /mnt/ext2/usr/src/git/linux-2.6
make clean
make -j12
make -j12	<--- this rebuilds the whole tree, althought it shouldn't

I wasn't able to bisect it because this bug seems to be present in every 
kernel I tried (back to 4.16.0). Ext4 doesn't seem to have this bug.

Mikulas

