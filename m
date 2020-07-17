Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 649D52230E3
	for <lists+linux-ext4@lfdr.de>; Fri, 17 Jul 2020 03:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgGQB4d (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 16 Jul 2020 21:56:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726231AbgGQB4c (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 16 Jul 2020 21:56:32 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3B5C061755
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jul 2020 18:56:32 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id t6so5903099pgq.1
        for <linux-ext4@vger.kernel.org>; Thu, 16 Jul 2020 18:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qsRBKN8QLdPNyhcwSV+uq9z8S14OK4+shsMWXoSHano=;
        b=fF8SXmuJ5dp+F3PTM2our2J4E+hDhHA0p3iDcnB/O91rUNgrshAnIKppEVbLV9YzFA
         4QV6KsmrWTalXlq6RfGoNa2i6J0lQkPm1oQS9mrzp5Iem/XFthEytoyzvTkpI8bk1neF
         ktTuLqsJ+g/DIvPLl/T+rEzFialug4jEbUek8pxOaE5o+AQKkHtPIHzgZoJ2YQGJmKhm
         uM82+Ak3HfxCJGEq8acmRO6w2zJLKq7xc3J9NI1zbXTRnM+AN/FMNGvvYJ17dAE0RFPy
         e1OIEHs7M7VC04J+vLieQoy1BO54eelNvQbGd9zmkoJ4+YAeR2fTBZi1H3+0AXZDoStB
         JYeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qsRBKN8QLdPNyhcwSV+uq9z8S14OK4+shsMWXoSHano=;
        b=GyXnuuwm2GYxX0I4ByKmBdRLSkh0uD94eqCTn/jZAsXZg3PRj/g06COKo7xNYLVDm0
         gs4Pyt4nzeuCnmreTApiRh7IthxHh1qvGrmf1aoq6JfmJZi8pNWah78n/2RPalZkYmeI
         tTAYAVa2BP+cWcu2KmHXh7uD0cG0rYDmmc48+Nl9pcV7nbTLnwJM8qedtm+Wr52bglmJ
         CKO1w3LIMXzRvGs33v9WDcj9cpf/oGNQw3jsY2TlLZ6C9GciG634fnvAmkz4UxwUK6vK
         8K9Fp6gLlPgW9HK7pjWpB0DL65AmVY3UE2Mmud/yeklVU3Hpjrj4XP58sdfs1eBF7RRs
         lrKQ==
X-Gm-Message-State: AOAM530AJajM+XhSoMsL4LIOP55VdSkJPNfBOzhZi2R2Xthdukc8rgx5
        ho7tP9HtVSDYKLtEs1aPy/94nUybJ08=
X-Google-Smtp-Source: ABdhPJw8pEBcXlCRGQ2zK0krljhxRjXz/nER5WspRB+U1hDcSxVBK7VwJySfVnXQhiryBo/CryuPIQ==
X-Received: by 2002:a63:f90f:: with SMTP id h15mr6578417pgi.53.1594950991806;
        Thu, 16 Jul 2020 18:56:31 -0700 (PDT)
Received: from google.com (124.190.199.35.bc.googleusercontent.com. [35.199.190.124])
        by smtp.gmail.com with ESMTPSA id d9sm5835817pfd.133.2020.07.16.18.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2020 18:56:31 -0700 (PDT)
Date:   Fri, 17 Jul 2020 01:56:27 +0000
From:   Satya Tangirala <satyat@google.com>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH 2/5] direct-io: add support for fscrypt using blk-crypto
Message-ID: <20200717015627.GA82163@google.com>
References: <20200709194751.2579207-1-satyat@google.com>
 <20200709194751.2579207-3-satyat@google.com>
 <20200710053406.GA25530@infradead.org>
 <20200713183619.GC722906@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200713183619.GC722906@gmail.com>
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Mon, Jul 13, 2020 at 11:36:19AM -0700, Eric Biggers wrote:
> On Fri, Jul 10, 2020 at 06:34:06AM +0100, Christoph Hellwig wrote:
> > On Thu, Jul 09, 2020 at 07:47:48PM +0000, Satya Tangirala wrote:
> > > From: Eric Biggers <ebiggers@google.com>
> > > 
> > > Set bio crypt contexts on bios by calling into fscrypt when required,
> > > and explicitly check for DUN continuity when adding pages to the bio.
> > > (While DUN continuity is usually implied by logical block contiguity,
> > > this is not the case when using certain fscrypt IV generation methods
> > > like IV_INO_LBLK_32).
> > 
> > I know it is asking you for more work, but instead of adding more
> > features to the legacy direct I/O code, could you just switch the user
> > of it (I guess this is for f2f2?) to the iomap one?
> 
> Eventually we should do that, as well as convert f2fs's fiemap, bmap, and llseek
> to use iomap.  However there's a nontrivial barrier to entry, at least for
> someone who isn't an expert in iomap, especially since f2fs currently doesn't
> use iomap at all and thus doesn't have an iomap_ops implementation.  And using
> ext4 as an example, there will be some subtle cases that need to be handled.
> 
> Satya says he's looking into it; we'll see what he can come up with and what the
> f2fs developers say.
> 
> If it turns out to be difficult and people think this patchset is otherwise
> ready, we probably shouldn't hold it up on that.  This is a very small patch,
> and Satya and I have to maintain it for years in downstream kernels anyway, so
> it will be used and tested regardless.  It would also be nice to allow userspace
> (e.g. xfstests) to assume that if the inlinecrypt mount option is supported,
> then direct I/O is supported too, without having to handle intermediate kernel
> releases where inlinecrypt was supported but not direct I/O.
> 
As Eric pointed out, it doesn't seem to be completely straightforward to
move f2fs to using iomap - I'm still looking into it, but for now I've
sent out v2 (and v3 just because I forgot to add a changelog to v2) with
the changes to fs/direct-io.c as is from v1, but (again, for the reasons
Eric points out) I think it'd be better not to hold this patch up for that.
> - Eric
