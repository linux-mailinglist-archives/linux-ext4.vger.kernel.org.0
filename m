Return-Path: <linux-ext4+bounces-94-lists+linux-ext4=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CEEA7F5536
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 01:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C9261C20A9F
	for <lists+linux-ext4@lfdr.de>; Thu, 23 Nov 2023 00:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F08D63B;
	Thu, 23 Nov 2023 00:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="EJky0xgk"
X-Original-To: linux-ext4@vger.kernel.org
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 784041AE
	for <linux-ext4@vger.kernel.org>; Wed, 22 Nov 2023 16:19:17 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-543c3756521so451161a12.2
        for <linux-ext4@vger.kernel.org>; Wed, 22 Nov 2023 16:19:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1700698756; x=1701303556; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/KrFqq6blt1lo7Kf9Cf57uU43ncdJqUq9kktaS62s5k=;
        b=EJky0xgk2GYWbBh5GeWhNGifrsZa+aw6znG5la1SOCQqVEpkEb4v3IMKgb+hdQcmVq
         7Ds/LPPcA9aWIVl5flUrRux+cXotIZ/8kAtSq7t1TCEVJdtK1HiF3/gmfp5Arc/Hg4Qz
         O2P35VKdqIRcGI7YCIB+IdXqXpDDUzhMHcJhs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700698756; x=1701303556;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/KrFqq6blt1lo7Kf9Cf57uU43ncdJqUq9kktaS62s5k=;
        b=oe4hlXU92sDWgbpbyn3QdmgE5M+ItBSQ8plBniOwd9H2BqcWVEbRGBeM+TYO0ZDigD
         B0jveJRZrr2eQS8tz2RMb8GRFrCsWEwpeLTF11i9FXTt9uO4y5+9EA5rFKT5s6p7zyd/
         uN+YhcQIinxbcaLUP4hw3cu3iJ/v2OIynfL0PNUksV7NfQ5ACXE6CTGBFyoASgfw/+eT
         iFsv6z0JzFtgF2hi27quBWuYLuqPVcRvRrcQOn+WqJeyaECiSSL+mB5dmoieVEN+6Tzn
         zLxWIM/HKgoodSZ0ktKFc6oPfxn2H4wp7VlZsguu25z/z+Big9csIFhs13CtFFnwvDsl
         3x/A==
X-Gm-Message-State: AOJu0YzwQ3zf+5zUuW+XaMMadKCaJDjODJ4XuXc4rCt3ZQz6k7Z7Dd0k
	HC9lj9ebQw7jMfFXPP+FuHciMerYI8l5Is5SDV3Zp1r/
X-Google-Smtp-Source: AGHT+IF+NgSduVCar4B58PyxSXaPOTPM3xzWnaesewiuZUsQGeP/iv463hSAVAN8T5gf+FUH2DMDbg==
X-Received: by 2002:a05:6402:3584:b0:548:5605:45c1 with SMTP id y4-20020a056402358400b00548560545c1mr2689556edc.21.1700698755851;
        Wed, 22 Nov 2023 16:19:15 -0800 (PST)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id c3-20020a056402120300b00530bc7cf377sm39044edw.12.2023.11.22.16.19.14
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Nov 2023 16:19:14 -0800 (PST)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5441ba3e53cso462037a12.1
        for <linux-ext4@vger.kernel.org>; Wed, 22 Nov 2023 16:19:14 -0800 (PST)
X-Received: by 2002:a17:906:cc:b0:9fe:3447:a84d with SMTP id
 12-20020a17090600cc00b009fe3447a84dmr2475163eji.23.1700698754069; Wed, 22 Nov
 2023 16:19:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-ext4@vger.kernel.org
List-Id: <linux-ext4.vger.kernel.org>
List-Subscribe: <mailto:linux-ext4+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ext4+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230816050803.15660-1-krisman@suse.de> <20231025-selektiert-leibarzt-5d0070d85d93@brauner>
 <655a9634.630a0220.d50d7.5063SMTPIN_ADDED_BROKEN@mx.google.com>
 <20231120-nihilismus-verehren-f2b932b799e0@brauner> <CAHk-=whTCWwfmSzv3uVLN286_WZ6coN-GNw=4DWja7NZzp5ytg@mail.gmail.com>
 <20231121022734.GC38156@ZenIV> <20231122211901.GJ38156@ZenIV>
In-Reply-To: <20231122211901.GJ38156@ZenIV>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 22 Nov 2023 16:18:56 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
Message-ID: <CAHk-=wh5WYPN7BLSUjUr_VBsPTxHOcMHo1gOH2P4+5NuXAsCKA@mail.gmail.com>
Subject: Re: [f2fs-dev] [PATCH v6 0/9] Support negative dentries on
 case-insensitive ext4 and f2fs
To: Al Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>, Gabriel Krisman Bertazi <krisman@suse.de>, tytso@mit.edu, 
	linux-f2fs-devel@lists.sourceforge.net, ebiggers@kernel.org, 
	linux-fsdevel@vger.kernel.org, jaegeuk@kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 22 Nov 2023 at 13:19, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The serious gap, AFAICS, is the interplay with open-by-fhandle.

So I'm obviously not a fan of igncase filesystems, but I don't think
this series actually changes any of that.

> It's not unfixable, but we need to figure out what to do when
> lookup runs into a disconnected directory alias.  d_splice_alias()
> will move it in place, all right, but any state ->lookup() has
> hung off the dentry that had been passed to it will be lost.

I guess this migth be about the new DCACHE_CASEFOLDED_NAME bit.

At least for now, that is only used by generic_ci_d_revalidate() for
negative dentries, so it shouldn't matter for that d_splice_alias()
that only does positive dentries. No?

Or is there something else you worry about?

Side note: Gabriel, as things are now, instead of that

        if (!d_is_casefolded_name(dentry))
                return 0;

in generic_ci_d_revalidate(), I would suggest that any time a
directory is turned into a case-folded one, you'd just walk all the
dentries for that directory and invalidate negative ones at that
point. Or was there some reason I missed that made it a good idea to
do it at run-time after-the-fact?

             Linus

