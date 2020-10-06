Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26B09284422
	for <lists+linux-ext4@lfdr.de>; Tue,  6 Oct 2020 04:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgJFCva (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 5 Oct 2020 22:51:30 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:52858 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725909AbgJFCva (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 5 Oct 2020 22:51:30 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0962nwax106626;
        Tue, 6 Oct 2020 02:51:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=YosbUU7kIPdnSwmp8WXDorI0qaN8IkFGsOrxOmisByQ=;
 b=o/d8baE3rfitjkiEc+2W8xFn1pTeh35tEcBNdJsaGAm65xK2fy/zRSFUdjG8XQG3VWyh
 ETj1XOSUFr638HpqF6JG77zeXqNhXYoTMMwnOXVEIdoevGL5abYpkm83Hudr8vV2UOYH
 VZ1TEKEIaLx7ocsoXX4ZCCbeV/Bet7EN3MNZqIQi8zh65wbRpa+wX1TF3yUxhZaOleCJ
 4UkotrK1jzRqizjEJN+yprguqLZihtiWH1JMJnoNt+P+EMBp1SNgwW5wkyDaKbLvnR7+
 XXjkkve8Vs1La5Q3ZjU3Zp4j/gdhStg7anLGszJD2bCG7aXtbz7B/kJ3mUpX8th0cj/O 2w== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 33xhxmshps-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 06 Oct 2020 02:51:15 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0962omMm058934;
        Tue, 6 Oct 2020 02:51:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33y36xc7s8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 06 Oct 2020 02:51:14 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0962pBIn029775;
        Tue, 6 Oct 2020 02:51:11 GMT
Received: from localhost (/10.159.149.142)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 05 Oct 2020 19:51:11 -0700
Date:   Mon, 5 Oct 2020 19:51:10 -0700
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ext4@vger.kernel.org
Subject: Re: ext4 regression in v5.9-rc2 from e7bfb5c9bb3d on ro fs with
 overlapped bitmaps
Message-ID: <20201006025110.GJ49559@magnolia>
References: <CAHk-=wj-H5BYCU_kKiOK=B9sN3BtRzL4pnne2AJPyf54nQ+d=w@mail.gmail.com>
 <20201005081454.GA493107@localhost>
 <20201005173639.GA2311765@magnolia>
 <20201006003216.GB6553@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201006003216.GB6553@localhost>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010060016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9765 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 mlxlogscore=999 adultscore=0 clxscore=1015 spamscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010060016
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Oct 05, 2020 at 05:32:16PM -0700, Josh Triplett wrote:
> On Mon, Oct 05, 2020 at 10:36:39AM -0700, Darrick J. Wong wrote:
> > On Mon, Oct 05, 2020 at 01:14:54AM -0700, Josh Triplett wrote:
> > > Ran into an ext4 regression when testing upgrades to 5.9-rc kernels:
> > > 
> > > Commit e7bfb5c9bb3d ("ext4: handle add_system_zone() failure in
> > > ext4_setup_system_zone()") breaks mounting of read-only ext4 filesystems
> > > with intentionally overlapping bitmap blocks.
> > > 
> > > On an always-read-only filesystem explicitly marked with
> > > EXT4_FEATURE_RO_COMPAT_SHARED_BLOCKS, prior to that commit, it's safe to
> > > point all the block and inode bitmaps to a single block
> > 
> > LOL, WHAT?
> > 
> > I didn't know shared blocks applied to fs metadata.  I thought that
> > "shared" only applied to file extent maps being able to share physical
> > blocks.
> 
> The flag isn't documented very well yet, but since it specifically
> forces the filesystem to always be mounted read-only, the bitmaps really
> shouldn't matter at all. (In an ideal world, a permanently read-only
> filesystem should be able to omit all the bitmaps entirely. Pointing
> them all to a single disk block is the next best thing.)

I disagree; creating undocumented forks of an existing ondisk format
(especially one that presents as inconsistent metadata to regular tools)
is creating a ton of pain for future users and maintainers when the
incompat forks collide with the canonical implementation(s).

(Granted, I don't know if you /created/ this new interpretation of the
feature flag or if you've merely been stuck with it...)

I don't say that as a theoretical argument -- you've just crashed right
into this, because nobody knew that the in-kernel block validity doesn't
know how to deal with this other than to error out.

> > Could /somebody/ please document the ondisk format changes that are
> > associated with this feature?
> 
> I pretty much had to sort it out by looking at a combination of
> e2fsprogs and the kernel, and a lot of experimentation, until I ended up
> with something that the kernel was completely happy with without a
> single complaint.
> 
> I'd be happy to write up a summary of the format.

Seems like a good idea, particularly since you're asking for a format
change that requires kernel support and the ondisk format documentation
lives under Documentation/.  That said...

> I'd still really like to see this patch applied for 5.9, to avoid having
> filesystems that an old kernel can mount but a new one can't. This still
> seems like a regression to me.
> 
> > > of all 1s,
> > > because a read-only filesystem will never allocate or free any blocks or
> > > inodes.
> > 
> > All 1s?  So the inode bitmap says that every inode table slot is in use,
> > even if the inode record itself says it isn't?
> 
> Yes.
> 
> > What does e2fsck -n
> > think about that kind of metadata inconsistency?
> 
> If you set up the rest of the metadata consistently with it (for
> instance, 0 free blocks and 0 free inodes), you'll only get a single
> complaint, from the e2fsck equivalent of block_validity. See
> https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=956509 for details on
> that;

...Ted shot down this whole thing six months ago.

The Debian bug database is /not/ the designated forum to discuss changes
to the ondisk format; linux-ext4 is.

--D

> with that fixed, e2fsck wouldn't complain at all. The kernel,
> prior to 5.9-rc2, doesn't have a single complaint, whether at mount,
> unmount, or read of every file and directory on the filesystem.
> 
> The errors you got in your e2fsck run came because you just overrode the
> bitmaps, but didn't make the rest of the metadata consistent with that.
> I can provide a sample filesystem if that would help.
> 
> - Josh
