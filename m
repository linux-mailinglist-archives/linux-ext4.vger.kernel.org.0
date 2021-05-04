Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F396373142
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 22:14:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbhEDUPc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 16:15:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbhEDUPb (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 16:15:31 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 709C6C061574
        for <linux-ext4@vger.kernel.org>; Tue,  4 May 2021 13:14:35 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id y26so11933595eds.4
        for <linux-ext4@vger.kernel.org>; Tue, 04 May 2021 13:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=6Jq1UFlO238ktXGC9j/XRxqdfBp9Wfsqo9YZ/raXFGI=;
        b=krEj8BgE/GqFmp2XKYFSaHGieKOZIPrms4OAR7SBx6QCTdBP1bZ8mv/b6QIrvWA8OK
         a6OPC3Bc1s1OL2u+i/i+5ibS3MWnj3hjpYNYOiIX0RqBmkevqMq7xL0wbBEcAQSQCWTu
         tdYmDqOqynBCFlsnhUYSZs7qeuv4PspiTpU1V8fxT6jMhAD2GlA/SXr87WX9mya1+GML
         EHOKoicvwkof2ZizjuCGXYC4nFIMP34NNq1z0Spk+pgHKLeusrYisheB6XiRvE61f9LH
         wI8MbDQFV4Lr3RETbjvvtrzKjoxg3CsH0oX+E3f3Z87zfLEeDk0OI3zzzA2BcHtIzUSV
         tvYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=6Jq1UFlO238ktXGC9j/XRxqdfBp9Wfsqo9YZ/raXFGI=;
        b=Ou2V717qO3J6IgkZkKU2/I1WReJP9LeXZRtZfpHeb2+oowYYFE9PiDggnTethKXqMh
         MWHTUsYMUtyZ1zOSTHTmwz/g+ij2WwTZXO1qxQNk/tkxgPVVkCZrUBMBLbPYw3UU8vBN
         8ODhLWtXDadwZUCXxTwuDTcYEfIdOGLxZmowdOFmIHDHc+7CmIeJ5BIcCsPrC6kXARbO
         88Nwb8WPWudkZHsrxfX91TjdrBDDTLxTFQz2YXh6sAqhkOo0Aexw5ixtU6ktN18Jhe+q
         G83TyVx5QLs7A7M/GOTUWir4oL5kN159ytywyIJ/Eb2nGTwo//IQCoqPfVVRZ75wUHKh
         4Pvw==
X-Gm-Message-State: AOAM532pyF3Lf8bev6wYd3X5Fi0cr9YODBNyLVajfEcwJWw5Tg9Iqs2y
        N7OIKTmcg1C0hsqipWbknu1u21mbhcE2nBLCm0s=
X-Google-Smtp-Source: ABdhPJwjjKO+ssNbsbSjQLGuPOFaMikvRvnuRSsayQs+SBvu8RY8mLUUNxedPJMKwfXZCYuHR9vanYhrNnuY3HMuYnc=
X-Received: by 2002:a05:6402:35c4:: with SMTP id z4mr11594912edc.362.1620159273956;
 Tue, 04 May 2021 13:14:33 -0700 (PDT)
MIME-Version: 1.0
References: <20210504031024.3888676-1-tytso@mit.edu> <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
 <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
 <YJFQ20rLK16rise2@mit.edu> <YJF6W7WHZBcVZexU@gmail.com> <CAD+ocby+01k9kx3-gEY_z+Ub9GFxi=AwxRS4Ax5-HUFDrVkT0w@mail.gmail.com>
 <YJGdDHLcYuRajhsb@gmail.com> <YJGmTNIHixCLiKok@mit.edu>
In-Reply-To: <YJGmTNIHixCLiKok@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 4 May 2021 13:14:22 -0700
Message-ID: <CAD+ocbwS9h4knUbhiXFUicvi-PwKSnPdF7hrZUhbg1MkzbDmrw@mail.gmail.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned accesses
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

I see thanks for the explanation. I quickly tried it too and saw that
UBSAN warnings went away but I got compiler warnings
"recovery.c:413:27: warning: taking address of packed member
't_blocknr_high' of class or structure 'journal_block_tag_s' may
result in an unaligned pointer value [-Waddress-of-packed-member]".
These compiler warnings seem to be added in [1].

These warnings make me think that de-referencing a member of a packed
struct is still not safe. My concern is this - If we define
journal_block_tag_t as a packed struct AND if we have following unsafe
code, then we won't see UBSAN warnings and the following unaligned
accesses would go unnoticed. That may not go well on certain
architectures.

j_block_tag_t *unaligned_ptr;

flags =3D unaligned_ptr->t_flags;

It looks like if the compiler doesn't support
-Waddress-of-packed-member [1], we may not even see these warnings, we
won't see UBSAN warnings and the unaligned accesses may cause problems
on the architectures that you mentioned.

In other words, what I'm trying to say is that while
__atribute__((packed)) would silence UBSAN warnings (and we should do
it), it's still not sufficient to ensure that our code doesn't do
unaligned accesses to the struct in question. Does that make sense?

- Harshad

[1] https://reviews.llvm.org/rG722a4db1985ca9a8b982074d658dfee9c4624d53

On Tue, May 4, 2021 at 12:53 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Tue, May 04, 2021 at 12:14:20PM -0700, Eric Biggers wrote:
> > On Tue, May 04, 2021 at 10:55:44AM -0700, harshad shirwadkar wrote:
> > > > However, wouldn't it be easier to just add __attribute__((packed)) =
to the
> > > > definition of struct journal_block_tag_t?
> > > While we know that journal_block_tag_t can be unaligned, our code
> > > should still ensure that we are reading this struct in an
> > > alignment-safe way (like Ted's patch does). IIUC, using
> > > __attribute__((packed)) might result in us keeping the door open for
> > > unaligned accesses in future. If someone tries to read 4 bytes
> > > starting at &journal_block_tag_t->t_flags, with attribute packed,
> > > UBSAN won't complain but this may still cause issues on some
> > > architectures.
> >
> > I don't understand your concern here.  Accesses to a packed struct are =
assumed
> > to be unaligned -- that's why I suggested it.  The packed attribute is =
pretty
> > widely used to implement unaligned accesses in C (as an alternative to =
memcpy()
> > or explicit byte-by-byte accesses, both of which also work, though the =
latter
> > seems to run into an UBSAN bug in this case).
>
> So part of the problem is that documentation for
> __attribute__((packed)) is terrible.  From the GCC documentation:
>
>   'packed'
>        The 'packed' attribute specifies that a structure member should
>        have the smallest possible alignment--one bit for a bit-field and
>        one byte otherwise, unless a larger value is specified with the
>        'aligned' attribute.  The attribute does not apply to non-member
>        objects.
>
>        For example in the structure below, the member array 'x' is packed
>        so that it immediately follows 'a' with no intervening padding:
>
>             struct foo
>             {
>               char a;
>               int x[2] __attribute__ ((packed));
>             };
>
>        _Note:_ The 4.1, 4.2 and 4.3 series of GCC ignore the 'packed'
>        attribute on bit-fields of type 'char'.  This has been fixed in GC=
C
>        4.4 but the change can lead to differences in the structure layout=
.
>        See the documentation of '-Wpacked-bitfield-compat' for more
>        information.
>
> I was under the impression that the only thing the packed attribute
> did was to change the structure layout.  So I was about to reply with
> a message saying, "How does this do anything?  The structure is
> already packed, so isn't this a no-op?"
>
> But I did the experiment, and your suggestion worked.... so I then
> started digging for documentation for this being guaranteed behavior
> for gcc and clang.... and I found nothing but blog posts.  One of them
> is by Roland Dreir (infiniband Linux hacker):
>
> http://digitalvampire.org/blog/index.php/2006/07/31/why-you-shouldnt-use-=
__attribute__packed/
>
> which does state:
>
>    But adding __attribute__((packed)) goes further than just telling
>    gcc that it shouldn=E2=80=99t add padding =E2=80=94 it also tells gcc =
that it can=E2=80=99t
>    make any assumptions about the alignment of accesses to structure
>    members
>
> But I wouldn't exactly call this documented behavior on the part of
> GCC.  I guess we could hope that behavior that apparently has been
> around for 15+ years is probably not going to change on us, but I
> would really prefer something in writing.  :-)
>
>
>
>                                                 - Ted
>
> P.S.  Roland's blog goes on to say:
>
>    ... And this leads to disastrously bad code on some architectures.
>
> and has some examples of some really terrible codegen on ia64 and
> sparc64.
