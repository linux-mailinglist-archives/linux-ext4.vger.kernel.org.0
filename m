Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25B5170B8C
	for <lists+linux-ext4@lfdr.de>; Mon, 22 Jul 2019 23:36:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731485AbfGVVgV (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Mon, 22 Jul 2019 17:36:21 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:34296 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729004AbfGVVgV (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Mon, 22 Jul 2019 17:36:21 -0400
Received: by mail-ot1-f66.google.com with SMTP id n5so41893052otk.1
        for <linux-ext4@vger.kernel.org>; Mon, 22 Jul 2019 14:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0fnAC+hpKzv5K33pyU8Rxj2HoQCvZ/kzGIX8Aqi7OmI=;
        b=dxWkI0wAtlnszJHDdj62XhMIfbKqZhjR1f3iuU+R8nsndWeKgdGrbKUakeZ1V5tQyH
         RXENZalzUVzItfBOmy59zDysLAe7CZXyhK/flBB8ILzWYLTAU1pETqvatvcZD/VlmPvE
         dTRng397wpXnrFaT5vXABlPZwFzqyyrvtWiEYI1vppqGn9iLNhGrvy5OPeMFaHKFEecx
         L7YNnAHztD3b2qkU+nWnR6VcWsG/8t/bDcbRo0/X3xXbA1jEt4LDFw8bqhwrhxurWWLr
         QyrbRlP6jhXbxf6FBovxun6XnPJ8oVYUjjZvl5HL0zmpO3jep/ZwL8ZDGbshHmNkkNzU
         8qIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0fnAC+hpKzv5K33pyU8Rxj2HoQCvZ/kzGIX8Aqi7OmI=;
        b=CN2E1REVLTMG12qCV3zGYe33w4fhzGUL00xHRhObtL1g+dv5jE7NWLJdG6kySg8/g4
         oj7qJ1Bs3m3i3JQF9ZziLsW+42uoxQh5Vgl7s+Zx92tWPjEXnQE0qVG9osGX/btAaaij
         LpDCfZ8BP3B8SVP5/1/5Ix52CMdvnAN8oSQDdRXw8qeLshgVV4f7rSjtCUzdqCg0zovn
         KHLQhwsNjL/4kGtXjRIE72Yq5hCat5Oqv26nt1VH7NPKMIevQzNmpFkbL/bF/fjOhsIW
         fv3o1FaMBXoxMoZMxPLzGP3ZyVaE37NR0N3obJ/OMBJNsKYKZxdVCOr+XnYc2j3TsRJV
         DYbw==
X-Gm-Message-State: APjAAAVv/fQfZr6s76vG1pZtHySu0CUp1HMwfbDPU1IKiLuEXHtDfzec
        dNm5yQ1M3ARa0pPmnWHIPORMK0C0WU1xMc/Fdrk=
X-Google-Smtp-Source: APXvYqxyHZqYOmJC0BoAzBfdNa2xpmb8cUlbvm/X3kzFaSlPszn2UmX51MDdkdICwcTqp7rIGdp46BcVAYMZp3gs0WY=
X-Received: by 2002:a9d:7d82:: with SMTP id j2mr43177420otn.171.1563831380033;
 Mon, 22 Jul 2019 14:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190722040011.18892-1-harshadshirwadkar@gmail.com>
 <41522E01-D5E5-4DC6-8AD4-09E3FA19F112@dilger.ca> <20190722210235.GE16313@mit.edu>
In-Reply-To: <20190722210235.GE16313@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Mon, 22 Jul 2019 14:36:09 -0700
Message-ID: <CAD+ocbyG6_GK-SMotXgm7OmBLmjiRPWMHH0oryYS=gQ7fbPBxA@mail.gmail.com>
Subject: Re: [PATCH 01/11] ext4: add handling for extended mount options
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
Cc:     Andreas Dilger <adilger@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Andreas. Thanks Ted for sharing the original paper link. I'll
submit a patch 00/11 with proposed documentation and cover letter
describing the feature and results from benchmarks.


On Mon, Jul 22, 2019 at 2:02 PM Theodore Y. Ts'o <tytso@mit.edu> wrote:
>
> On Mon, Jul 22, 2019 at 12:15:11PM -0600, Andreas Dilger wrote:
> > Unless I missed it, this patch series needs a 00/11 email that describes
> > *what* "fast commit" is, and why we want it.  This should include some
> > benchmark results, since (I'd assume) that the "fast" part of the feature
> > name implies a performance improvement?
>
> For background, it's a simplified version of the scheme proposed by
> Park and Shin, in their paper, "iJournaling: Fine-Grained Journaling
> for Improving the Latency of Fsync System Call"[1]
>
> [1] https://www.usenix.org/conference/atc17/technical-sessions/presentation/park
>
> I agree we should have a cover letter for this patch series.  Also, we
> should add documentation to Documentation/filesystems/journaling.rst
> about this feature; what it does, how it works, its basic on-disk
> format changes, etc.
>
> The fs/jbd2 layer isn't as well documented as the fs/ext4 code, and
> bringing Documentation/filesystems/journaling.rst to the same level as
> Documentation/filesystems/ext4/* isn't a fair/reasonable request.  On
> the other hand, documenting what is being added by this patch series
> is something that I think we should do.
>
>                                     - Ted
