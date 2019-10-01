Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 98372C2E69
	for <lists+linux-ext4@lfdr.de>; Tue,  1 Oct 2019 09:51:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730309AbfJAHvK (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 1 Oct 2019 03:51:10 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:35213 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730124AbfJAHvK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 1 Oct 2019 03:51:10 -0400
Received: by mail-ot1-f65.google.com with SMTP id z6so10750558otb.2
        for <linux-ext4@vger.kernel.org>; Tue, 01 Oct 2019 00:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k5JcKIl1bYBBZxUJDuNliaxh6nXXuguiSK7hFwKJfsA=;
        b=Smv4o59ilf+SzW+WlBaHBp3hcYOulcv8+2Pli9q/93kF4EA0zhbpTUpba8RJGZSjNG
         FTyq2BsfThWarix1y0T4mRj6ldWe9iZLG0Z9kN0EIxscnNXbWidDGdkw89P5SyVvARhG
         VIu1J1tbPztXXBRUZ8dJ69YdZj3BmFNkKbROW30Babm+o6O4tmQhqZQ/GM8UK9WXZBpu
         vkc4YSLjDKtlKwlPWht+QC8htyVfnars9By8pdEc1TKt5+SMy5eGn/KENAnSR/HMX6N4
         4QwJevgrxAwEGRZoTUeXyqYt90ZGfTQhifM/xrNrhKg+v9u9KGUTkjaghmwbCdTGsyGi
         ux+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k5JcKIl1bYBBZxUJDuNliaxh6nXXuguiSK7hFwKJfsA=;
        b=hs9lkZPfP9o/fDwXHABZC9hYrUchB6RtGnW+QLQlgcpK2NpPpoAGfeHpkQV+11/S/T
         FqHeczMQgFn+vCAgkdzMsrXotiByiXM73mJCWPkTc803hkuMbwMHHdxVOoADww67MQAl
         CuilRONAUDmTapzzFFjFpdxWfezoWz+LZK/Vqiq7Ix9h6HfyGg6qT/ftqyiWACkkMCDi
         /oGkatovx6FKt1KRsp3pUaoXCmPeizIPn/b+tr1Rsm86EfZb27wroj0if5BJjBoNh27h
         GhLVHhs4QDoy0tVqFqekyTKK0xWcIYIqIf31unYkaUhfqL2HUJ1XTJm7YtBl5gpgGJwz
         oOVw==
X-Gm-Message-State: APjAAAXHDbJMCn2xqVLzF0iVpMVCdZ9tAgFfg6xA7y+SomSFHvG+tBon
        gJ+wnfayHn1ZMCA044k0Nl8lWzR2zLOKrAO8lQSZfllt
X-Google-Smtp-Source: APXvYqzMalR1dxovZoKZfTgsLzHQXVB5zpA8zzX33dkZvmBA0XgG9TOHj7KiU8n5auhUOYsi0MV7/iWoMhyUG0snxZE=
X-Received: by 2002:a9d:6e81:: with SMTP id a1mr1041364otr.363.1569916268984;
 Tue, 01 Oct 2019 00:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <20190809034552.148629-1-harshadshirwadkar@gmail.com>
 <20190809034552.148629-3-harshadshirwadkar@gmail.com> <13BA3D29-983E-4D7F-901E-3EF78201C9AB@dilger.ca>
In-Reply-To: <13BA3D29-983E-4D7F-901E-3EF78201C9AB@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 1 Oct 2019 00:50:58 -0700
Message-ID: <CAD+ocby8+qHFUP1bi64gKyaJwg2muy8mRyRt3fqkxTWvJMVNSw@mail.gmail.com>
Subject: Re: [PATCH v2 02/12] jbd2: add fast commit fields to journal_s structure
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks, done in V3.


On Fri, Aug 9, 2019 at 12:48 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Aug 8, 2019, at 9:45 PM, Harshad Shirwadkar <harshadshirwadkar@gmail.com> wrote:
> >
> > For fast commits, JBD2 as of now allocates a default of 128 blocks at
> > the end of the journalling area. Although JBD2 owns these blocks, it
> > doesn't control what exactly should be written in these blocks. It
> > just provides the right abstraction for making these blocks usable by
> > file systems. This patch adds necessary fields to manage these fast
> > commit blocks.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> Contrary to the description, this patch doesn't really do anything beyond
> adding unused fields and constants to the header, and as such isn't really
> useful to land on its own since there is no way to see what the fields
> are used for.  In particular, I was going to say that JBD2_FAST_COMMIT_BLOCKS
> should only be reserved if the FAST_COMMIT feature is enabled (unlike what
> is written above, which implies that they are always reserved), otherwise
> it can impact filesystem performance even when the feature is not active.
>
> I'd recommend to merge these changes with the patch where the fields/constants
> are actually used.
>
> Cheers, Andreas
>
> > ---
> >
> > Changelog:
> >
> > V2: Added struct transaction_run_stats_s * argument to
> >    j_fc_commit_callback to collect stats
> > ---
> > include/linux/jbd2.h | 79 ++++++++++++++++++++++++++++++++++++++++++++
> > 1 file changed, 79 insertions(+)
> >
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index b7eed49b8ecd..9a750b732241 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -66,6 +66,7 @@ void __jbd2_debug(int level, const char *file, const char *func,
> > extern void *jbd2_alloc(size_t size, gfp_t flags);
> > extern void jbd2_free(void *ptr, size_t size);
> >
> > +#define JBD2_FAST_COMMIT_BLOCKS 128
> > #define JBD2_MIN_JOURNAL_BLOCKS 1024
> >
> > #ifdef __KERNEL__
> > @@ -918,6 +919,34 @@ struct journal_s
> >        */
> >       unsigned long           j_last;
> >
> > +     /**
> > +      * @j_first_fc:
> > +      *
> > +      * The block number of the first fast commit block in the journal
> > +      */
> > +     unsigned long           j_first_fc;
> > +
> > +     /**
> > +      * @j_current_fc:
> > +      *
> > +      * Journal fc block iterator
> > +      */
> > +     unsigned long           j_fc_off;
> > +
> > +     /**
> > +      * @j_last_fc:
> > +      *
> > +      * The block number of the last fast commit block in the journal
> > +      */
> > +     unsigned long           j_last_fc;
> > +
> > +     /**
> > +      * @j_do_full_commit:
> > +      *
> > +      * Force a full commit. If this flag is set JBD2 won't try fast commits
> > +      */
> > +     bool                    j_do_full_commit;
> > +
> >       /**
> >        * @j_dev: Device where we store the journal.
> >        */
> > @@ -987,6 +1016,15 @@ struct journal_s
> >        */
> >       tid_t                   j_transaction_sequence;
> >
> > +     /**
> > +      * @j_subtid:
> > +      *
> > +      * One plus the sequence number of the most recently committed fast
> > +      * commit. This represents the sub transaction ID for the next fast
> > +      * commit.
> > +      */
> > +     tid_t                   j_subtid;
> > +
> >       /**
> >        * @j_commit_sequence:
> >        *
> > @@ -1068,6 +1106,20 @@ struct journal_s
> >        */
> >       int                     j_wbufsize;
> >
> > +     /**
> > +      * @j_fc_wbuf:
> > +      *
> > +      * Array of bhs for fast commit transactions
> > +      */
> > +     struct buffer_head      **j_fc_wbuf;
> > +
> > +     /**
> > +      * @j_fc_wbufsize:
> > +      *
> > +      * Size of @j_fc_wbufsize array.
> > +      */
> > +     int                     j_fc_wbufsize;
> > +
> >       /**
> >        * @j_last_sync_writer:
> >        *
> > @@ -1167,6 +1219,33 @@ struct journal_s
> >        */
> >       struct lockdep_map      j_trans_commit_map;
> > #endif
> > +     /**
> > +      * @j_fc_commit_callback:
> > +      *
> > +      * File-system specific function that performs actual fast commit
> > +      * operation. Should return 0 if the fast commit was successful, in that
> > +      * case, JBD2 will just increment journal->j_subtid and move on. If it
> > +      * returns < 0, JBD2 will fall-back to full commit.
> > +      */
> > +     int (*j_fc_commit_callback)(struct journal_s *journal, tid_t tid,
> > +                                 tid_t subtid,
> > +                                 struct transaction_run_stats_s *stats);
> > +     /**
> > +      * @j_fc_replay_callback:
> > +      *
> > +      * File-system specific function that performs replay of a fast
> > +      * commit. JBD2 calls this function for each fast commit block found in
> > +      * the journal.
> > +      */
> > +     int (*j_fc_replay_callback)(struct journal_s *journal,
> > +                                 struct buffer_head *bh);
> > +     /**
> > +      * @j_fc_cleanup_callback:
> > +      *
> > +      * Clean-up after fast commit or full commit. JBD2 calls this function
> > +      * after every commit operation.
> > +      */
> > +     void (*j_fc_cleanup_callback)(struct journal_s *journal);
> > };
> >
> > #define jbd2_might_wait_for_commit(j) \
> > --
> > 2.23.0.rc1.153.gdeed80330f-goog
> >
>
>
> Cheers, Andreas
>
>
>
>
>
