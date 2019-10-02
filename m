Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 24554C92B8
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Oct 2019 22:00:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbfJBUAD (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Oct 2019 16:00:03 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:55112 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726069AbfJBUAD (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Oct 2019 16:00:03 -0400
Received: from callcc.thunk.org (guestnat-104-133-0-98.corp.google.com [104.133.0.98] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x92JxtwW029285
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 2 Oct 2019 15:59:57 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 68A4C42088C; Wed,  2 Oct 2019 15:59:55 -0400 (EDT)
Date:   Wed, 2 Oct 2019 15:59:55 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     "A. Wilcox" <awilfox@adelielinux.org>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: t_ext_jnl_rm test takes 96 seconds to finish
Message-ID: <20191002195955.GC777@mit.edu>
References: <6f6b5895-12f3-bc3d-f50c-1de0886f41c3@adelielinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6f6b5895-12f3-bc3d-f50c-1de0886f41c3@adelielinux.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Oct 02, 2019 at 01:16:51PM -0500, A. Wilcox wrote:
> Hello there,
> 
> While building e2fsprogs 1.45.4, I noticed the following output during
> testing:
> 
> t_ext_jnl_rm: remove missing external journal device: ok
> t_ext_jnl_rm:  *** took 96 seconds to finish ***
> t_ext_jnl_rm:  consider adding t_ext_jnl_rm/is_slow_test
> 
> I didn't see any mention of this in the list archives, and I'm not
> entirely sure if it should really be marked as a slow test.
> 
> System is a 64-thread POWER9 @ 3.8 GHz with DDR4-2400 RAM, so it isn't
> exactly a "low end" machine.

The first time I ran this test, it took 20 seconds.  (And that was
only because I had a WDC external SSD attached to my laptop and it
took time to spin it up; more on that below.)  The next time, it was
nearly instaneous:

% time ./test_script t_ext_jnl_rm
t_ext_jnl_rm: remove missing external journal device: ok
356 tests succeeded  0 tests failed

real	  0m0.242s
user	  0m0.053s
sys	  0m0.114s

If you look at the test script, you'll see that we are creating a file
system, setting up an external journal which doesn't exist:

    dd if=/dev/zero of=$TMPFILE bs=1k count=512 > /dev/null 2>&1

    echo mke2fs -q -F -o Linux -b 1024 $TMPFILE >> $OUT
    $MKE2FS -q -F -o Linux -I 128 -b 1024 $TMPFILE >> $OUT 2>&1

    echo "debugfs add journal device/UUID" >> $OUT
    $DEBUGFS -w -f - $TMPFILE <<- EOF >> $OUT 2>&1
    	feature has_journal
    	ssv journal_dev 0x9999
    	ssv journal_uuid 1db3f677-6832-4adb-bafc-8e4059c30a33
    EOF

... and then we ask tune2fs to remove the journal:

    echo "tune2fs -f -O ^has_journal $TMPFILE" >> $OUT
    $TUNE2FS -f -O ^has_journal $TMPFILE >> $OUT 2>&1

So the time that it takes is based on how long it takes to search all
of the disks attached to the system looking for an external journal
with the uuid 1db3f677-6832-4adb-bafc-8e4059c30a33.

On most systems, this is fast.  If you happen to have a slow device
attached to your system, then this can take a while --- but there's
really not much we can do about this.  I suppose we could try to add a
test mock which disables the external journal search, if there isn't
any way you can speed things up on your end now that you know what's
causing the delay?

						- Ted
