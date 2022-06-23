Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D393558898
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Jun 2022 21:22:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbiFWTWo (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 23 Jun 2022 15:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiFWTWX (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 23 Jun 2022 15:22:23 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEE036E7B6
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jun 2022 11:29:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o16so28167wra.4
        for <linux-ext4@vger.kernel.org>; Thu, 23 Jun 2022 11:29:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KrWGXFbNgMMhzSIizObhFKBuw+wLcBi2aRxew+I55bA=;
        b=Xlst84Z/0tJTVE0xKXosapYV/2tgGHCssDQFUZELwsmFTZv4Crs9w4Cu0GaBWoOuGi
         0iTcRmqFlHxCXrRnWZ+II1yIc6b2KGjFkDLVFjEsx9t3hneYUZDlcJvfdYeOjz0tXTEp
         ojegC4sC1Dtaey6K+FcZV3oLsacZ/NDevukbz+C6QYOItFV7xTPcz2iIxo2CoNCFiSe1
         001bsVMikK4j5iBnYcqEF5ffCkYUw5Nyv78wmGeMZ9sA+ECjx/tdJARm69gE+9JalUbm
         HNxTg0p9JrTd1a3HnMTXA/DtO6Xz5I2OEki3r7C1mWEzRe5dLdns0v/AX/ThxK83Aj3g
         yoew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KrWGXFbNgMMhzSIizObhFKBuw+wLcBi2aRxew+I55bA=;
        b=D0fzvxs4aRnyCZLdXr2ykVc9CGu0wU5dNB9y5S7u0+oKePrGchbi6jvy2cUPhKO0Kr
         6QrT9MrPdzag9Y7dTs8r8Bo1957aFHX4OhbueQS77zWZC3lkG8/ac+pn3dsRvGBvRQG6
         HO3aJqQy5komI2PWQI8CUrgLQP923rW6YTuUePIjSd9CVzzMRInN1T/jZkP3dUXe03KM
         VVsCj01wVb0h1uONlLSlk1INfo7Gy+LyJgwD2TrWAX5L+36dmOE78ZCr1Wc/YNtObxOS
         IQcHGwfJ+ZRGvBx62ih3pLMNIfl3H5R4KhzyTIWba2SNouKXg8TvOalebx3rxgR+lzZ6
         iYEA==
X-Gm-Message-State: AJIora96UCbbshvtBFsOAOCqkV+ZzpibKdw0XLrgs1D1YMLb1+eLbzmB
        gxln4KEhErPsrcoA9e6mWqA9X2HtN6STJ96z2VipAyKMInY=
X-Google-Smtp-Source: AGRyM1syjSl2Jzmxhtpzv0pQV0XQBWFHQPsRd3W2Hn761pw4MZB8at7HMK9KEoPKRQ5OSOQPJvPI8FfLMo3CsyGT+Zc=
X-Received: by 2002:a5d:588d:0:b0:218:4d47:bb66 with SMTP id
 n13-20020a5d588d000000b002184d47bb66mr9556046wrf.157.1656008939037; Thu, 23
 Jun 2022 11:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQ4T_Jne-bxdP9rMNBzqXw16a4kD4FM=F5VuGgUbczj5WgCLA@mail.gmail.com>
 <Yqz8a0ggTjIU3h7T@mit.edu> <CAGQ4T_J-43q5xszJK8yDTUt14NGjjQACK4Z1RST-ZQkju3xSzQ@mail.gmail.com>
 <117682F9-5CEF-44F2-935E-E048C8A9D75D@dilger.ca>
In-Reply-To: <117682F9-5CEF-44F2-935E-E048C8A9D75D@dilger.ca>
From:   Santosh S <santosh.letterz@gmail.com>
Date:   Thu, 23 Jun 2022 14:28:47 -0400
Message-ID: <CAGQ4T_LM9kYSHNWW+wJdXUzq7Ymf1+RGmot1Rqz9fChZBeRcAA@mail.gmail.com>
Subject: Re: Overwrite faster than fallocate
To:     Andreas Dilger <adilger@dilger.ca>
Cc:     "Theodore Ts'o" <tytso@mit.edu>, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jun 20, 2022 at 2:50 PM Andreas Dilger <adilger@dilger.ca> wrote:
>
> On Jun 17, 2022, at 5:56 PM, Santosh S <santosh.letterz@gmail.com> wrote:
> >
> > On Fri, Jun 17, 2022 at 6:13 PM Theodore Ts'o <tytso@mit.edu> wrote:
> >>
> >> On Fri, Jun 17, 2022 at 12:38:20PM -0400, Santosh S wrote:
> >>> Dear ext4 developers,
> >>>
> >>> This is my test - preallocate a large file (2G) and then do sequential
> >>> 4K direct-io writes to that file, with fdatasync after every write.
> >>> I am preallocating using fallocate mode 0. I noticed that if the 2G
> >>> file is pre-written rather than fallocate'd I get more than twice the
> >>> throughput. I could reproduce this with fio. The storage is nvme.
> >>> Kernel version is 5.3.18 on Suse.
> >>>
> >>> Am I doing something wrong or is this difference expected? Any
> >>> suggestion to get a better throughput without actually pre-writing the
> >>> file.
> >>
> >> This is, alas, expected.  The reason for this is because when you use
> >> fallocate, the extent is marked as uninitialized, so that when you
> >> read from the those newly allocated blocks, you don't see previously
> >> written data belonging to deleted files.  These files could contain
> >> someone else's e-mail, or medical information, etc.  So if we didn't
> >> do this, it would be a walking, talking HIPPA or PCI violation.
> >>
> >> So when you write to an fallocated region, and then call fdatasync(2),
> >> we need to update the metadata blocks to clear the uninitialized bit
> >> so that when you read from the file after a crash, you actually get
> >> the data that was written.  So the fdatasync(2) operation is quite the
> >> heavyweight operation, since it requries journal commit because of the
> >> required metadata update.  When you do an overwrite, there is no need
> >> to force a metadata update and journal update, which is why write(2)
> >> plus fdatasync(2) is much lighter weight when you do an overwrite.
> >>
> >> What enterprise databases (e.g., Oracle Enterprise Database and IBM's
> >> Informix DB) tend to do is to use fallocate a chunk of space (say,
> >> 16MB or 32MB), because for Legacy Unix OS's, this tends enable some
> >> file system's block allocators to be more likely to allocate a
> >> contiguous block range, and then immediate write zero's on that 16 or
> >> 32MB, plus a fdatasync(2).  This fdatasync(2) would update the extent
> >> tree once to make that 16MB or 32MB to be marked initialized to the
> >> database's tablespace file, so you only pay the metadata update once,
> >> instead of every few dozen kilobytes as you write each database commit
> >> into the tablespace file.
> >>
> >> There is also an old, out of tree patch which enables an fallocate
> >> mode called "no hide stale", which marks the extent tree blcoks which
> >> are allocated using fallocate(2) as initialized.  This substantially
> >> speeds things up, but it is potentially a walking, talking, HIPPA or
> >> PCI violation in that revealing previously written data is considered
> >> a horrible security violation by most file system developers.
> >>
> >> If you know, say, that a cluster file system is the only user of the
> >> file system, and all data is written encrypted at rest using a
> >> per-user key, such that exposing stale data is not a security
> >> disaster, the "no hide stale" flag could be "safe" in that highly
> >> specialized user case.
> >>
> >> But that assumes that file system authors can trust application
> >> writers not to do something stupid and insecure, and historically,
> >> file system authors (possibly with good reason, given bitter past
> >> experience) don't trust application writesr to do something which is
> >> very easy, and gooses performance, even if it has terrible side
> >> effects on either data robustness or data security.
> >>
> >> Effectively, the no hide stale flag could be considered an "Attractive
> >> Nuisance"[1] and so support for this feature has never been accepted
> >> into the mainline kernel, and never to any distro kernels, since the
> >> distribution companies don't want to be held liable for making an
> >> "acctive nuisance" that might enable application authors from shooting
> >> themselves in the foot.
> >>
> >> [1] https://en.wikipedia.org/wiki/Attractive_nuisance_doctrine
> >>
> >> In any case, the technique of fallocatE(2) plus zero-fill-write plus
> >> fdatasync(2) isn't *that* slow, and is only needed when you are first
> >> extending the tablespace file.  In the steady state, most database
> >> applications tend to be overwriting space, so this isn't an issue.
> >>
> >> In any case, if you need to get that last 5% or so of performance ---
> >> say, if you are are an enterprise database company interested in
> >> taking a full page advertisement on the back cover of Business Week
> >> Magazine touting how your enterprise database benchmarks are better
> >> than the competition --- the simple solution is to use a raw block
> >> device.  Of course, most end users want the convenience of the file
> >> system, but that's not the point if you are engaging in
> >> benchmarketing.   :-)
> >>
> >> Cheers,
> >>
> >>                                                - Ted
> >
> > Thank you for a comprehensive answer :-)
> >
> > I have one more question - when I gradually increase the i/o transfer
> > size the performance degradation begins to lessen and at 32K it is
> > similar to the "overwriting the file" case. I assume this is because
> > the metadata update is now spread over 32K of data rather than 4K.
>
> When splitting unwritten extents, the ext4 code will write out zero
> blocks up to 32KB by default (/sys/fs/ext4/*/extent_max_zeroout_kb)
> to avoid having millions of very small extents in a file (e.g. in
> case of a pathological alternating 4KB write pattern).  If your test
> is writing >= 32KB blocks then this no longer needs to be done.  If
> writing smaller blocks then it makes sense that the speed is 1/2 the
> raw speed because the file blocks are all being written twice (first
> with zeroes, then with actual data on a later write).
>
> 32KB (or 64KB) is a reasonable minimum size because any disk write
> will take the same time to write a single block or a whole sector,
> so doing writes in smaller units is not very efficient.  Depending
> on the underlying storage (e.g. RAID-6) it might be more efficient
> to set extent_max_zeroout_kb=1024 or similar.
>
> > However, my understanding is that, in my case, an extent should
> > represent the max 128MiB of data and so the clearing of the
> > uninitialized bit for an extent should happen once every 128MiB, so
> > then why is a higher transfer size making a difference?
>
> You are misunderstanding how uninitialized extents are cleared.  The
> uninitialized extent is split into two/three parts, where only the
> extent that has data written to it (min 32KB) is set to "initialized"
> and the remaining one/two extents are left uninitialized.  Otherwise,
> each write to an uninitialized extent would need up to 128MB of zeroes
> written to disk each time, which would be slow/high latency.
>
> Cheers, Andreas
>
>
Thank you and sorry for the delay in responding.

What kind of write will stop an uninitialized extent from splitting?
For example, I want to create a file, fallocate 512MB, and zero-fill
it. But I want the file system to only create 4 extents so they all
reside in the inode itself, and each extent represents the entire
128MB (so no splitting).
Even if I do large sized writes, my understanding is that ultimately
the kernel / hardware restrictions will split the the i/o into smaller
chunks thus causing the extent to split. For example, this is what I
see on my test system

# cat /sys/block/nvme1n1/queue/max_hw_sectors_kb
128
# cat /sys/block/nvme1n1/queue/max_sectors_kb
128

Santosh
