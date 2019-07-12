Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 68AED675E5
	for <lists+linux-ext4@lfdr.de>; Fri, 12 Jul 2019 22:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727550AbfGLU2m (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 12 Jul 2019 16:28:42 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:58003 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727118AbfGLU2m (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Jul 2019 16:28:42 -0400
Received: from callcc.thunk.org (guestnat-104-133-8-97.corp.google.com [104.133.8.97] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6CKSSL6001248
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 Jul 2019 16:28:29 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id DEDDE420036; Fri, 12 Jul 2019 16:28:27 -0400 (EDT)
Date:   Fri, 12 Jul 2019 16:28:27 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Thomas Walker <Thomas.Walker@twosigma.com>
Cc:     Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>,
        "'Jan Kara'" <jack@suse.cz>,
        "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: Re: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Message-ID: <20190712202827.GA16730@mit.edu>
References: <9abbdde6145a4887a8d32c65974f7832@exmbdft5.ad.twosigma.com>
 <20181108184722.GB27852@magnolia>
 <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com>
 <20190626151754.GA2789@twosigma.com>
 <20190711092315.GA10473@quack2.suse.cz>
 <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
 <20190711171046.GA13966@mit.edu>
 <20190712191903.GP2772@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712191903.GP2772@twosigma.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Jul 12, 2019 at 03:19:03PM -0400, Thomas Walker wrote:
> Clearing orphaned inode 1048838 (uid=0, gid=4, mode=0100640, size=39006841856)

> Of particular note, ino 1048838 matches the size of the space that we "lost".

Hmmm... what's gid 4?  Is that a hint of where the inode might have come from?

Can you try the this experiment of e2image... e2fsck, but add a "cp
--sparse" of the e2i file between the e2image and e2fsck step?  Then
when you can identify the inode that has the huge amount of the
orphaned space, try grab the first couple of blocks, and then run
"file" on the first part of the file, which might help you identify
where the file came from.  Is it an ISO file?  etc.

The goal is to come up with a repeatable way of forcing the failure,
so we can understand the root cause of the "lost space".  The fact
that it's an orphaned inode means that something was hanging onto the
inode.  The question is what part of the kernel was keeping the ref
count elevated.

Thanks,

						- Ted
