Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0122D18A0
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Dec 2020 19:36:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726184AbgLGSgY (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Dec 2020 13:36:24 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:52085 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725917AbgLGSgY (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Dec 2020 13:36:24 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0B7IZYOF022576
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 7 Dec 2020 13:35:35 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C7CFA420136; Mon,  7 Dec 2020 13:35:34 -0500 (EST)
Date:   Mon, 7 Dec 2020 13:35:34 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Michael Walle <michael@walle.cc>
Cc:     linux-ext4@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: discard feature, mkfs.ext4 and mmc default fallback to normal
 erase op
Message-ID: <20201207183534.GA52960@mit.edu>
References: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Dec 07, 2020 at 04:10:27PM +0100, Michael Walle wrote:
> Hi,
> 
> The problem I'm having is that I'm trying to install debian on
> an embedded system onto an sdcard. During installation it will
> format the target filesystem, but the "mkfs.ext4 -F /dev/mmcblk0p2"
> takes ages.
> 
> What I've found out so far:
>  - mkfs.ext4 tries to discard all blocks on the target device
>  - with my target device being an sdcard it seems to fallback
>    to normal erase [1], with erase_arg being set to what the card
>    is capable of [2]
> 
> Now I'm trying to figure out if this behavior is intended. I guess
> one can reduce it to "blkdiscard /dev/mmcblk0p2". Should this
> actually fall back to normal erasing or should it return -EOPNOTSUPP?

There are three different MMC commands which are defined:

1) DISCARD
2) ERASE
3) SECURE ERASE

The first two are expected to be fast, since it only involves clearing
some metadata fields in the Flash Translation Layer (FTL), so that the
LBA's in the specified range are no longer mapped to a flash page.

The difference between "discard" and "erase" is that "discard" is a
hint, so the device is allowed to ignore it whenever it wants (in
practice, if it's busy doing a GC, or if it's busy writing back blocks
in its writeback cache).  "Erase" is guaranteed to work, in that after
an erase, a read from a specified sector MUST return all zeros, but
that can easily be done by redirecting a point in the FTL metadata.

"Secure Erase" is the one which can be slow, since it requires
physically zeroing all of the flash pages (although if the device is
self-encrypting, this in theory could also be fast if you're doing a
secure erase at the granularity of the device's encryption keys, so
all it needs to do is to regenerate the crypto key).

It sounds like your SD card is implementing the "erase" command in a
particularly non-optimal way.  If it's common, perhaps we need some
kind of blacklist for drivers with badly implemented erase commands.
As a workaround, you can run mke2fs with the command-line option "-E
discard=0".

Cheers,

					- Ted

P.S.  If your SD card got "erase" wrong, I'd be a little worried about
what else the FTL implementation may have screwed up.  So you want to
under simply getting a different SD card --- especially if this is
something that you plan to distribute as a product to downstream
customers.  In general, low-end flash needs to be very carefully
qualified to make sure they are competently implemented if you plan to
deploy in large quantities.  An example of what happen if this
qualification process is not done:

https://insideevs.com/news/376037/tesla-mcu-emmc-memory-issue/

Tesla is currently under investigation by the National Highway Traffic
Safety Administration due to cheaping out on their eMMC flash
(probably just a few pennies per unit).  Given that customers are
having to pay $1500 to replace their engine controller out of warranty
(and the NHTSA is considering whether or not to force Tesla to eat the
costs, as opposed to forcing their customers to pay $$$), that's an
example of false economy....

