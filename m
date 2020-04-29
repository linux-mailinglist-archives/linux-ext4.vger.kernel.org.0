Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8131BD254
	for <lists+linux-ext4@lfdr.de>; Wed, 29 Apr 2020 04:42:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgD2CmG (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 28 Apr 2020 22:42:06 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:53895 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726345AbgD2CmG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Tue, 28 Apr 2020 22:42:06 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id 889BF3A296C;
        Wed, 29 Apr 2020 12:42:02 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jTcfh-0001e5-4c; Wed, 29 Apr 2020 12:42:01 +1000
Date:   Wed, 29 Apr 2020 12:42:01 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Francois <rigault.francois@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: ext4 and project quotas bugs
Message-ID: <20200429024201.GE2005@dread.disaster.area>
References: <CAMc2VtTqz5QuCfdtEBDND+-sU=7T5_8Sh9Wo-4-u6HbJs+PZdw@mail.gmail.com>
 <20200428153228.GB6426@quack2.suse.cz>
 <20200428155351.GH6733@magnolia>
 <20200428164824.GD6426@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200428164824.GD6426@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=cl8xLZFz6L8A:10 a=7-415B0cAAAA:8
        a=6m63xNJIwqfvyKoSR8cA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Apr 28, 2020 at 06:48:24PM +0200, Jan Kara wrote:
> On Tue 28-04-20 08:53:51, Darrick J. Wong wrote:
> > On Tue, Apr 28, 2020 at 05:32:28PM +0200, Jan Kara wrote:
> > > > dd if=/dev/zero of=someoutput oflag=append
> > > > dd: failed to open 'someoutput': Invalid argument
> > > 
> > > Yes, that's a bug that should be fixed. Thanks for reporting this! -1 means
> > > 'this id is not expressible in current user namespace' and some code gets
> > > confused along the way. We should refuse to set project -1 for a file...
> > 
> > Awkward part: projid 4294967295 is allowed on XFS (at least by the
> > kernel), though the xfs quota tools do not permit that.
> 
> Are you OK with just refusing to set projid 4294967295 for everybody? Or
> should we just not try to translate project IDs through user namespaces?
> Because XFS does not seem to translate them while ext4 does... What a mess.

We do not translate project IDs through user names space because
they are not usable as a mappable id. Project IDs are only used for
customised aggregation of space accounting, unlike UIDs and GIDS
that are used primarily for access control. IOWs, PRIDs are
fundamentally different to UIDs and GIDs.

Project IDs were already being used in the init namespace for
directory quotas to limit containers using bind mounts on a host
filesystem to an amount of disk space less than the entire hosting
filesystem.  And once you use PRIDs in the init namespace, they
cannot be used by users in other user namespaces, regardless of
whether they are mappable or not.

Essentially, the project ID mapping stuff was implemented by someone
who didn't understand what project IDs were or how project IDs were
being used, and then refused to listen to the people who knew these
things and wanted them to drop the PRID mapping stuff.  And then
Linus pulled their tree containing all the uid/gid/prid mapping code
without warning and we've been stuck with this shit ever since.

Hence in XFS we simply do not allow project IDs to be manipulated
outside of the init user namespace, and so mapping them is
irrelevant because users in confined namespaces cannot usefully
interact with them in any way.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
