Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71F5C16620C
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Feb 2020 17:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728123AbgBTQO3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Feb 2020 11:14:29 -0500
Received: from apollo.dupie.be ([51.15.19.225]:60396 "EHLO apollo.dupie.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726871AbgBTQO3 (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Thu, 20 Feb 2020 11:14:29 -0500
Received: from [IPv6:2a00:1cf8:1200:3a80:20da:22c2:8761:2] (unknown [IPv6:2a00:1cf8:1200:3a80:20da:22c2:8761:2])
        by apollo.dupie.be (Postfix) with ESMTPSA id DDB5280ABF3;
        Thu, 20 Feb 2020 17:14:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
        t=1582215268;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MGl3OdfXA4TS8R0GlkFWlLkZqJmjiROHulSLt+I3tyc=;
        b=DKaUZQbt0TQUAySGnnjp9J7PpJfwZs/rFrLeLlHFzOHT9iulH2vG6S/BvbDMX7qEPNhY9x
        KiGtggr+E446h0ICNEH6y26YNOb/+GgvXU+yHwHAQ2W0BX5yP4JIwCSiar34G/Z4enWMjE
        Guaa2YtSkqie8Oz0R6CIsFwKaPRrRlHApAI5fYCktwWx+F1rf6UucuRDhp5w9TG93RT683
        7TSgii+GSOeO2BKgkiyH9qUlDspnoTlbbAgMeicj7CHLt4mTpxMA7ae9K+Xb/lkM7p7sAx
        EB1WRG8XhRNqXTd//kOJaHh/8Eud0AHzcsoEHF0a60J6YxBVNeoOGhw8WSzK0g==
From:   Jean-Louis Dupond <jean-louis@dupond.be>
Subject: Re: Filesystem corruption after unreachable storage
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
 <20200124203725.GH147870@mit.edu>
 <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
 <20200220155022.GA532518@mit.edu>
Message-ID: <7376c09c-63e3-488f-fcf8-89c81832ef2d@dupond.be>
Date:   Thu, 20 Feb 2020 17:14:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200220155022.GA532518@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: nl-BE
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


On 20/02/2020 16:50, Theodore Y. Ts'o wrote:
> On Thu, Feb 20, 2020 at 10:08:44AM +0100, Jean-Louis Dupond wrote:
>> dumpe2fs -> see attachment
> Looking at the dumpe2fs output, it's interesting that it was "clean
> with errors", without any error information being logged in the
> superblock.  What version of the kernel are you using?  I'm guessing
> it's a fairly old one?
Debian 10 (Buster), with kernel 4.19.67-2+deb10u1
>> Fsck:
>> # e2fsck -fy /dev/mapper/vg01-root
>> e2fsck 1.44.5 (15-Dec-2018)
> And that's a old version of e2fsck as well.  Is this some kind of
> stable/enterprise linux distro?
Debian 10 indeed.
>> Pass 1: Checking inodes, blocks, and sizes
>> Inodes that were part of a corrupted orphan linked list found.  Fix? yes
>>
>> Inode 165708 was part of the orphaned inode list.  FIXED.
> OK, this and the rest looks like it's relating to a file truncation or
> deletion at the time of the disconnection.
>
>   > > > On KVM for example there is a unlimited timeout (afaik) until the
>>>> storage is
>>>> back, and the VM just continues running after storage recovery.
>>> Well, you can adjust the SCSI timeout, if you want to give that a try....
>> It has some other disadvantages? Or is it quite safe to increment the SCSI
>> timeout?
> It should be pretty safe.
>
> Can you reliably reproduce the problem by disconnecting the machine
> from the SAN?
Yep, can be reproduced by killing the connection to the SAN while the VM 
is running, and then after the scsi timeout passed, re-enabled the SAN 
connection.
Then reset the machine, and then you need to run an fsck to have it back 
online.
> 						- Ted
