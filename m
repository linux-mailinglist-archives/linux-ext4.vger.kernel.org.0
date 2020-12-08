Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C0EF2D34B9
	for <lists+linux-ext4@lfdr.de>; Tue,  8 Dec 2020 22:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgLHU5y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 8 Dec 2020 15:57:54 -0500
Received: from ssl.serverraum.org ([176.9.125.105]:60257 "EHLO
        ssl.serverraum.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726114AbgLHU5y (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 8 Dec 2020 15:57:54 -0500
Received: from ssl.serverraum.org (web.serverraum.org [172.16.0.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 197C122EE4;
        Tue,  8 Dec 2020 21:57:08 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1607461028;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TqidlpolAAbWLA854G4QY0WBqzuSGuwWJswb7wmGneE=;
        b=DSOaZhIftisjVK/PxLBh6g8cThYIvviaj00AMm2pBzuripCShYZcbCdAYDTQTNeZ5rHxed
        x7HX7yjvRehY5DcTc5PJxW2SHKUdfKW2QYV9t3EmN3Dps29zQc6E6eqqfOeOyO4TBjyYrI
        bSeVdCxDDngKG2csSi+rqP1VghOt61o=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 08 Dec 2020 21:57:07 +0100
From:   Michael Walle <michael@walle.cc>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org,
        linux-mmc@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>
Subject: Re: discard feature, mkfs.ext4 and mmc default fallback to normal
 erase op
In-Reply-To: <CAPDyKFqFT9g8OnyxEOEiATgmkgdCceu_G3drKqX3NawxSDV0kg@mail.gmail.com>
References: <97c4bb65c8a3e688b191d57e9f06aa5a@walle.cc>
 <20201207183534.GA52960@mit.edu> <2edcf8e344937b3c5b92a0b87ebd13bd@walle.cc>
 <20201208024057.GC52960@mit.edu>
 <CAPDyKFpY+M_FVXCyeg+97jAgDSqhGDTNoND8CQDMWH-e09KGKQ@mail.gmail.com>
 <d7041bbb403698ac1097f7740f364467@walle.cc>
 <CAPDyKFqFT9g8OnyxEOEiATgmkgdCceu_G3drKqX3NawxSDV0kg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.9
Message-ID: <2cff273453781a8cf7f4586fba200bb6@walle.cc>
X-Sender: michael@walle.cc
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ulf, Ted,

Am 2020-12-08 17:17, schrieb Ulf Hansson:
> On Tue, 8 Dec 2020 at 12:26, Michael Walle <michael@walle.cc> wrote:
>> > To find performance bottlenecks, I would start looking at what actual
>> > eMMC/SD commands/args we end up mapping towards the
>> > REQ_OP_DISCARD/REQ_OP_SECURE_ERASE requests. Then definitely, I would
>> > also look at the values we end up picking as max discard sectors and
>> > the discard granularity.
>> 
>> I'm just about finding some SD cards and looking how they behave 
>> timing
>> wise and what they report they support (ie. erase or discard). Looks
>> like other cards are doing better. But I'd have to find out if they
>> support the discard (mine doesn't) and if they are slow too if I force
>> them to use the normal erase.
> 
> Sounds great, looking forward to hear more about your findings.

Ok so sample size is 3 *g*. Two of these cards are actually "fast",
meaning that a discard of any size will take less than a second and
one is the slow card.

I've added tracing to dump the cards parameters (see patch at the end
of this mail). No card supports discard, they just use the normal erase
method. That wasn't what I was expecting ;)

(1) Fast card (Kingston CANVAS Select Plus, 16GB)
# time blkdiscard -l 536870912 /dev/mmcblk1
real	0m 0.34s
user	0m 0.00s
sys	0m 0.00s

      kworker/0:2-81      [000] ....   123.285801: mmc_sd_setup_card: 
card->erase_arg=0, au=9 es=512 et=12 eo=3
     kworker/1:3H-2368    [001] ....   133.570762: mmc_do_erase: from=0x0 
to=0x1fff
     kworker/1:3H-2368    [001] ....   133.585204: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.585284: mmc_do_erase: 
from=0x2000 to=0x3fff
     kworker/1:3H-2368    [001] ....   133.589201: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.589217: mmc_do_erase: 
from=0x4000 to=0x5fff
     kworker/1:3H-2368    [001] ....   133.591315: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.591330: mmc_do_erase: 
from=0x6000 to=0x7fff
     kworker/1:3H-2368    [001] ....   133.593202: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.593217: mmc_do_erase: 
from=0x8000 to=0x9fff
     kworker/1:3H-2368    [001] ....   133.595338: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.595353: mmc_do_erase: 
from=0xa000 to=0xbfff
     kworker/1:3H-2368    [001] ....   133.597473: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.597488: mmc_do_erase: 
from=0xc000 to=0xdfff
     kworker/1:3H-2368    [001] ....   133.599605: mmc_do_erase: 
mmc_poll_for_busy() done
[..]
     kworker/1:3H-2368    [001] ....   133.891681: mmc_do_erase: 
from=0xf0000 to=0xf1fff
     kworker/1:3H-2368    [001] ....   133.893919: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.893947: mmc_do_erase: 
from=0xf2000 to=0xf3fff
     kworker/1:3H-2368    [001] ....   133.896186: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.896213: mmc_do_erase: 
from=0xf4000 to=0xf5fff
     kworker/1:3H-2368    [001] ....   133.898452: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.898481: mmc_do_erase: 
from=0xf6000 to=0xf7fff
     kworker/1:3H-2368    [001] ....   133.900713: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.900741: mmc_do_erase: 
from=0xf8000 to=0xf9fff
     kworker/1:3H-2368    [001] ....   133.902979: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.903008: mmc_do_erase: 
from=0xfa000 to=0xfbfff
     kworker/1:3H-2368    [001] ....   133.905246: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.905274: mmc_do_erase: 
from=0xfc000 to=0xfdfff
     kworker/1:3H-2368    [001] ....   133.909589: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   133.909620: mmc_do_erase: 
from=0xfe000 to=0xfffff
     kworker/1:3H-2368    [001] ....   133.911870: mmc_do_erase: 
mmc_poll_for_busy() done


(2) Fast card (Panasonic, Unknown model, 8GB)
      kworker/0:2-81      [000] ....   492.192453: mmc_sd_setup_card: 
card->erase_arg=0, au=9 es=8 et=1 eo=3

     I didn't discard the blocks again, so no logs, but it didn't take
     long in the first run.


(3) Slow card (Toshiba Exceria, 16GB)
# time blkdiscard -l 536870912 /dev/mmcblk1
real	0m 39.78s
user	0m 0.00s
sys	0m 0.00s

      kworker/0:2-81      [000] ....   207.271171: mmc_sd_setup_card: 
card->erase_arg=0, au=9 es=512 et=12 eo=3
     kworker/1:3H-2368    [001] ....   212.096265: mmc_do_erase: from=0x0 
to=0x1fff
     kworker/1:3H-2368    [001] ....   212.100282: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   212.100328: mmc_do_erase: 
from=0x2000 to=0x3fff
     kworker/1:3H-2368    [001] ....   212.102207: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   212.102215: mmc_do_erase: 
from=0x4000 to=0x5fff
     kworker/1:3H-2368    [001] ....   212.104260: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   212.104267: mmc_do_erase: 
from=0x6000 to=0x7fff
     kworker/1:3H-2368    [001] ....   213.086808: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.086842: mmc_do_erase: 
from=0x8000 to=0x9fff
     kworker/1:3H-2368    [001] ....   213.149232: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.149263: mmc_do_erase: 
from=0xa000 to=0xbfff
     kworker/1:3H-2368    [001] ....   213.215185: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.215216: mmc_do_erase: 
from=0xc000 to=0xdfff
     kworker/1:3H-2368    [001] ....   213.346672: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.346702: mmc_do_erase: 
from=0xe000 to=0xffff
     kworker/1:3H-2368    [001] ....   213.412594: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.412623: mmc_do_erase: 
from=0x10000 to=0x11fff
     kworker/1:3H-2368    [001] ....   213.478507: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.478541: mmc_do_erase: 
from=0x12000 to=0x13fff
     kworker/1:3H-2368    [001] ....   213.598798: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.598829: mmc_do_erase: 
from=0x14000 to=0x15fff
     kworker/1:3H-2368    [001] ....   213.664721: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.664750: mmc_do_erase: 
from=0x16000 to=0x17fff
     kworker/1:3H-2368    [001] ....   213.730632: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.730661: mmc_do_erase: 
from=0x18000 to=0x19fff
     kworker/1:3H-2368    [001] ....   213.862108: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.862138: mmc_do_erase: 
from=0x1a000 to=0x1bfff
     kworker/1:3H-2368    [001] ....   213.928017: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.928046: mmc_do_erase: 
from=0x1c000 to=0x1dfff
     kworker/1:3H-2368    [001] ....   213.993925: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   213.993954: mmc_do_erase: 
from=0x1e000 to=0x1ffff
     kworker/1:3H-2368    [001] ....   214.110795: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   214.110827: mmc_do_erase: 
from=0x20000 to=0x21fff
     kworker/1:3H-2368    [001] ....   214.173232: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   214.173263: mmc_do_erase: 
from=0x22000 to=0x23fff
     kworker/1:3H-2368    [001] ....   214.239191: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   214.239221: mmc_do_erase: 
from=0x24000 to=0x25fff
     kworker/1:3H-2368    [001] ....   215.069222: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   215.069253: mmc_do_erase: 
from=0x26000 to=0x27fff
     kworker/1:3H-2368    [001] ....   215.135138: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   215.135168: mmc_do_erase: 
from=0x28000 to=0x29fff
     kworker/1:3H-2368    [001] ....   215.197232: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   215.197264: mmc_do_erase: 
from=0x2a000 to=0x2bfff
     kworker/1:3H-2368    [001] ....   216.040197: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   216.040229: mmc_do_erase: 
from=0x2c000 to=0x2dfff
     kworker/1:3H-2368    [001] ....   216.158794: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   216.158824: mmc_do_erase: 
from=0x2e000 to=0x2ffff
     kworker/1:3H-2368    [001] ....   216.221232: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   216.221263: mmc_do_erase: 
from=0x30000 to=0x31fff
     kworker/1:3H-2368    [001] ....   217.064195: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   217.064226: mmc_do_erase: 
from=0x32000 to=0x33fff
     kworker/1:3H-2368    [001] ....   217.182794: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   217.182824: mmc_do_erase: 
from=0x34000 to=0x35fff
     kworker/1:3H-2368    [001] ....   217.245231: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   217.245263: mmc_do_erase: 
from=0x36000 to=0x37fff
     kworker/1:3H-2368    [001] ....   218.083500: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   218.083532: mmc_do_erase: 
from=0x38000 to=0x39fff
     kworker/1:3H-2368    [001] ....   218.141223: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   218.141253: mmc_do_erase: 
from=0x3a000 to=0x3bfff
     kworker/1:3H-2368    [001] ....   218.207130: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   218.207160: mmc_do_erase: 
from=0x3c000 to=0x3dfff
     kworker/1:3H-2368    [001] ....   219.046630: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   219.046663: mmc_do_erase: 
from=0x3e000 to=0x3ffff
     kworker/1:3H-2368    [001] ....   219.112564: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   219.112595: mmc_do_erase: 
from=0x40000 to=0x41fff
     kworker/1:3H-2368    [001] ....   219.230811: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   219.230842: mmc_do_erase: 
from=0x42000 to=0x43fff
     kworker/1:3H-2368    [001] ....   220.070631: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   220.070665: mmc_do_erase: 
from=0x44000 to=0x45fff
     kworker/1:3H-2368    [001] ....   220.136551: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   220.136580: mmc_do_erase: 
from=0x46000 to=0x47fff
     kworker/1:3H-2368    [001] ....   220.254794: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   220.254824: mmc_do_erase: 
from=0x48000 to=0x49fff
     kworker/1:3H-2368    [001] ....   221.094626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   221.094658: mmc_do_erase: 
from=0x4a000 to=0x4bfff
     kworker/1:3H-2368    [001] ....   221.160559: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   221.160588: mmc_do_erase: 
from=0x4c000 to=0x4dfff
     kworker/1:3H-2368    [001] ....   221.278793: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   221.278823: mmc_do_erase: 
from=0x4e000 to=0x4ffff
     kworker/1:3H-2368    [001] ....   222.118626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   222.118658: mmc_do_erase: 
from=0x50000 to=0x51fff
     kworker/1:3H-2368    [001] ....   222.184557: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   222.184586: mmc_do_erase: 
from=0x52000 to=0x53fff
     kworker/1:3H-2368    [001] ....   222.302797: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   222.302829: mmc_do_erase: 
from=0x54000 to=0x55fff
     kworker/1:3H-2368    [001] ....   223.142627: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   223.142659: mmc_do_erase: 
from=0x56000 to=0x57fff
     kworker/1:3H-2368    [001] ....   223.208558: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   223.208587: mmc_do_erase: 
from=0x58000 to=0x59fff
     kworker/1:3H-2368    [001] ....   223.326793: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   223.326823: mmc_do_erase: 
from=0x5a000 to=0x5bfff
     kworker/1:3H-2368    [001] ....   224.166631: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   224.166663: mmc_do_erase: 
from=0x5c000 to=0x5dfff
     kworker/1:3H-2368    [001] ....   224.232553: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   224.232582: mmc_do_erase: 
from=0x5e000 to=0x5ffff
     kworker/1:3H-2368    [001] ....   224.350792: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   224.350822: mmc_do_erase: 
from=0x60000 to=0x61fff
     kworker/1:3H-2368    [001] ....   225.190627: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   225.190658: mmc_do_erase: 
from=0x62000 to=0x63fff
     kworker/1:3H-2368    [001] ....   225.256542: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   225.256571: mmc_do_erase: 
from=0x64000 to=0x65fff
     kworker/1:3H-2368    [001] ....   225.374796: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   225.374827: mmc_do_erase: 
from=0x66000 to=0x67fff
     kworker/1:3H-2368    [001] ....   226.214627: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   226.214658: mmc_do_erase: 
from=0x68000 to=0x69fff
     kworker/1:3H-2368    [001] ....   226.333222: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   226.333255: mmc_do_erase: 
from=0x6a000 to=0x6bfff
     kworker/1:3H-2368    [001] ....   226.399137: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   226.399168: mmc_do_erase: 
from=0x6c000 to=0x6dfff
     kworker/1:3H-2368    [001] ....   227.238625: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   227.238657: mmc_do_erase: 
from=0x6e000 to=0x6ffff
     kworker/1:3H-2368    [001] ....   227.304560: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   227.304589: mmc_do_erase: 
from=0x70000 to=0x71fff
     kworker/1:3H-2368    [001] ....   227.422792: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   227.422822: mmc_do_erase: 
from=0x72000 to=0x73fff
     kworker/1:3H-2368    [001] ....   228.262629: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   228.262661: mmc_do_erase: 
from=0x74000 to=0x75fff
     kworker/1:3H-2368    [001] ....   228.328546: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   228.328575: mmc_do_erase: 
from=0x76000 to=0x77fff
     kworker/1:3H-2368    [001] ....   228.446796: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   228.446827: mmc_do_erase: 
from=0x78000 to=0x79fff
     kworker/1:3H-2368    [001] ....   229.286630: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   229.286662: mmc_do_erase: 
from=0x7a000 to=0x7bfff
     kworker/1:3H-2368    [001] ....   229.352545: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   229.352573: mmc_do_erase: 
from=0x7c000 to=0x7dfff
     kworker/1:3H-2368    [001] ....   229.470792: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   229.470822: mmc_do_erase: 
from=0x7e000 to=0x7ffff
     kworker/1:3H-2368    [001] ....   230.310627: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   230.310659: mmc_do_erase: 
from=0x80000 to=0x81fff
     kworker/1:3H-2368    [001] ....   230.376544: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   230.376574: mmc_do_erase: 
from=0x82000 to=0x83fff
     kworker/1:3H-2368    [001] ....   230.494792: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   230.494822: mmc_do_erase: 
from=0x84000 to=0x85fff
     kworker/1:3H-2368    [001] ....   231.334626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   231.334658: mmc_do_erase: 
from=0x86000 to=0x87fff
     kworker/1:3H-2368    [001] ....   231.400542: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   231.400571: mmc_do_erase: 
from=0x88000 to=0x89fff
     kworker/1:3H-2368    [001] ....   231.518795: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   231.518827: mmc_do_erase: 
from=0x8a000 to=0x8bfff
     kworker/1:3H-2368    [001] ....   232.358627: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   232.358659: mmc_do_erase: 
from=0x8c000 to=0x8dfff
     kworker/1:3H-2368    [001] ....   232.477222: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   232.477255: mmc_do_erase: 
from=0x8e000 to=0x8ffff
     kworker/1:3H-2368    [001] ....   232.543130: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   232.543160: mmc_do_erase: 
from=0x90000 to=0x91fff
     kworker/1:3H-2368    [001] ....   233.382626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   233.382658: mmc_do_erase: 
from=0x92000 to=0x93fff
     kworker/1:3H-2368    [001] ....   233.448558: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   233.448587: mmc_do_erase: 
from=0x94000 to=0x95fff
     kworker/1:3H-2368    [001] ....   233.566793: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   233.566823: mmc_do_erase: 
from=0x96000 to=0x97fff
     kworker/1:3H-2368    [001] ....   234.406628: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   234.406659: mmc_do_erase: 
from=0x98000 to=0x99fff
     kworker/1:3H-2368    [001] ....   234.472545: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   234.472574: mmc_do_erase: 
from=0x9a000 to=0x9bfff
     kworker/1:3H-2368    [001] ....   234.590796: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   234.590827: mmc_do_erase: 
from=0x9c000 to=0x9dfff
     kworker/1:3H-2368    [001] ....   235.430625: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   235.430656: mmc_do_erase: 
from=0x9e000 to=0x9ffff
     kworker/1:3H-2368    [001] ....   235.496536: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   235.496566: mmc_do_erase: 
from=0xa0000 to=0xa1fff
     kworker/1:3H-2368    [001] ....   235.614792: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   235.614822: mmc_do_erase: 
from=0xa2000 to=0xa3fff
     kworker/1:3H-2368    [001] ....   236.454627: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   236.454657: mmc_do_erase: 
from=0xa4000 to=0xa5fff
     kworker/1:3H-2368    [001] ....   236.520546: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   236.520575: mmc_do_erase: 
from=0xa6000 to=0xa7fff
     kworker/1:3H-2368    [001] ....   236.638793: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   236.638824: mmc_do_erase: 
from=0xa8000 to=0xa9fff
     kworker/1:3H-2368    [001] ....   237.478625: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   237.478656: mmc_do_erase: 
from=0xaa000 to=0xabfff
     kworker/1:3H-2368    [001] ....   237.544554: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   237.544583: mmc_do_erase: 
from=0xac000 to=0xadfff
     kworker/1:3H-2368    [001] ....   237.662796: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   237.662827: mmc_do_erase: 
from=0xae000 to=0xaffff
     kworker/1:3H-2368    [001] ....   238.502625: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   238.502656: mmc_do_erase: 
from=0xb0000 to=0xb1fff
     kworker/1:3H-2368    [001] ....   238.621222: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   238.621255: mmc_do_erase: 
from=0xb2000 to=0xb3fff
     kworker/1:3H-2368    [001] ....   238.687131: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   238.687161: mmc_do_erase: 
from=0xb4000 to=0xb5fff
     kworker/1:3H-2368    [001] ....   239.526626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   239.526657: mmc_do_erase: 
from=0xb6000 to=0xb7fff
     kworker/1:3H-2368    [001] ....   239.592540: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   239.592569: mmc_do_erase: 
from=0xb8000 to=0xb9fff
     kworker/1:3H-2368    [001] ....   239.710792: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   239.710822: mmc_do_erase: 
from=0xba000 to=0xbbfff
     kworker/1:3H-2368    [001] ....   240.550626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   240.550656: mmc_do_erase: 
from=0xbc000 to=0xbdfff
     kworker/1:3H-2368    [001] ....   240.616539: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   240.616567: mmc_do_erase: 
from=0xbe000 to=0xbffff
     kworker/1:3H-2368    [001] ....   240.734796: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   240.734828: mmc_do_erase: 
from=0xc0000 to=0xc1fff
     kworker/1:3H-2368    [001] ....   241.574624: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   241.574655: mmc_do_erase: 
from=0xc2000 to=0xc3fff
     kworker/1:3H-2368    [001] ....   241.640552: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   241.640581: mmc_do_erase: 
from=0xc4000 to=0xc5fff
     kworker/1:3H-2368    [001] ....   241.758792: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   241.758823: mmc_do_erase: 
from=0xc6000 to=0xc7fff
     kworker/1:3H-2368    [001] ....   242.598626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   242.598658: mmc_do_erase: 
from=0xc8000 to=0xc9fff
     kworker/1:3H-2368    [001] ....   242.664543: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   242.664571: mmc_do_erase: 
from=0xca000 to=0xcbfff
     kworker/1:3H-2368    [001] ....   242.782792: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   242.782822: mmc_do_erase: 
from=0xcc000 to=0xcdfff
     kworker/1:3H-2368    [001] ....   243.622626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   243.622658: mmc_do_erase: 
from=0xce000 to=0xcffff
     kworker/1:3H-2368    [001] ....   243.688545: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   243.688574: mmc_do_erase: 
from=0xd0000 to=0xd1fff
     kworker/1:3H-2368    [001] ....   243.806795: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   243.806827: mmc_do_erase: 
from=0xd2000 to=0xd3fff
     kworker/1:3H-2368    [001] ....   244.646625: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   244.646656: mmc_do_erase: 
from=0xd4000 to=0xd5fff
     kworker/1:3H-2368    [001] ....   244.765222: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   244.765255: mmc_do_erase: 
from=0xd6000 to=0xd7fff
     kworker/1:3H-2368    [001] ....   244.831131: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   244.831160: mmc_do_erase: 
from=0xd8000 to=0xd9fff
     kworker/1:3H-2368    [001] ....   245.670626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   245.670658: mmc_do_erase: 
from=0xda000 to=0xdbfff
     kworker/1:3H-2368    [001] ....   245.736537: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   245.736566: mmc_do_erase: 
from=0xdc000 to=0xddfff
     kworker/1:3H-2368    [001] ....   245.854792: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   245.854823: mmc_do_erase: 
from=0xde000 to=0xdffff
     kworker/1:3H-2368    [001] ....   246.694624: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   246.694655: mmc_do_erase: 
from=0xe0000 to=0xe1fff
     kworker/1:3H-2368    [001] ....   246.760553: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   246.760582: mmc_do_erase: 
from=0xe2000 to=0xe3fff
     kworker/1:3H-2368    [001] ....   246.878795: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   246.878827: mmc_do_erase: 
from=0xe4000 to=0xe5fff
     kworker/1:3H-2368    [001] ....   247.718624: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   247.718656: mmc_do_erase: 
from=0xe6000 to=0xe7fff
     kworker/1:3H-2368    [001] ....   247.784540: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   247.784570: mmc_do_erase: 
from=0xe8000 to=0xe9fff
     kworker/1:3H-2368    [001] ....   247.902791: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   247.902821: mmc_do_erase: 
from=0xea000 to=0xebfff
     kworker/1:3H-2368    [001] ....   248.742625: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   248.742657: mmc_do_erase: 
from=0xec000 to=0xedfff
     kworker/1:3H-2368    [001] ....   248.808554: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   248.808584: mmc_do_erase: 
from=0xee000 to=0xeffff
     kworker/1:3H-2368    [001] ....   248.926792: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   248.926822: mmc_do_erase: 
from=0xf0000 to=0xf1fff
     kworker/1:3H-2368    [001] ....   249.766626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   249.766657: mmc_do_erase: 
from=0xf2000 to=0xf3fff
     kworker/1:3H-2368    [001] ....   249.832544: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   249.832574: mmc_do_erase: 
from=0xf4000 to=0xf5fff
     kworker/1:3H-2368    [001] ....   249.950797: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   249.950828: mmc_do_erase: 
from=0xf6000 to=0xf7fff
     kworker/1:3H-2368    [001] ....   250.790626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   250.790658: mmc_do_erase: 
from=0xf8000 to=0xf9fff
     kworker/1:3H-2368    [001] ....   250.909223: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   250.909256: mmc_do_erase: 
from=0xfa000 to=0xfbfff
     kworker/1:3H-2368    [001] ....   250.975143: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   250.975173: mmc_do_erase: 
from=0xfc000 to=0xfdfff
     kworker/1:3H-2368    [001] ....   251.814626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/1:3H-2368    [001] ....   251.814656: mmc_do_erase: 
from=0xfe000 to=0xfffff
     kworker/1:3H-2368    [001] ....   251.880556: mmc_do_erase: 
mmc_poll_for_busy() done

As you can see, some erase operations are fast and some take significant
longer. While for the fast card, all are completed almost 
instantaneously.
Looks like the slow card will do some kind of background work between 
erase
cycles.

The reported parameters of the slow card sounds reasonable, like 15s
for 2GiB. Because of this I've changed the perf_erase to its max value
for this card (i.e. au * 512):

# time blkdiscard /dev/mmcblk1
real	0m 1.72s
user	0m 0.00s
sys	0m 0.00s

     kworker/0:3H-2375    [000] ....   528.308617: mmc_do_erase: from=0x0 
to=0x3fdfff
     kworker/0:3H-2375    [000] ....   528.435991: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/0:3H-2375    [000] ....   528.436047: mmc_do_erase: 
from=0x3fe000 to=0x7fbfff
     kworker/0:3H-2375    [000] ....   528.605276: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/0:3H-2375    [000] ....   528.605311: mmc_do_erase: 
from=0x7fc000 to=0x7ffffe
     kworker/0:3H-2375    [000] ....   528.736726: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/0:3H-2375    [000] ....   528.736757: mmc_do_erase: 
from=0x7fffff to=0xbfdffe
     kworker/0:3H-2375    [000] ....   528.926908: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/0:3H-2375    [000] ....   528.926940: mmc_do_erase: 
from=0xbfdfff to=0xffbffe
     kworker/0:3H-2375    [000] ....   529.189489: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/0:3H-2375    [000] ....   529.189520: mmc_do_erase: 
from=0xffbfff to=0xfffffd
     kworker/0:3H-2375    [000] ....   529.386494: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/0:3H-2375    [000] ....   529.386524: mmc_do_erase: 
from=0xfffffe to=0x13fdffd
     kworker/0:3H-2375    [000] ....   529.629276: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/0:3H-2375    [000] ....   529.629307: mmc_do_erase: 
from=0x13fdffe to=0x17fbffd
     kworker/0:3H-2375    [000] ....   529.760731: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/0:3H-2375    [000] ....   529.760762: mmc_do_erase: 
from=0x17fbffe to=0x17ffffc
     kworker/0:3H-2375    [000] ....   529.892180: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/0:3H-2375    [000] ....   529.892211: mmc_do_erase: 
from=0x17ffffd to=0x1bfdffc
     kworker/0:3H-2375    [000] ....   530.023626: mmc_do_erase: 
mmc_poll_for_busy() done
     kworker/0:3H-2375    [000] ....   530.023656: mmc_do_erase: 
from=0x1bfdffd to=0x1cd9fff
     kworker/0:3H-2375    [000] ....   530.032057: mmc_do_erase: 
mmc_poll_for_busy() done

Now there is a comment about the "perf_erase" that states it should
be small to allow other I/O. But maybe we could also take the erase
time into account and allow larger erase sizes.

-michael



diff --git a/drivers/mmc/core/core.c b/drivers/mmc/core/core.c
index 19f1ee57fb34..e126a01414be 100644
--- a/drivers/mmc/core/core.c
+++ b/drivers/mmc/core/core.c
@@ -1675,6 +1675,8 @@ static int mmc_do_erase(struct mmc_card *card, 
unsigned int from,
                 to <<= 9;
         }

+       trace_printk("from=0x%x to=0x%x\n", from, to);
+
         if (mmc_card_sd(card))
                 cmd.opcode = SD_ERASE_WR_BLK_START;
         else
@@ -1747,6 +1749,7 @@ static int mmc_do_erase(struct mmc_card *card, 
unsigned int from,
         /* Let's poll to find out when the erase operation completes. */
         err = mmc_poll_for_busy(card, busy_timeout, MMC_BUSY_ERASE);

+       trace_printk("mmc_poll_for_busy() done\n");
  out:
         mmc_retune_release(card->host);
         return err;
diff --git a/drivers/mmc/core/sd.c b/drivers/mmc/core/sd.c
index 6f054c449d46..5e48a2cd4ad3 100644
--- a/drivers/mmc/core/sd.c
+++ b/drivers/mmc/core/sd.c
@@ -291,6 +291,8 @@ static int mmc_read_ssr(struct mmc_card *card)
         card->erase_arg = (card->scr.sda_specx && discard_support) ?
                             SD_DISCARD_ARG : SD_ERASE_ARG;

+       trace_printk("card->erase_arg=%d, au=%d es=%d et=%d eo=%d\n", 
card->erase_arg, au, es, et, eo);
+
         return 0;
  }

