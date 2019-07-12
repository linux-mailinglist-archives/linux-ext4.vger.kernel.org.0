Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AEF1367662
	for <lists+linux-ext4@lfdr.de>; Sat, 13 Jul 2019 00:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbfGLWEb convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-ext4@lfdr.de>); Fri, 12 Jul 2019 18:04:31 -0400
Received: from mxo2.nje.dmz.twosigma.com ([208.77.214.162]:40429 "EHLO
        mxo2.nje.dmz.twosigma.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727245AbfGLWEb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 12 Jul 2019 18:04:31 -0400
X-Greylist: delayed 600 seconds by postgrey-1.27 at vger.kernel.org; Fri, 12 Jul 2019 18:04:31 EDT
Received: from localhost (localhost [127.0.0.1])
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTP id 45lmjZ1ZZxz7t8t;
        Fri, 12 Jul 2019 21:47:14 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at twosigma.com
Received: from mxo2.nje.dmz.twosigma.com ([127.0.0.1])
        by localhost (mxo2.nje.dmz.twosigma.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Fr0fccIZnsUp; Fri, 12 Jul 2019 21:47:14 +0000 (GMT)
Received: from exmbdft7.ad.twosigma.com (exmbdft7.ad.twosigma.com [172.22.2.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mxo2.nje.dmz.twosigma.com (Postfix) with ESMTPS id 45lmjZ0t5Rz3wZ3;
        Fri, 12 Jul 2019 21:47:14 +0000 (GMT)
Received: from EXMBDFT10.ad.twosigma.com (172.23.127.159) by
 exmbdft7.ad.twosigma.com (172.22.2.43) with Microsoft SMTP Server (TLS) id
 15.0.1365.1; Fri, 12 Jul 2019 21:47:13 +0000
Received: from EXMBDFT10.ad.twosigma.com ([fe80::5821:6415:3fad:203e]) by
 EXMBDFT10.ad.twosigma.com ([fe80::5821:6415:3fad:203e%19]) with mapi id
 15.00.1365.000; Fri, 12 Jul 2019 21:47:13 +0000
From:   Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>
To:     'Theodore Ts'o' <tytso@mit.edu>,
        Thomas Walker <Thomas.Walker@twosigma.com>
CC:     'Jan Kara' <jack@suse.cz>,
        "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Subject: RE: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Thread-Topic: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Thread-Index: AQHVLDJVDWy5GscrLU+Z6omBu3PDnabFPCSAgABXnMCAACsDAIABti2AgAATZICAABR0YA==
Date:   Fri, 12 Jul 2019 21:47:13 +0000
Message-ID: <7cc876ae264c495e9868717f33a63a77@EXMBDFT10.ad.twosigma.com>
References: <9abbdde6145a4887a8d32c65974f7832@exmbdft5.ad.twosigma.com>
 <20181108184722.GB27852@magnolia>
 <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com> <20190626151754.GA2789@twosigma.com>
 <20190711092315.GA10473@quack2.suse.cz>
 <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
 <20190711171046.GA13966@mit.edu> <20190712191903.GP2772@twosigma.com>
 <20190712202827.GA16730@mit.edu>
In-Reply-To: <20190712202827.GA16730@mit.edu>
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

On Friday, July 12, 2019 4:28 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> To: Thomas Walker <Thomas.Walker@twosigma.com>
> Cc: Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>; 'Jan Kara'
> <jack@suse.cz>; 'linux-ext4@vger.kernel.org' <linux-ext4@vger.kernel.org>;
> Darrick J. Wong <darrick.wong@oracle.com>
> Subject: Re: Phantom full ext4 root filesystems on 4.1 through 4.14
> kernels
> 
> On Fri, Jul 12, 2019 at 03:19:03PM -0400, Thomas Walker wrote:
> > Clearing orphaned inode 1048838 (uid=0, gid=4, mode=0100640,
> size=39006841856)
> 
> > Of particular note, ino 1048838 matches the size of the space that we
> "lost".
> 
> Hmmm... what's gid 4?  Is that a hint of where the inode might have come
> from?

Good call, gid 4 is `adm`. And now that we have an inode number we can see the file's contents, it's from /var/log/account. 

I bet that this is acct(2) holding onto a reference in some weird way (possibly involving logrotate?), which also explains why we couldn't find a userspace process holding onto the inode. We'll investigate a bit....

Thanks,
-- 
Geoffrey Thomas
geofft@twosigma.com
