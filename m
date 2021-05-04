Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 99F68372825
	for <lists+linux-ext4@lfdr.de>; Tue,  4 May 2021 11:40:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230043AbhEDJlQ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 4 May 2021 05:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229883AbhEDJlP (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 4 May 2021 05:41:15 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C183AC061574
        for <linux-ext4@vger.kernel.org>; Tue,  4 May 2021 02:40:20 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id t4so12212106ejo.0
        for <linux-ext4@vger.kernel.org>; Tue, 04 May 2021 02:40:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CwWL2Xw8Xxrp1/M2QKR51Gs5xZ3y7MS0GqNFDHgpzX4=;
        b=MYsxGAKqdTpMvjaPGhY1fDPSYDKA4zTQXl1W9DzRNGiPxZFk7OQr5A0nNH++QUg1zu
         GcJtYfo5R6zchpr1ExY2+bMRIWtYUnVu+RppFKiN2Rf+rQBoULEoC7UowP2KBeBGSpW1
         QfoN/65kr5e2Mb20IevXmrGppRPmymPTXXEUE5Q9n3k6oJiKIQ+NR5rwbptGlfJtUACU
         NYqQqRkB+heUPlb+tKBHGtTK76N4p4zsP4W6WUef1OtJUw0D+42hlWLFMWa6FIbLX8V9
         3X6/PEIpmhOP52kTqzdlJ+yubuYVYsdXAYn6JZcVbtli31Ch0LdnkgNiU9mTObqbJB81
         dYxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CwWL2Xw8Xxrp1/M2QKR51Gs5xZ3y7MS0GqNFDHgpzX4=;
        b=FDVnGnToS/hbwbWGpo4NPZ+0iEBxpRoEujucOB+xmcSyWkqFKvYSTm/EseX9CbTOok
         2560JnB2+uy8R40E6+r5jwMm/qFS5NRGk88k/ahbDptyjTK8FVr00bFUKirx2qmXabE1
         /JkeQYWVlM7GIlqF1qN+c9chpOX+d8tfFv/kinjxoIXWMCmN9zX/vVuvv98BGm71q1c+
         EkqE8tfFYBtIoU2TSLM7J523xs/knLDRMz9oGVHAL1I1yaJGJ8/h/A8ahoRiczevVPJJ
         RxnrcTRhmurBnAopUD3dWo//Kh7kUQUHL9N2lIiTzMY9xRvoDJYxJEOJ6IXkLvKLx74C
         5GBw==
X-Gm-Message-State: AOAM5337Y4R7pnpSno7XMcq0hwj3aiUsPklQ+75I0MagApptUcg+i72s
        /50PbPxvelAmCA9sp1AUDAxZTlUvWuetZZkchpyyC+l9t1xL4Q==
X-Google-Smtp-Source: ABdhPJwSYcXwROqLrqgAbX82BKE1/63n4QJ9lKR3vKz8TJKVj3U7dMnkHrTBImhTsuK2jVGxadJeG8XGcnoNxHy62bY=
X-Received: by 2002:a17:907:2bc7:: with SMTP id gv7mr20972016ejc.187.1620121219385;
 Tue, 04 May 2021 02:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20210504031024.3888676-1-tytso@mit.edu> <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
In-Reply-To: <8E9C71E8-FE5F-4CB8-BA62-8D8895DCA92A@dilger.ca>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 4 May 2021 02:40:08 -0700
Message-ID: <CAD+ocbx9STMGrE0xkHtR8J_c_TgMEz1A6MmNOQyrQtakoZjq3Q@mail.gmail.com>
Subject: Re: [PATCH] e2fsck: fix portability problems caused by unaligned accesses
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Harshad Shirwadkar <harshads@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Ted,

Thanks for the patch. While I now see that these accesses are safe,
ubsan still complains about it the dereferences not being aligned.
With your changes, the way we read journal_block_tag_t is now safe.
But IIUC, ubsan still complains mainly because we still pass the
pointer as "&tag->t_flags" and at which point ubsan thinks that we are
accessing member t_flags in an aligned way. Is there a way to silence
these errors?

I was wondering if it makes sense to do something like this for known
unaligned structures:

journal_block_tag_t local, *unaligned;
...
memcpy(&local, unaligned, sizeof(&local));

// access local.t_flags instead of unaligned

Here are the failures ubsan that I still see:

recovery.c:243:24: runtime error: member access within misaligned
address 0x000001c18fae for type 'journal_block_tag_t' (aka 'struct
journal_block_tag_s'), which requires 4 byte alignment
0x000001c18fae: note: pointer points here
 00 00 00 00 00 01  e0 01 ac 26 00 02 00 00  00 00 01 03 ac 26 00 02
00 00 00 01 e0 02 ac 26  00 02
             ^
Thanks,
Harshad

On Mon, May 3, 2021 at 11:33 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On May 3, 2021, at 9:10 PM, Theodore Ts'o <tytso@mit.edu> wrote:
> >
> > The on-disk format for the ext4 journal can have unaigned 32-bit
> > integers.  This can happen when replaying a journal using a obsolete
> > checksum format (which was never popularly used, since the v3 format
> > replaced v2 while the metadata checksum feature was being stablized),
> > and in the fast commit feature (which landed in the 5.10 kernel,
> > although it is not enabled by default).
> >
> > This commit fixes the following regression tests on some platforms
> > (such as running 32-bit arm architectures on a 64-bit arm kernel):
> > j_recover_csum2_32bit, j_recover_csum2_64bit, j_recover_fast_commit.
> >
> > https://github.com/tytso/e2fsprogs/issues/65
>
> Minor style comments inline.
>
> > Addresses-Debian-Bug: #987641
> > Signed-off-by: Theodore Ts'o <tytso@mit.edu>
> > ---
> > e2fsck/journal.c                   | 41 ++++++++++++++++++++---------
> > e2fsck/recovery.c                  | 42 +++++++++++++++++++++++++-----
> > tests/j_recover_fast_commit/script |  1 -
> > 3 files changed, 65 insertions(+), 19 deletions(-)
> >
> > diff --git a/e2fsck/journal.c b/e2fsck/journal.c
> > index a425bbd1..2231b811 100644
> > --- a/e2fsck/journal.c
> > +++ b/e2fsck/journal.c
> > @@ -344,10 +361,10 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
> >                                               offsetof(struct ext4_fc_tail,
> >                                               fc_crc));
> >                       jbd_debug(1, "tail tid %d, expected %d\n",
> > -                                     le32_to_cpu(tail->fc_tid),
> > +                                     get_le32(&tail->fc_tid),
> >                                       expected_tid);
> > -                     if (le32_to_cpu(tail->fc_tid) == expected_tid &&
> > -                             le32_to_cpu(tail->fc_crc) == state->fc_crc) {
> > +                     if (get_le32(&tail->fc_tid) == expected_tid &&
> > +                             get_le32(&tail->fc_crc) == state->fc_crc) {
>
> (style) better to align continued line after '(' on previous line?  That way
> it can be distinguished from the next (body) line more easily
>
> >                               state->fc_replay_num_tags = state->fc_cur_tag;
> >                       } else {
> >                               ret = state->fc_replay_num_tags ?
> > @@ -357,12 +374,12 @@ static int ext4_fc_replay_scan(journal_t *j, struct buffer_head *bh,
> >                       break;
> >               case EXT4_FC_TAG_HEAD:
> >                       head = (struct ext4_fc_head *)ext4_fc_tag_val(tl);
> > -                     if (le32_to_cpu(head->fc_features) &
> > +                     if (get_le32(&head->fc_features) &
> >                               ~EXT4_FC_SUPPORTED_FEATURES) {
>
> (style) same
>
> >                               ret = -EOPNOTSUPP;
> >                               break;
> >                       }
> > -                     if (le32_to_cpu(head->fc_tid) != expected_tid) {
> > +                     if (get_le32(&head->fc_tid) != expected_tid) {
> >                               ret = -EINVAL;
> >                               break;
> >                       }
>
>
> Cheers, Andreas
>
>
>
>
>
