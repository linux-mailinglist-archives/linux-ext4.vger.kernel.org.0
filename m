Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93BB72CC40D
	for <lists+linux-ext4@lfdr.de>; Wed,  2 Dec 2020 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730809AbgLBRmp (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 2 Dec 2020 12:42:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726619AbgLBRmo (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 2 Dec 2020 12:42:44 -0500
Received: from mail-vk1-xa41.google.com (mail-vk1-xa41.google.com [IPv6:2607:f8b0:4864:20::a41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3621C0613D6
        for <linux-ext4@vger.kernel.org>; Wed,  2 Dec 2020 09:42:04 -0800 (PST)
Received: by mail-vk1-xa41.google.com with SMTP id j142so585618vkj.9
        for <linux-ext4@vger.kernel.org>; Wed, 02 Dec 2020 09:42:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1x85fibtNgk8eCqEQNDAdM4H9CAeQh2Tw033sLE9au0=;
        b=k17fYGcwuvMZ1Z8sW8ED5NcNXVNtT2pFk45+2PoxoQU8LXfOr6AYnwMnP48duoDTOX
         KkETXo8kz86TN9x3hgA72/j3TAPJcyMySF/dKg3fqDLhxHHqn0b6mMjJvCX9YFgXcZSE
         meXC9GzKinsBSDUgRWYmV1DBRcJbE7gisVkLs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1x85fibtNgk8eCqEQNDAdM4H9CAeQh2Tw033sLE9au0=;
        b=SHB5JoEZOtUWg/LmonBC8K0XrxdxmhTfaHvRuc0NYwzIrk9OL2KHL2Gt8jJmTaSojm
         /uqJzWj4HoHixD+M9AXWIGcER3gwEuubQA3YMljgx9Fvx4PrwwUvXKHafdtaW9SCcpeO
         IP0FWds46lW/QdYIyrQIMxlH4W39ExlBprRdDFNRZd1eRyqYOLVSjexFBmgKx5kS+DTw
         aj3te4WoI+Rq3Y+eDCZYq1Es9VeHnj9uogg2eZ2uNltpsaaq5tfy16qicuAeHm995fB6
         EBJN1xlDE+Wt8LHZ4SH2diu3CqptaKTN1HFRE8GqYwgnQ54wsvKkiHg3ECmw+Yrxr4JS
         LSWw==
X-Gm-Message-State: AOAM5324CrvH/3NQ1ZgYJoE3LLX6wCS7IKRpKZvrbUOIPOHUBADDnlF1
        6pG+j06izDOSo28Uf00c1F+8i25Uqrb/mnM2cpYsTw==
X-Google-Smtp-Source: ABdhPJwTheLKPeYlIrrssTfR1rpgEOPwTCjeb+0/mDlt+DYvNW/fgwgzHLBBS7di/GI9wgwe9tiBOAwzgf9hYJ07zfU=
X-Received: by 2002:a1f:b245:: with SMTP id b66mr2625951vkf.3.1606930923918;
 Wed, 02 Dec 2020 09:42:03 -0800 (PST)
MIME-Version: 1.0
References: <3e28d2c7-fbe5-298a-13ba-dcd8fd504666@redhat.com>
 <20201202160049.GD1447340@iweiny-DESK2.sc.intel.com> <CAJfpegt6w4h28VLctpaH46r2pkbcUNJ4pUhwUqZ-zbrOrXPEEQ@mail.gmail.com>
 <641397.1606926232@warthog.procyon.org.uk>
In-Reply-To: <641397.1606926232@warthog.procyon.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Wed, 2 Dec 2020 18:41:43 +0100
Message-ID: <CAJfpegsQxi+_ttNshHu5MP+uLn3px9+nZRoTLTxh9-xwU8s1yg@mail.gmail.com>
Subject: Re: [PATCH V2] uapi: fix statx attribute value overlap for DAX & MOUNT_ROOT
To:     David Howells <dhowells@redhat.com>
Cc:     Ira Weiny <ira.weiny@intel.com>, Eric Sandeen <sandeen@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        linux-fsdevel@vger.kernel.org,
        linux-man <linux-man@vger.kernel.org>,
        linux-kernel@vger.kernel.org, xfs <linux-xfs@vger.kernel.org>,
        linux-ext4@vger.kernel.org, Xiaoli Feng <xifeng@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Wed, Dec 2, 2020 at 5:24 PM David Howells <dhowells@redhat.com> wrote:
>
> Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Stable cc also?
> >
> > Cc: <stable@vger.kernel.org> # 5.8
>
> That seems to be unnecessary, provided there's a Fixes: tag.

Is it?

Fixes: means it fixes a patch, Cc: stable means it needs to be
included in stable kernels.  The two are not necessarily the same.

Greg?

Thanks,
Miklos
