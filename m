Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF072BB21F
	for <lists+linux-ext4@lfdr.de>; Fri, 20 Nov 2020 19:10:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729369AbgKTSKh (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 20 Nov 2020 13:10:37 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:53569 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729147AbgKTSKg (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 20 Nov 2020 13:10:36 -0500
Received: from callcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 0AKIAUZf002978
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 20 Nov 2020 13:10:31 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C7E55420107; Fri, 20 Nov 2020 13:10:30 -0500 (EST)
Date:   Fri, 20 Nov 2020 13:10:30 -0500
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Jan Kara <jack@suse.cz>, linux-ext4@vger.kernel.org
Subject: Re: [PATCH] ext4: Fix mmap write protection for data=journal mode
Message-ID: <20201120181030.GF609857@mit.edu>
References: <20201027132751.29858-1-jack@suse.cz>
 <CAO9xwp0AtCLG77g6fWgu9un9XPD3d5U6ZtjWc3FRJrB8NK44SQ@mail.gmail.com>
 <CAO9xwp3sSjzy9W8pMjV6vYitfZ9BmZE-9bLwcLg1uz3CFBHUcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp3sSjzy9W8pMjV6vYitfZ9BmZE-9bLwcLg1uz3CFBHUcQ@mail.gmail.com>
pFrom:  "Theodore Y. Ts'o" <tytso@mit.edu>
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Mauricio,

Thanks for your work in finding the corner cases for data=journal.  If
you don't mind me asking, however --- what are the use cases for you
where data=journal is the preferred mode for ext4?  There are a lot of
advanced features for data=journal mode which don't work.  This
includes things like dioread_nolock (now the default), delayed
allocation, and other optimizations.

It used to be that data=journal pretty nicely fell out of how ext4
worked in "normally".  These days, data=journal is becoming more and
more an exception case that requires special handling.  And to be
honest, every so often there has been discussion about whether the
maintenance overhead of data=journal has been worth keeping it.  So
far, we just don't bother making data=journal work with things like
delayed allocation, and one of ther reasons why we've kept it around
is because it's a unique mode that none of the Linux file systems
have.

It would be useful, though, to understand what are the use cases where
you (or your customers) are finding data=journal useful, so we can
better optimize for their use case.  And if there are enough people
who care about it --- and clearly, you've invested so much effort that
you definitely fall into that category :-) --- then maybe there's a
business case for investing more into data=journal and trying to make
it something which is easier to maintain and can work with things like
delayed allocation.

Thanks,

					- Ted
