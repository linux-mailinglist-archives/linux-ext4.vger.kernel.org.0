Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F907481A12
	for <lists+linux-ext4@lfdr.de>; Thu, 30 Dec 2021 07:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236707AbhL3G5M (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 30 Dec 2021 01:57:12 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:57948 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S229514AbhL3G5M (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 30 Dec 2021 01:57:12 -0500
Received: from cwcc.thunk.org (pool-108-7-220-252.bstnma.fios.verizon.net [108.7.220.252])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 1BU6un75028402
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 30 Dec 2021 01:56:50 -0500
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 488E515C33A3; Thu, 30 Dec 2021 01:56:49 -0500 (EST)
Date:   Thu, 30 Dec 2021 01:56:49 -0500
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        =?iso-8859-1?Q?Lu=EDs?= Henriques <lhenriques@suse.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to
 extents
Message-ID: <Yc1YMUryayqc8fUk@mit.edu>
References: <20211214175058.19511-1-lhenriques@suse.de>
 <20211215004945.GD69182@magnolia>
 <20211215112852.GM14044@quack2.suse.cz>
 <20211215141237.lrymhbebgjunh4n2@work>
 <YbuGLsQy6TSM2xOl@mit.edu>
 <20211217093534.2ug6e5cm37md2c3u@work>
 <20211228224017.GA2242@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211228224017.GA2242@duo.ucw.cz>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Dec 28, 2021 at 11:40:17PM +0100, Pavel Machek wrote:
> > Our rationale behind not supporting the migration was always the fact
> > that we felt that backup was absolutely necessary before operation like
> > this. When you already have up-to-date backup available you might as
> > well create a fresh ext4 file system with all the advantages it brings
> > and recover data from said backup. I think this is still a very
> > reasonable approach.
> 
> Umm. Not really?
> 
> First... full backup/restore will take a _long_ time.

How big is an ext3 file system going to be, though?  Ext4 was
available in RHEL 5, and was fully supported in RHEL 6 --- which was
released in the year 2000.  Back in 2000, the biggest Seagate
Barracuda drive you could get was 30GB.  The biggest disk available at
that time was the IBM Deskstar 75GXP, which was 75GB.

So a 5 disk RAID array from the era where you might have still been
using ext3 *might* have been as large as 300GB.

> Second... if you do online migration, you have filesystem you are
> quite unlikely to corrupt, and backup you are unlikely to use. If you
> do backup/restore, you have to be _way_ more careful that backup media
> is reliable etc.

21 years later, those IDE disks are probably not even functioning any
more.  Every 4-7 years, depending on how careful you want to be, you'd
would be well-advised to buy new hard drives, since back then disk
drive capacities were doubling every 18-24 months.  And so the sane
thing to do would be to do a disk-to-disk transfer.  That is, you buy
a new computer, with brand new hard drives, install the latest distro
(many companies would only upgrade distros when they upgraded their
hardware), and so you'd format new hard drives with the latest file
system, and do a disk-to-disk transfer from the old system to the new
system.

Quite frankly, if you aren't willing to copy the data from your
ancient spinning rust platters (and back then, they probably *were*
actually iron oxide :-), your largest risk would be the HDD
self-destructing from extreme old age.  :-)

							- Ted

