Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 321B76740D0
	for <lists+linux-ext4@lfdr.de>; Thu, 19 Jan 2023 19:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbjASSYj (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 19 Jan 2023 13:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjASSYi (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 19 Jan 2023 13:24:38 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65BA97C844
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 10:24:37 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id d66so3070695vsd.9
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 10:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BVU3lcJ1W9NU2wT8Hm8eV0/TWVb/x/i77jlSHkdBSX0=;
        b=X8uOxnpcOYcn+tIHKB6hg729w4beVgxFLf5xAktSPr4Em61svIdbOxlVLaqSvYF6TT
         H3vf3deBuCDnLIkUBMyf3mZzOoW1yIyKjkwKbbSKAygRRuobaWMlvDYuAK8EjfwMJCt2
         c5Q/qDF8rOdmFFwzp80BEOyX7vvIv0SYf8ekc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BVU3lcJ1W9NU2wT8Hm8eV0/TWVb/x/i77jlSHkdBSX0=;
        b=702kV+tTZX3d1+sse62zrlI3BUI/QZuQ5QHu2SvInCRvKlo4vFcXZEXQE+BNbEksZ+
         R2dsrebMOOe9SAYnJ9ZWbzhKptIOWUFGQo5oG5+GQZGkbrgVtgeRjRDSK/lifA7xhiH0
         oqz3kJLzTXyTl1p3Kxf3rZ4yNEwEQyWyC6s3r9cQyiCcOy9MFW71B5T4IpHo9lNBsYNV
         bDzhxCA9mMssctXcJglUByNhYF5FADcJWV5n3wblWuiaJ/yRX7Op10qoz/s7BoTJFT7J
         SDvj5N0iUsM1UCwuGah79iSSDqLxyCOW1ZPahDZW9eRVbyGRFR1g82vGhIQshenI1OKz
         0CjQ==
X-Gm-Message-State: AFqh2konXTrp8DazzcgrEFQP3XdguxRNoCvFy4FoWH+EiP8lhSYKrcSN
        3HzIzJ4XmuiT8so01D/89d6bwibi0bUx5agm
X-Google-Smtp-Source: AMrXdXtomfYNIcrmcp8hNYdNkKXnMPbih6ERa8ES8hWoAh35h/d5+t5+lV1VeMxZqJznnGC/RdRmUA==
X-Received: by 2002:a05:6102:7d1:b0:3d4:540:785a with SMTP id y17-20020a05610207d100b003d40540785amr7448042vsg.19.1674152676211;
        Thu, 19 Jan 2023 10:24:36 -0800 (PST)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com. [209.85.222.179])
        by smtp.gmail.com with ESMTPSA id l13-20020a05620a28cd00b0070531c5d655sm2261587qkp.90.2023.01.19.10.24.35
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 10:24:35 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id d13so1600257qkk.12
        for <linux-ext4@vger.kernel.org>; Thu, 19 Jan 2023 10:24:35 -0800 (PST)
X-Received: by 2002:ae9:efd8:0:b0:706:e593:2598 with SMTP id
 d207-20020ae9efd8000000b00706e5932598mr197935qkg.216.1674152674832; Thu, 19
 Jan 2023 10:24:34 -0800 (PST)
MIME-Version: 1.0
References: <Y8bpkm3jA3bDm3eL@debian-BULLSEYE-live-builder-AMD64>
 <7DE6598D-B60D-466F-8771-5FEC0FDEC57F@dilger.ca> <Y8dtze3ZLGaUi8pi@sol.localdomain>
 <CAHk-=whUNjwqZXa-MH9KMmc_CpQpoFKFjAB9ZKHuu=TbsouT4A@mail.gmail.com>
 <Y8eAJIKikCTJrlcr@sol.localdomain> <Y8hUCIVImjqCmEWv@mit.edu>
 <CAHk-=wiGdxWtHRZftcqyPf8WbenyjniesKyZ=o73UyxfK9BL-A@mail.gmail.com>
 <Y8hpZRmHJwdutRr2@mit.edu> <3A9E6D2E-F98F-461C-834D-D4E269CC737F@dilger.ca>
In-Reply-To: <3A9E6D2E-F98F-461C-834D-D4E269CC737F@dilger.ca>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Jan 2023 10:24:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whAMYsprEG8idgtvmzsx_Si5r3Hzetp39s3Rkkm=6+eSA@mail.gmail.com>
Message-ID: <CAHk-=whAMYsprEG8idgtvmzsx_Si5r3Hzetp39s3Rkkm=6+eSA@mail.gmail.com>
Subject: Re: Detecting default signedness of char in ext4 (despite -funsigned-char)
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>,
        Eric Biggers <ebiggers@kernel.org>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Eric Whitney <enwlinux@gmail.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: multipart/mixed; boundary="0000000000007c12fc05f2a20bc5"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--0000000000007c12fc05f2a20bc5
Content-Type: text/plain; charset="UTF-8"

On Wed, Jan 18, 2023 at 2:20 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> It makes sense to use the existing UNSIGNED/SIGNED flag in the superblock
> for the dir hash also for the xattr hash.

No. As Eric says, the existing flag for this - while related to a very
similar issue - just doesn't work.

It's for a different hash, and the flag has been set (or not) based on
previous history of that particular filesystem that isn't necessarily
at all relevant. The "signedness" of the xattrs hash simply doesn't
necessarily match the signedness of the existing flag.

Also, honestly, it's just entirely POINTLESS.

Here's the deal: these kinds of flags simply SHOULD NOT EXIST. A
filesystem that has dynamic byte order flags is an INCOMPETENT
filesystem. Yes, I know they exist. The people involved should be
ashamed of them.

For things like byte order flags, it's simply unambiguously better to
just have an unconditional on-disk byte order, even when that byte
order doesn't match the "native" byte order of the machine. Doing an
unconditional 'bswap' operation is literally smaller, simpler and
faster than conditionally doing nothing, and makes for much easier
verification (because you can use static typing rules, like we use for
"__le32" and types like that).

The EXACT same thing is true of architecture-specific signedness.

Yes, you can add flags to dynamically choose one or the other, but
that's actively *worse* then just picking one statically and saying
"this is the correct one".

And honestly, the unsigned version was always the correct one. It's
not even half-way ambiguous like the whole little-endian vs big-endian
discussion used to be. In this very thread Ted made clear that he
hadn't even realized that this signed case could happen and would
matter.  The signed case is surprising and unintentional.

So, given that
 (a) it's just a *fact* that the static choice is better
 (b) of the two choices, one is clearly correct
I'm just going to put my foot down and say that right way forward is
clearly to just make that be the de-facto rule.

And honestly, it's the simpler patch too, since "-funsigned-char" has
already done all the actual "pick the right hash" for us.

We have four levels of "how much do we care" and simplicity:

 (1) do nothing, see if anybody actually ever notices outside of generic/454

 (2) just remove the hash check entirely, it's not doing anything
semantically meaningful

 (3) keep the hash check, replace the "return -EFSCORRUPTED" with a
"pr_warn_once()" and returning zero

 (4) the "keep the hash check, if it fails, test it the other way,
always write the correct new hash" patch I already posted

but the thing I refuse to do is to either just maintain the bug as-is
with extra complexity (Eric's patch) or add a new flag (or erroneously
re-use an existing flag) to make it dynamic.

The e2fsck argument is bugus, because *every* case requires e2fsck
changes. Even if we maintain the completely bogus historical behavior
of "the on-disk filesystem representation depends on architecture",
e2fsck had better start warning about it.

And again, I guarantee that the "fix the signedness" is the simpler
thing even for e2fsck, since at least then there is one unambiguously
correct version and one incorrect one, instead of some wishy-washy
"oh, this filesystem is correct for *THESE* architectures".

I'm attaching my suggested patch here again - this time with a commit
message - because while I'm ok with any of options 1-4 above, I
already wrote the patch for the most complicated case, and it's not
*that* complex.

We could possibly add a "pr_warn_once()" so that we have a combination
of (3) and (4).

In the longer term, we should

 (a) remove the #ifdef __CHAR_UNSIGNED__ in ext4 as always true
(happily, I grepped - it's the only case in the whole source tree)

 (b) probably plan on _eventually_ just remove my disgusting
"calculate signed version" thing, once we think it's all blown over
and we have never seen one of those pr_warn_on() messages outside of
generic/454

but I *really* don't want to add some new filesystem flag to deal with
this situation when a non-flag version is just simpler.

Hmm?

              Linus

--0000000000007c12fc05f2a20bc5
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-ext4-deal-with-legacy-signed-xattr-name-hash-values.patch"
Content-Disposition: attachment; 
	filename="0001-ext4-deal-with-legacy-signed-xattr-name-hash-values.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ld3f8yay0>
X-Attachment-Id: f_ld3f8yay0

RnJvbSBhOWMwYWUyODYzODc1NDQ2ZmEzZDAwZWRhZTJjY2FkNGRhNzVmZWI1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRh
dGlvbi5vcmc+CkRhdGU6IFRodSwgMTkgSmFuIDIwMjMgMDk6NTA6MzggLTA4MDAKU3ViamVjdDog
W1BBVENIXSBleHQ0OiBkZWFsIHdpdGggbGVnYWN5IHNpZ25lZCB4YXR0ciBuYW1lIGhhc2ggdmFs
dWVzCgpXZSBwb3RlbnRpYWxseSBoYXZlIG9sZCBoYXNoZXMgb2YgdGhlIHhhdHRyIG5hbWVzIGdl
bmVyYXRlZCBvbiBzeXN0ZW1zCndpdGggc2lnbmVkICdjaGFyJyB0eXBlcy4gIE5vdyB0aGF0IGV2
ZXJ5Ym9keSB1c2VzICctZnVuc2lnbmVkLWNoYXInLAp0aG9zZSBoYXNoZXMgd2lsbCBubyBsb25n
ZXIgbWF0Y2guCgpUaGlzIG9ubHkgaGFwcGVucyBpZiB5b3UgdXNlIHhhdHRycyBuYW1lcyB0aGF0
IGhhdmUgdGhlIGhpZ2ggYml0IHNldCwKd2hpY2ggcHJvYmFibHkgZG9lc24ndCBoYXBwZW4gaW4g
cHJhY3RpY2UsIGJ1dCB0aGUgeGZzdGVzdCBnZW5lcmljLzQ1NApzaG93cyBpdC4KCkluc3RlYWQg
b2YgYWRkaW5nIGEgbmV3ICJzaWduZWQgeGF0dHIgaGFzaCBmaWxlc3lzdGVtIiBiaXQgYW5kIGhh
dmluZyB0bwpkZWFsIHdpdGggYWxsIHRoZSBwb3NzaWJsZSBjb21iaW5hdGlvbnMsIGp1c3QgY2Fs
Y3VsYXRlIHRoZSBoYXNoIGJvdGgKd2F5cyBpZiB0aGUgZmlyc3Qgb25lIGZhaWxzLCBhbmQgYWx3
YXlzIGdlbmVyYXRlIG5ldyBoYXNoZXMgd2l0aCB0aGUKcHJvcGVyIHVuc2lnbmVkIGNoYXIgdmVy
c2lvbi4KClJlcG9ydGVkLWJ5OiBrZXJuZWwgdGVzdCByb2JvdCA8b2xpdmVyLnNhbmdAaW50ZWwu
Y29tPgpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9yZy9vZS1sa3AvMjAyMjEyMjkxNTA5Ljcw
NGExMWM5LW9saXZlci5zYW5nQGludGVsLmNvbQpMaW5rOiBodHRwczovL2xvcmUua2VybmVsLm9y
Zy9hbGwvQ0FIay09d2hVTmp3cVpYYS1NSDlLTW1jX0NwUXBvRktGakFCOVpLSHV1PVRic291VDRB
QG1haWwuZ21haWwuY29tLwpFeHBvc2VkLWJ5OiAzYmM3NTNjMDZkZDAgKCJrYnVpbGQ6IHRyZWF0
IGNoYXIgYXMgYWx3YXlzIHVuc2lnbmVkIikKQ2M6IEVyaWMgQmlnZ2VycyA8ZWJpZ2dlcnNAa2Vy
bmVsLm9yZz4KQ2M6IEFuZHJlYXMgRGlsZ2VyIDxhZGlsZ2VyQGRpbGdlci5jYT4KQ2M6IFRoZW9k
b3JlIFRzJ28gPHR5dHNvQG1pdC5lZHU+LApDYzogSmFzb24gRG9uZW5mZWxkIDxKYXNvbkB6eDJj
NC5jb20+CkNjOiBNYXNhaGlybyBZYW1hZGEgPG1hc2FoaXJveUBrZXJuZWwub3JnPgpTaWduZWQt
b2ZmLWJ5OiBMaW51cyBUb3J2YWxkcyA8dG9ydmFsZHNAbGludXgtZm91bmRhdGlvbi5vcmc+Ci0t
LQogZnMvZXh0NC94YXR0ci5jIHwgNDEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygt
KQoKZGlmZiAtLWdpdCBhL2ZzL2V4dDQveGF0dHIuYyBiL2ZzL2V4dDQveGF0dHIuYwppbmRleCA3
ZGVjYWFmMjdlODIuLjY5YTFiOGM2YTJlYyAxMDA2NDQKLS0tIGEvZnMvZXh0NC94YXR0ci5jCisr
KyBiL2ZzL2V4dDQveGF0dHIuYwpAQCAtODEsNiArODEsOCBAQCBleHQ0X3hhdHRyX2Jsb2NrX2Nh
Y2hlX2ZpbmQoc3RydWN0IGlub2RlICosIHN0cnVjdCBleHQ0X3hhdHRyX2hlYWRlciAqLAogCQkJ
ICAgIHN0cnVjdCBtYl9jYWNoZV9lbnRyeSAqKik7CiBzdGF0aWMgX19sZTMyIGV4dDRfeGF0dHJf
aGFzaF9lbnRyeShjaGFyICpuYW1lLCBzaXplX3QgbmFtZV9sZW4sIF9fbGUzMiAqdmFsdWUsCiAJ
CQkJICAgIHNpemVfdCB2YWx1ZV9jb3VudCk7CitzdGF0aWMgX19sZTMyIGV4dDRfeGF0dHJfaGFz
aF9lbnRyeV9zaWduZWQoY2hhciAqbmFtZSwgc2l6ZV90IG5hbWVfbGVuLCBfX2xlMzIgKnZhbHVl
LAorCQkJCSAgICBzaXplX3QgdmFsdWVfY291bnQpOwogc3RhdGljIHZvaWQgZXh0NF94YXR0cl9y
ZWhhc2goc3RydWN0IGV4dDRfeGF0dHJfaGVhZGVyICopOwogCiBzdGF0aWMgY29uc3Qgc3RydWN0
IHhhdHRyX2hhbmRsZXIgKiBjb25zdCBleHQ0X3hhdHRyX2hhbmRsZXJfbWFwW10gPSB7CkBAIC00
NzAsOCArNDcyLDIxIEBAIGV4dDRfeGF0dHJfaW5vZGVfdmVyaWZ5X2hhc2hlcyhzdHJ1Y3QgaW5v
ZGUgKmVhX2lub2RlLAogCQl0bXBfZGF0YSA9IGNwdV90b19sZTMyKGhhc2gpOwogCQllX2hhc2gg
PSBleHQ0X3hhdHRyX2hhc2hfZW50cnkoZW50cnktPmVfbmFtZSwgZW50cnktPmVfbmFtZV9sZW4s
CiAJCQkJCSAgICAgICAmdG1wX2RhdGEsIDEpOwotCQlpZiAoZV9oYXNoICE9IGVudHJ5LT5lX2hh
c2gpCi0JCQlyZXR1cm4gLUVGU0NPUlJVUFRFRDsKKwkJLyogQWxsIGdvb2Q/ICovCisJCWlmIChl
X2hhc2ggPT0gZW50cnktPmVfaGFzaCkKKwkJCXJldHVybiAwOworCisJCS8qCisJCSAqIE5vdCBn
b29kLiBNYXliZSB0aGUgZW50cnkgaGFzaCB3YXMgY2FsY3VsYXRlZAorCQkgKiB1c2luZyB0aGUg
YnVnZ3kgc2lnbmVkIGNoYXIgdmVyc2lvbj8KKwkJICovCisJCWVfaGFzaCA9IGV4dDRfeGF0dHJf
aGFzaF9lbnRyeV9zaWduZWQoZW50cnktPmVfbmFtZSwgZW50cnktPmVfbmFtZV9sZW4sCisJCQkJ
CQkJJnRtcF9kYXRhLCAxKTsKKwkJaWYgKGVfaGFzaCA9PSBlbnRyeS0+ZV9oYXNoKQorCQkJcmV0
dXJuIDA7CisKKwkJLyogU3RpbGwgbm8gbWF0Y2ggLSBiYWQgKi8KKwkJcmV0dXJuIC1FRlNDT1JS
VVBURUQ7CiAJfQogCXJldHVybiAwOwogfQpAQCAtMzA5MSw2ICszMTA2LDI4IEBAIHN0YXRpYyBf
X2xlMzIgZXh0NF94YXR0cl9oYXNoX2VudHJ5KGNoYXIgKm5hbWUsIHNpemVfdCBuYW1lX2xlbiwg
X19sZTMyICp2YWx1ZSwKIAlyZXR1cm4gY3B1X3RvX2xlMzIoaGFzaCk7CiB9CiAKKy8qCisgKiBl
eHQ0X3hhdHRyX2hhc2hfZW50cnlfc2lnbmVkKCkKKyAqCisgKiBDb21wdXRlIHRoZSBoYXNoIG9m
IGFuIGV4dGVuZGVkIGF0dHJpYnV0ZSBpbmNvcnJlY3RseS4KKyAqLworc3RhdGljIF9fbGUzMiBl
eHQ0X3hhdHRyX2hhc2hfZW50cnlfc2lnbmVkKGNoYXIgKm5hbWUsIHNpemVfdCBuYW1lX2xlbiwg
X19sZTMyICp2YWx1ZSwgc2l6ZV90IHZhbHVlX2NvdW50KQoreworCV9fdTMyIGhhc2ggPSAwOwor
CisJd2hpbGUgKG5hbWVfbGVuLS0pIHsKKwkJaGFzaCA9IChoYXNoIDw8IE5BTUVfSEFTSF9TSElG
VCkgXgorCQkgICAgICAgKGhhc2ggPj4gKDgqc2l6ZW9mKGhhc2gpIC0gTkFNRV9IQVNIX1NISUZU
KSkgXgorCQkgICAgICAgKHNpZ25lZCBjaGFyKSpuYW1lKys7CisJfQorCXdoaWxlICh2YWx1ZV9j
b3VudC0tKSB7CisJCWhhc2ggPSAoaGFzaCA8PCBWQUxVRV9IQVNIX1NISUZUKSBeCisJCSAgICAg
ICAoaGFzaCA+PiAoOCpzaXplb2YoaGFzaCkgLSBWQUxVRV9IQVNIX1NISUZUKSkgXgorCQkgICAg
ICAgbGUzMl90b19jcHUoKnZhbHVlKyspOworCX0KKwlyZXR1cm4gY3B1X3RvX2xlMzIoaGFzaCk7
Cit9CisKICN1bmRlZiBOQU1FX0hBU0hfU0hJRlQKICN1bmRlZiBWQUxVRV9IQVNIX1NISUZUCiAK
LS0gCjIuMzkuMC5yYzIuNC5nMTQzNTkzMWU0MwoK
--0000000000007c12fc05f2a20bc5--
