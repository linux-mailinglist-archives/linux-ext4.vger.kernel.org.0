Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7985C56D93
	for <lists+linux-ext4@lfdr.de>; Wed, 26 Jun 2019 17:24:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726723AbfFZPYW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 26 Jun 2019 11:24:22 -0400
Received: from mxo1.dft.dmz.twosigma.com ([208.77.212.183]:45389 "EHLO
        mxo1.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbfFZPYW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 26 Jun 2019 11:24:22 -0400
X-Greylist: delayed 384 seconds by postgrey-1.27 at vger.kernel.org; Wed, 26 Jun 2019 11:24:21 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTP id 45Ymqm4sq4z7t8V;
        Wed, 26 Jun 2019 15:17:56 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo1.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo1.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XhBvqCTbyQMp; Wed, 26 Jun 2019 15:17:56 +0000 (GMT)
Received: from EXMBNJE7.ad.twosigma.com (exmbnje7.ad.twosigma.com [172.20.45.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo1.dft.dmz.twosigma.com (Postfix) with ESMTPS id 45Ymqm49vsz3wZB;
        Wed, 26 Jun 2019 15:17:56 +0000 (GMT)
Received: from EXMBNJE10.ad.twosigma.com (172.20.2.246) by
 EXMBNJE7.ad.twosigma.com (172.20.45.147) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Wed, 26 Jun 2019 15:17:56 +0000
Received: from EXMBNJE6.ad.twosigma.com (172.20.45.169) by
 EXMBNJE10.ad.twosigma.com (172.20.2.246) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Wed, 26 Jun 2019 15:17:56 +0000
Received: from twosigma.com (192.168.147.188) by EXMBNJE6.ad.twosigma.com
 (172.20.45.169) with Microsoft SMTP Server (TLS) id 15.0.1365.1 via Frontend
 Transport; Wed, 26 Jun 2019 15:17:56 +0000
Date:   Wed, 26 Jun 2019 11:17:54 -0400
From:   Thomas Walker <Thomas.Walker@twosigma.com>
To:     "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>
CC:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        "'tytso@mit.edu'" <tytso@mit.edu>,
        Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>
Subject: Re: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Message-ID: <20190626151754.GA2789@twosigma.com>
References: <9abbdde6145a4887a8d32c65974f7832@exmbdft5.ad.twosigma.com>
 <20181108184722.GB27852@magnolia>
 <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20190123195922.GA16927@twosigma.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Sorry to revive a rather old thread, but Elana mentioned that there might have been a related fix recently?  Possibly something to do with truncate? 
A quick scan of the last month or so turned up https://www.spinics.net/lists/linux-ext4/msg65772.html but none of these seemed obviously applicable to me.
We do still experience this phantom space usage quite frequently (although the remount workaround below has lowered the priority). 

On Wed, Jan 23, 2019 at 02:59:22PM -0500, Thomas Walker wrote:
> Unfortunately this still continues to be a persistent problem for us.  On another example system:
> 
> # uname -a
> Linux <hostname> 4.14.67-ts1 #1 SMP Wed Aug 29 13:28:25 UTC 2018 x86_64 GNU/Linux
> 
> # df -h /
> Filesystem                                              Size  Used Avail Use% Mounted on
> /dev/disk/by-uuid/<uuid>                                 50G   46G  1.1G  98% /
> 
> # df -hi /
> Filesystem                                             Inodes IUsed IFree IUse% Mounted on
> /dev/disk/by-uuid/<uuid>                                 3.2M  306K  2.9M   10% /
> 
> # du -hsx  /
> 14G     /
> 
> And confirmed not to be due to sparse files or deleted but still open files.
> 
> The most interesting thing that I've been able to find so far is this:
> 
> # mount -o remount,ro /
> mount: / is busy
> # df -h /
> Filesystem                                              Size  Used Avail Use% Mounted on
> /dev/disk/by-uuid/<uuid>                                 50G   14G   33G  30% /
> 
> Something about attempting (and failing) to remount read-only frees up all of the phantom space usage.
> Curious whether that sparks ideas in anyone's mind?
> 
> I've tried all manner of other things without success.  Unmounting all of the overlays.  Killing off virtually all of usersapce (dropping to single user).  Dropping page/inode/dentry caches.Nothing else (short of a reboot) seems to give us the space back.
