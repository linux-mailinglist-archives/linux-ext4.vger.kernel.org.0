Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4C617CF94
	for <lists+linux-ext4@lfdr.de>; Sat,  7 Mar 2020 19:11:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgCGSLR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sat, 7 Mar 2020 13:11:17 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:50753 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726109AbgCGSLR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sat, 7 Mar 2020 13:11:17 -0500
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 027IBDf9018525
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 7 Mar 2020 13:11:13 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 1DEB042045B; Sat,  7 Mar 2020 13:11:13 -0500 (EST)
Date:   Sat, 7 Mar 2020 13:11:13 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Lukas Czerner <lczerner@redhat.com>
Cc:     linux-ext4@vger.kernel.org, Zdenek Kabelac <zkabelac@redhat.com>,
        Karel Zak <kzak@redhat.com>,
        Carlos Maiolino <cmaiolino@redhat.com>
Subject: Re: [PATCH v2] libext2fs/ismounted.c: check open(O_EXCL) before
 mntent file
Message-ID: <20200307181113.GC99899@mit.edu>
References: <20200225143445.13182-1-lczerner@redhat.com>
 <20200303135348.20827-1-lczerner@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200303135348.20827-1-lczerner@redhat.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Mar 03, 2020 at 02:53:48PM +0100, Lukas Czerner wrote:
> Currently the ext2fs_check_mount_point() will use the open(O_EXCL) check
> on linux after all the other checks are done. However it is not
> necessary to check mntent if open(O_EXCL) succeeds because it means that
> the device is not mounted.
> 
> Moreover the commit ea4d53b7 introduced a regression where a following
> set of commands fails:
> 
> vgcreate mygroup /dev/sda
> lvcreate -L 1G -n lvol0 mygroup
> mkfs.ext4 /dev/mygroup/lvol0
> mount /dev/mygroup/lvol0 /mnt
> lvrename /dev/mygroup/lvol0 /dev/mygroup/lvol1
> lvcreate -L 1G -n lvol0 mygroup
> mkfs.ext4 /dev/mygroup/lvol0   <<<--- This fails
> 
> It fails because it thinks that /dev/mygroup/lvol0 is mounted because
> the device name in /proc/mounts is not updated following the lvrename.
> 
> Move the open(O_EXCL) check before the mntent check and return
> immediatelly if the device is not busy.
> 
> Fixes: ea4d53b7 ("libext2fs/ismounted.c: check device id in advance to skip false device names")
> Signed-off-by: Lukas Czerner <lczerner@redhat.com>
> Reported-by: Zdenek Kabelac <zkabelac@redhat.com>
> Reported-by: Karel Zak <kzak@redhat.com>
> Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>

Applied, thanks.

						- Ted
