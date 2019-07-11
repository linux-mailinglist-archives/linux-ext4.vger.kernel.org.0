Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 452D865955
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jul 2019 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728579AbfGKOtT convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 11 Jul 2019 10:49:19 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:49625 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728471AbfGKOtT (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Jul 2019 10:49:19 -0400
X-Greylist: delayed 515 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2019 10:49:19 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 45kzHv6Qhnz7t91;
        Thu, 11 Jul 2019 14:40:43 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id tyjWWggbRvj8; Thu, 11 Jul 2019 14:40:43 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 45kzHv5mXlz3wZ5;
        Thu, 11 Jul 2019 14:40:43 +0000 (GMT)
Received: from EXMBDFT10.ad.twosigma.com (172.23.127.159) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Thu, 11 Jul 2019 14:40:43 +0000
Received: from EXMBDFT10.ad.twosigma.com ([fe80::5821:6415:3fad:203e]) by
 EXMBDFT10.ad.twosigma.com ([fe80::5821:6415:3fad:203e%19]) with mapi id
 15.00.1365.000; Thu, 11 Jul 2019 14:40:43 +0000
From:   Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>
To:     'Jan Kara' <jack@suse.cz>,
        Thomas Walker <Thomas.Walker@twosigma.com>
CC:     "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "'tytso@mit.edu'" <tytso@mit.edu>
Subject: RE: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Thread-Topic: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Thread-Index: AQHVLDJVDWy5GscrLU+Z6omBu3PDnabFPCSAgABXnMA=
Date:   Thu, 11 Jul 2019 14:40:43 +0000
Message-ID: <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
References: <9abbdde6145a4887a8d32c65974f7832@exmbdft5.ad.twosigma.com>
 <20181108184722.GB27852@magnolia>
 <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com> <20190626151754.GA2789@twosigma.com>
 <20190711092315.GA10473@quack2.suse.cz>
In-Reply-To: <20190711092315.GA10473@quack2.suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [192.168.147.160]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thursday, July 11, 2019 5:23 AM, Jan Kara <jack@suse.cz> wrote: 
> On Wed 26-06-19 11:17:54, Thomas Walker wrote:
> > Sorry to revive a rather old thread, but Elana mentioned that there might
> > have been a related fix recently?  Possibly something to do with
> > truncate?  A quick scan of the last month or so turned up
> > https://www.spinics.net/lists/linux-ext4/msg65772.html but none of these
> > seemed obviously applicable to me.  We do still experience this phantom
> > space usage quite frequently (although the remount workaround below has
> > lowered the priority).
> 
> I don't recall any fix for this. But seeing that remount "fixes" the issue
> for you can you try whether one of the following has a similar effect?
> 
> 1) Try "sync"
> 2) Try "fsfreeze -f / && fsfreeze -u /"
> 3) Try "echo 3 >/proc/sys/vm/drop_caches"
> 
> Also what is the contents of
> /sys/fs/ext4/<problematic-device>/delayed_allocation_blocks
> when the issue happens?

We just had one of these today, and no luck from any of those. delayed_allocation_blocks is 1:

# df -h /
Filesystem                                              Size  Used Avail Use% Mounted on
/dev/disk/by-uuid/523c8243-5a25-40eb-8627-f3bbf98ec299   50G   47G  455M 100% /
# ls -l /dev/disk/by-uuid/523c8243-5a25-40eb-8627-f3bbf98ec299
lrwxrwxrwx 1 root root 10 Mar  8 16:03 /dev/disk/by-uuid/523c8243-5a25-40eb-8627-f3bbf98ec299 -> ../../sda3
# cat /sys/fs/ext4/sda3/delayed_allocation_blocks
1
# sync; sync; sync
# df -h /
Filesystem                                              Size  Used Avail Use% Mounted on
/dev/disk/by-uuid/523c8243-5a25-40eb-8627-f3bbf98ec299   50G   47G  455M 100% /
# fsfreeze -f /; fsfreeze -u /
# df -h /
Filesystem                                              Size  Used Avail Use% Mounted on
/dev/disk/by-uuid/523c8243-5a25-40eb-8627-f3bbf98ec299   50G   47G  455M 100% /
# echo 3 > /proc/sys/vm/drop_caches
[blocks for about 10 seconds]
# df -h /
Filesystem                                              Size  Used Avail Use% Mounted on
/dev/disk/by-uuid/523c8243-5a25-40eb-8627-f3bbf98ec299   50G   47G  454M 100% /
# umount /
[blocks for about 2 seconds]
umount: /: device is busy.
        (In some cases useful info about processes that use
         the device is found by lsof(8) or fuser(1))
# df -h /
Filesystem                                              Size  Used Avail Use% Mounted on
/dev/disk/by-uuid/523c8243-5a25-40eb-8627-f3bbf98ec299   50G   16G   32G  33% /
# uname -r
4.14.67-ts1

-- 
Geoffrey Thomas
geofft@twosigma.com
