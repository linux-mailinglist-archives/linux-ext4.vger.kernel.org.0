Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B9DF1F20A1
	for <lists+linux-ext4@lfdr.de>; Mon,  8 Jun 2020 22:24:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbgFHUY2 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 8 Jun 2020 16:24:28 -0400
Received: from mail.thelounge.net ([91.118.73.15]:22523 "EHLO
        mail.thelounge.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726415AbgFHUY1 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 8 Jun 2020 16:24:27 -0400
Received: from srv-rhsoft.rhsoft.net (rh.vpn.thelounge.net [10.10.10.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: h.reindl@thelounge.net)
        by mail.thelounge.net (THELOUNGE MTA) with ESMTPSA id 49gl8n3dpbzXPN;
        Mon,  8 Jun 2020 22:24:25 +0200 (CEST)
Subject: Re: ext4 filesystem being mounted at /boot supports timestamps until
 2038
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
References: <b944159f-01cb-9e48-309b-fe13e25e2340@thelounge.net>
 <D642F0D8-160C-4DB0-9ABB-AA2F709698AE@dilger.ca>
From:   Reindl Harald <h.reindl@thelounge.net>
Organization: the lounge interactive design
Message-ID: <5a3eefd0-ba26-6a56-0118-e2a601b1cee3@thelounge.net>
Date:   Mon, 8 Jun 2020 22:24:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <D642F0D8-160C-4DB0-9ABB-AA2F709698AE@dilger.ca>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org



Am 08.06.20 um 22:15 schrieb Andreas Dilger:
> On Jun 6, 2020, at 10:45 AM, Reindl Harald <h.reindl@thelounge.net> wrote:
>>
>> are you guys kidding me?
>>
>> * create a new vmware vdisk with 512 MB
>> * kernel 5.7.0, e2fsprogs-1.45.5-1.fc31.x86_64
>> * mount the filesystem
>>
>> Jun  6 18:37:57 master kernel: ext4 filesystem being mounted at /boot
>> supports timestamps until 2038 (0x7fffffff)
>>
>> https://lore.kernel.org/patchwork/patch/1172334/
> 
> Hi Reindl,
> It isn't clear if your complaint is about the warning message, or the
> fact that this is an issue with the newly-formatted filesystem?  The
> *issue* of 2038 timestamps has always existed, but the warning message
> is newly added so that people have time to fix this if necessary.

that it even is an issue with a newly-formatted filesystem in 220

> I wonder if it makes sense to add a superblock flag like "yes, I know
> this is not 2038 compliant, and I don't care"?

well, more or less i case because i expect that setups to still live in
2038 and it's unclear what happens then

>> -----------------------------
>>
>> this does *not* happen when the vdisk is 768 MB instead just 512 MB
>> large - what's te point of defaults which lead to warnings like this in
>> 2020?
> 
> This is a matter of space usage. Enabling the 64-bit timestamps requires
> that the filesystem be formatted with 256-byte inodes, since there wasn't
> enough space in the original 128-byte inodes for the larger timestamps
> (among other things).  That means either 1/2 as many inodes for the
> filesystem to fit in the same metadata space, or double the amount of
> metadata usage for the filesystem (reducing free space).

none of that would have mattered

Filesystem           Type            Size      Used Available Use%
Mounted on
/dev/root            ext4          738.9M     54.0M    669.6M   7% /

> The assumption is that smaller filesystems like this are unlikely to be
> used for storing long-term data

adventurous assumption

> so maximizing the usable space is most
> important.  It is unlikely you will be using the same /boot filesystem
> in 18 years, and if you are it is even less likely that it is being
> updated on a regular basis.

why wouldn't it on virtual machines?

most of my stuff has the same golden master from 2008 as source and is
running happily the newest kernel and newest Fedora release

in the case with the new formatted filesystem it was even the rootfs
which was a 6 GB vdisk and i created a new one and copied the whole data
while mounte dfrom a different vm

> It is possible to enable the larger inodes for any size filesystem by
> formatting with "mk2fs -I 256 <other options> <device>".  See "man mke2fs"
> for full details.

well, i decided to go from 512 MV to 768 MB which is at least magnitudes
smaller than 6 GB and don't throw warnings at the first mount
