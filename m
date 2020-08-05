Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6373723D26F
	for <lists+linux-ext4@lfdr.de>; Wed,  5 Aug 2020 22:13:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726971AbgHEUMs (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Wed, 5 Aug 2020 16:12:48 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50008 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726709AbgHEQZe (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Wed, 5 Aug 2020 12:25:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596644702;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RDiNTwaajX9EstP2+rkOoaOqP4Sp0ty/xDldPk1nRuY=;
        b=ZLdpXk/HNS+AUi3ROo21rtg5Qv/XEfMrWtwgHBP6n1uUNof4vHLTDb87x3rxT0koc07SI1
        KTy/QnlzYkehHheLsKET1MfkI4cCZ3DuAAVbypP255ovHcsjVT2UagoKVgj5mgELRtEPhL
        jo0xtTQdhi26UO7nuMhsfxoSWEsvsFk=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-12-XtUf4EMiOraEThPWwmhAww-1; Wed, 05 Aug 2020 11:54:43 -0400
X-MC-Unique: XtUf4EMiOraEThPWwmhAww-1
Received: by mail-oi1-f197.google.com with SMTP id t83so12869748oih.18
        for <linux-ext4@vger.kernel.org>; Wed, 05 Aug 2020 08:54:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RDiNTwaajX9EstP2+rkOoaOqP4Sp0ty/xDldPk1nRuY=;
        b=M/G4XG2MrOY1nGgl4B9gzDRvmVnylRBf7tA3ZrInvmGXFVa1PIZDsz9Aip8LyC3R6y
         WXDLyO8kK0Q39i2HzaPrYBcIrAhCS6dmPi5AJqHdU+6z2IaZwWOWSR6lJgNeW8OcBtK0
         JGh1dbp9wQMgOHeKtIJkNeqRqqIzI1W0KCmSbKfeY5+V/UYtWP6OSvwQJvJBAw3k0ZKU
         L0pUlOc0DMAlyKR7UeDX6p4ZsxMKVxYxUqxrlKN4cZYfQg+PazOQ1HtPZuB1FTKnaPQo
         PHwVvtha8uEXiNLK7q1xO+xdsGZ1UycO/VRf3c88K+/J0zAAITODwc+pK8nO7qalwyTZ
         mp+Q==
X-Gm-Message-State: AOAM5309Hz182efEzoFZU0RtTrdIMTgsyvlR/o96mZ9hNlF4dvj680Il
        SttexaN+eHhLadkygybGLx4s8uIVPxTAfYAKkKzqliI/mNHkyjSbmzu2syiE58rlVc5ctfNilxS
        H8weG07tqUgeBAtKK7fuC6vyLt4QbQqGGsMs/xw==
X-Received: by 2002:a9d:3784:: with SMTP id x4mr3040061otb.95.1596642882737;
        Wed, 05 Aug 2020 08:54:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFNuf696slwlPSZJynKjLvYPlN0RCiKIOzOVmS4vUbpxiRMAJuurwOtGRZDzCz52Sm2DXwT3decGCiphYpc3o=
X-Received: by 2002:a9d:3784:: with SMTP id x4mr3040047otb.95.1596642882501;
 Wed, 05 Aug 2020 08:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20200805153214.GA6090@magnolia>
In-Reply-To: <20200805153214.GA6090@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Wed, 5 Aug 2020 17:54:31 +0200
Message-ID: <CAHc6FU6yMnuKdVsAXkWgwr2ViMSXJdBXksrQDvHwaaw4p8u0rQ@mail.gmail.com>
Subject: Re: [GIT PULL] iomap: new code for 5.9-rc1
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs@vger.kernel.org, Dave Chinner <david@fromorbit.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, riteshh@linux.ibm.com,
        Goldwyn Rodrigues <rgoldwyn@suse.de>,
        linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-ext4-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Hi Darrick,

On Wed, Aug 5, 2020 at 5:40 PM Darrick J. Wong <djwong@kernel.org> wrote:
> ----------------------------------------------------------------
> Andreas Gruenbacher (1):
>       iomap: Make sure iomap_end is called after iomap_begin

that commit (d1b4f507d71de) contains the following garbage in the
commit message:

    The message from this sender included one or more files
    which could not be scanned for virus detection; do not
    open these files unless you are certain of the sender's intent.

    ----------------------------------------------------------------------

How did it come to that?

Thanks,
Andreas

