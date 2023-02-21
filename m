Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE9B669E895
	for <lists+linux-ext4@lfdr.de>; Tue, 21 Feb 2023 20:52:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjBUTwn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 21 Feb 2023 14:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBUTwm (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 21 Feb 2023 14:52:42 -0500
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F452CFCE
        for <linux-ext4@vger.kernel.org>; Tue, 21 Feb 2023 11:52:41 -0800 (PST)
Received: by mail-qt1-x82f.google.com with SMTP id x1so6208879qtw.3
        for <linux-ext4@vger.kernel.org>; Tue, 21 Feb 2023 11:52:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GKQIm97cslza0/pA/2Tt6dsdksQXci6wiIScYVFkF3I=;
        b=PByVN/lX7j14uF/PsAeFDsKU1iu11HESIbA/xOdjp/6vlfeFsHIyAsvA19sMp7QuB/
         IeMrSptQV4jAfvVsCxuPL+QxgWguJ5yGqF6n5Kyn5HBZaUdbl0KPBjO9abz5DUKbaXxo
         1mnQJTOmcmdN5a6bA+ANBnC87mak5gSP6fe2uM6eC3hbXEqdFBaTPJ32Z/kW9c3BTDU/
         uLhT6n+U98TLME2drqnFEaAi5HyQbeuOufP9lpIrol09EzDCybsMYAE+KK+xeAo7fjDn
         gCcSO4BiX13SloKnGkFs12GlO5FpQKv2rIR8vYqKMKTUQnmUZMz1LnfDq+TcMJsUlm+w
         v2Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GKQIm97cslza0/pA/2Tt6dsdksQXci6wiIScYVFkF3I=;
        b=BU5PzbBF2zRzQ2CpntF17qpcL1Y4tkcPpmUmDGlbvJyKydMWnBuiyfRGBYBjajoEJT
         lcFio91ALKA2v+U+x2kyrcMP5mAzEfp6oXf+6Yl88vanYFS97HAotGKfcWiqa5BaGOXE
         vNc1NCdTp3y7V7Qu3A9ukKl2lTbWYmYRbSyGsIHJwqMB31ImmY75jiFDgI/2VVAWtuUR
         OmSY2rJv8MnvQMKOB6d5tZyXa2mFmqaZEWCD3MykLbLpwfCnv2jRWuCrxmwoGiPjSqAj
         njw+Ax8lbfnoGlgIGehgZS1j1fMkJwNNLLi62lZHaoi4PZ9rEu/ndXcjyDR2ARD3Pizt
         BXwg==
X-Gm-Message-State: AO0yUKXvQF4WXN6ueNNkUjEq+kI3rJruF9KUGH9BDQXbyYYrqoJxCUuz
        H/o+cM58qAd+j00dbYoTWmxuwyd5B0E=
X-Google-Smtp-Source: AK7set9rmHdeUhRosUwsPIn0zQ25sM/+cZpkFmHiu4+hPQIrl+tz67JzXQInlgcVme34LWsRzIeCIA==
X-Received: by 2002:ac8:5a8b:0:b0:3ba:1360:ec0a with SMTP id c11-20020ac85a8b000000b003ba1360ec0amr9569208qtc.41.1677009160083;
        Tue, 21 Feb 2023 11:52:40 -0800 (PST)
Received: from debian-BULLSEYE-live-builder-AMD64 (h64-35-202-119.cntcnh.broadband.dynamic.tds.net. [64.35.202.119])
        by smtp.gmail.com with ESMTPSA id 203-20020a3708d4000000b0071de2b6d439sm2747918qki.49.2023.02.21.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 11:52:39 -0800 (PST)
Date:   Tue, 21 Feb 2023 14:52:37 -0500
From:   Eric Whitney <enwlinux@gmail.com>
To:     Ritesh Harjani <ritesh.list@gmail.com>
Cc:     Eric Whitney <enwlinux@gmail.com>, linux-ext4@vger.kernel.org,
        tytso@mit.edu
Subject: Re: [PATCH] ext4: fix RENAME_WHITEOUT handling for inline directories
Message-ID: <Y/UhBdnKh/WST81A@debian-BULLSEYE-live-builder-AMD64>
References: <20230210173244.679890-1-enwlinux@gmail.com>
 <87mt5dn76p.fsf@doe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87mt5dn76p.fsf@doe.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

* Ritesh Harjani <ritesh.list@gmail.com>:
> Eric Whitney <enwlinux@gmail.com> writes:
> 
> > A significant number of xfstests can cause ext4 to log one or more
> > warning messages when they are run on a test file system where the
> > inline_data feature has been enabled.  An example:
> >
> > "EXT4-fs warning (device vdc): ext4_dirblock_csum_set:425: inode
> >  #16385: comm fsstress: No space for directory leaf checksum. Please
> > run e2fsck -D."
> >
> > The xfstests include: ext4/057, 058, and 307; generic/013, 051, 068,
> > 070, 076, 078, 083, 232, 269, 270, 390, 461, 475, 476, 482, 579, 585,
> > 589, 626, 631, and 650.
> 
> So, I guess since these were only ext4 warnings hence maybe these were
> getting ignored? Because the tests were never failing?
> Should we do something for such cases? Maybe adding this warning
> detection in xfstests to fail the test case when these warnings are not
> intended? e.g. such warnings should make the test fail by saying
> something detected in dmesg. Except when these are expected for I/O error
> injection tests, etc...
> 

Hi, Ritesh:

Thanks for taking a look at this patch.

Right, the tests never failed.  I was aware of the warning messages because
I routinely check the captured system log output from my upstream regression
runs.  The messages weren't so much ignored as being set aside for the time
being.  They have been appearing for some years, and I'd mentioned them in
past concalls. Since the warning messages simply suggest a recovery action
that's appropriate in some cases - running "e2fsck -D" - there wasn't much
interest in pursuing them, given there was no evidence of actual file system
damage or misbehavior.   After becoming much more familiar with the inline_data
code myself recently I got suspicious and took a closer look.

I don't know that I've got a strong opinion about this, but I think that adding
the EXT4-fs warning and error message prefixes to the set of strings searched
for by _check_dmesg, say, to force a test failure might be more trouble than
it's worth (at least, in comparison with periodically grepping through the
logs).  Adding ext4-specific filters to individual xfstests as needed,
including maintaining them over time and extending the coverage to new tests as
they appear, sounds like a lot of ongoing work for what might be a modest
return.  IIRC, we haven't had a significant number of bugs associated with
EXT4-fs messages without test failures in the last several years, at least.

> >
> > In this situation, the warning message indicates a bug in the code that
> > performs the RENAME_WHITEOUT operation on a directory entry that has
> > been stored inline.  It doesn't detect that the directory is stored
> > inline, and incorrectly attempts to compute a dirent block checksum on
> > the whiteout inode when creating it.  This attempt fails as a result
> > of the integrity checking in get_dirent_tail (usually due to a failure
> > to match the EXT4_FT_DIR_CSUM magic cookie), and the warning message
> > is then emitted.
> >
> > Fix this by simply collecting the inlined data state at the time the
> > search for the source directory entry is performed.  Existing code
> > handles the rest, and this is sufficient to eliminate all spurious
> > warning messages produced by the tests above.  Go one step further
> > and do the same in the code that resets the source directory entry in
> > the event of failure.  The inlined state should be present in the
> > "old" struct, but given the possibility of a race there's no harm
> > in taking a conservative approach and getting that information again
> > since the directory entry is being reread anyway.
> 
> Thanks for the detailed explaination. This makes sense to me.
> 
> >
> > Fixes: b7ff91fd030d ("ext4: find old entry again if failed to rename whiteout")
> 
> So for your changes in ext4_resetent(), your above fixes tags make sense.
> But what about the changes in ext4_rename() function. That was always
> passing NULL as the last argument since the begining no?
> Thinking from the backport perspective if and when required ;)
> 

I'm guessing the intersection of the set of inline data and whiteout (overlayfs)
users is sufficiently small that this patch won't need backporting anytime
soon.  :-)

The reason I picked that tag is that it's a fix for a fix to the patch that
originally added whiteout support to ext4. I wanted to convey that those
fixes should be applied in addition to this patch to get fully functional code.

Thanks,
Eric

> 
> >
> > Signed-off-by: Eric Whitney <enwlinux@gmail.com>
> > ---
> >  fs/ext4/namei.c | 13 +++++++------
> >  1 file changed, 7 insertions(+), 6 deletions(-)
> >
> > diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
> > index dd28453d6ea3..924e16b239e0 100644
> > --- a/fs/ext4/namei.c
> > +++ b/fs/ext4/namei.c
> > @@ -1595,11 +1595,10 @@ static struct buffer_head *__ext4_find_entry(struct inode *dir,
> >  		int has_inline_data = 1;
> >  		ret = ext4_find_inline_entry(dir, fname, res_dir,
> >  					     &has_inline_data);
> > -		if (has_inline_data) {
> > -			if (inlined)
> > -				*inlined = 1;
> > +		if (inlined)
> > +			*inlined = has_inline_data;
> > +		if (has_inline_data)
> >  			goto cleanup_and_exit;
> > -		}
> >  	}
> 
> This looks like a nice cleanup!!
> 
> >
> >  	if ((namelen <= 2) && (name[0] == '.') &&
> > @@ -3646,7 +3645,8 @@ static void ext4_resetent(handle_t *handle, struct ext4_renament *ent,
> >  	 * so the old->de may no longer valid and need to find it again
> >  	 * before reset old inode info.
> >  	 */
> > -	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
> > +	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
> > +				 &old.inlined);
> >  	if (IS_ERR(old.bh))
> >  		retval = PTR_ERR(old.bh);
> >  	if (!old.bh)
> > @@ -3813,7 +3813,8 @@ static int ext4_rename(struct user_namespace *mnt_userns, struct inode *old_dir,
> >  			return retval;
> >  	}
> >
> > -	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de, NULL);
> > +	old.bh = ext4_find_entry(old.dir, &old.dentry->d_name, &old.de,
> > +				 &old.inlined);
> >  	if (IS_ERR(old.bh))
> >  		return PTR_ERR(old.bh);
> >  	/*
> > --
> > 2.30.2
