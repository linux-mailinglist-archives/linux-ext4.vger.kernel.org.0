Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40CDB372B56
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 15:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231240AbhEDNuP (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 09:50:15 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:33414 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231138AbhEDNuP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 09:50:15 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 144DnF5F000673
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 May 2021 09:49:16 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id A762B15C3C3D; Tue,  4 May 2021 09:49:15 -0400 (EDT)
Date:   Tue, 4 May 2021 09:49:15 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     harshad shirwadkar <harshadshirwadkar@gmail.com>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJFQ20rLK16rise2@mit.edu>
References: <20210504031024.3888676-1-tytso@mit.edu>
 <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
 <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 04, 2021 at 02:40:08AM -0700, harshad shirwadkar wrote:
> Hi Ted,
> 
> Thanks for the patch. While I now see that these accesses are safe,
> ubsan still complains about it the dereferences not being aligned.
> With your changes, the way we read journal_block_tag_t is now safe.
> But IIUC, ubsan still complains mainly because we still pass the
> pointer as "&tag->t_flags" and at which point ubsan thinks that we are
> accessing member t_flags in an aligned way. Is there a way to silence
> these errors?

Yeah, I had noticed that.  I was thinking perhaps of doing something
like casting the pointer to void * or char *, and then adding offsetof
to work around the UBSAN warning.  Or maybe asking the compiler folks
if they can make the UBSAN warning smarter, since what we're doing
should be perfectly safe. 

> 
> I was wondering if it makes sense to do something like this for known
> unaligned structures:
> 
> journal_block_tag_t local, *unaligned;
> ...
> memcpy(&local, unaligned, sizeof(&local));

I guess that would work too.  The extra memory copy is unfortunate,
although I suspect the performance hit isn't measurable, and journal
replay isn't really a hot path in either the kernel or e2fsprogs.
(Note that want to keep recovery.c in sync between the kernel and
e2fsprogs, so whatever we do needs to be something we're happy with in
both places.)

						- Ted
