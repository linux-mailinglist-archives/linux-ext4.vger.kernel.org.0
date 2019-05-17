Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72D1C21A9A
	for <lists+linux-ext4@lfdr.de>; Fri, 17 May 2019 17:34:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729279AbfEQPeL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 May 2019 11:34:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:40460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729270AbfEQPeK (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Fri, 17 May 2019 11:34:10 -0400
Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id CFB0321734;
        Fri, 17 May 2019 15:34:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1558107249;
        bh=hNUVgilqllPnNDxjKRyIezzzdxjmSkINzA0vwXyMx9c=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=yO0CcLnCVsCLrrQA6fVeGr8dFrIteCQKqUsQD9tn3Pgq4bQzw6RBY+EPAYmB9rDF7
         LI6+9KLjM3CWOmBU4ztpfh0ySdCRUgyw5vrhGSNkvcYepkh6tq2zl2shF8bO9ylukV
         CYWNHAlok2fNfynPzL4nyB0yP1ySnA1HT2VSDuhk=
Received: by mail-vs1-f42.google.com with SMTP id o5so4914040vsq.4;
        Fri, 17 May 2019 08:34:08 -0700 (PDT)
X-Gm-Message-State: APjAAAWDD+iQgw4bG8DcZ8cP3OCzKEIdk7aWMuux1ofvBY9MT1TkFCEO
        b0UXzNYTqSrGhWfaSmYWZCjF3JHOamXNGSB1soI=
X-Google-Smtp-Source: APXvYqxxkU8wSIZ4sxZSe6xWbFXzNxBo6Ovnjh9ieEPHyfTp0OqAPERFN9PESCfbwu+GcC0U2i+QVcWLX0wofwk8PTs=
X-Received: by 2002:a67:e891:: with SMTP id x17mr15519608vsn.206.1558107247942;
 Fri, 17 May 2019 08:34:07 -0700 (PDT)
MIME-Version: 1.0
References: <20190515150221.16647-1-fdmanana@kernel.org> <20190516092848.GA6975@mit.edu>
 <CAL3q7H7q5Xphhax3qPdt1fnjaWrekMgMKzKfDyOLm+bbgsw6Aw@mail.gmail.com>
 <20190516165921.GA4023@mit.edu> <CAL3q7H6gvdhSweJH1W7dbvOtwu8RmzbMRMb9MsSv0D8g+Cm40g@mail.gmail.com>
In-Reply-To: <CAL3q7H6gvdhSweJH1W7dbvOtwu8RmzbMRMb9MsSv0D8g+Cm40g@mail.gmail.com>
From:   Filipe Manana <fdmanana@kernel.org>
Date:   Fri, 17 May 2019 16:33:56 +0100
X-Gmail-Original-Message-ID: <CAL3q7H4C9+e6MZGYKgmGMZbwOvRgSJtN2vf7-9dCzmeUAsuYCg@mail.gmail.com>
Message-ID: <CAL3q7H4C9+e6MZGYKgmGMZbwOvRgSJtN2vf7-9dCzmeUAsuYCg@mail.gmail.com>
Subject: Re: [PATCH] fstests: generic, fsync fuzz tester with fsstress
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     fstests <fstests@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        linux-ext4 <linux-ext4@vger.kernel.org>, Jan Kara <jack@suse.cz>,
        Filipe Manana <fdmanana@suse.com>
Content-Type: multipart/mixed; boundary="0000000000000967a90589171db0"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--0000000000000967a90589171db0
Content-Type: text/plain; charset="UTF-8"

On Thu, May 16, 2019 at 6:18 PM Filipe Manana <fdmanana@kernel.org> wrote:
>
> On Thu, May 16, 2019 at 5:59 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > On Thu, May 16, 2019 at 10:54:57AM +0100, Filipe Manana wrote:
> > >
> > > Haven't tried ext4 with 1 process only (instead of 4), but I can try
> > > to see if it happens without concurrency as well.
> >
> > How many CPU's and how much memory were you using?  And I assume this
> > was using KVM/QEMU?  How was it configured?
>
> Yep, kvm and qemu (3.0.0). The qemu config:
>
> https://pastebin.com/KNigeXXq
>
> TEST_DEV is the drive with ID "drive1" and SCRATCH_DEV is the drive
> with ID "drive2".
>
> The host has:
>
> Intel(R) Core(TM) i7-8700 CPU @ 3.20GHz
> 64Gb of ram
> crappy seagate hdd:
>
> Device Model:     ST3000DM008-2DM166
> Serial Number:    Z5053T2R
> LU WWN Device Id: 5 000c50 0a46f7ecb
> Firmware Version: CC26
> User Capacity:    3,000,592,982,016 bytes [3,00 TB]
> Sector Sizes:     512 bytes logical, 4096 bytes physical
> Rotation Rate:    7200 rpm
> Form Factor:      3.5 inches
> Device is:        Not in smartctl database [for details use: -P showall]
> ATA Version is:   ACS-2, ACS-3 T13/2161-D revision 3b
> SATA Version is:  SATA 3.1, 6.0 Gb/s (current: 6.0 Gb/s)
>
> It hosts 3 qemu instances, all with the same configuration.
>
> I left the test running earlier today for about 1 hour on ext4 with
> only 1 fsstress process. Didn't manage to reproduce.
> With 4 or more processes, those journal checksum failures happen sporadically.
> I can leave it running with 1 process during this evening and see what
> we get here, if it happens with 1 process, it should be trivial to
> reproduce anywhere.

Ok, so I left it running overnight, for 17 000+ iterations. It failed
102 times with that journal corruption.
I changed the test to randomize the number of fsstress processes
between 1 to 8. I'm attaching here the logs (.full, .out.bad and dmesg
files) in case you are interested in the seed values for fsstress.

So the test does now:

(...)
procs=$(( (RANDOM % 8) + 1 ))
args=`_scale_fsstress_args -p $procs -n 100 $FSSTRESS_AVOID -d
$SCRATCH_MNT/test`
args="$args -f mknod=0 -f symlink=0"
echo "Running fsstress with arguments: $args" >>$seqres.full
(...)

I verified no failures happened with only 1 process, and the more
processes are used, the more likely it is to hit the issue:

$ egrep -r 'Running fsstress with arguments: -p' . | cut -d ' ' -f 6 |
perl -n -e 'use Statistics::Histogram; @data = <>; chomp @data; print
get_histogram(\@data);'
Count: 102
Range:  2.000 -  8.000; Mean:  5.598; Median:  6.000; Stddev:  1.831
Percentiles:  90th:  8.000; 95th:  8.000; 99th:  8.000
   2.000 -    2.348:     5 ##############
   2.348 -    3.171:    13 ####################################
   3.171 -    4.196:    12 #################################
   4.196 -    5.473:    15 ##########################################
   5.473 -    6.225:    19 #####################################################
   6.225 -    7.064:    19 #####################################################
   7.064 -    8.000:    19 #####################################################

And verified picking one of the failing seeds, such as 1557322233 for
2 processes, and running the test with that seed for 10 times didn't
reproduce, so it indeed seems to be some race causing the journal
corruption.

Forgot previously, but my kernel config in case it helps:
https://pastebin.com/LKvRcAW1

Thanks.

>
> >
> > Thanks,
> >
> >                                         - Ted

--0000000000000967a90589171db0
Content-Type: application/x-xz; name="ext4_generic_547_logs.tar.xz"
Content-Disposition: attachment; filename="ext4_generic_547_logs.tar.xz"
Content-Transfer-Encoding: base64
Content-ID: <f_jvs88zcj0>
X-Attachment-Id: f_jvs88zcj0

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
WVo=
--0000000000000967a90589171db0--
