Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6242C72B08F
	for <lists+linux-ext4@lfdr.de>; Sun, 11 Jun 2023 09:05:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232405AbjFKHFl (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Sun, 11 Jun 2023 03:05:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjFKHFk (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Sun, 11 Jun 2023 03:05:40 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777DAC4
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 00:05:35 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-3f7fcdc7f7fso20921925e9.0
        for <linux-ext4@vger.kernel.org>; Sun, 11 Jun 2023 00:05:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686467134; x=1689059134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA4wgOPujvAUjdqjKaG1hoAB/qM7L4//asLUXWFEwjc=;
        b=NZV0a8cufqxQUKfcVdm3i4FmBM+bKtNaCwPs5mFOULYnCOJD2HvJgIpdIc0TL1ohHD
         43E6slW+rdxhssQRT3MmT0M09lpreQ5x+PPxGDLHCogZdFb+vaEref2O0vxGd0Lx3n33
         aDO1RgPAPIx7xEfHHv2xRE8OzuMUwkRCWMjwpFVs0MKywCusztZjoh2BmoLaR+FjkX0F
         MuL4CBJt9CakoUO+7YZjZlS69zr+Q7Q/xgJSCPjyPfuYitvEb33RqbCxhXg3PScVvsP4
         ksQZjlqy5J+qTfoOm6erm6L1406j0NrjWJOdKKh1RoFVyCWzH9B9gR7qJwqpCGZMk72F
         CdIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686467134; x=1689059134;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eA4wgOPujvAUjdqjKaG1hoAB/qM7L4//asLUXWFEwjc=;
        b=Fa5VM2EoKwsj7I4kC8v2xYXCuNdr0WJXjB4wAIR/beLMtplPatAXVUQfiTj7m7pCD8
         IazbjdHo7Ln97+noCSnnpX8eEIx1HIoFuco4xUwBG+dUTCiF3nstdMbFIxFfx3z/Ep89
         m8X/htlem50Ei5zSCf3P3TQdoIYiJFSY38GWATV5+TpZPef7SrEU62oa+ToTMPm9xW2u
         m/b9xz3nV+ckPS7bfssjHe66w0AYcn75I9K+x6HgOg1KVhQt6hjEIrHk8nmqswwA0e7e
         T2PSYCgM4xcXlBKHG4WU0L/EQXdoP5QxACvaZQJlGnxqMlDRCoyIgy+P7acPm7uhVzTC
         vPxA==
X-Gm-Message-State: AC+VfDxCtcFwAYq3oeBq9r4GstdBFL86WWBrEoQ0ZhKTsBaCrXXUflLo
        qwl05XQdVNCbXQnsRKSkL3Y=
X-Google-Smtp-Source: ACHHUZ7FR1iaT+FliF5DUY5sT8XCwMHL6OUTZFxzcpmxqtG4cRSahjg/kB/rPYZPdkrsBDF3ilgkXg==
X-Received: by 2002:a7b:c4d9:0:b0:3f7:e818:3a6c with SMTP id g25-20020a7bc4d9000000b003f7e8183a6cmr5156412wmk.5.1686467133556;
        Sun, 11 Jun 2023 00:05:33 -0700 (PDT)
Received: from suse.localnet (host-95-252-166-216.retail.telecomitalia.it. [95.252.166.216])
        by smtp.gmail.com with ESMTPSA id cr4-20020a05600004e400b003063a92bbf5sm8914536wrb.70.2023.06.11.00.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jun 2023 00:05:32 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org,
        syzkaller-bugs@googlegroups.com,
        syzbot <syzbot+4acc7d910e617b360859@syzkaller.appspotmail.com>
Subject: Re: [syzbot] [ext4?] BUG: sleeping function called from invalid context in
 ext4_update_super
Date:   Sun, 11 Jun 2023 09:05:31 +0200
Message-ID: <2113211.OBFZWjSADL@suse>
In-Reply-To: <20230611032032.GC1436857@mit.edu>
References: <00000000000070575805fdc6cdb2@google.com> <7535327.EvYhyI6sBW@suse>
 <20230611032032.GC1436857@mit.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On domenica 11 giugno 2023 05:20:32 CEST Theodore Ts'o wrote:
> (Dropping linux-fsdevel and linux-kernel from the cc list.)
> 
> On Sat, Jun 10, 2023 at 10:41:18PM +0200, Fabio M. De Francesco wrote:
> > Well, I'm a new to filesystems. However, I'd like to test a change in
> > ext4_handle_error().
> > 
> > Currently I see that errors are handled according to the next snippet of
> > code
> > 
> > from the above-mentioned function (please note that we are in atomic 
context):
> > 	if (continue_fs && journal)
> > 	
> > 		schedule_work(&EXT4_SB(sb)->s_error_work);
> > 	
> > 	else
> > 	
> > 		ext4_commit_super(sb);
> > 
> > If evaluates false, we directly call ext4_commit_super(), forgetting that,
> > AFAICS we are in atomic context.
> > 
> > As I said I have only little experience with filesystems, so my question 
is:
> > despite the overhead, can we delete the check and do the following?
> > 
> > [ Unconditionally call schedule_work(&EXT4_SB(sb)->s_error_work) ]
> 
> That doesn't work, for the simple reason that it's possible that file
> system might be configured to immediately panic on an error.  (See
> later in the ext4_handle_error() function after the check for
> test_opt(sb, ERRORS_PANIC).

Theodore,

Thanks for pointing out this "detail". I had completely overlooked it due to 
lack of experience and because I just spent few minutes on this. I should have 
read the entire function. The end result was that I didn't look at the code in 
the final part of ext4_handle_error() :-(

Are you okay with me submitting a patch with your "Suggested by:" tag? Or 
maybe you prefer to take care of it yourself? For now I await your kind reply. 

> If that happens, the workqueue will never
> have a chance to run.  In that case, we have to call
> ext4_commit_super().
> 
> The real answer here is that ext4_error() must never be called from an
> atomic context, and a recent commit 5354b2af3406 ("ext4: allow
> ext4_get_group_info() to fail") added a call to ext4_error() which is
> problematic since some callers of the ext4_get_group_info() function
> may be holding a spinlock.  And so the best solution is to just simply
> to drop the call to ext4_error(), since it's not strictly necessary.
> If there is an antagonist process which is actively corrupting the
> superblock, some other code path will report the fact that the file
> system is corrupted soon enough.
> 
> 						- Ted
> 
> P.S.  There is an exception to what I've described above, and that's
> special ext4_grp_locked_error() which is used in fs/ext4/mballoc.c.
> But that's a special case which requires very careful handling, In
> general, you simply must not be in atomic context when you want to
> report a problem.

Yes, I can understand that we must not be in atomic context  to report a 
problem. 

Can we "reliably" test !in_atomic() and act accordingly? I remember that the 
in_atomic() helper cannot always detect atomic contexts. 

Anyway, I suppose that this "exception" can be addressed later. Am I somewhat 
wrong about looking at these problems like unrelated, so that we are not 
forced to fix both them at the same time? If you have any suggestions you want 
to share, I'd be happy to help with implementation.

Again thanks,

Fabio



