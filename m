Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A7B42655F2
	for <lists+linux-ext4@lfdr.de>; Fri, 11 Sep 2020 02:06:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725440AbgIKAGX (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 10 Sep 2020 20:06:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgIKAGU (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 10 Sep 2020 20:06:20 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1790C061573
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 17:06:18 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id v23so10527791ljd.1
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 17:06:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yfTJPlFVn2wmTIDxeU/z6D80k4UaPNoiqLlzOJNoBDY=;
        b=fJzXmuisfL3b2UMU74xdsqxFM9IrmmTVr3UkRCZhsKpmKO24DHQI3Aw3A6CTuTFN0n
         Dj136xniAYX//Yf30RXzU5yySTnN8PA8QdJmA3QVwM6SqzpVxVlizhLEMpFaUyJtSGYg
         xjNUwGBuUu/AEGCNu0cBBlr75RsD5k8ksKR4M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yfTJPlFVn2wmTIDxeU/z6D80k4UaPNoiqLlzOJNoBDY=;
        b=ZNF6VOrpefh3yA5I1k+6CZ3hERrky83OLukYEAAjC0BgiMl3KcV8i0VNEdu3W+VgSK
         jQfRYYJno+MJkZswOeY94qe7FhwPZ6+xdq3B5EaKZsVaLOFg6ttoq3Gxu1PipTvq01lO
         jltFc+6Lgr4BkjXe16n6Euo1GOO0Sk2nElLL9p8VFKzfHnLgHCnnzB5LaqdDgIZknEpB
         afOvfb5Y9NO6iLDFlRi8LK5heZGLjVoR/m4O1tlPfGLSBev+VRqbEwWChRWb4BO+iQKU
         Sd99IxWvoVNop8uOylsWfdrP9D8BXAKOLIwfXN/HLUsopAH1kM54PGExASZf6IZJmdeZ
         w6pw==
X-Gm-Message-State: AOAM533IT3Xi8k3JMNayWLb7xT+ncd64ew2X7ndJzuJ40od3FQf2zxmA
        hptMRYL1gwAZH6Eo9bkkzTnrIUp7wTuS6g==
X-Google-Smtp-Source: ABdhPJwiWP13vBRoNeFlkjjnVbLRrZ6Q3PRSVENcnCmDZgGgQAE/VuIY2UayR2qRr2+b8xEyQZ1mOw==
X-Received: by 2002:a2e:a588:: with SMTP id m8mr5584553ljp.210.1599782776777;
        Thu, 10 Sep 2020 17:06:16 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id l1sm118933ljg.113.2020.09.10.17.06.15
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Sep 2020 17:06:15 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id c2so10434582ljj.12
        for <linux-ext4@vger.kernel.org>; Thu, 10 Sep 2020 17:06:15 -0700 (PDT)
X-Received: by 2002:a05:651c:104c:: with SMTP id x12mr6168022ljm.285.1599782774602;
 Thu, 10 Sep 2020 17:06:14 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wiZnE409WkTOG6fbF_eV1LgrHBvMtyKkpTqM9zT5hpf9A@mail.gmail.com>
 <4ced9401-de3d-b7c9-9976-2739e837fafc@MichaelLarabel.com> <CAHk-=wj+Qj=wXByMrAx3T8jmw=soUetioRrbz6dQaECx+zjMtg@mail.gmail.com>
 <CAHk-=wgOPjbJsj-LeLc-JMx9Sz9DjGF66Q+jQFJROt9X9utdBg@mail.gmail.com>
 <CAHk-=wjjK7PTnDZNi039yBxSHtAqusFoRrZzgMNTiYkJYdNopw@mail.gmail.com>
 <aa90f272-1186-f9e1-8fdb-eefd332fdae8@MichaelLarabel.com> <CAHk-=wh_31_XBNHbdF7EUJceLpEpwRxVF+_1TONzyBUym6Pw4w@mail.gmail.com>
 <e24ef34d-7b1d-dd99-082d-28ca285a79ff@MichaelLarabel.com> <CAHk-=wgEE4GuNjcRaaAvaS97tW+239-+tjcPjTq2FGhEuM8HYg@mail.gmail.com>
 <6e1d8740-2594-c58b-ff02-a04df453d53c@MichaelLarabel.com> <CAHk-=wgJ3-cEkU-5zXFPvRCHKkCCuKxVauYWGphjePEhJJgtgQ@mail.gmail.com>
 <d2023f4c-ef14-b877-b5bb-e4f8af332abc@MichaelLarabel.com> <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
In-Reply-To: <CAHk-=wiz=J=8mJ=zRG93nuJ9GtQAm5bSRAbWJbWZuN4Br38+EQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 10 Sep 2020 17:05:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
Message-ID: <CAHk-=wimM2kckaYj7spUJwehZkSYxK9RQqu3G392BE=73dyKtg@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Michael Larabel <Michael@michaellarabel.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000000052d505aefe7474"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--0000000000000052d505aefe7474
Content-Type: text/plain; charset="UTF-8"

[ Ted / Andreas - Michael bisected a nasty regression to the new fair
page lock, and I think at least part of the reason is the ext4 page
locking patterns ]

On Thu, Sep 10, 2020 at 1:57 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I can already from a quick look see that one of the major
> "interesting" paths here is a "writev()" system call that takes a page
> fault when it copies data from user space.

I think the page fault is incidental and not important.

No, I think the issue is that ext4_write_begin() does some fairly crazy things.

It does

        page = grab_cache_page_write_begin(mapping, index, flags);
        if (!page)
                return -ENOMEM;
        unlock_page(page);

which is all kinds of bad, because where grab_cache_page_write_begin()
will get the page lock, and wait for it to not be under writeback any
more.

And then we unlock it right away.

Only to do the journal start, and after that immediately do

        lock_page(page);
        ... check that the mapping hasn't changed ..
        /* In case writeback began while the page was unlocked */
        wait_for_stable_page(page);

so it does that again.

And I think this is exactly the pattern where the old unfair page
locking worked very well, because the second "lock_page()" will
probably happen while the previous "unlock_page()" had kept it
unlocked. So 99% of the time, the second lock_page() was free.

But with the new fair page locking, the previous unlock_page() will
have given the page away to whoever was waiting for it, and now when
we do the second lock_page(), we'll block and wait for that user - and
every other possible one. Because that's fair - everybody gets the
page lock in order.

This may not be *the* reason, but it's exactly the kind of pessimal
pattern where the old unfair model worked very well (where "well"
means "good average performance, but then occasionally you get
watchdogs firing because there's no forward progress"), and the new
fair code will really stutter, because the lock/unlock/lock pattern is
basically *exactly* the wrong thing to do and only causes a complete
serialization in case there are other waiters, because fairness means
that the second lock will always be done after *all* other queued
waiters have been handled.

And the sad part is that the code doesn't even *want* the lock for
that initial case, and immediately drops it.

The main reason the code seems to want to use that
grab_cache_page_write_begin() that lkocks the page is that it wants to
create the page if it didn't exist, and that creation creates a locked
page.

But the code *could* use FGP_FOR_MMAP instead, which only locks that
initial page case.

So something like this might at least work around this particular
case. But it's *entirely* untested.

Ted, Andreas, comments? The old unfair lock_page() made this a
non-issue, but we really do have years of reports of odd watchdog
errors that seem to be due to that almost infinite unfairness under
bad loads..

Michael: it's entirely possible that the two cases in fs/ext4/inode.c
that I noticed are not that important. But I found them from following
your profile data down to lock_page() cases, so they seem to be at
least _part_ of the issue.

Again: the patch is ENTIRELY untested. It compiles for me, and it
looks superficially right, but that's all I'm going to say about it..

                    Linus

--0000000000000052d505aefe7474
Content-Type: application/octet-stream; name=patch
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: base64
Content-ID: <f_kexh96ss0>
X-Attachment-Id: f_kexh96ss0

IGZzL2V4dDQvaW5vZGUuYyB8IDMzICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQog
MSBmaWxlIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZnMvZXh0NC9pbm9kZS5jIGIvZnMvZXh0NC9pbm9kZS5jCmluZGV4IGJmNTk2NDY3YzIz
NC4uNjUzNTVlMzNlYWFlIDEwMDY0NAotLS0gYS9mcy9leHQ0L2lub2RlLmMKKysrIGIvZnMvZXh0
NC9pbm9kZS5jCkBAIC0xMTEyLDYgKzExMTIsMzMgQEAgc3RhdGljIGludCBleHQ0X2Jsb2NrX3dy
aXRlX2JlZ2luKHN0cnVjdCBwYWdlICpwYWdlLCBsb2ZmX3QgcG9zLCB1bnNpZ25lZCBsZW4sCiB9
CiAjZW5kaWYKIAorCisvKgorICogVGhpcyBpcyBsaWtlIGdyYWJfY2FjaGVfcGFnZV93cml0ZV9i
ZWdpbigpLCBidXQgd2l0aG91dAorICogbG9ja2luZyB0aGUgcGFnZSwgYmVjYXVzZSB3ZSB3YW50
IHRvIGdyYWIgYSBwYWdlIGZpcnN0CisgKiBiZWZvcmUgd2Ugc3RhcnQgYSB0cmFuc2FjdGlvbiBo
YW5kbGUuCisgKgorICogVGhlIHBhZ2Ugd2lsbCBiZSBsb2NrZWQgbGF0ZXIuCisgKgorICogVGhh
dCBGR1BfRk9SX01NQVAgaXMgZXhhY3RseSB0aGF0ICJJIGRvbid0IHdhbnQgaXQgbG9ja2VkIgor
ICogZmxhZywgYW5kIGlzIHJlcXVpcmVkIHRvIHdvcmsgd2l0aCBGR1BfQ1JFQVQuCisgKi8KK3N0
YXRpYyBzdHJ1Y3QgcGFnZSAqZ3JhYl9jYWNoZV9wYWdlX3dyaXRlX2JlZ2luX3VubG9ja2VkKAor
CXN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLCBwZ29mZl90IGluZGV4LCB1bnNpZ25lZCBm
bGFncykKK3sKKwlzdHJ1Y3QgcGFnZSAqcGFnZTsKKwlpbnQgZmdwX2ZsYWdzID0gRkdQX0ZPUl9N
TUFQfEZHUF9XUklURXxGR1BfQ1JFQVQ7CisKKwlpZiAoZmxhZ3MgJiBBT1BfRkxBR19OT0ZTKQor
CQlmZ3BfZmxhZ3MgfD0gRkdQX05PRlM7CisJcGFnZSA9IHBhZ2VjYWNoZV9nZXRfcGFnZShtYXBw
aW5nLCBpbmRleCwgZmdwX2ZsYWdzLAorCQkJbWFwcGluZ19nZnBfbWFzayhtYXBwaW5nKSk7CisJ
aWYgKHBhZ2UpCisJCXdhaXRfZm9yX3N0YWJsZV9wYWdlKHBhZ2UpOworCisJcmV0dXJuIHBhZ2U7
Cit9CisKIHN0YXRpYyBpbnQgZXh0NF93cml0ZV9iZWdpbihzdHJ1Y3QgZmlsZSAqZmlsZSwgc3Ry
dWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJCQkgICAgbG9mZl90IHBvcywgdW5zaWduZWQg
bGVuLCB1bnNpZ25lZCBmbGFncywKIAkJCSAgICBzdHJ1Y3QgcGFnZSAqKnBhZ2VwLCB2b2lkICoq
ZnNkYXRhKQpAQCAtMTE1NCwxMCArMTE4MSw5IEBAIHN0YXRpYyBpbnQgZXh0NF93cml0ZV9iZWdp
bihzdHJ1Y3QgZmlsZSAqZmlsZSwgc3RydWN0IGFkZHJlc3Nfc3BhY2UgKm1hcHBpbmcsCiAJICog
dGhlIHBhZ2UgKGlmIG5lZWRlZCkgd2l0aG91dCB1c2luZyBHRlBfTk9GUy4KIAkgKi8KIHJldHJ5
X2dyYWI6Ci0JcGFnZSA9IGdyYWJfY2FjaGVfcGFnZV93cml0ZV9iZWdpbihtYXBwaW5nLCBpbmRl
eCwgZmxhZ3MpOworCXBhZ2UgPSBncmFiX2NhY2hlX3BhZ2Vfd3JpdGVfYmVnaW5fdW5sb2NrZWQo
bWFwcGluZywgaW5kZXgsIGZsYWdzKTsKIAlpZiAoIXBhZ2UpCiAJCXJldHVybiAtRU5PTUVNOwot
CXVubG9ja19wYWdlKHBhZ2UpOwogCiByZXRyeV9qb3VybmFsOgogCWhhbmRsZSA9IGV4dDRfam91
cm5hbF9zdGFydChpbm9kZSwgRVhUNF9IVF9XUklURV9QQUdFLCBuZWVkZWRfYmxvY2tzKTsKQEAg
LTI5NjIsMTAgKzI5ODgsOSBAQCBzdGF0aWMgaW50IGV4dDRfZGFfd3JpdGVfYmVnaW4oc3RydWN0
IGZpbGUgKmZpbGUsIHN0cnVjdCBhZGRyZXNzX3NwYWNlICptYXBwaW5nLAogCSAqIHRoZSBwYWdl
IChpZiBuZWVkZWQpIHdpdGhvdXQgdXNpbmcgR0ZQX05PRlMuCiAJICovCiByZXRyeV9ncmFiOgot
CXBhZ2UgPSBncmFiX2NhY2hlX3BhZ2Vfd3JpdGVfYmVnaW4obWFwcGluZywgaW5kZXgsIGZsYWdz
KTsKKwlwYWdlID0gZ3JhYl9jYWNoZV9wYWdlX3dyaXRlX2JlZ2luX3VubG9ja2VkKG1hcHBpbmcs
IGluZGV4LCBmbGFncyk7CiAJaWYgKCFwYWdlKQogCQlyZXR1cm4gLUVOT01FTTsKLQl1bmxvY2tf
cGFnZShwYWdlKTsKIAogCS8qCiAJICogV2l0aCBkZWxheWVkIGFsbG9jYXRpb24sIHdlIGRvbid0
IGxvZyB0aGUgaV9kaXNrc2l6ZSB1cGRhdGUK
--0000000000000052d505aefe7474--
