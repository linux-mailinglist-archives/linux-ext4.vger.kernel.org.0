Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8896D7D1703
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Oct 2023 22:30:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbjJTUaa (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Oct 2023 16:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbjJTUa3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Oct 2023 16:30:29 -0400
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 20 Oct 2023 13:30:26 PDT
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5985D63
        for <linux-ext4@vger.kernel.org>; Fri, 20 Oct 2023 13:30:26 -0700 (PDT)
Received: from localhost (88-113-24-34.elisa-laajakaista.fi [88.113.24.34])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 58d03404-6f87-11ee-a9de-005056bdf889;
        Fri, 20 Oct 2023 23:29:20 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Fri, 20 Oct 2023 23:29:19 +0300
To:     Jan Kara <jack@suse.cz>
Cc:     Andy Shevchenko <andriy.shevchenko@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Ferry Toth <ftoth@exalondelft.nl>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
Message-ID: <ZTLjHyn5bPIZFhA-@surfacebook.localdomain>
References: <ZTFAzuE58mkFbScV@smile.fi.intel.com>
 <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com>
 <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com>
 <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
 <20231020180547.6r4qwlefs77uvdsv@quack3>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231020180547.6r4qwlefs77uvdsv@quack3>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Fri, Oct 20, 2023 at 08:05:47PM +0200, Jan Kara kirjoitti:
> On Fri 20-10-23 17:51:59, Andy Shevchenko wrote:
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
> 
> Interesting, but it's a data point :)
> 
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
> > 
> > If it's a timing issue it's related to that error message, as the new helper is
> > run outside of the spinlock.
> > 
> > What's is fishy there besides the error message being available only in one
> > case, is the pointer that is used for dp_op. I'm not at all familiar with the
> > code, but can it be that these superblocks are different for those two cases?
> 
> dquot->dq_sb could be different from the sb we have only if the dirty list
> would get corrupted in some way. Not impossible but does not seem too
> likely. Let's first check whether there are any quotas in the first place.
> 
> I've asked this already but I don't think I've got an answer: What
> filesystem type is the root filesystem? Does it have any quotas (either
> there would be files like aquota.user, quota.user, aquota.group,
> quota.group in / or there would be quota feature enabled - how to find that
> out depends on the filesystem so once I know the fs type I can give you
> instructions).

Oh, indeed. Sorry that I missed that. Kernel configuration you asked for is
available via bitbacket (see some messages above in the thread), I'm using
`make x86_64_defconfig` to get .config out of that.

The root filesystem is initramfs (cpio I suppose). I dunno if that ever
supported quota.

-- 
With Best Regards,
Andy Shevchenko


