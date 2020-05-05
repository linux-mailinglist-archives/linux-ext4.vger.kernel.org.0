Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 590011C4B11
	for <lists+linux-ext4@lfdr.de>; Tue,  5 May 2020 02:32:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726531AbgEEAc3 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 4 May 2020 20:32:29 -0400
Received: from mail104.syd.optusnet.com.au ([211.29.132.246]:37918 "EHLO
        mail104.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725981AbgEEAc3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 4 May 2020 20:32:29 -0400
Received: from dread.disaster.area (pa49-195-157-175.pa.nsw.optusnet.com.au [49.195.157.175])
        by mail104.syd.optusnet.com.au (Postfix) with ESMTPS id 4637958C06B;
        Tue,  5 May 2020 10:32:24 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1jVlVW-0000wq-5t; Tue, 05 May 2020 10:32:22 +1000
Date:   Tue, 5 May 2020 10:32:22 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Andreas Dilger <adilger@dilger.ca>, Jan Kara <jack@suse.cz>,
        Francois <rigault.francois@gmail.com>,
        Wang Shilong <wangshilong1991@gmail.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Subject: Re: ext4 and project quotas bugs
Message-ID: <20200505003222.GF2005@dread.disaster.area>
References: <CAMc2VtTqz5QuCfdtEBDND+-sU=7T5_8Sh9Wo-4-u6HbJs+PZdw@mail.gmail.com>
 <20200428153228.GB6426@quack2.suse.cz>
 <3FF8B32A-0CB2-4818-95AA-5E76FE494EDB@dilger.ca>
 <20200429150132.GJ6733@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200429150132.GJ6733@magnolia>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=W5xGqiek c=1 sm=1 tr=0
        a=ONQRW0k9raierNYdzxQi9Q==:117 a=ONQRW0k9raierNYdzxQi9Q==:17
        a=kj9zAlcOel0A:10 a=sTwFKg_x9MkA:10 a=VwQbUJbxAAAA:8 a=RPJ6JBhKAAAA:8
        a=7-415B0cAAAA:8 a=F5UFxqKIs3wLVhx5Mk4A:9 a=CjuIK1q_8ugA:10
        a=9EPSukFtP5IA:10 a=AjGcO6oz07-iQ99wixmX:22 a=fa_un-3J20JGBB2Tu-mn:22
        a=biEYGPWJfzWAr4FL6Ov7:22
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Apr 29, 2020 at 08:01:32AM -0700, Darrick J. Wong wrote:
> On Tue, Apr 28, 2020 at 09:34:09PM -0600, Andreas Dilger wrote:
> > On Apr 28, 2020, at 9:32 AM, Jan Kara <jack@suse.cz> wrote:
> > > 
> > > Hello!
> > > 
> > > On Tue 28-04-20 08:41:59, Francois wrote:
> > >> my goal is to make some kind of ansible playbook to install project
> > >> quotas, so I am interested in using a tool like setquota, I also want
> > >> the teams behind the capped directories, to think about a clean-up
> > >> mechanism (the quota would just be a temporary annoyance for them), so
> > >> it should not be "jailbreakable" too easily.
> > > 
> > > Hum, that "not jailbreakable" part is going to be difficult unless you also
> > > confine those users also in their user namespace. Because any user is
> > > allowed to change project ID of the files he owns arbitrarily if he is
> > > running in the initial user namespace. Project quotas have been designed as
> > > an advisory feature back in Irix days... There are talks of allowing to
> > > tweak the behavior (i.e., to allow setting of project id only by sysadmin)
> > > by a mount option but so far nobody has implemented it.
> > 
> > We tried to implement this for ext4, but Dave Chinner argued that
> > allowing anyone (at least in the root namespace) to set the project
> > ID to anything they wanted was part of how project quotas are
> > _supposed_ to work.
> > 
> > We ended up adding a restriction at the Lustre level, defaulting to
> > only allow root (chprojid_gid=0, via CAP_SYS_RESOURCE), or admins in
> > a specific numeric group (with chprojid_gid=N), to change the projid,
> > and denying regular users the ability to change the projid of files.
> > 
> > This can be changed by setting "chprojid_gid=-1" to allow users in
> > any group to change the projid of files, returning the XFS behavior.
> > The "chprojid_gid" is essentially a sysfs tunable for Lustre, but it
> > could also/instead be a mount option for ext4, if that is preferred.
> > I don't have a particular attachment to the parameter name, or how
> > it is set by the admin, but I think something like this is needed.
> > 
> > 
> > >> 2- project quota are a bit too easy to escape:
> > >> dd if=/dev/zero of=someoutput oflag=append
> > >> loop0: write failed, project block limit reached.
> > >> dd: writing to 'someoutput': Disk quota exceeded
> > >> 2467+0 records in
> > >> 2466+0 records out
> > >> 1262592 bytes (1.3 MB, 1.2 MiB) copied, 0.0105432 s, 120 MB/s
> > >> vagrant@localhost:/mnt/loop/abc/mydir3> chattr -p 33 someoutput
> > >> vagrant@localhost:/mnt/loop/abc/mydir3> dd if=/dev/zero of=someoutput
> > >> oflag=append
> > >> dd: writing to 'someoutput': No space left on device
> > >> 127393+0 records in
> > >> 127392+0 records out
> > >> 65224704 bytes (65 MB, 62 MiB) copied, 0.568859 s, 115 MB/s
> > > 
> > > Yes and as I mentioned above this is deliberate.
> > 
> > That may be the historical XFS behavior, but IMHO, it doesn't make
> > this behavior *useful*.  If *anyone* can change the projid of files
> > that makes them mostly useless.  They might be OK for informational
> > or accounting purposes (e.g. fast "du" of a directory) in a friendly
> > user environment, but they are useless for any space management (i.e.
> > anyone can easily bypass project limits by "chattr -p $RANDOM <file>").
> > 
> > I'd prefer to make the project quotas useful out of the box for ext4,
> > by implementing the chprojid_gid tunable, or something equivalent.
> > If there are users/sites that want identical behavior to XFS, they
> > can always set chprojid_gid=-1 to allow anyone to change the projid.
> > 
> > I'd be happy to understand what Dave doesn't like about this proposal,
> > but the last time the enforcement of project quotas was discussed, my
> > attempt to figure this out ended with silence, see thread ending at:
> > 
> > https://lore.kernel.org/linux-ext4/6B0D1F84-0718-4E43-87D4-C8AFC94C0163@dilger.ca/
> > 
> > Maybe this time we can get over the hump?  Is it just some implicit
> > difference between "directory quota" and "project quota" that exists
> > in XFS that I (and everyone using ext4) does not understand?
> 
> I don't have any particular objection to adding an admin-controlled
> means to restrict who can change project ids on a file, other than let's
> do this in a consistent way for the three fses that support prjquota.

That's my stance in a nutshell. Project quotas are not a "ext4 can
do whatever they like and screw everyone else" feature.

New features for project quotas *must* be consistently managed and
provide -exactly the same semantics- across all filesystems that
support project quotas. That means new management features is *must*
be supportable by all filesystems and implemented *in the same
patchset* for all filesystems that support project quotas.

Fragmenting the functionality space because "ext4 does not play well
with others" is not acceptible anymore. If you implement
functionality that other filesystems support and then want to extend
it, you need to bring all the other filesystems along with ext4.

> Personally, I thought Dave was stating how we got to the current
> prjquota implementation w/ non-entirely-intuitive Irix behavior and then
> asked for a concrete definition of new behavior + patches and was
> waiting to see if Wang or someone would send out f2fs/ext4/xfs patches...

Yup, that's pretty much it.

Cheers,

Dave.
-- 
Dave Chinner
david@fromorbit.com
