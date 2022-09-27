Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47E7E5ECBEB
	for <lists+linux-ext4@lfdr.de>; Tue, 27 Sep 2022 20:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbiI0SK6 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 27 Sep 2022 14:10:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232783AbiI0SK5 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 27 Sep 2022 14:10:57 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96FC35BC1A
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 11:10:56 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cv6so328302pjb.5
        for <linux-ext4@vger.kernel.org>; Tue, 27 Sep 2022 11:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=NpZ+9a6xMXbzILlPatVIhnE0rwKLVJkggnNAyG21fTU=;
        b=gBlm72qns+3J4O3qxr5dTeiniRsysaK+pIXz6KW/JBCrntrW7OFJzUsXJ+ltDjuvZ3
         TsZClT5xoPDiS8Q+J7wia8KQyfXmAM7IyAPvh+dmKcj1s0sJI5+Nb4ZdAyh8TNGVAjTY
         /R25BbdY9WzyVCMoImojcjOUtKdKBtHeSb29YJWyzl6dKYYUx0FiScMUweXTKaQRUV9i
         lU3i6aAjG6Wsp4ZcKA4OkSYZ4rNRaKhZxRChrZRDS11TiYxNLnwSmL6PnsXU51eaqfEX
         83K8w6tYV1JCkQHQe7uEXquIsahhGkFOSM1ZcvP8cCwmhUzR75+0gicvmrCJ+X/ADLeu
         vtng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=NpZ+9a6xMXbzILlPatVIhnE0rwKLVJkggnNAyG21fTU=;
        b=IW2K7qHugQm7RkrmNQW5ZjNQ/5NnXXhpw36gYtAB5IpsuAwBLW1gu6mRARCvolGBUl
         5Ty78lgG5WhkUHyIiJbyPVbNAw5kQ9NJOBx/KSXyTPtga3hZyoJBz3kaG0hrPJINe0sv
         1dvRvnw1sT95/Jrl4lezu1COq2dZUtH9+Ep0OG4Q/8Er1qj7Aa3drg2+I+nGkR8Fj625
         IuYOuwWBlrGE7lw/pXUKk5uPtr2Q17B95FuF6NTEKXfmHggnBLc9YLSWfluNGpEyhLla
         4aGILm2NwjCEoi74lZF7gofM3wiFg9ilQJJACHLNIPnP233t5ulckIXx6fzVkje6U8Kc
         0DJQ==
X-Gm-Message-State: ACrzQf1snWutqaIl8EwSZzPrXjhJ+FOqTUK9n0Dgj4rrsf0UQsHsRS1m
        Wa2082UcGleIf/uydU4RJa3sBv66esGw6A==
X-Google-Smtp-Source: AMsMyM5WHT7sBWk0/eaQvv4GJ0tGK09omz22LPAekw6h6fy/+p+nt+sZ6TvtmES04ujzsMJYIzG2Ug==
X-Received: by 2002:a17:902:8c8a:b0:179:eb8d:f41d with SMTP id t10-20020a1709028c8a00b00179eb8df41dmr4233261plo.62.1664302256006;
        Tue, 27 Sep 2022 11:10:56 -0700 (PDT)
Received: from localhost ([2406:7400:63:621e:5c1c:d320:a94b:9339])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902dace00b001728ac8af94sm1851721plx.248.2022.09.27.11.10.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 11:10:55 -0700 (PDT)
Date:   Tue, 27 Sep 2022 23:40:49 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Theodore Ts'o <tytso@mit.edu>
Cc:     bugzilla-daemon@kernel.org, linux-ext4@vger.kernel.org
Subject: Re: [Bug 216529] New: [fstests generic/048] BUG: Kernel NULL pointer
 dereference at 0x00000069, filemap_release_folio+0x88/0xb0
Message-ID: <20220927181049.jpk3b52ssmq326b5@riteshh-domain>
References: <bug-216529-13602@https.bugzilla.kernel.org/>
 <YzEySPNMuIcfsda9@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzEySPNMuIcfsda9@mit.edu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On 22/09/26 01:02AM, Theodore Ts'o wrote:
> On Sun, Sep 25, 2022 at 11:55:29AM +0000, bugzilla-daemon@kernel.org wrote:
> > https://bugzilla.kernel.org/show_bug.cgi?id=216529
> >
> >
> > Hit a panic on ppc64le, by running generic/048 with 1k block size:
>
> Hmm, does this reproduce reliably for you?  I test with a 1k block
> size on x86_64 as a proxy 4k block sizes on PPC64, where the blocksize
> < pagesize... and this isn't reproducing for me on x86, and I don't
> have access to a PPC64LE system.
>
> Ritesh, is this something you can take a look at it?  Thanks!

I was away for some personal work for last few days, but I am back to work from
today. Sure, I will take a look at this and will get back.

I did give this test a couple of runs though, but wasn't able to reproduce it.
But let me try few more things along with more iterations. Will update
accordingly.

-ritesh
