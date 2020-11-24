Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837942C19C3
	for <lists+linux-ext4@lfdr.de>; Tue, 24 Nov 2020 01:03:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728616AbgKXADV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 23 Nov 2020 19:03:21 -0500
Received: from youngberry.canonical.com ([91.189.89.112]:34035 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728035AbgKXADV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 23 Nov 2020 19:03:21 -0500
Received: from mail-wr1-f72.google.com ([209.85.221.72])
        by youngberry.canonical.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.86_2)
        (envelope-from <mauricio.oliveira@canonical.com>)
        id 1khLni-0001X4-TY
        for linux-ext4@vger.kernel.org; Tue, 24 Nov 2020 00:03:18 +0000
Received: by mail-wr1-f72.google.com with SMTP id m2so2218086wro.1
        for <linux-ext4@vger.kernel.org>; Mon, 23 Nov 2020 16:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iC6D8/sl2ihZ01b7Fa50SWQPMJxbJZPwc7yRBlokxr0=;
        b=cSR5CIYFaAPPI1dLHc+BK6Rc0W3zZcXUsG2lKA7sGt0e4TFw2aGBZkktyz1IhCmJoH
         eOdpEKHGc6qLuPccGc4DxOMC3PyiHrE9HIS3K3ThJJVv6hG7EE20kTYAnBo2NW3n79//
         aVW876Fda6vsSzc/s/McP0ZSkZHmpoHP2rmQyTNvrjXSycfy0s+4wRqSJlnkNiPshfTY
         s7SwLmyrcBF8X9MAi5GBsa2uAp/58eSlkTZVNDWWGZpcHtAhzC89+IM9+XSxhnu875Zq
         i54lhN6H8gd+/KdtZDCtynl5eWGS3mMC6Skp80XNU6SXyWQQlhJOrg0VeklsR5QY6gT9
         qdEg==
X-Gm-Message-State: AOAM531lZc1HtSoK0PStLU9jhT43sqjc7Zw2B/qrRJoCWIi0LDWkrlI4
        69Y2qnU4zqFFF7nlg1Jfps3zIdp2gKWwtn7awC5BvNgRjzExJ8mUxVy3ts2qkCfiBYwcG9Pj91C
        ZhkjlpYtM7aZ+dEvYy/HmcEQT2km7KDTxRXWkJ68n1fdOnUHu+W1v9uw=
X-Received: by 2002:adf:ea47:: with SMTP id j7mr2151515wrn.126.1606176198114;
        Mon, 23 Nov 2020 16:03:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcMNyFEtTY0aXR3o9BekeAz+CWue5wLPSzgghpxHF1Tc5CKj1M6C0eC+judQWmHd4SDGx/3kocZZ6JBE6RAfw=
X-Received: by 2002:adf:ea47:: with SMTP id j7mr2151506wrn.126.1606176197937;
 Mon, 23 Nov 2020 16:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20201027132751.29858-1-jack@suse.cz> <CAO9xwp0AtCLG77g6fWgu9un9XPD3d5U6ZtjWc3FRJrB8NK44SQ@mail.gmail.com>
 <CAO9xwp3sSjzy9W8pMjV6vYitfZ9BmZE-9bLwcLg1uz3CFBHUcQ@mail.gmail.com> <20201123093434.GA27294@quack2.suse.cz>
In-Reply-To: <20201123093434.GA27294@quack2.suse.cz>
From:   Mauricio Faria de Oliveira <mfo@canonical.com>
Date:   Mon, 23 Nov 2020 21:03:06 -0300
Message-ID: <CAO9xwp3hj2dbAxhd2azayTinfw7pWY9OM43EgW09=btjpYT7Vg@mail.gmail.com>
Subject: Re: [PATCH] ext4: Fix mmap write protection for data=journal mode
To:     Jan Kara <jack@suse.cz>
Cc:     Ted Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hey Jan,

On Mon, Nov 23, 2020 at 6:34 AM Jan Kara <jack@suse.cz> wrote:
> > ...
> >
> > The remaining checksum changes due to write-protect failures _seem_ to be
> > a race between our write-protect with write_cache_pages() and writeback/sync.
> > But I'm not exactly sure as it's been hard to find the timing/steps
> > for both threads.
> > The idea is,
> >
> > Our write_cache_pages() during commit /
> > ext4_journalled_submit_inode_data_buffers()
> > depends on PAGECACHE_TAG_DIRTY being set, for pagevec_lookup_range_tag()
> > to put such pages in the array to be write-protected with
> > clear_page_dirty_for_io().
> >
> > With a debug patch to dump_stack() callers of
> > __test_set_page_writeback(), that can
> > xas_clear_mark() it, _while_ the page is still going in our call to
> > write_cache_pages(),
> > we see this: wb_workfn() -> ext4_writepage() -> ext4_ext4_bio_write_page(),
>
> I guess there was something between wb_workfn() and ext4_writepage(),
> wasn't there? There should be write_cache_pages()...
>

Yes, you're right, I oversimplified the function path between the first two. :)
(I'll use '...' in the future to make that clearer.)

> > i.e., _not_ going through ext4_journalled_writepage(), which
> > knows/waits on journal.
> > The other leg of ext4_writepage()  _doesn't_, and thus can clear the
> > tag and prevent
> > write-protect while the journal commit / our write_cache_pages() is running.
>
> So I don't think this is quite it. If there are two writebacks racing,
> either of them will writeprotect the page which is enough for commit to be
> safe (as the mapped write will then trigger ext4_page_mkwrite() which will
> wait for the end of running commit in jbd2_journal_get_write_access()). Or
> am I missing something? But there must be still some race as you can still
> see occasional checksum changes... So I must be missing something.
>

Actually you're right, I missed that -- either writeback will
writeprotect the page.
There's still something else going on, but it's me not you who missed
something. :)
Thanks for pointing that out.

> > Since the switch to either leg is PageChecked(), I guess this might be
> > due to clearing it right away in ext4_journalled_writepage(), before
> > write-protection.
>
> The write-protection happens in clear_page_dirty_for_io() call so that's
> before our ->writepage() callback is even called.
>

Right, I meant write-protection by the other/racing writeback thread.
But please nevermind, as this doesn't seem to be the corner case anymore.

Thanks!

>                                                                 Honza
> --
> Jan Kara <jack@suse.com>
> SUSE Labs, CR



-- 
Mauricio Faria de Oliveira
