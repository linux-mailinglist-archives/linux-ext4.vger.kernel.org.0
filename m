Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 379B12DDCA3
	for <lists+linux-ext4@lfdr.de>; Fri, 18 Dec 2020 02:31:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727184AbgLRBaR (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Dec 2020 20:30:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45718 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725930AbgLRBaR (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Dec 2020 20:30:17 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI1NR7f009287;
        Fri, 18 Dec 2020 01:29:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=corp-2020-01-29;
 bh=4BCKYnAG32dA16FV8nDABR5KYqi/dmEEhosVoff2oY4=;
 b=q0CDd9GGNbNIpogrUETTEJBKfXJBWZHzW97ukb2QHqTb5i9XZYuQCxEyVY/UyL+1uOda
 NUbV+e8npeDLf1xAyftmPhef5f9voJG3Z/kRE4M9zzO3ShJbK08NtXKyCoXgRoYXbimC
 jY0/a1d2LVPcClfLi/8eotSluw2o2pR3BV6t133z/Ig5zh2nasstWg1JkoC3nf2gX7yb
 k2fM0iJTLlURMAeRdYNJBSF+PhsYcVg3aMhsU87dBvhiABbB6oPq5kbK80hlw1dNosfu
 Ue42h2GGVRfyn093rsR61l/E2OnUi9+xO0UhtAcoywqlzCLUhT/MQq5kgJOQjrXpqeZs jg== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 35cn9rr883-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 18 Dec 2020 01:29:28 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0BI1LHno195989;
        Fri, 18 Dec 2020 01:27:27 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 35e6eu3b2y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 18 Dec 2020 01:27:27 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0BI1RQqk019851;
        Fri, 18 Dec 2020 01:27:26 GMT
Received: from localhost (/67.169.218.210)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 17 Dec 2020 17:27:26 -0800
Date:   Thu, 17 Dec 2020 17:27:25 -0800
From:   "Darrick J. Wong" <darrick.wong@oracle.com>
To:     Wang Shilong <wangshilong1991@gmail.com>
Cc:     Saranya Muruganandam <saranyamohan@google.com>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, adilger.kernel@dilger.ca,
        Li Xi <lixi@ddn.com>, Wang Shilong <wshilong@ddn.com>
Subject: Re: [RFC PATCH v3 02/61] e2fsck: copy context when using
 multi-thread fsck
Message-ID: <20201218012725.GD6908@magnolia>
References: <20201118153947.3394530-1-saranyamohan@google.com>
 <20201118153947.3394530-3-saranyamohan@google.com>
 <20201217235638.GB6908@magnolia>
 <CAP9B-QkipnMyxJ83WZd9Lhz2KDUh_6RMFnhzG8OoV_jJpqveYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP9B-QkipnMyxJ83WZd9Lhz2KDUh_6RMFnhzG8OoV_jJpqveYg@mail.gmail.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 phishscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012180006
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9838 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 impostorscore=0 lowpriorityscore=0 clxscore=1011 spamscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012180006
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Dec 18, 2020 at 09:13:25AM +0800, Wang Shilong wrote:
> On Fri, Dec 18, 2020 at 8:01 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> >
> > On Wed, Nov 18, 2020 at 07:38:48AM -0800, Saranya Muruganandam wrote:
> > > From: Li Xi <lixi@ddn.com>
> > >
> > > This patch only copy the context to a new one when -m is enabled.
> > > It doesn't actually start any thread. When pass1 test finishes,
> > > the new context is copied back to the original context.
> > >
> > > Since the signal handler only changes the original context, so
> > > add global_ctx in "struct e2fsck_struct" and use that to check
> > > whether there is any signal of canceling.
> > >
> > > This patch handles the long jump properly so that all the existing
> > > tests can be passed even the context has been copied. Otherwise,
> > > test f_expisize_ea_del would fail when aborting.
> > >
> > > Signed-off-by: Li Xi <lixi@ddn.com>
> > > Signed-off-by: Wang Shilong <wshilong@ddn.com>
> > > Signed-off-by: Saranya Muruganandam <saranyamohan@google.com>
> > > ---
> > >  e2fsck/pass1.c | 114 +++++++++++++++++++++++++++++++++++++++++++++----
> > >  e2fsck/unix.c  |   1 +
> > >  2 files changed, 107 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/e2fsck/pass1.c b/e2fsck/pass1.c
> > > index 8eecd958..64d237d3 100644
> > > --- a/e2fsck/pass1.c
> > > +++ b/e2fsck/pass1.c
> > > @@ -1144,7 +1144,22 @@ static int quota_inum_is_reserved(ext2_filsys fs, ext2_ino_t ino)
> > >       return 0;
> > >  }
> > >
> > > -void e2fsck_pass1(e2fsck_t ctx)
> > > +static int e2fsck_should_abort(e2fsck_t ctx)
> > > +{
> > > +     e2fsck_t global_ctx;
> > > +
> > > +     if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> > > +             return 1;
> > > +
> > > +     if (ctx->global_ctx) {
> > > +             global_ctx = ctx->global_ctx;
> > > +             if (global_ctx->flags & E2F_FLAG_SIGNAL_MASK)
> > > +                     return 1;
> > > +     }
> > > +     return 0;
> > > +}
> > > +
> > > +void e2fsck_pass1_thread(e2fsck_t ctx)
> > >  {
> > >       int     i;
> > >       __u64   max_sizes;
> > > @@ -1360,7 +1375,7 @@ void e2fsck_pass1(e2fsck_t ctx)
> > >               if (ino > ino_threshold)
> > >                       pass1_readahead(ctx, &ra_group, &ino_threshold);
> > >               ehandler_operation(old_op);
> > > -             if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> > > +             if (e2fsck_should_abort(ctx))
> > >                       goto endit;
> > >               if (pctx.errcode == EXT2_ET_BAD_BLOCK_IN_INODE_TABLE) {
> > >                       /*
> > > @@ -1955,7 +1970,7 @@ void e2fsck_pass1(e2fsck_t ctx)
> > >               if (process_inode_count >= ctx->process_inode_size) {
> > >                       process_inodes(ctx, block_buf);
> > >
> > > -                     if (ctx->flags & E2F_FLAG_SIGNAL_MASK)
> > > +                     if (e2fsck_should_abort(ctx))
> > >                               goto endit;
> > >               }
> > >       }
> > > @@ -2068,6 +2083,89 @@ endit:
> > >       else
> > >               ctx->invalid_bitmaps++;
> > >  }
> > > +
> > > +static errcode_t e2fsck_pass1_thread_prepare(e2fsck_t global_ctx, e2fsck_t *thread_ctx)
> > > +{
> > > +     errcode_t       retval;
> > > +     e2fsck_t        thread_context;
> > > +
> > > +     retval = ext2fs_get_mem(sizeof(struct e2fsck_struct), &thread_context);
> >
> > Hm, so I guess the strategy here is that parallel e2fsck makes
> > per-thread copies of the ext2_filsys and e2fsck_t global contexts?
> > And then after the threaded parts complete, each thread merges its
> > per-thread contexts back into the global one, right?
> 
> Yes.
> 
> >
> > This means that we have to be careful to track which fields in those
> > cloned contexts have been updated by the thread so that we can copy them
> > back and not lose any data.
> >
> > I'm wondering if for future maintainability it would be better to track
> > the per-thread data in a separate structure to make it very explicit
> > which data (sub)structures are effectively per-thread and hence don't
> > require locking?
> 
> Maybe use a per-thread structure is better maintained, but i am not sure
> we could remove locking completely.
> 
> Locking is mostly used for fix, because fixing is serialized now
> and for some global structure which could be used seldomly
> but could simplify codes.

<nod> I was assuming that you'd still put a lock in the global structure
and use it for data fields that aren't so frequently accessed.

--D

> >
> > (I ask that mostly because I'm having a hard time figuring out which
> > fields are supposed to be shared and which ones aren't...)
> >
> > --D
> >
> > > +     if (retval) {
> > > +             com_err(global_ctx->program_name, retval, "while allocating memory");
