Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC35E12AD37
	for <lists+linux-ext4@lfdr.de>; Thu, 26 Dec 2019 16:31:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726450AbfLZPbb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 26 Dec 2019 10:31:31 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:44937 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726236AbfLZPbb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 26 Dec 2019 10:31:31 -0500
Received: from callcc.thunk.org (96-72-84-49-static.hfc.comcastbusiness.net [96.72.84.49] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xBQFVITQ021452
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 26 Dec 2019 10:31:20 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 65041420485; Thu, 26 Dec 2019 10:31:18 -0500 (EST)
Date:   Thu, 26 Dec 2019 10:31:18 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Cc:     joseph.qi@linux.alibaba.com, Liu Bo <bo.liu@linux.alibaba.com>
Subject: Discussion: is it time to remove dioread_nolock?
Message-ID: <20191226153118.GA17237@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

With inclusion of Ritesh's inode lock scalability patches[1], the
traditional performance reasons for dioread_nolock --- namely,
removing the need to take an exclusive lock for Direct I/O read
operations --- has been removed.

[1] https://lore.kernel.org/r/20191212055557.11151-1-riteshh@linux.ibm.com

So... is it time to remove the code which supports dioread_nolock?
Doing so would simplify the code base, and reduce the test matrix.
This would also make it easier to restructure the write path when
allocating blocks so that the extent tree is updated after writing out
the data blocks, by clearing away the underbrush of dioread nolock
first.

If we do this, we'd leave the dioread_nolock mount option for
backwards compatibility, but it would be a no-op and not actually do
anything.

Any objections before I look into ripping out dioread_nolock?

The one possible concern that I considered was for Alibaba, which was
doing something interesting with dioread_nolock plus nodelalloc.  But
looking at Liu Bo's explanation[2], I believe that their workload
would be satisfied simply by using the standard ext4 mount options
(that is, the default mode has the performance benefits when doing
parallel DIO reads, and so the need for nodelalloc to mitigate the
tail latency concerns which Alibaba was seeing in their workload would
not be needed).  Could Liu or someone from Alibaba confirm, perhaps
with some benchmarks using their workload?

[2] https://lore.kernel.org/linux-ext4/20181121013035.ab4xp7evjyschecy@US-160370MP2.local/

    	  	     	      	   	- Ted


