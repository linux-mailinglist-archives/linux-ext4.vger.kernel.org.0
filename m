Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A14D926D3F4
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Sep 2020 08:51:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726151AbgIQGvL (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Sep 2020 02:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726106AbgIQGvK (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Sep 2020 02:51:10 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB3E1C06174A
        for <linux-ext4@vger.kernel.org>; Wed, 16 Sep 2020 23:51:09 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id t10so776945wrv.1
        for <linux-ext4@vger.kernel.org>; Wed, 16 Sep 2020 23:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=04ZnPqR5fQwS72vXUsYwjIjzCp4WzwL4wEim+jkptW4=;
        b=F6rnX7vSp0KdaRoD1kKrBQf/RDGKq39T29DHRdVpvrwzC5FBPGc0MxBjg/XSiV1O9O
         D0waWh8VFt9KXkOYHrqt1tWH3jBD2O5EGhW86he5XVW6/XrWIIHQA9Utk+M7/tPKUPHR
         JaMvTMt+ADaVRzjbuUTeRMTsp9W2HyNly7NLdWHP8BcU4e0/UKg7L75E2vaNwqrcRKlC
         K0kyYhgBlhD61bptd6jYwc6j1m+J76iISA9uYtVVDf4UKWKyeyxf9icQuJxPCfdwb7Ia
         INxEcXoh6XDuzByyNcKNPnBNzufg1VnEAl++YIK9d3jRergt/zUh5rR/m0z9ASk9/Odt
         toXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=04ZnPqR5fQwS72vXUsYwjIjzCp4WzwL4wEim+jkptW4=;
        b=NDcNjuOtnDnINa+MEyyI/Ac1+TTRH8q9rIuv0rKk62wG5Iy16LAVsR/o9sxpYYNRxX
         mLen9rV3lsm4U6ycPsbi1rVOs1OOlSzg1jg1K+dCob/rFtGWJpKIetG19r0gsoRfHWR1
         60Xb+SRTuZjWjVgKR+MOujkihnnccH30iqEd6iI5dnPY3wau/hkTJHz+ryJUYXaPIhYM
         dVFz+g42N5yLt1dEME+hSMxQKIA6sUZ8zjrtIYdQuFM0Cz/yyI9VZBAZWJod5WQ4e/ry
         OiQak+tGXov08kFVpTvluv4UhVdQOAyuAK0l50rqtkjYPp+Wlb7nLeOPdvVgwCRWZsaJ
         AFRQ==
X-Gm-Message-State: AOAM530YAAQg5TLv9muzNFm25I1jtWGkPLLSz4Yt5pGvuTfFploA2YyC
        c/zl5bT5P0evuPhwJO/Th7EsgcihP9VmabsPTYc=
X-Google-Smtp-Source: ABdhPJwiChGXGnlxsLg9FF9jk57UmzpFybhHjp+xuIquowbSPbNaiufRnGGpYvLavP8mqkmWYlaHV/RrXg6TSW2tHzo=
X-Received: by 2002:adf:f082:: with SMTP id n2mr30039909wro.35.1600325468261;
 Wed, 16 Sep 2020 23:51:08 -0700 (PDT)
MIME-Version: 1.0
References: <CA+OwuSj-WjaPbfOSDpg5Mz2tm_W0p40N-L=meiWEDZ6j1ccq=Q@mail.gmail.com>
 <132401FE-6D25-41B3-99D1-50E7BC746237@dilger.ca> <20200916210352.GD38283@mit.edu>
 <D9D82475-7B39-4D79-84CA-C246130AD3B1@dilger.ca>
In-Reply-To: <D9D82475-7B39-4D79-84CA-C246130AD3B1@dilger.ca>
From:   Wang Shilong <wangshilong1991@gmail.com>
Date:   Thu, 17 Sep 2020 14:50:52 +0800
Message-ID: <CAP9B-Q=iS_rFNgBW_O0DOwcYPNvdAkydZ7tyxQs1Z-ph8wo7ig@mail.gmail.com>
Subject: Re: [PATCH] [RFC] ext2fs: parallel bitmap loading
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        saranyamohan@google.com, harshads@google.com
Content-Type: multipart/mixed; boundary="0000000000000fc4f705af7ccfae"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

--0000000000000fc4f705af7ccfae
Content-Type: text/plain; charset="UTF-8"

Hi,

On Thu, Sep 17, 2020 at 9:34 AM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Sep 16, 2020, at 3:03 PM, Theodore Y. Ts'o <tytso@mit.edu> wrote:
> >
> > On Fri, Sep 04, 2020 at 03:34:26PM -0600, Andreas Dilger wrote:
> >> This is a patch that is part of the parallel e2fsck series that Shilong
> >> is working on, and does not work by itself, but was requested during
> >> discussion on the ext4 concall today.
> >
> > Andreas, thanks for sending this patch.  (Also available at[1].)
> >
> > [1] https://lore.kernel.org/linux-ext4/132401FE-6D25-41B3-99D1-50E7BC746237@dilger.ca/
> >
> > I took look at it, and there are a number of issues with it.  First of
> > all, there seems to be an assumption that (a) the number of threads is
> > less than the number of block groups, and (b) the number of threads
> > can evenly divide the number of block groups.  So for example, if the
> > number of block groups is prime, or if you are trying to use say, 8 or
> > 16 threads, and the number of block groups is odd, the code in
> > question will not do the right thing.
>
> Yes, the thread count is checked earlier in the parallel e2fsck patch
> series to be <= number of block groups.  However, I wasn't aware of any
> requirement for groups = N * threads.  It may be coincidental that we
> have never tested that case.
>
> In any case, the patch was never really intended to be used by itself,
> only for review and discussion of the general approach.
>
> > (a) meant that attempting to run the e2fsprogs regression test suite
> > caused most of the test cases to fail with e2fsck crashing due to
> > buffer overruns.  I fixed this by changing the number of threads to be
> > 16, or if 16 was greater than the number of block groups, to be the
> > number of block groups, just for debugging purposes.  However, there
> > were still a few regression test failures.
> >
> > I also then tried to use a file system that we had been using for
> > testing fragmentation issues.  The file system was creating a 10GB
> > virtual disk, and then running these commands:
> >
> >   DEV=/dev/sdc
> >   mke2fs -t ext4 $DEV 10G
> >   mount $DEV /mnt
> >   pushd /mnt
> >   for t in $(seq 1 6144) ; do
> >       for i in $(seq 1 25) ; do
> >           fallocate tb$t-8mb-$i -l 8M
> >       done
> >       for i in $(seq 1 2) ; do
> >           fallocate tb$t-400mb-$i -l 400M
> >       done
> >   done
> >   popd
> >   umount /mnt
> >

I tested an attachment v2 patch(based on master branch) which used 32
threads locally and it passed the test.

[root@server e2fsprogs]# ./e2fsck/e2fsck -f /dev/sda4
e2fsck 1.46-WIP (20-Mar-2020)
Pass 1: Checking inodes, blocks, and sizes
Pass 2: Checking directory structure
Pass 3: Checking directory connectivity
Pass 4: Checking reference counts
Pass 5: Checking group summary information
Multiple threads triggered to read bitmaps
/dev/sda4: 77963/3145728 files (0.0% non-contiguous), 12559729/12563825 blocks


> > With the patch applied, all of the threads failed with error code 22
> > (EINVAL), except for one which failed with a bad block group checksum
> > error.  I haven't had a chance to dig into further; but I was hoping
> > that Shilong and/or Saranya might be able to take closer look at that.
>
> There may very well be other issues with the patch that make it not
> useful as-is in isolation.  I'd have to let Shilong comment on that.
>
> > But the other thing that we might want to consider is to add
> > demand-loading of the block (or inode) bitmap.  We got a complaint
> > that "e2fsck -E journal_only" was super-slow whereas running the
> > journal by mounting and unmounting the file system was much faster.
> > The reason, of course, was because the kernel was only reading those
> > bitmap blocks that are needed to be modified by the orphaned inode
> > processing, whereas with e2fsprogs, we have to read in all of the
> > bitmap blocks whether this is necessary or not.
>
> Forking threads to do on-demand loading may have a high overhead, so
> it would be interesting to investigate a libext2fs IO engine that is
> using libaio.  That would allow O_DIRECT reading of filesystem metadata
> without double caching, as well as avoid blocking threads.  Alternately,
> there is already a "readahead" method exported that could be used to
> avoid changing the code too much, using posix_fadvise(WILLNEED), but I
> have no idea on how that would perform.
>
> > So another idea that we've talked about is teaching libext2fs to be
> > able to demand load the bitmap, and then when we write out the block
> > bitmap, we only need to write out those blocks that were loaded.  This
> > would also speed up running debugfs to examine the file system, as
> > well as running fuse2fs.  Fortunately, we have abstractions in front
> > of all of the bitmap accessor functions, and the code paths that would
> > need to be changed to add demand-loading of bitmaps should be mostly
> > exclusive of the changes needed for parallel bitmap loading.  So if
> > Shilong has time to look at making the parallel bitmap loader more
> > robust, perhaps Saranya could work on the demand-loading idea.
> >
> > Or if Shilong doesn't have time to try to polish this parallel bitmap
> > loading changes, we could have Saranya look at clean it up --- since
> > regardless of whether we implement demand-loading or not, parallel
> > bitmap reading is going to be useful for some use cases (e.g., a full
> > fsck, dumpe2fs, or e2image).
>
> I don't think Shilong will have time to work on major code changes for
> the next few weeks at least, due to internal deadlines, after which we
> can finish cleaning up and submitting the pfsck patch series upstream.
> If you are interested in the whole 59-patch series, it is available via:
>
> git pull https://review.whamcloud.com/tools/e2fsprogs refs/changes/14/39914/1
>
> or viewable online via Gerrit at:
>
> https://review.whamcloud.com/39914
>
> Getting some high-level review/feedback of that patch series would avoid
> spending time to rework/rebase it and finding it isn't in the form that
> you would prefer, or if it needs major architectural changes.
>
> Note that this is currently based on top of the Lustre e2fsprogs branch.
> While these shouldn't cause any problems with non-Lustre filesystems,
> there are other patches in the series that are not necessarily ready
> for submission (e.g. dirdata, Lustre xattr decoding, inode badness, etc).
>
> Cheers, Andreas
>
>
>
>
>

--0000000000000fc4f705af7ccfae
Content-Type: application/octet-stream; 
	name="v2-0001-LU-8465-ext2fs-parallel-bitmap-loading.patch"
Content-Disposition: attachment; 
	filename="v2-0001-LU-8465-ext2fs-parallel-bitmap-loading.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kf6gbc5y0>
X-Attachment-Id: f_kf6gbc5y0

RnJvbSAxYTMzNzBmMzdiYjEwNjBiODE0OTA0OTY1MWMwOGJiN2YxNDY4OGE2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBXYW5nIFNoaWxvbmcgPHdzaGlsb25nQGRkbi5jb20+CkRhdGU6
IFRodSwgMyBTZXAgMjAyMCAxMDo1MTo0OSArMDgwMApTdWJqZWN0OiBbUEFUQ0ggdjJdIExVLTg0
NjUgZXh0MmZzOiBwYXJhbGxlbCBiaXRtYXAgbG9hZGluZwoKSW4gb3VyIGJlbmNobWFya2luZyBm
b3IgUGlCIHNpemUgZmlsZXN5c3RlbSwgcGFzczUgdGFrZXMKMTA0NDZzIHRvIGZpbmlzaCBhbmQg
OTkuNSUgb2YgdGltZSB0YWtlcyBvbiByZWFkaW5nIGJpdG1hcHMuCgpJdCBtYWtlcyBzZW5zZSB0
byByZWFkaW5nIGJpdG1hcHMgdXNpbmcgbXVsdGlwbGUgdGhyZWFkcywKYSBxdWlja2x5IGJlbmNo
bWFyayBzaG93IDEwNDQ2cyB0byA2MjZzIHdpdGggNjQgdGhyZWFkcy4KClNpZ25lZC1vZmYtYnk6
IFdhbmcgU2hpbG9uZyA8d3NoaWxvbmdAZGRuLmNvbT4KQ2hhbmdlLUlkOiBJOGQ3Mzg5NDEzYTA5
YmYyNjJkMGFlNjU3Y2I0ODVlODg2MjM4NWQwYwotLS0KIGxpYi9leHQyZnMvZXh0MmZzLmggICAg
IHwgIDI4ICsrKy0KIGxpYi9leHQyZnMvcndfYml0bWFwcy5jIHwgMjgxICsrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLS0tLS0KIDIgZmlsZXMgY2hhbmdlZCwgMjY5IGluc2VydGlv
bnMoKyksIDQwIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2xpYi9leHQyZnMvZXh0MmZzLmgg
Yi9saWIvZXh0MmZzL2V4dDJmcy5oCmluZGV4IDY5YzhhM2ZmLi5lOGFlZjczNiAxMDA2NDQKLS0t
IGEvbGliL2V4dDJmcy9leHQyZnMuaAorKysgYi9saWIvZXh0MmZzL2V4dDJmcy5oCkBAIC0yNTUs
MTAgKzI1NSwxMSBAQCBzdHJ1Y3Qgc3RydWN0X2V4dDJfZmlsc3lzIHsKIAlpbnQJCQkJY2x1c3Rl
cl9yYXRpb19iaXRzOwogCV9fdTE2CQkJCWRlZmF1bHRfYml0bWFwX3R5cGU7CiAJX191MTYJCQkJ
cGFkOworCV9fdTMyCQkJCWZzX251bV90aHJlYWRzOwogCS8qCiAJICogUmVzZXJ2ZWQgZm9yIGZ1
dHVyZSBleHBhbnNpb24KIAkgKi8KLQlfX3UzMgkJCQlyZXNlcnZlZFs1XTsKKwlfX3UzMgkJCQly
ZXNlcnZlZFs0XTsKIAogCS8qCiAJICogUmVzZXJ2ZWQgZm9yIHRoZSB1c2Ugb2YgdGhlIGNhbGxp
bmcgYXBwbGljYXRpb24uCkBAIC0yMTA2LDYgKzIxMDcsMzEgQEAgZXh0MmZzX2NvbnN0X2lub2Rl
KGNvbnN0IHN0cnVjdCBleHQyX2lub2RlX2xhcmdlICogbGFyZ2VfaW5vZGUpCiAJcmV0dXJuIChj
b25zdCBzdHJ1Y3QgZXh0Ml9pbm9kZSAqKSBsYXJnZV9pbm9kZTsKIH0KIAorc3RhdGljIGRncnBf
dCBleHQyZnNfZ2V0X2F2Z19ncm91cChleHQyX2ZpbHN5cyBmcykKK3sKKwlkZ3JwX3QJCQkgYXZl
cmFnZV9ncm91cDsKKwl1bnNpZ25lZAkJZmxleGJnX3NpemU7CisKKwlpZiAoZnMtPmZzX251bV90
aHJlYWRzIDw9IDEpCisJCXJldHVybiBmcy0+Z3JvdXBfZGVzY19jb3VudDsKKworCWF2ZXJhZ2Vf
Z3JvdXAgPSBmcy0+Z3JvdXBfZGVzY19jb3VudCAvIGZzLT5mc19udW1fdGhyZWFkczsKKwlpZiAo
YXZlcmFnZV9ncm91cCA8PSAxKQorCQlyZXR1cm4gMTsKKworCWlmIChleHQyZnNfaGFzX2ZlYXR1
cmVfZmxleF9iZyhmcy0+c3VwZXIpKSB7CisJCWludCB0aW1lcyA9IDE7CisKKwkJZmxleGJnX3Np
emUgPSAxIDw8IGZzLT5zdXBlci0+c19sb2dfZ3JvdXBzX3Blcl9mbGV4OworCQlpZiAoYXZlcmFn
ZV9ncm91cCAlIGZsZXhiZ19zaXplKSB7CisJCQl0aW1lcyA9IGF2ZXJhZ2VfZ3JvdXAgLyBmbGV4
Ymdfc2l6ZTsKKwkJCWF2ZXJhZ2VfZ3JvdXAgPSB0aW1lcyAqIGZsZXhiZ19zaXplOworCQl9CisJ
fQorCisJcmV0dXJuIGF2ZXJhZ2VfZ3JvdXA7Cit9CisKICN1bmRlZiBfSU5MSU5FXwogI2VuZGlm
CiAKZGlmZiAtLWdpdCBhL2xpYi9leHQyZnMvcndfYml0bWFwcy5jIGIvbGliL2V4dDJmcy9yd19i
aXRtYXBzLmMKaW5kZXggZDgwYzllYjguLmY1NjM1YzRkIDEwMDY0NAotLS0gYS9saWIvZXh0MmZz
L3J3X2JpdG1hcHMuYworKysgYi9saWIvZXh0MmZzL3J3X2JpdG1hcHMuYwpAQCAtMjMsNiArMjMs
NyBAQAogI2lmZGVmIEhBVkVfU1lTX1RZUEVTX0gKICNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KICNl
bmRpZgorI2luY2x1ZGUgPHB0aHJlYWQuaD4KIAogI2luY2x1ZGUgImV4dDJfZnMuaCIKICNpbmNs
dWRlICJleHQyZnMuaCIKQEAgLTIwNSwyMiArMjA2LDEyIEBAIHN0YXRpYyBpbnQgYml0bWFwX3Rh
aWxfdmVyaWZ5KHVuc2lnbmVkIGNoYXIgKmJpdG1hcCwgaW50IGZpcnN0LCBpbnQgbGFzdCkKIAly
ZXR1cm4gMTsKIH0KIAotc3RhdGljIGVycmNvZGVfdCByZWFkX2JpdG1hcHMoZXh0Ml9maWxzeXMg
ZnMsIGludCBkb19pbm9kZSwgaW50IGRvX2Jsb2NrKQorc3RhdGljIGVycmNvZGVfdCByZWFkX2Jp
dG1hcHNfcmFuZ2VfcHJlcGFyZShleHQyX2ZpbHN5cyBmcywgaW50IGRvX2lub2RlLCBpbnQgZG9f
YmxvY2spCiB7Ci0JZGdycF90IGk7Ci0JY2hhciAqYmxvY2tfYml0bWFwID0gMCwgKmlub2RlX2Jp
dG1hcCA9IDA7Ci0JY2hhciAqYnVmOwogCWVycmNvZGVfdCByZXR2YWw7CiAJaW50IGJsb2NrX25i
eXRlcyA9IEVYVDJfQ0xVU1RFUlNfUEVSX0dST1VQKGZzLT5zdXBlcikgLyA4OwogCWludCBpbm9k
ZV9uYnl0ZXMgPSBFWFQyX0lOT0RFU19QRVJfR1JPVVAoZnMtPnN1cGVyKSAvIDg7Ci0JaW50IHRh
aWxfZmxhZ3MgPSAwOwotCWludCBjc3VtX2ZsYWc7Ci0JdW5zaWduZWQgaW50CWNudDsKLQlibGs2
NF90CWJsazsKLQlibGs2NF90CWJsa19pdHIgPSBFWFQyRlNfQjJDKGZzLCBmcy0+c3VwZXItPnNf
Zmlyc3RfZGF0YV9ibG9jayk7Ci0JYmxrNjRfdCAgIGJsa19jbnQ7Ci0JZXh0Ml9pbm9fdCBpbm9f
aXRyID0gMTsKLQlleHQyX2lub190IGlub19jbnQ7CisJY2hhciAqYnVmOwogCiAJRVhUMl9DSEVD
S19NQUdJQyhmcywgRVhUMl9FVF9NQUdJQ19FWFQyRlNfRklMU1lTKTsKIApAQCAtMjMwLDExICsy
MjEsMTAgQEAgc3RhdGljIGVycmNvZGVfdCByZWFkX2JpdG1hcHMoZXh0Ml9maWxzeXMgZnMsIGlu
dCBkb19pbm9kZSwgaW50IGRvX2Jsb2NrKQogCiAJZnMtPndyaXRlX2JpdG1hcHMgPSBleHQyZnNf
d3JpdGVfYml0bWFwczsKIAotCWNzdW1fZmxhZyA9IGV4dDJmc19oYXNfZ3JvdXBfZGVzY19jc3Vt
KGZzKTsKLQogCXJldHZhbCA9IGV4dDJmc19nZXRfbWVtKHN0cmxlbihmcy0+ZGV2aWNlX25hbWUp
ICsgODAsICZidWYpOwogCWlmIChyZXR2YWwpCiAJCXJldHVybiByZXR2YWw7CisKIAlpZiAoZG9f
YmxvY2spIHsKIAkJaWYgKGZzLT5ibG9ja19tYXApCiAJCQlleHQyZnNfZnJlZV9ibG9ja19iaXRt
YXAoZnMtPmJsb2NrX21hcCk7CkBAIC0yNDMsMTEgKzIzMyw4IEBAIHN0YXRpYyBlcnJjb2RlX3Qg
cmVhZF9iaXRtYXBzKGV4dDJfZmlsc3lzIGZzLCBpbnQgZG9faW5vZGUsIGludCBkb19ibG9jaykK
IAkJcmV0dmFsID0gZXh0MmZzX2FsbG9jYXRlX2Jsb2NrX2JpdG1hcChmcywgYnVmLCAmZnMtPmJs
b2NrX21hcCk7CiAJCWlmIChyZXR2YWwpCiAJCQlnb3RvIGNsZWFudXA7Ci0JCXJldHZhbCA9IGlv
X2NoYW5uZWxfYWxsb2NfYnVmKGZzLT5pbywgMCwgJmJsb2NrX2JpdG1hcCk7Ci0JCWlmIChyZXR2
YWwpCi0JCQlnb3RvIGNsZWFudXA7Ci0JfSBlbHNlCi0JCWJsb2NrX25ieXRlcyA9IDA7CisJfQor
CiAJaWYgKGRvX2lub2RlKSB7CiAJCWlmIChmcy0+aW5vZGVfbWFwKQogCQkJZXh0MmZzX2ZyZWVf
aW5vZGVfYml0bWFwKGZzLT5pbm9kZV9tYXApOwpAQCAtMjU2LDEzICsyNDMsNjkgQEAgc3RhdGlj
IGVycmNvZGVfdCByZWFkX2JpdG1hcHMoZXh0Ml9maWxzeXMgZnMsIGludCBkb19pbm9kZSwgaW50
IGRvX2Jsb2NrKQogCQlyZXR2YWwgPSBleHQyZnNfYWxsb2NhdGVfaW5vZGVfYml0bWFwKGZzLCBi
dWYsICZmcy0+aW5vZGVfbWFwKTsKIAkJaWYgKHJldHZhbCkKIAkJCWdvdG8gY2xlYW51cDsKLQkJ
cmV0dmFsID0gaW9fY2hhbm5lbF9hbGxvY19idWYoZnMtPmlvLCAwLCAmaW5vZGVfYml0bWFwKTsK
Kwl9CisJZXh0MmZzX2ZyZWVfbWVtKCZidWYpOworCisJcmV0dXJuIHJldHZhbDsKKworY2xlYW51
cDoKKwlpZiAoZG9fYmxvY2spIHsKKwkJZXh0MmZzX2ZyZWVfYmxvY2tfYml0bWFwKGZzLT5ibG9j
a19tYXApOworCQlmcy0+YmxvY2tfbWFwID0gMDsKKwl9CisJaWYgKGRvX2lub2RlKSB7CisJCWV4
dDJmc19mcmVlX2lub2RlX2JpdG1hcChmcy0+aW5vZGVfbWFwKTsKKwkJZnMtPmlub2RlX21hcCA9
IDA7CisJfQorCWlmIChidWYpCisJCWV4dDJmc19mcmVlX21lbSgmYnVmKTsKKwlyZXR1cm4gcmV0
dmFsOworfQorCitzdGF0aWMgZXJyY29kZV90IHJlYWRfYml0bWFwc19yYW5nZV9zdGFydChleHQy
X2ZpbHN5cyBmcywgaW50IGRvX2lub2RlLCBpbnQgZG9fYmxvY2ssCisJCQkJCSAgZGdycF90IHN0
YXJ0LCBkZ3JwX3QgZW5kLCBwdGhyZWFkX211dGV4X3QgKm11dGV4LAorCQkJCQkgIGlvX2NoYW5u
ZWwgaW8pCit7CisJZGdycF90IGk7CisJY2hhciAqYmxvY2tfYml0bWFwID0gMCwgKmlub2RlX2Jp
dG1hcCA9IDA7CisJY2hhciAqYnVmOworCWVycmNvZGVfdCByZXR2YWw7CisJaW50IGJsb2NrX25i
eXRlcyA9IEVYVDJfQ0xVU1RFUlNfUEVSX0dST1VQKGZzLT5zdXBlcikgLyA4OworCWludCBpbm9k
ZV9uYnl0ZXMgPSBFWFQyX0lOT0RFU19QRVJfR1JPVVAoZnMtPnN1cGVyKSAvIDg7CisJaW50IHRh
aWxfZmxhZ3MgPSAwOworCWludCBjc3VtX2ZsYWc7CisJdW5zaWduZWQgaW50CWNudDsKKwlibGs2
NF90CWJsazsKKwlibGs2NF90CWJsa19pdHIgPSBFWFQyRlNfQjJDKGZzLCBmcy0+c3VwZXItPnNf
Zmlyc3RfZGF0YV9ibG9jayk7CisJYmxrNjRfdCAgIGJsa19jbnQ7CisJZXh0Ml9pbm9fdCBpbm9f
aXRyID0gMTsKKwlleHQyX2lub190IGlub19jbnQ7CisJaW9fY2hhbm5lbCB0aGlzX2lvOworCisJ
aWYgKCFpbykKKwkJdGhpc19pbyA9IGZzLT5pbzsKKwllbHNlCisJCXRoaXNfaW8gPSBpbzsKKwor
CWNzdW1fZmxhZyA9IGV4dDJmc19oYXNfZ3JvdXBfZGVzY19jc3VtKGZzKTsKKworCWlmIChkb19i
bG9jaykgeworCQlyZXR2YWwgPSBpb19jaGFubmVsX2FsbG9jX2J1Zih0aGlzX2lvLCAwLCAmYmxv
Y2tfYml0bWFwKTsKIAkJaWYgKHJldHZhbCkKIAkJCWdvdG8gY2xlYW51cDsKLQl9IGVsc2UKKwl9
IGVsc2UgeworCQlibG9ja19uYnl0ZXMgPSAwOworCX0KKworCWlmIChkb19pbm9kZSkgeworCQly
ZXR2YWwgPSBpb19jaGFubmVsX2FsbG9jX2J1Zih0aGlzX2lvLCAwLCAmaW5vZGVfYml0bWFwKTsK
KwkJaWYgKHJldHZhbCkKKwkJCWdvdG8gY2xlYW51cDsKKwl9IGVsc2UgewogCQlpbm9kZV9uYnl0
ZXMgPSAwOwotCWV4dDJmc19mcmVlX21lbSgmYnVmKTsKKwl9CiAKKwkvKiBpbyBzaG91bGQgYmUg
bnVsbCAqLwogCWlmIChmcy0+ZmxhZ3MgJiBFWFQyX0ZMQUdfSU1BR0VfRklMRSkgewogCQlibGsg
PSAoZXh0MmZzX2xlMzJfdG9fY3B1KGZzLT5pbWFnZV9oZWFkZXItPm9mZnNldF9pbm9kZW1hcCkg
LyBmcy0+YmxvY2tzaXplKTsKIAkJaW5vX2NudCA9IGZzLT5zdXBlci0+c19pbm9kZXNfY291bnQ7
CkBAIC0zMDMsNyArMzQ2LDkgQEAgc3RhdGljIGVycmNvZGVfdCByZWFkX2JpdG1hcHMoZXh0Ml9m
aWxzeXMgZnMsIGludCBkb19pbm9kZSwgaW50IGRvX2Jsb2NrKQogCQlnb3RvIHN1Y2Nlc3NfY2xl
YW51cDsKIAl9CiAKLQlmb3IgKGkgPSAwOyBpIDwgZnMtPmdyb3VwX2Rlc2NfY291bnQ7IGkrKykg
eworCWJsa19pdHIgKz0gKChibGs2NF90KXN0YXJ0ICogKGJsb2NrX25ieXRlcyA8PCAzKSk7CisJ
aW5vX2l0ciArPSAoKGJsazY0X3Qpc3RhcnQgKiAoaW5vZGVfbmJ5dGVzIDw8IDMpKTsKKwlmb3Ig
KGkgPSBzdGFydDsgaSA8PSBlbmQ7IGkrKykgewogCQlpZiAoYmxvY2tfYml0bWFwKSB7CiAJCQli
bGsgPSBleHQyZnNfYmxvY2tfYml0bWFwX2xvYyhmcywgaSk7CiAJCQlpZiAoKGNzdW1fZmxhZyAm
JgpAQCAtMzEyLDcgKzM1Nyw3IEBAIHN0YXRpYyBlcnJjb2RlX3QgcmVhZF9iaXRtYXBzKGV4dDJf
Zmlsc3lzIGZzLCBpbnQgZG9faW5vZGUsIGludCBkb19ibG9jaykKIAkJCSAgICAoYmxrID49IGV4
dDJmc19ibG9ja3NfY291bnQoZnMtPnN1cGVyKSkpCiAJCQkJYmxrID0gMDsKIAkJCWlmIChibGsp
IHsKLQkJCQlyZXR2YWwgPSBpb19jaGFubmVsX3JlYWRfYmxrNjQoZnMtPmlvLCBibGssCisJCQkJ
cmV0dmFsID0gaW9fY2hhbm5lbF9yZWFkX2JsazY0KHRoaXNfaW8sIGJsaywKIAkJCQkJCQkgICAg
ICAgMSwgYmxvY2tfYml0bWFwKTsKIAkJCQlpZiAocmV0dmFsKSB7CiAJCQkJCXJldHZhbCA9IEVY
VDJfRVRfQkxPQ0tfQklUTUFQX1JFQUQ7CkBAIC0zMzMsOCArMzc4LDEyIEBAIHN0YXRpYyBlcnJj
b2RlX3QgcmVhZF9iaXRtYXBzKGV4dDJfZmlsc3lzIGZzLCBpbnQgZG9faW5vZGUsIGludCBkb19i
bG9jaykKIAkJCX0gZWxzZQogCQkJCW1lbXNldChibG9ja19iaXRtYXAsIDAsIGJsb2NrX25ieXRl
cyk7CiAJCQljbnQgPSBibG9ja19uYnl0ZXMgPDwgMzsKKwkJCWlmIChtdXRleCkKKwkJCQlwdGhy
ZWFkX211dGV4X2xvY2sobXV0ZXgpOwogCQkJcmV0dmFsID0gZXh0MmZzX3NldF9ibG9ja19iaXRt
YXBfcmFuZ2UyKGZzLT5ibG9ja19tYXAsCiAJCQkJCSAgICAgICBibGtfaXRyLCBjbnQsIGJsb2Nr
X2JpdG1hcCk7CisJCQlpZiAobXV0ZXgpCisJCQkJcHRocmVhZF9tdXRleF91bmxvY2sobXV0ZXgp
OwogCQkJaWYgKHJldHZhbCkKIAkJCQlnb3RvIGNsZWFudXA7CiAJCQlibGtfaXRyICs9IGJsb2Nr
X25ieXRlcyA8PCAzOwpAQCAtMzQ3LDcgKzM5Niw3IEBAIHN0YXRpYyBlcnJjb2RlX3QgcmVhZF9i
aXRtYXBzKGV4dDJfZmlsc3lzIGZzLCBpbnQgZG9faW5vZGUsIGludCBkb19ibG9jaykKIAkJCSAg
ICAoYmxrID49IGV4dDJmc19ibG9ja3NfY291bnQoZnMtPnN1cGVyKSkpCiAJCQkJYmxrID0gMDsK
IAkJCWlmIChibGspIHsKLQkJCQlyZXR2YWwgPSBpb19jaGFubmVsX3JlYWRfYmxrNjQoZnMtPmlv
LCBibGssCisJCQkJcmV0dmFsID0gaW9fY2hhbm5lbF9yZWFkX2JsazY0KHRoaXNfaW8sIGJsaywK
IAkJCQkJCQkgICAgICAgMSwgaW5vZGVfYml0bWFwKTsKIAkJCQlpZiAocmV0dmFsKSB7CiAJCQkJ
CXJldHZhbCA9IEVYVDJfRVRfSU5PREVfQklUTUFQX1JFQUQ7CkBAIC0zNjksMjkgKzQxOCwyOCBA
QCBzdGF0aWMgZXJyY29kZV90IHJlYWRfYml0bWFwcyhleHQyX2ZpbHN5cyBmcywgaW50IGRvX2lu
b2RlLCBpbnQgZG9fYmxvY2spCiAJCQl9IGVsc2UKIAkJCQltZW1zZXQoaW5vZGVfYml0bWFwLCAw
LCBpbm9kZV9uYnl0ZXMpOwogCQkJY250ID0gaW5vZGVfbmJ5dGVzIDw8IDM7CisJCQlpZiAobXV0
ZXgpCisJCQkJcHRocmVhZF9tdXRleF9sb2NrKG11dGV4KTsKIAkJCXJldHZhbCA9IGV4dDJmc19z
ZXRfaW5vZGVfYml0bWFwX3JhbmdlMihmcy0+aW5vZGVfbWFwLAogCQkJCQkgICAgICAgaW5vX2l0
ciwgY250LCBpbm9kZV9iaXRtYXApOworCQkJaWYgKG11dGV4KQorCQkJCXB0aHJlYWRfbXV0ZXhf
dW5sb2NrKG11dGV4KTsKIAkJCWlmIChyZXR2YWwpCiAJCQkJZ290byBjbGVhbnVwOwogCQkJaW5v
X2l0ciArPSBpbm9kZV9uYnl0ZXMgPDwgMzsKIAkJfQogCX0KIAotCS8qIE1hcmsgZ3JvdXAgYmxv
Y2tzIGZvciBhbnkgQkxPQ0tfVU5JTklUIGdyb3VwcyAqLwotCWlmIChkb19ibG9jaykgewotCQly
ZXR2YWwgPSBtYXJrX3VuaW5pdF9iZ19ncm91cF9ibG9ja3MoZnMpOwotCQlpZiAocmV0dmFsKQot
CQkJZ290byBjbGVhbnVwOwotCX0KLQogc3VjY2Vzc19jbGVhbnVwOgotCWlmIChpbm9kZV9iaXRt
YXApIHsKLQkJZXh0MmZzX2ZyZWVfbWVtKCZpbm9kZV9iaXRtYXApOwotCQlmcy0+ZmxhZ3MgJj0g
fkVYVDJfRkxBR19JQklUTUFQX1RBSUxfUFJPQkxFTTsKLQl9Ci0JaWYgKGJsb2NrX2JpdG1hcCkg
ewotCQlleHQyZnNfZnJlZV9tZW0oJmJsb2NrX2JpdG1hcCk7Ci0JCWZzLT5mbGFncyAmPSB+RVhU
Ml9GTEFHX0JCSVRNQVBfVEFJTF9QUk9CTEVNOworCWlmIChzdGFydCA9PSAwICYmIGVuZCA9PSBm
cy0+Z3JvdXBfZGVzY19jb3VudCAtIDEpIHsKKwkJaWYgKGlub2RlX2JpdG1hcCkgeworCQkJZXh0
MmZzX2ZyZWVfbWVtKCZpbm9kZV9iaXRtYXApOworCQkJZnMtPmZsYWdzICY9IH5FWFQyX0ZMQUdf
SUJJVE1BUF9UQUlMX1BST0JMRU07CisJCX0KKwkJaWYgKGJsb2NrX2JpdG1hcCkgeworCQkJZXh0
MmZzX2ZyZWVfbWVtKCZibG9ja19iaXRtYXApOworCQkJZnMtPmZsYWdzICY9IH5FWFQyX0ZMQUdf
QkJJVE1BUF9UQUlMX1BST0JMRU07CisJCX0KIAl9CiAJZnMtPmZsYWdzIHw9IHRhaWxfZmxhZ3M7
CiAJcmV0dXJuIDA7CkBAIC00MTIsNiArNDYwLDE2MSBAQCBjbGVhbnVwOgogCWlmIChidWYpCiAJ
CWV4dDJmc19mcmVlX21lbSgmYnVmKTsKIAlyZXR1cm4gcmV0dmFsOworCit9CisKK3N0YXRpYyBl
cnJjb2RlX3QgcmVhZF9iaXRtYXBzX3JhbmdlX2VuZChleHQyX2ZpbHN5cyBmcywgaW50IGRvX2lu
b2RlLCBpbnQgZG9fYmxvY2spCit7CisJZXJyY29kZV90IHJldHZhbCA9IDA7CisKKwkvKiBNYXJr
IGdyb3VwIGJsb2NrcyBmb3IgYW55IEJMT0NLX1VOSU5JVCBncm91cHMgKi8KKwlpZiAoZG9fYmxv
Y2spIHsKKwkJcmV0dmFsID0gbWFya191bmluaXRfYmdfZ3JvdXBfYmxvY2tzKGZzKTsKKwkJaWYg
KHJldHZhbCkKKwkJCWdvdG8gY2xlYW51cDsKKwl9CisKKwlyZXR1cm4gcmV0dmFsOworY2xlYW51
cDoKKwlpZiAoZG9fYmxvY2spIHsKKwkJZXh0MmZzX2ZyZWVfYmxvY2tfYml0bWFwKGZzLT5ibG9j
a19tYXApOworCQlmcy0+YmxvY2tfbWFwID0gMDsKKwl9CisJaWYgKGRvX2lub2RlKSB7CisJCWV4
dDJmc19mcmVlX2lub2RlX2JpdG1hcChmcy0+aW5vZGVfbWFwKTsKKwkJZnMtPmlub2RlX21hcCA9
IDA7CisJfQorCXJldHVybiByZXR2YWw7Cit9CisKK3N0YXRpYyBlcnJjb2RlX3QgcmVhZF9iaXRt
YXBzX3JhbmdlKGV4dDJfZmlsc3lzIGZzLCBpbnQgZG9faW5vZGUsIGludCBkb19ibG9jaywKKwkJ
CQkgICAgZGdycF90IHN0YXJ0LCBkZ3JwX3QgZW5kKQoreworCWVycmNvZGVfdCByZXR2YWw7CisK
KwlyZXR2YWwgPSByZWFkX2JpdG1hcHNfcmFuZ2VfcHJlcGFyZShmcywgZG9faW5vZGUsIGRvX2Js
b2NrKTsKKwlpZiAocmV0dmFsKQorCQlyZXR1cm4gcmV0dmFsOworCisJcmV0dmFsID0gcmVhZF9i
aXRtYXBzX3JhbmdlX3N0YXJ0KGZzLCBkb19pbm9kZSwgZG9fYmxvY2ssIHN0YXJ0LCBlbmQsIE5V
TEwsIE5VTEwpOworCWlmIChyZXR2YWwpCisJCXJldHVybiByZXR2YWw7CisKKwlyZXR1cm4gcmVh
ZF9iaXRtYXBzX3JhbmdlX2VuZChmcywgZG9faW5vZGUsIGRvX2Jsb2NrKTsKK30KKworc3RydWN0
IHJlYWRfYml0bWFwc190aHJlYWRfaW5mbyB7CisJZXh0Ml9maWxzeXMJcmJ0X2ZzOworCWludCAJ
CXJidF9kb19pbm9kZTsKKwlpbnQJCXJidF9kb19ibG9jazsKKwlkZ3JwX3QJCXJidF9ncnBfc3Rh
cnQ7CisJZGdycF90CQlyYnRfZ3JwX2VuZDsKKwllcnJjb2RlX3QJcmJ0X3JldHZhbDsKKwlwdGhy
ZWFkX211dGV4X3QgKnJidF9tdXRleDsKKwlpb19jaGFubmVsICAgICAgcmJ0X2lvOworfTsKKwor
c3RhdGljIHZvaWQqIHJlYWRfYml0bWFwc190aHJlYWQodm9pZCAqZGF0YSkKK3sKKwlzdHJ1Y3Qg
cmVhZF9iaXRtYXBzX3RocmVhZF9pbmZvICpyYnQgPSBkYXRhOworCisJcmJ0LT5yYnRfcmV0dmFs
ID0gcmVhZF9iaXRtYXBzX3JhbmdlX3N0YXJ0KHJidC0+cmJ0X2ZzLAorCQkJCXJidC0+cmJ0X2Rv
X2lub2RlLCByYnQtPnJidF9kb19ibG9jaywKKwkJCQlyYnQtPnJidF9ncnBfc3RhcnQsIHJidC0+
cmJ0X2dycF9lbmQsCisJCQkJcmJ0LT5yYnRfbXV0ZXgsIHJidC0+cmJ0X2lvKTsKKwlyZXR1cm4g
TlVMTDsKK30KKworc3RhdGljIGVycmNvZGVfdCByZWFkX2JpdG1hcHMoZXh0Ml9maWxzeXMgZnMs
IGludCBkb19pbm9kZSwgaW50IGRvX2Jsb2NrKQoreworCXB0aHJlYWRfYXR0cl90CWF0dHI7CisJ
aW50IG51bV90aHJlYWRzID0gZnMtPmZzX251bV90aHJlYWRzOworCXB0aHJlYWRfdCAqdGhyZWFk
X2lkcyA9IE5VTEw7CisJc3RydWN0IHJlYWRfYml0bWFwc190aHJlYWRfaW5mbyAqdGhyZWFkX2lu
Zm9zID0gTlVMTDsKKwlwdGhyZWFkX211dGV4X3QgcmJ0X211dGV4ID0gUFRIUkVBRF9NVVRFWF9J
TklUSUFMSVpFUjsKKwllcnJjb2RlX3QgcmV0dmFsOworCWVycmNvZGVfdCByYzsKKwlkZ3JwX3Qg
YXZlcmFnZV9ncm91cDsKKwlpbnQgaTsKKwlpb19tYW5hZ2VyIG1hbmFnZXIgPSB1bml4X2lvX21h
bmFnZXI7CisKKwlpZiAobnVtX3RocmVhZHMgPD0gMSB8fCAoZnMtPmZsYWdzICYgRVhUMl9GTEFH
X0lNQUdFX0ZJTEUpKQorCQlyZXR1cm4gcmVhZF9iaXRtYXBzX3JhbmdlKGZzLCBkb19pbm9kZSwg
ZG9fYmxvY2ssIDAsIGZzLT5ncm91cF9kZXNjX2NvdW50IC0gMSk7CisKKwlyZXR2YWwgPSBwdGhy
ZWFkX2F0dHJfaW5pdCgmYXR0cik7CisJaWYgKHJldHZhbCkKKwkJcmV0dXJuIHJldHZhbDsKKwor
CXRocmVhZF9pZHMgPSBjYWxsb2Moc2l6ZW9mKHB0aHJlYWRfdCksIG51bV90aHJlYWRzKTsKKwlp
ZiAoIXRocmVhZF9pZHMpCisJCXJldHVybiAtRU5PTUVNOworCisJdGhyZWFkX2luZm9zID0gY2Fs
bG9jKHNpemVvZihzdHJ1Y3QgcmVhZF9iaXRtYXBzX3RocmVhZF9pbmZvKSwKKwkJCQludW1fdGhy
ZWFkcyk7CisJaWYgKCF0aHJlYWRfaW5mb3MpCisJCWdvdG8gb3V0OworCisJYXZlcmFnZV9ncm91
cCA9IGV4dDJmc19nZXRfYXZnX2dyb3VwKGZzKTsKKwlyZXR2YWwgPSByZWFkX2JpdG1hcHNfcmFu
Z2VfcHJlcGFyZShmcywgZG9faW5vZGUsIGRvX2Jsb2NrKTsKKwlpZiAocmV0dmFsKQorCQlnb3Rv
IG91dDsKKworCWZwcmludGYoc3Rkb3V0LCAiTXVsdGlwbGUgdGhyZWFkcyB0cmlnZ2VyZWQgdG8g
cmVhZCBiaXRtYXBzXG4iKTsKKwlmb3IgKGkgPSAwOyBpIDwgbnVtX3RocmVhZHM7IGkrKykgewor
CQl0aHJlYWRfaW5mb3NbaV0ucmJ0X2ZzID0gZnM7CisJCXRocmVhZF9pbmZvc1tpXS5yYnRfZG9f
aW5vZGUgPSBkb19pbm9kZTsKKwkJdGhyZWFkX2luZm9zW2ldLnJidF9kb19ibG9jayA9IGRvX2Js
b2NrOworCQl0aHJlYWRfaW5mb3NbaV0ucmJ0X211dGV4ID0gJnJidF9tdXRleDsKKwkJaWYgKGkg
PT0gMCkKKwkJCXRocmVhZF9pbmZvc1tpXS5yYnRfZ3JwX3N0YXJ0ID0gMDsKKwkJZWxzZQorCQkJ
dGhyZWFkX2luZm9zW2ldLnJidF9ncnBfc3RhcnQgPSBhdmVyYWdlX2dyb3VwICogaSArIDE7CisK
KwkJaWYgKGkgPT0gbnVtX3RocmVhZHMgLSAxKQorCQkJdGhyZWFkX2luZm9zW2ldLnJidF9ncnBf
ZW5kID0gZnMtPmdyb3VwX2Rlc2NfY291bnQgLSAxOworCQllbHNlCisJCQl0aHJlYWRfaW5mb3Nb
aV0ucmJ0X2dycF9lbmQgPSBhdmVyYWdlX2dyb3VwICogKGkgKyAxKTsKKwkJcmV0dmFsID0gbWFu
YWdlci0+b3Blbihmcy0+ZGV2aWNlX25hbWUsIElPX0ZMQUdfUlcsCisJCQkJCSZ0aHJlYWRfaW5m
b3NbaV0ucmJ0X2lvKTsKKwkJaWYgKHJldHZhbCkKKwkJCWJyZWFrOworCQlpb19jaGFubmVsX3Nl
dF9ibGtzaXplKHRocmVhZF9pbmZvc1tpXS5yYnRfaW8sIGZzLT5pby0+YmxvY2tfc2l6ZSk7CisJ
CXJldHZhbCA9IHB0aHJlYWRfY3JlYXRlKCZ0aHJlYWRfaWRzW2ldLCAmYXR0ciwKKwkJCQkJJnJl
YWRfYml0bWFwc190aHJlYWQsICZ0aHJlYWRfaW5mb3NbaV0pOworCQlpZiAocmV0dmFsKSB7CisJ
CQlpb19jaGFubmVsX2Nsb3NlKHRocmVhZF9pbmZvc1tpXS5yYnRfaW8pOworCQkJYnJlYWs7CisJ
CX0KKwl9CisJZm9yIChpID0gMDsgaSA8IG51bV90aHJlYWRzOyBpKyspIHsKKwkJaWYgKCF0aHJl
YWRfaWRzW2ldKQorCQkJYnJlYWs7CisJCXJjID0gcHRocmVhZF9qb2luKHRocmVhZF9pZHNbaV0s
IE5VTEwpOworCQlpZiAocmMgJiYgIXJldHZhbCkKKwkJCXJldHZhbCA9IHJjOworCQlyYyA9IHRo
cmVhZF9pbmZvc1tpXS5yYnRfcmV0dmFsOworCQlpZiAocmMgJiYgIXJldHZhbCkKKwkJCXJldHZh
bCA9IHJjOworCQlpb19jaGFubmVsX2Nsb3NlKHRocmVhZF9pbmZvc1tpXS5yYnRfaW8pOworCX0K
K291dDoKKwlyYyA9IHB0aHJlYWRfYXR0cl9kZXN0cm95KCZhdHRyKTsKKwlpZiAocmMgJiYgIXJl
dHZhbCkKKwkJcmV0dmFsID0gcmM7CisJZnJlZSh0aHJlYWRfaW5mb3MpOworCWZyZWUodGhyZWFk
X2lkcyk7CisKKwlpZiAoIXJldHZhbCkKKwkJcmV0dmFsID0gcmVhZF9iaXRtYXBzX3JhbmdlX2Vu
ZChmcywgZG9faW5vZGUsIGRvX2Jsb2NrKTsKKworCWlmICghcmV0dmFsKSB7CisJCWlmIChkb19p
bm9kZSkKKwkJCWZzLT5mbGFncyAmPSB+RVhUMl9GTEFHX0lCSVRNQVBfVEFJTF9QUk9CTEVNOwor
CQlpZiAoZG9fYmxvY2spCisJCQlmcy0+ZmxhZ3MgJj0gfkVYVDJfRkxBR19CQklUTUFQX1RBSUxf
UFJPQkxFTTsKKwl9CisKKwlyZXR1cm4gcmV0dmFsOwogfQogCiBlcnJjb2RlX3QgZXh0MmZzX3Jl
YWRfaW5vZGVfYml0bWFwKGV4dDJfZmlsc3lzIGZzKQotLSAKMi4yNS40Cgo=
--0000000000000fc4f705af7ccfae--
