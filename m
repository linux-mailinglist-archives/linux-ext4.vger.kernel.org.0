Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 36A4A1C4B23
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 02:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726635AbgEEAoC (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 May 2020 20:44:02 -0400
Received: from mail105.syd.optusnet.com.au ([211.29.132.249]:34931 "EHLO
        mail105.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726550AbgEEAoC (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 May 2020 20:44:02 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail105.syd.optusnet.com.au (Postfix) with ESMTPS id EA7543A3908;
        Tue,  5 May 2020 10:43:59 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jVlgk-0000xg-LW; Tue, 05 May 2020 10:43:58 +1000
Date:   Tue, 5 May 2020 10:43:58 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Jan Kara <jack@suse.cz>
Cc:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Francois <rigault.francois@gmail.com>, linux-ext4@vger.kernel.org
Subject: Re: ext4 and project quotas bugs
Message-ID: <20200505004358.GG2005@dread.disaster.area>
References: <CAMc2VtTqz5QuCfdtEBDND+-sU=7T5_8Sh9Wo-4-u6HbJs+PZdw@mail.gmail.com>
 <20200428153228.GB6426@quack2.suse.cz>
 <20200428155351.GH6733@magnolia>
 <20200428164824.GD6426@quack2.suse.cz>
 <20200429024201.GE2005@dread.disaster.area>
 <20200430111436.GD12716@quack2.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430111436.GD12716@quack2.suse.cz>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=QIgWuTDL c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=7-415B0cAAAA:8
        a=RKuqs710FA7j12_tIekA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Apr 30, 2020 at 01:14:36PM +0200, Jan Kara wrote:
> On Wed 29-04-20 12:42:01, Dave Chinner wrote:
> > On Tue, Apr 28, 2020 at 06:48:24PM +0200, Jan Kara wrote:
> > > On Tue 28-04-20 08:53:51, Darrick J. Wong wrote:
> > > > On Tue, Apr 28, 2020 at 05:32:28PM +0200, Jan Kara wrote:
> > > > > > dd if=/dev/zero of=someoutput oflag=append
> > > > > > dd: failed to open 'someoutput': Invalid argument
> > > > > 
> > > > > Yes, that's a bug that should be fixed. Thanks for reporting this! -1 means
> > > > > 'this id is not expressible in current user namespace' and some code gets
> > > > > confused along the way. We should refuse to set project -1 for a file...
> > > > 
> > > > Awkward part: projid 4294967295 is allowed on XFS (at least by the
> > > > kernel), though the xfs quota tools do not permit that.
> > > 
> > > Are you OK with just refusing to set projid 4294967295 for everybody? Or
> > > should we just not try to translate project IDs through user namespaces?
> > > Because XFS does not seem to translate them while ext4 does... What a mess.
> > 
> > We do not translate project IDs through user names space because
> > they are not usable as a mappable id. Project IDs are only used for
> > customised aggregation of space accounting, unlike UIDs and GIDS
> > that are used primarily for access control. IOWs, PRIDs are
> > fundamentally different to UIDs and GIDs.
> > 
> > Project IDs were already being used in the init namespace for
> > directory quotas to limit containers using bind mounts on a host
> > filesystem to an amount of disk space less than the entire hosting
> > filesystem.  And once you use PRIDs in the init namespace, they
> > cannot be used by users in other user namespaces, regardless of
> > whether they are mappable or not.
> 
> OK, understood.
> 
> > Essentially, the project ID mapping stuff was implemented by someone
> > who didn't understand what project IDs were or how project IDs were
> > being used, and then refused to listen to the people who knew these
> > things and wanted them to drop the PRID mapping stuff.  And then
> > Linus pulled their tree containing all the uid/gid/prid mapping code
> > without warning and we've been stuck with this shit ever since.
> > 
> > Hence in XFS we simply do not allow project IDs to be manipulated
> > outside of the init user namespace, and so mapping them is
> > irrelevant because users in confined namespaces cannot usefully
> > interact with them in any way.
> 
> So in ext4 we also don't currently allow anybody outside init user
> namespace to change project IDs. Also as I'm now checking the projid
> handling in ext4 more closely, we always transform project ID only to/from
> init_user_ns (even in FSGETXATTR ioctl) so it's more or less pointless and
> equivalent to XFS not transforming anything AFAIU.

*nod*

> So the only problem is really with VFS quota code. There we do mapping of
> passed project ID from current_user_ns() in fs/quota/quota.c before passing
> the ID further to the core quota code. Practically, this is only relevant
> for GETQUOTA quotactl calls because all the others are restricted to
> init_user_ns capable CAP_SYS_ADMIN so they can get called only from
> init_user_ns.
> 
> Now we also have a check like:
> 
>         /* Filesystems outside of init_user_ns not yet supported */
>         if (sb->s_user_ns != &init_user_ns) {
>                 error = -EINVAL;
>                 goto out_fmt;
>         }
> 
> in dquot_load_quota_sb() which is the quota enabling function. So we don't
> allow any quotas for filesystems outside of init_user_ns. So the
> qid_has_mapping() checks are mostly pointless as sb->s_user_ns is always
> init_user_ns. But this is except for id -1, which doesn't have mapping even
> in init_user_ns...

ISTR that was done because it was supposed to be the "invalid ID"
indicator, and so it common across everything? Kinda like the
"nobody" UID? 

[ Apart from the fact that older XFS filesystems only support 16 bit
project IDs, so using 2^32-1 for anything is kinda troublesome. ]

> So I'm pondering what's the best way out of this mess. Currently, the
> mapping of project IDs in quota code has rather limited impact and we may
> be able to get away with just removing it (i.e. without causing a
> regression for any real user). So that's certainly one option.  But then we
> should probably also remove the capability to specify (non-trivial) project
> ID maps for user namespaces because having maps that are not actually
> applied is pretty confusing.

*nod*

> Then there's a second option: Is there a reason *not* to map project IDs
> in user namespaces? I understand it's pointless with how project ids are
> currently used but it does not harm either AFAIU. The only real harm is
> with id -1 not being usable. Also when people create fs mount option where
> project ID is changeable by CAP_SYS_ADMIN (or maybe CAP_SYS_RESOURCE)
> capable user - and there are several people asking for a functionality like
> this - then fully mapping project IDs would IMHO make more sence.

I'm not opposed to doing this, however I have not had anyone at all
ask for this functionality at all. SO perhaps it would be better to
start with describing the use cases and user requirements so can
get a better idea of the applications that people want to use
mappable prids for...

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
