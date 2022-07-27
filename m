Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0440D582D2A
	for <lists+linux-ext4@lfdr.de>; Wed, 27 Jul 2022 18:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbiG0Qxc (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 27 Jul 2022 12:53:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240596AbiG0Qw3 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 27 Jul 2022 12:52:29 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1FB4AD7D
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 09:34:37 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id y141so16541635pfb.7
        for <linux-ext4@vger.kernel.org>; Wed, 27 Jul 2022 09:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dilger-ca.20210112.gappssmtp.com; s=20210112;
        h=from:message-id:mime-version:subject:date:in-reply-to:cc:to
         :references;
        bh=BjcOtoVTmsno1sYNjhMCxMueuLaSliOJ80J38dXdj3E=;
        b=icatVNS6qlefpbFeyxDVtGEzyaG6BQyNF0ML3t+yUlhGCvNZXjyIc/K6N8CFhxtwaf
         OKKY3iArCz9Ry82F8m2IPUXaFWuXTZAS8+Qiq4s51O8cXa2S+jLAU5dy1/chT/FcJ9I/
         hx6EaTbXjQ4SZQZWG+vkFJb3Y4+2Mxlj517PWROWYnE9UZMyKNW0RkSIYGMotByNnCu0
         T/SOuezumXx+T3EAYh43wFkzSzbyVdTEAdU/UK/ce9H3acKkcGwzrJapLFDGFCCn0RpI
         GL8hoFIWXD+XHG3WdB4uDq5WXeMXVIdiOPnUvSnuvooOB2sDmGHUFYchx8ys4pKO1hsh
         ZFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:message-id:mime-version:subject:date
         :in-reply-to:cc:to:references;
        bh=BjcOtoVTmsno1sYNjhMCxMueuLaSliOJ80J38dXdj3E=;
        b=iGZBSRy6b7HmkMXS4lL495SPs/eHR6P4iw9BrmUdeU/hdYxvd2oCoD2eDA64eofBxT
         HgIsa1++ROgLJc4/8EqFM9MT27J5zU9Ieb6ldvD29ZpkqfgL7/6UoY/dIzMPOh2XZfMg
         OfPHBTcgxTD29umG6SycQKliz9sTWy4p3hiMo4ytg3/6KefHVVukdRl62AHxyBwSoVOj
         wHQv+rNGEzexzARat+JRJ5iCw1zMAUqb3qdepa+aa/7LvZUCzi77ZJjBYZgOBO37lhvn
         Ib3FBGHsiV1/nTfneGTOD2HDL0KW+pj79YOp3l0gKX41cspJUe4h/3zgR0OAd8Sa+d84
         NTIw==
X-Gm-Message-State: AJIora+uFCfvfURIOGdexNAA6fA7SujXB0pmzmWvtyDfJKD8SYhb4Xzn
        /bg5oOHnm5NSG7KR3MADzamHZA==
X-Google-Smtp-Source: AGRyM1uob5M1A9/0QUDUTPAwiJPYGqowE8P7dOia1+F4P79/EMV12h2hlp8kn13hharABMBYa3Byng==
X-Received: by 2002:a05:6a00:1941:b0:50d:807d:530b with SMTP id s1-20020a056a00194100b0050d807d530bmr22663074pfk.17.1658939677178;
        Wed, 27 Jul 2022 09:34:37 -0700 (PDT)
Received: from cabot.adilger.int (S01061cabc081bf83.cg.shawcable.net. [70.77.221.9])
        by smtp.gmail.com with ESMTPSA id d4-20020a621d04000000b00528c8ed356dsm14425004pfd.96.2022.07.27.09.34.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2022 09:34:36 -0700 (PDT)
From:   Andreas Dilger <adilger@dilger.ca>
Message-Id: <B530A3E1-B96D-4CEF-AE12-F76CB52494DB@dilger.ca>
Content-Type: multipart/signed;
 boundary="Apple-Mail=_AF9BEB8E-9D91-481E-A4ED-0252E5240886";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: Ext4 mballoc behavior with mb_optimize_scan=1
Date:   Wed, 27 Jul 2022 10:34:33 -0600
In-Reply-To: <20220727105123.ckwrhbilzrxqpt24@quack3>
Cc:     linux-ext4@vger.kernel.org, Ted Tso <tytso@mit.edu>,
        Harshad Shirwadkar <harshadshirwadkar@gmail.com>
To:     Jan Kara <jack@suse.cz>
References: <20220727105123.ckwrhbilzrxqpt24@quack3>
X-Mailer: Apple Mail (2.3273)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org


--Apple-Mail=_AF9BEB8E-9D91-481E-A4ED-0252E5240886
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=us-ascii

On Jul 27, 2022, at 4:51 AM, Jan Kara <jack@suse.cz> wrote:
> 
> Hello,
> 
> before going on vacation I was tracking down why reaim benchmark regresses
> (10-20%) with larger number of processes with the new mb_optimize_scan
> strategy of mballoc. After a while I have reproduced the regression with a
> simple benchmark that just creates, fsyncs, and deletes lots of small files
> (22k) from 16 processes, each process has its own directory. The immediate
> reason for the slow down is that with mb_optimize_scan=1 the file blocks
> are spread among more block groups and thus we have more bitmaps to update
> in each transaction.
> 
> So the question is why mballoc with mb_optimize_scan=1 spreads allocations
> more among block groups. The situation is somewhat obscured by group
> preallocation feature of mballoc where each *CPU* holds a preallocation and
> small (below 64k) allocations on that CPU are allocated from this
> preallocation. If I trace creating of these group preallocations I can see
> that the block groups they are taken from look like:
> 
> mb_optimize_scan=0:
> 49 81 113 97 17 33 113 49 81 33 97 113 81 1 17 33 33 81 1 113 97 17 113 113
> 33 33 97 81 49 81 17 49
> 
> mb_optimize_scan=1:
> 127 126 126 125 126 127 125 126 127 124 123 124 122 122 121 120 119 118 117
> 116 115 116 114 113 111 110 109 108 107 106 105 104 104
> 
> So we can see that while with mb_optimize_scan=0 the preallocation is
> always take from one of a few groups (among which we jump mostly randomly)
> which mb_optimize_scan=1 we consistently drift from higher block groups to
> lower block groups.
> 
> The mb_optimize_scan=0 behavior is given by the fact that search for free
> space always starts in the same block group where the inode is allocated
> and the inode is always allocated in the same block group as its parent
> directory. So the create-delete benchmark generally keeps all inodes for
> one process in the same block group and thus allocations are always
> starting in that block group. Because files are small, we always succeed in
> finding free space in the starting block group and thus allocations are
> generally restricted to the several block groups where parent directories
> were originally allocated.
> 
> With mb_optimize_scan=1 the block group to allocate from is selected by
> ext4_mb_choose_next_group_cr0() so in this mode we completely ignore the
> "pack inode with data in the same group" rule. The reason why we keep
> drifting among block groups is that whenever free space in a block group is
> updated (blocks allocated / freed) we recalculate largest free order (see
> mb_mark_used() and mb_free_blocks()) and as a side effect that removes
> group from the bb_largest_free_order_node list and reinserts the group at
> the tail.
> 
> I have two questions about the mb_optimize_scan=1 strategy:
> 
> 1) Shouldn't we respect the initial goal group and try to allocate from it
> in ext4_mb_regular_allocator() before calling ext4_mb_choose_next_group()?

I would agree with this.  Keeping the allocations close to the inode is a
useful first-guess heuristic that fairly distributes load across the groups
and doesn't cost anything in terms of complexity/searching.  For multiple
writers of large inodes in the same group there might initially be some
contention, but with 8MB allocation chunks and 128MB groups this would be
resolved quickly, and those writers should end up in different groups after
the initial group is full.

> 2) The rotation of groups in mb_set_largest_free_order() seems a bit
> undesirable to me. In particular it seems pointless if the largest free
> order does not change. Was there some rationale behind it?

I'd actually been wondering about this same thing recently.  IMHO, it makes
sense for the per-CPU small block preallocation to stick with the same group,
once the current PA chunk is full, unless that group is full.  I don't think
it is desirable to fill every group in the filesystem only 1/32 full (or so)
and then move on to the next empty group.

Selecting a new group should only be done when the current group is (nearly)
full.  That avoids partial filling of all groups, and also avoids contention
on the group selection locks.

As for the rotation of the groups in the list, this was to avoid concurrent
writers always contending to get the same group at the start of the list.
However, it makes more sense if each writer (or per-CPU PA) is "sticky" with
a particular group until it is full and not do a new group search each time.

Cheers, Andreas






--Apple-Mail=_AF9BEB8E-9D91-481E-A4ED-0252E5240886
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQIzBAEBCAAdFiEEDb73u6ZejP5ZMprvcqXauRfMH+AFAmLhaRkACgkQcqXauRfM
H+DAdw/8CINCerigYd7pip8jlKbfFZAvXTnWLawgWErsgqvsuXiVa49wPN7b0rsd
8FBA/4+7FirSzI8H4nnJNK/ZLKLPRw46quzK+8xUwgQaC5POxRNEikW4NbPhZVd9
4dtO/o1zvzLrjDEl38Vfpb4c12tMD3uaahYF8B8F3XTmgrh0LQgqUt8CGD/WOi6T
R/MQ30gNcxoXAKJzAUmGOkqseKAGseXay3abxtDgc7hxv8dIhL+LnDjYaUj3GoZr
9ZEu1pDRhnojVVuSVDVVhrd7JtrNeW9RZCI9+MIE7/fgh4TyKBJqLidVe+0djSZN
L4ouvBv4otEHHQoCxV/VOG8pJxvUY1EyMaMf/nqrqiAoy39xc+5Fzb4BBzGnljfN
7e+55qj6nqb+HdXcLXto2xv35lHjOUStpsoOoYIxOfSy8DifeAwXFqn8e30HSmdH
FLmyPYcM8J0XGihouBfMyUwCLQ0FbYiDCUDsdXFwm14YofRkwgTMxFRNoP9pq6jY
r+9GrmYNe1xc0/BR7uEPEl2X2CKN9MUvIfZxGQkeszgzbj7p0e6pMfjhWt7y6ejC
cgTIvZ/sHTnuhkTyJENMrdyOSxRZ4o96rCDXtbLdjJmh53yddBDvbuhg7T9+guTh
SY30IVxJRS1al4Hi52NMcNIXDFBNCRNWyL6xDwsoxXts1UBdq/c=
=2cv9
-----END PGP SIGNATURE-----

--Apple-Mail=_AF9BEB8E-9D91-481E-A4ED-0252E5240886--
