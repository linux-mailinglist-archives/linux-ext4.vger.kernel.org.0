Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBEF0373111
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 21:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232649AbhEDTyw (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 15:54:52 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:39510 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232636AbhEDTyu (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 15:54:50 -0400
Received: from cwcc.thunk.org (pool-72-74-133-215.bstnma.fios.verizon.net [72.74.133.215])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 144Jrm9K032216
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 4 May 2021 15:53:48 -0400
Received: by cwcc.thunk.org (Postfix, from userid 15806)
        id 3D88D15C3C43; Tue,  4 May 2021 15:53:48 -0400 (EDT)
Date:   Tue, 4 May 2021 15:53:48 -0400
From:   "Theodore Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     harshad shirwadkar <harshadshirwadkar@gmail.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned
 accesses
Message-ID: <YJGmTNIHixCLiKok@mit.edu>
References: <20210504031024.3888676-1-tytso@mit.edu>
 <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
 <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
 <YJFQ20rLK16rise2@mit.edu>
 <YJF6W7WHZBcVZexU@gmail.com>
 <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
 <YJGdDHLcYuRajhsb@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YJGdDHLcYuRajhsb@gmail.com>
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Tue, May 04, 2021 at 12:14:20PM -0700, Eric Biggers wrote:
> On Tue, May 04, 2021 at 10:55:44AM -0700, harshad shirwadkar wrote:
> > > However, wouldn't it be easier to just add __attribute__((packed)) to the
> > > definition of struct journal_block_tag_t?
> > While we know that journal_block_tag_t can be unaligned, our code
> > should still ensure that we are reading this struct in an
> > alignment-safe way (like Ted's patch does). IIUC, using
> > __attribute__((packed)) might result in us keeping the door open for
> > unaligned accesses in future. If someone tries to read 4 bytes
> > starting at &journal_block_tag_t->t_flags, with attribute packed,
> > UBSAN won't complain but this may still cause issues on some
> > architectures.
> 
> I don't understand your concern here.  Accesses to a packed struct are assumed
> to be unaligned -- that's why I suggested it.  The packed attribute is pretty
> widely used to implement unaligned accesses in C (as an alternative to memcpy()
> or explicit byte-by-byte accesses, both of which also work, though the latter
> seems to run into an UBSAN bug in this case).

So part of the problem is that documentation for
__attribute__((packed)) is terrible.  From the GCC documentation:

  'packed'
       The 'packed' attribute specifies that a structure member should
       have the smallest possible alignment--one bit for a bit-field and
       one byte otherwise, unless a larger value is specified with the
       'aligned' attribute.  The attribute does not apply to non-member
       objects.

       For example in the structure below, the member array 'x' is packed
       so that it immediately follows 'a' with no intervening padding:

            struct foo
            {
              char a;
              int x[2] __attribute__ ((packed));
            };

       _Note:_ The 4.1, 4.2 and 4.3 series of GCC ignore the 'packed'
       attribute on bit-fields of type 'char'.  This has been fixed in GCC
       4.4 but the change can lead to differences in the structure layout.
       See the documentation of '-Wpacked-bitfield-compat' for more
       information.

I was under the impression that the only thing the packed attribute
did was to change the structure layout.  So I was about to reply with
a message saying, "How does this do anything?  The structure is
already packed, so isn't this a no-op?"

But I did the experiment, and your suggestion worked.... so I then
started digging for documentation for this being guaranteed behavior
for gcc and clang.... and I found nothing but blog posts.  One of them
is by Roland Dreir (infiniband Linux hacker):

http://digitalvampire.org/blog/index.php/2006/07/31/why-you-shouldnt-use-__attribute__packed/

which does state:

   But adding __attribute__((packed)) goes further than just telling
   gcc that it shouldn’t add padding — it also tells gcc that it can’t
   make any assumptions about the alignment of accesses to structure
   members

But I wouldn't exactly call this documented behavior on the part of
GCC.  I guess we could hope that behavior that apparently has been
around for 15+ years is probably not going to change on us, but I
would really prefer something in writing.  :-)



						- Ted

P.S.  Roland's blog goes on to say:

   ... And this leads to disastrously bad code on some architectures.

and has some examples of some really terrible codegen on ia64 and
sparc64.
