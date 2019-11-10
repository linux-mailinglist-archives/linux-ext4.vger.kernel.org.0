Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B24F690E
	for <lists+linux-ext4@lfdr.de>; Sun, 10 Nov 2019 14:14:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbfKJNOw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 10 Nov 2019 08:14:52 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:49255 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726301AbfKJNOv (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 10 Nov 2019 08:14:51 -0500
Received: from callcc.thunk.org ([199.116.115.139])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id xAADEh0g027911
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 10 Nov 2019 08:14:45 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9B53F4202FD; Sun, 10 Nov 2019 08:14:43 -0500 (EST)
Date:   Sun, 10 Nov 2019 08:14:43 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org
Subject: Re: [PATCH] resize2fs: Make minimum size estimates more reliable for
 mounted fs
Message-ID: <20191110131443.GI23325@mit.edu>
References: <20191018125059.2446-1-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191018125059.2446-1-jack@suse.cz>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 18, 2019 at 02:50:59PM +0200, Jan Kara wrote:
> Currently, the estimate of minimum filesystem size is using free blocks
> counter in the superblock. The counter generally doesn't get updated
> while the filesystem is mounted and thus the estimate is very unreliable
> for a mounted filesystem. For some usecases such as automated
> partitioning proposal to the user it is desirable that the estimate of
> minimum filesystem size is reasonably accurate even for a mounted
> filesystem. So use group descriptor counters of free blocks for the
> estimate of minimum filesystem size. These get updated together with
> block being allocated and so the resulting estimate is more accurate.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Thanks, applied.

						- Ted
