Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64E25500F9
	for <lists+linux-ext4@lfdr.de>; Sat, 18 Jun 2022 01:56:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236528AbiFQX4P (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 17 Jun 2022 19:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbiFQX4O (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 17 Jun 2022 19:56:14 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0310D4BBA5
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 16:56:13 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a2so9076754lfg.5
        for <linux-ext4@vger.kernel.org>; Fri, 17 Jun 2022 16:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F+eSgrgXoa7ILO8WNbcNZfo44Me97QuDoZqkqwP+mEA=;
        b=R8edasI0jKryGtSNUxXj0BmYducxhYBk53wbWs1DijQYxo2V48v0Kv4AdMxbJwiDvo
         O56w0J0+BrLWzWox4z97jqEag5PBCU15LSsVc2A/CM2imaH7hIXuzeBOV34hd1DQBtOL
         Roixli8+uZwRAl310eEhWgDYiu5257S2Kr2QyWgtMGOF6H33DDNXvqlFxhzsIUlAMsf7
         gfAATyD9S7LYPx/oEjptj3a3XZ+ptm9kgJwZKr54LhR0ZNblZphZzk9l9WIB+qB8wnYL
         6lgUN7qNvgeByKt/Nnf+fufygyBp2fhRh0rPibMQSy8X2/MYdDdgtJWXyagyZKylVNaY
         Xyfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F+eSgrgXoa7ILO8WNbcNZfo44Me97QuDoZqkqwP+mEA=;
        b=6WMaQ21jLz7Rs0uRfWXUpBgT+rv9yfEdfuY277WkELdokmUFkcHsy38dhokgvHGd1U
         dyoOSKquV+hOBERfj2Rxs5fMRRDx9wzkO3cQ50bup9B9LYqS5FJOuwNOwBNme1TYE9ZV
         RjZ+WWtO+Ry5+pXeTslv900wL9US9Rt50XSRspSoJMX+62JDxF0X5sFJyGnaBkZwOKVJ
         cxgk0iUFQdNk9JvCvOXLJdUgGwdWUaNOo9K/ulKNNVvA9V0VV/W7USw5AjDeKTv/nAIr
         p243XrX7D66IBHm9rQ0pStM/BvSlZXbxh6y0vl1b6nde7Xtg6dlDFdqoofPpRvXwP/nn
         jzRw==
X-Gm-Message-State: AJIora/Pl4yKyBBUb0KAiDOdN2h+XAC6PWYNREXWOCtthvInI2pCJWVJ
        FlyP5334E2G/M/ygfCDQKV9J2b1TxFHf+wy0fI0=
X-Google-Smtp-Source: AGRyM1sF1eNL7upkmtmv0xGSbHNGMIpNayq4UEhq//zCXEAom7ihTgNhNO8h4nIeOLnSLsKNUGNrqU30craBrQo3W+4=
X-Received: by 2002:a05:6512:2346:b0:479:43b1:8fcf with SMTP id
 p6-20020a056512234600b0047943b18fcfmr6809577lfu.441.1655510171180; Fri, 17
 Jun 2022 16:56:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAGQ4T_Jne-bxdP9rMNBzqXw16a4kD4FM=F5VuGgUbczj5WgCLA@mail.gmail.com>
 <Yqz8a0ggTjIU3h7T@mit.edu>
In-Reply-To: <Yqz8a0ggTjIU3h7T@mit.edu>
From:   Santosh S <santosh.letterz@gmail.com>
Date:   Fri, 17 Jun 2022 19:56:00 -0400
Message-ID: <CAGQ4T_J-43q5xszJK8yDTUt14NGjjQACK4Z1RST-ZQkju3xSzQ@mail.gmail.com>
Subject: Re: Overwrite faster than fallocate
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     linux-ext4@vger.kernel.org
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

 On Fri, Jun 17, 2022 at 6:13 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Jun 17, 2022 at 12:38:20PM -0400, Santosh S wrote:
> > Dear ext4 developers,
> >
> > This is my test - preallocate a large file (2G) and then do sequential
> > 4K direct-io writes to that file, with fdatasync after every write.
> > I am preallocating using fallocate mode 0. I noticed that if the 2G
> > file is pre-written rather than fallocate'd I get more than twice the
> > throughput. I could reproduce this with fio. The storage is nvme.
> > Kernel version is 5.3.18 on Suse.
> >
> > Am I doing something wrong or is this difference expected? Any
> > suggestion to get a better throughput without actually pre-writing the
> > file.
>
> This is, alas, expected.  The reason for this is because when you use
> fallocate, the extent is marked as uninitialized, so that when you
> read from the those newly allocated blocks, you don't see previously
> written data belonging to deleted files.  These files could contain
> someone else's e-mail, or medical information, etc.  So if we didn't
> do this, it would be a walking, talking HIPPA or PCI violation.
>
> So when you write to an fallocated region, and then call fdatasync(2),
> we need to update the metadata blocks to clear the uninitialized bit
> so that when you read from the file after a crash, you actually get
> the data that was written.  So the fdatasync(2) operation is quite the
> heavyweight operation, since it requries journal commit because of the
> required metadata update.  When you do an overwrite, there is no need
> to force a metadata update and journal update, which is why write(2)
> plus fdatasync(2) is much lighter weight when you do an overwrite.
>
> What enterprise databases (e.g., Oracle Enterprise Database and IBM's
> Informix DB) tend to do is to use fallocate a chunk of space (say,
> 16MB or 32MB), because for Legacy Unix OS's, this tends enable some
> file system's block allocators to be more likely to allocate a
> contiguous block range, and then immediate write zero's on that 16 or
> 32MB, plus a fdatasync(2).  This fdatasync(2) would update the extent
> tree once to make that 16MB or 32MB to be marked initialized to the
> database's tablespace file, so you only pay the metadata update once,
> instead of every few dozen kilobytes as you write each database commit
> into the tablespace file.
>
> There is also an old, out of tree patch which enables an fallocate
> mode called "no hide stale", which marks the extent tree blcoks which
> are allocated using fallocate(2) as initialized.  This substantially
> speeds things up, but it is potentially a walking, talking, HIPPA or
> PCI violation in that revealing previously written data is considered
> a horrible security violation by most file system developers.
>
> If you know, say, that a cluster file system is the only user of the
> file system, and all data is written encrypted at rest using a
> per-user key, such that exposing stale data is not a security
> disaster, the "no hide stale" flag could be "safe" in that highly
> specialized user case.
>
> But that assumes that file system authors can trust application
> writers not to do something stupid and insecure, and historically,
> file system authors (possibly with good reason, given bitter past
> experience) don't trust application writesr to do something which is
> very easy, and gooses performance, even if it has terrible side
> effects on either data robustness or data security.
>
> Effectively, the no hide stale flag could be considered an "Attractive
> Nuisance"[1] and so support for this feature has never been accepted
> into the mainline kernel, and never to any distro kernels, since the
> distribution companies don't want to be held liable for making an
> "acctive nuisance" that might enable application authors from shooting
> themselves in the foot.
>
> [1] https://en.wikipedia.org/wiki/Attractive_nuisance_doctrine
>
> In any case, the technique of fallocatE(2) plus zero-fill-write plus
> fdatasync(2) isn't *that* slow, and is only needed when you are first
> extending the tablespace file.  In the steady state, most database
> applications tend to be overwriting space, so this isn't an issue.
>
> In any case, if you need to get that last 5% or so of performance ---
> say, if you are are an enterprise database company interested in
> taking a full page advertisement on the back cover of Business Week
> Magazine touting how your enterprise database benchmarks are better
> than the competition --- the simple solution is to use a raw block
> device.  Of course, most end users want the convenience of the file
> system, but that's not the point if you are engaging in
> benchmarketing.   :-)
>
> Cheers,
>
>                                                 - Ted

Thank you for a comprehensive answer :-)

I have one more question - when I gradually increase the i/o transfer
size the performance degradation begins to lessen and at 32K it is
similar to the "overwriting the file" case. I assume this is because
the metadata update is now spread over 32K of data rather than 4K.
However, my understanding is that, in my case, an extent should
represent the max 128MiB of data and so the clearing of the
uninitialized bit for an extent should happen once every 128MiB, so
then why is a higher transfer size making a difference?

Santosh
