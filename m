Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C5B341222
	for <lists+linux-ext4@lfdr.de>; Fri, 19 Mar 2021 02:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229927AbhCSBco (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 18 Mar 2021 21:32:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbhCSBc0 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 18 Mar 2021 21:32:26 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26D34C06174A
        for <linux-ext4@vger.kernel.org>; Thu, 18 Mar 2021 18:32:26 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id l18so727800edc.9
        for <linux-ext4@vger.kernel.org>; Thu, 18 Mar 2021 18:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6rWuTdwIAioCQ0FaHL+KRRa/Mb7b3ZbPnuswryRkMnY=;
        b=IWZdFYJzvQrW8Fnra+b/kDT/UZ7DG6nfgLTT/qqy068fSbmyLtrEUYaSoZx8Ux6MNP
         ecCRkIcPXX0eIX0+Eq9iCimNLvvmTb+nErNOi+Qk6HRbA6WsW2pGLPvD+C3L43NYTn5i
         zFlfr7Ip9G84VdEg0alMaD2oTijj6ZWjbyIRL8eeXJDlWw2kQji4VAMnqQtpLdzi2fIF
         JpcgESkvfCLJFuOrr7JY8jT/9zbvwJJaiW07PxJrV8fLRMWm4F3bljztudmy9gFTpgA9
         rbNrOz3mi8m9giaMWdCkRs5pvSr7ewQy6Huj/2soaJotr27Ge9TY6mhnFuOFCvTmbY6M
         kavg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6rWuTdwIAioCQ0FaHL+KRRa/Mb7b3ZbPnuswryRkMnY=;
        b=R/A0ViRokRkWphaQiUEKsyKbh/KBUJsPhvjVc59m/7ZirnEeQrGJI3BvaeeRBpg5Ax
         Rd6SBmEDyUMv2VXjdMflFciX2irr+uRlkAqJ6WRUXXh6SXokv0dOmk7Y5dgBQwJR47Va
         c1x5rmKBdLobnRsuNdr4K0FTBXPyBpqbtv/SPdtMuPIR/6JGB56kneAAenuhdhHyE1w7
         EApO4Ul3YcJAZiMzWjDzZy766eLFsjVXeVn8NYzNmfp3YF5ew1jwT3YCFAff29HFZuXf
         YzoxW2YpXBR12sk6WWSlECsXONR0HzFToyB/lVGfvCqLqEbQb23l8ZgkO2XJAG/9f105
         pARg==
X-Gm-Message-State: AOAM5314OgOo2n6nAf7Zkc3xb8qDmCAgPMamlg8+4CaFwfMDSIkynH/j
        CCodwiwDSJ0GX9ZEuFXJNp69s5IXmmPDNTs5l/s=
X-Google-Smtp-Source: ABdhPJz3uAUZqcg+qPrLC4/yNyOazEewygBZyOOE+2fM8/gUoXWVoZHrO2AWIDPABEj8/ETcQf+QKCRslDOQqqNiJCg=
X-Received: by 2002:a05:6402:1d33:: with SMTP id dh19mr6923215edb.362.1616117544696;
 Thu, 18 Mar 2021 18:32:24 -0700 (PDT)
MIME-Version: 1.0
References: <20210316221921.1124955-1-harshadshirwadkar@gmail.com> <CAOQ4uxiD8WGLeSftqL6dOfz_kNp+YSE7qfXYG34Pea4j8G7CxA@mail.gmail.com>
In-Reply-To: <CAOQ4uxiD8WGLeSftqL6dOfz_kNp+YSE7qfXYG34Pea4j8G7CxA@mail.gmail.com>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Thu, 18 Mar 2021 18:32:13 -0700
Message-ID: <CAD+ocbzMv6SyUUZFnBE0gTnHf8yvMFfq6Dm9rdnLXoUrh7gYkg@mail.gmail.com>
Subject: Re: [PATCH] ext4: add rename whiteout support for fast commit
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     Ext4 <linux-ext4@vger.kernel.org>, Theodore Tso <tytso@mit.edu>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks for the review Amir.

Sure changing the subject makes sense.

Also, on further discussions on Ext4 conference call, we also thought
that with this patch, overlayfs customers would not benefit from fast
commits much if they call renames often. So, in order to really make
rename whiteout a fast commit compatible operation, we probably would
need to add support in fast commit to replay a char device creation
event (since whiteout object is a char device). That would imply, we
would need to do careful versioning and would need to burn an on-disk
feature flag.

An alternative to this would be to have a static whiteout object with
irrelevant nlink count and to have every rename point to that object
instead. Based on how we decide to implement that, at max only the
first rename operation would be fast commit incompatible since that's
when this object would get created. All the further operations would
be fast commit compatible. The big benefit of this approach is that
this way we don't have to add support for char device creation in fast
commit replay code and thus we don't have to worry about versioning.

So, I'm planning to work on that in the near future, but meanwhile we
can carry this patch so that at least we don't break rename whiteout
after fast commit replays.

Thanks,
Harshad

On Wed, Mar 17, 2021 at 2:33 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> On Wed, Mar 17, 2021 at 12:19 AM Harshad Shirwadkar
> <harshadshirwadkar@gmail.com> wrote:
> >
> > This patch adds rename whiteout support in fast commits. Note that the
>
> My only problem with this change is the subject.
> It sounds like rename whiteout was not possible and now support was added
> and it is now possible. This is not the case.
> The truth is that rename whiteout is supported but broken with fast commits.
> So the subject should reflect that this is a FIX commit, i.e.:
>
> "ext4: fix rename whiteout with fast commit"
>
> And patch should have a Fixes: tag with the commit that added fast commit
> support to rename.
>
> Otherwise, patch has stray newline but the rest looks pretty straightforward
> to me.
>
> Thanks,
> Amir.
