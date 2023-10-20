Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 907497D1251
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Oct 2023 17:12:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377628AbjJTPMy (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Oct 2023 11:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377529AbjJTPMw (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Oct 2023 11:12:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD821FA;
        Fri, 20 Oct 2023 08:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697814770; x=1729350770;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=gXAirkdMH/amlSezswVD4m66mm6dUsGdCBipQZgrys4=;
  b=Q0UJmXpmH2FikMdOZAhkEeQZbbb1uNpnFCc5tuGoP176po0AQnDQQvlE
   1Nc9f9nISPEw8ch6svHhxEze915XQK70LAj3t6IQRsemL4hGKfEm+lU2W
   TcVgqV6BnEm/bMvitsnmridBSDnvM+bl8C5MIxr/aRvedgSEIPs5LlgdL
   8UAiWszNE5KaOocwFCu/4AiIjDAWT8Qm+T6ubinwCoonRJ2q7kuGoTWZw
   mEtmD+fO6iyVIxDFNcn9PD9wJO1JA8rjHzFR9JoiuDaItvek8sGsHSs83
   PGKn8M2pjbDxVa38lFk9B5ac6Vl/szmqlpfBsGsWfA2AzET+gw3mXDUmU
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="371585034"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="371585034"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:12:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="823278948"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="823278948"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 08:12:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1qtrB4-00000007Aif-3j7t;
        Fri, 20 Oct 2023 18:12:42 +0300
Date:   Fri, 20 Oct 2023 18:12:42 +0300
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Baokun Li <libaokun1@huawei.com>
Cc:     Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTKY6nRGWoYsEJjj@smile.fi.intel.com>
References: <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <ZTKXbbSS2Pvmc-Fh@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTKXbbSS2Pvmc-Fh@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_SBL_A autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Oct 20, 2023 at 06:06:22PM +0300, Andy Shevchenko wrote:
> On Fri, Oct 20, 2023 at 05:51:59PM +0300, Andy Shevchenko wrote:
> > On Thu, Oct 19, 2023 at 11:43:47AM -0700, Linus Torvalds wrote:
> > > On Thu, 19 Oct 2023 at 11:16, Andy Shevchenko
> > > <andriy.shevchenko@intel.com> wrote:
> > > >
> > > > Meanwhile a wild idea, can it be some git (automatic) conflict resolution that
> > > > makes that merge affect another (not related to the main contents of the merge)
> > > > files? Like upstream has one base, the merge has another which is older/newer
> > > > in the history?
> > > 
> > > I already looked at any obvious case of that.
> > > 
> > > The only quota-related issue on the other side is an obvious
> > > one-liner: commit 86be6b8bd834 ("quota: Check presence of quota
> > > operation structures instead of ->quota_read and ->quota_write
> > > callbacks").
> > > 
> > > It didn't affect the merge, because it was not related to  any of the
> > > changes that came in from the quota branch (it was physically close to
> > > the change that used lockdep_assert_held_write() instead of a
> > > WARN_ON_ONCE(down_read_trylock()) sequence, but it is unrelated to
> > > it).
> > > 
> > > I guess you could try reverting that one-liner after the merge, but I
> > > _really_ don't think it is at all relevant.
> > > 
> > > What *would* probably be interesting is to start at the pre-merge
> > > state, and rebase the code that got merged in. And then bisect *that*
> > > series.
> > > 
> > > IOW, with the merge that triggers your bisection being commit
> > > 1500e7e0726e, do perhaps something like this:
> > > 
> > >   # Name the states before the merge
> > >   git branch pre-merge 1500e7e0726e^
> > >   git branch jan-state 1500e7e0726e^2
> > > 
> > >   # Now double-check that this works for you, of course.
> > >   # Just to be safe...
> > >   git checkout pre-merge
> > >   .. test-build and test-boot this with the bad config ..
> > 
> > That's I have checked already [4], but okay, let me double check.
> > [5] is the same as [4] according to `git diff`.
> > 
> > It boots.
> > 
> > >   # Then, let's create a new branch that is
> > >   # the rebased version of Jan's state:
> > >   git checkout -b jan-rebased jan-state
> > >   git rebase pre-merge
> > 
> > [6] is created.
> > 
> > >   # Verify that the tree is the same as the merge
> > >   git diff 1500e7e0726e
> > 
> > Yes, nothing in output.
> > 
> > And it does not boot.
> > 
> > >   # Ok, that was empty, so do a bisect on this
> > >   # rebased history
> > >   git bisect start
> > >   git bisect bad
> > >   git bisect good pre-merge
> > > 
> > > .. and see what commit it *now* claims is the bad commit.
> > 
> > git bisect start
> > # status: waiting for both good and bad commits
> > # good: [63580f669d7ff5aa5a1fa2e3994114770a491722] Merge tag 'ovl-update-6.6' of git://git.kernel.org/pub/scm/linux/kernel/git/overlayfs/vfs
> > git bisect good 63580f669d7ff5aa5a1fa2e3994114770a491722
> > # status: waiting for bad commit, 1 good commit known
> > # bad: [2447ff4196091e41d385635f9b6d003119f24199] ext2: Fix kernel-doc warnings
> > git bisect bad 2447ff4196091e41d385635f9b6d003119f24199
> > # bad: [a7c4109a1fa7f9f8cfa9aa93e7aae52d0df820f6] MAINTAINERS: change reiserfs status to obsolete
> > git bisect bad a7c4109a1fa7f9f8cfa9aa93e7aae52d0df820f6
> > # bad: [74fdc82e4a4302bf8a519101a40691b78d9beb6c] quota: add new helper dquot_active()
> > git bisect bad 74fdc82e4a4302bf8a519101a40691b78d9beb6c
> > # bad: [e64db1c50eb5d3be2187b56d32ec39e56b739845] quota: factor out dquot_write_dquot()
> > git bisect bad e64db1c50eb5d3be2187b56d32ec39e56b739845
> > # good: [eea7e964642984753768ddbb710e2eefd32c7a89] ext2: remove redundant assignment to variable desc and variable best_desc
> > git bisect good eea7e964642984753768ddbb710e2eefd32c7a89
> > # first bad commit: [e64db1c50eb5d3be2187b56d32ec39e56b739845] quota: factor out dquot_write_dquot()
> > 
> > > Would you be willing to do this? It should be only a few bisects,
> > > since Jan's branch only brought in 17 commits that the above rebases
> > > into this test branch. So four or five bisections should pinpoint the
> > > exact point where it goes bad.
> > 
> > See above.
> > 
> > I even rebuilt again with just rebased on top of e64db1c50eb5 and it doesn't
> > boot, so we found the culprit that triggers this issue.
> > 
> > > Of course, since this is apparently about some "random code generation
> > > issue", that exact point still may not be very interesting.
> > 
> > On top of the above I have tried the following:
> > 1) dropping inline, replacing it to __always_inline -- no help;
> > 2) commenting out the error message -- helps!
> > 
> > --- a/fs/quota/dquot.c
> > +++ b/fs/quota/dquot.c
> > @@ -632,8 +632,10 @@ static inline int dquot_write_dquot(struct dquot *dquot)
> >  {
> >         int ret = dquot->dq_sb->dq_op->write_dquot(dquot);
> >         if (ret < 0) {
> > +#if 0
> >                 quota_error(dquot->dq_sb, "Can't write quota structure "
> >                             "(error %d). Quota may get out of sync!", ret);
> > +#endif
> >                 /* Clear dirty bit anyway to avoid infinite loop. */
> >                 clear_dquot_dirty(dquot);
> >         }

Doing the same on the my branch based on top of v6.6-rc6 does not help.
So looks like a race condition somewhere happening related to that dirty bit
(as comment states it needs to be cleaned to avoid infinite loop, that's
 probably what happens).

> > If it's a timing issue it's related to that error message, as the new helper is
> > run outside of the spinlock.
> > 
> > What's is fishy there besides the error message being available only in one
> > case, is the pointer that is used for dp_op. I'm not at all familiar with the
> > code, but can it be that these superblocks are different for those two cases?
> > 
> > [4]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-before-merge/
> > [5]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-pre-merge/
> > [6]: https://bitbucket.org/andy-shev/linux/src/test-mrfld-jan-rebased/

-- 
With Best Regards,
Andy Shevchenko


