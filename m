Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8B72EEA04
	for <lists+linux-ext4@lfdr.de>; Fri,  8 Jan 2021 00:55:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729110AbhAGXyv (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 7 Jan 2021 18:54:51 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:32906 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727858AbhAGXyv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 7 Jan 2021 18:54:51 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107NrfIo142252;
        Thu, 7 Jan 2021 23:53:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=XmsIp9Zfga5rvuoJrqoBPasGOnyJ8zj0Web421dIPCw=;
 b=Bfq+C6lyaVF40FuIrCCO1zwWV+lWbh9cH9DbPqcm+elzaJ4M6/24+9I1/f8L6Ll4YbYb
 9jBnpv1cqVikgPrEUALeI3gwbkMLQGCgy/i5y7m17vwizSAK2tvC5MMDeE04cAPqkAXC
 NPFkZAoZdhVhN6GSiu3zSTDNlfiRwpk4Oigf80GyS17H2tcb4x6GfR14bazuEgtSfPjT
 U9lby2T1KDcMMxDC3Uv+639IMaQf7daHnKROqR43dONIMZ1F30Z9xWeOO3zGsJO8h/f/
 gZU+GDmPJQ8oHQqKeHtC0793SWcWOzHYTQZdghxURdkpwODzmQV5P5gczPbCtruTTiTr Gg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 35wftxegs2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 07 Jan 2021 23:53:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 107NaUEB129484;
        Thu, 7 Jan 2021 23:53:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 35w3quga70-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 07 Jan 2021 23:53:32 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 107NrUWe004278;
        Thu, 7 Jan 2021 23:53:30 GMT
Received: from localhost (/10.159.138.126)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 07 Jan 2021 23:53:30 +0000
Date:   Thu, 7 Jan 2021 15:53:28 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Arnd Bergmann <arnd@kernel.org>, "Theodore Ts'o" <tytso@mit.edu>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Will Deacon <will@kernel.org>,
        linux-toolchains@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: Aarch64 EXT4FS inode checksum failures - seems to be weak memory
 ordering issues
Message-ID: <20210107235328.GI6908@magnolia>
References: <20210106135253.GJ1551@shell.armlinux.org.uk>
 <20210106172033.GA2165@willie-the-truck>
 <20210106223223.GM1551@shell.armlinux.org.uk>
 <20210107111841.GN1551@shell.armlinux.org.uk>
 <20210107124506.GO1551@shell.armlinux.org.uk>
 <CAK8P3a2TXPfFpgy+XjpDzOqt1qpDxufwiD-BLNbn4W_jpGp98g@mail.gmail.com>
 <20210107133747.GP1551@shell.armlinux.org.uk>
 <X/c2aqSvYCaB9sR6@mit.edu>
 <CAK8P3a2svyz1KXSqSUMVeDqdag4f1VcERH9jpECSLsn-FWvZbw@mail.gmail.com>
 <X/eK5xIMK5yZ2/tl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/eK5xIMK5yZ2/tl@gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 spamscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070132
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9857 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 clxscore=1011
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2101070133
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jan 07, 2021 at 02:27:51PM -0800, Eric Biggers wrote:
> On Thu, Jan 07, 2021 at 10:48:05PM +0100, Arnd Bergmann wrote:
> > On Thu, Jan 7, 2021 at 5:27 PM Theodore Ts'o <tytso@mit.edu> wrote:
> > >
> > > On Thu, Jan 07, 2021 at 01:37:47PM +0000, Russell King - ARM Linux admin wrote:
> > > > > The gcc bugzilla mentions backports into gcc-linaro, but I do not see
> > > > > them in my git history.
> > > >
> > > > So, do we raise the minimum gcc version for the kernel as a whole to 5.1
> > > > or just for aarch64?
> > >
> > > Russell, Arnd, thanks so much for tracking down the root cause of the
> > > bug!
> > 
> > There is one more thing that I wondered about when looking through
> > the ext4 code: Should it just call the crc32c_le() function directly
> > instead of going through the crypto layer? It seems that with Ard's
> > rework from 2018, that can just call the underlying architecture specific
> > implementation anyway.
> > 
> 
> It looks like that would work, although note that crc32c_le() uses the shash API
> too, so it isn't any more "direct" than what ext4 does now.

Yes.

> Also, a potential issue is that the implementation of crc32c that crc32c_le()
> uses might be chosen too early if the architecture-specific implementation of
> crc32c is compiled as a module (e.g. crc32c-intel.ko).

This was the primary reason I chose to do it this way for ext4.

The other is that ext4 didn't use crc32c before metadata_csum, so
there's no point in pulling in the crypto layer if you're only going to
use older ext2 or ext3 filesystems.  That was 2010, maybe people have
stopped doing that?

> There are two ways this
> could be fixed -- either by making it a proper library API like blake2s() that
> can call the architecture-specific code directly, or by reconfiguring things
> when a new crypto module is loaded (like what lib/crc-t10dif.c does).

Though I would like to see the library functions gain the ability to use
whatever is the fastest mechanism available once we can be reasonably
certain that all the platform-specific drivers have been loaded.

That said, IIRC most distros compile all of them into their
(increasingly large) vmlinuz files so maybe this isn't much of practical
concern?

--D
> 
> Until one of those is done, switching to crc32c_le() might cause performance
> regressions.
> 
> - Eric
