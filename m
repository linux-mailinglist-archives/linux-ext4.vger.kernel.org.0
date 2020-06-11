Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD8221F6D15
	for <lists+linux-ext4@lfdr.de>; Thu, 11 Jun 2020 20:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgFKSBJ (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 11 Jun 2020 14:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgFKSBG (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 11 Jun 2020 14:01:06 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D749C08C5C1
        for <linux-ext4@vger.kernel.org>; Thu, 11 Jun 2020 11:01:06 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id e4so8028325ljn.4
        for <linux-ext4@vger.kernel.org>; Thu, 11 Jun 2020 11:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BulRtyYimxYCM3JqpK8tF3IaJrXUR0A9VD3QaE4GUiU=;
        b=F+EXHlVbvkMTRVWWzv8ZcPEHGpfAID2Da8N5jJ9jwq/Sk5UFdV4BndnY890mbolBO3
         xJbuERV3mR0f+F5yKntH8xwiKR2kUGoUueLXNO5RnIgcO1PBh7DEHUydmD5yKAclq+vQ
         balMdqIjrUuK2NFsEurmgSTtX0E/N5pRMm69I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BulRtyYimxYCM3JqpK8tF3IaJrXUR0A9VD3QaE4GUiU=;
        b=FPpvmSWDRBa8b0AmBeJrBPw7xi4tYQzyyRtCdZSTJRkbOyjsXI3/mHZe7VoI9iSnBk
         uzAn9ymxwQ+jAgbaREKrLnYttJBw1s0/6E0eZgrAKprBoHF8Gd/5PyemsQ5cMFyJCBD4
         TUX600VfL365xehe6OlQiPFbgWncZcMWTr+nnUDz1mnMmjTjaQIoIUZHvaDisYCA0lct
         qnXnI89T0aJA93vnpzKca+vu2bloXZunRJI/xsGmbuI9l7MlS6OpGXOsptHhDZaOa+cl
         s3RUXx8Iz8TNnK5dKQEC0Liw8vk/K1M9sCogZ6O095LQyTc9fluvCAGStLenFeUCeBWb
         o6Vw==
X-Gm-Message-State: AOAM532RzQsydWV36yAJMAxAeJ2ya555EnD3Lk7uEZuz1TIBhRrqJz1o
        bZjpcbIacvZONr+ziBgKIjPFc/POPtY=
X-Google-Smtp-Source: ABdhPJxxB1bYxzl6ezZr+y/7dtd3K0BjAWVUCCrGc+GBzDIWsdFWp8RaEBJ77zfwYrs64TDz/BCVXw==
X-Received: by 2002:a05:651c:484:: with SMTP id s4mr4552411ljc.381.1591898462198;
        Thu, 11 Jun 2020 11:01:02 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id z2sm1287459lfg.45.2020.06.11.11.01.00
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 11:01:00 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id x18so8004086lji.1
        for <linux-ext4@vger.kernel.org>; Thu, 11 Jun 2020 11:01:00 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr4854187ljk.314.1591898459839;
 Thu, 11 Jun 2020 11:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200611024248.GG11245@magnolia>
In-Reply-To: <20200611024248.GG11245@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Jun 2020 11:00:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTMxCAHVgtKkbSJt=1pBm+86bz=RbZiZE-2sszwmcKvQ@mail.gmail.com>
Message-ID: <CAHk-=wgTMxCAHVgtKkbSJt=1pBm+86bz=RbZiZE-2sszwmcKvQ@mail.gmail.com>
Subject: Re: [GIT PULL] vfs: improve DAX behavior for 5.8, part 3
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Jun 10, 2020 at 7:43 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> I did a test merge of this branch against upstream this evening and
> there weren't any conflicts.  The first five patches in the series were
> already in the xfs merge, so it's only the last one that should change
> anything.  Please let us know if you have any complaints about pulling
> this, since I can rework the branch.

I've taken this, but I hate how the patches apparently got duplicated.
It feels like they should have been a cleanly separated branch that
was just pulled into whoever needed them when they were ready, rather
than applied in two different places.

So this is just a note for future work - duplicating the patches like
this can cause annoyances down the line. No merge issues this time
(they often happen when duplicate patches then have other work done on
top of them), but things like "git bisect" now don't have quite as
black-and-white a situation etc etc.,

("git bisect" will still find _one_ of the duplicate commits if it
introduced a problem, so it's usually not a huge deal, but it can
cause the bug to be then repeated if people revert that one, but
nobody ever notices that the other commit that did the same thing is
still around and it gets back-ported to stable or whatever..)

So part of this is just in general about confusing duplicate history,
and part of it is that the duplication can then cause later confusion.

                Linus
