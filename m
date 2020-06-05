Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59C451F0386
	for <lists+linux-ext4@lfdr.de>; Sat,  6 Jun 2020 01:33:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgFEXd4 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Fri, 5 Jun 2020 19:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728370AbgFEXd4 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Fri, 5 Jun 2020 19:33:56 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2BA8C08C5C2
        for <linux-ext4@vger.kernel.org>; Fri,  5 Jun 2020 16:33:55 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s1so13761368ljo.0
        for <linux-ext4@vger.kernel.org>; Fri, 05 Jun 2020 16:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ClAVloF54JIqrc+m+0ATOT37Q30+IcoX9urgdaodTTM=;
        b=HenIB/3KEnX6g7OVHqu+kSDDosed1DGCBW9BlMitBhtXu1qUftlTh0ByQYgIxxzPaJ
         v1BjKRoudpt4MRAW4isZGAyfXDO8MooDq35/5ak4ac6HzntoEvXpzd5SVBQKA2dAjkgz
         VEzncixfstBUoWrWg53pxL1hUYFIG0E2zxjFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ClAVloF54JIqrc+m+0ATOT37Q30+IcoX9urgdaodTTM=;
        b=LznRSmXTFgUtrlxIrx+UoWAIKhFpwdvRDW5Da36lYFAbsVMEuU8+61cU4hq0/kMzF9
         GPwt6iRKjLQQvaipYnfx5eo75R8FbodGUC2mluqaIelTWfiZ3y9wzTdpUD45NjTtSjla
         zqjtqVXYaaGv/rQhzsedsseJFvR4v0lFHee8inquJPeY/KQMfWLqNdjiD4N8QYtrdlwE
         ABZ308tH24QLubE+GokdX+nzSpvYm2zaO2G04vsQAv11ZXLt5rkrTTV3xNtWYcjayv2s
         caHNFKjWQG7abQ8OikqWOD5t+36w471YJOAWpzB/h90sNbs4JC9AgsHLFNOGcOcRjGd4
         8OTw==
X-Gm-Message-State: AOAM531cwIcXZNnItf0fhpNiBvHbGiv/DyqE1csWAPhE6pLxRdP5G4I3
        3LvGDKeM3Wnb8A5D6go7wp44Gw49M+Y=
X-Google-Smtp-Source: ABdhPJyy14/8O5x/sck3RbkgAKk52Cvv+j9SKWuQXe7nb7OOpK2DvZQSEJMIAchCw4RpROsT8qeoUw==
X-Received: by 2002:a2e:9d8c:: with SMTP id c12mr5551110ljj.230.1591400033882;
        Fri, 05 Jun 2020 16:33:53 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id c4sm1292410lja.56.2020.06.05.16.33.52
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Jun 2020 16:33:52 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id b6so13784128ljj.1
        for <linux-ext4@vger.kernel.org>; Fri, 05 Jun 2020 16:33:52 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr5449089ljn.70.1591400031826;
 Fri, 05 Jun 2020 16:33:51 -0700 (PDT)
MIME-Version: 1.0
References: <2240660.1591289899@warthog.procyon.org.uk>
In-Reply-To: <2240660.1591289899@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 5 Jun 2020 16:33:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgsxbn2QamOL_xu0F8srnpmsAZ-k6eJMCFazAKOcJ4t9w@mail.gmail.com>
Message-ID: <CAHk-=wgsxbn2QamOL_xu0F8srnpmsAZ-k6eJMCFazAKOcJ4t9w@mail.gmail.com>
Subject: Re: [GIT PULL] afs: Improvements for v5.8
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-afs@lists.infradead.org,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Jun 4, 2020 at 9:58 AM David Howells <dhowells@redhat.com> wrote:
>
>  (4) Improve Ext4's time updating.  Konstantin Khlebnikov said "For now,
>      I've plugged this issue with try-lock in ext4 lazy time update.  This
>      solution is much better."

It would have been good to get acks on this from the ext4 people, but
I've merged this as-is (but it's still going through my sanity tests,
so if that triggers something it might get unpulled again).

                  Linus
