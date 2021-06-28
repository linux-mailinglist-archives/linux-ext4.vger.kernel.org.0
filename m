Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB7C3B565B
	for <lists+linux-ext4@lfdr.de>; Mon, 28 Jun 2021 02:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231725AbhF1AmW (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 27 Jun 2021 20:42:22 -0400
Received: from mail110.syd.optusnet.com.au ([211.29.132.97]:37016 "EHLO
        mail110.syd.optusnet.com.au" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231689AbhF1AmW (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>);
        Sun, 27 Jun 2021 20:42:22 -0400
Received: from dread.disaster.area (pa49-179-138-183.pa.nsw.optusnet.com.au [49.179.138.183])
        by mail110.syd.optusnet.com.au (Postfix) with ESMTPS id 7D784107992;
        Mon, 28 Jun 2021 10:39:55 +1000 (AEST)
Received: from dave by dread.disaster.area with local (Exim 4.92.3)
        (envelope-from <david@fromorbit.com>)
        id 1lxfJa-000Buk-6p; Mon, 28 Jun 2021 10:39:54 +1000
Date:   Mon, 28 Jun 2021 10:39:54 +1000
From:   Dave Chinner <david@fromorbit.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Wang Shilong <wshilong@ddn.com>
Subject: Re: [PATCH] ext4: forbid U32_MAX project ID
Message-ID: <20210628003954.GM2419729@dread.disaster.area>
References: <20210625124033.5639-1-wangshilong1991@gmail.com>
 <20210627224217.GL2419729@dread.disaster.area>
 <CAP9B-Qnngwh+PL3wEBRWZQszaO00h5W=wiQG1WT3MBT65oMhyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9B-Qnngwh+PL3wEBRWZQszaO00h5W=wiQG1WT3MBT65oMhyw@mail.gmail.com>
X-Optus-CM-Score: 0
X-Optus-CM-Analysis: v=2.3 cv=F8MpiZpN c=1 sm=1 tr=0
        a=MnllW2CieawZLw/OcHE/Ng==:117 a=MnllW2CieawZLw/OcHE/Ng==:17
        a=kj9zAlcOel0A:10 a=r6YtysWOX24A:10 a=7-415B0cAAAA:8 a=lB0dNpNiAAAA:8
        a=9nCa61v3IhUg5NtY66YA:9 a=CjuIK1q_8ugA:10 a=biEYGPWJfzWAr4FL6Ov7:22
        a=c-ZiYqmG3AbHTdtsH08C:22
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 28, 2021 at 07:13:04AM +0800, Wang Shilong wrote:
> On Mon, Jun 28, 2021 at 6:42 AM Dave Chinner <david@fromorbit.com> wrote:
> >
> > On Fri, Jun 25, 2021 at 08:40:33AM -0400, Wang Shilong wrote:
> > > From: Wang Shilong <wshilong@ddn.com>
> > >
> > > U32_MAX is reserved for special purpose,
> > > qid_has_mapping() will return false if projid is
> > > 4294967295, dqget() will return NULL for it.
> > >
> > > So U32_MAX is unsupported Project ID, fix to forbid
> > > it.
> >
> > Actually, it's INVALID_PROJID, not U32_MAX, and we already have a
> > check function for that:
> >
> > static inline bool projid_valid(kprojid_t projid)
> > {
> >         return !projid_eq(projid, INVALID_PROJID);
> > }
> >
> 
> I was not aware of this, thanks for pointing it out.
> 
> > > Signed-off-by: Wang Shilong <wshilong@ddn.com>
> > > ---
> > >  fs/ext4/ioctl.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/fs/ext4/ioctl.c b/fs/ext4/ioctl.c
> > > index 31627f7dc5cd..f3a8d962c291 100644
> > > --- a/fs/ext4/ioctl.c
> > > +++ b/fs/ext4/ioctl.c
> > > @@ -744,6 +744,9 @@ int ext4_fileattr_set(struct user_namespace *mnt_userns,
> > >       u32 flags = fa->flags;
> > >       int err = -EOPNOTSUPP;
> > >
> > > +     if (fa->fsx_projid >= U32_MAX)
> > > +             return -EINVAL;
> > > +
> >
> > This should actually be calling qid_valid() or projid_valid(),
> > and it should be in generic code because multiple filesystems
> > support project quotas.  i.e this should be checked in
> > fileattr_set_prepare(), not in ext4 specific code.
> 
> I tried to fix ext4/f2fs, i am not sure about XFS, it looks to me XFS
> implemented quota mostly by itself.

Yes, XFS is where project quotas originally come from - XFS has had
project quotas since quotas were first implemented in XFS back in
1995, long before it was ported to Linux. Ext4 and other filesystems
are very recent Linux re-implementations, hence the different quota
infrastructure. As it is, XFS project quotas can be queried and
controlled through the same generic linux quota APIs ithat ext4 uses
as well as it's own....

But the above change is not in quota code - you're changing code in
the FS_IOC_FSSETXATTR ioctl call (again, originally XFS code, but
lifted to the VFS level so ext4 et al can manipulate project
quotas). Hence parameter validity checks for parameters need to be
done at the VFS layers...

> Anyway, let me fix this in generic code.

Thanks!

Cheers,

-Dave.
-- 
Dave Chinner
david@fromorbit.com
