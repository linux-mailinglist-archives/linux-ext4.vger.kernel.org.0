Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7806512DF1C
	for <lists+linux-ext4@lfdr.de>; Wed,  1 Jan 2020 15:17:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725877AbgAAORw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 1 Jan 2020 09:17:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57067 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725783AbgAAORv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 1 Jan 2020 09:17:51 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 001EHm3d022802
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 1 Jan 2020 09:17:48 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 19DDC420485; Wed,  1 Jan 2020 09:17:48 -0500 (EST)
Date:   Wed, 1 Jan 2020 09:17:48 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [bugreport] Ext4 automatically checked at each boot
Message-ID: <20200101141748.GA191637@mit.edu>
References: <CABXGCsODr3tMpQxJ_nhWQQg5WGakFt4Yu5B8ev6ErOkc+zv9kA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABXGCsODr3tMpQxJ_nhWQQg5WGakFt4Yu5B8ev6ErOkc+zv9kA@mail.gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jan 01, 2020 at 03:58:25PM +0500, Mikhail Gavrilov wrote:
> Hi folks.
> 
> Strange things happen with my ext4 lately:
> - At each boot, the file system is checked.
> - When I launch fsck manually it didn't found any issue.
> - But tune2fs report that last checked and mount time is Sun Dec 15,
> but this is incorrect.

The problem is casued by the fact that the mount time is incorrect,
which indicates that the system time was incorrect at the time when
the file system was mounted and when it fsck was run.  Since the last
write time was in the future, this triggered "time is insane" check.

This is inconsistent with your report that started happening when you
switched to a new motherboard.  That's because the real time clock is
not reporting the correct time when the system is booted.  Later on,
in the boot cycle, after the root file system is checked and remounted
read-write, the system time is getting set from an internet time
server.  This then causes the last write time to be ahead of the last
mount time, and "in the future" with respect to the real time clock.

Normally, the hardware clock's time gets set to match system time when
it is set from network time, or when the system is getting shut down
cleanly, but your init scripts aren't doing this properly --- or you
normally shut down your system by just flipping the power switch, and
not letting the shutdown sequence run correctly.  The other possibilty
is the real time clock on your system is just completly busted
(although normally when that happens, the last mount time would be in
the 1970's.)

Running "/sbin/hwclock -w" as root may fix things; as is figuring out
why this isn't run automatically by your boot scripts.  Another
workaround is to add to /etc/e2fsck.conf the following:

[options]
	broken_system_lock = true

This will disable e2fsck's time checks.

Cheers,

					- Ted
