Return-Path: <linux-ext4+bounces-10472-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4206EBA7CE1
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 04:33:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7750C189A382
	for <lists+linux-ext4@lfdr.de>; Mon, 29 Sep 2025 02:33:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A8E01EDA02;
	Mon, 29 Sep 2025 02:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THFayHc8"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E331E5B64
	for <linux-ext4@vger.kernel.org>; Mon, 29 Sep 2025 02:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759113212; cv=none; b=mS3fmuecOAjP/+5dD0KF5uJfaXIgxeKg17cviKmm5auC2XMsFYVCADlWBZCFumdm98AIrA/ADnRPlgV3p2h83Lssuu0fGnm0WxCX6VYPkxdfr2nbeknnDEr0ZaS/aeAEbgNjk3Z189XL4t6K9TXi3iC368kS4CsdwVMQ4VIUih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759113212; c=relaxed/simple;
	bh=REkyw4bRuFFRLimMvu2xXosWLip2v7XNmc+rXOczHo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aMvtxhjuHQl6wHJdX+oJNvxpXte8Ccrle7qNR1H0Z+DKWN7rIP1SAffhKCrKn6pxwHDhTiIBhxHPU6ipMKOFlT/FAFK22S3p43DOHAGA15UnAoJGp+JMxxyNh8ytffMeSMCJjRVAolp2s+NurbEjtEaTw9au8voeCCvVSDHQ8N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THFayHc8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-3635bd94f3eso38499741fa.0
        for <linux-ext4@vger.kernel.org>; Sun, 28 Sep 2025 19:33:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759113208; x=1759718008; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pxwj1QJEX6CXy7NV+KeCrUs6LhKSXsDnjg/3jpxKK78=;
        b=THFayHc84Fvf7xJ8o8vGGhyy9HSeltoksDv568yTkm6qELboaO3yQVAN232Sg1FLWk
         IgsoIZLnv/kBrb8w0iYgKEk37C2mGjVrWEEmMvqAuW0ftY2pnss0KHqg6OynW7V5RJWj
         GgUCxGeJWpD4OeMuujV4kdsVFpDavaQPvSNwtexmY0At6Lhh90UbG3tJpDN3mXHQcOIq
         RvJH/BwYOIQN80eZeaPAffY/kadbSpr01+/txQMdCeZ4yAY5iAC28dDqkpMNOtiFjiVy
         Q1FSiY5tdl6/3Vs+zM9tGYUQtj14nePOYKAeSkrMe/9Qmncx60HY0Nxg4uejm5ht6cPP
         JdJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759113208; x=1759718008;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pxwj1QJEX6CXy7NV+KeCrUs6LhKSXsDnjg/3jpxKK78=;
        b=OX+1NeuL6k1dRggQI89d5gLHNVAH1MptNbTMFfgMVf5mgE1TZOCxjPeeBXRF8dUS6S
         jDFVQL9Ryztq2j3D0NYDFb/zocr4F4eIpVDyW2TVpEDc6Itdzj9r02CIDnOOlQ87Wqi3
         3TfvdHlLG1tRAYFZNH0W+S16a2eNSPh3eCGWDDx+Ht1m3H3ysFdtSB6v9lrtEo8CGNzn
         BQNBtUvAFWBWhbbsgXSBrTy4e9E2gtGhDWKBqInrRBKkWCHmslNXRl3p48j3uDoCwfnP
         l5xyZaJfg5jFhkVdWz1Uzt9HKow67DLQLWZ1GZjWyjAGsEd8ALXsM3zRwN+vTuIHFVQN
         7taA==
X-Forwarded-Encrypted: i=1; AJvYcCWV8HEU8ksb0P5Uv2DoiAEw9BHhDQkQT2FGvF+Gq/NpShJtrxpeWwKGl36Lr6Bp8kZgDjjpxk8bvjuW@vger.kernel.org
X-Gm-Message-State: AOJu0YyAiBsnyj9E5U3ezDTZOa+pP4owiHzARPv1RE03dX+pxSRYY/i5
	vPNfW/DYjsck+ePJMQGld6HcvWxsKo8WUl8coHQZyuTuFhAAYtxr4Aq/WIBsjcn/3DEi87a+oTo
	uqw3ywI+SLJyDlu+9g60iLoTK6CjeN6w=
X-Gm-Gg: ASbGncufklA9XnoOSgVfA6yhfsDDVOGAgw+/osz4pava7Phe0A2IdmfDEMrhi8OL2TD
	IuLGJGAvwei5w7Hg3IGcuhwzg8ZqJ8/f00jsBaixlUM9etPpZv8fZlIpTK2Y6c0agZLgH8ViW3G
	ex2BtCIzQBjjon4B6GLZPHjUXQcwHb7k6TE1MTByL043RlhwahjH029b8Bm7CLMJzIJ4kfPgvaS
	ySI0i2wQcyavX+ML+emJIWLeWtEFTU=
X-Google-Smtp-Source: AGHT+IEuCDEtuLpkrk2Kn/+L05CnfnbmVYaBZ9wc3su4A27X6O5uTdW9zKuMRQ1wU7+2gvxwzQWw1ENzsDf3mlYFRV4=
X-Received: by 2002:a2e:be8b:0:b0:36e:9e8f:ba4d with SMTP id
 38308e7fff4ca-36f7dda318cmr39724531fa.14.1759113207660; Sun, 28 Sep 2025
 19:33:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20200407064616.221459-3-harshadshirwadkar@gmail.com>
 <c7a41ba13a3551fca25d7498b9d4542a104fac74.camel@gmail.com>
 <CAHB1NagYz+BLXdEtUa7C_6-A6DDCT9Q+A7Vg6PXSwm9D7ZyAkQ@mail.gmail.com>
 <20250928034638.GC200463@mit.edu> <CAHB1NaifpACESRtCMsbF3f8EACD__gnM0bsXyyi4sQ0HYcJs=A@mail.gmail.com>
 <20250928210231.GB274922@mit.edu>
In-Reply-To: <20250928210231.GB274922@mit.edu>
From: Julian Sun <sunjunchao2870@gmail.com>
Date: Mon, 29 Sep 2025 10:33:16 +0800
X-Gm-Features: AS18NWBRGgNVzVj_yEKauPpPTYNAg_RcUBk_eJQmKz3JMMJc1x4HsvFGqysgzE0
Message-ID: <CAHB1NagobAcbdJ48TwnPhMauq5bh_f9SFAAcmp0YrsFfi5D+vw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] ext4: reimplement ext4_empty_dir() using is_dirent_block_empty
To: "Theodore Ts'o" <tytso@mit.edu>
Cc: Harshad Shirwadkar <harshadshirwadkar@gmail.com>, adilger@dilger.ca, jack@suse.cz, 
	Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

I really appreciate the detailed explanation=E2=80=94your explanation made =
the
current state of this patch set much clearer to me.
I=E2=80=99ll follow up with the work as you suggested.

On Mon, Sep 29, 2025 at 5:02=E2=80=AFAM Theodore Ts'o <tytso@mit.edu> wrote=
:
>
> On Sun, Sep 28, 2025 at 02:51:09PM +0800, Julian Sun wrote:
> > Emm. I checked the code and found that support for 3-level htrees was
> > added in 2017 via commit e08ac99fa2a2 ("ext4: add largedir feature"),
> > but this patch was submitted in 2020. Did I make a mistake somewhere?
>
> I made that statement when I tried forward porting Harshad's patches
> to 6.17-rc4, and one of the patch conflicts seemed to implyyy that
> dx_probe predated the3-level htree change.  But I could have been
> mistaken about why the patch conflict eixsts.
>
> > > There are
> > > also some hardening against maliciously fuzzed file systems that will
> > > prevent the patches from applying cleanly.
> >
> > Is this included in the xfstests test suite?
>
> For better or for worse, no.  The reason for this is that xfstests
> tends to avoid using pre-generated file systems becase they aren't
> portable to different file system types.  And in order to test
> deliberately corrupted, you generally need to include small corrupted
> file systems into xfstests.  You *could* try to create them as an
> ext4-specific test using debugfs to introduce the corruption, but
> that's quite painful, and in some cases the only way to corrupt the
> file system in that very specific way would require a hex editor.
>
> That being said, it's generally pretty obvious when bullet-proofing
> code has been added and it causes a merge conflict.  For example, I
> skipped forward-porting the third patch, "ext4: reimplement
> ext4_empty_dir() using is_dirent_block_empty" because there was some
> bullet-proofing code added in ext4_empty_dir() which caused the patch
> application to fail, and I was too third try to deal with it, and it
> strictly speaking wasn't necessary for the patch shrinking
> functionality.  That being said, the bullet proofing which was added
> to ext4_empty_dir(), *should* be added to the newly created
> i_dirent_block_empty() function introduced in the 2/3 patch in this
> series.
>
> > > Then we'd need to run regression tests on a variety of different ext4
> > > configurations to see if there are any regressions, and if so, they
> > > would need to be fixed.
> >
> > Is testing with xfstests sufficient? Or are there any other test
> > suites that can be used to test this patch set?
>
> Testing with xfstests are sufficient, but we need to test multiple
> file system configurations, but just the default "ext4 using a 4k
> blocksize".  So I tried to do a quick-and-dirty forward port of the
> patches, and they compiled and passed the 15-20 minute smoke test
> (running "kvm-xfstests smoke", or "gce-xfstests smoke").  But when I
> ran the full set of tests, this is what I found.
>
> ext4/4k: 594 tests, 4 failures, 65 skipped, 5196 seconds
>   Failures: generic/426 generic/756
>   Flaky: generic/041: 20% (1/5)   generic/049: 20% (1/5)
> ext4/1k: 588 tests, 3 failures, 69 skipped, 6306 seconds
>   Failures: generic/426 generic/756
>   Flaky: generic/043: 20% (1/5)
> ext4/ext3: 586 tests, 3 failures, 149 skipped, 4958 seconds
>   Flaky: generic/041: 40% (2/5)   generic/426: 60% (3/5)
>     generic/756: 60% (3/5)
> ext4/encrypt: 569 tests, 3 failures, 181 skipped, 3263 seconds
>   Failures: generic/426 generic/756
>   Flaky: generic/049: 40% (2/5)
> ext4/nojournal: 586 tests, 3 failures, 137 skipped, 3918 seconds
>   Failures: ext4/045 generic/426 generic/756
> ext4/ext3conv: 591 tests, 4 failures, 67 skipped, 5408 seconds
>   Failures: generic/426 generic/756
>   Flaky: ext4/045: 40% (2/5)   generic/040: 60% (3/5)
> ext4/adv: 587 tests, 10 failures, 73 skipped, 5487 seconds
>   Failures: [generic/347] generic/426 generic/756 [generic/757] [generic/=
764]
>     [generic/777]
>   Flaky: generic/047: 40% (2/5)   generic/475: 20% (1/5)
>     [generic/482: 40% (2/5)]   generic/547: 20% (1/5)
> ext4/dioread_nolock: 592 tests, 3 failures, 65 skipped, 4996 seconds
>   Failures: generic/426 generic/756
>   Flaky: generic/047: 40% (2/5)
> ext4/data_journal: 587 tests, 6 failures, 141 skipped, 5151 seconds
>   Failures: [generic/127] generic/426 generic/756
>   Flaky: generic/049: 60% (3/5)   generic/475: 60% (3/5)
>     generic/645: 40% (2/5)
> ext4/bigalloc_4k: 565 tests, 4 failures, 68 skipped, 5066 seconds
>   Failures: ext4/045
>   Flaky: generic/320: 60% (3/5)   generic/426: 60% (3/5)
>     generic/756: 60% (3/5)
> ext4/bigalloc_1k: 566 tests, 3 failures, 79 skipped, 5096 seconds
>   Failures: generic/426 generic/756
>   Flaky: generic/049: 20% (1/5)
> ext4/dax: 578 tests, 5 failures, 170 skipped, 3198 seconds
>   Failures: [generic/344] [generic/363] generic/426 generic/756
>   Flaky: generic/043: 20% (1/5)
> Totals: 7193 tests, 1264 skipped, 190 failures, 0 errors, 53862s
>
> (Tests in square brackets were failing with stock 6.17-rc4, so don't
> represent regressions.  Ignore them for the purposes of trying to fix
> up this patch set.)
>
> Now, some of thsee may be failures caused by my making a mistake when
> doing the forward port.  Basically, I bashed the patches until they
> built; and then I ran the smoke test; and then I kicked of the full
> test run, which takes about 2.5 hours using a dozen VM's.
>
> I don't have time to take this any further, so with your permission,
> if you're OK with my handing fiishing off this project to you, I'll
> send the patches as a reply to this message, and then "Your mission,
> should you use to accept it" (quoting from the "Mission Impossible" TV
> Show / Movie) would be:
>
> 1) Investigate the failures deailed above, and fix them.  Again, some
> of these failures may not be Harshads; it could be mine when I did the
> forward port.  Either way, we need to fix them before we can merge the
> changes upstream.
>
> 2) Do more cleanups on the patches as necessary.  While doing the
> forward port, I noted the following issues that should really be
> fixed.  You might find more things that need improvement; if so,
> please go for it!
>
> 2a) Although we are potentially modifying more metadata blocks in
> ext4_try_dir_shrink(), the number of journal credits requested by
> callers to ext4_delete_entry() were not increased.  This could result
> in the handle running out of credits, which will trigger a warning,
> and if the transaction runs out of space, could trigger a journal
> abort.  One way would simply be to increase the credits passed to
> ext4_journal_start().
>
> The other way would be to queue up the work and do the directory
> shrinking in workqueue, where the changes would be done in a
> completely separate journal handle.  This has the advantage that it
> avoids increasing the latency to the unlink() system call, since there
> is no reason why the change needs to happen as part of the system
> call, or in the same transaction as the unlink.
>
> 2b) Error checking is missing in some of the newly added code.  In
> particular the function calls in make_unindexed() are ignoring error
> returns.  More generally, while we do the directory shrnk, we need to
> check for potential problems; and if there are any failures, we need
> to leave the directory unchanged, possibly calling ext4_error() if
> file system corruption is dicovered, or just skipping the directory
> shirnk operation if it is some transient error --- for example, a
> memory allocation failure.
>
> 2c) As mentioned above, I skipped forward porting the 3rd patch
> series, and there is code to rigorously check for inconsistent file
> system corruptions lest we trigger a BUG or WARN or worse which is
> causing the patch application to fail.  That checking needs to be
> added to is_dirent_block_empty(), and while you're at it, please check
> all of the newly added code to make sure it won't misbehave if the
> file system structures have been corrupted in a particualrly inventive
> way.
>
> 2d)  Once (2c) is done forward port patch #3.
>
> 3) As discussed in this thread, once these patches are landed, the
> further work to merge leaf notes; to remove empty htree nodes; and to
> shorten the htree depth when necessary.
>
> > > Also, please note that this first set of changes doesn't really make =
a
> > > big difference for real-world use casses, since a directory block
> > > won't get dropped when it is completely empty....
> >
> > Yes, I think the biggest beneficiary is rm -rf-type workloads.
>
> The thing about rm -rf workloads is that if you eventually rmdir() the
> directory, all of the blocks will be released anyway.  That's probably
> why this feature is one that hasn't been high priority.  If you delete
> 75% of the files in a directory, you *could* do something like "mkdir
> foo.new ; mv foo/* foo.new ; rmdir foo ; mv foo.new foo", but of
> course that won't work if some other process is actively accessing the
> files when you are trying to do the "DIY directory shrink operation".
>
> Cheers,
>
>                                         - Ted
>

Thanks,
--=20
Julian Sun <sunjunchao2870@gmail.com>

