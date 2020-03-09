Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7767017E3A9
	for <lists+linux-ext4@lfdr.de>; Mon,  9 Mar 2020 16:33:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbgCIPdt (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 9 Mar 2020 11:33:49 -0400
Received: from apollo.dupie.be ([51.15.19.225]:35516 "EHLO apollo.dupie.be"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726926AbgCIPdt (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 9 Mar 2020 11:33:49 -0400
Received: from [10.10.1.146] (systeembeheer.combell.com [217.21.177.69])
        by apollo.dupie.be (Postfix) with ESMTPSA id 0838280AE37;
        Mon,  9 Mar 2020 16:33:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dupond.be; s=dkim;
        t=1583768027;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=R1XXosTlIQobNknZjKha8pxExgwCG8py/92QnT7rCm0=;
        b=Dw3Ic6sh9kl1lzKxsMchGtx36tTquKFjCwcaO2mcIGeWhhU2zmYBn4aKIsA4bQ2XzCUF8N
        P7MxTRumybefR/ujYWBc0p8XeaWADvFwYClYR5plze54CRm5FaDwSfVYkXfqnXxPQ8JU79
        o0LjIBOtPXsDJZB4KeSTY9NB6cjjA56sjbrCcOMlVbjhNKLRiGNoWwRFBB7UVa86Ox8bpV
        HkzCRyKMvE3WBcfjTRlFtZuKogi5tVjUqAoMR+W+A8jGrAad5QJklRwNAHih4k/Ne/QzfF
        q+HjhWm4MG+jX6mykXEMJnys31GPIEmLKdBzAYVUoZ38T2lYvxXquJKh4ghaFg==
Subject: Re: Filesystem corruption after unreachable storage
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
References: <c829a701-3e22-8931-e5ca-2508f87f4d78@dupond.be>
 <20200124203725.GH147870@mit.edu>
 <3a7bc899-31d9-51f2-1ea9-b3bef2a98913@dupond.be>
 <20200220155022.GA532518@mit.edu>
 <7376c09c-63e3-488f-fcf8-89c81832ef2d@dupond.be>
 <adc0517d-b46e-2879-f06c-34c3d7b7c5f6@dupond.be>
 <20200225172355.GA14617@mit.edu>
 <d19e44af-585f-e4a2-5546-7a3345a0ee66@dupond.be>
 <50f93ccb-2b2c-15c5-8b08-facc3a25068a@dupond.be>
 <20200309151838.GA4852@mit.edu>
From:   Jean-Louis Dupond <jean-louis@dupond.be>
Message-ID: <93e74f9f-6694-a3e9-4fac-981389522d25@dupond.be>
Date:   Mon, 9 Mar 2020 16:33:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200309151838.GA4852@mit.edu>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 9/03/2020 16:18, Theodore Y. Ts'o wrote:
> Did the panic happen immediately, or did things hang until the storage
> recovered, and*then*  it rebooted.  Or did the hard reset and reboot
> happened before the storage network connection was restored?

The panic (well it was just frozen, no stacktrace or automatic reboot) 
did happen *after* storage came back online.
So nothing happens while the storage is offline, even if we wait until 
the scsi timeout is exceeded (180s * 6).
It's only when the storage returns that the filesystem goes read-only / 
panic (depending on the error setting).
>
> Fundamentally I think what's going on is that even though there is an
> I/O error reported back to the OS, but in some cases, the outstanding
> I/O actually happens.  So in the error=panic case, we do update the
> superblock saying that the file system contains inconsistencies.  And
> then we reboot.  But it appears that even though host rebooted, the
> storage area network*did*  manage to send the I/O to the device.
It seems that by updating the superblock to state that filesystem 
contains errors, things are made worse.
At the moment it does this, the storage is already accessible again, so 
it seems logic the I/O is written.
>
> I'm not sure what we can really do here, other than simply making the
> SCSI timeout infinite.  The problem is that storage area networks are
> flaky.  Sometimes I/O's make it through, and even though we get an
> error, it's an error from the local SCSI layer --- and it's possible
> that I/O will make it through.  In other cases, even though the
> storage area network was disconnected at the time we sent the I/O
> saying the file system has problems, and then rebooted, the I/O
> actually makes it through.  Given that, assuming that if we're not
> sure, forcing an full file system check is better part of valor.
If we do reset the VM before storage is back, the filesystem check just 
goes fine in automatic mode.
So I think we should (in some cases) not try to update the superblock 
anymore on I/O errors, but just go read-only/panic.
Cause it seems like updating the superblock makes things worse.

Or changes could be made to e2fsck to allow automatic repair of this 
kind of error for example?
>
> And if it hangs forever, and we do a hard reset reboot, I don't know
> *what*  to trust from the storage area network.  Ideally, there would
> be some way to do a hard reset of the storage area network so that all
> outstanding I/O's from the host that we are about to reset will get
> forgotten before we do actually the hard reset.
>
> 						- Ted
