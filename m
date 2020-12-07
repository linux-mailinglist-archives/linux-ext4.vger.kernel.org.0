Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2CE92D1AB1
	for <lists+linux-ext4@lfdr.de>; Mon,  7 Dec 2020 21:41:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725972AbgLGUkQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 7 Dec 2020 15:40:16 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:54701 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725814AbgLGUkQ (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 7 Dec 2020 15:40:16 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 0BFBF22E0A;
        Mon,  7 Dec 2020 21:39:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1607373573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=99gx2cWANtw7xbgXmiVd706Ja27zb5HI7XI/tfZcAoQ=;
        b=VjM5ehjWW56mCDj/RZGZ6fgh1Jr0pn/PbdVw4mFG46Ad1ezv8AjKzL8eBOwATYcCgTKbkv
        6bOVcV/fNP5Y2MzvmhHsxmycff6Xg03odmS8uOzxt5k4keXLHZQI7utj9WR6YwqB8ceGGT
        KjAaFOJ62GuTI1gOE1WdOOTuHcSAxxM=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 07 Dec 2020 21:39:32 +0100
From:   Michael Walle <michael@walle.cc>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org, linux-mmc@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: Re: discard feature, mkfs.ext4 and mmc default fallback to normal
 erase op
In-Reply-To: <20201207183534.GA52960@mit.edu>
References: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc>
 <20201207183534.GA52960@mit.edu>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <2edcf8e344937b3c5b92a0b87ebd13bd@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

Am 2020-12-07 19:35, schrieb Theodore Y. Ts'o:
> On Mon, Dec 07, 2020 at 04:10:27PM +0100, Michael Walle wrote:
>> Hi,
>> 
>> The problem I'm having is that I'm trying to install debian on
>> an embedded system onto an sdcard. During installation it will
>> format the target filesystem, but the "mkfs.ext4 -F /dev/mmcblk0p2"
>> takes ages.
>> 
>> What I've found out so far:
>>  - mkfs.ext4 tries to discard all blocks on the target device
>>  - with my target device being an sdcard it seems to fallback
>>    to normal erase [1], with erase_arg being set to what the card
>>    is capable of [2]
>> 
>> Now I'm trying to figure out if this behavior is intended. I guess
>> one can reduce it to "blkdiscard /dev/mmcblk0p2". Should this
>> actually fall back to normal erasing or should it return -EOPNOTSUPP?
> 
> There are three different MMC commands which are defined:
> 
> 1) DISCARD
> 2) ERASE
> 3) SECURE ERASE
> 
> The first two are expected to be fast, since it only involves clearing
> some metadata fields in the Flash Translation Layer (FTL), so that the
> LBA's in the specified range are no longer mapped to a flash page.

Mh, where is it specified that the erase command is fast? According
to the Physical Layer Simplified Specification Version 8.00:

  The actual erase time may be quite long, and the host may issue CMD7
  to deselect the card or perform card disconnection, as described in
  the Block Write section, above.

Honest question. Also reading "4.14 Erase Timeout Calculation" doesn't
sound that it is fast.

Also there is this comment:
https://elixir.bootlin.com/linux/v5.9.12/source/drivers/mmc/core/core.c#L1495

> The difference between "discard" and "erase" is that "discard" is a
> hint, so the device is allowed to ignore it whenever it wants (in
> practice, if it's busy doing a GC, or if it's busy writing back blocks
> in its writeback cache).  "Erase" is guaranteed to work, in that after
> an erase, a read from a specified sector MUST return all zeros, but
> that can easily be done by redirecting a point in the FTL metadata.
> 
> "Secure Erase" is the one which can be slow, since it requires
> physically zeroing all of the flash pages (although if the device is
> self-encrypting, this in theory could also be fast if you're doing a
> secure erase at the granularity of the device's encryption keys, so
> all it needs to do is to regenerate the crypto key).
> 
> It sounds like your SD card is implementing the "erase" command in a
> particularly non-optimal way.  If it's common, perhaps we need some
> kind of blacklist for drivers with badly implemented erase commands.
> As a workaround, you can run mke2fs with the command-line option "-E
> discard=0".

I've already tested that "mkfs.ext4 -E nodiscard" is fast (or works in
the same way as before the pre-discard feature).

But I wouldn't say it is a cheapo card (Toshiba Exceria). Although I
cannot guarantee that it might be a china clone, but it looks authentic
;)


> P.S.  If your SD card got "erase" wrong, I'd be a little worried about
> what else the FTL implementation may have screwed up.  So you want to
> under simply getting a different SD card --- especially if this is
> something that you plan to distribute as a product to downstream
> customers.  In general, low-end flash needs to be very carefully
> qualified to make sure they are competently implemented if you plan to
> deploy in large quantities.  An example of what happen if this
> qualification process is not done:
> 
> https://insideevs.com/news/376037/tesla-mcu-emmc-memory-issue/
> 
> Tesla is currently under investigation by the National Highway Traffic
> Safety Administration due to cheaping out on their eMMC flash
> (probably just a few pennies per unit).  Given that customers are
> having to pay $1500 to replace their engine controller out of warranty
> (and the NHTSA is considering whether or not to force Tesla to eat the
> costs, as opposed to forcing their customers to pay $$$), that's an
> example of false economy....

Yeah I'm aware of the Tesla eMMC wear-out problem. But I've seen this
esp. from a user point of view. Like take our product, where the user
can freely choose its sdcard just to then notice that the installation
of its distribution is painfully slow. So I'm interested in 
understanding
the implications. Like is it really the case that the erase command can
be assumed fast.

-michael
