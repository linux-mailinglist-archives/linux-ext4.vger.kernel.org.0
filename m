Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 17F4731CE82
	for <lists+linux-ext4@lfdr.de>; Tue, 16 Feb 2021 17:56:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhBPQ4A (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 16 Feb 2021 11:56:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbhBPQz4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 16 Feb 2021 11:55:56 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66D1C06174A
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 08:55:15 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id y26so17572526eju.13
        for <linux-ext4@vger.kernel.org>; Tue, 16 Feb 2021 08:55:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jfudufnBhAQ5uYvwMx0nKzazQE0xeDWTfYNAl09+ph8=;
        b=eafi6R2mLqcqRrGHrZiwr5mcVguBPMUpeXH+low5Fb4aiIZInKkrGx4m4CC0jmeVQS
         8jyxW2rSbX304qdt6YpyLumTE1XPkiQ6MYY8vY7N+JpOOAtHR5DVsTrpC0US6XgVs15i
         ZCxxcgXD9SvdCQooBPDYmfLUlWpfqTT7ZmIKO/RpzTnU26KRHmPNXl/0JwdVCzMPS4t4
         tHRXzpzLHiwb80cjnQ9ZPCavKWtbl1mon9rTtoZx2CUf6kmOBqaNHD30SfwbtFs3rEeF
         jhGeMi9A63LYJt2k36+u6YQsW3e9SVwg6L8NteRVmOLwuF3oqBHYMKHteb9UTuZ6aw3H
         2cag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jfudufnBhAQ5uYvwMx0nKzazQE0xeDWTfYNAl09+ph8=;
        b=PbR+m3OymRYJtEZLy4S24n3a/mKNAVItr0bYar9DvZHdVtcSzUlRA+wrkWkSJN6wlC
         3TKKR/wDampefy/K5IjV93zzdgq1ip86f731JQwI6qeALUt7dTNrx0bR0LsfWlzZ/85G
         cwJaRUqMU2aICLA+rccMSC+KytPOPF6p+w5aeyKAPCRP1K9GTQMzjDdQab3nieT4jfeK
         gmJEjC18KxrZ2FN4nZFWHH+EfW+1tz6uAFtMA/hGIcTNm1dSgoSluHZ/DwKfz0NrMAw/
         +J6HmcwFLimDchCWL3kzEScyRZjQcA8xew4hP5/3D1Cwad+MsDQjr4F40Ua1/aMy4Gnw
         rGjw==
X-Gm-Message-State: AOAM532tJS/1WV89dss3LPm75oA6RPto3RzHlaj2Rnu0+oKC0en/RbMT
        ya3tlMOeVu9To+80ngbDA1/oyiYuYEksPZlqn5k=
X-Google-Smtp-Source: ABdhPJzJCkPA6SPJPz4BOjUmhxu22a4HeSDwAGnHrihd1D0Vxs29KUAmS4bUs+Jq2FHHwUVzSn4K3Do8odtZikeoeLU=
X-Received: by 2002:a17:906:dfce:: with SMTP id jt14mr21464605ejc.345.1613494514588;
 Tue, 16 Feb 2021 08:55:14 -0800 (PST)
MIME-Version: 1.0
References: <20210209202857.4185846-1-harshadshirwadkar@gmail.com>
 <20210209202857.4185846-6-harshadshirwadkar@gmail.com> <95D11120-F8E4-48DC-B149-1B2A5804E74D@dilger.ca>
In-Reply-To: <95D11120-F8E4-48DC-B149-1B2A5804E74D@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 16 Feb 2021 08:55:03 -0800
Message-ID: <CAD+ocbyJ8JTX_42f8=48iGtZ3O0OpwRdUSF3oSnsxpgYysNLVQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] ext4: add proc files to monitor new structures
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Alex Zhuravlev <bzzz@whamcloud.com>,
        =?UTF-8?B?0JHQu9Cw0LPQvtC00LDRgNC10L3QutC+INCQ0YDRgtGR0Lw=?= 
        <artem.blagodarenko@gmail.com>, Shuichi Ihara <sihara@ddn.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Fri, Feb 12, 2021 at 2:37 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Feb 9, 2021, at 1:28 PM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > This patch adds a new file "mb_structs_summary" which allows us to see the
> > summary of the new allocator structures added in this series.
>
> Hmm, it is hard to visualize what these files will look like, could you
> please include an example output in the commit message?  It looks like
> they will no longer have one line per group, which is good, but maybe
> one line per order?
Sure, will do that in the next version.
>
> If at all possible, it makes sense to have well-formatted output that
> follows YAML formatting (https://yaml-online-parser.appspot.com/ can
> verify this) so that it can be easily parsed (both as YAML and via
> awk or other text processing tools).  That doesn't mean you need to
> embed a YAML parser, just a few well-placed ':' and spaces...
Yeah I like the idea. YAML sounds good to me!
>
> Unfortunately, files like "mb_groups" were created before that wisdom
> was learned, and are a bit of a nightmare to parse today.
>
> A few comments inline...
>
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > +static int ext4_mb_seq_structs_summary_show(struct seq_file *seq, void *v)
> > +{
> > +
>
> Extra blank line here can be removed
Ack
>
> > +     if (position >= MB_NUM_ORDERS(sb)) {
> > +             seq_puts(seq, "Tree\n");
>
> Prefer not to use capitalized words.
>
> This should have a ':' like "tree:", but this still leaves the question
> "what is the tree for?" so using "fragment_size_tree:" or similar would
> be better.
Ack
>
> > +             n = rb_first(&sbi->s_mb_avg_fragment_size_root);
> > +             if (!n) {
> > +                     seq_puts(seq, "<Empty>\n");
>
> I'm guessing this won't happen very often, but it might be easier if it
> kept the same output format, so "min: 0, max: 0, num_nodes: 0", or just
> initialize those values and then skip the intermediate processing below
> before printing out the summary line (better because there is only one
> place that is formatting the output, so it will be consistent)?
Sounds good!
>
> > +                     return 0;
> > +             }
> > +             grp = rb_entry(n, struct ext4_group_info, bb_avg_fragment_size_rb);
> > +             min = grp->bb_fragments ? grp->bb_free / grp->bb_fragments : 0;
> > +             count = 1;
> > +             while (rb_next(n)) {
> > +                     count++;
> > +                     n = rb_next(n);
> > +             }
> > +             grp = rb_entry(n, struct ext4_group_info, bb_avg_fragment_size_rb);
> > +             max = grp->bb_fragments ? grp->bb_free / grp->bb_fragments : 0;
> > +
> > +             seq_printf(seq, "Min: %d, Max: %d, Num Nodes: %d\n",
>
> These should be "%u" and not "%d"?  I'd assume none will ever be negative.
Ack
>
> Prefer not to have spaces within keys, so that it is possible to use
> e.g. 'awk /field:/ { print $2 }' to extract a value.  "num_nodes:" or
> "tree_nodes: is better. To be a subset of "tree:" they should be
> indented with 4 spaces or a tab:
>
>     fragment_size_tree:
>         tree_min: nnn
>         tree_max: mmm
>         tree_nodes: ooo
Ack
>
>
> > +     if (position == 0)
> > +             seq_puts(seq, "Largest Free Order Lists:\n");
>
> Similarly, avoiding spaces in the key makes this easier to parse,
> like "max_free_order_lists:" or similar.
>
> > +     seq_printf(seq, "Order %ld list: ", position);
>
> Here, "    list_order_%u: %u groups\n" would be more clear, and
> can be printed in a single call instead of being split up.
Ack

Sounds good, thanks for the feedback. I'll incorporate these changes
in the next version.

Thanks,
Harshad
>
>
> Cheers, Andreas
>
>
>
>
>
