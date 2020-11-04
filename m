Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 477102A6F9E
	for <lists+linux-ext4@lfdr.de>; Wed,  4 Nov 2020 22:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731687AbgKDVZn (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 4 Nov 2020 16:25:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729600AbgKDVZn (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 4 Nov 2020 16:25:43 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A374C0613D3
        for <linux-ext4@vger.kernel.org>; Wed,  4 Nov 2020 13:25:43 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id j24so31826160ejc.11
        for <linux-ext4@vger.kernel.org>; Wed, 04 Nov 2020 13:25:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/QjMNV0gmbFejQP/+uoncF4mRUUm4/dummX3VyqDMNA=;
        b=H8T3PGFWuzbHdkF8BvJQfm8okjPL61yS28D5927tKqMgDYeH6y4gTFfpyoeEfOdx5S
         1qrVrc6G/+A1yPHywunSo4n4SGEVGDUzNDIAl8N5+VpSQsas+8yJyVhIs4KB7G0loaVe
         dyUvG0XS2g80FaYY9P5iHfhYO6PjmEx7/+forYj86za/u944Y2/FcEmgYGBuGoySZyIF
         iREl/b5iSoUsM+FDcjYz/Kxi7gD8dOgWTrJNiSUB4ixDUGSUUXH5klugZHCYuwt+0aOk
         zNsCJ8Dk9jYWHBCwRq4pZTiJodanESFF1IhZo1FbaRLH207KC8agtwBE1/DcAOOG9R5d
         7HcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/QjMNV0gmbFejQP/+uoncF4mRUUm4/dummX3VyqDMNA=;
        b=PAAyedFjbMyZIRBuhdnx5iqwdJBHoma94s0VMDzAJIM2kZ6LCVvzlxPEVv4rPzT27p
         O410vFWnYoVI1b57Z9laIKPwL92yoUVIMaKeBtcNSIYnjSbuaDP+EfHphWCzGrAFEVYM
         Yy+Xlq8xKxit35xJeit8ymSVpvLz8o80RhSs4ThvudjnHn0LFLM4TImsv4nCoM1wJ//0
         ZA4oCTC+15n9lhQuGwcnOw3d3h2xvkuDjyS9VaetaQCi6wbrFPaRSNvA0LomBUUOKkSz
         /yFOh+17bxHl5PoI5CrkbovVNW6YLRpsQlNXTFRhm47QnB1gS98IZlA5lQfdVu3wBNhL
         Ji7Q==
X-Gm-Message-State: AOAM5326kLPpwKPnGBEW4oO8bHN05cd+J9eFBWxZVecqSZyohK6zZkZl
        ErODSmcORMMt5xdFszU4z4D1Wt5qHNZswGdgvRBK+dSeusuU7g==
X-Google-Smtp-Source: ABdhPJzswWH1gVbyF2PNi33y12ddLHxfhSRtDkINiIvVlg4u5UsYxMwLJKlrqztTKsvpQK840Wnbq7+l8Gkw1dOyFe0=
X-Received: by 2002:a17:906:640d:: with SMTP id d13mr29438ejm.223.1604525141729;
 Wed, 04 Nov 2020 13:25:41 -0800 (PST)
MIME-Version: 1.0
References: <20201031200518.4178786-1-harshadshirwadkar@gmail.com>
 <20201031200518.4178786-6-harshadshirwadkar@gmail.com> <20201103163850.GI3440@quack2.suse.cz>
In-Reply-To: <20201103163850.GI3440@quack2.suse.cz>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Wed, 4 Nov 2020 13:25:30 -0800
Message-ID: <CAD+ocbyDLm8e39K-Aue_hWaPrZ0XOOvp9i+GMbHnFk8JgT_MRw@mail.gmail.com>
Subject: Re: [PATCH 05/10] jbd2: fix fast commit journalling APIs
To:     Jan Kara <jack@suse.cz>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Y. Ts'o" <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, Nov 3, 2020 at 8:38 AM Jan Kara <jack@suse.cz> wrote:
>
> On Sat 31-10-20 13:05:13, Harshad Shirwadkar wrote:
> > This patch adds a few misc fixes for jbd2 fast commit functions.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> Please no "misc fixes" patches. If you have trouble writing good
> explanatory changelog, it's usually a sign you're trying to cram too much
> into a single commit :). In this case I'd split it into 3 changes:
>
> 1) TODO update.
> 2) Removal of j_state_lock protection (with comment updates)
> 3) Fix of journal->j_running_transaction->t_tid handling.
Okay thanks for pointing this out. I'll break this commit into logical
patches for the next version.
>
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index 9b4e87a0068b..df1285da7276 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -946,7 +946,9 @@ struct journal_s
> >        * @j_fc_off:
> >        *
> >        * Number of fast commit blocks currently allocated.
> > -      * [j_state_lock].
> > +      * [j_state_lock]. During the commit path, this variable is not
>
> Please remove the [j_state_lock] annotation when the entry isn't really
> protected by j_state_lock... Also I'd maybe rephrase the comment like
> "Accessed only during fastcommit, currenly only a single process can
> perform fastcommit at a time."
Ack
>
> > +      * protected by j_state_lock since only one process performs commit
> > +      * at a time.
> >        */
> >       unsigned long           j_fc_off;
> >
> > @@ -1110,7 +1112,9 @@ struct journal_s
> >
> >       /**
> >        * @j_fc_wbuf: Array of fast commit bhs for
> > -      * jbd2_journal_commit_transaction.
> > +      * jbd2_journal_commit_transaction. During the commit path, this
> > +      * variable is not protected by j_state_lock since only one process
> > +      * performs commit at a time.
> >        */
> >       struct buffer_head      **j_fc_wbuf;
>
> Here the bh's aren't really used in jbd2_journal_commit_transaction() are
> they? Please fix that when updating the comment. Also I'd find a
> reformulation like I suggested for the comment above more comprehensible.
Ack,

Thanks,
Harshad
>
>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR
