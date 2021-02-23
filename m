Return-Path: <linux-ext4-owner@vger.kernel.org>
X-Original-To: lists+linux-ext4@lfdr.de
Delivered-To: lists+linux-ext4@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5101A322FC3
	for <lists+linux-ext4@lfdr.de>; Tue, 23 Feb 2021 18:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233668AbhBWRl7 (ORCPT <rfc822;lists+linux-ext4@lfdr.de>);
        Tue, 23 Feb 2021 12:41:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233647AbhBWRl6 (ORCPT
        <rfc822;linux-ext4@vger.kernel.org>); Tue, 23 Feb 2021 12:41:58 -0500
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE635C06174A
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:41:17 -0800 (PST)
Received: by mail-ej1-x634.google.com with SMTP id k13so33979435ejs.10
        for <linux-ext4@vger.kernel.org>; Tue, 23 Feb 2021 09:41:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8N8//LW61kaV1lCJVHANDmFwIO/PEzKZzZOWWf6T27A=;
        b=QNi0/QuYyf6nv8kN/KThAKeJ7yMvXp1YkdmbYvTwYZtZQPGeiUUeMFwNk5Ec+WA2mU
         See4s/AsMnhWPE4fUW3Vt3/eFG+ODapomOkedwGoO0flE1+7CNDUNoXFWkDLtqI1THl/
         7bUET6K6nU6GoeDWYCtFPbdycZVUd+ak/S9lC/PM+Fv1AEv8oHXHQevJPPKM78XBb1UG
         LI5VpEibKV5zLJz76VuIKK91VtARF/o54D36DIdTDecapmZWTNadwHPJlEdUfI3OQ8vN
         nbSJZ+BBim6wCEljUmjr5Xz75s8gP6XajQZp4NsFVNWfhxiquWUOAHEV6y8HViFcK4rx
         Q8jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8N8//LW61kaV1lCJVHANDmFwIO/PEzKZzZOWWf6T27A=;
        b=r8NwExmaxYREMblsbEHsPc2BV5d66mWeJwcAio0pwfE0QZY5egEb1ATQzG3sxJhO0X
         /QRYwtRJsv4OWcHeXaH8yebTe7h+GKz3uxRBZw2QIq1acsgHLs6sSqAJTw3uqDKpFnSQ
         R4iDIhO1+dZP/Y+GeUd8uC/uYJAyHK8f500O5mdw3EZxbvpWe4vr71doVw3JdSxnWalU
         tiMsLP8wjz5y4/O8QWFMhyx941uRaQF2BY1eE+qMUVqrlLUIuMcJkKq34GVBL3WoEwzn
         csXBMzez3mtqpBbNF0Uo//Kls+KZDiI6K0KdbP5o/TX5bqJoAtDliuUjHT1nbh19Iqmu
         +klQ==
X-Gm-Message-State: AOAM533gZa+XOm6k6+YbBqAXdn0KHB5fyEJnYo+f7K+ZOCX3ZjpdXdsT
        REkk8nbPfCkKLJrQxP7dRF1SxCkm3CwQo7qL3nH28Ls6uac=
X-Google-Smtp-Source: ABdhPJyQPed/88oS3OpA68rjvJZ8FbWZ4lohA5egLXXWKHBvBSqDrHgLW3UX1Y4o8YAUEaXt9R8o2cSE2LlIPClm0Ow=
X-Received: by 2002:a17:906:c210:: with SMTP id d16mr23166137ejz.187.1614102076571;
 Tue, 23 Feb 2021 09:41:16 -0800 (PST)
MIME-Version: 1.0
References: <20210219210333.1439525-1-harshads@google.com> <20210219210333.1439525-4-harshads@google.com>
 <YDLpPr/DD/sSRuES@mit.edu>
In-Reply-To: <YDLpPr/DD/sSRuES@mit.edu>
From:   harshad shirwadkar <harshadshirwadkar@gmail.com>
Date:   Tue, 23 Feb 2021 09:41:05 -0800
Message-ID: <CAD+ocbwro-Zu9O60QQFTZ2CvQtdyZN19_X3bghFyxJS=hChStg@mail.gmail.com>
Subject: Re: [PATCH 4/4] e2fsck: initialize variable before first use in fast
 commit replay
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Ext4 Developers List <linux-ext4@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-ext4.vger.kernel.org>
X-Mailing-List: linux-ext4@vger.kernel.org

Thanks Ted, it makes sense, will fix this in V2.

- Harshad

On Sun, Feb 21, 2021 at 3:14 PM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Fri, Feb 19, 2021 at 01:03:33PM -0800, Harshad Shirwadkar wrote:
> > From: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
> >
> > Initialize ext2fs_ex variable in ext4_fc_replay_scan() before first
> > use.
> >
> > Signed-off-by: Harshad Shirwadkar <harshadshirwadkar@gmail.com>
>
> I wonder if we should make the following change to
> ext2fs_decode_extent(), which will prevent other future bugs to
> potential users of the function:
>
>         to->e_pblk = ext2fs_le32_to_cpu(from->ee_start) +
>                 ((__u64) ext2fs_le16_to_cpu(from->ee_start_hi)
>                         << 32);
>         to->e_lblk = ext2fs_le32_to_cpu(from->ee_block);
>         to->e_len = ext2fs_le16_to_cpu(from->ee_len);
> -       to->e_flags |= EXT2_EXTENT_FLAGS_LEAF;
> +       to->e_flags = EXT2_EXTENT_FLAGS_LEAF;
>
> ext2fs_decode_extent() overwrites all other members of the structure,
> so we might as well just initialize e_flags as opposed to depending
> the caller to initiaize *to just for the sake of to->e_flags.
>
> Cheers,
>
>                                         - Ted
