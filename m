Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67E36479021
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Dec 2021 16:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhLQPmG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Dec 2021 10:42:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232425AbhLQPmF (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Dec 2021 10:42:05 -0500
X-Greylist: delayed 1928 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 17 Dec 2021 07:42:04 PST
Received: from top.wolffelaar.nl (top.wolffelaar.nl [IPv6:2a01:7c8:d006:9b:5054:ff:fe71:c4fc])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E03AC061574;
        Fri, 17 Dec 2021 07:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=wolffelaar.nl; s=202103.top; h=Message-ID:References:In-Reply-To:Subject:Cc
        :To:From:Date:Content-Transfer-Encoding:Content-Type:MIME-Version:Sender:
        Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
        :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=3rU2NucpADexhzJ+OcpPb0OQz9bw/D3NfmzXX2qTU6c=; b=OjTz14J6wvR8VBOQRYpN12oRIL
        o82LxtMJVYbII9+1xLIIAG2+dMin7qY6lv3AqX+QaoSJgLZ46IHWakfjIyyIKgvX3gPkuLyxmZ2uv
        VhHu510T3Til9b28w463yxJacBpNuJZlRc6ChQmR73e8xW0Y0BvIJbhu/4EjvvBN5cb01G8DvWh1v
        05Xvkdp0ulVAqHjDHqm9eLI2XkEnkKPRBIOJyT5pdGIo7fnPi+CqtniCL4pl+qkJCbJwVsomf2sMM
        hvRFb5G7NsTp76UCgpz0L1RwVojDHDwZTlJiTfYuqvKUchccCYOJIuyTHKHPwAQXp/MLH/HqBhzkH
        aFNp5Eww==;
Received: from localhost ([::1] helo=webmail.wolffelaar.nl)
        by top.wolffelaar.nl with esmtpa (Exim 4.92)
        (envelope-from <jeroen@wolffelaar.nl>)
        id 1myErm-0001m8-5k; Fri, 17 Dec 2021 16:09:50 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Fri, 17 Dec 2021 15:09:50 +0000
From:   Jeroen van Wolffelaar <jeroen@wolffelaar.nl>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     Lukas Czerner <lczerner@redhat.com>, Jan Kara <jack@suse.cz>,
        "Darrick J. Wong" <djwong@kernel.org>,
        =?UTF-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        linux-ext4@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ext4: set csum seed in tmp inode while migrating to
 extents
In-Reply-To: <YbuGLsQy6TSM2xOl@mit.edu>
References: <20211214175058.19511-1-lhenriques@suse.de>
 <20211215004945.GD69182@magnolia> <20211215112852.GM14044@quack2.suse.cz>
 <20211215141237.lrymhbebgjunh4n2@work> <YbuGLsQy6TSM2xOl@mit.edu>
Message-ID: <f8a4352c32b1c6d4407f6d1b99a2c43c@wolffelaar.nl>
X-Sender: jeroen@wolffelaar.nl
User-Agent: Roundcube Webmail/1.3.17
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

First of all, thanks Luís for figuring out the bug and writing a patch.

On 2021-12-16 18:32, Theodore Ts'o wrote:
> So the question is, is it worth it to continue supporting the migrate
> feature, or should we just delete all of the migration code, and risk
> users complaining that we've broken their use case?  The chances of
> that happening is admittedly low, and Linus's rule that "it's only
> breaking userspace if a user complains" means we might very well get
> away with it.  :-)

As the person who ran into this bug and then filed the issue in
bugzilla, my two cents:

I can do without the migration functionality, it is slightly
inconvenient, but that's it. I do believe having an always-broken
migration path (HEAD kernel, if csum is on) is much worse than not
having one. I don't personally care if a crash means I lose one or
several files, but I feel it's really not okay for chattr to risk losing
a file in a crash on a journalled filesystem. I would consider that a
severe data loss bug.

Thus, I support removing this feature. At the same time, I believe the
original patch is strictly better than the existing situation, so I also
support adding that to the kernel so that in the happy case, this
doesn't cause e2fsck failures, pending the (much longer) deprecation
path.


In case anyone cares, my usecase, so you can see it's quite esoteric.
You can also stop reading, I believe that's better :-P.

I have a rotation of harddisks that I use to have offline backups. They
were ext3 until the day I ran into this bug, I finally got around to
upgrading the filesystems (I never wanted to upgrade the instant ext4
became available, but arguably this is somewhat late too).

Because I knew -- out of prior interest -- that ext3 blocklists did not
have checksums, I wanted to ensure all existing files were csum too, so
extents. chattr +e promised to do exactly that. Well, it didn't work.

All files are indexed and checksummed, losing any or all, I can recover
from.  So a working chattr +e, even if it risks losing some or all data,
would be 'best' for my case. My alternative is just copying all files
in-disk, which is a few TiB of extra I/O, but whatever.

Recreating the filesystem is annoying, since that brings the number of
backup copies *intentionally* down by one, temporarily, which I do not
want to do. I want my buffer for unintentional failures.

Thank you all,
--Jeroen
