Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C039324449
	for <lists+linux-ext4@lfdr.de>; Wed, 24 Feb 2021 20:04:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbhBXTBb (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 24 Feb 2021 14:01:31 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:46021 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234283AbhBXTAE (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Wed, 24 Feb 2021 14:00:04 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.west.internal (Postfix) with ESMTP id D42B99A7;
        Wed, 24 Feb 2021 13:58:49 -0500 (EST)
Received: from imap8 ([10.202.2.58])
  by compute2.internal (MEProxy); Wed, 24 Feb 2021 13:58:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tinfoilwizard.net; h=mime-version:message-id:in-reply-to
        :references:date:from:to:cc:subject:content-type; s=fm1; bh=jDPP
        t8Zx5oHOrmdRFjLc8zcXqkd4fOlNS44JO/VE2b8=; b=Mzp3JluOu5aB4gFUQq7D
        Q+DowJVBigsMy0K9V7DdUKXn6gST3PRhonXpNjRNoXaswIgKJMm0rJTWwOHQDGrB
        1xHQc82q04Qbi7NMrRrZ4akoqGBBzDjviwFdd0FVnbnqf8Zs0snLRKCjNRE8s53t
        2j4yruZofAW7/QQBtXyvE11NcNOhanJRvIbQhfmuHIEW2IeNICzWCCbAxx70wvpY
        FxyA8j4e4Urn5mamXDwzzHsTWAjUkmrJlhcNivxb/hp2cSCbQvG/Oe47vBmf5eV7
        WTMLil0iry8c8y8ZERzDd1KUXXpvEAGan8p3/Xg/IXPgefMOMUPDy8+pIHwIVhHg
        6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=jDPPt8
        Zx5oHOrmdRFjLc8zcXqkd4fOlNS44JO/VE2b8=; b=w1QkzNuxOEybnQW9LHY+4d
        42a1Sk0CmQh0ebVsssHd3mSyGgsZkk9c4FZZjij+wOEz3+bgPITKMzy3cd1WwrN7
        06ZkazFyKu68Md/LIUXpf5BYAvYAfHV4Vpr7LwhmEFr+hWHkITttDxGi+JQATQBI
        EAimTOTMBpufwoYLTEOWtzQ4QhbOu91rLavqi2PU36crq7nnddigG3zFBsRpEZSD
        bvdSrbByr24aYGSWal4pWD0cEJZqRD/93EhsV2u6Vwk5udJblN4/ILFbPk5tCpHS
        sm0I41vSYPdBw3utJ/37WgFyhefYteD/ktlIO1yCM3Pcr3eN1dCMUFG5X9Xfvi3w
        ==
X-ME-Sender: <xms:6aE2YA2oVqWeQkiaNhne5KorZM5wRx1wrO2SGNmxkFeKkF1_oycMOA>
    <xme:6aE2YLFX07ojJ2kHgLbe-IagSF7smnpiLs1EU0Zd0BD-YPwJSl1VFTnXQOAPmmmtE
    nsSL21DwGQrEUh06w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrkeejgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtsehttd
    ertderredtnecuhfhrohhmpedfufgvrghmuhhsucevohhnnhhorhdfuceoshgvrghmuhhs
    sehtihhnfhhoihhlfihiiigrrhgurdhnvghtqeenucggtffrrghtthgvrhhnpeeitefhve
    dtkeekieekudeuffevkeehlefgueelvedtkefgkefgieffveefvdehveenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsvggrmhhushesthhinh
    hfohhilhifihiirghrugdrnhgvth
X-ME-Proxy: <xmx:6aE2YI60UbmXmAEfnQBR3hgO65gIYyvkNe7BO4isbdbxh_7zi3fu8w>
    <xmx:6aE2YJ3gzCuvmalJR-3cwF7NRxM4naM0EfntpAfOhE4LUc_NvK8KOQ>
    <xmx:6aE2YDF1CCv6krB3UpCLDZVT78pGPNUa0jCCNkY00B0eUOwAt3Qsaw>
    <xmx:6aE2YKxvDmSfUBwSTf47urgoYVamTDPpMRndyRj7UMEgelRmRWvC1g>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 1EAA53A00DC; Wed, 24 Feb 2021 13:58:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-141-gf094924a34-fm-20210210.001-gf094924a
Mime-Version: 1.0
Message-Id: <43801f2e-a2e5-4035-9757-930ea7dc1757@www.fastmail.com>
In-Reply-To: <YDZoaacIYStFQT8g@mit.edu>
References: <dccc26c4-19be-4f07-a593-bec842500d09@www.fastmail.com>
 <YDZoaacIYStFQT8g@mit.edu>
Date:   Wed, 24 Feb 2021 10:58:27 -0800
From:   "Seamus Connor" <seamus@tinfoilwizard.net>
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: reproducible corruption in journal
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

> *) It appears that your test is generating a large number of very
> small transactions, and you are then "crashing" the file system by
> disconnecting the file system from further updates, and running e2fsck
> to replay the journal, throwing away the block writes after the
> "disconnection", and then remounting the file system.  I'm going to
> further guess that size of the small transactions are very similar,
> and the amount of time between when the file system is mounted, and
> when the file system is forcibly disconnected, is highly predictable
> (e.g., always N seconds, plus or minus a small delta).

Yes, this matches the workload. I assume the transactions are very small 
because we are doing a large number of metadata operations, and 
because we are mounted sync?

> 
> Is that last point correct?  If so, that's a perfect storm where it's
> possible for the journal replay to get confused, and mistake previous
> blocks in the journal as ones part of the last valid file system
> mount.  It's something which probably never happens in practice in
> production, since users are generally not running a super-fixed
> workload, and then causing the system to repeatedly crash after a
> fixed interval, such that the mistake described above could happen.
> That being said, it's arguably still a bug.
> 
> Does this hypothesis consistent with what you are seeing?

Yes, this is consistent with what I am seeing. The only thing to add is that
the workload isn't particularly fixed. The data being written is generated
by a production workload (we are recording statistics about hardware).
The interval at which we are shutting down the block device is regular
but not precise (+/- 30 seconds).

> 
> If so, I can see two possible solutions to avoid this:
> 
> 1) When we initialize the journal, after replaying the journal and
> writing a new journal superblock, we issue a discard for the rest of
> the journal.  This won't help for block devices that don't support
> discard, but it should slightly reduce work for the FTL, and perhaps
> slightly improve the write endurance for flash.
Our virtual device doesn't support discard, could that be why others aren't
seeing this issue?

> 
> 2) We should stop resetting the sequence number to zero, but instead,
> keep the sequence number at the last used number.  For testing
> purposes, we should have an option where the sequence number is forced
> to (0U - 300) so that we test what happens when the 4 byte unsigned
> integer wraps.
I can give this a try with my workload. Just so I can be sure I understand, the 
hypothesis is that we are running into issues during do_one_pass(..., PASS_SCAN)
because we are getting unlucky with  "if (sequence != next_commit_ID) {..."?
The solution is to reduce the occurrence of this issue (to basically zero) by not
resetting the sequence number? Have I understood you correctly? Looking
through e2fsprogs, I think there is a commit that already does this
(32448f50df7d974ded956bbc78a419cf65ec09a3) during replay. Another thing
that I could try is zeroing out the contents of inode 8 after a journal replay and
recreating the journal after each event.

Thanks for your help!
