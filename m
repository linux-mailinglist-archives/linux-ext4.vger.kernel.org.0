Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE8E4DC87
	for <lists+linux-ext4@lfdr.de>; Thu, 20 Jun 2019 23:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726304AbfFTV3k (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 20 Jun 2019 17:29:40 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:42282 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726027AbfFTV3k (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 20 Jun 2019 17:29:40 -0400
Received: by mail-ed1-f67.google.com with SMTP id z25so6726808edq.9
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2019 14:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=v3IpD3zOAyT/o3jFLveqYdHxVLapPS/YFt6LidFqVKU=;
        b=KvOr4Sp+Id3A6XKZfDq0jaToh9hTpDvR4uHERHTmM5jYRInzJr41kiC9SoOmmDJhky
         oWXqPY/lKaIz9THmlD7IH7YFcmC3tZDq/MG8PgXKGCf9XHFgOdbfcOfRn1VFfw/TeOoP
         bFK/Xo6W9HJHbqyCJAlgYtMGuDNKG7dFjc43Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=v3IpD3zOAyT/o3jFLveqYdHxVLapPS/YFt6LidFqVKU=;
        b=rSRDyY0KOuWmD9RHm0KD9fJyabmv7SZyTF6zn7bUNg5LIevFbXJWBtD2MSQ+6ZqKXt
         A4R0IZOxZPUenMp6k7v3wlsl2SSa3vCA37wwqrXH6IRyo8QJ0QqrE1Kn/dURmGT3Lm6m
         ko8GHPuwJ8OLEY7LP9HUDVnaVTE250ddNmtcPJCdIqbTJPa6dGR3rr1ecmtWkyzZmwJ5
         iQjEN8SDLcTY0JXSimvC0La3m23EhSuhp8OdNPvarJh/XceoSR8KJnMq/XvFOrcp6myk
         dL5vivPQ1GrDkqcyBS7lOvcqgGkYa6R0X/T5BraylWjokp2R7qYj4TC1FvCpNJFcqsVh
         LCHA==
X-Gm-Message-State: APjAAAW8rlwXLOFQCMjHdurrhsSHzRwFmIhuMeqcU7blYM1JnlK2ZJKp
        3xH8sNCjhU0rX7PFM8Hpd91uhnUD9fc=
X-Google-Smtp-Source: APXvYqwEzR/KM2j8H9hBZwkSsHCwF7uYr/dudYRG7c83QnxGL8x0kiMiaZhVsqQj3qJSztJNzlysyg==
X-Received: by 2002:a50:aa14:: with SMTP id o20mr75560507edc.165.1561066178423;
        Thu, 20 Jun 2019 14:29:38 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com. [209.85.208.51])
        by smtp.gmail.com with ESMTPSA id z40sm203230edb.61.2019.06.20.14.29.36
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 14:29:37 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id r12so6758241edo.5
        for <linux-ext4@vger.kernel.org>; Thu, 20 Jun 2019 14:29:36 -0700 (PDT)
X-Received: by 2002:a17:906:b315:: with SMTP id n21mr8174762ejz.312.1561066175899;
 Thu, 20 Jun 2019 14:29:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190620151839.195506-1-zwisler@google.com> <20190620151839.195506-3-zwisler@google.com>
 <20190620212517.GC4650@mit.edu>
In-Reply-To: <20190620212517.GC4650@mit.edu>
From:   Ross Zwisler <zwisler@chromium.org>
Date:   Thu, 20 Jun 2019 15:29:24 -0600
X-Gmail-Original-Message-ID: <CAGRrVHw8LuMT7eTnJ4VV9OpnetSSYaLh5nLkN4Anevz6r8KmZA@mail.gmail.com>
Message-ID: <CAGRrVHw8LuMT7eTnJ4VV9OpnetSSYaLh5nLkN4Anevz6r8KmZA@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] jbd2: introduce jbd2_inode dirty range scoping
To:     "Theodore Ts'o" <tytso@mit.edu>,
        Ross Zwisler <zwisler@chromium.org>,
        linux-kernel@vger.kernel.org, Ross Zwisler <zwisler@google.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Jan Kara <jack@suse.com>, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Fletcher Woodruff <fletcherw@google.com>,
        Justin TerAvest <teravest@google.com>, Jan Kara <jack@suse.cz>,
        stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 20, 2019 at 3:25 PM Theodore Ts'o <tytso@mit.edu> wrote:
> On Thu, Jun 20, 2019 at 09:18:38AM -0600, Ross Zwisler wrote:
> > diff --git a/include/linux/jbd2.h b/include/linux/jbd2.h
> > index 5c04181b7c6d8..0e0393e7f41a4 100644
> > --- a/include/linux/jbd2.h
> > +++ b/include/linux/jbd2.h
> > @@ -1397,6 +1413,12 @@ extern int        jbd2_journal_force_commit(journal_t *);
> >  extern int      jbd2_journal_force_commit_nested(journal_t *);
> >  extern int      jbd2_journal_inode_add_write(handle_t *handle, struct jbd2_inode *inode);
> >  extern int      jbd2_journal_inode_add_wait(handle_t *handle, struct jbd2_inode *inode);
> > +extern int      jbd2_journal_inode_ranged_write(handle_t *handle,
> > +                     struct jbd2_inode *inode, loff_t start_byte,
> > +                     loff_t length);
> > +extern int      jbd2_journal_inode_ranged_wait(handle_t *handle,
> > +                     struct jbd2_inode *inode, loff_t start_byte,
> > +                     loff_t length);
> >  extern int      jbd2_journal_begin_ordered_truncate(journal_t *journal,
> >                               struct jbd2_inode *inode, loff_t new_size);
> >  extern void     jbd2_journal_init_jbd_inode(struct jbd2_inode *jinode, struct inode *inode);
>
> You're adding two new functions that are called from outside the jbd2
> subsystem.  To support compiling jbd2 as a module, we also need to add
> EXPORT_SYMBOL declarations for these two functions.
>
> I'll take care of this when applying this change.

Ah, yep, great catch.  Thanks!
