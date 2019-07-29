Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4464A78945
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Jul 2019 12:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728153AbfG2KJS (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 29 Jul 2019 06:09:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:49272 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726358AbfG2KJS (ORCPT <rfc822;linux-ext4@vger.kernel.org>);
        Mon, 29 Jul 2019 06:09:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 30933AF4E;
        Mon, 29 Jul 2019 10:09:17 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D59F51E4379; Mon, 29 Jul 2019 12:09:14 +0200 (CEST)
Date:   Mon, 29 Jul 2019 12:09:14 +0200
From:   Jan Kara <jack@suse.cz>
To:     Geoffrey Thomas <Geoffrey.Thomas@twosigma.com>
Cc:     'Theodore Ts'o' <tytso@mit.edu>,
        Thomas Walker <Thomas.Walker@twosigma.com>,
        'Jan Kara' <jack@suse.cz>,
        "'linux-ext4@vger.kernel.org'" <linux-ext4@vger.kernel.org>,
        "'Darrick J. Wong'" <darrick.wong@oracle.com>
Subject: Re: Phantom full ext4 root filesystems on 4.1 through 4.14 kernels
Message-ID: <20190729100914.GB17833@quack2.suse.cz>
References: <c7cfeaf451d7438781da95b01f21116e@exmbdft5.ad.twosigma.com>
 <20190123195922.GA16927@twosigma.com>
 <20190626151754.GA2789@twosigma.com>
 <20190711092315.GA10473@quack2.suse.cz>
 <96c4e04f8d5146c49ee9f4478c161dcb@EXMBDFT10.ad.twosigma.com>
 <20190711171046.GA13966@mit.edu>
 <20190712191903.GP2772@twosigma.com>
 <20190712202827.GA16730@mit.edu>
 <7cc876ae264c495e9868717f33a63a77@EXMBDFT10.ad.twosigma.com>
 <865a6dad983e4dedb9836075c210a782@EXMBDFT11.ad.twosigma.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865a6dad983e4dedb9836075c210a782@EXMBDFT11.ad.twosigma.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu 25-07-19 21:22:28, Geoffrey Thomas wrote:
> On Friday, July 12, 2019 5:47 PM, Geoffrey Thomas <Geoffrey.Thomas@twosigma.com> wrote:
> > On Friday, July 12, 2019 4:28 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> > > Hmmm... what's gid 4?  Is that a hint of where the inode might have come
> > > from?
> > 
> > Good call, gid 4 is `adm`. And now that we have an inode number we can see
> > the file's contents, it's from /var/log/account.
> > 
> > I bet that this is acct(2) holding onto a reference in some weird way
> > (possibly involving logrotate?), which also explains why we couldn't find
> > a userspace process holding onto the inode. We'll investigate a bit....
> 
> To close this out - yes, this was process accounting. Debian has a nightly cronjob which rotates the pacct logs, runs `invoke-rc.d acct restart` to reopen the file, and compresses the old log. Due to a stray policy-rc.d file from an old provisioning script, however, the restart was being skipped, and so we were unlinking and compressing the pacct file while the kernel still had it open. So it was the classic problem of an open file handle to a large deleted file, except that the open file handle was being held by the kernel.
> 
> `accton off` solved our immediate problems and freed the space. I'm not totally sure why a failed umount had that effect, too, but I suppose it turned off process accounting.
> 
> It's a little frustrating to me that the file opened by acct(2) doesn't show up to userspace (lsof doesn't seem to find it) - it'd be nice if it could show up in /proc/$some_kernel_thread/fd or somewhere, if possible.
> 
> Thanks for the help - the e2image + fsck trick is great!

Glad to hear you were able to solve the problem in the end :)

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
