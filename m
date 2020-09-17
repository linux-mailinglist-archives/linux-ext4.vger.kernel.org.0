Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1E226E5ED
	for <lists+linux-ext4@lfdr.de>; Thu, 17 Sep 2020 21:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726480AbgIQT6Y (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Thu, 17 Sep 2020 15:58:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726457AbgIQT57 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Thu, 17 Sep 2020 15:57:59 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4269C061224
        for <linux-ext4@vger.kernel.org>; Thu, 17 Sep 2020 12:47:36 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y2so3478821lfy.10
        for <linux-ext4@vger.kernel.org>; Thu, 17 Sep 2020 12:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qwB5yamo/VQg9lGW1D6zAt8KwlMkbf+/RiRqSyfA74s=;
        b=hHGYORd3WT/upNR5+53j3xigCR+oA1RiSdZA/E4QxMevzXDwYfmnVsbMBtuzpjYDqs
         SJuNY7erG1NyJuWM+SXV+V0yVUnm8MKV+IbcdX0/iaj4iAM8utlAB/fq3BI5UlzERQhR
         Wy3RP+/XFCSTW3CViq8mrFjvl+YoOtxmAsQmY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qwB5yamo/VQg9lGW1D6zAt8KwlMkbf+/RiRqSyfA74s=;
        b=iQEF+pbWnT4osYk+GNfahcuRmnMD14B2Ds9DA91T+YbCV73wEZ4Kb0sxnqDYhawyeB
         HjoOUpSx4Apq+COHYVBaqgHIamsoIvINByE/MaoUcnsl1S9/MW2ri2KS0DdoZVlAU8kQ
         RmrwbdBsXljaF+xpNZnnqawyhqLOg083xq5+Ep6e01Om3rp7Artow9HAWxcqAhl9gPAo
         kbiPC6clUI3Enlcfp/VPNiZsTQvUuF1fCxv6Fbp0/AizOVnfjUC/FfwCxxHl2ng9fMzv
         d1ZZcYdY0RdEohm0sGdbi6FfsQ4WzJsFPKgPm5mGW+JHp7mvzRO8ZicpWzEk1VLhACWA
         hDDQ==
X-Gm-Message-State: AOAM530I570qIZY82N7QIwAFblkYzOZTNcku0nEfEx0S/+4vS/l7h3i3
        r50Mij0/68HCPpfqZ0UojPIJ9pp9gp1M4g==
X-Google-Smtp-Source: ABdhPJwHbNF/FRKpvhlBxYpu/1wyS8o4SEQqbt+kLnOT3SWs1othWIoeHRK00RX2SvxM5sxWcGfC0g==
X-Received: by 2002:a19:5e0f:: with SMTP id s15mr9651040lfb.141.1600372054635;
        Thu, 17 Sep 2020 12:47:34 -0700 (PDT)
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com. [209.85.208.179])
        by smtp.gmail.com with ESMTPSA id n21sm105804ljc.89.2020.09.17.12.47.33
        for <linux-ext4@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Sep 2020 12:47:33 -0700 (PDT)
Received: by mail-lj1-f179.google.com with SMTP id u21so3071437ljl.6
        for <linux-ext4@vger.kernel.org>; Thu, 17 Sep 2020 12:47:33 -0700 (PDT)
X-Received: by 2002:a2e:994a:: with SMTP id r10mr8323841ljj.102.1600372052998;
 Thu, 17 Sep 2020 12:47:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxhz8prfD5K7dU68yHdz=iBndCXTg5w4BrF-35B+4ziOwA@mail.gmail.com>
 <0daf6ae6-422c-dd46-f85a-e83f6e1d1113@MichaelLarabel.com> <20200912143704.GB6583@casper.infradead.org>
 <658ae026-32d9-0a25-5a59-9c510d6898d5@MichaelLarabel.com> <CAHk-=wip0bCNnFK2Sxdn-YCTdKBF2JjF0kcM5mXbRuKKp3zojw@mail.gmail.com>
 <CAHk-=whc5CnTUWoeeCDj640Rng4nH8HdLsHgEdnz3NtPSRqqhQ@mail.gmail.com>
 <20200917182314.GU5449@casper.infradead.org> <CAHk-=wj6g2y2Z3cGzHBMoeLx-mfG0Md_2wMVwx=+g_e-xDNTbw@mail.gmail.com>
 <20200917185049.GV5449@casper.infradead.org> <CAHk-=wj6Ha=cNU4kL3z661CV+c2x2=DKzPrfH=XujMa378NhWQ@mail.gmail.com>
 <20200917192707.GW5449@casper.infradead.org>
In-Reply-To: <20200917192707.GW5449@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 17 Sep 2020 12:47:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
Message-ID: <CAHk-=wjp+KiZE2EM=f8Z1J_wmZSoq0MVZTJi=bMSXmfZ7Gx76w@mail.gmail.com>
Subject: Re: Kernel Benchmarking
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Michael Larabel <Michael@michaellarabel.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        Amir Goldstein <amir73il@gmail.com>,
        "Ted Ts'o" <tytso@google.com>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

On Thu, Sep 17, 2020 at 12:27 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Ah, I see what you mean.  Hold the i_mmap_rwsem for write across,
> basically, the entirety of truncate_inode_pages_range().

I really suspect that will be entirely unacceptable for latency
reasons, but who knows. In practice, nobody actually truncates a file
_while_ it's mapped, that's just crazy talk.

But almost every time I go "nobody actually does this", I tend to be
surprised by just how crazy some loads are, and it turns out that
_somebody_ does it, and has a really good reason for doing odd things,
and has been doing it for years because it worked really well and
solved some odd problem.

So the "hold it for the entirety of truncate_inode_pages_range()"
thing seems to be a really simple approach, and nice and clean, but it
makes me go "*somebody* is going to do bad things and complain about
page fault latencies".

              Linus
