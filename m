Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 97BA075970
	for <lists+linux-ext4@lfdr.de>; Thu, 25 Jul 2019 23:22:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfGYVW3 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Thu, 25 Jul 2019 17:22:29 -0400
Received: from mxo2.dft.dmz.twosigma.com ([208.77.212.182]:33033 "EHLO
        mxo2.dft.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726585AbfGYVW3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 25 Jul 2019 17:22:29 -0400
Received: from localhost (localhost [127.0.0.1])
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTP id 45vlY05R0bz7t8t;
        Thu, 25 Jul 2019 21:22:28 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.dft.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.dft.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4_rYKg-GfsKT; Thu, 25 Jul 2019 21:22:28 +0000 (GMT)
Received: from exmbdft6.ad.twosigma.com (exmbdft6.ad.twosigma.com [172.22.1.5])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.dft.dmz.twosigma.com (Postfix) with ESMTPS id 45vlY04rNXz3wZ5;
        Thu, 25 Jul 2019 21:22:28 +0000 (GMT)
Received: from EXMBDFT10.ad.twosigma.com (172.23.127.159) by
 exmbdft6.ad.twosigma.com (172.22.1.5) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Thu, 25 Jul 2019 21:22:28 +0000
Received: from EXMBDFT11.ad.twosigma.com (172.23.162.14) by
 EXMBDFT10.ad.twosigma.com (172.23.127.159) with Microsoft SMTP Server (TLS)
 id 15.0.1365.1; Thu, 25 Jul 2019 21:22:28 +0000
Received: from EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9]) by
 EXMBDFT11.ad.twosigma.com ([fe80::8d66:2326:5416:86a9%19]) with mapi id
 15.00.1365.000; Thu, 25 Jul 2019 21:22:28 +0000
From:   Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>
To:     'Theodore Ts'o' <tytso@mit.edu>,
        Thomas Walker <Thomas.Walker@twosigma.com>
CC:     'Jan Kara' <jack@suse.cz>,
        "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>,
        "'Darrick J. Wong'" <darrick.wong@oracle.com>
Subject: RE: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Thread-Topic: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Thread-Index: AQHVLDJVDWy5GscrLU+Z6omBu3PDnabFPCSAgABXnMCAACsDAIABti2AgAATZICAABR0YIAUWz0Q
Date:   Thu, 25 Jul 2019 21:22:28 +0000
Message-ID: <865a6dad983e4dedb9836075c210a782@EXMBDFT11.ad.twosigma.com>
References: <9abbdde6145a4887a8d32c65974f7832@exmbdft5.ad.twosigma.com>
 <20181108184722.GB27852@magnolia>
 <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com> <20190626151754.GA2789@twosigma.com>
 <20190711092315.GA10473@quack2.suse.cz>
 <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
 <20190711171046.GA13966@mit.edu> <20190712191903.GP2772@twosigma.com>
 <20190712202827.GA16730@mit.edu>
 <7cc876ae264c495e9868717f33a63a77@EXMBDFT10.ad.twosigma.com>
In-Reply-To: <7cc876ae264c495e9868717f33a63a77@EXMBDFT10.ad.twosigma.com>
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

On Friday, July 12, 2019 5:47 PM, Geoffrey Thomas <Geoffrey.Thomas@twosigma.com> wrote:
> On Friday, July 12, 2019 4:28 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> > Hmmm... what's gid 4?  Is that a hint of where the inode might have come
> > from?
> 
> Good call, gid 4 is `adm`. And now that we have an inode number we can see
> the file's contents, it's from /var/log/account.
> 
> I bet that this is acct(2) holding onto a reference in some weird way
> (possibly involving logrotate?), which also explains why we couldn't find
> a userspace process holding onto the inode. We'll investigate a bit....

To close this out - yes, this was process accounting. Debian has a nightly cronjob which rotates the pacct logs, runs `invoke-rc.d acct restart` to reopen the file, and compresses the old log. Due to a stray policy-rc.d file from an old provisioning script, however, the restart was being skipped, and so we were unlinking and compressing the pacct file while the kernel still had it open. So it was the classic problem of an open file handle to a large deleted file, except that the open file handle was being held by the kernel.

`accton off` solved our immediate problems and freed the space. I'm not totally sure why a failed umount had that effect, too, but I suppose it turned off process accounting.

It's a little frustrating to me that the file opened by acct(2) doesn't show up to userspace (lsof doesn't seem to find it) - it'd be nice if it could show up in /proc/$some_kernel_thread/fd or somewhere, if possible.

Thanks for the help - the e2image + fsck trick is great!

-- 
Geoffrey Thomas
geofft@twosigma.com
